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

import os
import pytest
from webtest.app import TestApp as WebObTestApp
import simplejson as json

from vcsserver.git_lfs.app import create_app


@pytest.fixture(scope='function')
def git_lfs_app(tmpdir):
    custom_app = WebObTestApp(create_app(
        git_lfs_enabled=True, git_lfs_store_path=str(tmpdir),
        git_lfs_http_scheme='http'))
    custom_app._store = str(tmpdir)
    return custom_app


@pytest.fixture(scope='function')
def git_lfs_https_app(tmpdir):
    custom_app = WebObTestApp(create_app(
        git_lfs_enabled=True, git_lfs_store_path=str(tmpdir),
        git_lfs_http_scheme='https'))
    custom_app._store = str(tmpdir)
    return custom_app


@pytest.fixture()
def http_auth():
    return {'HTTP_AUTHORIZATION': "Basic XXXXX"}


class TestLFSApplication(object):

    def test_app_wrong_path(self, git_lfs_app):
        git_lfs_app.get('/repo/info/lfs/xxx', status=404)

    def test_app_deprecated_endpoint(self, git_lfs_app):
        response = git_lfs_app.post('/repo/info/lfs/objects', status=501)
        assert response.status_code == 501
        assert json.loads(response.text) == {u'message': u'LFS: v1 api not supported'}

    def test_app_lock_verify_api_not_available(self, git_lfs_app):
        response = git_lfs_app.post('/repo/info/lfs/locks/verify', status=501)
        assert response.status_code == 501
        assert json.loads(response.text) == {
            u'message': u'GIT LFS locking api not supported'}

    def test_app_lock_api_not_available(self, git_lfs_app):
        response = git_lfs_app.post('/repo/info/lfs/locks', status=501)
        assert response.status_code == 501
        assert json.loads(response.text) == {
            u'message': u'GIT LFS locking api not supported'}

    def test_app_batch_api_missing_auth(self, git_lfs_app):
        git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params={}, status=403)

    def test_app_batch_api_unsupported_operation(self, git_lfs_app, http_auth):
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params={}, status=400,
            extra_environ=http_auth)
        assert json.loads(response.text) == {
            u'message': u'unsupported operation mode: `None`'}

    def test_app_batch_api_missing_objects(self, git_lfs_app, http_auth):
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params={'operation': 'download'},
            status=400, extra_environ=http_auth)
        assert json.loads(response.text) == {
            u'message': u'missing objects data'}

    def test_app_batch_api_unsupported_data_in_objects(
            self, git_lfs_app, http_auth):
        params = {'operation': 'download',
                  'objects': [{}]}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params=params, status=400,
            extra_environ=http_auth)
        assert json.loads(response.text) == {
            u'message': u'unsupported data in objects'}

    def test_app_batch_api_download_missing_object(
            self, git_lfs_app, http_auth):
        params = {'operation': 'download',
                  'objects': [{'oid': '123', 'size': '1024'}]}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params=params,
            extra_environ=http_auth)

        expected_objects = [
            {u'authenticated': True,
             u'errors': {u'error': {
                 u'code': 404,
                 u'message': u'object: 123 does not exist in store'}},
             u'oid': u'123',
             u'size': u'1024'}
        ]
        assert json.loads(response.text) == {
            'objects': expected_objects, 'transfer': 'basic'}

    def test_app_batch_api_download(self, git_lfs_app, http_auth):
        oid = '456'
        oid_path = os.path.join(git_lfs_app._store, oid)
        if not os.path.isdir(os.path.dirname(oid_path)):
            os.makedirs(os.path.dirname(oid_path))
        with open(oid_path, 'wb') as f:
            f.write('OID_CONTENT')

        params = {'operation': 'download',
                  'objects': [{'oid': oid, 'size': '1024'}]}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params=params,
            extra_environ=http_auth)

        expected_objects = [
            {u'authenticated': True,
             u'actions': {
                 u'download': {
                     u'header': {u'Authorization': u'Basic XXXXX'},
                     u'href': u'http://localhost/repo/info/lfs/objects/456'},
             },
             u'oid': u'456',
             u'size': u'1024'}
        ]
        assert json.loads(response.text) == {
            'objects': expected_objects, 'transfer': 'basic'}

    def test_app_batch_api_upload(self, git_lfs_app, http_auth):
        params = {'operation': 'upload',
                  'objects': [{'oid': '123', 'size': '1024'}]}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/objects/batch', params=params,
            extra_environ=http_auth)
        expected_objects = [
            {u'authenticated': True,
             u'actions': {
                 u'upload': {
                     u'header': {u'Authorization': u'Basic XXXXX',
                                 u'Transfer-Encoding': u'chunked'},
                     u'href': u'http://localhost/repo/info/lfs/objects/123'},
                 u'verify': {
                     u'header': {u'Authorization': u'Basic XXXXX'},
                     u'href': u'http://localhost/repo/info/lfs/verify'}
             },
             u'oid': u'123',
             u'size': u'1024'}
        ]
        assert json.loads(response.text) == {
            'objects': expected_objects, 'transfer': 'basic'}

    def test_app_batch_api_upload_for_https(self, git_lfs_https_app, http_auth):
        params = {'operation': 'upload',
                  'objects': [{'oid': '123', 'size': '1024'}]}
        response = git_lfs_https_app.post_json(
            '/repo/info/lfs/objects/batch', params=params,
            extra_environ=http_auth)
        expected_objects = [
            {u'authenticated': True,
             u'actions': {
                 u'upload': {
                     u'header': {u'Authorization': u'Basic XXXXX',
                                 u'Transfer-Encoding': u'chunked'},
                     u'href': u'https://localhost/repo/info/lfs/objects/123'},
                 u'verify': {
                     u'header': {u'Authorization': u'Basic XXXXX'},
                     u'href': u'https://localhost/repo/info/lfs/verify'}
             },
             u'oid': u'123',
             u'size': u'1024'}
        ]
        assert json.loads(response.text) == {
            'objects': expected_objects, 'transfer': 'basic'}

    def test_app_verify_api_missing_data(self, git_lfs_app):
        params = {'oid': 'missing'}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/verify', params=params,
            status=400)

        assert json.loads(response.text) == {
            u'message': u'missing oid and size in request data'}

    def test_app_verify_api_missing_obj(self, git_lfs_app):
        params = {'oid': 'missing', 'size': '1024'}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/verify', params=params,
            status=404)

        assert json.loads(response.text) == {
            u'message': u'oid `missing` does not exists in store'}

    def test_app_verify_api_size_mismatch(self, git_lfs_app):
        oid = 'existing'
        oid_path = os.path.join(git_lfs_app._store, oid)
        if not os.path.isdir(os.path.dirname(oid_path)):
            os.makedirs(os.path.dirname(oid_path))
        with open(oid_path, 'wb') as f:
            f.write('OID_CONTENT')

        params = {'oid': oid, 'size': '1024'}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/verify', params=params, status=422)

        assert json.loads(response.text) == {
            u'message': u'requested file size mismatch '
                        u'store size:11 requested:1024'}

    def test_app_verify_api(self, git_lfs_app):
        oid = 'existing'
        oid_path = os.path.join(git_lfs_app._store, oid)
        if not os.path.isdir(os.path.dirname(oid_path)):
            os.makedirs(os.path.dirname(oid_path))
        with open(oid_path, 'wb') as f:
            f.write('OID_CONTENT')

        params = {'oid': oid, 'size': 11}
        response = git_lfs_app.post_json(
            '/repo/info/lfs/verify', params=params)

        assert json.loads(response.text) == {
            u'message': {u'size': u'ok', u'in_store': u'ok'}}

    def test_app_download_api_oid_not_existing(self, git_lfs_app):
        oid = 'missing'

        response = git_lfs_app.get(
            '/repo/info/lfs/objects/{oid}'.format(oid=oid), status=404)

        assert json.loads(response.text) == {
            u'message': u'requested file with oid `missing` not found in store'}

    def test_app_download_api(self, git_lfs_app):
        oid = 'existing'
        oid_path = os.path.join(git_lfs_app._store, oid)
        if not os.path.isdir(os.path.dirname(oid_path)):
            os.makedirs(os.path.dirname(oid_path))
        with open(oid_path, 'wb') as f:
            f.write('OID_CONTENT')

        response = git_lfs_app.get(
            '/repo/info/lfs/objects/{oid}'.format(oid=oid))
        assert response

    def test_app_upload(self, git_lfs_app):
        oid = 'uploaded'

        response = git_lfs_app.put(
            '/repo/info/lfs/objects/{oid}'.format(oid=oid), params='CONTENT')

        assert json.loads(response.text) == {u'upload': u'ok'}

        # verify that we actually wrote that OID
        oid_path = os.path.join(git_lfs_app._store, oid)
        assert os.path.isfile(oid_path)
        assert 'CONTENT' == open(oid_path).read()
