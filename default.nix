# Nix environment for the community edition
#
# This shall be as lean as possible, just producing the rhodecode-vcsserver
# derivation. For advanced tweaks to pimp up the development environment we use
# "shell.nix" so that it does not have to clutter this file.

args@
{ pythonPackages ? "python27Packages"
, pythonExternalOverrides ? self: super: {}
, doCheck ? false
, ...
}:

let pkgs_ = (import <nixpkgs> {}); in

let

  # TODO: Currently we ignore the passed in pkgs, instead we should use it
  # somehow as a base and apply overlays to it.
  pkgs = import <nixpkgs> {
    overlays = [
      (import ./pkgs/overlays.nix)
    ];
    inherit (pkgs_)
      system;
  };

  # Works with the new python-packages, still can fallback to the old
  # variant.
  basePythonPackagesUnfix = basePythonPackages.__unfix__ or (
    self: basePythonPackages.override (a: { inherit self; }));

  # Evaluates to the last segment of a file system path.
  basename = path: with pkgs.lib; last (splitString "/" path);

  # source code filter used as arugment to builtins.filterSource.
  src-filter = path: type: with pkgs.lib;
    let
      ext = last (splitString "." path);
    in
      !builtins.elem (basename path) [
        ".git" ".hg" "__pycache__" ".eggs" ".idea" ".dev"
        "bower_components" "node_modules"
        "build" "data" "result" "tmp"] &&
      !builtins.elem ext ["egg-info" "pyc"] &&
      # TODO: johbo: This check is wrong, since "path" contains an absolute path,
      # it would still be good to restore it since we want to ignore "result-*".
      !hasPrefix "result" path;

  sources =
    let
      inherit (pkgs.lib) all isString attrValues;
      sourcesConfig = pkgs.config.rc.sources or {};
    in
      # Ensure that sources are configured as strings. Using a path
      # would result in a copy into the nix store.
      assert all isString (attrValues sourcesConfig);
      sourcesConfig;

  version = builtins.readFile "${rhodecode-vcsserver-src}/vcsserver/VERSION";
  rhodecode-vcsserver-src = builtins.filterSource src-filter ./.;

  pythonLocalOverrides = self: super: {
    rhodecode-vcsserver =
      let
        releaseName = "RhodeCodeVCSServer-${version}";
      in super.rhodecode-vcsserver.override (attrs: {
      inherit
        doCheck
        version;

      name = "rhodecode-vcsserver-${version}";
      releaseName = releaseName;
      src = rhodecode-vcsserver-src;
      dontStrip = true; # prevent strip, we don't need it.

      # expose following attributed outside
      passthru = {
        pythonPackages = self;
      };

      propagatedBuildInputs =
        attrs.propagatedBuildInputs or [] ++ [
        pkgs.git
        pkgs.subversion
      ];

      # Add bin directory to path so that tests can find 'vcsserver'.
      preCheck = ''
        export PATH="$out/bin:$PATH"
      '';

      # custom check phase for testing
      checkPhase = ''
        runHook preCheck
        PYTHONHASHSEED=random py.test -vv -p no:sugar -r xw --cov-config=.coveragerc --cov=vcsserver --cov-report=term-missing vcsserver
        runHook postCheck
      '';

      postCheck = ''
        echo "Cleanup of vcsserver/tests"
        rm -rf $out/lib/${self.python.libPrefix}/site-packages/vcsserver/tests
      '';

      postInstall = ''
        echo "Writing vcsserver meta information for rccontrol to nix-support/rccontrol"
        mkdir -p $out/nix-support/rccontrol
        cp -v vcsserver/VERSION $out/nix-support/rccontrol/version
        echo "DONE: vcsserver meta information for rccontrol written"

        mkdir -p $out/etc
        cp configs/production.ini $out/etc
        echo "DONE: saved vcsserver production.ini into $out/etc"

        # python based programs need to be wrapped
        mkdir -p $out/bin
        ln -s ${self.python}/bin/python $out/bin
        ln -s ${self.pyramid}/bin/* $out/bin/
        ln -s ${self.gunicorn}/bin/gunicorn $out/bin/

        # Symlink version control utilities
        # We ensure that always the correct version is available as a symlink.
        # So that users calling them via the profile path will always use the
        # correct version.

        ln -s ${pkgs.git}/bin/git $out/bin
        ln -s ${self.mercurial}/bin/hg $out/bin
        ln -s ${pkgs.subversion}/bin/svn* $out/bin
        echo "DONE: created symlinks into $out/bin"

        for file in $out/bin/*;
        do
          wrapProgram $file \
            --prefix PATH : $PATH \
            --prefix PYTHONPATH : $PYTHONPATH \
            --set PYTHONHASHSEED random
        done
        echo "DONE: vcsserver binary wrapping"

      '';

    });
  };

  basePythonPackages = with builtins;
    if isAttrs pythonPackages then
      pythonPackages
    else
      getAttr pythonPackages pkgs;

  pythonGeneratedPackages = import ./pkgs/python-packages.nix {
    inherit pkgs;
    inherit (pkgs) fetchurl fetchgit fetchhg;
  };

  pythonVCSServerOverrides = import ./pkgs/python-packages-overrides.nix {
    inherit pkgs basePythonPackages;
  };


  # Apply all overrides and fix the final package set
  myPythonPackagesUnfix = with pkgs.lib;
    (extends pythonExternalOverrides
    (extends pythonLocalOverrides
    (extends pythonVCSServerOverrides
    (extends pythonGeneratedPackages
             basePythonPackagesUnfix))));

  myPythonPackages = (pkgs.lib.fix myPythonPackagesUnfix);

in myPythonPackages.rhodecode-vcsserver
