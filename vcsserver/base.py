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

import sys
import traceback
import logging
import urlparse

from vcsserver.lib.rc_cache import region_meta
log = logging.getLogger(__name__)


class RepoFactory(object):
    """
    Utility to create instances of repository

    It provides internal caching of the `repo` object based on
    the :term:`call context`.
    """
    repo_type = None

    def __init__(self):
        self._cache_region = region_meta.dogpile_cache_regions['repo_object']

    def _create_config(self, path, config):
        config = {}
        return config

    def _create_repo(self, wire, create):
        raise NotImplementedError()

    def repo(self, wire, create=False):
        raise NotImplementedError()


def obfuscate_qs(query_string):
    if query_string is None:
        return None

    parsed = []
    for k, v in urlparse.parse_qsl(query_string, keep_blank_values=True):
        if k in ['auth_token', 'api_key']:
            v = "*****"
        parsed.append((k, v))

    return '&'.join('{}{}'.format(
        k, '={}'.format(v) if v else '') for k, v in parsed)


def raise_from_original(new_type):
    """
    Raise a new exception type with original args and traceback.
    """
    exc_type, exc_value, exc_traceback = sys.exc_info()
    new_exc = new_type(*exc_value.args)
    # store the original traceback into the new exc
    new_exc._org_exc_tb = traceback.format_exc(exc_traceback)

    try:
        raise new_exc, None, exc_traceback
    finally:
        del exc_traceback
