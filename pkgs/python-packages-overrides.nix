# Overrides for the generated python-packages.nix
#
# This function is intended to be used as an extension to the generated file
# python-packages.nix. The main objective is to add needed dependencies of C
# libraries and tweak the build instructions where needed.

{ pkgs
, basePythonPackages
}:

let
  sed = "sed -i";

in

self: super: {

  "gevent" = super."gevent".override (attrs: {
    propagatedBuildInputs = attrs.propagatedBuildInputs ++ [
      # NOTE: (marcink) odd requirements from gevent aren't set properly,
      # thus we need to inject psutil manually
      self."psutil"
    ];
  });

  "hgsubversion" = super."hgsubversion".override (attrs: {
    propagatedBuildInputs = attrs.propagatedBuildInputs ++ [
      pkgs.sqlite
      #basePythonPackages.sqlite3
      self.mercurial
    ];
  });

  "subvertpy" = super."subvertpy".override (attrs: {
    SVN_PREFIX = "${pkgs.subversion.dev}";
    propagatedBuildInputs = [
      pkgs.apr.dev
      pkgs.aprutil
      pkgs.subversion
    ];
  });

  "mercurial" = super."mercurial".override (attrs: {
    propagatedBuildInputs = [
      # self.python.modules.curses
    ];
  });

  "dulwich" = super."dulwich".override (attrs: {
    patches = [
      ./patches/dulwich/handle-dir-refs.patch
    ];
  });


  # Avoid that base packages screw up the build process
  inherit (basePythonPackages)
    setuptools;

}
