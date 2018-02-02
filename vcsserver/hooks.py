# -*- coding: utf-8 -*-

# RhodeCode VCSServer provides access to different vcs backends via network.
# Copyright (C) 2014-2018 RhodeCode GmbH
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

import io
import os
import sys
import json
import logging
import collections
import importlib

from httplib import HTTPConnection


import mercurial.scmutil
import mercurial.node
import simplejson as json

from vcsserver import exceptions, subprocessio, settings

log = logging.getLogger(__name__)


class HooksHttpClient(object):
    connection = None

    def __init__(self, hooks_uri):
        self.hooks_uri = hooks_uri

    def __call__(self, method, extras):
        connection = HTTPConnection(self.hooks_uri)
        body = self._serialize(method, extras)
        connection.request('POST', '/', body)
        response = connection.getresponse()
        return json.loads(response.read())

    def _serialize(self, hook_name, extras):
        data = {
            'method': hook_name,
            'extras': extras
        }
        return json.dumps(data)


class HooksDummyClient(object):
    def __init__(self, hooks_module):
        self._hooks_module = importlib.import_module(hooks_module)

    def __call__(self, hook_name, extras):
        with self._hooks_module.Hooks() as hooks:
            return getattr(hooks, hook_name)(extras)


class RemoteMessageWriter(object):
    """Writer base class."""
    def write(self, message):
        raise NotImplementedError()


class HgMessageWriter(RemoteMessageWriter):
    """Writer that knows how to send messages to mercurial clients."""

    def __init__(self, ui):
        self.ui = ui

    def write(self, message):
        # TODO: Check why the quiet flag is set by default.
        old = self.ui.quiet
        self.ui.quiet = False
        self.ui.status(message.encode('utf-8'))
        self.ui.quiet = old


class GitMessageWriter(RemoteMessageWriter):
    """Writer that knows how to send messages to git clients."""

    def __init__(self, stdout=None):
        self.stdout = stdout or sys.stdout

    def write(self, message):
        self.stdout.write(message.encode('utf-8'))


def _handle_exception(result):
    exception_class = result.get('exception')
    exception_traceback = result.get('exception_traceback')

    if exception_traceback:
        log.error('Got traceback from remote call:%s', exception_traceback)

    if exception_class == 'HTTPLockedRC':
        raise exceptions.RepositoryLockedException(*result['exception_args'])
    elif exception_class == 'RepositoryError':
        raise exceptions.VcsException(*result['exception_args'])
    elif exception_class:
        raise Exception('Got remote exception "%s" with args "%s"' %
                        (exception_class, result['exception_args']))


def _get_hooks_client(extras):
    if 'hooks_uri' in extras:
        protocol = extras.get('hooks_protocol')
        return HooksHttpClient(extras['hooks_uri'])
    else:
        return HooksDummyClient(extras['hooks_module'])


def _call_hook(hook_name, extras, writer):
    hooks = _get_hooks_client(extras)
    result = hooks(hook_name, extras)
    log.debug('Hooks got result: %s', result)
    writer.write(result['output'])
    _handle_exception(result)

    return result['status']


def _extras_from_ui(ui):
    hook_data = ui.config('rhodecode', 'RC_SCM_DATA')
    if not hook_data:
        # maybe it's inside environ ?
        env_hook_data = os.environ.get('RC_SCM_DATA')
        if env_hook_data:
            hook_data = env_hook_data

    extras = {}
    if hook_data:
        extras = json.loads(hook_data)
    return extras


def _rev_range_hash(repo, node):

    commits = []
    for rev in xrange(repo[node], len(repo)):
        ctx = repo[rev]
        commit_id = mercurial.node.hex(ctx.node())
        branch = ctx.branch()
        commits.append((commit_id, branch))

    return commits


def repo_size(ui, repo, **kwargs):
    extras = _extras_from_ui(ui)
    return _call_hook('repo_size', extras, HgMessageWriter(ui))


def pre_pull(ui, repo, **kwargs):
    extras = _extras_from_ui(ui)
    return _call_hook('pre_pull', extras, HgMessageWriter(ui))


def pre_pull_ssh(ui, repo, **kwargs):
    extras = _extras_from_ui(ui)
    if extras and extras.get('SSH'):
        return pre_pull(ui, repo, **kwargs)
    return 0


def post_pull(ui, repo, **kwargs):
    extras = _extras_from_ui(ui)
    return _call_hook('post_pull', extras, HgMessageWriter(ui))


