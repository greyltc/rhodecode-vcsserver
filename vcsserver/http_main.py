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
import sys
import base64
import locale
import logging
import uuid
import wsgiref.util
import traceback
import tempfile
from itertools import chain

import simplejson as json
import msgpack
from pyramid.config import Configurator
from pyramid.settings import asbool, aslist
from pyramid.wsgi import wsgiapp
from pyramid.compat import configparser


log = logging.getLogger(__name__)

# due to Mercurial/glibc2.27 problems we need to detect if locale settings are
# causing problems and "fix" it in case they do and fallback to LC_ALL = C

try:
    locale.setlocale(locale.LC_ALL, '')
except locale.Error as e:
    log.error(
        'LOCALE ERROR: failed to set LC_ALL, fallback to LC_ALL=C, org error: %s', e)
    os.environ['LC_ALL'] = 'C'

import vcsserver
from vcsserver import remote_wsgi, scm_app, settings, hgpatches
from vcsserver.git_lfs.app import GIT_LFS_CONTENT_TYPE, GIT_LFS_PROTO_PAT
from vcsserver.echo_stub import remote_wsgi as remote_wsgi_stub
from vcsserver.echo_stub.echo_app import EchoApp
from vcsserver.exceptions import HTTPRepoLocked, HTTPRepoBranchProtected
from vcsserver.lib.exc_tracking import store_exception
from vcsserver.server import VcsServer

try:
    from vcsserver.git import GitFactory, GitRemote
except ImportError:
    GitFactory = None
    GitRemote = None

try:
    from vcsserver.hg import MercurialFactory, HgRemote
except ImportError:
    MercurialFactory = None
    HgRemote = None

try:
    from vcsserver.svn import SubversionFactory, SvnRemote
except ImportError:
    SubversionFactory = None
    SvnRemote = None


def _is_request_chunked(environ):
    stream = environ.get('HTTP_TRANSFER_ENCODING', '') == 'chunked'
    return stream


def _int_setting(settings, name, default):
    settings[name] = int(settings.get(name, default))
    return settings[name]


def _bool_setting(settings, name, default):
    input_val = settings.get(name, default)
    if isinstance(input_val, unicode):
        input_val = input_val.encode('utf8')
    settings[name] = asbool(input_val)
    return settings[name]


def _list_setting(settings, name, default):
    raw_value = settings.get(name, default)

    # Otherwise we assume it uses pyramids space/newline separation.
    settings[name] = aslist(raw_value)
    return settings[name]


def _string_setting(settings, name, default, lower=True, default_when_empty=False):
    value = settings.get(name, default)

    if default_when_empty and not value:
        # use default value when value is empty
        value = default

    if lower:
        value = value.lower()
    settings[name] = value
    return settings[name]


class VCS(object):
    def __init__(self, locale=None, cache_config=None):
        self.locale = locale
        self.cache_config = cache_config
        self._configure_locale()

        if GitFactory and GitRemote:
            git_factory = GitFactory()
            self._git_remote = GitRemote(git_factory)
        else:
            log.info("Git client import failed")

        if MercurialFactory and HgRemote:
            hg_factory = MercurialFactory()
            self._hg_remote = HgRemote(hg_factory)
        else:
            log.info("Mercurial client import failed")

        if SubversionFactory and SvnRemote:
            svn_factory = SubversionFactory()

            # hg factory is used for svn url validation
            hg_factory = MercurialFactory()
            self._svn_remote = SvnRemote(svn_factory, hg_factory=hg_factory)
        else:
            log.info("Subversion client import failed")

        self._vcsserver = VcsServer()

    def _configure_locale(self):
        if self.locale:
            log.info('Settings locale: `LC_ALL` to %s', self.locale)
        else:
            log.info(
                'Configuring locale subsystem based on environment variables')
        try:
            # If self.locale is the empty string, then the locale
            # module will use the environment variables. See the
            # documentation of the package `locale`.
            locale.setlocale(locale.LC_ALL, self.locale)

            language_code, encoding = locale.getlocale()
            log.info(
                'Locale set to language code "%s" with encoding "%s".',
                language_code, encoding)
        except locale.Error:
            log.exception(
                'Cannot set locale, not configuring the locale system')


