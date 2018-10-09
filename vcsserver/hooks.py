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
import logging
import collections
import importlib
import base64

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
        try:
            connection.request('POST', '/', body)
        except Exception:
            log.error('Connection failed on %s', connection)
            raise
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


class SvnMessageWriter(RemoteMessageWriter):
    """Writer that knows how to send messages to svn clients."""

    def __init__(self, stderr=None):
        # SVN needs data sent to stderr for back-to-client messaging
        self.stderr = stderr or sys.stderr

    def write(self, message):
        self.stderr.write(message.encode('utf-8'))


def _handle_exception(result):
    exception_class = result.get('exception')
    exception_traceback = result.get('exception_traceback')

    if exception_traceback:
        log.error('Got traceback from remote call:%s', exception_traceback)

    if exception_class == 'HTTPLockedRC':
        raise exceptions.RepositoryLockedException()(*result['exception_args'])
    elif exception_class == 'HTTPBranchProtected':
        raise exceptions.RepositoryBranchProtectedException()(*result['exception_args'])
    elif exception_class == 'RepositoryError':
        raise exceptions.VcsException()(*result['exception_args'])
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
    hooks_client = _get_hooks_client(extras)
    log.debug('Hooks, using client:%s', hooks_client)
    result = hooks_client(hook_name, extras)
    log.debug('Hooks got result: %s', result)

    _handle_exception(result)
    writer.write(result['output'])

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


def _rev_range_hash(repo, node, check_heads=False):

    commits = []
    revs = []
    start = repo[node].rev()
    end = len(repo)
    for rev in range(start, end):
        revs.append(rev)
        ctx = repo[rev]
        commit_id = mercurial.node.hex(ctx.node())
        branch = ctx.branch()
        commits.append((commit_id, branch))

    parent_heads = []
    if check_heads:
        parent_heads = _check_heads(repo, start, end, revs)
    return commits, parent_heads


def _check_heads(repo, start, end, commits):
    changelog = repo.changelog
    parents = set()

    for new_rev in commits:
        for p in changelog.parentrevs(new_rev):
            if p == mercurial.node.nullrev:
                continue
            if p < start:
                parents.add(p)

    for p in parents:
        branch = repo[p].branch()
        # The heads descending from that parent, on the same branch
        parent_heads = set([p])
        reachable = set([p])
        for x in xrange(p + 1, end):
            if repo[x].branch() != branch:
                continue
            for pp in changelog.parentrevs(x):
                if pp in reachable:
                    reachable.add(x)
                    parent_heads.discard(pp)
                    parent_heads.add(x)
        # More than one head? Suggest merging
        if len(parent_heads) > 1:
            return list(parent_heads)

    return []


def _get_git_env():
    env = {}
    for k, v in os.environ.items():
        if k.startswith('GIT'):
            env[k] = v

    # serialized version
    return [(k, v) for k, v in env.items()]


def _get_hg_env(old_rev, new_rev, txnid, repo_path):
    env = {}
    for k, v in os.environ.items():
        if k.startswith('HG'):
            env[k] = v

    env['HG_NODE'] = old_rev
    env['HG_NODE_LAST'] = new_rev
    env['HG_TXNID'] = txnid
    env['HG_PENDING'] = repo_path

    return [(k, v) for k, v in env.items()]


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
    """
    Mercurial pre_push hook
    """
    extras = _extras_from_ui(ui)
    detect_force_push = extras.get('detect_force_push')

    rev_data = []
    if node and kwargs.get('hooktype') == 'pretxnchangegroup':
        branches = collections.defaultdict(list)
        commits, _heads = _rev_range_hash(repo, node, check_heads=detect_force_push)
        for commit_id, branch in commits:
            branches[branch].append(commit_id)

        for branch, commits in branches.items():
            old_rev = kwargs.get('node_last') or commits[0]
            rev_data.append({
                'total_commits': len(commits),
                'old_rev': old_rev,
                'new_rev': commits[-1],
                'ref': '',
                'type': 'branch',
                'name': branch,
            })

        for push_ref in rev_data:
            push_ref['multiple_heads'] = _heads

            repo_path = os.path.join(
                extras.get('repo_store', ''), extras.get('repository', ''))
            push_ref['hg_env'] = _get_hg_env(
                old_rev=push_ref['old_rev'],
                new_rev=push_ref['new_rev'], txnid=kwargs.get('txnid'),
                repo_path=repo_path)

    extras['hook_type'] = kwargs.get('hooktype', 'pre_push')
    extras['commit_ids'] = rev_data

    return _call_hook('pre_push', extras, HgMessageWriter(ui))


