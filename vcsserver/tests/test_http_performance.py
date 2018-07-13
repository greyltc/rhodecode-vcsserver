"""
Tests used to profile the HTTP based implementation.
"""

import pytest
import webtest

from vcsserver.http_main import main


@pytest.fixture
def vcs_app():
    stub_settings = {
        'dev.use_echo_app': 'true',
        'locale': 'en_US.UTF-8',
    }
    vcs_app = main({}, **stub_settings)
    app = webtest.TestApp(vcs_app)
    return app


@pytest.fixture(scope='module')
def data():
    one_kb = 'x' * 1024
    return one_kb * 1024 * 10


def test_http_app_streaming_with_data(data, repeat, vcs_app):
    app = vcs_app
    for x in xrange(repeat / 10):
        response = app.post('/stream/git/', params=data)
        assert response.status_code == 200


def test_http_app_streaming_no_data(repeat, vcs_app):
    app = vcs_app
    for x in xrange(repeat / 10):
        response = app.post('/stream/git/')
        assert response.status_code == 200
