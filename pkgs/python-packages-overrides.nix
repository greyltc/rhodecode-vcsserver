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

  "beaker" = super."beaker".override (attrs: {
    patches = [
      ./patch_beaker/patch-beaker-lock-func-debug.diff
      ./patch_beaker/patch-beaker-metadata-reuse.diff
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

  # Avoid that base packages screw up the build process
  inherit (basePythonPackages)
    setuptools;

}
