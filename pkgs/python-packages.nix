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
    name = "Jinja2-2.9.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/90/61/f820ff0076a2599dd39406dcb858ecb239438c02ce706c8e91131ab9c7f1/Jinja2-2.9.6.tar.gz";
      md5 = "6411537324b4dba0956aaa8109f3c77b";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  Mako = super.buildPythonPackage {
    name = "Mako-1.0.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/eb/f3/67579bb486517c0d49547f9697e36582cd19dafb5df9e687ed8e22de57fa/Mako-1.0.7.tar.gz";
      md5 = "5836cc997b1b773ef389bf6629c30e65";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  MarkupSafe = super.buildPythonPackage {
    name = "MarkupSafe-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz";
      md5 = "2fcedc9284d50e577b5192e8e3578355";
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
    name = "WebTest-2.0.29";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six WebOb waitress beautifulsoup4];
    src = fetchurl {
      url = "https://pypi.python.org/packages/94/de/8f94738be649997da99c47b104aa3c3984ecec51a1d8153ed09638253d56/WebTest-2.0.29.tar.gz";
      md5 = "30b4cf0d340b9a5335fac4389e6f84fc";
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
  beautifulsoup4 = super.buildPythonPackage {
    name = "beautifulsoup4-4.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/fa/8d/1d14391fdaed5abada4e0f63543fef49b8331a34ca60c88bd521bcf7f782/beautifulsoup4-4.6.0.tar.gz";
      md5 = "c17714d0f91a23b708a592cb3c697728";
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
    name = "decorator-4.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/bb/e0/f6e41e9091e130bf16d4437dabbac3993908e4d6485ecbc985ef1352db94/decorator-4.1.2.tar.gz";
      md5 = "a0f7f4fe00ae2dde93494d90c192cf8c";
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
    name = "gprof2dot-2017.9.19";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9d/36/f977122502979f3dfb50704979c9ed70e6b620787942b089bf1af15f5aba/gprof2dot-2017.9.19.tar.gz";
      md5 = "cda2d552bb0d0b9f16e6824a9aabd225";
    };
    meta = {
      license = [ { fullName = "GNU Lesser General Public License v3 or later (LGPLv3+)"; } { fullName = "LGPL"; } ];
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
    name = "hg-evolve-7.0.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/69/8a/003d4fd5b5d137054b3d768b6ebf4a2f76149b3557bb322689bf3db3e15b/hg-evolve-7.0.0.tar.gz";
      md5 = "2f427fa2cdb30984df26c1258831316f";
    };
    meta = {
      license = [ { fullName = "GPLv2+"; } ];
    };
  };
  hgsubversion = super.buildPythonPackage {
    name = "hgsubversion-1.9";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [mercurial subvertpy];
    src = fetchurl {
      url = "https://pypi.python.org/packages/db/26/7293a6c6b85e2a74ab452e9ba7f00b04ff0e440e6cd4f84131ac5d5e6b22/hgsubversion-1.9.tar.gz";
      md5 = "0c6f93ef12cc2e7fe67286f16bcc7211";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 ];
    };
  };
  hupper = super.buildPythonPackage {
    name = "hupper-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/2e/07/df892c564dc09bb3cf6f6deb976c26adf9117db75ba218cb4353dbc9d826/hupper-1.0.tar.gz";
      md5 = "26e77da7d5ac5858f59af050d1a6eb5a";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
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
    name = "mercurial-4.4";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/ad/a2/26cd147e44acdcaceada23e93ffec49e4f6adfc57db647f3d071db411961/mercurial-4.4.tar.gz";
      md5 = "c1d9fad1b7ed7077b0d4ae82e71154db";
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
    name = "plaster-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/37/e1/56d04382d718d32751017d32f351214384e529b794084eee20bb52405563/plaster-1.0.tar.gz";
      md5 = "80e6beb4760c16fea31754babcc0576e";
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
    name = "prompt-toolkit-1.0.15";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six wcwidth];
    src = fetchurl {
      url = "https://pypi.python.org/packages/8a/ad/cf6b128866e78ad6d7f1dc5b7f99885fb813393d9860778b2984582e81b5/prompt_toolkit-1.0.15.tar.gz";
      md5 = "8fe70295006dbc8afedd43e5eba99032";
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
    name = "py-1.5.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/90/e3/e075127d39d35f09a500ebb4a90afd10f9ef0a1d28a6d09abeec0e444fdd/py-1.5.2.tar.gz";
      md5 = "279ca69c632069e1b71e11b14641ca28";
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
    name = "pyramid-1.9.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools WebOb repoze.lru zope.interface zope.deprecation venusian translationstring PasteDeploy plaster plaster-pastedeploy hupper];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9a/57/73447be9e7d0512d601e3f0a1fb9d7d1efb941911f49efdfe036d2826507/pyramid-1.9.1.tar.gz";
      md5 = "0163e19c58c2d12976a3b6fdb57e052d";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pyramid-jinja2 = super.buildPythonPackage {
    name = "pyramid-jinja2-2.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pyramid zope.deprecation Jinja2 MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/d8/80/d60a7233823de22ce77bd864a8a83736a1fe8b49884b08303a2e68b2c853/pyramid_jinja2-2.7.tar.gz";
      md5 = "c2f8b2cd7b73a6f1d9a311fcfaf4fb92";
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
    name = "pytest-3.2.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [py setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/1f/f8/8cd74c16952163ce0db0bd95fdd8810cbf093c08be00e6e665ebf0dc3138/pytest-3.2.5.tar.gz";
      md5 = "6dbe9bb093883f75394a689a1426ac6f";
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
    name = "pytest-profiling-1.2.11";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six pytest gprof2dot];
    src = fetchurl {
      url = "https://pypi.python.org/packages/c0/4a/b4aa786e93c07a86f1f87c581a36bf355a9e06a9da7e00dbd05047626bd2/pytest-profiling-1.2.11.tar.gz";
      md5 = "9ef6b60248731be5d44477980408e8f7";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-runner = super.buildPythonPackage {
    name = "pytest-runner-3.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/65/b4/ae89338cd2d81e2cc54bd6db2e962bfe948f612303610d68ab24539ac2d1/pytest-runner-3.0.tar.gz";
      md5 = "8f8363a52bbabc4cedd5e239beb2ba11";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-sugar = super.buildPythonPackage {
    name = "pytest-sugar-0.9.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest termcolor];
    src = fetchurl {
      url = "https://pypi.python.org/packages/49/d8/c5ff6cca3ce2ebd8b73eec89779bf6b4a7737456a70e8ea4d44c1ff90f71/pytest-sugar-0.9.0.tar.gz";
      md5 = "89fbff17277fa6a95a560a04b68cb9f9";
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
    name = "repoze.lru-0.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz";
      md5 = "c08cc030387e0b1fc53c5c7d964b35e2";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  rhodecode-vcsserver = super.buildPythonPackage {
    name = "rhodecode-vcsserver-4.11.0";
    buildInputs = with self; [pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage configobj];
    doCheck = true;
    propagatedBuildInputs = with self; [Beaker configobj decorator dulwich hgsubversion hg-evolve infrae.cache mercurial msgpack-python pyramid pyramid-jinja2 pyramid-mako repoze.lru simplejson subprocess32 subvertpy six translationstring WebOb wheel zope.deprecation zope.interface ipdb ipython gevent greenlet gunicorn waitress pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock WebTest cov-core coverage];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  scandir = super.buildPythonPackage {
    name = "scandir-1.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/77/3f/916f524f50ee65e3f465a280d2851bd63685250fddb3020c212b3977664d/scandir-1.6.tar.gz";
      md5 = "0180ddb97c96cbb2d4f25d2ae11c64ac";
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
    name = "six-1.11.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz";
      md5 = "d12789f9baf7e9fb2524c0c64f1773f8";
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
    name = "subvertpy-0.10.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/9d/76/99fa82affce75f5ac0f7dbe513796c3f37311ace0c68e1b063683b4f9b99/subvertpy-0.10.1.tar.gz";
      md5 = "a70e03579902d480f5e9f8c570f6536b";
    };
    meta = {
      license = [ pkgs.lib.licenses.lgpl21Plus pkgs.lib.licenses.gpl2Plus ];
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
    name = "waitress-1.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/3c/68/1c10dd5c556872ceebe88483b0436140048d39de83a84a06a8baa8136f4f/waitress-1.1.0.tar.gz";
      md5 = "0f1eb7fdfdbf2e6d18decbda1733045c";
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
