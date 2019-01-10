# -*- coding: utf-8 -*-

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

import re
import os
import sys
import datetime
import logging
import pkg_resources

import vcsserver

log = logging.getLogger(__name__)


def get_git_hooks_path(repo_path, bare):
    hooks_path = os.path.join(repo_path, 'hooks')
    if not bare:
        hooks_path = os.path.join(repo_path, '.git', 'hooks')

    return hooks_path


def install_git_hooks(repo_path, bare, executable=None, force_create=False):
    """
    Creates a RhodeCode hook inside a git repository

    :param repo_path: path to repository
    :param executable: binary executable to put in the hooks
    :param force_create: Create even if same name hook exists
    """
    executable = executable or sys.executable
    hooks_path = get_git_hooks_path(repo_path, bare)

    if not os.path.isdir(hooks_path):
        os.makedirs(hooks_path, mode=0o777)

    tmpl_post = pkg_resources.resource_string(
        'vcsserver', '/'.join(
            ('hook_utils', 'hook_templates', 'git_post_receive.py.tmpl')))
    tmpl_pre = pkg_resources.resource_string(
        'vcsserver', '/'.join(
            ('hook_utils', 'hook_templates', 'git_pre_receive.py.tmpl')))

    path = ''  # not used for now
    timestamp = datetime.datetime.utcnow().isoformat()

    for h_type, template in [('pre', tmpl_pre), ('post', tmpl_post)]:
        log.debug('Installing git hook in repo %s', repo_path)
        _hook_file = os.path.join(hooks_path, '%s-receive' % h_type)
        _rhodecode_hook = check_rhodecode_hook(_hook_file)

        if _rhodecode_hook or force_create:
            log.debug('writing git %s hook file at %s !', h_type, _hook_file)
            try:
                with open(_hook_file, 'wb') as f:
                    template = template.replace(
                        '_TMPL_', vcsserver.__version__)
                    template = template.replace('_DATE_', timestamp)
                    template = template.replace('_ENV_', executable)
                    template = template.replace('_PATH_', path)
                    f.write(template)
                os.chmod(_hook_file, 0o755)
            except IOError:
                log.exception('error writing hook file %s', _hook_file)
        else:
            log.debug('skipping writing hook file')

    return True


def get_svn_hooks_path(repo_path):
    hooks_path = os.path.join(repo_path, 'hooks')

    return hooks_path


def install_svn_hooks(repo_path, executable=None, force_create=False):
    """
    Creates RhodeCode hooks inside a svn repository

    :param repo_path: path to repository
    :param executable: binary executable to put in the hooks
    :param force_create: Create even if same name hook exists
    """
    executable = executable or sys.executable
    hooks_path = get_svn_hooks_path(repo_path)
    if not os.path.isdir(hooks_path):
        os.makedirs(hooks_path, mode=0o777)

    tmpl_post = pkg_resources.resource_string(
        'vcsserver', '/'.join(
            ('hook_utils', 'hook_templates', 'svn_post_commit_hook.py.tmpl')))
    tmpl_pre = pkg_resources.resource_string(
        'vcsserver', '/'.join(
            ('hook_utils', 'hook_templates', 'svn_pre_commit_hook.py.tmpl')))

    path = ''  # not used for now
    timestamp = datetime.datetime.utcnow().isoformat()

    for h_type, template in [('pre', tmpl_pre), ('post', tmpl_post)]:
        log.debug('Installing svn hook in repo %s', repo_path)
        _hook_file = os.path.join(hooks_path, '%s-commit' % h_type)
        _rhodecode_hook = check_rhodecode_hook(_hook_file)

        if _rhodecode_hook or force_create:
            log.debug('writing svn %s hook file at %s !', h_type, _hook_file)

            try:
                with open(_hook_file, 'wb') as f:
                    template = template.replace(
                        '_TMPL_', vcsserver.__version__)
                    template = template.replace('_DATE_', timestamp)
                    template = template.replace('_ENV_', executable)
                    template = template.replace('_PATH_', path)

                    f.write(template)
                os.chmod(_hook_file, 0o755)
            except IOError:
                log.exception('error writing hook file %s', _hook_file)
        else:
            log.debug('skipping writing hook file')

    return True


def get_version_from_hook(hook_path):
    version = ''
    hook_content = read_hook_content(hook_path)
    matches = re.search(r'(?:RC_HOOK_VER)\s*=\s*(.*)', hook_content)
    if matches:
        try:
            version = matches.groups()[0]
            log.debug('got version %s from hooks.', version)
        except Exception:
            log.exception("Exception while reading the hook version.")
    return version.replace("'", "")


def check_rhodecode_hook(hook_path):
    """
    Check if the hook was created by RhodeCode
    """
    if not os.path.exists(hook_path):
        return True

    log.debug('hook exists, checking if it is from RhodeCode')

    version = get_version_from_hook(hook_path)
    if version:
        return True

    return False


def read_hook_content(hook_path):
    with open(hook_path, 'rb') as f:
        content = f.read()
    return content


def get_git_pre_hook_version(repo_path, bare):
    hooks_path = get_git_hooks_path(repo_path, bare)
    _hook_file = os.path.join(hooks_path, 'pre-receive')
    version = get_version_from_hook(_hook_file)
    return version


def get_git_post_hook_version(repo_path, bare):
    hooks_path = get_git_hooks_path(repo_path, bare)
    _hook_file = os.path.join(hooks_path, 'post-receive')
    version = get_version_from_hook(_hook_file)
    return version


def get_svn_pre_hook_version(repo_path):
    hooks_path = get_svn_hooks_path(repo_path)
    _hook_file = os.path.join(hooks_path, 'pre-commit')
    version = get_version_from_hook(_hook_file)
    return version


def get_svn_post_hook_version(repo_path):
    hooks_path = get_svn_hooks_path(repo_path)
    _hook_file = os.path.join(hooks_path, 'post-commit')
    version = get_version_from_hook(_hook_file)
    return version
