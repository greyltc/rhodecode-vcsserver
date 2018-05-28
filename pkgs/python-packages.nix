# Generated by pip2nix 0.4.0
# See https://github.com/johbo/pip2nix

{
  atomicwrites = super.buildPythonPackage {
    name = "atomicwrites-1.1.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/e1/2d9bc76838e6e6667fde5814aa25d7feb93d6fa471bf6816daac2596e8b2/atomicwrites-1.1.5.tar.gz";
      sha256 = "240831ea22da9ab882b551b31d4225591e5e447a68c5e188db5b89ca1d487585";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  attrs = super.buildPythonPackage {
    name = "attrs-18.1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e4/ac/a04671e118b57bee87dabca1e0f2d3bda816b7a551036012d0ca24190e71/attrs-18.1.0.tar.gz";
      sha256 = "e0d0eb91441a3b53dab4d9b743eafc1ac44476296a2053b6ca3af0b139faf87b";
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
      url = "https://files.pythonhosted.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz";
      sha256 = "713e7a8228ae80341c70586d1cc0a8caa5207346927e23d09dcbcaf18eadec80";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  beaker = super.buildPythonPackage {
    name = "beaker-1.9.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [funcsigs];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ca/14/a626188d0d0c7b55dd7cf1902046c2743bd392a7078bb53073e13280eb1e/Beaker-1.9.1.tar.gz";
      sha256 = "32276ed686ab7203baf60520452903e35d1c3515f632683ea4a5881c8cd55921";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  beautifulsoup4 = super.buildPythonPackage {
    name = "beautifulsoup4-4.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/fa/8d/1d14391fdaed5abada4e0f63543fef49b8331a34ca60c88bd521bcf7f782/beautifulsoup4-4.6.0.tar.gz";
      sha256 = "808b6ac932dccb0a4126558f7dfdcf41710dd44a4ef497a0bb59a77f9f078e89";
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
      url = "https://files.pythonhosted.org/packages/64/61/079eb60459c44929e684fa7d9e2fdca403f67d64dd9dbac27296be2e0fab/configobj-5.0.6.tar.gz";
      sha256 = "a2f5650770e1c87fb335af19a9b7eb73fc05ccf22144eb68db7d00cd2bcb0902";
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
      url = "https://files.pythonhosted.org/packages/4b/87/13e75a47b4ba1be06f29f6d807ca99638bedc6b57fa491cd3de891ca2923/cov-core-1.15.0.tar.gz";
      sha256 = "4a14c67d520fda9d42b0da6134638578caae1d374b9bb462d8de00587dba764c";
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
      url = "https://files.pythonhosted.org/packages/09/4f/89b06c7fdc09687bca507dc411c342556ef9c5a3b26756137a4878ff19bf/coverage-3.7.1.tar.gz";
      sha256 = "d1aea1c4aa61b8366d6a42dd3650622fbf9c634ed24eaf7f379c8b970e5ed44e";
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
      url = "https://files.pythonhosted.org/packages/bb/e0/f6e41e9091e130bf16d4437dabbac3993908e4d6485ecbc985ef1352db94/decorator-4.1.2.tar.gz";
      sha256 = "7cb64d38cb8002971710c8899fbdfb859a23a364b7c99dab19d1f719c2ba16b5";
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
      url = "https://files.pythonhosted.org/packages/84/95/732d280eee829dacc954e8109f97b47abcadcca472c2ab013e1635eb4792/dulwich-0.13.0.tar.gz";
      sha256 = "8ed35334e22cf93e7dcfd5113d8e262041967fe4c3cead5e262c9102f3e63238";
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
      url = "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz";
      sha256 = "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1";
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
      url = "https://files.pythonhosted.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23/funcsigs-1.0.2.tar.gz";
      sha256 = "a7bb0f2cf3a3fd1ab2732cb49eba4252c2af4240442415b4abce3b87022a8f50";
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
      url = "https://files.pythonhosted.org/packages/1b/92/b111f76e54d2be11375b47b213b56687214f258fd9dae703546d30b837be/gevent-1.2.2.tar.gz";
      sha256 = "4791c8ae9c57d6f153354736e1ccab1e2baf6c8d9ae5a77a9ac90f41e2966b2d";
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
      url = "https://files.pythonhosted.org/packages/9d/36/f977122502979f3dfb50704979c9ed70e6b620787942b089bf1af15f5aba/gprof2dot-2017.9.19.tar.gz";
      sha256 = "cebc7aa2782fd813ead415ea1fae3409524343485eadc7fb60ef5bd1e810309e";
    };
    meta = {
      license = [ { fullName = "GNU Lesser General Public License v3 or later (LGPLv3+)"; } { fullName = "LGPL"; } ];
    };
  };
  greenlet = super.buildPythonPackage {
    name = "greenlet-0.4.13";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/13/de/ba92335e9e76040ca7274224942282a80d54f85e342a5e33c5277c7f87eb/greenlet-0.4.13.tar.gz";
      sha256 = "0fef83d43bf87a5196c91e73cb9772f945a4caaff91242766c5916d1dd1381e4";
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
      url = "https://files.pythonhosted.org/packages/30/3a/10bb213cede0cc4d13ac2263316c872a64bf4c819000c8ccd801f1d5f822/gunicorn-19.7.1.tar.gz";
      sha256 = "eee1169f0ca667be05db3351a0960765620dad53f53434262ff8901b68a1b622";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  hg-evolve = super.buildPythonPackage {
    name = "hg-evolve-8.0.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a3/21/551af5378d043eaa4c1901c8c9bc29fe222005ceced9bc2ad7799e7d8f41/hg-evolve-8.0.0.tar.gz";
      sha256 = "7c95f2311b3baa0c8660f61a2624798995b4cf3aa9b12d6de3add9617a2e984a";
    };
    meta = {
      license = [ { fullName = "GPLv2+"; } ];
    };
  };
  hgsubversion = super.buildPythonPackage {
    name = "hgsubversion-1.9.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [mercurial subvertpy];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/92/8e0871f064573a0033b0c769e875b02e50a93a0123ed694f1bfaaffd0d92/hgsubversion-1.9.1.tar.gz";
      sha256 = "832ce824d644d6de987e5e3dde8a7b1f8da5b03ddd74f0194ac1a13d2754356f";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 ];
    };
  };
  hupper = super.buildPythonPackage {
    name = "hupper-1.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/21/0d/b7832396df00564836b204ac23aadd6ff177d1c0e68ce40e5ccaccc1dd86/hupper-1.1.tar.gz";
      sha256 = "e18037fa43fb4af7c00bd262ca6f5d7bcd22debd5d71e43b0fb1437f56e78035";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  infrae.cache = super.buildPythonPackage {
    name = "infrae.cache-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [beaker repoze.lru];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/bb/f0/e7d5e984cf6592fd2807dc7bc44a93f9d18e04e6a61f87fdfb2622422d74/infrae.cache-1.0.1.tar.gz";
      sha256 = "844b1baa0ab7613159c7e2ee368a5ec4d574e409ff86963e1f45f08dacd478b7";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  ipdb = super.buildPythonPackage {
    name = "ipdb-0.11";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools ipython];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/80/fe/4564de08f174f3846364b3add8426d14cebee228f741c27e702b2877e85b/ipdb-0.11.tar.gz";
      sha256 = "7081c65ed7bfe7737f83fa4213ca8afd9617b42ff6b3f1daf9a3419839a2a00a";
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
      url = "https://files.pythonhosted.org/packages/89/63/a9292f7cd9d0090a0f995e1167f3f17d5889dcbc9a175261719c513b9848/ipython-5.1.0.tar.gz";
      sha256 = "7ef4694e1345913182126b219aaa4a0047e191af414256da6772cf249571b961";
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
      url = "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz";
      sha256 = "eb2e116e75ecef9d4d228fdc66af54269afa26ab4463042e33785b887c628ba8";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  mako = super.buildPythonPackage {
    name = "mako-1.0.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [markupsafe];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/eb/f3/67579bb486517c0d49547f9697e36582cd19dafb5df9e687ed8e22de57fa/Mako-1.0.7.tar.gz";
      sha256 = "4e02fde57bd4abb5ec400181e4c314f56ac3e49ba4fb8b0d50bba18cb27d25ae";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  markupsafe = super.buildPythonPackage {
    name = "markupsafe-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz";
      sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  mercurial = super.buildPythonPackage {
    name = "mercurial-4.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/27/f1/a83c40781455ffaf04fc9a000c2ddbae21407d4675667563b17d9706e0ea/mercurial-4.6.tar.gz";
      sha256 = "56ae3b10201adae37ad97fbd759cf3cea4ebe64c57641c059978c7a706ee6b49";
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
      url = "https://files.pythonhosted.org/packages/a2/52/7edcd94f0afb721a2d559a5b9aae8af4f8f2c79bc63fdbe8a8a6c9b23bbe/mock-1.0.1.tar.gz";
      sha256 = "b839dd2d9c117c701430c149956918a423a9863b48b09c90e30a6013e7d2f44f";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  more-itertools = super.buildPythonPackage {
    name = "more-itertools-4.2.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c0/2f/6773347277d76c5ade4414a6c3f785ef27e7f5c4b0870ec7e888e66a8d83/more-itertools-4.2.0.tar.gz";
      sha256 = "2b6b9893337bfd9166bee6a62c2b0c9fe7735dcf85948b387ec8cba30e85d8e8";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  msgpack-python = super.buildPythonPackage {
    name = "msgpack-python-0.4.8";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/21/27/8a1d82041c7a2a51fcc73675875a5f9ea06c2663e02fcfeb708be1d081a0/msgpack-python-0.4.8.tar.gz";
      sha256 = "1a2b19df0f03519ec7f19f826afb935b202d8979b0856c6fb3dc28955799f886";
    };
    meta = {
      license = [ pkgs.lib.licenses.asl20 ];
    };
  };
  pastedeploy = super.buildPythonPackage {
    name = "pastedeploy-1.5.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0f/90/8e20cdae206c543ea10793cbf4136eb9a8b3f417e04e40a29d72d9922cbd/PasteDeploy-1.5.2.tar.gz";
      sha256 = "d5858f89a255e6294e63ed46b73613c56e3b9a2d82a42f1df4d06c8421a9e3cb";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pathlib2 = super.buildPythonPackage {
    name = "pathlib2-2.3.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six scandir];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/14/df0deb867c2733f7d857523c10942b3d6612a1b222502fdffa9439943dfb/pathlib2-2.3.0.tar.gz";
      sha256 = "d32550b75a818b289bd4c1f96b60c89957811da205afcceab75bc8b4857ea5b3";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pexpect = super.buildPythonPackage {
    name = "pexpect-4.5.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [ptyprocess];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/09/0e/75f0c093654988b8f17416afb80f7621bcf7d36bbd6afb4f823acdb4bcdc/pexpect-4.5.0.tar.gz";
      sha256 = "9f8eb3277716a01faafaba553d629d3d60a1a624c7cf45daa600d2148c30020c";
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
      url = "https://files.pythonhosted.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz";
      sha256 = "84a9257227dfdd6fe1b4be1319096c20eb85ff1e82c7932f36efccfe1b09737b";
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
      url = "https://files.pythonhosted.org/packages/37/e1/56d04382d718d32751017d32f351214384e529b794084eee20bb52405563/plaster-1.0.tar.gz";
      sha256 = "8351c7c7efdf33084c1de88dd0f422cbe7342534537b553c49b857b12d98c8c3";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  plaster-pastedeploy = super.buildPythonPackage {
    name = "plaster-pastedeploy-0.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pastedeploy plaster];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e7/05/cc12d9d3efaa10046b6ec5de91b16486c95de4847dc57599bf58021a3d5c/plaster_pastedeploy-0.5.tar.gz";
      sha256 = "70a3185b2a3336996a26e9987968cf35e84cf13390b7e8a0a9a91eb8f6f85ba9";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pluggy = super.buildPythonPackage {
    name = "pluggy-0.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz";
      sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff";
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
      url = "https://files.pythonhosted.org/packages/8a/ad/cf6b128866e78ad6d7f1dc5b7f99885fb813393d9860778b2984582e81b5/prompt_toolkit-1.0.15.tar.gz";
      sha256 = "858588f1983ca497f1cf4ffde01d978a3ea02b01c8a26a8bbc5cd2e66d816917";
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
      url = "https://files.pythonhosted.org/packages/51/83/5d07dc35534640b06f9d9f1a1d2bc2513fb9cc7595a1b0e28ae5477056ce/ptyprocess-0.5.2.tar.gz";
      sha256 = "e64193f0047ad603b71f202332ab5527c5e52aa7c8b609704fc28c0dc20c4365";
    };
    meta = {
      license = [  ];
    };
  };
  py = super.buildPythonPackage {
    name = "py-1.5.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f7/84/b4c6e84672c4ceb94f727f3da8344037b62cee960d80e999b1cd9b832d83/py-1.5.3.tar.gz";
      sha256 = "29c9fab495d7528e80ba1e343b958684f4ace687327e6f789a94bf3d1915f881";
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
      url = "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz";
      sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  pyramid = super.buildPythonPackage {
    name = "pyramid-1.9.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools webob repoze.lru zope.interface zope.deprecation venusian translationstring pastedeploy plaster plaster-pastedeploy hupper];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a0/c1/b321d07cfc4870541989ad131c86a1d593bfe802af0eca9718a0dadfb97a/pyramid-1.9.2.tar.gz";
      sha256 = "cf89a48cb899291639686bf3d4a883b39e496151fa4871fb83cc1a3200d5b925";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pyramid-mako = super.buildPythonPackage {
    name = "pyramid-mako-1.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pyramid mako];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f1/92/7e69bcf09676d286a71cb3bbb887b16595b96f9ba7adbdc239ffdd4b1eb9/pyramid_mako-1.0.2.tar.gz";
      sha256 = "6da0987b9874cf53e72139624665a73965bbd7fbde504d1753e4231ce916f3a1";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  pytest = super.buildPythonPackage {
    name = "pytest-3.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [py six setuptools attrs more-itertools atomicwrites pluggy funcsigs];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/67/6a/5bcdc22f8dbada1d2910d6e1a3a03f6b14306c78f81122890735b28be4bf/pytest-3.6.0.tar.gz";
      sha256 = "39555d023af3200d004d09e51b4dd9fdd828baa863cded3fd6ba2f29f757ae2d";
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
      url = "https://files.pythonhosted.org/packages/f2/2b/2faccdb1a978fab9dd0bf31cca9f6847fbe9184a0bdcc3011ac41dd44191/pytest-catchlog-1.2.2.zip";
      sha256 = "4be15dc5ac1750f83960897f591453040dff044b5966fe24a91c2f7d04ecfcf0";
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
      url = "https://files.pythonhosted.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz";
      sha256 = "03aa752cf11db41d281ea1d807d954c4eda35cfa1b21d6971966cc041bbf6e2d";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.mit ];
    };
  };
  pytest-profiling = super.buildPythonPackage {
    name = "pytest-profiling-1.3.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six pytest gprof2dot];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f5/34/4626126e041a51ef50a80d0619519b18d20aef249aac25b0d0fdd47e57ee/pytest-profiling-1.3.0.tar.gz";
      sha256 = "6b86a2e547bf1a70610da6568d91ed3e785d15a12151abebdd5e885fba532523";
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
      url = "https://files.pythonhosted.org/packages/65/b4/ae89338cd2d81e2cc54bd6db2e962bfe948f612303610d68ab24539ac2d1/pytest-runner-3.0.tar.gz";
      sha256 = "0f7c3a3cf5aead13f54baaa01ceb49e5ae92aba5d3ff1928e81e189c40bc6703";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  pytest-sugar = super.buildPythonPackage {
    name = "pytest-sugar-0.9.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytest termcolor];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3e/6a/a3f909083079d03bde11d06ab23088886bbe25f2c97fbe4bb865e2bf05bc/pytest-sugar-0.9.1.tar.gz";
      sha256 = "ab8cc42faf121344a4e9b13f39a51257f26f410e416c52ea11078cdd00d98a2c";
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
      url = "https://files.pythonhosted.org/packages/cc/b7/b2a61365ea6b6d2e8881360ae7ed8dad0327ad2df89f2f0be4a02304deb2/pytest-timeout-1.2.0.tar.gz";
      sha256 = "c29e3168f10897728059bd6b8ca20b28733d7fe6b8f6c09bb9d89f6146f27cb8";
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
      url = "https://files.pythonhosted.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz";
      sha256 = "0429a75e19380e4ed50c0694e26ac8819b4ea7851ee1fc7583c8572db80aff77";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  rhodecode-vcsserver = super.buildPythonPackage {
    name = "rhodecode-vcsserver-4.13.0";
    buildInputs = with self; [pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock webtest cov-core coverage configobj];
    doCheck = true;
    propagatedBuildInputs = with self; [beaker configobj decorator dulwich hgsubversion hg-evolve infrae.cache mako markupsafe mercurial msgpack-python pastedeploy pyramid pyramid-mako pygments pathlib2 repoze.lru simplejson subprocess32 subvertpy six translationstring webob zope.deprecation zope.interface gevent greenlet gunicorn waitress ipdb ipython pytest py pytest-cov pytest-sugar pytest-runner pytest-catchlog pytest-profiling gprof2dot pytest-timeout mock webtest cov-core coverage];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  scandir = super.buildPythonPackage {
    name = "scandir-1.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/13/bb/e541b74230bbf7a20a3949a2ee6631be299378a784f5445aa5d0047c192b/scandir-1.7.tar.gz";
      sha256 = "b2d55be869c4f716084a19b1e16932f0769711316ba62de941320bf2be84763d";
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
      url = "https://files.pythonhosted.org/packages/1e/43/002c8616db9a3e7be23c2556e39b90a32bb40ba0dc652de1999d5334d372/setuptools-30.1.0.tar.gz";
      sha256 = "73c7f183260cec2ef870128c77106ba7a978649b8c4cddc320ec3547615e885f";
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
      url = "https://files.pythonhosted.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip";
      sha256 = "dc972e06094b9af5b855b3df4a646395e43d1c9d0d39ed345b7393560d0b9173";
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
      url = "https://files.pythonhosted.org/packages/08/48/c97b668d6da7d7bebe7ea1817a6f76394b0ec959cb04214ca833c34359df/simplejson-3.11.1.tar.gz";
      sha256 = "01a22d49ddd9a168b136f26cac87d9a335660ce07aa5c630b8e3607d6f4325e7";
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
      url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz";
      sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9";
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
      url = "https://files.pythonhosted.org/packages/b8/2f/49e53b0d0e94611a2dc624a1ad24d41b6d94d0f1b0a078443407ea2214c2/subprocess32-3.2.7.tar.gz";
      sha256 = "1e450a4a4c53bf197ad6402c564b9f7a53539385918ef8f12bdf430a61036590";
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
      url = "https://files.pythonhosted.org/packages/9d/76/99fa82affce75f5ac0f7dbe513796c3f37311ace0c68e1b063683b4f9b99/subvertpy-0.10.1.tar.gz";
      sha256 = "322e7f3fba1c7e680931e11eefb5f6cf77307dcb6cab23caf67f7cc993673618";
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
      url = "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz";
      sha256 = "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b";
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
      url = "https://files.pythonhosted.org/packages/a5/98/7f5ef2fe9e9e071813aaf9cb91d1a732e0a68b6c44a32b38cb8e14c3f069/traitlets-4.3.2.tar.gz";
      sha256 = "9c4bd2d267b7153df9152698efb1050a5d84982d3384a37b2c1f7723ba3e7835";
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
      url = "https://files.pythonhosted.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz";
      sha256 = "4ee44cfa58c52ade8910ea0ebc3d2d84bdcad9fa0422405b1801ec9b9a65b72d";
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
      url = "https://files.pythonhosted.org/packages/38/24/b4b470ab9e0a2e2e9b9030c7735828c8934b4c6b45befd1bb713ec2aeb2d/venusian-1.1.0.tar.gz";
      sha256 = "9902e492c71a89a241a18b2f9950bea7e41d025cc8f3af1ea8d8201346f8577d";
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
      url = "https://files.pythonhosted.org/packages/3c/68/1c10dd5c556872ceebe88483b0436140048d39de83a84a06a8baa8136f4f/waitress-1.1.0.tar.gz";
      sha256 = "d33cd3d62426c0f1b3cd84ee3d65779c7003aae3fc060dee60524d10a57f05a9";
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
      url = "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz";
      sha256 = "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  webob = super.buildPythonPackage {
    name = "webob-1.7.4";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/75/34/731e23f52371852dfe7490a61644826ba7fe70fd52a377aaca0f4956ba7f/WebOb-1.7.4.tar.gz";
      sha256 = "8d10af182fda4b92193113ee1edeb687ab9dc44336b37d6804e413f0240d40d9";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  webtest = super.buildPythonPackage {
    name = "webtest-2.0.29";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six webob waitress beautifulsoup4];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/94/de/8f94738be649997da99c47b104aa3c3984ecec51a1d8153ed09638253d56/WebTest-2.0.29.tar.gz";
      sha256 = "dbbccc15ac2465066c95dc3a7de0d30cde3791e886ccbd7e91d5d2a2580c922d";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  zope.deprecation = super.buildPythonPackage {
    name = "zope.deprecation-4.3.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/18/2dc5e6bfe64fdc3b79411b67464c55bb0b43b127051a20f7f492ab767758/zope.deprecation-4.3.0.tar.gz";
      sha256 = "7d52e134bbaaa0d72e1e2bc90f0587f1adc116c4bdf15912afaf2f1e8856b224";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };
  zope.interface = super.buildPythonPackage {
    name = "zope.interface-4.5.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ac/8a/657532df378c2cd2a1fe6b12be3b4097521570769d4852ec02c24bd3594e/zope.interface-4.5.0.tar.gz";
      sha256 = "57c38470d9f57e37afb460c399eb254e7193ac7fb8042bd09bdc001981a9c74c";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpt21 ];
    };
  };

### Test requirements

  
}
