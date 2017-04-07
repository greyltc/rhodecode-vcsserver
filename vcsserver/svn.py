# Copyright (C) 2014-2017 RodeCode GmbH
from vcsserver import exceptions
from vcsserver.base import RepoFactory, raise_from_original
def reraise_safe_exceptions(func):
    """Decorator for converting svn exceptions to something neutral."""
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except Exception as e:
            if not hasattr(e, '_vcs_kind'):
                log.exception("Unhandled exception in hg remote call")
                raise_from_original(exceptions.UnhandledException)
            raise
    return wrapper


    @reraise_safe_exceptions
    def discover_svn_version(self):
        try:
            import svn.core
            svn_ver = svn.core.SVN_VERSION
        except ImportError:
            svn_ver = None
        return svn_ver


            if change.action in [svn.repos.CHANGE_ACTION_ADD]:
            elif change.action in [svn.repos.CHANGE_ACTION_MODIFY,
                                   svn.repos.CHANGE_ACTION_REPLACE]:
            elif change.action in [svn.repos.CHANGE_ACTION_DELETE]:

        try:
            return diff_creator.generate_diff()
        except svn.core.SubversionException as e:
            log.exception(
                "Error during diff operation operation. "
                "Path might not exist %s, %s" % (path1, path2))
            return ""

    @reraise_safe_exceptions
    def is_large_file(self, wire, path):
        return False
        change = None
        if self.src_kind == svn.core.svn_node_none:
            change = "add"
        elif self.tgt_kind == svn.core.svn_node_none:
            change = "delete"
        tgt_base, tgt_path = vcspath.split(self.tgt_path)
        src_base, src_path = vcspath.split(self.src_path)
        self._generate_node_diff(
            buf, change, tgt_path, tgt_base, src_path, src_base)

        if self.src_rev == self.tgt_rev and tgt_base == src_base:
            # makes consistent behaviour with git/hg to return empty diff if
            # we compare same revisions
            return



            #TODO(marcink): intro to binary detection of svn patches
            # if self.binary_content:
            #     buf.write('GIT binary patch\n')


            #TODO(marcink): intro to binary detection of svn patches
            # if self.binary_content:
            #     buf.write('GIT binary patch\n')
