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
import copy
from functools import wraps


def get_cython_compat_decorator(wrapper, func):
    """
    Creates a cython compatible decorator. The previously used
    decorator.decorator() function seems to be incompatible with cython.

    :param wrapper: __wrapper method of the decorator class
    :param func: decorated function
    """
    @wraps(func)
    def local_wrapper(*args, **kwds):
        return wrapper(func, *args, **kwds)
    local_wrapper.__wrapped__ = func
    return local_wrapper


def safe_result(result):
    """clean result for better representation in logs"""
    clean_copy = copy.deepcopy(result)

    try:
        if 'objects' in clean_copy:
            for oid_data in clean_copy['objects']:
                if 'actions' in oid_data:
                    for action_name, data in oid_data['actions'].items():
                        if 'header' in data:
                            data['header'] = {'Authorization': '*****'}
    except Exception:
        return result

    return clean_copy
