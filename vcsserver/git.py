# RhodeCode VCSServer provides access to different vcs backends via network.
# Copyright (C) 2014-2020 RhodeCode GmbH
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

import collections
import logging
import os
import posixpath as vcspath
import re
import stat
import traceback
import urllib
import urllib2
from functools import wraps

import more_itertools
import pygit2
from pygit2 import Repository as LibGit2Repo
from dulwich import index, objects
from dulwich.client import HttpGitClient, LocalGitClient
from dulwich.errors import (
    NotGitRepository, ChecksumMismatch, WrongObjectException,
    MissingCommitError, ObjectMissing, HangupException,
    UnexpectedCommandError)
from dulwich.repo import Repo as DulwichRepo
from dulwich.server import update_server_info

from vcsserver import exceptions, settings, subprocessio
from vcsserver.utils import safe_str, safe_int, safe_unicode
from vcsserver.base import RepoFactory, obfuscate_qs
from vcsserver.hgcompat import (
    hg_url as url_parser, httpbasicauthhandler, httpdigestauthhandler)
from vcsserver.git_lfs.lib import LFSOidStore
from vcsserver.vcs_base import RemoteBase

DIR_STAT = stat.S_IFDIR
FILE_MODE = stat.S_IFMT
GIT_LINK = objects.S_IFGITLINK
PEELED_REF_MARKER = '^{}'


log = logging.getLogger(__name__)


def str_to_dulwich(value):
    """
    Dulwich 0.10.1a requires `unicode` objects to be passed in.
    """
    return value.decode(settings.WIRE_ENCODING)


def reraise_safe_exceptions(func):
    """Converts Dulwich exceptions to something neutral."""

    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except (ChecksumMismatch, WrongObjectException, MissingCommitError, ObjectMissing,) as e:
            exc = exceptions.LookupException(org_exc=e)
            raise exc(safe_str(e))
        except (HangupException, UnexpectedCommandError) as e:
            exc = exceptions.VcsException(org_exc=e)
            raise exc(safe_str(e))
        except Exception as e:
            # NOTE(marcink): becuase of how dulwich handles some exceptions
            # (KeyError on empty repos), we cannot track this and catch all
            # exceptions, it's an exceptions from other handlers
            #if not hasattr(e, '_vcs_kind'):
                #log.exception("Unhandled exception in git remote call")
                #raise_from_original(exceptions.UnhandledException)
            raise
    return wrapper


class Repo(DulwichRepo):
    """
    A wrapper for dulwich Repo class.

    Since dulwich is sometimes keeping .idx file descriptors open, it leads to
    "Too many open files" error. We need to close all opened file descriptors
    once the repo object is destroyed.
    """
    def __del__(self):
        if hasattr(self, 'object_store'):
            self.close()


class Repository(LibGit2Repo):

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.free()


class GitFactory(RepoFactory):
    repo_type = 'git'

    def _create_repo(self, wire, create, use_libgit2=False):
        if use_libgit2:
            return Repository(wire['path'])
        else:
            repo_path = str_to_dulwich(wire['path'])
            return Repo(repo_path)

    def repo(self, wire, create=False, use_libgit2=False):
        """
        Get a repository instance for the given path.
        """
        return self._create_repo(wire, create, use_libgit2)

    def repo_libgit2(self, wire):
        return self.repo(wire, use_libgit2=True)


