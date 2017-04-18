# RhodeCode VCSServer provides access to different vcs backends via network.
# Copyright (C) 2014-2017 RodeCode GmbH
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
import logging
from wsgiref.util import FileWrapper

import simplejson as json
from pyramid.config import Configurator
from pyramid.response import Response, FileIter
from pyramid.httpexceptions import (
    HTTPBadRequest, HTTPNotImplemented, HTTPNotFound, HTTPForbidden,
    HTTPUnprocessableEntity)

from vcsserver.git_lfs.lib import OidHandler, LFSOidStore
from vcsserver.git_lfs.utils import safe_result, get_cython_compat_decorator
from vcsserver.utils import safe_int

log = logging.getLogger(__name__)


GIT_LFS_CONTENT_TYPE = 'application/vnd.git-lfs' #+json ?
GIT_LFS_PROTO_PAT = re.compile(r'^/(.+)/(info/lfs/(.+))')


def write_response_error(http_exception, text=None):
    content_type = GIT_LFS_CONTENT_TYPE + '+json'
    _exception = http_exception(content_type=content_type)
    _exception.content_type = content_type
    if text:
        _exception.body = json.dumps({'message': text})
    log.debug('LFS: writing response of type %s to client with text:%s',
              http_exception, text)
    return _exception


class AuthHeaderRequired(object):
    """
    Decorator to check if request has proper auth-header
    """

    def __call__(self, func):
        return get_cython_compat_decorator(self.__wrapper, func)

    def __wrapper(self, func, *fargs, **fkwargs):
        request = fargs[1]
        auth = request.authorization
        if not auth:
            return write_response_error(HTTPForbidden)
        return func(*fargs[1:], **fkwargs)


# views

def lfs_objects(request):
    # indicate not supported, V1 API
    log.warning('LFS: v1 api not supported, reporting it back to client')
    return write_response_error(HTTPNotImplemented, 'LFS: v1 api not supported')


@AuthHeaderRequired()
def lfs_objects_batch(request):
    """
    The client sends the following information to the Batch endpoint to transfer some objects:

        operation - Should be download or upload.
        transfers - An optional Array of String identifiers for transfer
            adapters that the client has configured. If omitted, the basic
            transfer adapter MUST be assumed by the server.
        objects - An Array of objects to download.
        oid - String OID of the LFS object.
        size - Integer byte size of the LFS object. Must be at least zero.
    """
    request.response.content_type = GIT_LFS_CONTENT_TYPE + '+json'
    auth = request.authorization
    repo = request.matchdict.get('repo')
    data = request.json
    operation = data.get('operation')
    if operation not in ('download', 'upload'):
        log.debug('LFS: unsupported operation:%s', operation)
        return write_response_error(
            HTTPBadRequest, 'unsupported operation mode: `%s`' % operation)

    if 'objects' not in data:
        log.debug('LFS: missing objects data')
        return write_response_error(
            HTTPBadRequest, 'missing objects data')

    log.debug('LFS: handling operation of type: %s', operation)

    objects = []
    for o in data['objects']:
        try:
            oid = o['oid']
            obj_size = o['size']
        except KeyError:
            log.exception('LFS, failed to extract data')
            return write_response_error(
                HTTPBadRequest, 'unsupported data in objects')

        obj_data = {'oid': oid}

        obj_href = request.route_url('lfs_objects_oid', repo=repo, oid=oid)
        obj_verify_href = request.route_url('lfs_objects_verify', repo=repo)
        store = LFSOidStore(
            oid, repo, store_location=request.registry.git_lfs_store_path)
        handler = OidHandler(
            store, repo, auth, oid, obj_size, obj_data,
            obj_href, obj_verify_href)

        # this verifies also OIDs
        actions, errors = handler.exec_operation(operation)
        if errors:
            log.warning('LFS: got following errors: %s', errors)
            obj_data['errors'] = errors

        if actions:
            obj_data['actions'] = actions

        obj_data['size'] = obj_size
        obj_data['authenticated'] = True
        objects.append(obj_data)

    result = {'objects': objects, 'transfer': 'basic'}
    log.debug('LFS Response %s', safe_result(result))

    return result


def lfs_objects_oid_upload(request):
    request.response.content_type = GIT_LFS_CONTENT_TYPE + '+json'
    repo = request.matchdict.get('repo')
    oid = request.matchdict.get('oid')
    store = LFSOidStore(
        oid, repo, store_location=request.registry.git_lfs_store_path)
    engine = store.get_engine(mode='wb')
    log.debug('LFS: starting chunked write of LFS oid: %s to storage', oid)

    body = request.environ['wsgi.input']

    with engine as f:
        blksize = 64 * 1024  # 64kb
        while True:
            # read in chunks as stream comes in from Gunicorn
            # this is a specific Gunicorn support function.
            # might work differently on waitress
            chunk = body.read(blksize)
            if not chunk:
                break
            f.write(chunk)

    return {'upload': 'ok'}


