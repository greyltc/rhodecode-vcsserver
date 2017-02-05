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

import mock
import pytest

from vcsserver import main
from vcsserver.base import obfuscate_qs


@mock.patch('vcsserver.main.VcsServerCommand', mock.Mock())
@mock.patch('vcsserver.hgpatches.patch_largefiles_capabilities')
def test_applies_largefiles_patch(patch_largefiles_capabilities):
    main.main([])
    patch_largefiles_capabilities.assert_called_once_with()


@mock.patch('vcsserver.main.VcsServerCommand', mock.Mock())
@mock.patch('vcsserver.main.MercurialFactory', None)
@mock.patch(
    'vcsserver.hgpatches.patch_largefiles_capabilities',
    mock.Mock(side_effect=Exception("Must not be called")))
def test_applies_largefiles_patch_only_if_mercurial_is_available():
    main.main([])


@pytest.mark.parametrize('given, expected', [
    ('bad', 'bad'),
    ('query&foo=bar', 'query&foo=bar'),
    ('equery&auth_token=bar', 'equery&auth_token=*****'),
    ('a;b;c;query&foo=bar&auth_token=secret',
     'a&b&c&query&foo=bar&auth_token=*****'),
    ('', ''),
    (None, None),
    ('foo=bar', 'foo=bar'),
    ('auth_token=secret', 'auth_token=*****'),
    ('auth_token=secret&api_key=secret2',
     'auth_token=*****&api_key=*****'),
    ('auth_token=secret&api_key=secret2&param=value',
     'auth_token=*****&api_key=*****&param=value'),
])
def test_obfuscate_qs(given, expected):
    assert expected == obfuscate_qs(given)
