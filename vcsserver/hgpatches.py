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

"""
Adjustments to Mercurial

Intentionally kept separate from `hgcompat` and `hg`, so that these patches can
be applied without having to import the whole Mercurial machinery.

Imports are function local, so that just importing this module does not cause
side-effects other than these functions being defined.
"""

import logging


def patch_largefiles_capabilities():
    """
    Patches the capabilities function in the largefiles extension.
    """
    from vcsserver import hgcompat
    lfproto = hgcompat.largefiles.proto
    wrapper = _dynamic_capabilities_wrapper(
        lfproto, hgcompat.extensions.extensions)
    lfproto.capabilities = wrapper


def _dynamic_capabilities_wrapper(lfproto, extensions):

    wrapped_capabilities = lfproto.capabilities
    logger = logging.getLogger('vcsserver.hg')

    def _dynamic_capabilities(repo, proto):
        """
        Adds dynamic behavior, so that the capability is only added if the
        extension is enabled in the current ui object.
        """
        if 'largefiles' in dict(extensions(repo.ui)):
            logger.debug('Extension largefiles enabled')
            calc_capabilities = wrapped_capabilities
        else:
            logger.debug('Extension largefiles disabled')
            calc_capabilities = lfproto.capabilitiesorig
        return calc_capabilities(repo, proto)

    return _dynamic_capabilities


def patch_subrepo_type_mapping():
    from collections import defaultdict
    from hgcompat import subrepo
    from exceptions import SubrepoMergeException

    class NoOpSubrepo(subrepo.abstractsubrepo):

        def __init__(self, ctx, path, *args, **kwargs):
            """Initialize abstractsubrepo part

            ``ctx`` is the context referring this subrepository in the
            parent repository.

            ``path`` is the path to this subrepository as seen from
            innermost repository.
            """
            self.ui = ctx.repo().ui
            self._ctx = ctx
            self._path = path

        def storeclean(self, path):
            """
            returns true if the repository has not changed since it was last
            cloned from or pushed to a given repository.
            """
            return True

        def dirty(self, ignoreupdate=False):
            """returns true if the dirstate of the subrepo is dirty or does not
            match current stored state. If ignoreupdate is true, only check
            whether the subrepo has uncommitted changes in its dirstate.
            """
            return False

        def basestate(self):
            """current working directory base state, disregarding .hgsubstate
            state and working directory modifications"""
            substate = subrepo.state(self._ctx, self.ui)
            file_system_path, rev, repotype = substate.get(self._path)
            return rev

        def remove(self):
            """remove the subrepo

            (should verify the dirstate is not dirty first)
            """
            pass

        def get(self, state, overwrite=False):
            """run whatever commands are needed to put the subrepo into
            this state
            """
            pass

        def merge(self, state):
            """merge currently-saved state with the new state."""
            raise SubrepoMergeException()

        def push(self, opts):
            """perform whatever action is analogous to 'hg push'

            This may be a no-op on some systems.
            """
            pass

    # Patch subrepo type mapping to always return our NoOpSubrepo class
    # whenever a subrepo class is looked up.
    subrepo.types = {
        'hg': NoOpSubrepo,
        'git': NoOpSubrepo,
        'svn': NoOpSubrepo
    }