class WsgiProxy(object):
    def __init__(self, wsgi):
        self.wsgi = wsgi

    def __call__(self, environ, start_response):
        input_data = environ['wsgi.input'].read()
        input_data = msgpack.unpackb(input_data)

        error = None
        try:
            data, status, headers = self.wsgi.handle(
                input_data['environment'], input_data['input_data'],
                *input_data['args'], **input_data['kwargs'])
        except Exception as e:
            data, status, headers = [], None, None
            error = {
                'message': str(e),
                '_vcs_kind': getattr(e, '_vcs_kind', None)
            }

        start_response(200, {})
        return self._iterator(error, status, headers, data)

    def _iterator(self, error, status, headers, data):
        initial_data = [
            error,
            status,
            headers,
        ]

        for d in chain(initial_data, data):
            yield msgpack.packb(d)


def not_found(request):
    return {'status': '404 NOT FOUND'}


class VCSViewPredicate(object):
    def __init__(self, val, config):
        self.remotes = val

    def text(self):
        return 'vcs view method = %s' % (self.remotes.keys(),)

    phash = text

    def __call__(self, context, request):
        """
        View predicate that returns true if given backend is supported by
        defined remotes.
        """
        backend = request.matchdict.get('backend')
        return backend in self.remotes


class HTTPApplication(object):
    ALLOWED_EXCEPTIONS = ('KeyError', 'URLError')

    remote_wsgi = remote_wsgi
    _use_echo_app = False

    def __init__(self, settings=None, global_config=None):
        self._sanitize_settings_and_apply_defaults(settings)

        self.config = Configurator(settings=settings)
        self.global_config = global_config
        self.config.include('vcsserver.lib.rc_cache')

        settings_locale = settings.get('locale', '') or 'en_US.UTF-8'
        vcs = VCS(locale=settings_locale, cache_config=settings)
        self._remotes = {
            'hg': vcs._hg_remote,
            'git': vcs._git_remote,
            'svn': vcs._svn_remote,
            'server': vcs._vcsserver,
        }
        if settings.get('dev.use_echo_app', 'false').lower() == 'true':
            self._use_echo_app = True
            log.warning("Using EchoApp for VCS operations.")
            self.remote_wsgi = remote_wsgi_stub

        self._configure_settings(global_config, settings)
        self._configure()

    def _configure_settings(self, global_config, app_settings):
        """
        Configure the settings module.
        """
        settings_merged = global_config.copy()
        settings_merged.update(app_settings)

        git_path = app_settings.get('git_path', None)
        if git_path:
            settings.GIT_EXECUTABLE = git_path
        binary_dir = app_settings.get('core.binary_dir', None)
        if binary_dir:
            settings.BINARY_DIR = binary_dir

        # Store the settings to make them available to other modules.
        vcsserver.PYRAMID_SETTINGS = settings_merged
        vcsserver.CONFIG = settings_merged

    def _sanitize_settings_and_apply_defaults(self, settings):
        temp_store = tempfile.gettempdir()
        default_cache_dir = os.path.join(temp_store, 'rc_cache')

        # save default, cache dir, and use it for all backends later.
        default_cache_dir = _string_setting(
            settings,
            'cache_dir',
            default_cache_dir, lower=False, default_when_empty=True)

        # ensure we have our dir created
        if not os.path.isdir(default_cache_dir):
            os.makedirs(default_cache_dir, mode=0o755)

        # exception store cache
        _string_setting(
            settings,
            'exception_tracker.store_path',
            temp_store, lower=False, default_when_empty=True)

        # repo_object cache
        _string_setting(
            settings,
            'rc_cache.repo_object.backend',
            'dogpile.cache.rc.memory_lru')
        _int_setting(
            settings,
            'rc_cache.repo_object.expiration_time',
            300)
        _int_setting(
            settings,
            'rc_cache.repo_object.max_size',
            1024)

    def _configure(self):
        self.config.add_renderer(name='msgpack', factory=self._msgpack_renderer_factory)

        self.config.add_route('service', '/_service')
        self.config.add_route('status', '/status')
        self.config.add_route('hg_proxy', '/proxy/hg')
        self.config.add_route('git_proxy', '/proxy/git')
        self.config.add_route('vcs', '/{backend}')
        self.config.add_route('stream_git', '/stream/git/*repo_name')
        self.config.add_route('stream_hg', '/stream/hg/*repo_name')

        self.config.add_view(self.status_view, route_name='status', renderer='json')
        self.config.add_view(self.service_view, route_name='service', renderer='msgpack')

        self.config.add_view(self.hg_proxy(), route_name='hg_proxy')
        self.config.add_view(self.git_proxy(), route_name='git_proxy')
        self.config.add_view(self.vcs_view, route_name='vcs', renderer='msgpack',
                             vcs_view=self._remotes)

        self.config.add_view(self.hg_stream(), route_name='stream_hg')
        self.config.add_view(self.git_stream(), route_name='stream_git')

        self.config.add_view_predicate('vcs_view', VCSViewPredicate)

        self.config.add_notfound_view(not_found, renderer='json')

        self.config.add_view(self.handle_vcs_exception, context=Exception)

        self.config.add_tween(
            'vcsserver.tweens.RequestWrapperTween',
        )

    def wsgi_app(self):
        return self.config.make_wsgi_app()

    def vcs_view(self, request):
        remote = self._remotes[request.matchdict['backend']]
        payload = msgpack.unpackb(request.body, use_list=True)
        method = payload.get('method')
        params = payload.get('params')
        wire = params.get('wire')
        args = params.get('args')
        kwargs = params.get('kwargs')
        context_uid = None

        if wire:
            try:
                wire['context'] = context_uid = uuid.UUID(wire['context'])
            except KeyError:
                pass
            args.insert(0, wire)

        # NOTE(marcink): trading complexity for slight performance
        if log.isEnabledFor(logging.DEBUG):
            no_args_methods = [
                'archive_repo'
            ]
            if method in no_args_methods:
                call_args = ''
            else:
                call_args = args[1:]
            log.debug('method called:%s with args:%s kwargs:%s context_uid: %s',
                      method, call_args, kwargs, context_uid)

        try:
            resp = getattr(remote, method)(*args, **kwargs)
        except Exception as e:
            exc_info = list(sys.exc_info())
            exc_type, exc_value, exc_traceback = exc_info

            org_exc = getattr(e, '_org_exc', None)
            org_exc_name = None
            org_exc_tb = ''
            if org_exc:
                org_exc_name = org_exc.__class__.__name__
                org_exc_tb = getattr(e, '_org_exc_tb', '')
                # replace our "faked" exception with our org
                exc_info[0] = org_exc.__class__
                exc_info[1] = org_exc

            store_exception(id(exc_info), exc_info)

            tb_info = ''.join(
                traceback.format_exception(exc_type, exc_value, exc_traceback))

            type_ = e.__class__.__name__
            if type_ not in self.ALLOWED_EXCEPTIONS:
                type_ = None

            resp = {
                'id': payload.get('id'),
                'error': {
                    'message': e.message,
                    'traceback': tb_info,
                    'org_exc': org_exc_name,
                    'org_exc_tb': org_exc_tb,
                    'type': type_
                }
            }
            try:
                resp['error']['_vcs_kind'] = getattr(e, '_vcs_kind', None)
            except AttributeError:
                pass
        else:
            resp = {
                'id': payload.get('id'),
                'result': resp
            }

        return resp

    def status_view(self, request):
        import vcsserver
        return {'status': 'OK', 'vcsserver_version': vcsserver.__version__,
                'pid': os.getpid()}

    def service_view(self, request):
        import vcsserver

        payload = msgpack.unpackb(request.body, use_list=True)

        try:
            path = self.global_config['__file__']
            config = configparser.ConfigParser()
            config.read(path)
            parsed_ini = config
            if parsed_ini.has_section('server:main'):
                parsed_ini = dict(parsed_ini.items('server:main'))
        except Exception:
            log.exception('Failed to read .ini file for display')
            parsed_ini = {}

        resp = {
            'id': payload.get('id'),
            'result': dict(
                version=vcsserver.__version__,
                config=parsed_ini,
                payload=payload,
            )
        }
        return resp

    def _msgpack_renderer_factory(self, info):
        def _render(value, system):
            request = system.get('request')
            if request is not None:
                response = request.response
                ct = response.content_type
                if ct == response.default_content_type:
                    response.content_type = 'application/x-msgpack'
            return msgpack.packb(value)
        return _render

    def set_env_from_config(self, environ, config):
        dict_conf = {}
        try:
            for elem in config:
                if elem[0] == 'rhodecode':
                    dict_conf = json.loads(elem[2])
                    break
        except Exception:
            log.exception('Failed to fetch SCM CONFIG')
            return

        username = dict_conf.get('username')
        if username:
            environ['REMOTE_USER'] = username
            # mercurial specific, some extension api rely on this
            environ['HGUSER'] = username

        ip = dict_conf.get('ip')
        if ip:
            environ['REMOTE_HOST'] = ip

        if _is_request_chunked(environ):
            # set the compatibility flag for webob
            environ['wsgi.input_terminated'] = True

    def hg_proxy(self):
        @wsgiapp
        def _hg_proxy(environ, start_response):
            app = WsgiProxy(self.remote_wsgi.HgRemoteWsgi())
            return app(environ, start_response)
        return _hg_proxy

    def git_proxy(self):
        @wsgiapp
        def _git_proxy(environ, start_response):
            app = WsgiProxy(self.remote_wsgi.GitRemoteWsgi())
            return app(environ, start_response)
        return _git_proxy

    def hg_stream(self):
        if self._use_echo_app:
            @wsgiapp
            def _hg_stream(environ, start_response):
                app = EchoApp('fake_path', 'fake_name', None)
                return app(environ, start_response)
            return _hg_stream
        else:
            @wsgiapp
            def _hg_stream(environ, start_response):
                log.debug('http-app: handling hg stream')
                repo_path = environ['HTTP_X_RC_REPO_PATH']
                repo_name = environ['HTTP_X_RC_REPO_NAME']
                packed_config = base64.b64decode(
                    environ['HTTP_X_RC_REPO_CONFIG'])
                config = msgpack.unpackb(packed_config)
                app = scm_app.create_hg_wsgi_app(
                    repo_path, repo_name, config)

                # Consistent path information for hgweb
                environ['PATH_INFO'] = environ['HTTP_X_RC_PATH_INFO']
                environ['REPO_NAME'] = repo_name
                self.set_env_from_config(environ, config)

                log.debug('http-app: starting app handler '
                          'with %s and process request', app)
                return app(environ, ResponseFilter(start_response))
            return _hg_stream

    def git_stream(self):
        if self._use_echo_app:
            @wsgiapp
            def _git_stream(environ, start_response):
                app = EchoApp('fake_path', 'fake_name', None)
                return app(environ, start_response)
            return _git_stream
        else:
            @wsgiapp
            def _git_stream(environ, start_response):
                log.debug('http-app: handling git stream')
                repo_path = environ['HTTP_X_RC_REPO_PATH']
                repo_name = environ['HTTP_X_RC_REPO_NAME']
                packed_config = base64.b64decode(
                    environ['HTTP_X_RC_REPO_CONFIG'])
                config = msgpack.unpackb(packed_config)

                environ['PATH_INFO'] = environ['HTTP_X_RC_PATH_INFO']
                self.set_env_from_config(environ, config)

                content_type = environ.get('CONTENT_TYPE', '')

                path = environ['PATH_INFO']
                is_lfs_request = GIT_LFS_CONTENT_TYPE in content_type
                log.debug(
                    'LFS: Detecting if request `%s` is LFS server path based '
                    'on content type:`%s`, is_lfs:%s',
                    path, content_type, is_lfs_request)

                if not is_lfs_request:
                    # fallback detection by path
                    if GIT_LFS_PROTO_PAT.match(path):
                        is_lfs_request = True
                    log.debug(
                        'LFS: fallback detection by path of: `%s`, is_lfs:%s',
                        path, is_lfs_request)

                if is_lfs_request:
                    app = scm_app.create_git_lfs_wsgi_app(
                        repo_path, repo_name, config)
                else:
                    app = scm_app.create_git_wsgi_app(
                        repo_path, repo_name, config)

                log.debug('http-app: starting app handler '
                          'with %s and process request', app)

                return app(environ, start_response)

            return _git_stream

    def handle_vcs_exception(self, exception, request):
        _vcs_kind = getattr(exception, '_vcs_kind', '')
        if _vcs_kind == 'repo_locked':
            # Get custom repo-locked status code if present.
            status_code = request.headers.get('X-RC-Locked-Status-Code')
            return HTTPRepoLocked(
                title=exception.message, status_code=status_code)

        elif _vcs_kind == 'repo_branch_protected':
            # Get custom repo-branch-protected status code if present.
            return HTTPRepoBranchProtected(title=exception.message)

        exc_info = request.exc_info
        store_exception(id(exc_info), exc_info)

        traceback_info = 'unavailable'
        if request.exc_info:
            exc_type, exc_value, exc_tb = request.exc_info
            traceback_info = ''.join(traceback.format_exception(exc_type, exc_value, exc_tb))

        log.error(
            'error occurred handling this request for path: %s, \n tb: %s',
            request.path, traceback_info)
        raise exception


class ResponseFilter(object):

    def __init__(self, start_response):
        self._start_response = start_response

    def __call__(self, status, response_headers, exc_info=None):
        headers = tuple(
            (h, v) for h, v in response_headers
            if not wsgiref.util.is_hop_by_hop(h))
        return self._start_response(status, headers, exc_info)


def main(global_config, **settings):
    if MercurialFactory:
        hgpatches.patch_largefiles_capabilities()
        hgpatches.patch_subrepo_type_mapping()

    app = HTTPApplication(settings=settings, global_config=global_config)
    return app.wsgi_app()
