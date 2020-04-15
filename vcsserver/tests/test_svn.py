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

import io
import mock
import pytest
import sys


class MockPopen(object):
    def __init__(self, stderr):
        self.stdout = io.BytesIO('')
        self.stderr = io.BytesIO(stderr)
        self.returncode = 1

    def wait(self):
        pass


INVALID_CERTIFICATE_STDERR = '\n'.join([
    'svnrdump: E230001: Unable to connect to a repository at URL url',
    'svnrdump: E230001: Server SSL certificate verification failed: issuer is not trusted',
])


@pytest.mark.parametrize('stderr,expected_reason', [
    (INVALID_CERTIFICATE_STDERR, 'INVALID_CERTIFICATE'),
    ('svnrdump: E123456', 'UNKNOWN:svnrdump: E123456'),
], ids=['invalid-cert-stderr', 'svnrdump-err-123456'])
@pytest.mark.xfail(sys.platform == "cygwin",
                   reason="SVN not packaged for Cygwin")
def test_import_remote_repository_certificate_error(stderr, expected_reason):
    from vcsserver import svn
    factory = mock.Mock()
    factory.repo = mock.Mock(return_value=mock.Mock())

    remote = svn.SvnRemote(factory)
    remote.is_path_valid_repository = lambda wire, path: True

    with mock.patch('subprocess.Popen',
                    return_value=MockPopen(stderr)):
        with pytest.raises(Exception) as excinfo:
            remote.import_remote_repository({'path': 'path'}, 'url')

    expected_error_args = (
        'Failed to dump the remote repository from url. Reason:{}'.format(expected_reason),)

    assert excinfo.value.args == expected_error_args


def test_svn_libraries_can_be_imported():
    import svn
    import svn.client
    assert svn.client is not None


@pytest.mark.parametrize('example_url, parts', [
    ('http://server.com', (None, None, 'http://server.com')),
    ('http://user@server.com', ('user', None, 'http://user@server.com')),
    ('http://user:pass@server.com', ('user', 'pass', 'http://user:pass@server.com')),
    ('<script>', (None, None, '<script>')),
    ('http://', (None, None, 'http://')),
])
def test_username_password_extraction_from_url(example_url, parts):
    from vcsserver import svn

    factory = mock.Mock()
    factory.repo = mock.Mock(return_value=mock.Mock())

    remote = svn.SvnRemote(factory)
    remote.is_path_valid_repository = lambda wire, path: True

    assert remote.get_url_and_credentials(example_url) == parts
