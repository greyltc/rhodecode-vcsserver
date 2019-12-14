self: super: {

  # bump GIT version
  git = super.lib.overrideDerivation super.git (oldAttrs: {
    name = "git-2.24.1";
    src = self.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.24.1.tar.xz";
      sha256 = "0ql5z31vgl7b785gwrf00m129mg7zi9pa65n12ij3mpxx3f28gvj";
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

  libgit2rc = super.lib.overrideDerivation super.libgit2 (oldAttrs: {
    name = "libgit2-0.28.2";
    version = "0.28.2";

    src = self.fetchFromGitHub {
        owner = "libgit2";
        repo = "libgit2";
        rev = "v0.28.2";
        sha256 = "0cm8fvs05rj0baigs2133q5a0sm3pa234y8h6hmwhl2bz9xq3k4b";
    };

    cmakeFlags = [ "-DTHREADSAFE=ON" "-DUSE_HTTPS=no"];

    buildInputs = [
        super.zlib
        super.libssh2
        super.openssl
        super.curl
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
      name = "subversion-1.12.2";
      src = self.fetchurl {
        url = "https://archive.apache.org/dist/subversion/subversion-1.12.2.tar.gz";
        sha256 = "1wr1pklnq67xdzmf237zj6l1hg43yshfkbxvpvd5sv6r0dk7v4pl";
      };

      ## use internal lz4/utf8proc because it is stable and shipped with SVN
      configureFlags = oldAttrs.configureFlags ++ [
        " --with-lz4=internal"
        " --with-utf8proc=internal"
      ];

  });


}
