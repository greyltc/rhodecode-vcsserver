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
import logging
import functools

from dogpile.cache import CacheRegion
from dogpile.cache.util import compat

from vcsserver.utils import safe_str, sha1


log = logging.getLogger(__name__)


class RhodeCodeCacheRegion(CacheRegion):

    def conditional_cache_on_arguments(
            self, namespace=None,
            expiration_time=None,
            should_cache_fn=None,
            to_str=compat.string_type,
            function_key_generator=None,
            condition=True):
        """
        Custom conditional decorator, that will not touch any dogpile internals if
        condition isn't meet. This works a bit different than should_cache_fn
        And it's faster in cases we don't ever want to compute cached values
        """
        expiration_time_is_callable = compat.callable(expiration_time)

        if function_key_generator is None:
            function_key_generator = self.function_key_generator

        def decorator(fn):
            if to_str is compat.string_type:
                # backwards compatible
                key_generator = function_key_generator(namespace, fn)
            else:
                key_generator = function_key_generator(namespace, fn, to_str=to_str)

            @functools.wraps(fn)
            def decorate(*arg, **kw):
                key = key_generator(*arg, **kw)

                @functools.wraps(fn)
                def creator():
                    return fn(*arg, **kw)

                if not condition:
                    return creator()

                timeout = expiration_time() if expiration_time_is_callable \
                    else expiration_time

                return self.get_or_create(key, creator, timeout, should_cache_fn)

            def invalidate(*arg, **kw):
                key = key_generator(*arg, **kw)
                self.delete(key)

            def set_(value, *arg, **kw):
                key = key_generator(*arg, **kw)
                self.set(key, value)

            def get(*arg, **kw):
                key = key_generator(*arg, **kw)
                return self.get(key)

            def refresh(*arg, **kw):
                key = key_generator(*arg, **kw)
                value = fn(*arg, **kw)
                self.set(key, value)
                return value

            decorate.set = set_
            decorate.invalidate = invalidate
            decorate.refresh = refresh
            decorate.get = get
            decorate.original = fn
            decorate.key_generator = key_generator
            decorate.__wrapped__ = fn

            return decorate

        return decorator


def make_region(*arg, **kw):
    return RhodeCodeCacheRegion(*arg, **kw)


def get_default_cache_settings(settings, prefixes=None):
    prefixes = prefixes or []
    cache_settings = {}
    for key in settings.keys():
        for prefix in prefixes:
            if key.startswith(prefix):
                name = key.split(prefix)[1].strip()
                val = settings[key]
                if isinstance(val, compat.string_types):
                    val = val.strip()
                cache_settings[name] = val
    return cache_settings


def compute_key_from_params(*args):
    """
    Helper to compute key from given params to be used in cache manager
    """
    return sha1("_".join(map(safe_str, args)))


def key_generator(namespace, fn):
    fname = fn.__name__

    def generate_key(*args):
        namespace_pref = namespace or 'default'
        arg_key = compute_key_from_params(*args)
        final_key = "{}:{}_{}".format(namespace_pref, fname, arg_key)

        return final_key

    return generate_key