def lfs_objects_oid_download(request):
    repo = request.matchdict.get('repo')
    oid = request.matchdict.get('oid')

    store = LFSOidStore(
        oid, repo, store_location=request.registry.git_lfs_store_path)
    if not store.has_oid():
        log.debug('LFS: oid %s does not exists in store', oid)
        return write_response_error(
            HTTPNotFound, 'requested file with oid `%s` not found in store' % oid)

    # TODO(marcink): support range header ?
    # Range: bytes=0-, `bytes=(\d+)\-.*`

    f = open(store.oid_path, 'rb')
    response = Response(
        content_type='application/octet-stream', app_iter=FileIter(f))
    response.headers.add('X-RC-LFS-Response-Oid', str(oid))
    return response


def lfs_objects_verify(request):
    request.response.content_type = GIT_LFS_CONTENT_TYPE + '+json'
    repo = request.matchdict.get('repo')

    data = request.json
    oid = data.get('oid')
    size = safe_int(data.get('size'))

    if not (oid and size):
        return write_response_error(
            HTTPBadRequest, 'missing oid and size in request data')

    store = LFSOidStore(
        oid, repo, store_location=request.registry.git_lfs_store_path)
    if not store.has_oid():
        log.debug('LFS: oid %s does not exists in store', oid)
        return write_response_error(
            HTTPNotFound, 'oid `%s` does not exists in store' % oid)

    store_size = store.size_oid()
    if store_size != size:
        msg = 'requested file size mismatch store size:%s requested:%s' % (
            store_size, size)
        return write_response_error(
            HTTPUnprocessableEntity, msg)

    return {'message': {'size': 'ok', 'in_store': 'ok'}}


def lfs_objects_lock(request):
    return write_response_error(
        HTTPNotImplemented, 'GIT LFS locking api not supported')


def not_found(request):
    return write_response_error(
        HTTPNotFound, 'request path not found')


def lfs_disabled(request):
    return write_response_error(
        HTTPNotImplemented, 'GIT LFS disabled for this repo')


def git_lfs_app(config):

    # v1 API deprecation endpoint
    config.add_route('lfs_objects',
                     '/{repo:.*?[^/]}/info/lfs/objects')
    config.add_view(lfs_objects, route_name='lfs_objects',
                    request_method='POST', renderer='json')

    # locking API
    config.add_route('lfs_objects_lock',
                     '/{repo:.*?[^/]}/info/lfs/locks')
    config.add_view(lfs_objects_lock, route_name='lfs_objects_lock',
                    request_method=('POST', 'GET'), renderer='json')

    config.add_route('lfs_objects_lock_verify',
                     '/{repo:.*?[^/]}/info/lfs/locks/verify')
    config.add_view(lfs_objects_lock, route_name='lfs_objects_lock_verify',
                    request_method=('POST', 'GET'), renderer='json')

    # batch API
    config.add_route('lfs_objects_batch',
                     '/{repo:.*?[^/]}/info/lfs/objects/batch')
    config.add_view(lfs_objects_batch, route_name='lfs_objects_batch',
                    request_method='POST', renderer='json')

    # oid upload/download API
    config.add_route('lfs_objects_oid',
                     '/{repo:.*?[^/]}/info/lfs/objects/{oid}')
    config.add_view(lfs_objects_oid_upload, route_name='lfs_objects_oid',
                    request_method='PUT', renderer='json')
    config.add_view(lfs_objects_oid_download, route_name='lfs_objects_oid',
                    request_method='GET', renderer='json')

    # verification API
    config.add_route('lfs_objects_verify',
                     '/{repo:.*?[^/]}/info/lfs/verify')
    config.add_view(lfs_objects_verify, route_name='lfs_objects_verify',
                    request_method='POST', renderer='json')

    # not found handler for API
    config.add_notfound_view(not_found, renderer='json')


def create_app(git_lfs_enabled, git_lfs_store_path):
    config = Configurator()
    if git_lfs_enabled:
        config.include(git_lfs_app)
        config.registry.git_lfs_store_path = git_lfs_store_path
    else:
        # not found handler for API, reporting disabled LFS support
        config.add_notfound_view(lfs_disabled, renderer='json')

    app = config.make_wsgi_app()
    return app
