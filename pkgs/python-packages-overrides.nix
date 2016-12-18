# Overrides for the generated python-packages.nix
#
# This function is intended to be used as an extension to the generated file
# python-packages.nix. The main objective is to add needed dependencies of C
# libraries and tweak the build instructions where needed.

{ pkgs, basePythonPackages }:

let
  sed = "sed -i";
in

self: super: {

  subvertpy = super.subvertpy.override (attrs: {
    # TODO: johbo: Remove the "or" once we drop 16.03 support
    SVN_PREFIX = "${pkgs.subversion.dev or pkgs.subversion}";
    propagatedBuildInputs = attrs.propagatedBuildInputs ++ [
      pkgs.aprutil
      pkgs.subversion
    ];
    preBuild = pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
      ${sed} -e "s/'gcc'/'clang'/" setup.py
    '';
  });

  mercurial = super.mercurial.override (attrs: {
    propagatedBuildInputs = attrs.propagatedBuildInputs ++ [
      self.python.modules.curses
    ] ++ pkgs.lib.optional pkgs.stdenv.isDarwin
      pkgs.darwin.apple_sdk.frameworks.ApplicationServices;
  });

  pyramid = super.pyramid.override (attrs: {
    postFixup = ''
      wrapPythonPrograms
      # TODO: johbo: "wrapPython" adds this magic line which
      # confuses pserve.
      ${sed} '/import sys; sys.argv/d' $out/bin/.pserve-wrapped
    '';
  });

  # Avoid that setuptools is replaced, this leads to trouble
  # with buildPythonPackage.
  setuptools = basePythonPackages.setuptools;

}
