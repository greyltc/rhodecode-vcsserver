# This file defines how to "build" for packaging.

{ pkgs ? import <nixpkgs> {}
, doCheck ? true
}:

let
  vcsserver = import ./default.nix {
    inherit
      doCheck
      pkgs;
  };

in {
  build = vcsserver;
}
