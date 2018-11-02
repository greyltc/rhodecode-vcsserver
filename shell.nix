# This file contains the adjustments which are desired for a development
# environment.

{ pkgs ? (import <nixpkgs> {})
, pythonPackages ? "python27Packages"
, doCheck ? false
}:

let

  vcsserver = import ./default.nix {
    inherit
      doCheck;
  };

  vcs-pythonPackages = vcsserver.pythonPackages;

in vcsserver.override (attrs: {
  # Avoid that we dump any sources into the store when entering the shell and
  # make development a little bit more convenient.
  src = null;

  # Add dependencies which are useful for the development environment.
  buildInputs =
    attrs.buildInputs ++
    (with vcs-pythonPackages; [
      ipdb
    ]);

  # place to inject some required libs from develop installs
  propagatedBuildInputs =
    attrs.propagatedBuildInputs ++
    [];


  # Make sure we execute both hooks
  shellHook = ''
    runHook preShellHook
    runHook postShellHook
  '';

  preShellHook = ''
    echo "Entering VCS-Shell"

    # Custom prompt to distinguish from other dev envs.
    export PS1="\n\[\033[1;32m\][VCS-shell:\w]$\[\033[0m\] "

    # Set locale
    export LC_ALL="en_US.UTF-8"

    # Setup a temporary directory.
    tmp_path=$(mktemp -d)
    export PATH="$tmp_path/bin:$PATH"
    export PYTHONPATH="$tmp_path/${vcs-pythonPackages.python.sitePackages}:$PYTHONPATH"
    mkdir -p $tmp_path/${vcs-pythonPackages.python.sitePackages}

    # Develop installation
    echo "[BEGIN]: develop install of rhodecode-vcsserver"
    python setup.py develop --prefix $tmp_path --allow-hosts ""
  '';

  postShellHook = ''

  '';

})
