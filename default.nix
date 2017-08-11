# Nix environment for the community edition
#
# This shall be as lean as possible, just producing the rhodecode-vcsserver
# derivation. For advanced tweaks to pimp up the development environment we use
# "shell.nix" so that it does not have to clutter this file.

{ pkgs ? (import <nixpkgs> {})
, pythonPackages ? "python27Packages"
, pythonExternalOverrides ? self: super: {}
, doCheck ? true
}:

let pkgs_ = pkgs; in

let
  pkgs = pkgs_.overridePackages (self: super: {
    # bump GIT version
    git = pkgs.lib.overrideDerivation pkgs_.git (oldAttrs: {
      name = "git-2.9.5";
      src = pkgs.fetchurl {
        url = "https://www.kernel.org/pub/software/scm/git/git-2.9.5.tar.xz";
        sha256 = "00ir7qmgfszwrhxjzxwixk7wp35gxvvw467gr30bagwsrdza7gm4";
      };

    });

    # Override subversion derivation to
    #  - activate python bindings
    subversion = let
      subversionWithPython = super.subversion.override {
        httpSupport = true;
        pythonBindings = true;
        python = self.python27Packages.python;
      };

    in

    pkgs.lib.overrideDerivation subversionWithPython (oldAttrs: {
      name = "subversion-1.9.7";
      src = pkgs.fetchurl {
        url = "https://www.apache.org/dist/subversion/subversion-1.9.7.tar.gz";
        sha256 = "0g3cs2h008z8ymgkhbk54jp87bjh7y049rn42igj881yi2f20an7";
      };

    });

  });

  inherit (pkgs.lib) fix extends;
  basePythonPackages = with builtins; if isAttrs pythonPackages
    then pythonPackages
    else getAttr pythonPackages pkgs;

  elem = builtins.elem;
  basename = path: with pkgs.lib; last (splitString "/" path);
  startsWith = prefix: full: let
    actualPrefix = builtins.substring 0 (builtins.stringLength prefix) full;
  in actualPrefix == prefix;

  src-filter = path: type: with pkgs.lib;
    let
      ext = last (splitString "." path);
    in
      !elem (basename path) [".hg" ".git" "__pycache__" ".eggs"
        "node_modules" "build" "data" "tmp"] &&
      !elem ext ["egg-info" "pyc"] &&
      !startsWith "result" path;

  rhodecode-vcsserver-src = builtins.filterSource src-filter ./.;

  pythonGeneratedPackages = self: basePythonPackages.override (a: {
    inherit self;
  }) // (scopedImport {
    self = self;
    super = basePythonPackages;
    inherit pkgs;
    inherit (pkgs) fetchurl fetchgit;
  } ./pkgs/python-packages.nix);

  pythonOverrides = import ./pkgs/python-packages-overrides.nix {
    inherit basePythonPackages pkgs;
  };

  version = builtins.readFile ./vcsserver/VERSION;

  pythonLocalOverrides = self: super: {
    rhodecode-vcsserver = super.rhodecode-vcsserver.override (attrs: {
      inherit doCheck version;

      name = "rhodecode-vcsserver-${version}";
      releaseName = "RhodeCodeVCSServer-${version}";
      src = rhodecode-vcsserver-src;
      dontStrip = true; # prevent strip, we don't need it.

      propagatedBuildInputs = attrs.propagatedBuildInputs ++ ([
        pkgs.git
        pkgs.subversion
      ]);

      # TODO: johbo: Make a nicer way to expose the parts. Maybe
      # pkgs/default.nix?
      passthru = {
        pythonPackages = self;
      };

      # Add VCSServer bin directory to path so that tests can find 'vcsserver'.
      preCheck = ''
        export PATH="$out/bin:$PATH"
      '';

      # put custom attrs here
      checkPhase = ''
        runHook preCheck
        PYTHONHASHSEED=random py.test -p no:sugar -vv --cov-config=.coveragerc --cov=vcsserver --cov-report=term-missing vcsserver
        runHook postCheck
      '';

      postInstall = ''
        echo "Writing meta information for rccontrol to nix-support/rccontrol"
        mkdir -p $out/nix-support/rccontrol
        cp -v vcsserver/VERSION $out/nix-support/rccontrol/version
        echo "DONE: Meta information for rccontrol written"

        # python based programs need to be wrapped
        ln -s ${self.pyramid}/bin/* $out/bin/
        ln -s ${self.gunicorn}/bin/gunicorn $out/bin/

        # Symlink version control utilities
        #
        # We ensure that always the correct version is available as a symlink.
        # So that users calling them via the profile path will always use the
        # correct version.
        ln -s ${pkgs.git}/bin/git $out/bin
        ln -s ${self.mercurial}/bin/hg $out/bin
        ln -s ${pkgs.subversion}/bin/svn* $out/bin

        for file in $out/bin/*;
        do
          wrapProgram $file \
            --set PATH $PATH \
            --set PYTHONPATH $PYTHONPATH \
            --set PYTHONHASHSEED random
        done

      '';

    });
  };

  # Apply all overrides and fix the final package set
  myPythonPackages =
    (fix
    (extends pythonExternalOverrides
    (extends pythonLocalOverrides
    (extends pythonOverrides
             pythonGeneratedPackages))));

in myPythonPackages.rhodecode-vcsserver
