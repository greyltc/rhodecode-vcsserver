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
import pytest
from vcsserver.git_lfs.lib import OidHandler, LFSOidStore


@pytest.fixture()
def lfs_store(tmpdir):
    repo = 'test'
    oid = '123456789'
    store = LFSOidStore(oid=oid, repo=repo, store_location=str(tmpdir))
    return store


@pytest.fixture()
def oid_handler(lfs_store):
    store = lfs_store
    repo = store.repo
    oid = store.oid

    oid_handler = OidHandler(
        store=store, repo_name=repo, auth=('basic', 'xxxx'),
        oid=oid,
        obj_size='1024', obj_data={}, obj_href='http://localhost/handle_oid',
        obj_verify_href='http://localhost/verify')
    return oid_handler


class TestOidHandler(object):

    @pytest.mark.parametrize('exec_action', [
        'download',
        'upload',
    ])
    def test_exec_action(self, exec_action, oid_handler):
        handler = oid_handler.exec_operation(exec_action)
        assert handler

    def test_exec_action_undefined(self, oid_handler):
        with pytest.raises(AttributeError):
            oid_handler.exec_operation('wrong')

    def test_download_oid_not_existing(self, oid_handler):
        response, has_errors = oid_handler.exec_operation('download')

        assert response is None
        assert has_errors['error'] == {
            'code': 404,
            'message': 'object: 123456789 does not exist in store'}

    def test_download_oid(self, oid_handler):
        store = oid_handler.get_store()
        if not os.path.isdir(os.path.dirname(store.oid_path)):
            os.makedirs(os.path.dirname(store.oid_path))

        with open(store.oid_path, 'wb') as f:
            f.write('CONTENT')

        response, has_errors = oid_handler.exec_operation('download')

        assert has_errors is None
        assert response['download'] == {
            'header': {'Authorization': 'basic xxxx'},
            'href': 'http://localhost/handle_oid'
        }

    def test_upload_oid_that_exists(self, oid_handler):
        store = oid_handler.get_store()
        if not os.path.isdir(os.path.dirname(store.oid_path)):
            os.makedirs(os.path.dirname(store.oid_path))

        with open(store.oid_path, 'wb') as f:
            f.write('CONTENT')
        oid_handler.obj_size = 7
        response, has_errors = oid_handler.exec_operation('upload')
        assert has_errors is None
        assert response is None

    def test_upload_oid_that_exists_but_has_wrong_size(self, oid_handler):
        store = oid_handler.get_store()
        if not os.path.isdir(os.path.dirname(store.oid_path)):
            os.makedirs(os.path.dirname(store.oid_path))

        with open(store.oid_path, 'wb') as f:
            f.write('CONTENT')

        oid_handler.obj_size = 10240
        response, has_errors = oid_handler.exec_operation('upload')
        assert has_errors is None
        assert response['upload'] == {
            'header': {'Authorization': 'basic xxxx',
                       'Transfer-Encoding': 'chunked'},
            'href': 'http://localhost/handle_oid',
        }

    def test_upload_oid(self, oid_handler):
        response, has_errors = oid_handler.exec_operation('upload')
        assert has_errors is None
        assert response['upload'] == {
            'header': {'Authorization': 'basic xxxx',
                       'Transfer-Encoding': 'chunked'},
            'href': 'http://localhost/handle_oid'
        }


class TestLFSStore(object):
    def test_write_oid(self, lfs_store):
        oid_location = lfs_store.oid_path

        assert not os.path.isfile(oid_location)

        engine = lfs_store.get_engine(mode='wb')
        with engine as f:
            f.write('CONTENT')

        assert os.path.isfile(oid_location)

    def test_detect_has_oid(self, lfs_store):

        assert lfs_store.has_oid() is False
        engine = lfs_store.get_engine(mode='wb')
        with engine as f:
            f.write('CONTENT')

        assert lfs_store.has_oid() is True