def post_pull_ssh(ui, repo, **kwargs):
    extras = _extras_from_ui(ui)
    if extras and extras.get('SSH'):
        return post_pull(ui, repo, **kwargs)
    return 0


def pre_push(ui, repo, node=None, **kwargs):
    extras = _extras_from_ui(ui)

    rev_data = []
    if node and kwargs.get('hooktype') == 'pretxnchangegroup':
        branches = collections.defaultdict(list)
        for commit_id, branch in _rev_range_hash(repo, node):
            branches[branch].append(commit_id)

        for branch, commits in branches.iteritems():
            old_rev = kwargs.get('node_last') or commits[0]
            rev_data.append({
                'old_rev': old_rev,
                'new_rev': commits[-1],
                'ref': '',
                'type': 'branch',
                'name': branch,
            })

    extras['commit_ids'] = rev_data
    return _call_hook('pre_push', extras, HgMessageWriter(ui))


def pre_push_ssh(ui, repo, node=None, **kwargs):
    if _extras_from_ui(ui).get('SSH'):
        return pre_push(ui, repo, node, **kwargs)

    return 0


def pre_push_ssh_auth(ui, repo, node=None, **kwargs):
    extras = _extras_from_ui(ui)
    if extras.get('SSH'):
        permission = extras['SSH_PERMISSIONS']

        if 'repository.write' == permission or 'repository.admin' == permission:
            return 0

        # non-zero ret code
        return 1

    return 0


def post_push(ui, repo, node, **kwargs):
    extras = _extras_from_ui(ui)

    commit_ids = []
    branches = []
    bookmarks = []
    tags = []

    for commit_id, branch in _rev_range_hash(repo, node):
        commit_ids.append(commit_id)
        if branch not in branches:
            branches.append(branch)

    if hasattr(ui, '_rc_pushkey_branches'):
        bookmarks = ui._rc_pushkey_branches

    extras['commit_ids'] = commit_ids
    extras['new_refs'] = {
        'branches': branches,
        'bookmarks': bookmarks,
        'tags': tags
    }

    return _call_hook('post_push', extras, HgMessageWriter(ui))


def post_push_ssh(ui, repo, node, **kwargs):
    if _extras_from_ui(ui).get('SSH'):
        return post_push(ui, repo, node, **kwargs)
    return 0


def key_push(ui, repo, **kwargs):
    if kwargs['new'] != '0' and kwargs['namespace'] == 'bookmarks':
        # store new bookmarks in our UI object propagated later to post_push
        ui._rc_pushkey_branches = repo[kwargs['key']].bookmarks()
    return


# backward compat
log_pull_action = post_pull

# backward compat
log_push_action = post_push


def handle_git_pre_receive(unused_repo_path, unused_revs, unused_env):
    """
    Old hook name: keep here for backward compatibility.

    This is only required when the installed git hooks are not upgraded.
    """
    pass


def handle_git_post_receive(unused_repo_path, unused_revs, unused_env):
    """
    Old hook name: keep here for backward compatibility.

    This is only required when the installed git hooks are not upgraded.
    """
    pass


HookResponse = collections.namedtuple('HookResponse', ('status', 'output'))


def git_pre_pull(extras):
    """
    Pre pull hook.

    :param extras: dictionary containing the keys defined in simplevcs
    :type extras: dict

    :return: status code of the hook. 0 for success.
    :rtype: int
    """
    if 'pull' not in extras['hooks']:
        return HookResponse(0, '')

    stdout = io.BytesIO()
    try:
        status = _call_hook('pre_pull', extras, GitMessageWriter(stdout))
    except Exception as error:
        status = 128
        stdout.write('ERROR: %s\n' % str(error))

    return HookResponse(status, stdout.getvalue())


def git_post_pull(extras):
    """
    Post pull hook.

    :param extras: dictionary containing the keys defined in simplevcs
    :type extras: dict

    :return: status code of the hook. 0 for success.
    :rtype: int
    """
    if 'pull' not in extras['hooks']:
        return HookResponse(0, '')

    stdout = io.BytesIO()
    try:
        status = _call_hook('post_pull', extras, GitMessageWriter(stdout))
    except Exception as error:
        status = 128
        stdout.write('ERROR: %s\n' % error)

    return HookResponse(status, stdout.getvalue())


