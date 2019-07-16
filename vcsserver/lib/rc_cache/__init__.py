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

import logging
from dogpile.cache import register_backend

register_backend(
    "dogpile.cache.rc.memory_lru", "vcsserver.lib.rc_cache.backends",
    "LRUMemoryBackend")

register_backend(
    "dogpile.cache.rc.file_namespace", "vcsserver.lib.rc_cache.backends",
    "FileNamespaceBackend")

register_backend(
    "dogpile.cache.rc.redis", "vcsserver.lib.rc_cache.backends",
    "RedisPickleBackend")

register_backend(
    "dogpile.cache.rc.redis_msgpack", "vcsserver.lib.rc_cache.backends",
    "RedisMsgPackBackend")


log = logging.getLogger(__name__)

from . import region_meta
from .utils import (get_default_cache_settings, backend_key_generator, make_region)


def configure_dogpile_cache(settings):
    cache_dir = settings.get('cache_dir')
    if cache_dir:
        region_meta.dogpile_config_defaults['cache_dir'] = cache_dir

    rc_cache_data = get_default_cache_settings(settings, prefixes=['rc_cache.'])

    # inspect available namespaces
    avail_regions = set()
    for key in rc_cache_data.keys():
        namespace_name = key.split('.', 1)[0]
        avail_regions.add(namespace_name)
    log.debug('dogpile: found following cache regions: %s', avail_regions)

    # register them into namespace
    for region_name in avail_regions:
        new_region = make_region(
            name=region_name,
            function_key_generator=None
        )

        new_region.configure_from_config(settings, 'rc_cache.{}.'.format(region_name))
        new_region.function_key_generator = backend_key_generator(new_region.actual_backend)
        log.debug('dogpile: registering a new region %s[%s]', region_name, new_region.__dict__)
        region_meta.dogpile_cache_regions[region_name] = new_region


def includeme(config):
    configure_dogpile_cache(config.registry.settings)
