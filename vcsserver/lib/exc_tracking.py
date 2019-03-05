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


import os
import time
import datetime
import msgpack
import logging
import traceback
import tempfile

from pyramid import compat

log = logging.getLogger(__name__)

# NOTE: Any changes should be synced with exc_tracking at rhodecode.lib.exc_tracking
global_prefix = 'vcsserver'
exc_store_dir_name = 'rc_exception_store_v1'


def exc_serialize(exc_id, tb, exc_type):

    data = {
        'version': 'v1',
        'exc_id': exc_id,
        'exc_utc_date': datetime.datetime.utcnow().isoformat(),
        'exc_timestamp': repr(time.time()),
        'exc_message': tb,
        'exc_type': exc_type,
    }
    return msgpack.packb(data), data


def exc_unserialize(tb):
    return msgpack.unpackb(tb)


def get_exc_store():
    """
    Get and create exception store if it's not existing
    """
    import vcsserver as app

    exc_store_dir = app.CONFIG.get('exception_tracker.store_path', '') or tempfile.gettempdir()
    _exc_store_path = os.path.join(exc_store_dir, exc_store_dir_name)

    _exc_store_path = os.path.abspath(_exc_store_path)
    if not os.path.isdir(_exc_store_path):
        os.makedirs(_exc_store_path)
        log.debug('Initializing exceptions store at %s', _exc_store_path)
    return _exc_store_path


def _store_exception(exc_id, exc_info, prefix):
    exc_type, exc_value, exc_traceback = exc_info

    tb = ''.join(traceback.format_exception(
        exc_type, exc_value, exc_traceback, None))

    detailed_tb = getattr(exc_value, '_org_exc_tb', None)

    if detailed_tb:
        if isinstance(detailed_tb, compat.string_types):
            remote_tb = [detailed_tb]

        tb += (
            '\n+++ BEG SOURCE EXCEPTION +++\n\n'
            '{}\n'
            '+++ END SOURCE EXCEPTION +++\n'
            ''.format('\n'.join(remote_tb))
        )

        # Avoid that remote_tb also appears in the frame
        del remote_tb

    exc_type_name = exc_type.__name__
    exc_store_path = get_exc_store()
    exc_data, org_data = exc_serialize(exc_id, tb, exc_type_name)
    exc_pref_id = '{}_{}_{}'.format(exc_id, prefix, org_data['exc_timestamp'])
    if not os.path.isdir(exc_store_path):
        os.makedirs(exc_store_path)
    stored_exc_path = os.path.join(exc_store_path, exc_pref_id)
    with open(stored_exc_path, 'wb') as f:
        f.write(exc_data)
    log.debug('Stored generated exception %s as: %s', exc_id, stored_exc_path)


def store_exception(exc_id, exc_info, prefix=global_prefix):
    """
    Example usage::

        exc_info = sys.exc_info()
        store_exception(id(exc_info), exc_info)
    """

    try:
        _store_exception(exc_id=exc_id, exc_info=exc_info, prefix=prefix)
    except Exception:
        log.exception('Failed to store exception `%s` information', exc_id)
        # there's no way this can fail, it will crash server badly if it does.
        pass


def _find_exc_file(exc_id, prefix=global_prefix):
    exc_store_path = get_exc_store()
    if prefix:
        exc_id = '{}_{}'.format(exc_id, prefix)
    else:
        # search without a prefix
        exc_id = '{}'.format(exc_id)

    # we need to search the store for such start pattern as above
    for fname in os.listdir(exc_store_path):
        if fname.startswith(exc_id):
            exc_id = os.path.join(exc_store_path, fname)
            break
        continue
    else:
        exc_id = None

    return exc_id


def _read_exception(exc_id, prefix):
    exc_id_file_path = _find_exc_file(exc_id=exc_id, prefix=prefix)
    if exc_id_file_path:
        with open(exc_id_file_path, 'rb') as f:
            return exc_unserialize(f.read())
    else:
        log.debug('Exception File `%s` not found', exc_id_file_path)
    return None


def read_exception(exc_id, prefix=global_prefix):
    try:
        return _read_exception(exc_id=exc_id, prefix=prefix)
    except Exception:
        log.exception('Failed to read exception `%s` information', exc_id)
        # there's no way this can fail, it will crash server badly if it does.
    return None


def delete_exception(exc_id, prefix=global_prefix):
    try:
        exc_id_file_path = _find_exc_file(exc_id, prefix=prefix)
        if exc_id_file_path:
            os.remove(exc_id_file_path)

    except Exception:
        log.exception('Failed to remove exception `%s` information', exc_id)
        # there's no way this can fail, it will crash server badly if it does.
        pass
