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

import os
import shutil
import logging
from collections import OrderedDict

log = logging.getLogger(__name__)


class OidHandler(object):

    def __init__(self, store, repo_name, auth, oid, obj_size, obj_data, obj_href,
                 obj_verify_href=None):
        self.current_store = store
        self.repo_name = repo_name
        self.auth = auth
        self.oid = oid
        self.obj_size = obj_size
        self.obj_data = obj_data
        self.obj_href = obj_href
        self.obj_verify_href = obj_verify_href

    def get_store(self, mode=None):
        return self.current_store

    def get_auth(self):
        """returns auth header for re-use in upload/download"""
        return " ".join(self.auth)

    def download(self):

        store = self.get_store()
        response = None
        has_errors = None

        if not store.has_oid():
            # error reply back to client that something is wrong with dl
            err_msg = 'object: {} does not exist in store'.format(store.oid)
            has_errors = OrderedDict(
                error=OrderedDict(
                    code=404,
                    message=err_msg
                )
            )

        download_action = OrderedDict(
            href=self.obj_href,
            header=OrderedDict([("Authorization", self.get_auth())])
        )
        if not has_errors:
            response = OrderedDict(download=download_action)
        return response, has_errors

    def upload(self, skip_existing=True):
        """
        Write upload action for git-lfs server
        """

        store = self.get_store()
        response = None
        has_errors = None

        # verify if we have the OID before, if we do, reply with empty
        if store.has_oid():
            log.debug('LFS: store already has oid %s', store.oid)
            if skip_existing:
                log.debug('LFS: skipping further action as oid is existing')
                return response, has_errors

        upload_action = OrderedDict(
            href=self.obj_href,
            header=OrderedDict([("Authorization", self.get_auth())])
        )
        if not has_errors:
            response = OrderedDict(upload=upload_action)
            # if specified in handler, return the verification endpoint
            if self.obj_verify_href:
                verify_action = OrderedDict(
                    href=self.obj_verify_href,
                    header=OrderedDict([("Authorization", self.get_auth())])
                )
                response['verify'] = verify_action
        return response, has_errors

    def exec_operation(self, operation, *args, **kwargs):
        handler = getattr(self, operation)
        log.debug('LFS: handling request using %s handler', handler)
        return handler(*args, **kwargs)


class LFSOidStore(object):

    def __init__(self, oid, repo, store_location=None):
        self.oid = oid
        self.repo = repo
        self.store_path = store_location or self.get_default_store()
        self.tmp_oid_path = os.path.join(self.store_path, oid + '.tmp')
        self.oid_path = os.path.join(self.store_path, oid)
        self.fd = None

    def get_engine(self, mode):
        """
        engine = .get_engine(mode='wb')
        with engine as f:
            f.write('...')
        """

        class StoreEngine(object):
            def __init__(self, mode, store_path, oid_path, tmp_oid_path):
                self.mode = mode
                self.store_path = store_path
                self.oid_path = oid_path
                self.tmp_oid_path = tmp_oid_path

            def __enter__(self):
                if not os.path.isdir(self.store_path):
                    os.makedirs(self.store_path)

                # TODO(marcink): maybe write metadata here with size/oid ?
                fd = open(self.tmp_oid_path, self.mode)
                self.fd = fd
                return fd

            def __exit__(self, exc_type, exc_value, traceback):
                # close tmp file, and rename to final destination
                self.fd.close()
                shutil.move(self.tmp_oid_path, self.oid_path)

        return StoreEngine(
            mode, self.store_path, self.oid_path, self.tmp_oid_path)

    def get_default_store(self):
        """
        Default store, consistent with defaults of Mercurial large files store
        which is /home/username/.cache/largefiles
        """
        user_home = os.path.expanduser("~")
        return os.path.join(user_home, '.cache', 'lfs-store')

    def has_oid(self):
        return os.path.exists(os.path.join(self.store_path, self.oid))

    def size_oid(self):
        size = -1

        if self.has_oid():
            oid = os.path.join(self.store_path, self.oid)
            size = os.stat(oid).st_size

        return size
