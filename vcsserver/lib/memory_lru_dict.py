# -*- coding: utf-8 -*-

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


import logging

from repoze.lru import LRUCache

from vcsserver.utils import safe_str

log = logging.getLogger(__name__)


class LRUDict(LRUCache):
    """
    Wrapper to provide partial dict access
    """

    def __setitem__(self, key, value):
        return self.put(key, value)

    def __getitem__(self, key):
        return self.get(key)

    def __contains__(self, key):
        return bool(self.get(key))

    def __delitem__(self, key):
        del self.data[key]

    def keys(self):
        return self.data.keys()


class LRUDictDebug(LRUDict):
    """
    Wrapper to provide some debug options
    """
    def _report_keys(self):
        elems_cnt = '%s/%s' % (len(self.keys()), self.size)
        # trick for pformat print it more nicely
        fmt = '\n'
        for cnt, elem in enumerate(self.keys()):
            fmt += '%s - %s\n' % (cnt+1, safe_str(elem))
        log.debug('current LRU keys (%s):%s', elems_cnt, fmt)

    def __getitem__(self, key):
        self._report_keys()
        return self.get(key)
