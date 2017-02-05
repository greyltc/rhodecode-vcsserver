# Generated by pip2nix 0.4.0
# See https://github.com/johbo/pip2nix

{
  Beaker = super.buildPythonPackage {
    name = "Beaker-1.7.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/97/8e/409d2e7c009b8aa803dc9e6f239f1db7c3cdf578249087a404e7c27a505d/Beaker-1.7.0.tar.gz";
      md5 = "386be3f7fe427358881eee4622b428b3";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  Jinja2 = super.buildPythonPackage {
    name = "Jinja2-2.8";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/f2/2f/0b98b06a345a761bec91a079ccae392d282690c2d8272e708f4d10829e22/Jinja2-2.8.tar.gz";
      md5 = "edb51693fe22c53cee5403775c71a99e";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  Mako = super.buildPythonPackage {
    name = "Mako-1.0.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz";
      md5 = "a28e22a339080316b2acc352b9ee631c";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  MarkupSafe = super.buildPythonPackage {
    name = "MarkupSafe-0.23";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz";
      md5 = "f5ab3deee4c37cd6a922fb81e730da6e";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  PasteDeploy = super.buildPythonPackage {
    name = "PasteDeploy-1.5.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/0f/90/8e20cdae206c543ea10793cbf4136eb9a8b3f417e04e40a29d72d9922cbd/PasteDeploy-1.5.2.tar.gz";
      md5 = "352b7205c78c8de4987578d19431af3b";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  Pyro4 = super.buildPythonPackage {
    name = "Pyro4-4.41";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [serpent];
    src = fetchurl {
      url = "https://pypi.python.org/packages/56/2b/89b566b4bf3e7f8ba790db2d1223852f8cb454c52cab7693dd41f608ca2a/Pyro4-4.41.tar.gz";
      md5 = "ed69e9bfafa9c06c049a87cb0c4c2b6c";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  WebOb = super.buildPythonPackage {
    name = "WebOb-1.3.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/16/78/adfc0380b8a0d75b2d543fa7085ba98a573b1ae486d9def88d172b81b9fa/WebOb-1.3.1.tar.gz";
      md5 = "20918251c5726956ba8fef22d1556177";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  WebTest = super.buildPythonPackage {
    name = "WebTest-1.4.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [WebOb];
    src = fetchurl {
      url = "https://pypi.python.org/packages/51/3d/84fd0f628df10b30c7db87895f56d0158e5411206b721ca903cb51bfd948/WebTest-1.4.3.zip";
      md5 = "631ce728bed92c681a4020a36adbc353";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  backports.shutil-get-terminal-size = super.buildPythonPackage {
    name = "backports.shutil-get-terminal-size-1.0.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz";
      md5 = "03267762480bd86b50580dc19dff3c66";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  configobj = super.buildPythonPackage {
    name = "configobj-5.0.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six];
    src = fetchurl {
      url = "https://pypi.python.org/packages/64/61/079eb60459c44929e684fa7d9e2fdca403f67d64dd9dbac27296be2e0fab/configobj-5.0.6.tar.gz";
      md5 = "e472a3a1c2a67bb0ec9b5d54c13a47d6";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  cov-core = super.buildPythonPackage {
    name = "cov-core-1.15.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [coverage];
    src = fetchurl {
      url = "https://pypi.python.org/packages/4b/87/13e75a47b4ba1be06f29f6d807ca99638bedc6b57fa491cd3de891ca2923/cov-core-1.15.0.tar.gz";
      md5 = "f519d4cb4c4e52856afb14af52919fe6";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  coverage = super.buildPythonPackage {
    name = "coverage-3.7.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/09/4f/89b06c7fdc09687bca507dc411c342556ef9c5a3b26756137a4878ff19bf/coverage-3.7.1.tar.gz";
      md5 = "c47b36ceb17eaff3ecfab3bcd347d0df";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  decorator = super.buildPythonPackage {
    name = "decorator-4.0.10";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/13/8a/4eed41e338e8dcc13ca41c94b142d4d20c0de684ee5065523fee406ce76f/decorator-4.0.10.tar.gz";
      md5 = "434b57fdc3230c500716c5aff8896100";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "new BSD License"; } ];
    };
  };
  dulwich = super.buildPythonPackage {
    name = "dulwich-0.13.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/84/95/732d280eee829dacc954e8109f97b47abcadcca472c2ab013e1635eb4792/dulwich-0.13.0.tar.gz";
      md5 = "6dede0626657c2bd08f48ca1221eea91";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl2Plus ];
    };
  };
  enum34 = super.buildPythonPackage {
    name = "enum34-1.1.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz";
      md5 = "5f13a0841a61f7fc295c514490d120d0";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  gevent = super.buildPythonPackage {
    name = "gevent-1.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [greenlet];
    src = fetchurl {
      url = "https://pypi.python.org/packages/43/8f/cb3224a0e6ab663547f45c10d0651cfd52633fde4283bf68d627084df8cc/gevent-1.1.2.tar.gz";
      md5 = "bb32a2f852a4997138014d5007215c6e";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  gprof2dot = super.buildPythonPackage {
    name = "gprof2dot-2016.10.13";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a0/e0/73c71baed306f0402a00a94ffc7b2be94ad1296dfcb8b46912655b93154c/gprof2dot-2016.10.13.tar.gz";
      md5 = "0125401f15fd2afe1df686a76c64a4fd";
    };
    meta = {
      license = [ { fullName = "LGPL"; } ];
    };
  };
  greenlet = super.buildPythonPackage {
    name = "greenlet-0.4.10";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/67/62/ca2a95648666eaa2ffeb6a9b3964f21d419ae27f82f2e66b53da5b943fc4/greenlet-0.4.10.zip";
      md5 = "bed0c4b3b896702131f4d5c72f87c41d";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  gunicorn = super.buildPythonPackage {
    name = "gunicorn-19.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/84/ce/7ea5396efad1cef682bbc4068e72a0276341d9d9d0f501da609fab9fcb80/gunicorn-19.6.0.tar.gz";
      md5 = "338e5e8a83ea0f0625f768dba4597530";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  hgsubversion = super.buildPythonPackage {
    name = "hgsubversion-1.8.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [mercurial subvertpy];
    src = fetchurl {
      url = "https://pypi.python.org/packages/ce/97/032e5093ad250e9908cea04395cbddb6902d587f712a79b53b2d778bdfdd/hgsubversion-1.8.6.tar.gz";
      md5 = "9310cb266031cf8d0779885782a84a5b";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 ];
    };
  };
  infrae.cache = super.buildPythonPackage {
    name = "infrae.cache-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [Beaker repoze.lru];
    src = fetchurl {
      url = "https://pypi.python.org/packages/bb/f0/e7d5e984cf6592fd2807dc7bc44a93f9d18e04e6a61f87fdfb2622422d74/infrae.cache-1.0.1.tar.gz";
      md5 = "b09076a766747e6ed2a755cc62088e32";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  ipdb = super.buildPythonPackage {
    name = "ipdb-0.10.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [ipython setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/eb/0a/0a37dc19572580336ad3813792c0d18c8d7117c2d66fc63c501f13a7a8f8/ipdb-0.10.1.tar.gz";
      md5 = "4aeab65f633ddc98ebdb5eebf08dc713";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  ipython = super.buildPythonPackage {
    name = "ipython-5.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools decorator pickleshare simplegeneric traitlets prompt-toolkit pygments pexpect backports.shutil-get-terminal-size pathlib2 pexpect];
    src = fetchurl {
      url = "https://pypi.python.org/packages/89/63/a9292f7cd9d0090a0f995e1167f3f17d5889dcbc9a175261719c513b9848/ipython-5.1.0.tar.gz";
      md5 = "47c8122420f65b58784cb4b9b4af35e3";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  ipython-genutils = super.buildPythonPackage {
    name = "ipython-genutils-0.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/71/b7/a64c71578521606edbbce15151358598f3dfb72a3431763edc2baf19e71f/ipython_genutils-0.1.0.tar.gz";
      md5 = "9a8afbe0978adbcbfcb3b35b2d015a56";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  mercurial = super.buildPythonPackage {
    name = "mercurial-4.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/85/1b/0296aacd697228974a473d2508f013532f987ed6b1bacfe5abd6d5be6332/mercurial-4.0.2.tar.gz";
      md5 = "fa72a08e2723e4fa2a21c4e66437f3fa";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 pkgs.lib.licenses.gpl2Plus ];
    };
  };
  mock = super.buildPythonPackage {
    name = "mock-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/15/45/30273ee91feb60dabb8fbb2da7868520525f02cf910279b3047182feed80/mock-1.0.1.zip";
      md5 = "869f08d003c289a97c1a6610faf5e913";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  msgpack-python = super.buildPythonPackage {
    name = "msgpack-python-0.4.8";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/21/27/8a1d82041c7a2a51fcc73675875a5f9ea06c2663e02fcfeb708be1d081a0/msgpack-python-0.4.8.tar.gz";
      md5 = "dcd854fb41ee7584ebbf35e049e6be98";
    };
    meta = {
      license = [ pkgs.lib.licenses.asl20 ];
    };
  };
  pathlib2 = super.buildPythonPackage {
    name = "pathlib2-2.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c9/27/8448b10d8440c08efeff0794adf7d0ed27adb98372c70c7b38f3947d4749/pathlib2-2.1.0.tar.gz";
      md5 = "38e4f58b4d69dfcb9edb49a54a8b28d2";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pexpect = super.buildPythonPackage {
    name = "pexpect-4.2.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [ptyprocess];
    src = fetchurl {
      url = "https://pypi.python.org/packages/e8/13/d0b0599099d6cd23663043a2a0bb7c61e58c6ba359b2656e6fb000ef5b98/pexpect-4.2.1.tar.gz";
      md5 = "3694410001a99dff83f0b500a1ca1c95";
    };
    meta = {
      license = [ pkgs.lib.licenses.isc { fullName = "ISC License (ISCL)"; } ];
    };
  };
  pickleshare = super.buildPythonPackage {
    name = "pickleshare-0.7.4";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pathlib2];
    src = fetchurl {
      url = "https://pypi.python.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz";
      md5 = "6a9e5dd8dfc023031f6b7b3f824cab12";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  prompt-toolkit = super.buildPythonPackage {
    name = "prompt-toolkit-1.0.9";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six wcwidth];
    src = fetchurl {
      url = "https://pypi.python.org/packages/83/14/5ac258da6c530eca02852ee25c7a9ff3ca78287bb4c198d0d0055845d856/prompt_toolkit-1.0.9.tar.gz";
      md5 = "a39f91a54308fb7446b1a421c11f227c";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  ptyprocess = super.buildPythonPackage {
    name = "ptyprocess-0.5.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/db/d7/b465161910f3d1cef593c5e002bff67e0384898f597f1a7fdc8db4c02bf6/ptyprocess-0.5.1.tar.gz";
      md5 = "94e537122914cc9ec9c1eadcd36e73a1";
    };
    meta = {
      license = [  ];
    };
  };
  py = super.buildPythonPackage {
    name = "py-1.4.31";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/f4/9a/8dfda23f36600dd701c6722316ba8a3ab4b990261f83e7d3ffc6dfedf7ef/py-1.4.31.tar.gz";
      md5 = "5d2c63c56dc3f2115ec35c066ecd582b";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pygments = super.buildPythonPackage {
    name = "pygments-2.2.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz";
      md5 = "13037baca42f16917cbd5ad2fab50844";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  pyramid = super.buildPythonPackage {
    name = "pyramid-1.6.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools WebOb repoze.lru zope.interface zope.deprecation venusian translationstring PasteDeploy];
    src = fetchurl {
      url = "https://pypi.python.org/packages/30/b3/fcc4a2a4800cbf21989e00454b5828cf1f7fe35c63e0810b350e56d4c475/pyramid-1.6.1.tar.gz";
      md5 = "b18688ff3cc33efdbb098a35b45dd122";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pyramid-jinja2 = super.buildPythonPackage {
    name = "pyramid-jinja2-2.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pyramid zope.deprecation Jinja2 MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a1/80/595e26ffab7deba7208676b6936b7e5a721875710f982e59899013cae1ed/pyramid_jinja2-2.5.tar.gz";
      md5 = "07cb6547204ac5e6f0b22a954ccee928";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pyramid-mako = super.buildPythonPackage {
    name = "pyramid-mako-1.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pyramid Mako];
    src = fetchurl {
      url = "https://pypi.python.org/packages/f1/92/7e69bcf09676d286a71cb3bbb887b16595b96f9ba7adbdc239ffdd4b1eb9/pyramid_mako-1.0.2.tar.gz";
      md5 = "ee25343a97eb76bd90abdc2a774eb48a";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pytest = super.buildPythonPackage {
    name = "pytest-3.0.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [py];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a8/87/b7ca49efe52d2b4169f2bfc49aa5e384173c4619ea8e635f123a0dac5b75/pytest-3.0.5.tar.gz";
      md5 = "cefd527b59332688bf5db4a10aa8a7cb";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-catchlog = super.buildPythonPackage {
    name = "pytest-catchlog-1.2.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [py pytest];
    src = fetchurl {
      url = "https://pypi.python.org/packages/f2/2b/2faccdb1a978fab9dd0bf31cca9f6847fbe9184a0bdcc3011ac41dd44191/pytest-catchlog-1.2.2.zip";
      md5 = "09d890c54c7456c818102b7ff8c182c8";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-cov = super.buildPythonPackage {
    name = "pytest-cov-2.4.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest coverage];
    src = fetchurl {
      url = "https://pypi.python.org/packages/00/c0/2bfd1fcdb9d407b8ac8185b1cb5ff458105c6b207a9a7f0e13032de9828f/pytest-cov-2.4.0.tar.gz";
      md5 = "2fda09677d232acc99ec1b3c5831e33f";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.mit ];
    };
  };
  pytest-profiling = super.buildPythonPackage {
    name = "pytest-profiling-1.2.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six pytest gprof2dot];
    src = fetchurl {
      url = "https://pypi.python.org/packages/73/e8/804681323bac0bc45c520ec34185ba8469008942266d0074699b204835c1/pytest-profiling-1.2.2.tar.gz";
      md5 = "0a16d7dda2d23b91e9730fa4558cf728";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-runner = super.buildPythonPackage {
    name = "pytest-runner-2.9";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/11/d4/c335ddf94463e451109e3494e909765c3e5205787b772e3b25ee8601b86a/pytest-runner-2.9.tar.gz";
      md5 = "2212a2e34404b0960b2fdc2c469247b2";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-sugar = super.buildPythonPackage {
    name = "pytest-sugar-0.7.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest termcolor];
    src = fetchurl {
      url = "https://pypi.python.org/packages/03/97/05d988b4fa870e7373e8ee4582408543b9ca2bd35c3c67b569369c6f9c49/pytest-sugar-0.7.1.tar.gz";
      md5 = "7400f7c11f3d572b2c2a3b60352d35fe";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  pytest-timeout = super.buildPythonPackage {
    name = "pytest-timeout-1.2.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest];
    src = fetchurl {
      url = "https://pypi.python.org/packages/cc/b7/b2a61365ea6b6d2e8881360ae7ed8dad0327ad2df89f2f0be4a02304deb2/pytest-timeout-1.2.0.tar.gz";
      md5 = "83607d91aa163562c7ee835da57d061d";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit { fullName = "DFSG approved"; } ];
    };
  };
  repoze.lru = super.buildPythonPackage {
    name = "repoze.lru-0.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/6e/1e/aa15cc90217e086dc8769872c8778b409812ff036bf021b15795638939e4/repoze.lru-0.6.tar.gz";
      md5 = "2c3b64b17a8e18b405f55d46173e14dd";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  rhodecode-vcsserver = super.buildPythonPackage {
    name = "rhodecode-vcsserver-4.6.0";
    buildInputs = with self; [pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage configobj];
    doCheck = true;
    propagatedBuildInputs = with self; [Beaker configobj dulwich hgsubversion infrae.cache mercurial msgpack-python pyramid pyramid-jinja2 pyramid-mako repoze.lru simplejson subprocess32 subvertpy six translationstring WebOb wheel zope.deprecation zope.interface ipdb ipython gevent greenlet gunicorn waitress Pyro4 serpent pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  serpent = super.buildPythonPackage {
    name = "serpent-1.15";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/7b/38/b2b27673a882ff2ea5871bb3e3e6b496ebbaafd1612e51990ffb158b9254/serpent-1.15.tar.gz";
      md5 = "e27b1aad5c218e16442f52abb7c7053a";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  setuptools = super.buildPythonPackage {
    name = "setuptools-30.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/1e/43/002c8616db9a3e7be23c2556e39b90a32bb40ba0dc652de1999d5334d372/setuptools-30.1.0.tar.gz";
      md5 = "cac497f42e5096ac8df29e38d3f81c3e";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  simplegeneric = super.buildPythonPackage {
    name = "simplegeneric-0.8.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip";
      md5 = "f9c1fab00fd981be588fc32759f474e3";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  simplejson = super.buildPythonPackage {
    name = "simplejson-3.7.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/6d/89/7f13f099344eea9d6722779a1f165087cb559598107844b1ac5dbd831fb1/simplejson-3.7.2.tar.gz";
      md5 = "a5fc7d05d4cb38492285553def5d4b46";
    };
    meta = {
      license = [ { fullName = "Academic Free License (AFL)"; } pkgs.lib.licenses.mit ];
    };
  };
  six = super.buildPythonPackage {
    name = "six-1.9.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/16/64/1dc5e5976b17466fd7d712e59cbe9fb1e18bec153109e5ba3ed6c9102f1a/six-1.9.0.tar.gz";
      md5 = "476881ef4012262dfc8adc645ee786c4";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  subprocess32 = super.buildPythonPackage {
    name = "subprocess32-3.2.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/28/8d/33ccbff51053f59ae6c357310cac0e79246bbed1d345ecc6188b176d72c3/subprocess32-3.2.6.tar.gz";
      md5 = "754c5ab9f533e764f931136974b618f1";
    };
    meta = {
      license = [ pkgs.lib.licenses.psfl ];
    };
  };
  subvertpy = super.buildPythonPackage {
    name = "subvertpy-0.9.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://code.rhodecode.com/upstream/subvertpy/archive/subvertpy-0.9.3.tar.gz?md5=4e49da2fe07608239cc9a80a7bb8f33c";
      md5 = "4e49da2fe07608239cc9a80a7bb8f33c";
    };
    meta = {
      license = [ pkgs.lib.licenses.lgpl21Plus ];
    };
  };
  termcolor = super.buildPythonPackage {
    name = "termcolor-1.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz";
      md5 = "043e89644f8909d462fbbfa511c768df";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  traitlets = super.buildPythonPackage {
    name = "traitlets-4.3.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [ipython-genutils six decorator enum34];
    src = fetchurl {
      url = "https://pypi.python.org/packages/b1/d6/5b5aa6d5c474691909b91493da1e8972e309c9f01ecfe4aeafd272eb3234/traitlets-4.3.1.tar.gz";
      md5 = "dd0b1b6e5d31ce446d55a4b5e5083c98";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  translationstring = super.buildPythonPackage {
    name = "translationstring-1.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz";
      md5 = "a4b62e0f3c189c783a1685b3027f7c90";
    };
    meta = {
      license = [ { fullName = "BSD-like (http://repoze.org/license.html)"; } ];
    };
  };
  venusian = super.buildPythonPackage {
    name = "venusian-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/86/20/1948e0dfc4930ddde3da8c33612f6a5717c0b4bc28f591a5c5cf014dd390/venusian-1.0.tar.gz";
      md5 = "dccf2eafb7113759d60c86faf5538756";
    };
    meta = {
      license = [ { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  waitress = super.buildPythonPackage {
    name = "waitress-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/78/7d/84d11b96c3f60164dec3bef4a859a03aeae0231aa93f57fbe0d05fa4ff36/waitress-1.0.1.tar.gz";
      md5 = "dda92358a7569669086155923a46e57c";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  wcwidth = super.buildPythonPackage {
    name = "wcwidth-0.1.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz";
      md5 = "b3b6a0a08f0c8a34d1de8cf44150a4ad";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  wheel = super.buildPythonPackage {
    name = "wheel-0.29.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c9/1d/bd19e691fd4cfe908c76c429fe6e4436c9e83583c4414b54f6c85471954a/wheel-0.29.0.tar.gz";
      md5 = "555a67e4507cedee23a0deb9651e452f";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  zope.deprecation = super.buildPythonPackage {
    name = "zope.deprecation-4.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c1/d3/3919492d5e57d8dd01b36f30b34fc8404a30577392b1eb817c303499ad20/zope.deprecation-4.1.2.tar.gz";
      md5 = "e9a663ded58f4f9f7881beb56cae2782";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  zope.interface = super.buildPythonPackage {
    name = "zope.interface-4.1.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9d/81/2509ca3c6f59080123c1a8a97125eb48414022618cec0e64eb1313727bfe/zope.interface-4.1.3.tar.gz";
      md5 = "9ae3d24c0c7415deb249dd1a132f0f79";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };

### Test requirements

  
}