class GitRemote(RemoteBase):

    def __init__(self, factory):
        self._factory = factory
        self._bulk_methods = {
            "date": self.date,
            "author": self.author,
            "branch": self.branch,
            "message": self.message,
            "parents": self.parents,
            "_commit": self.revision,
        }

    def _wire_to_config(self, wire):
        if 'config' in wire:
            return dict([(x[0] + '_' + x[1], x[2]) for x in wire['config']])
        return {}

    def _remote_conf(self, config):
        params = [
            '-c', 'core.askpass=""',
        ]
        ssl_cert_dir = config.get('vcs_ssl_dir')
        if ssl_cert_dir:
            params.extend(['-c', 'http.sslCAinfo={}'.format(ssl_cert_dir)])
        return params

    @reraise_safe_exceptions
    def discover_git_version(self):
        stdout, _ = self.run_git_command(
            {}, ['--version'], _bare=True, _safe=True)
        prefix = 'git version'
        if stdout.startswith(prefix):
            stdout = stdout[len(prefix):]
        return stdout.strip()

    @reraise_safe_exceptions
    def is_empty(self, wire):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:

            try:
                has_head = repo.head.name
                if has_head:
                    return False

                # NOTE(marcink): check again using more expensive method
                return repo.is_empty
            except Exception:
                pass

            return True

    @reraise_safe_exceptions
    def assert_correct_path(self, wire):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _assert_correct_path(_context_uid, _repo_id):
            try:
                repo_init = self._factory.repo_libgit2(wire)
                with repo_init as repo:
                    pass
            except pygit2.GitError:
                path = wire.get('path')
                tb = traceback.format_exc()
                log.debug("Invalid Git path `%s`, tb: %s", path, tb)
                return False

            return True
        return _assert_correct_path(context_uid, repo_id)

    @reraise_safe_exceptions
    def bare(self, wire):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            return repo.is_bare

    @reraise_safe_exceptions
    def blob_as_pretty_string(self, wire, sha):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            blob_obj = repo[sha]
            blob = blob_obj.data
            return blob

    @reraise_safe_exceptions
    def blob_raw_length(self, wire, sha):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _blob_raw_length(_repo_id, _sha):

            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                blob = repo[sha]
                return blob.size

        return _blob_raw_length(repo_id, sha)

    def _parse_lfs_pointer(self, raw_content):

        spec_string = 'version https://git-lfs.github.com/spec'
        if raw_content and raw_content.startswith(spec_string):
            pattern = re.compile(r"""
            (?:\n)?
            ^version[ ]https://git-lfs\.github\.com/spec/(?P<spec_ver>v\d+)\n
            ^oid[ ] sha256:(?P<oid_hash>[0-9a-f]{64})\n
            ^size[ ](?P<oid_size>[0-9]+)\n
            (?:\n)?
            """, re.VERBOSE | re.MULTILINE)
            match = pattern.match(raw_content)
            if match:
                return match.groupdict()

        return {}

    @reraise_safe_exceptions
    def is_large_file(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)

        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _is_large_file(_repo_id, _sha):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                blob = repo[commit_id]
                if blob.is_binary:
                    return {}

                return self._parse_lfs_pointer(blob.data)

        return _is_large_file(repo_id, commit_id)

    @reraise_safe_exceptions
    def is_binary(self, wire, tree_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)

        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _is_binary(_repo_id, _tree_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                blob_obj = repo[tree_id]
                return blob_obj.is_binary

        return _is_binary(repo_id, tree_id)

    @reraise_safe_exceptions
    def in_largefiles_store(self, wire, oid):
        conf = self._wire_to_config(wire)
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            repo_name = repo.path

        store_location = conf.get('vcs_git_lfs_store_location')
        if store_location:

            store = LFSOidStore(
                oid=oid, repo=repo_name, store_location=store_location)
            return store.has_oid()

        return False

    @reraise_safe_exceptions
    def store_path(self, wire, oid):
        conf = self._wire_to_config(wire)
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            repo_name = repo.path

        store_location = conf.get('vcs_git_lfs_store_location')
        if store_location:
            store = LFSOidStore(
                oid=oid, repo=repo_name, store_location=store_location)
            return store.oid_path
        raise ValueError('Unable to fetch oid with path {}'.format(oid))

    @reraise_safe_exceptions
    def bulk_request(self, wire, rev, pre_load):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _bulk_request(_repo_id, _rev, _pre_load):
            result = {}
            for attr in pre_load:
                try:
                    method = self._bulk_methods[attr]
                    args = [wire, rev]
                    result[attr] = method(*args)
                except KeyError as e:
                    raise exceptions.VcsException(e)(
                        "Unknown bulk attribute: %s" % attr)
            return result

        return _bulk_request(repo_id, rev, sorted(pre_load))

    def _build_opener(self, url):
        handlers = []
        url_obj = url_parser(url)
        _, authinfo = url_obj.authinfo()

        if authinfo:
            # create a password manager
            passmgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
            passmgr.add_password(*authinfo)

            handlers.extend((httpbasicauthhandler(passmgr),
                             httpdigestauthhandler(passmgr)))

        return urllib2.build_opener(*handlers)

    def _type_id_to_name(self, type_id):
        return {
            1: b'commit',
            2: b'tree',
            3: b'blob',
            4: b'tag'
        }[type_id]

    @reraise_safe_exceptions
    def check_url(self, url, config):
        url_obj = url_parser(url)
        test_uri, _ = url_obj.authinfo()
        url_obj.passwd = '*****' if url_obj.passwd else url_obj.passwd
        url_obj.query = obfuscate_qs(url_obj.query)
        cleaned_uri = str(url_obj)
        log.info("Checking URL for remote cloning/import: %s", cleaned_uri)

        if not test_uri.endswith('info/refs'):
            test_uri = test_uri.rstrip('/') + '/info/refs'

        o = self._build_opener(url)
        o.addheaders = [('User-Agent', 'git/1.7.8.0')]  # fake some git

        q = {"service": 'git-upload-pack'}
        qs = '?%s' % urllib.urlencode(q)
        cu = "%s%s" % (test_uri, qs)
        req = urllib2.Request(cu, None, {})

        try:
            log.debug("Trying to open URL %s", cleaned_uri)
            resp = o.open(req)
            if resp.code != 200:
                raise exceptions.URLError()('Return Code is not 200')
        except Exception as e:
            log.warning("URL cannot be opened: %s", cleaned_uri, exc_info=True)
            # means it cannot be cloned
            raise exceptions.URLError(e)("[%s] org_exc: %s" % (cleaned_uri, e))

        # now detect if it's proper git repo
        gitdata = resp.read()
        if 'service=git-upload-pack' in gitdata:
            pass
        elif re.findall(r'[0-9a-fA-F]{40}\s+refs', gitdata):
            # old style git can return some other format !
            pass
        else:
            raise exceptions.URLError()(
                "url [%s] does not look like an git" % (cleaned_uri,))

        return True

    @reraise_safe_exceptions
    def clone(self, wire, url, deferred, valid_refs, update_after_clone):
        # TODO(marcink): deprecate this method. Last i checked we don't use it anymore
        remote_refs = self.pull(wire, url, apply_refs=False)
        repo = self._factory.repo(wire)
        if isinstance(valid_refs, list):
            valid_refs = tuple(valid_refs)

        for k in remote_refs:
            # only parse heads/tags and skip so called deferred tags
            if k.startswith(valid_refs) and not k.endswith(deferred):
                repo[k] = remote_refs[k]

        if update_after_clone:
            # we want to checkout HEAD
            repo["HEAD"] = remote_refs["HEAD"]
            index.build_index_from_tree(repo.path, repo.index_path(),
                                        repo.object_store, repo["HEAD"].tree)

    @reraise_safe_exceptions
    def branch(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _branch(_context_uid, _repo_id, _commit_id):
            regex = re.compile('^refs/heads')

            def filter_with(ref):
                return regex.match(ref[0]) and ref[1] == _commit_id

            branches = filter(filter_with, self.get_refs(wire).items())
            return [x[0].split('refs/heads/')[-1] for x in branches]

        return _branch(context_uid, repo_id, commit_id)

    @reraise_safe_exceptions
    def commit_branches(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _commit_branches(_context_uid, _repo_id, _commit_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                branches = [x for x in repo.branches.with_commit(_commit_id)]
                return branches

        return _commit_branches(context_uid, repo_id, commit_id)

    @reraise_safe_exceptions
    def add_object(self, wire, content):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            blob = objects.Blob()
            blob.set_raw_string(content)
            repo.object_store.add_object(blob)
            return blob.id

    # TODO: this is quite complex, check if that can be simplified
    @reraise_safe_exceptions
    def commit(self, wire, commit_data, branch, commit_tree, updated, removed):
        repo = self._factory.repo(wire)
        object_store = repo.object_store

        # Create tree and populates it with blobs
        commit_tree = commit_tree and repo[commit_tree] or objects.Tree()

        for node in updated:
            # Compute subdirs if needed
            dirpath, nodename = vcspath.split(node['path'])
            dirnames = map(safe_str, dirpath and dirpath.split('/') or [])
            parent = commit_tree
            ancestors = [('', parent)]

            # Tries to dig for the deepest existing tree
            while dirnames:
                curdir = dirnames.pop(0)
                try:
                    dir_id = parent[curdir][1]
                except KeyError:
                    # put curdir back into dirnames and stops
                    dirnames.insert(0, curdir)
                    break
                else:
                    # If found, updates parent
                    parent = repo[dir_id]
                    ancestors.append((curdir, parent))
            # Now parent is deepest existing tree and we need to create
            # subtrees for dirnames (in reverse order)
            # [this only applies for nodes from added]
            new_trees = []

            blob = objects.Blob.from_string(node['content'])

            if dirnames:
                # If there are trees which should be created we need to build
                # them now (in reverse order)
                reversed_dirnames = list(reversed(dirnames))
                curtree = objects.Tree()
                curtree[node['node_path']] = node['mode'], blob.id
                new_trees.append(curtree)
                for dirname in reversed_dirnames[:-1]:
                    newtree = objects.Tree()
                    newtree[dirname] = (DIR_STAT, curtree.id)
                    new_trees.append(newtree)
                    curtree = newtree
                parent[reversed_dirnames[-1]] = (DIR_STAT, curtree.id)
            else:
                parent.add(name=node['node_path'], mode=node['mode'], hexsha=blob.id)

            new_trees.append(parent)
            # Update ancestors
            reversed_ancestors = reversed(
                [(a[1], b[1], b[0]) for a, b in zip(ancestors, ancestors[1:])])
            for parent, tree, path in reversed_ancestors:
                parent[path] = (DIR_STAT, tree.id)
                object_store.add_object(tree)

            object_store.add_object(blob)
            for tree in new_trees:
                object_store.add_object(tree)

        for node_path in removed:
            paths = node_path.split('/')
            tree = commit_tree
            trees = [tree]
            # Traverse deep into the forest...
            for path in paths:
                try:
                    obj = repo[tree[path][1]]
                    if isinstance(obj, objects.Tree):
                        trees.append(obj)
                        tree = obj
                except KeyError:
                    break
            # Cut down the blob and all rotten trees on the way back...
            for path, tree in reversed(zip(paths, trees)):
                del tree[path]
                if tree:
                    # This tree still has elements - don't remove it or any
                    # of it's parents
                    break

        object_store.add_object(commit_tree)

        # Create commit
        commit = objects.Commit()
        commit.tree = commit_tree.id
        for k, v in commit_data.iteritems():
            setattr(commit, k, v)
        object_store.add_object(commit)

        self.create_branch(wire, branch, commit.id)

        # dulwich set-ref
        ref = 'refs/heads/%s' % branch
        repo.refs[ref] = commit.id

        return commit.id

    @reraise_safe_exceptions
    def pull(self, wire, url, apply_refs=True, refs=None, update_after=False):
        if url != 'default' and '://' not in url:
            client = LocalGitClient(url)
        else:
            url_obj = url_parser(url)
            o = self._build_opener(url)
            url, _ = url_obj.authinfo()
            client = HttpGitClient(base_url=url, opener=o)
        repo = self._factory.repo(wire)

        determine_wants = repo.object_store.determine_wants_all
        if refs:
            def determine_wants_requested(references):
                return [references[r] for r in references if r in refs]
            determine_wants = determine_wants_requested

        try:
            remote_refs = client.fetch(
                path=url, target=repo, determine_wants=determine_wants)
        except NotGitRepository as e:
            log.warning(
                'Trying to fetch from "%s" failed, not a Git repository.', url)
            # Exception can contain unicode which we convert
            raise exceptions.AbortException(e)(repr(e))

        # mikhail: client.fetch() returns all the remote refs, but fetches only
        # refs filtered by `determine_wants` function. We need to filter result
        # as well
        if refs:
            remote_refs = {k: remote_refs[k] for k in remote_refs if k in refs}

        if apply_refs:
            # TODO: johbo: Needs proper test coverage with a git repository
            # that contains a tag object, so that we would end up with
            # a peeled ref at this point.
            for k in remote_refs:
                if k.endswith(PEELED_REF_MARKER):
                    log.debug("Skipping peeled reference %s", k)
                    continue
                repo[k] = remote_refs[k]

            if refs and not update_after:
                # mikhail: explicitly set the head to the last ref.
                repo['HEAD'] = remote_refs[refs[-1]]

        if update_after:
            # we want to checkout HEAD
            repo["HEAD"] = remote_refs["HEAD"]
            index.build_index_from_tree(repo.path, repo.index_path(),
                                        repo.object_store, repo["HEAD"].tree)
        return remote_refs

    @reraise_safe_exceptions
    def sync_fetch(self, wire, url, refs=None, all_refs=False):
        repo = self._factory.repo(wire)
        if refs and not isinstance(refs, (list, tuple)):
            refs = [refs]

        config = self._wire_to_config(wire)
        # get all remote refs we'll use to fetch later
        cmd = ['ls-remote']
        if not all_refs:
            cmd += ['--heads', '--tags']
        cmd += [url]
        output, __ = self.run_git_command(
            wire, cmd, fail_on_stderr=False,
            _copts=self._remote_conf(config),
            extra_env={'GIT_TERMINAL_PROMPT': '0'})

        remote_refs = collections.OrderedDict()
        fetch_refs = []

        for ref_line in output.splitlines():
            sha, ref = ref_line.split('\t')
            sha = sha.strip()
            if ref in remote_refs:
                # duplicate, skip
                continue
            if ref.endswith(PEELED_REF_MARKER):
                log.debug("Skipping peeled reference %s", ref)
                continue
            # don't sync HEAD
            if ref in ['HEAD']:
                continue

            remote_refs[ref] = sha

            if refs and sha in refs:
                # we filter fetch using our specified refs
                fetch_refs.append('{}:{}'.format(ref, ref))
            elif not refs:
                fetch_refs.append('{}:{}'.format(ref, ref))
        log.debug('Finished obtaining fetch refs, total: %s', len(fetch_refs))

        if fetch_refs:
            for chunk in more_itertools.chunked(fetch_refs, 1024 * 4):
                fetch_refs_chunks = list(chunk)
                log.debug('Fetching %s refs from import url', len(fetch_refs_chunks))
                _out, _err = self.run_git_command(
                    wire, ['fetch', url, '--force', '--prune', '--'] + fetch_refs_chunks,
                    fail_on_stderr=False,
                    _copts=self._remote_conf(config),
                    extra_env={'GIT_TERMINAL_PROMPT': '0'})

        return remote_refs

    @reraise_safe_exceptions
    def sync_push(self, wire, url, refs=None):
        if not self.check_url(url, wire):
            return
        config = self._wire_to_config(wire)
        self._factory.repo(wire)
        self.run_git_command(
            wire, ['push', url, '--mirror'], fail_on_stderr=False,
            _copts=self._remote_conf(config),
            extra_env={'GIT_TERMINAL_PROMPT': '0'})

    @reraise_safe_exceptions
    def get_remote_refs(self, wire, url):
        repo = Repo(url)
        return repo.get_refs()

    @reraise_safe_exceptions
    def get_description(self, wire):
        repo = self._factory.repo(wire)
        return repo.get_description()

    @reraise_safe_exceptions
    def get_missing_revs(self, wire, rev1, rev2, path2):
        repo = self._factory.repo(wire)
        LocalGitClient(thin_packs=False).fetch(path2, repo)

        wire_remote = wire.copy()
        wire_remote['path'] = path2
        repo_remote = self._factory.repo(wire_remote)
        LocalGitClient(thin_packs=False).fetch(wire["path"], repo_remote)

        revs = [
            x.commit.id
            for x in repo_remote.get_walker(include=[rev2], exclude=[rev1])]
        return revs

    @reraise_safe_exceptions
    def get_object(self, wire, sha, maybe_unreachable=False):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _get_object(_context_uid, _repo_id, _sha):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:

                missing_commit_err = 'Commit {} does not exist for `{}`'.format(sha, wire['path'])
                try:
                    commit = repo.revparse_single(sha)
                except KeyError:
                    # NOTE(marcink): KeyError doesn't give us any meaningful information
                    # here, we instead give something more explicit
                    e = exceptions.RefNotFoundException('SHA: %s not found', sha)
                    raise exceptions.LookupException(e)(missing_commit_err)
                except ValueError as e:
                    raise exceptions.LookupException(e)(missing_commit_err)

                is_tag = False
                if isinstance(commit, pygit2.Tag):
                    commit = repo.get(commit.target)
                    is_tag = True

                check_dangling = True
                if is_tag:
                    check_dangling = False

                if check_dangling and maybe_unreachable:
                    check_dangling = False

                # we used a reference and it parsed means we're not having a dangling commit
                if sha != commit.hex:
                    check_dangling = False

                if check_dangling:
                    # check for dangling commit
                    for branch in repo.branches.with_commit(commit.hex):
                        if branch:
                            break
                    else:
                        # NOTE(marcink): Empty error doesn't give us any meaningful information
                        # here, we instead give something more explicit
                        e = exceptions.RefNotFoundException('SHA: %s not found in branches', sha)
                        raise exceptions.LookupException(e)(missing_commit_err)

                commit_id = commit.hex
                type_id = commit.type

                return {
                    'id': commit_id,
                    'type': self._type_id_to_name(type_id),
                    'commit_id': commit_id,
                    'idx': 0
                }

        return _get_object(context_uid, repo_id, sha)

    @reraise_safe_exceptions
    def get_refs(self, wire):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _get_refs(_context_uid, _repo_id):

            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                regex = re.compile('^refs/(heads|tags)/')
                return {x.name: x.target.hex for x in
                        filter(lambda ref: regex.match(ref.name) ,repo.listall_reference_objects())}

        return _get_refs(context_uid, repo_id)

    @reraise_safe_exceptions
    def get_branch_pointers(self, wire):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _get_branch_pointers(_context_uid, _repo_id):

            repo_init = self._factory.repo_libgit2(wire)
            regex = re.compile('^refs/heads')
            with repo_init as repo:
                branches = filter(lambda ref: regex.match(ref.name), repo.listall_reference_objects())
                return {x.target.hex: x.shorthand for x in branches}

        return _get_branch_pointers(context_uid, repo_id)

    @reraise_safe_exceptions
    def head(self, wire, show_exc=True):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _head(_context_uid, _repo_id, _show_exc):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                try:
                    return repo.head.peel().hex
                except Exception:
                    if show_exc:
                        raise
        return _head(context_uid, repo_id, show_exc)

    @reraise_safe_exceptions
    def init(self, wire):
        repo_path = str_to_dulwich(wire['path'])
        self.repo = Repo.init(repo_path)

    @reraise_safe_exceptions
    def init_bare(self, wire):
        repo_path = str_to_dulwich(wire['path'])
        self.repo = Repo.init_bare(repo_path)

    @reraise_safe_exceptions
    def revision(self, wire, rev):

        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _revision(_context_uid, _repo_id, _rev):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                commit = repo[rev]
                obj_data = {
                    'id': commit.id.hex,
                }
                # tree objects itself don't have tree_id attribute
                if hasattr(commit, 'tree_id'):
                    obj_data['tree'] = commit.tree_id.hex

                return obj_data
        return _revision(context_uid, repo_id, rev)

    @reraise_safe_exceptions
    def date(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _date(_repo_id, _commit_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                commit = repo[commit_id]

                if hasattr(commit, 'commit_time'):
                    commit_time, commit_time_offset = commit.commit_time, commit.commit_time_offset
                else:
                    commit = commit.get_object()
                    commit_time, commit_time_offset = commit.commit_time, commit.commit_time_offset

                # TODO(marcink): check dulwich difference of offset vs timezone
                return [commit_time, commit_time_offset]
        return _date(repo_id, commit_id)

    @reraise_safe_exceptions
    def author(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _author(_repo_id, _commit_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                commit = repo[commit_id]

                if hasattr(commit, 'author'):
                    author = commit.author
                else:
                    author = commit.get_object().author

                if author.email:
                    return u"{} <{}>".format(author.name, author.email)

                try:
                    return u"{}".format(author.name)
                except Exception:
                    return u"{}".format(safe_unicode(author.raw_name))

        return _author(repo_id, commit_id)

    @reraise_safe_exceptions
    def message(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _message(_repo_id, _commit_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                commit = repo[commit_id]
                return commit.message
        return _message(repo_id, commit_id)

    @reraise_safe_exceptions
    def parents(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _parents(_repo_id, _commit_id):
            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                commit = repo[commit_id]
                if hasattr(commit, 'parent_ids'):
                    parent_ids = commit.parent_ids
                else:
                    parent_ids = commit.get_object().parent_ids

                return [x.hex for x in parent_ids]
        return _parents(repo_id, commit_id)

    @reraise_safe_exceptions
    def children(self, wire, commit_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _children(_repo_id, _commit_id):
            output, __ = self.run_git_command(
                wire, ['rev-list', '--all', '--children'])

            child_ids = []
            pat = re.compile(r'^%s' % commit_id)
            for l in output.splitlines():
                if pat.match(l):
                    found_ids = l.split(' ')[1:]
                    child_ids.extend(found_ids)

            return child_ids
        return _children(repo_id, commit_id)

    @reraise_safe_exceptions
    def set_refs(self, wire, key, value):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            repo.references.create(key, value, force=True)

    @reraise_safe_exceptions
    def create_branch(self, wire, branch_name, commit_id, force=False):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            commit = repo[commit_id]

            if force:
                repo.branches.local.create(branch_name, commit, force=force)
            elif not repo.branches.get(branch_name):
                # create only if that branch isn't existing
                repo.branches.local.create(branch_name, commit, force=force)

    @reraise_safe_exceptions
    def remove_ref(self, wire, key):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            repo.references.delete(key)

    @reraise_safe_exceptions
    def tag_remove(self, wire, tag_name):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            key = 'refs/tags/{}'.format(tag_name)
            repo.references.delete(key)

    @reraise_safe_exceptions
    def tree_changes(self, wire, source_id, target_id):
        # TODO(marcink): remove this seems it's only used by tests
        repo = self._factory.repo(wire)
        source = repo[source_id].tree if source_id else None
        target = repo[target_id].tree
        result = repo.object_store.tree_changes(source, target)
        return list(result)

    @reraise_safe_exceptions
    def tree_and_type_for_path(self, wire, commit_id, path):

        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _tree_and_type_for_path(_context_uid, _repo_id, _commit_id, _path):
            repo_init = self._factory.repo_libgit2(wire)

            with repo_init as repo:
                commit = repo[commit_id]
                try:
                    tree = commit.tree[path]
                except KeyError:
                    return None, None, None

                return tree.id.hex, tree.type, tree.filemode
        return _tree_and_type_for_path(context_uid, repo_id, commit_id, path)

    @reraise_safe_exceptions
    def tree_items(self, wire, tree_id):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _tree_items(_repo_id, _tree_id):

            repo_init = self._factory.repo_libgit2(wire)
            with repo_init as repo:
                try:
                    tree = repo[tree_id]
                except KeyError:
                    raise ObjectMissing('No tree with id: {}'.format(tree_id))

                result = []
                for item in tree:
                    item_sha = item.hex
                    item_mode = item.filemode
                    item_type = item.type

                    if item_type == 'commit':
                        # NOTE(marcink): submodules we translate to 'link' for backward compat
                        item_type = 'link'

                    result.append((item.name, item_mode, item_sha, item_type))
                return result
        return _tree_items(repo_id, tree_id)

    @reraise_safe_exceptions
    def diff_2(self, wire, commit_id_1, commit_id_2, file_filter, opt_ignorews, context):
        """
        Old version that uses subprocess to call diff
        """

        flags = [
            '-U%s' % context, '--patch',
            '--binary',
            '--find-renames',
            '--no-indent-heuristic',
            # '--indent-heuristic',
            #'--full-index',
            #'--abbrev=40'
        ]

        if opt_ignorews:
            flags.append('--ignore-all-space')

        if commit_id_1 == self.EMPTY_COMMIT:
            cmd = ['show'] + flags + [commit_id_2]
        else:
            cmd = ['diff'] + flags + [commit_id_1, commit_id_2]

        if file_filter:
            cmd.extend(['--', file_filter])

        diff, __ = self.run_git_command(wire, cmd)
        # If we used 'show' command, strip first few lines (until actual diff
        # starts)
        if commit_id_1 == self.EMPTY_COMMIT:
            lines = diff.splitlines()
            x = 0
            for line in lines:
                if line.startswith('diff'):
                    break
                x += 1
            # Append new line just like 'diff' command do
            diff = '\n'.join(lines[x:]) + '\n'
        return diff

    @reraise_safe_exceptions
    def diff(self, wire, commit_id_1, commit_id_2, file_filter, opt_ignorews, context):
        repo_init = self._factory.repo_libgit2(wire)
        with repo_init as repo:
            swap = True
            flags = 0
            flags |= pygit2.GIT_DIFF_SHOW_BINARY

            if opt_ignorews:
                flags |= pygit2.GIT_DIFF_IGNORE_WHITESPACE

            if commit_id_1 == self.EMPTY_COMMIT:
                comm1 = repo[commit_id_2]
                diff_obj = comm1.tree.diff_to_tree(
                    flags=flags, context_lines=context, swap=swap)

            else:
                comm1 = repo[commit_id_2]
                comm2 = repo[commit_id_1]
                diff_obj = comm1.tree.diff_to_tree(
                    comm2.tree, flags=flags, context_lines=context, swap=swap)
            similar_flags = 0
            similar_flags |= pygit2.GIT_DIFF_FIND_RENAMES
            diff_obj.find_similar(flags=similar_flags)

            if file_filter:
                for p in diff_obj:
                    if p.delta.old_file.path == file_filter:
                        return p.patch or ''
                # fo matching path == no diff
                return ''
            return diff_obj.patch or ''

    @reraise_safe_exceptions
    def node_history(self, wire, commit_id, path, limit):
        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _node_history(_context_uid, _repo_id, _commit_id, _path, _limit):
            # optimize for n==1, rev-list is much faster for that use-case
            if limit == 1:
                cmd = ['rev-list', '-1', commit_id, '--', path]
            else:
                cmd = ['log']
                if limit:
                    cmd.extend(['-n', str(safe_int(limit, 0))])
                cmd.extend(['--pretty=format: %H', '-s', commit_id, '--', path])

            output, __ = self.run_git_command(wire, cmd)
            commit_ids = re.findall(r'[0-9a-fA-F]{40}', output)

            return [x for x in commit_ids]
        return _node_history(context_uid, repo_id, commit_id, path, limit)

    @reraise_safe_exceptions
    def node_annotate(self, wire, commit_id, path):

        cmd = ['blame', '-l', '--root', '-r', commit_id, '--', path]
        # -l     ==> outputs long shas (and we need all 40 characters)
        # --root ==> doesn't put '^' character for boundaries
        # -r commit_id ==> blames for the given commit
        output, __ = self.run_git_command(wire, cmd)

        result = []
        for i, blame_line in enumerate(output.split('\n')[:-1]):
            line_no = i + 1
            commit_id, line = re.split(r' ', blame_line, 1)
            result.append((line_no, commit_id, line))
        return result

    @reraise_safe_exceptions
    def update_server_info(self, wire):
        repo = self._factory.repo(wire)
        update_server_info(repo)

    @reraise_safe_exceptions
    def get_all_commit_ids(self, wire):

        cache_on, context_uid, repo_id = self._cache_on(wire)
        @self.region.conditional_cache_on_arguments(condition=cache_on)
        def _get_all_commit_ids(_context_uid, _repo_id):

            cmd = ['rev-list', '--reverse', '--date-order', '--branches', '--tags']
            try:
                output, __ = self.run_git_command(wire, cmd)
                return output.splitlines()
            except Exception:
                # Can be raised for empty repositories
                return []
        return _get_all_commit_ids(context_uid, repo_id)

    @reraise_safe_exceptions
    def run_git_command(self, wire, cmd, **opts):
        path = wire.get('path', None)

        if path and os.path.isdir(path):
            opts['cwd'] = path

        if '_bare' in opts:
            _copts = []
            del opts['_bare']
        else:
            _copts = ['-c', 'core.quotepath=false', ]
        safe_call = False
        if '_safe' in opts:
            # no exc on failure
            del opts['_safe']
            safe_call = True

        if '_copts' in opts:
            _copts.extend(opts['_copts'] or [])
            del opts['_copts']

        gitenv = os.environ.copy()
        gitenv.update(opts.pop('extra_env', {}))
        # need to clean fix GIT_DIR !
        if 'GIT_DIR' in gitenv:
            del gitenv['GIT_DIR']
        gitenv['GIT_CONFIG_NOGLOBAL'] = '1'
        gitenv['GIT_DISCOVERY_ACROSS_FILESYSTEM'] = '1'

        cmd = [settings.GIT_EXECUTABLE] + _copts + cmd
        _opts = {'env': gitenv, 'shell': False}

        proc = None
        try:
            _opts.update(opts)
            proc = subprocessio.SubprocessIOChunker(cmd, **_opts)

            return ''.join(proc), ''.join(proc.error)
        except (EnvironmentError, OSError) as err:
            cmd = ' '.join(cmd)  # human friendly CMD
            tb_err = ("Couldn't run git command (%s).\n"
                      "Original error was:%s\n"
                      "Call options:%s\n"
                      % (cmd, err, _opts))
            log.exception(tb_err)
            if safe_call:
                return '', err
            else:
                raise exceptions.VcsException()(tb_err)
        finally:
            if proc:
                proc.close()

    @reraise_safe_exceptions
    def install_hooks(self, wire, force=False):
        from vcsserver.hook_utils import install_git_hooks
        bare = self.bare(wire)
        path = wire['path']
        return install_git_hooks(path, bare, force_create=force)

    @reraise_safe_exceptions
    def get_hooks_info(self, wire):
        from vcsserver.hook_utils import (
            get_git_pre_hook_version, get_git_post_hook_version)
        bare = self.bare(wire)
        path = wire['path']
        return {
            'pre_version': get_git_pre_hook_version(path, bare),
            'post_version': get_git_post_hook_version(path, bare),
        }
