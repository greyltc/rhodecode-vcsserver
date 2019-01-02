# RhodeCode VCSServer provides access to different vcs backends via network.
# Copyright (C) 2014-2019 RhodeCode GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

import os
import logging
import itertools

import mercurial
import mercurial.error
import mercurial.wireprotoserver
import mercurial.hgweb.common
import mercurial.hgweb.hgweb_mod
import webob.exc

from vcsserver import pygrack, exceptions, settings, git_lfs


log = logging.getLogger(__name__)


# propagated from mercurial documentation
HG_UI_SECTIONS = [
    'alias', 'auth', 'decode/encode', 'defaults', 'diff', 'email', 'extensions',
    'format', 'merge-patterns', 'merge-tools', 'hooks', 'http_proxy', 'smtp',
    'patch', 'paths', 'profiling', 'server', 'trusted', 'ui', 'web',
]


class HgWeb(mercurial.hgweb.hgweb_mod.hgweb):
    """Extension of hgweb that simplifies some functions."""

    def _get_view(self, repo):
        """Views are not supported."""
        return repo

    def loadsubweb(self):
        """The result is only used in the templater method which is not used."""
        return None

    def run(self):
        """Unused function so raise an exception if accidentally called."""
        raise NotImplementedError

    def templater(self, req):
        """Function used in an unreachable code path.

        This code is unreachable because we guarantee that the HTTP request,
        corresponds to a Mercurial command. See the is_hg method. So, we are
        never going to get a user-visible url.
        """
        raise NotImplementedError

    def archivelist(self, nodeid):
        """Unused function so raise an exception if accidentally called."""
        raise NotImplementedError

    def __call__(self, environ, start_response):
        """Run the WSGI application.

        This may be called by multiple threads.
        """
        from mercurial.hgweb import request as requestmod
        req = requestmod.parserequestfromenv(environ)
        res = requestmod.wsgiresponse(req, start_response)
        gen = self.run_wsgi(req, res)

        first_chunk = None

        try:
            data = gen.next()

            def first_chunk():
                yield data
        except StopIteration:
            pass

        if first_chunk:
            return itertools.chain(first_chunk(), gen)
        return gen

    def _runwsgi(self, req, res, repo):

        cmd = req.qsparams.get('cmd', '')
        if not mercurial.wireprotoserver.iscmd(cmd):
            # NOTE(marcink): for unsupported commands, we return bad request
            # internally from HG
            from mercurial.hgweb.common import statusmessage
            res.status = statusmessage(mercurial.hgweb.common.HTTP_BAD_REQUEST)
            res.setbodybytes('')
            return res.sendresponse()

        return super(HgWeb, self)._runwsgi(req, res, repo)


def make_hg_ui_from_config(repo_config):
    baseui = mercurial.ui.ui()

    # clean the baseui object
    baseui._ocfg = mercurial.config.config()
    baseui._ucfg = mercurial.config.config()
    baseui._tcfg = mercurial.config.config()

    for section, option, value in repo_config:
        baseui.setconfig(section, option, value)

    # make our hgweb quiet so it doesn't print output
    baseui.setconfig('ui', 'quiet', 'true')

    return baseui


def update_hg_ui_from_hgrc(baseui, repo_path):
    path = os.path.join(repo_path, '.hg', 'hgrc')

    if not os.path.isfile(path):
        log.debug('hgrc file is not present at %s, skipping...', path)
        return
    log.debug('reading hgrc from %s', path)
    cfg = mercurial.config.config()
    cfg.read(path)
    for section in HG_UI_SECTIONS:
        for k, v in cfg.items(section):
            log.debug('settings ui from file: [%s] %s=%s', section, k, v)
            baseui.setconfig(section, k, v)


def create_hg_wsgi_app(repo_path, repo_name, config):
    """
    Prepares a WSGI application to handle Mercurial requests.

    :param config: is a list of 3-item tuples representing a ConfigObject
        (it is the serialized version of the config object).
    """
    log.debug("Creating Mercurial WSGI application")

    baseui = make_hg_ui_from_config(config)
    update_hg_ui_from_hgrc(baseui, repo_path)

    try:
        return HgWeb(repo_path, name=repo_name, baseui=baseui)
    except mercurial.error.RequirementError as e:
        raise exceptions.RequirementException(e)(e)


class GitHandler(object):
    """
    Handler for Git operations like push/pull etc
    """
    def __init__(self, repo_location, repo_name, git_path, update_server_info,
                 extras):
        if not os.path.isdir(repo_location):
            raise OSError(repo_location)
        self.content_path = repo_location
        self.repo_name = repo_name
        self.repo_location = repo_location
        self.extras = extras
        self.git_path = git_path
        self.update_server_info = update_server_info

    def __call__(self, environ, start_response):
        app = webob.exc.HTTPNotFound()
        candidate_paths = (
            self.content_path, os.path.join(self.content_path, '.git'))

        for content_path in candidate_paths:
            try:
                app = pygrack.GitRepository(
                    self.repo_name, content_path, self.git_path,
                    self.update_server_info, self.extras)
                break
            except OSError:
                continue

        return app(environ, start_response)


def create_git_wsgi_app(repo_path, repo_name, config):
    """
    Creates a WSGI application to handle Git requests.

    :param config: is a dictionary holding the extras.
    """
    git_path = settings.GIT_EXECUTABLE
    update_server_info = config.pop('git_update_server_info')
    app = GitHandler(
        repo_path, repo_name, git_path, update_server_info, config)

    return app


class GitLFSHandler(object):
    """
    Handler for Git LFS operations
    """

    def __init__(self, repo_location, repo_name, git_path, update_server_info,
                 extras):
        if not os.path.isdir(repo_location):
            raise OSError(repo_location)
        self.content_path = repo_location
        self.repo_name = repo_name
        self.repo_location = repo_location
        self.extras = extras
        self.git_path = git_path
        self.update_server_info = update_server_info

    def get_app(self, git_lfs_enabled, git_lfs_store_path):
        app = git_lfs.create_app(git_lfs_enabled, git_lfs_store_path)
        return app


def create_git_lfs_wsgi_app(repo_path, repo_name, config):
    git_path = settings.GIT_EXECUTABLE
    update_server_info = config.pop('git_update_server_info')
    git_lfs_enabled = config.pop('git_lfs_enabled')
    git_lfs_store_path = config.pop('git_lfs_store_path')
    app = GitLFSHandler(
        repo_path, repo_name, git_path, update_server_info, config)

    return app.get_app(git_lfs_enabled, git_lfs_store_path)
