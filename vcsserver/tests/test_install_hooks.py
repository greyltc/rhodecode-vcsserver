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
import stat
import pytest
import vcsserver
import tempfile
from vcsserver import hook_utils
from vcsserver.tests.fixture import no_newline_id_generator
from vcsserver.utils import AttributeDict


class TestCheckRhodecodeHook(object):

    def test_returns_false_when_hook_file_is_wrong_found(self, tmpdir):
        hook = os.path.join(str(tmpdir), 'fake_hook_file.py')
        with open(hook, 'wb') as f:
            f.write('dummy test')
            result = hook_utils.check_rhodecode_hook(hook)
            assert result is False

    def test_returns_true_when_no_hook_file_found(self, tmpdir):
        hook = os.path.join(str(tmpdir), 'fake_hook_file_not_existing.py')
        result = hook_utils.check_rhodecode_hook(hook)
        assert result

    @pytest.mark.parametrize("file_content, expected_result", [
        ("RC_HOOK_VER = '3.3.3'\n", True),
        ("RC_HOOK = '3.3.3'\n", False),
    ], ids=no_newline_id_generator)
    def test_signatures(self, file_content, expected_result, tmpdir):
        hook = os.path.join(str(tmpdir), 'fake_hook_file_1.py')
        with open(hook, 'wb') as f:
            f.write(file_content)

        result = hook_utils.check_rhodecode_hook(hook)

        assert result is expected_result


class BaseInstallHooks(object):
    HOOK_FILES = ()

    def _check_hook_file_mode(self, file_path):
        assert os.path.exists(file_path), 'path %s missing' % file_path
        stat_info = os.stat(file_path)

        file_mode = stat.S_IMODE(stat_info.st_mode)
        expected_mode = int('755', 8)
        assert expected_mode == file_mode

    def _check_hook_file_content(self, file_path, executable):
        executable = executable or sys.executable
        with open(file_path, 'rt') as hook_file:
            content = hook_file.read()

        expected_env = '#!{}'.format(executable)
        expected_rc_version = "\nRC_HOOK_VER = '{}'\n".format(
            vcsserver.__version__)
        assert content.strip().startswith(expected_env)
        assert expected_rc_version in content

    def _create_fake_hook(self, file_path, content):
        with open(file_path, 'w') as hook_file:
            hook_file.write(content)

    def create_dummy_repo(self, repo_type):
        tmpdir = tempfile.mkdtemp()
        repo = AttributeDict()
        if repo_type == 'git':
            repo.path = os.path.join(tmpdir, 'test_git_hooks_installation_repo')
            os.makedirs(repo.path)
            os.makedirs(os.path.join(repo.path, 'hooks'))
            repo.bare = True

        elif repo_type == 'svn':
            repo.path = os.path.join(tmpdir, 'test_svn_hooks_installation_repo')
            os.makedirs(repo.path)
            os.makedirs(os.path.join(repo.path, 'hooks'))

        return repo

    def check_hooks(self, repo_path, repo_bare=True):
        for file_name in self.HOOK_FILES:
            if repo_bare:
                file_path = os.path.join(repo_path, 'hooks', file_name)
            else:
                file_path = os.path.join(repo_path, '.git', 'hooks', file_name)
            self._check_hook_file_mode(file_path)
            self._check_hook_file_content(file_path, sys.executable)


class TestInstallGitHooks(BaseInstallHooks):
    HOOK_FILES = ('pre-receive', 'post-receive')

    def test_hooks_are_installed(self):
        repo = self.create_dummy_repo('git')
        result = hook_utils.install_git_hooks(repo.path, repo.bare)
        assert result
        self.check_hooks(repo.path, repo.bare)

    def test_hooks_are_replaced(self):
        repo = self.create_dummy_repo('git')
        hooks_path = os.path.join(repo.path, 'hooks')
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content="RC_HOOK_VER = 'abcde'\n")

        result = hook_utils.install_git_hooks(repo.path, repo.bare)
        assert result
        self.check_hooks(repo.path, repo.bare)

    def test_non_rc_hooks_are_not_replaced(self):
        repo = self.create_dummy_repo('git')
        hooks_path = os.path.join(repo.path, 'hooks')
        non_rc_content = 'echo "non rc hook"\n'
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content=non_rc_content)

        result = hook_utils.install_git_hooks(repo.path, repo.bare)
        assert result

        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            with open(file_path, 'rt') as hook_file:
                content = hook_file.read()
            assert content == non_rc_content

    def test_non_rc_hooks_are_replaced_with_force_flag(self):
        repo = self.create_dummy_repo('git')
        hooks_path = os.path.join(repo.path, 'hooks')
        non_rc_content = 'echo "non rc hook"\n'
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content=non_rc_content)

        result = hook_utils.install_git_hooks(
            repo.path, repo.bare, force_create=True)
        assert result
        self.check_hooks(repo.path, repo.bare)


class TestInstallSvnHooks(BaseInstallHooks):
    HOOK_FILES = ('pre-commit', 'post-commit')

    def test_hooks_are_installed(self):
        repo = self.create_dummy_repo('svn')
        result = hook_utils.install_svn_hooks(repo.path)
        assert result
        self.check_hooks(repo.path)

    def test_hooks_are_replaced(self):
        repo = self.create_dummy_repo('svn')
        hooks_path = os.path.join(repo.path, 'hooks')
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content="RC_HOOK_VER = 'abcde'\n")

        result = hook_utils.install_svn_hooks(repo.path)
        assert result
        self.check_hooks(repo.path)

    def test_non_rc_hooks_are_not_replaced(self):
        repo = self.create_dummy_repo('svn')
        hooks_path = os.path.join(repo.path, 'hooks')
        non_rc_content = 'echo "non rc hook"\n'
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content=non_rc_content)

        result = hook_utils.install_svn_hooks(repo.path)
        assert result

        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            with open(file_path, 'rt') as hook_file:
                content = hook_file.read()
            assert content == non_rc_content

    def test_non_rc_hooks_are_replaced_with_force_flag(self):
        repo = self.create_dummy_repo('svn')
        hooks_path = os.path.join(repo.path, 'hooks')
        non_rc_content = 'echo "non rc hook"\n'
        for file_path in [os.path.join(hooks_path, f) for f in self.HOOK_FILES]:
            self._create_fake_hook(
                file_path, content=non_rc_content)

        result = hook_utils.install_svn_hooks(
            repo.path, force_create=True)
        assert result
        self.check_hooks(repo.path, )
