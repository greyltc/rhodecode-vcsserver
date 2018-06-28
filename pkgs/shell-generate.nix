{ pkgs ? (import <nixpkgs> {})
, pythonPackages ? "python27Packages"
}:

with pkgs.lib;

let _pythonPackages = pythonPackages; in
let
  pythonPackages = getAttr _pythonPackages pkgs;

  pip2nix = import ./nix-common/pip2nix.nix {
    inherit
      pkgs
      pythonPackages;
  };

in

pkgs.stdenv.mkDerivation {
  name = "pip2nix-generated";
  buildInputs = [
    pip2nix.pip2nix
    pythonPackages.pip-tools
    pkgs.apr
    pkgs.aprutil
  ];

  shellHook = ''
    runHook preShellHook
    echo "Setting SVN_* variables"
    export SVN_LIBRARY_PATH=${pkgs.subversion}/lib
    export SVN_HEADER_PATH=${pkgs.subversion.dev}/include
    runHook postShellHook
  '';

  preShellHook = ''
    echo "Starting Generate Shell"
    # Custom prompt to distinguish from other dev envs.
    export PS1="\n\[\033[1;32m\][Generate-shell:\w]$\[\033[0m\] "
  '';
}
