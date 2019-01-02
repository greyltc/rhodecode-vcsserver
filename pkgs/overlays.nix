self: super: {
  # bump GIT version
  git = super.lib.overrideDerivation super.git (oldAttrs: {
    name = "git-2.19.2";
    src = self.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.19.2.tar.xz";
      sha256 = "1scbggzghkzzfqg4ky3qh7h9w87c3zya4ls5disz7dbx56is7sgw";
    };

    # patches come from: https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools/git
    patches = [
      ./patches/git/docbook2texi.patch
      ./patches/git/git-sh-i18n.patch
      ./patches/git/ssh-path.patch
      ./patches/git/git-send-email-honor-PATH.patch
      ./patches/git/installCheck-path.patch
    ];

  });

  # Override subversion derivation to
  #  - activate python bindings
  subversion =
  let
    subversionWithPython = super.subversion.override {
      httpSupport = true;
      pythonBindings = true;
      python = self.python27Packages.python;
    };
  in
    super.lib.overrideDerivation subversionWithPython (oldAttrs: {
      name = "subversion-1.10.2";
      src = self.fetchurl {
        url = "https://archive.apache.org/dist/subversion/subversion-1.10.2.tar.gz";
        sha256 = "0xv5z2bg0lw7057g913yc13f60nfj257wvmsq22pr33m4syf26sg";
      };

      ## use internal lz4/utf8proc because it is stable and shipped with SVN
      configureFlags = oldAttrs.configureFlags ++ [
        " --with-lz4=internal"
        " --with-utf8proc=internal"
      ];


  });

}
