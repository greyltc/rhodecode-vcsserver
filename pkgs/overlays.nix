self: super: {
  # bump GIT version
  git = super.lib.overrideDerivation super.git (oldAttrs: {
    name = "git-2.17.1";
    src = self.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.17.1.tar.xz";
      sha256 = "0pm6bdnrrm165k3krnazxcxadifk2gqi30awlbcf9fism1x6w4vr";
    };

    patches = [
      ./git_patches/docbook2texi.patch
      ./git_patches/symlinks-in-bin.patch
      ./git_patches/git-sh-i18n.patch
      ./git_patches/ssh-path.patch
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
