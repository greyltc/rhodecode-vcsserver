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

import time
import logging

import vcsserver
from vcsserver.utils import safe_str


log = logging.getLogger(__name__)


def get_access_path(request):
    environ = request.environ
    return environ.get('PATH_INFO')


def get_user_agent(environ):
    return environ.get('HTTP_USER_AGENT')


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
            total = end - start
            count = request.request_count()
            _ver_ = vcsserver.__version__
            log.info(
                'Req[%4s] IP: %s %s Request to %s time: %.4fs [%s], VCSServer %s',
                count, '127.0.0.1', request.environ.get('REQUEST_METHOD'),
                safe_str(get_access_path(request)), total, get_user_agent(request.environ), _ver_)

        return response


def includeme(config):
    config.add_tween(
        'vcsserver.tweens.request_wrapper.RequestWrapperTween',
    )
