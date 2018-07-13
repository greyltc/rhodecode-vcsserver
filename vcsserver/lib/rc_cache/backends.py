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

import logging

from dogpile.cache.backends import memory as memory_backend
from lru import LRU as LRUDict


_default_max_size = 1024

log = logging.getLogger(__name__)


class LRUMemoryBackend(memory_backend.MemoryBackend):
    pickle_values = False

    def __init__(self, arguments):
        max_size = arguments.pop('max_size', _default_max_size)
        callback = None
        if arguments.pop('log_max_size_reached', None):
            def evicted(key, value):
                log.debug(
                    'LRU: evicting key `%s` due to max size %s reach', key, max_size)
            callback = evicted

        arguments['cache_dict'] = LRUDict(max_size, callback=callback)
        super(LRUMemoryBackend, self).__init__(arguments)

    def delete(self, key):
        if self._cache.has_key(key):
            del self._cache[key]

    def delete_multi(self, keys):
        for key in keys:
            if self._cache.has_key(key):
                del self._cache[key]
