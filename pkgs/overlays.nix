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
      name = "subversion-1.9.9";
      src = self.fetchurl {
        url = "https://archive.apache.org/dist/subversion/subversion-1.9.9.tar.gz";
        sha256 = "0f0ivhv6mjrpmlxa6a81zsjqdpw6y06ivszky7x5fz5h34c05lr8";
      };
  });

}
