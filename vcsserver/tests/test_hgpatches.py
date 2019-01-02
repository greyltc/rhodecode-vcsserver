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

import mock
import pytest

from vcsserver import hgcompat, hgpatches


LARGEFILES_CAPABILITY = 'largefiles=serve'


def test_patch_largefiles_capabilities_applies_patch(
        patched_capabilities):
    lfproto = hgcompat.largefiles.proto
    hgpatches.patch_largefiles_capabilities()
    assert lfproto._capabilities.func_name == '_dynamic_capabilities'


def test_dynamic_capabilities_uses_original_function_if_not_enabled(
        stub_repo, stub_proto, stub_ui, stub_extensions, patched_capabilities,
        orig_capabilities):
    dynamic_capabilities = hgpatches._dynamic_capabilities_wrapper(
        hgcompat.largefiles.proto, stub_extensions)

    caps = dynamic_capabilities(orig_capabilities, stub_repo, stub_proto)

    stub_extensions.assert_called_once_with(stub_ui)
    assert LARGEFILES_CAPABILITY not in caps


def test_dynamic_capabilities_ignores_updated_capabilities(
        stub_repo, stub_proto, stub_ui, stub_extensions, patched_capabilities,
        orig_capabilities):
    stub_extensions.return_value = [('largefiles', mock.Mock())]
    dynamic_capabilities = hgpatches._dynamic_capabilities_wrapper(
        hgcompat.largefiles.proto, stub_extensions)

    # This happens when the extension is loaded for the first time, important
    # to ensure that an updated function is correctly picked up.
    hgcompat.largefiles.proto._capabilities = mock.Mock(
        side_effect=Exception('Must not be called'))

    dynamic_capabilities(orig_capabilities, stub_repo, stub_proto)


def test_dynamic_capabilities_uses_largefiles_if_enabled(
        stub_repo, stub_proto, stub_ui, stub_extensions, patched_capabilities,
        orig_capabilities):
    stub_extensions.return_value = [('largefiles', mock.Mock())]

    dynamic_capabilities = hgpatches._dynamic_capabilities_wrapper(
        hgcompat.largefiles.proto, stub_extensions)

    caps = dynamic_capabilities(orig_capabilities, stub_repo, stub_proto)

    stub_extensions.assert_called_once_with(stub_ui)
    assert LARGEFILES_CAPABILITY in caps


def test_hgsubversion_import():
    from hgsubversion import svnrepo
    assert svnrepo


@pytest.fixture
def patched_capabilities(request):
    """
    Patch in `capabilitiesorig` and restore both capability functions.
    """
    lfproto = hgcompat.largefiles.proto
    orig_capabilities = lfproto._capabilities

    @request.addfinalizer
    def restore():
        lfproto._capabilities = orig_capabilities


@pytest.fixture
def stub_repo(stub_ui):
    repo = mock.Mock()
    repo.ui = stub_ui
    return repo


@pytest.fixture
def stub_proto(stub_ui):
    proto = mock.Mock()
    proto.ui = stub_ui
    return proto


@pytest.fixture
def orig_capabilities():
    from mercurial.wireprotov1server import wireprotocaps

    def _capabilities(repo, proto):
        return wireprotocaps
    return _capabilities


@pytest.fixture
def stub_ui():
    return hgcompat.ui.ui()


@pytest.fixture
def stub_extensions():
    extensions = mock.Mock(return_value=tuple())
    return extensions
