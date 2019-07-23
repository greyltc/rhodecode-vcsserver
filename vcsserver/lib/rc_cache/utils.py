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
from decorator import decorate

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

        def get_or_create_for_user_func(key_generator, user_func, *arg, **kw):

            if not condition:
                log.debug('Calling un-cached func:%s', user_func)
                return user_func(*arg, **kw)

            key = key_generator(*arg, **kw)

            timeout = expiration_time() if expiration_time_is_callable \
                else expiration_time

            log.debug('Calling cached fn:%s', user_func)
            return self.get_or_create(key, user_func, timeout, should_cache_fn, (arg, kw))

        def cache_decorator(user_func):
            if to_str is compat.string_type:
                # backwards compatible
                key_generator = function_key_generator(namespace, user_func)
            else:
                key_generator = function_key_generator(namespace, user_func, to_str=to_str)

            def refresh(*arg, **kw):
                """
                Like invalidate, but regenerates the value instead
                """
                key = key_generator(*arg, **kw)
                value = user_func(*arg, **kw)
                self.set(key, value)
                return value

            def invalidate(*arg, **kw):
                key = key_generator(*arg, **kw)
                self.delete(key)

            def set_(value, *arg, **kw):
                key = key_generator(*arg, **kw)
                self.set(key, value)

            def get(*arg, **kw):
                key = key_generator(*arg, **kw)
                return self.get(key)

            user_func.set = set_
            user_func.invalidate = invalidate
            user_func.get = get
            user_func.refresh = refresh
            user_func.key_generator = key_generator
            user_func.original = user_func

            # Use `decorate` to preserve the signature of :param:`user_func`.

            return decorate(user_func, functools.partial(
                get_or_create_for_user_func, key_generator))

        return cache_decorator


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


def backend_key_generator(backend):
    """
    Special wrapper that also sends over the backend to the key generator
    """
    def wrapper(namespace, fn):
        return key_generator(backend, namespace, fn)
    return wrapper


def key_generator(backend, namespace, fn):
    fname = fn.__name__

    def generate_key(*args):
        backend_prefix = getattr(backend, 'key_prefix', None) or 'backend_prefix'
        namespace_pref = namespace or 'default_namespace'
        arg_key = compute_key_from_params(*args)
        final_key = "{}:{}:{}_{}".format(backend_prefix, namespace_pref, fname, arg_key)

        return final_key

    return generate_key