def _parse_git_ref_lines(revision_lines):
    rev_data = []
    for revision_line in revision_lines or []:
        old_rev, new_rev, ref = revision_line.strip().split(' ')
        ref_data = ref.split('/', 2)
        if ref_data[1] in ('tags', 'heads'):
            rev_data.append({
                'old_rev': old_rev,
                'new_rev': new_rev,
                'ref': ref,
                'type': ref_data[1],
                'name': ref_data[2],
            })
    return rev_data


def git_pre_receive(unused_repo_path, revision_lines, env):
    """
    Pre push hook.

    :param extras: dictionary containing the keys defined in simplevcs
    :type extras: dict

    :return: status code of the hook. 0 for success.
    :rtype: int
    """
    extras = json.loads(env['RC_SCM_DATA'])
    rev_data = _parse_git_ref_lines(revision_lines)
    if 'push' not in extras['hooks']:
        return 0
    extras['commit_ids'] = rev_data
    return _call_hook('pre_push', extras, GitMessageWriter())


def _run_command(arguments):
    """
    Run the specified command and return the stdout.

    :param arguments: sequence of program arguments (including the program name)
    :type arguments: list[str]
    """

    cmd = arguments
    try:
        gitenv = os.environ.copy()
        _opts = {'env': gitenv, 'shell': False, 'fail_on_stderr': False}
        p = subprocessio.SubprocessIOChunker(cmd, **_opts)
        stdout = ''.join(p)
    except (EnvironmentError, OSError) as err:
        cmd = ' '.join(cmd)  # human friendly CMD
        tb_err = ("Couldn't run git command (%s).\n"
                  "Original error was:%s\n" % (cmd, err))
        log.exception(tb_err)
        raise Exception(tb_err)

    return stdout


def git_post_receive(unused_repo_path, revision_lines, env):
    """
    Post push hook.

    :param extras: dictionary containing the keys defined in simplevcs
    :type extras: dict

    :return: status code of the hook. 0 for success.
    :rtype: int
    """
    extras = json.loads(env['RC_SCM_DATA'])
    if 'push' not in extras['hooks']:
        return 0

    rev_data = _parse_git_ref_lines(revision_lines)

    git_revs = []

    # N.B.(skreft): it is ok to just call git, as git before calling a
    # subcommand sets the PATH environment variable so that it point to the
    # correct version of the git executable.
    empty_commit_id = '0' * 40
    branches = []
    tags = []
    for push_ref in rev_data:
        type_ = push_ref['type']

        if type_ == 'heads':
            if push_ref['old_rev'] == empty_commit_id:
                # starting new branch case
                if push_ref['name'] not in branches:
                    branches.append(push_ref['name'])

                # Fix up head revision if needed
                cmd = [settings.GIT_EXECUTABLE, 'show', 'HEAD']
                try:
                    _run_command(cmd)
                except Exception:
                    cmd = [settings.GIT_EXECUTABLE, 'symbolic-ref', 'HEAD',
                           'refs/heads/%s' % push_ref['name']]
                    print("Setting default branch to %s" % push_ref['name'])
                    _run_command(cmd)

                cmd = [settings.GIT_EXECUTABLE, 'for-each-ref', '--format=%(refname)',
                       'refs/heads/*']
                heads = _run_command(cmd)
                heads = heads.replace(push_ref['ref'], '')
                heads = ' '.join(head for head in heads.splitlines() if head)
                cmd = [settings.GIT_EXECUTABLE, 'log', '--reverse', '--pretty=format:%H',
                        '--', push_ref['new_rev'], '--not', heads]
                git_revs.extend(_run_command(cmd).splitlines())
            elif push_ref['new_rev'] == empty_commit_id:
                # delete branch case
                git_revs.append('delete_branch=>%s' % push_ref['name'])
            else:
                if push_ref['name'] not in branches:
                    branches.append(push_ref['name'])

                cmd = [settings.GIT_EXECUTABLE, 'log',
                       '{old_rev}..{new_rev}'.format(**push_ref),
                       '--reverse', '--pretty=format:%H']
                git_revs.extend(_run_command(cmd).splitlines())
        elif type_ == 'tags':
            if push_ref['name'] not in tags:
                tags.append(push_ref['name'])
            git_revs.append('tag=>%s' % push_ref['name'])

    extras['commit_ids'] = git_revs
    extras['new_refs'] = {
        'branches': branches,
        'bookmarks': [],
        'tags': tags,
    }

    if 'repo_size' in extras['hooks']:
        try:
            _call_hook('repo_size', extras, GitMessageWriter())
        except:
            pass

    return _call_hook('post_push', extras, GitMessageWriter())
