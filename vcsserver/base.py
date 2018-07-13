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
        """
        Get a repository instance for the given path.

        Uses internally the low level beaker API since the decorators introduce
        significant overhead.
        """
        region = self._cache_region
        context = wire.get('context', None)
        repo_path = wire.get('path', '')
        context_uid = '{}'.format(context)
        cache = wire.get('cache', True)
        cache_on = context and cache

        @region.conditional_cache_on_arguments(condition=cache_on)
        def create_new_repo(_repo_type, _repo_path, _context_uid):
            return self._create_repo(wire, create)

        repo = create_new_repo(self.repo_type, repo_path, context_uid)
        return repo


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

    traceback.format_exception(exc_type, exc_value, exc_traceback)

    try:
        raise new_type(*exc_value.args), None, exc_traceback
    finally:
        del exc_traceback
