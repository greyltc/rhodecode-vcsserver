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

import contextlib
import io
import threading
from BaseHTTPServer import BaseHTTPRequestHandler
from SocketServer import TCPServer

import mercurial.ui
import mock
import pytest
import simplejson as json

from vcsserver import hooks


def get_hg_ui(extras=None):
    """Create a Config object with a valid RC_SCM_DATA entry."""
    extras = extras or {}
    required_extras = {
        'username': '',
        'repository': '',
        'locked_by': '',
        'scm': '',
        'make_lock': '',
        'action': '',
        'ip': '',
        'hooks_uri': 'fake_hooks_uri',
    }
    required_extras.update(extras)
    hg_ui = mercurial.ui.ui()
    hg_ui.setconfig('rhodecode', 'RC_SCM_DATA', json.dumps(required_extras))

    return hg_ui


def test_git_pre_receive_is_disabled():
    extras = {'hooks': ['pull']}
    response = hooks.git_pre_receive(None, None,
                                     {'RC_SCM_DATA': json.dumps(extras)})

    assert response == 0


def test_git_post_receive_is_disabled():
    extras = {'hooks': ['pull']}
    response = hooks.git_post_receive(None, '',
                                      {'RC_SCM_DATA': json.dumps(extras)})

    assert response == 0


def test_git_post_receive_calls_repo_size():
    extras = {'hooks': ['push', 'repo_size']}
    with mock.patch.object(hooks, '_call_hook') as call_hook_mock:
        hooks.git_post_receive(
            None, '', {'RC_SCM_DATA': json.dumps(extras)})
    extras.update({'commit_ids': []})
    expected_calls = [
        mock.call('repo_size', extras, mock.ANY),
        mock.call('post_push', extras, mock.ANY),
    ]
    assert call_hook_mock.call_args_list == expected_calls


def test_git_post_receive_does_not_call_disabled_repo_size():
    extras = {'hooks': ['push']}
    with mock.patch.object(hooks, '_call_hook') as call_hook_mock:
        hooks.git_post_receive(
            None, '', {'RC_SCM_DATA': json.dumps(extras)})
    extras.update({'commit_ids': []})
    expected_calls = [
        mock.call('post_push', extras, mock.ANY)
    ]
    assert call_hook_mock.call_args_list == expected_calls


def test_repo_size_exception_does_not_affect_git_post_receive():
    extras = {'hooks': ['push', 'repo_size']}
    status = 0

    def side_effect(name, *args, **kwargs):
        if name == 'repo_size':
            raise Exception('Fake exception')
        else:
            return status

    with mock.patch.object(hooks, '_call_hook') as call_hook_mock:
        call_hook_mock.side_effect = side_effect
        result = hooks.git_post_receive(
            None, '', {'RC_SCM_DATA': json.dumps(extras)})
    assert result == status


def test_git_pre_pull_is_disabled():
    assert hooks.git_pre_pull({'hooks': ['push']}) == hooks.HookResponse(0, '')


def test_git_post_pull_is_disabled():
    assert (
        hooks.git_post_pull({'hooks': ['push']}) == hooks.HookResponse(0, ''))


class TestGetHooksClient(object):

    def test_returns_http_client_when_protocol_matches(self):
        hooks_uri = 'localhost:8000'
        result = hooks._get_hooks_client({
            'hooks_uri': hooks_uri,
            'hooks_protocol': 'http'
        })
        assert isinstance(result, hooks.HooksHttpClient)
        assert result.hooks_uri == hooks_uri

    def test_returns_dummy_client_when_hooks_uri_not_specified(self):
        fake_module = mock.Mock()
        import_patcher = mock.patch.object(
            hooks.importlib, 'import_module', return_value=fake_module)
        fake_module_name = 'fake.module'
        with import_patcher as import_mock:
            result = hooks._get_hooks_client(
                {'hooks_module': fake_module_name})

        import_mock.assert_called_once_with(fake_module_name)
        assert isinstance(result, hooks.HooksDummyClient)
        assert result._hooks_module == fake_module


class TestHooksHttpClient(object):
    def test_init_sets_hooks_uri(self):
        uri = 'localhost:3000'
        client = hooks.HooksHttpClient(uri)
        assert client.hooks_uri == uri

    def test_serialize_returns_json_string(self):
        client = hooks.HooksHttpClient('localhost:3000')
        hook_name = 'test'
        extras = {
            'first': 1,
            'second': 'two'
        }
        result = client._serialize(hook_name, extras)
        expected_result = json.dumps({
            'method': hook_name,
            'extras': extras
        })
        assert result == expected_result

    def test_call_queries_http_server(self, http_mirror):
        client = hooks.HooksHttpClient(http_mirror.uri)
        hook_name = 'test'
        extras = {
            'first': 1,
            'second': 'two'
        }
        result = client(hook_name, extras)
        expected_result = {
            'method': hook_name,
            'extras': extras
        }
        assert result == expected_result


class TestHooksDummyClient(object):
    def test_init_imports_hooks_module(self):
        hooks_module_name = 'rhodecode.fake.module'
        hooks_module = mock.MagicMock()

        import_patcher = mock.patch.object(
            hooks.importlib, 'import_module', return_value=hooks_module)
        with import_patcher as import_mock:
            client = hooks.HooksDummyClient(hooks_module_name)
            import_mock.assert_called_once_with(hooks_module_name)
        assert client._hooks_module == hooks_module

    def test_call_returns_hook_result(self):
        hooks_module_name = 'rhodecode.fake.module'
        hooks_module = mock.MagicMock()
        import_patcher = mock.patch.object(
            hooks.importlib, 'import_module', return_value=hooks_module)
        with import_patcher:
            client = hooks.HooksDummyClient(hooks_module_name)

        result = client('post_push', {})
        hooks_module.Hooks.assert_called_once_with()
        assert result == hooks_module.Hooks().__enter__().post_push()


@pytest.fixture
def http_mirror(request):
    server = MirrorHttpServer()
    request.addfinalizer(server.stop)
    return server


class MirrorHttpHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers['Content-Length'])
        body = self.rfile.read(length).decode('utf-8')
        self.send_response(200)
        self.end_headers()
        self.wfile.write(body)


class MirrorHttpServer(object):
    ip_address = '127.0.0.1'
    port = 0

    def __init__(self):
        self._daemon = TCPServer((self.ip_address, 0), MirrorHttpHandler)
        _, self.port = self._daemon.server_address
        self._thread = threading.Thread(target=self._daemon.serve_forever)
        self._thread.daemon = True
        self._thread.start()

    def stop(self):
        self._daemon.shutdown()
        self._thread.join()
        self._daemon = None
        self._thread = None

    @property
    def uri(self):
        return '{}:{}'.format(self.ip_address, self.port)
