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

"""
Special exception handling over the wire.

Since we cannot assume that our client is able to import our exception classes,
this module provides a "wrapping" mechanism to raise plain exceptions
which contain an extra attribute `_vcs_kind` to allow a client to distinguish
different error conditions.
"""

from pyramid.httpexceptions import HTTPLocked, HTTPForbidden


def _make_exception(kind, org_exc, *args):
    """
    Prepares a base `Exception` instance to be sent over the wire.

    To give our caller a hint what this is about, it will attach an attribute
    `_vcs_kind` to the exception.
    """
    exc = Exception(*args)
    exc._vcs_kind = kind
    exc._org_exc = org_exc
    return exc


def AbortException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('abort', org_exc, *args)
    return _make_exception_wrapper


def ArchiveException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('archive', org_exc, *args)
    return _make_exception_wrapper


def LookupException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('lookup', org_exc, *args)
    return _make_exception_wrapper


def VcsException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('error', org_exc, *args)
    return _make_exception_wrapper


def RepositoryLockedException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('repo_locked', org_exc, *args)
    return _make_exception_wrapper


def RepositoryBranchProtectedException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('repo_branch_protected', org_exc, *args)
    return _make_exception_wrapper


def RequirementException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('requirement', org_exc, *args)
    return _make_exception_wrapper


def UnhandledException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('unhandled', org_exc, *args)
    return _make_exception_wrapper


def URLError(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('url_error', org_exc, *args)
    return _make_exception_wrapper


def SubrepoMergeException(org_exc=None):
    def _make_exception_wrapper(*args):
        return _make_exception('subrepo_merge_error', org_exc, *args)
    return _make_exception_wrapper


class HTTPRepoLocked(HTTPLocked):
    """
    Subclass of HTTPLocked response that allows to set the title and status
    code via constructor arguments.
    """
    def __init__(self, title, status_code=None, **kwargs):
        self.code = status_code or HTTPLocked.code
        self.title = title
        super(HTTPRepoLocked, self).__init__(**kwargs)


class HTTPRepoBranchProtected(HTTPForbidden):
    def __init__(self, *args, **kwargs):
        super(HTTPForbidden, self).__init__(*args, **kwargs)
