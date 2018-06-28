self: super: {
  # bump GIT version
  git = super.lib.overrideDerivation super.git (oldAttrs: {
    name = "git-2.16.4";
    src = self.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.16.4.tar.xz";
      sha256 = "0cnmidjvbdf81mybcvxvl0c2r2x2nvq2jj2dl59dmrc7qklv0sbf";
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
      name = "subversion-1.9.7";
      src = self.fetchurl {
        url = "https://www.apache.org/dist/subversion/subversion-1.9.7.tar.gz";
        sha256 = "0g3cs2h008z8ymgkhbk54jp87bjh7y049rn42igj881yi2f20an7";
      };
  });

}
