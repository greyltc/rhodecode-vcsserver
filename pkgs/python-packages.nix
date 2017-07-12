# Generated by pip2nix 0.4.0
# See https://github.com/johbo/pip2nix

{
  Beaker = super.buildPythonPackage {
    name = "Beaker-1.9.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [funcsigs];
    src = fetchurl {
      url = "https://pypi.python.org/packages/93/b2/12de6937b06e9615dbb3cb3a1c9af17f133f435bdef59f4ad42032b6eb49/Beaker-1.9.0.tar.gz";
      md5 = "38b3fcdfa24faf97c6cf66991eb54e9c";
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
  WebOb = super.buildPythonPackage {
    name = "WebOb-1.7.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/46/87/2f96d8d43b2078fae6e1d33fa86b95c228cebed060f4e3c7576cc44ea83b/WebOb-1.7.3.tar.gz";
      md5 = "350028baffc508e3d23c078118e35316";
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
    name = "decorator-4.0.11";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/cc/ac/5a16f1fc0506ff72fcc8fd4e858e3a1c231f224ab79bb7c4c9b2094cc570/decorator-4.0.11.tar.gz";
      md5 = "73644c8f0bd4983d1b6a34b49adec0ae";
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
  funcsigs = super.buildPythonPackage {
    name = "funcsigs-1.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23/funcsigs-1.0.2.tar.gz";
      md5 = "7e583285b1fb8a76305d6d68f4ccc14e";
    };
    meta = {
      license = [ { fullName = "ASL"; } pkgs.lib.licenses.asl20 ];
    };
  };
  gevent = super.buildPythonPackage {
    name = "gevent-1.2.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [greenlet];
    src = fetchurl {
      url = "https://pypi.python.org/packages/1b/92/b111f76e54d2be11375b47b213b56687214f258fd9dae703546d30b837be/gevent-1.2.2.tar.gz";
      md5 = "7f0baf355384fe5ff2ecf66853422554";
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
    name = "greenlet-0.4.12";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/be/76/82af375d98724054b7e273b5d9369346937324f9bcc20980b45b068ef0b0/greenlet-0.4.12.tar.gz";
      md5 = "e8637647d58a26c4a1f51ca393e53c00";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  gunicorn = super.buildPythonPackage {
    name = "gunicorn-19.7.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/30/3a/10bb213cede0cc4d13ac2263316c872a64bf4c819000c8ccd801f1d5f822/gunicorn-19.7.1.tar.gz";
      md5 = "174d3c3cd670a5be0404d84c484e590c";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  hg-evolve = super.buildPythonPackage {
    name = "hg-evolve-6.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c4/31/0673a5657c201ebb46e63c4bba8668f96cf5d7a8a0f8a91892d022ccc32b/hg-evolve-6.0.1.tar.gz";
      md5 = "9c1ce7ac24792abc0eedee09a3344d06";
    };
    meta = {
      license = [ { fullName = "GPLv2+"; } ];
    };
  };
  hgsubversion = super.buildPythonPackage {
    name = "hgsubversion-1.8.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [mercurial subvertpy];
    src = fetchurl {
      url = "https://pypi.python.org/packages/1c/b8/ff4d2e0ec486f9765b410f09728c02a010e7485d68d6154968074498a403/hgsubversion-1.8.7.tar.gz";
      md5 = "289f1c36c13bd6a3435a9be390a77bdc";
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
    name = "ipdb-0.10.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools ipython];
    src = fetchurl {
      url = "https://pypi.python.org/packages/ad/cc/0e7298e1fbf2efd52667c9354a12aa69fb6f796ce230cca03525051718ef/ipdb-0.10.3.tar.gz";
      md5 = "def1f6ac075d54bdee07e6501263d4fa";
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
    name = "ipython-genutils-0.2.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz";
      md5 = "5a4f9781f78466da0ea1a648f3e1f79f";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  mercurial = super.buildPythonPackage {
    name = "mercurial-4.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/88/c1/f0501fd67f5e69346da41ee0bd7b2619ce4bbc9854bb645074c418b9941f/mercurial-4.1.2.tar.gz";
      md5 = "934c99808bdc8385e074b902d59b0d93";
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
    name = "pathlib2-2.3.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six scandir];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a1/14/df0deb867c2733f7d857523c10942b3d6612a1b222502fdffa9439943dfb/pathlib2-2.3.0.tar.gz";
      md5 = "89c90409d11fd5947966b6a30a47d18c";
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
  plaster = super.buildPythonPackage {
    name = "plaster-0.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/99/b3/d7ca1fe31d2b56dba68a238721fda6820770f9c2a3de17a582d4b5b2edcc/plaster-0.5.tar.gz";
      md5 = "c59345a67a860cfcaa1bd6a81451399d";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  plaster-pastedeploy = super.buildPythonPackage {
    name = "plaster-pastedeploy-0.4.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [PasteDeploy plaster];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9d/6e/f8be01ed41c94e6c54ac97cf2eb142a702aae0c8cce31c846f785e525b40/plaster_pastedeploy-0.4.1.tar.gz";
      md5 = "f48d5344b922e56c4978eebf1cd2e0d3";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  prompt-toolkit = super.buildPythonPackage {
    name = "prompt-toolkit-1.0.14";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six wcwidth];
    src = fetchurl {
      url = "https://pypi.python.org/packages/55/56/8c39509b614bda53e638b7500f12577d663ac1b868aef53426fc6a26c3f5/prompt_toolkit-1.0.14.tar.gz";
      md5 = "f24061ae133ed32c6b764e92bd48c496";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  ptyprocess = super.buildPythonPackage {
    name = "ptyprocess-0.5.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/51/83/5d07dc35534640b06f9d9f1a1d2bc2513fb9cc7595a1b0e28ae5477056ce/ptyprocess-0.5.2.tar.gz";
      md5 = "d3b8febae1b8c53b054bd818d0bb8665";
    };
    meta = {
      license = [  ];
    };
  };
  py = super.buildPythonPackage {
    name = "py-1.4.34";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/68/35/58572278f1c097b403879c1e9369069633d1cbad5239b9057944bb764782/py-1.4.34.tar.gz";
      md5 = "d9c3d8f734b0819ff48e355d77bf1730";
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
    name = "pyramid-1.9";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools WebOb repoze.lru zope.interface zope.deprecation venusian translationstring PasteDeploy plaster plaster-pastedeploy hupper];
    src = fetchurl {
      url = "https://pypi.python.org/packages/b0/73/715321e129334f3e41430bede877620175a63ed075fd5d1fd2c25b7cb121/pyramid-1.9.tar.gz";
      md5 = "aa6c7c568f83151af51eb053ac633bc4";
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
    name = "pytest-3.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [py setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/72/2b/2d3155e01f45a5a04427857352ee88220ee39550b2bc078f9db3190aea46/pytest-3.1.2.tar.gz";
      md5 = "c4d179f89043cc925e1c169d03128e02";
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
    name = "pytest-cov-2.5.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest coverage];
    src = fetchurl {
      url = "https://pypi.python.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz";
      md5 = "5acf38d4909e19819eb5c1754fbfc0ac";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.mit ];
    };
  };
  pytest-profiling = super.buildPythonPackage {
    name = "pytest-profiling-1.2.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six pytest gprof2dot];
    src = fetchurl {
      url = "https://pypi.python.org/packages/f9/0d/df67fb9ce16c2cef201693da956321b1bccfbf9a4ead39748b9f9d1d74cb/pytest-profiling-1.2.6.tar.gz";
      md5 = "50eb4c66c3762a2f1a49669bedc0b894";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-runner = super.buildPythonPackage {
    name = "pytest-runner-2.11.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9e/4d/08889e5e27a9f5d6096b9ad257f4dea1faabb03c5ded8f665ead448f5d8a/pytest-runner-2.11.1.tar.gz";
      md5 = "bdb73eb18eca2727944a2dcf963c5a81";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-sugar = super.buildPythonPackage {
    name = "pytest-sugar-0.8.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest termcolor];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a5/b0/b2773dee078f17773a5bf2dfad49b0be57b6354bbd84bbefe4313e509d87/pytest-sugar-0.8.0.tar.gz";
      md5 = "8cafbdad648068e0e44b8fc5f9faae42";
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
    name = "rhodecode-vcsserver-4.9.0";
    buildInputs = with self; [pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage configobj];
    doCheck = true;
    propagatedBuildInputs = with self; [Beaker configobj decorator dulwich hgsubversion hg-evolve infrae.cache mercurial msgpack-python pyramid pyramid-jinja2 pyramid-mako repoze.lru simplejson subprocess32 subvertpy six translationstring WebOb wheel zope.deprecation zope.interface ipdb ipython gevent greenlet gunicorn waitress pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  scandir = super.buildPythonPackage {
    name = "scandir-1.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/bd/f4/3143e0289faf0883228017dbc6387a66d0b468df646645e29e1eb89ea10e/scandir-1.5.tar.gz";
      md5 = "a2713043de681bba6b084be42e7a8a44";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "New BSD License"; } ];
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
    name = "simplejson-3.11.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/08/48/c97b668d6da7d7bebe7ea1817a6f76394b0ec959cb04214ca833c34359df/simplejson-3.11.1.tar.gz";
      md5 = "6e2f1bd5fb0a926facf5d89d217a7183";
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
    name = "subprocess32-3.2.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/b8/2f/49e53b0d0e94611a2dc624a1ad24d41b6d94d0f1b0a078443407ea2214c2/subprocess32-3.2.7.tar.gz";
      md5 = "824c801e479d3e916879aae3e9c15e16";
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
    name = "traitlets-4.3.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [ipython-genutils six decorator enum34];
    src = fetchurl {
      url = "https://pypi.python.org/packages/a5/98/7f5ef2fe9e9e071813aaf9cb91d1a732e0a68b6c44a32b38cb8e14c3f069/traitlets-4.3.2.tar.gz";
      md5 = "3068663f2f38fd939a9eb3a500ccc154";
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
    name = "venusian-1.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/38/24/b4b470ab9e0a2e2e9b9030c7735828c8934b4c6b45befd1bb713ec2aeb2d/venusian-1.1.0.tar.gz";
      md5 = "56bc5e6756e4bda37bcdb94f74a72b8f";
    };
    meta = {
      license = [ { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  waitress = super.buildPythonPackage {
    name = "waitress-1.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/cd/f4/400d00863afa1e03618e31fd7e2092479a71b8c9718b00eb1eeb603746c6/waitress-1.0.2.tar.gz";
      md5 = "b968f39e95d609f6194c6e50425d4bb7";
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
