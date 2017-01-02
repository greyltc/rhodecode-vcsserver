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

import logging
import urlparse

log = logging.getLogger(__name__)


class RepoFactory(object):
    """
    Utility to create instances of repository

    It provides internal caching of the `repo` object based on
    the :term:`call context`.
    """

    def __init__(self, repo_cache):
        self._cache = repo_cache

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
        def create_new_repo():
            return self._create_repo(wire, create)

        return self._repo(wire, create_new_repo)

    def _repo(self, wire, createfunc):
        context = wire.get('context', None)
        cache = wire.get('cache', True)

        if context and cache:
            cache_key = (context, wire['path'])
            log.debug(
                'FETCH %s@%s repo object from cache. Context: %s',
                self.__class__.__name__, wire['path'], context)
            return self._cache.get(key=cache_key, createfunc=createfunc)
        else:
            log.debug(
                'INIT %s@%s repo object based on wire %s. Context: %s',
                self.__class__.__name__, wire['path'], wire, context)
            return createfunc()


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