def pre_push_ssh(ui, repo, node=None, **kwargs):
    extras = _extras_from_ui(ui)
    if extras.get('SSH'):
        return pre_push(ui, repo, node, **kwargs)

    return 0


def pre_push_ssh_auth(ui, repo, node=None, **kwargs):
    """
    Mercurial pre_push hook for SSH
    """
    extras = _extras_from_ui(ui)
    if extras.get('SSH'):
        permission = extras['SSH_PERMISSIONS']

        if 'repository.write' == permission or 'repository.admin' == permission:
            return 0

        # non-zero ret code
        return 1

    return 0


def post_push(ui, repo, node, **kwargs):
    """
    Mercurial post_push hook
    """
    extras = _extras_from_ui(ui)

    commit_ids = []
    branches = []
    bookmarks = []
    tags = []

    commits, _heads = _rev_range_hash(repo, node)
    for commit_id, branch in commits:
        commit_ids.append(commit_id)
        if branch not in branches:
            branches.append(branch)

    if hasattr(ui, '_rc_pushkey_branches'):
        bookmarks = ui._rc_pushkey_branches

    extras['hook_type'] = kwargs.get('hooktype', 'post_push')
    extras['commit_ids'] = commit_ids
    extras['new_refs'] = {
        'branches': branches,
        'bookmarks': bookmarks,
        'tags': tags
    }

    return _call_hook('post_push', extras, HgMessageWriter(ui))


def post_push_ssh(ui, repo, node, **kwargs):
    """
    Mercurial post_push hook for SSH
    """
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
                # NOTE(marcink):
                # we're unable to tell total_commits for git at this point
                # but we set the variable for consistency with GIT
                'total_commits': -1,
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
    empty_commit_id = '0' * 40

    detect_force_push = extras.get('detect_force_push')

    for push_ref in rev_data:
        # store our git-env which holds the temp store
        push_ref['git_env'] = _get_git_env()
        push_ref['pruned_sha'] = ''
        if not detect_force_push:
            # don't check for forced-push when we don't need to
            continue

        type_ = push_ref['type']
        new_branch = push_ref['old_rev'] == empty_commit_id
        if type_ == 'heads' and not new_branch:
            old_rev = push_ref['old_rev']
            new_rev = push_ref['new_rev']
            cmd = [settings.GIT_EXECUTABLE, 'rev-list',
                   old_rev, '^{}'.format(new_rev)]
            stdout, stderr = subprocessio.run_command(
                cmd, env=os.environ.copy())
            # means we're having some non-reachable objects, this forced push
            # was used
            if stdout:
                push_ref['pruned_sha'] = stdout.splitlines()

    extras['hook_type'] = 'pre_receive'
    extras['commit_ids'] = rev_data
    return _call_hook('pre_push', extras, GitMessageWriter())


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
                    subprocessio.run_command(cmd, env=os.environ.copy())
                except Exception:
                    cmd = [settings.GIT_EXECUTABLE, 'symbolic-ref', 'HEAD',
                           'refs/heads/%s' % push_ref['name']]
                    print("Setting default branch to %s" % push_ref['name'])
                    subprocessio.run_command(cmd, env=os.environ.copy())

                cmd = [settings.GIT_EXECUTABLE, 'for-each-ref',
                       '--format=%(refname)', 'refs/heads/*']
                stdout, stderr = subprocessio.run_command(
                    cmd, env=os.environ.copy())
                heads = stdout
                heads = heads.replace(push_ref['ref'], '')
                heads = ' '.join(head for head
                                 in heads.splitlines() if head) or '.'
                cmd = [settings.GIT_EXECUTABLE, 'log', '--reverse',
                       '--pretty=format:%H', '--', push_ref['new_rev'],
                       '--not', heads]
                stdout, stderr = subprocessio.run_command(
                    cmd, env=os.environ.copy())
                git_revs.extend(stdout.splitlines())
            elif push_ref['new_rev'] == empty_commit_id:
                # delete branch case
                git_revs.append('delete_branch=>%s' % push_ref['name'])
            else:
                if push_ref['name'] not in branches:
                    branches.append(push_ref['name'])

                cmd = [settings.GIT_EXECUTABLE, 'log',
                       '{old_rev}..{new_rev}'.format(**push_ref),
                       '--reverse', '--pretty=format:%H']
                stdout, stderr = subprocessio.run_command(
                    cmd, env=os.environ.copy())
                git_revs.extend(stdout.splitlines())
        elif type_ == 'tags':
            if push_ref['name'] not in tags:
                tags.append(push_ref['name'])
            git_revs.append('tag=>%s' % push_ref['name'])

    extras['hook_type'] = 'post_receive'
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


