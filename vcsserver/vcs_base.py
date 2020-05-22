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


class RemoteBase(object):
    EMPTY_COMMIT = '0' * 40

    @property
    def region(self):
        return self._factory._cache_region

    def _cache_on(self, wire):
        context = wire.get('context', '')
        context_uid = '{}'.format(context)
        repo_id = wire.get('repo_id', '')
        cache = wire.get('cache', True)
        cache_on = context and cache
        return cache_on, context_uid, repo_id
