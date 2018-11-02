# This file defines how to "build" for packaging.

{ doCheck ? true
}:

let
  vcsserver = import ./default.nix {
    inherit
      doCheck;
  };

in {
  build = vcsserver;
}
