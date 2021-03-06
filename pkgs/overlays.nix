self: super: {

  # bump GIT version
  git = super.lib.overrideDerivation super.git (oldAttrs: {
    name = "git-2.27.0";
    src = self.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.27.0.tar.xz";
      sha256 = "1ybk39ylvs32lywq7ra4l2kdr5izc80r9461hwfnw8pssxs9gjkk";
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
      name = "subversion-1.13.0";
      src = self.fetchurl {
        url = "https://archive.apache.org/dist/subversion/subversion-1.13.0.tar.gz";
        sha256 = "0cb9p7f5hg0l4k32hz8vmvy2r45igchq5sh4m366za5q0c649bfs";
      };

      ## use internal lz4/utf8proc because it is stable and shipped with SVN
      configureFlags = oldAttrs.configureFlags ++ [
        " --with-lz4=internal"
        " --with-utf8proc=internal"
      ];

  });


}
