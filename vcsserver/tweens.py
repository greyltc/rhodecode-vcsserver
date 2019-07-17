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



import time
import logging


from vcsserver.utils import safe_str


log = logging.getLogger(__name__)


def get_access_path(request):
    environ = request.environ
    return environ.get('PATH_INFO')


class RequestWrapperTween(object):
    def __init__(self, handler, registry):
        self.handler = handler
        self.registry = registry

        # one-time configuration code goes here

    def __call__(self, request):
        start = time.time()
        try:
            response = self.handler(request)
        finally:
            end = time.time()

            log.info('IP: %s Request to path: `%s` time: %.4fs',
                     '127.0.0.1', safe_str(get_access_path(request)), end - start)

        return response


def includeme(config):
    config.add_tween(
        'vcsserver.tweens.RequestWrapperTween',
    )