def _get_extras_from_txn_id(path, txn_id):
    extras = {}
    try:
        cmd = ['svnlook', 'pget',
               '-t', txn_id,
               '--revprop', path, 'rc-scm-extras']
        stdout, stderr = subprocessio.run_command(
            cmd, env=os.environ.copy())
        extras = json.loads(base64.urlsafe_b64decode(stdout))
    except Exception:
        log.exception('Failed to extract extras info from txn_id')

    return extras


def _get_extras_from_commit_id(commit_id, path):
    extras = {}
    try:
        cmd = ['svnlook', 'pget',
               '-r', commit_id,
               '--revprop', path, 'rc-scm-extras']
        stdout, stderr = subprocessio.run_command(
            cmd, env=os.environ.copy())
        extras = json.loads(base64.urlsafe_b64decode(stdout))
    except Exception:
        log.exception('Failed to extract extras info from commit_id')

    return extras


def svn_pre_commit(repo_path, commit_data, env):
    path, txn_id = commit_data
    branches = []
    tags = []

    if env.get('RC_SCM_DATA'):
        extras = json.loads(env['RC_SCM_DATA'])
    else:
        # fallback method to read from TXN-ID stored data
        extras = _get_extras_from_txn_id(path, txn_id)
        if not extras:
            return 0

    extras['commit_ids'] = []
    extras['txn_id'] = txn_id
    extras['new_refs'] = {
        'total_commits': 1,
        'branches': branches,
        'bookmarks': [],
        'tags': tags,
    }

    return _call_hook('pre_push', extras, SvnMessageWriter())


def svn_post_commit(repo_path, commit_data, env):
    """
    commit_data is path, rev, txn_id
    """
    path, commit_id, txn_id = commit_data
    branches = []
    tags = []

    if env.get('RC_SCM_DATA'):
        extras = json.loads(env['RC_SCM_DATA'])
    else:
        # fallback method to read from TXN-ID stored data
        extras = _get_extras_from_commit_id(commit_id, path)
        if not extras:
            return 0

    extras['commit_ids'] = [commit_id]
    extras['txn_id'] = txn_id
    extras['new_refs'] = {
        'branches': branches,
        'bookmarks': [],
        'tags': tags,
        'total_commits': 1,
    }

    if 'repo_size' in extras['hooks']:
        try:
            _call_hook('repo_size', extras, SvnMessageWriter())
        except Exception:
            pass

    return _call_hook('post_push', extras, SvnMessageWriter())
