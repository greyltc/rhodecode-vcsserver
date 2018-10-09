# Generated by pip2nix 0.8.0.dev1
# See https://github.com/johbo/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "atomicwrites" = super.buildPythonPackage {
    name = "atomicwrites-1.1.5";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/e1/2d9bc76838e6e6667fde5814aa25d7feb93d6fa471bf6816daac2596e8b2/atomicwrites-1.1.5.tar.gz";
      sha256 = "11bm90fwm2avvf4f3ib8g925w7jr4m11vcsinn1bi6ns4bm32214";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "attrs" = super.buildPythonPackage {
    name = "attrs-18.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e4/ac/a04671e118b57bee87dabca1e0f2d3bda816b7a551036012d0ca24190e71/attrs-18.1.0.tar.gz";
      sha256 = "0yzqz8wv3w1srav5683a55v49i0szkm47dyrnkd56fqs8j8ypl70";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "backports.shutil-get-terminal-size" = super.buildPythonPackage {
    name = "backports.shutil-get-terminal-size-1.0.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz";
      sha256 = "107cmn7g3jnbkp826zlj8rrj19fam301qvaqf0f3905f5217lgki";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "beautifulsoup4" = super.buildPythonPackage {
    name = "beautifulsoup4-4.6.3";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/88/df/86bffad6309f74f3ff85ea69344a078fc30003270c8df6894fca7a3c72ff/beautifulsoup4-4.6.3.tar.gz";
      sha256 = "041dhalzjciw6qyzzq7a2k4h1yvyk76xigp35hv5ibnn448ydy4h";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "configobj" = super.buildPythonPackage {
    name = "configobj-5.0.6";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
    ];
    src = fetchurl {
      url = "https://code.rhodecode.com/upstream/configobj/archive/a11ff0a0bd4fbda9e3a91267e720f88329efb4a6.tar.gz?md5=9916c524ea11a6c418217af6b28d4b3c";
      sha256 = "1hhcxirwvg58grlfr177b3awhbq8hlx1l3lh69ifl1ki7lfd1s1x";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "cov-core" = super.buildPythonPackage {
    name = "cov-core-1.15.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."coverage"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4b/87/13e75a47b4ba1be06f29f6d807ca99638bedc6b57fa491cd3de891ca2923/cov-core-1.15.0.tar.gz";
      sha256 = "0k3np9ymh06yv1ib96sb6wfsxjkqhmik8qfsn119vnhga9ywc52a";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "coverage" = super.buildPythonPackage {
    name = "coverage-3.7.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/09/4f/89b06c7fdc09687bca507dc411c342556ef9c5a3b26756137a4878ff19bf/coverage-3.7.1.tar.gz";
      sha256 = "0knlbq79g2ww6xzsyknj9rirrgrgc983dpa2d9nkdf31mb2a3bni";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "decorator" = super.buildPythonPackage {
    name = "decorator-4.1.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/bb/e0/f6e41e9091e130bf16d4437dabbac3993908e4d6485ecbc985ef1352db94/decorator-4.1.2.tar.gz";
      sha256 = "1d8npb11kxyi36mrvjdpcjij76l5zfyrz2f820brf0l0rcw4vdkw";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "new BSD License"; } ];
    };
  };
  "dogpile.cache" = super.buildPythonPackage {
    name = "dogpile.cache-0.6.6";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/48/ca/604154d835c3668efb8a31bd979b0ea4bf39c2934a40ffecc0662296cb51/dogpile.cache-0.6.6.tar.gz";
      sha256 = "1h8n1lxd4l2qvahfkiinljkqz7pww7w3sgag0j8j9ixbl2h4wk84";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "dogpile.core" = super.buildPythonPackage {
    name = "dogpile.core-0.4.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0e/77/e72abc04c22aedf874301861e5c1e761231c288b5de369c18be8f4b5c9bb/dogpile.core-0.4.1.tar.gz";
      sha256 = "0xpdvg4kr1isfkrh1rfsh7za4q5a5s6l2kf9wpvndbwf3aqjyrdy";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "dulwich" = super.buildPythonPackage {
    name = "dulwich-0.13.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/84/95/732d280eee829dacc954e8109f97b47abcadcca472c2ab013e1635eb4792/dulwich-0.13.0.tar.gz";
      sha256 = "0f1jwvrh549c4rgavkn3wizrch904s73s4fmrxykxy9cw8s57lwf";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl2Plus ];
    };
  };
  "enum34" = super.buildPythonPackage {
    name = "enum34-1.1.6";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz";
      sha256 = "1cgm5ng2gcfrkrm3hc22brl6chdmv67b9zvva9sfs7gn7dwc9n4a";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "funcsigs" = super.buildPythonPackage {
    name = "funcsigs-1.0.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23/funcsigs-1.0.2.tar.gz";
      sha256 = "0l4g5818ffyfmfs1a924811azhjj8ax9xd1cffr1mzd3ycn0zfx7";
    };
    meta = {
      license = [ { fullName = "ASL"; } pkgs.lib.licenses.asl20 ];
    };
  };
  "gevent" = super.buildPythonPackage {
    name = "gevent-1.3.5";
    doCheck = false;
    propagatedBuildInputs = [
      self."greenlet"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e6/0a/fc345c6e6161f84484870dbcaa58e427c10bd9bdcd08a69bed3d6b398bf1/gevent-1.3.5.tar.gz";
      sha256 = "1w3gydxirgd2f60c5yv579w4903ds9s4g3587ik4jby97hgqc5bz";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "gprof2dot" = super.buildPythonPackage {
    name = "gprof2dot-2017.9.19";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/9d/36/f977122502979f3dfb50704979c9ed70e6b620787942b089bf1af15f5aba/gprof2dot-2017.9.19.tar.gz";
      sha256 = "17ih23ld2nzgc3xwgbay911l6lh96jp1zshmskm17n1gg2i7mg6f";
    };
    meta = {
      license = [ { fullName = "GNU Lesser General Public License v3 or later (LGPLv3+)"; } { fullName = "LGPL"; } ];
    };
  };
  "greenlet" = super.buildPythonPackage {
    name = "greenlet-0.4.13";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/13/de/ba92335e9e76040ca7274224942282a80d54f85e342a5e33c5277c7f87eb/greenlet-0.4.13.tar.gz";
      sha256 = "1r412gfx25jrdiv444prmz5a8igrfabwnwqyr6b52ypq7ga87vqg";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "gunicorn" = super.buildPythonPackage {
    name = "gunicorn-19.9.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/47/52/68ba8e5e8ba251e54006a49441f7ccabca83b6bef5aedacb4890596c7911/gunicorn-19.9.0.tar.gz";
      sha256 = "1wzlf4xmn6qjirh5w81l6i6kqjnab1n1qqkh7zsj1yb6gh4n49ps";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "hg-evolve" = super.buildPythonPackage {
    name = "hg-evolve-8.0.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/06/1a/c5c12d8f117426f05285a820ee5a23121882f5381104e86276b72598934f/hg-evolve-8.0.1.tar.gz";
      sha256 = "1brafifb42k71gl7qssb5m3ijnm7y30lfvm90z8xxcr2fgz19p29";
    };
    meta = {
      license = [ { fullName = "GPLv2+"; } ];
    };
  };
  "hgsubversion" = super.buildPythonPackage {
    name = "hgsubversion-1.9.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."mercurial"
      self."subvertpy"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/05/80/3a3cef10dd65e86528ef8d7ac57a41ebc782d0f3c6cfa4fed021aa9fbee0/hgsubversion-1.9.2.tar.gz";
      sha256 = "16490narhq14vskml3dam8g5y3w3hdqj3g8bgm2b0c0i85l1xvcz";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 ];
    };
  };
  "hupper" = super.buildPythonPackage {
    name = "hupper-1.3";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/51/0c/96335b1f2f32245fb871eea5bb9773196505ddb71fad15190056a282df9e/hupper-1.3.tar.gz";
      sha256 = "1pkyrm9c2crc32ps00k1ahnc5clj3pjwiarc7j0x8aykwih7ff10";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "ipdb" = super.buildPythonPackage {
    name = "ipdb-0.11";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
      self."ipython"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/80/fe/4564de08f174f3846364b3add8426d14cebee228f741c27e702b2877e85b/ipdb-0.11.tar.gz";
      sha256 = "02m0l8wrhhd3z7dg3czn5ys1g5pxib516hpshdzp7rxzsxgcd0bh";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "ipython" = super.buildPythonPackage {
    name = "ipython-5.1.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
      self."decorator"
      self."pickleshare"
      self."simplegeneric"
      self."traitlets"
      self."prompt-toolkit"
      self."pygments"
      self."pexpect"
      self."backports.shutil-get-terminal-size"
      self."pathlib2"
      self."pexpect"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/89/63/a9292f7cd9d0090a0f995e1167f3f17d5889dcbc9a175261719c513b9848/ipython-5.1.0.tar.gz";
      sha256 = "0qdrf6aj9kvjczd5chj1my8y2iq09am9l8bb2a1334a52d76kx3y";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "ipython-genutils" = super.buildPythonPackage {
    name = "ipython-genutils-0.2.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz";
      sha256 = "1a4bc9y8hnvq6cp08qs4mckgm6i6ajpndp4g496rvvzcfmp12bpb";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "mako" = super.buildPythonPackage {
    name = "mako-1.0.7";
    doCheck = false;
    propagatedBuildInputs = [
      self."markupsafe"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/eb/f3/67579bb486517c0d49547f9697e36582cd19dafb5df9e687ed8e22de57fa/Mako-1.0.7.tar.gz";
      sha256 = "1bi5gnr8r8dva06qpyx4kgjc6spm2k1y908183nbbaylggjzs0jf";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "markupsafe" = super.buildPythonPackage {
    name = "markupsafe-1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz";
      sha256 = "0rdn1s8x9ni7ss8rfiacj7x1085lx8mh2zdwqslnw8xc3l4nkgm6";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "mercurial" = super.buildPythonPackage {
    name = "mercurial-4.6.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/d9/fb/c7ecf2b7fd349878dbf45b8390b8db735cef73d49dd9ce8a364b4ca3a846/mercurial-4.6.2.tar.gz";
      sha256 = "1bv6wgcdx8glihjjfg22khhc52mclsn4kwfqvzbzlg0b42h4xl0w";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 pkgs.lib.licenses.gpl2Plus ];
    };
  };
  "mock" = super.buildPythonPackage {
    name = "mock-1.0.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a2/52/7edcd94f0afb721a2d559a5b9aae8af4f8f2c79bc63fdbe8a8a6c9b23bbe/mock-1.0.1.tar.gz";
      sha256 = "0kzlsbki6q0awf89rc287f3aj8x431lrajf160a70z0ikhnxsfdq";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "more-itertools" = super.buildPythonPackage {
    name = "more-itertools-4.3.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/88/ff/6d485d7362f39880810278bdc906c13300db05485d9c65971dec1142da6a/more-itertools-4.3.0.tar.gz";
      sha256 = "17h3na0rdh8xq30w4b9pizgkdxmm51896bxw600x84jflg9vaxn4";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "msgpack-python" = super.buildPythonPackage {
    name = "msgpack-python-0.5.6";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/8a/20/6eca772d1a5830336f84aca1d8198e5a3f4715cd1c7fc36d3cc7f7185091/msgpack-python-0.5.6.tar.gz";
      sha256 = "16wh8qgybmfh4pjp8vfv78mdlkxfmcasg78lzlnm6nslsfkci31p";
    };
    meta = {
      license = [ pkgs.lib.licenses.asl20 ];
    };
  };
  "pastedeploy" = super.buildPythonPackage {
    name = "pastedeploy-1.5.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0f/90/8e20cdae206c543ea10793cbf4136eb9a8b3f417e04e40a29d72d9922cbd/PasteDeploy-1.5.2.tar.gz";
      sha256 = "1jz3m4hq8v6hyhfjz9425nd3nvn52cvbfipdcd72krjmla4qz1fm";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pathlib2" = super.buildPythonPackage {
    name = "pathlib2-2.3.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."scandir"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/14/df0deb867c2733f7d857523c10942b3d6612a1b222502fdffa9439943dfb/pathlib2-2.3.0.tar.gz";
      sha256 = "1cx5gs2v9j2vnzmcrbq5l8fq2mwrr1h6pyf1sjdji2w1bavm09fk";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pexpect" = super.buildPythonPackage {
    name = "pexpect-4.6.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."ptyprocess"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/89/43/07d07654ee3e25235d8cea4164cdee0ec39d1fda8e9203156ebe403ffda4/pexpect-4.6.0.tar.gz";
      sha256 = "1fla85g47iaxxpjhp9vkxdnv4pgc7rplfy6ja491smrrk0jqi3ia";
    };
    meta = {
      license = [ pkgs.lib.licenses.isc { fullName = "ISC License (ISCL)"; } ];
    };
  };
  "pickleshare" = super.buildPythonPackage {
    name = "pickleshare-0.7.4";
    doCheck = false;
    propagatedBuildInputs = [
      self."pathlib2"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz";
      sha256 = "0yvk14dzxk7g6qpr7iw23vzqbsr0dh4ij4xynkhnzpfz4xr2bac4";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "plaster" = super.buildPythonPackage {
    name = "plaster-1.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/37/e1/56d04382d718d32751017d32f351214384e529b794084eee20bb52405563/plaster-1.0.tar.gz";
      sha256 = "1hy8k0nv2mxq94y5aysk6hjk9ryb4bsd13g83m60hcyzxz3wflc3";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "plaster-pastedeploy" = super.buildPythonPackage {
    name = "plaster-pastedeploy-0.6";
    doCheck = false;
    propagatedBuildInputs = [
      self."pastedeploy"
      self."plaster"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3f/e7/6a6833158d2038ec40085433308a1e164fd1dac595513f6dd556d5669bb8/plaster_pastedeploy-0.6.tar.gz";
      sha256 = "1bkggk18f4z2bmsmxyxabvf62znvjwbivzh880419r3ap0616cf2";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pluggy" = super.buildPythonPackage {
    name = "pluggy-0.6.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz";
      sha256 = "1zqckndfn85l1cd8pndw212zg1bq9fkg1nnj32kp2mppppsyg2kz";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "prompt-toolkit" = super.buildPythonPackage {
    name = "prompt-toolkit-1.0.15";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."wcwidth"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/8a/ad/cf6b128866e78ad6d7f1dc5b7f99885fb813393d9860778b2984582e81b5/prompt_toolkit-1.0.15.tar.gz";
      sha256 = "05v9h5nydljwpj5nm8n804ms0glajwfy1zagrzqrg91wk3qqi1c5";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "psutil" = super.buildPythonPackage {
    name = "psutil-5.4.6";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/51/9e/0f8f5423ce28c9109807024f7bdde776ed0b1161de20b408875de7e030c3/psutil-5.4.6.tar.gz";
      sha256 = "1xmw4qi6hnrhw81xqzkvmsm9im7j2vkk4v26ycjwq2jczqsmlvk8";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "ptyprocess" = super.buildPythonPackage {
    name = "ptyprocess-0.6.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/7d/2d/e4b8733cf79b7309d84c9081a4ab558c89d8c89da5961bf4ddb050ca1ce0/ptyprocess-0.6.0.tar.gz";
      sha256 = "1h4lcd3w5nrxnsk436ar7fwkiy5rfn5wj2xwy9l0r4mdqnf2jgwj";
    };
    meta = {
      license = [  ];
    };
  };
  "py" = super.buildPythonPackage {
    name = "py-1.5.3";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f7/84/b4c6e84672c4ceb94f727f3da8344037b62cee960d80e999b1cd9b832d83/py-1.5.3.tar.gz";
      sha256 = "10gq2lckvgwlk9w6yzijhzkarx44hsaknd0ypa08wlnpjnsgmj99";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pygments" = super.buildPythonPackage {
    name = "pygments-2.2.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz";
      sha256 = "1k78qdvir1yb1c634nkv6rbga8wv4289xarghmsbbvzhvr311bnv";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pyramid" = super.buildPythonPackage {
    name = "pyramid-1.9.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
      self."webob"
      self."repoze.lru"
      self."zope.interface"
      self."zope.deprecation"
      self."venusian"
      self."translationstring"
      self."pastedeploy"
      self."plaster"
      self."plaster-pastedeploy"
      self."hupper"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a0/c1/b321d07cfc4870541989ad131c86a1d593bfe802af0eca9718a0dadfb97a/pyramid-1.9.2.tar.gz";
      sha256 = "09drsl0346nchgxp2j7sa5hlk7mkhfld9wvbd0wicacrp26a92fg";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "pyramid-mako" = super.buildPythonPackage {
    name = "pyramid-mako-1.0.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."pyramid"
      self."mako"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f1/92/7e69bcf09676d286a71cb3bbb887b16595b96f9ba7adbdc239ffdd4b1eb9/pyramid_mako-1.0.2.tar.gz";
      sha256 = "18gk2vliq8z4acblsl6yzgbvnr9rlxjlcqir47km7kvlk1xri83d";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "pytest" = super.buildPythonPackage {
    name = "pytest-3.6.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."py"
      self."six"
      self."setuptools"
      self."attrs"
      self."more-itertools"
      self."atomicwrites"
      self."pluggy"
      self."funcsigs"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/67/6a/5bcdc22f8dbada1d2910d6e1a3a03f6b14306c78f81122890735b28be4bf/pytest-3.6.0.tar.gz";
      sha256 = "0bdfazvjjbxssqzyvkb3m2x2in7xv56ipr899l00s87k7815sm9r";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-cov" = super.buildPythonPackage {
    name = "pytest-cov-2.5.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
      self."coverage"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz";
      sha256 = "0bbfpwdh9k3636bxc88vz9fa7vf4akchgn513ql1vd0xy4n7bah3";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.mit ];
    };
  };
  "pytest-profiling" = super.buildPythonPackage {
    name = "pytest-profiling-1.3.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."pytest"
      self."gprof2dot"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f5/34/4626126e041a51ef50a80d0619519b18d20aef249aac25b0d0fdd47e57ee/pytest-profiling-1.3.0.tar.gz";
      sha256 = "08r5afx5z22yvpmsnl91l4amsy1yxn8qsmm61mhp06mz8zjs51kb";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-runner" = super.buildPythonPackage {
    name = "pytest-runner-4.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/9e/b7/fe6e8f87f9a756fd06722216f1b6698ccba4d269eac6329d9f0c441d0f93/pytest-runner-4.2.tar.gz";
      sha256 = "1gkpyphawxz38ni1gdq1fmwyqcg02m7ypzqvv46z06crwdxi2gyj";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-sugar" = super.buildPythonPackage {
    name = "pytest-sugar-0.9.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
      self."termcolor"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3e/6a/a3f909083079d03bde11d06ab23088886bbe25f2c97fbe4bb865e2bf05bc/pytest-sugar-0.9.1.tar.gz";
      sha256 = "0b4av40dv30727m54v211r0nzwjp2ajkjgxix6j484qjmwpw935b";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pytest-timeout" = super.buildPythonPackage {
    name = "pytest-timeout-1.2.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/be/e9/a9106b8bc87521c6813060f50f7d1fdc15665bc1bbbe71c0ffc1c571aaa2/pytest-timeout-1.2.1.tar.gz";
      sha256 = "1kdp6qbh5v1168l99rba5yfzvy05gmzkmkhldgp36p9xcdjd5dv8";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit { fullName = "DFSG approved"; } ];
    };
  };
  "repoze.lru" = super.buildPythonPackage {
    name = "repoze.lru-0.7";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz";
      sha256 = "0xzz1aw2smy8hdszrq8yhnklx6w1r1mf55061kalw3iq35gafa84";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "rhodecode-vcsserver" = super.buildPythonPackage {
    name = "rhodecode-vcsserver-4.13.3";
    buildInputs = [
      self."pytest"
      self."py"
      self."pytest-cov"
      self."pytest-sugar"
      self."pytest-runner"
      self."pytest-profiling"
      self."gprof2dot"
      self."pytest-timeout"
      self."mock"
      self."webtest"
      self."cov-core"
      self."coverage"
      self."configobj"
    ];
    doCheck = true;
    propagatedBuildInputs = [
      self."configobj"
      self."atomicwrites"
      self."attrs"
      self."dogpile.cache"
      self."dogpile.core"
      self."decorator"
      self."dulwich"
      self."hgsubversion"
      self."hg-evolve"
      self."mako"
      self."markupsafe"
      self."mercurial"
      self."msgpack-python"
      self."pastedeploy"
      self."psutil"
      self."pyramid"
      self."pyramid-mako"
      self."pygments"
      self."pathlib2"
      self."repoze.lru"
      self."simplejson"
      self."subprocess32"
      self."setproctitle"
      self."subvertpy"
      self."six"
      self."translationstring"
      self."webob"
      self."zope.deprecation"
      self."zope.interface"
      self."gevent"
      self."greenlet"
      self."gunicorn"
      self."waitress"
      self."ipdb"
      self."ipython"
      self."pytest"
      self."py"
      self."pytest-cov"
      self."pytest-sugar"
      self."pytest-runner"
      self."pytest-profiling"
      self."gprof2dot"
      self."pytest-timeout"
      self."mock"
      self."webtest"
      self."cov-core"
      self."coverage"
    ];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  "scandir" = super.buildPythonPackage {
    name = "scandir-1.9.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/16/2a/557af1181e6b4e30254d5a6163b18f5053791ca66e251e77ab08887e8fe3/scandir-1.9.0.tar.gz";
      sha256 = "0r3hvf1a9jm1rkqgx40gxkmccknkaiqjavs8lccgq9s8khh5x5s4";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "New BSD License"; } ];
    };
  };
  "setproctitle" = super.buildPythonPackage {
    name = "setproctitle-1.1.10";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/5a/0d/dc0d2234aacba6cf1a729964383e3452c52096dc695581248b548786f2b3/setproctitle-1.1.10.tar.gz";
      sha256 = "163kplw9dcrw0lffq1bvli5yws3rngpnvrxrzdw89pbphjjvg0v2";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "setuptools" = super.buildPythonPackage {
    name = "setuptools-40.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/5a/df/b2e3d9693bb0dcbeac516a73dd7a9eb82b126ae52e4a74605a9b01beddd5/setuptools-40.1.0.zip";
      sha256 = "0w1blx5ajga5y15dci0mddk49cf2xpq0mp7rp7jrqr2diqk00ib6";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "simplegeneric" = super.buildPythonPackage {
    name = "simplegeneric-0.8.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip";
      sha256 = "0wwi1c6md4vkbcsfsf8dklf3vr4mcdj4mpxkanwgb6jb1432x5yw";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };
  "simplejson" = super.buildPythonPackage {
    name = "simplejson-3.11.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/08/48/c97b668d6da7d7bebe7ea1817a6f76394b0ec959cb04214ca833c34359df/simplejson-3.11.1.tar.gz";
      sha256 = "1rr58dppsq73p0qcd9bsw066cdd3v63sqv7j6sqni8frvm4jv8h1";
    };
    meta = {
      license = [ { fullName = "Academic Free License (AFL)"; } pkgs.lib.licenses.mit ];
    };
  };
  "six" = super.buildPythonPackage {
    name = "six-1.11.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz";
      sha256 = "1scqzwc51c875z23phj48gircqjgnn3af8zy2izjwmnlxrxsgs3h";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "subprocess32" = super.buildPythonPackage {
    name = "subprocess32-3.5.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/de/fb/fd3e91507021e2aecdb081d1b920082628d6b8869ead845e3e87b3d2e2ca/subprocess32-3.5.1.tar.gz";
      sha256 = "0wgi3bfnssid1g6h0v803z3k1wjal6il16nr3r9c587cfzwfkv0q";
    };
    meta = {
      license = [ pkgs.lib.licenses.psfl ];
    };
  };
  "subvertpy" = super.buildPythonPackage {
    name = "subvertpy-0.10.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/9d/76/99fa82affce75f5ac0f7dbe513796c3f37311ace0c68e1b063683b4f9b99/subvertpy-0.10.1.tar.gz";
      sha256 = "061ncy9wjz3zyv527avcrdyk0xygyssyy7p1644nhzhwp8zpybij";
    };
    meta = {
      license = [ pkgs.lib.licenses.lgpl21Plus pkgs.lib.licenses.gpl2Plus ];
    };
  };
  "termcolor" = super.buildPythonPackage {
    name = "termcolor-1.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz";
      sha256 = "0fv1vq14rpqwgazxg4981904lfyp84mnammw7y046491cv76jv8x";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "traitlets" = super.buildPythonPackage {
    name = "traitlets-4.3.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."ipython-genutils"
      self."six"
      self."decorator"
      self."enum34"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a5/98/7f5ef2fe9e9e071813aaf9cb91d1a732e0a68b6c44a32b38cb8e14c3f069/traitlets-4.3.2.tar.gz";
      sha256 = "0dbq7sx26xqz5ixs711k5nc88p8a0nqyz6162pwks5dpcz9d4jww";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "translationstring" = super.buildPythonPackage {
    name = "translationstring-1.3";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz";
      sha256 = "0bdpcnd9pv0131dl08h4zbcwmgc45lyvq3pa224xwan5b3x4rr2f";
    };
    meta = {
      license = [ { fullName = "BSD-like (http://repoze.org/license.html)"; } ];
    };
  };
  "venusian" = super.buildPythonPackage {
    name = "venusian-1.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/38/24/b4b470ab9e0a2e2e9b9030c7735828c8934b4c6b45befd1bb713ec2aeb2d/venusian-1.1.0.tar.gz";
      sha256 = "0zapz131686qm0gazwy8bh11vr57pr89jbwbl50s528sqy9f80lr";
    };
    meta = {
      license = [ { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "waitress" = super.buildPythonPackage {
    name = "waitress-1.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3c/68/1c10dd5c556872ceebe88483b0436140048d39de83a84a06a8baa8136f4f/waitress-1.1.0.tar.gz";
      sha256 = "1a85gyji0kajc3p0s1pwwfm06w4wfxjkvvl4rnrz3h164kbd6g6k";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };
  "wcwidth" = super.buildPythonPackage {
    name = "wcwidth-0.1.7";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz";
      sha256 = "0pn6dflzm609m4r3i8ik5ni9ijjbb5fa3vg1n7hn6vkd49r77wrx";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "webob" = super.buildPythonPackage {
    name = "webob-1.7.4";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/75/34/731e23f52371852dfe7490a61644826ba7fe70fd52a377aaca0f4956ba7f/WebOb-1.7.4.tar.gz";
      sha256 = "1na01ljg04z40il7vcrn8g29vaw7nvg1xvhk64cr4jys5wcay44d";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "webtest" = super.buildPythonPackage {
    name = "webtest-2.0.29";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."webob"
      self."waitress"
      self."beautifulsoup4"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/94/de/8f94738be649997da99c47b104aa3c3984ecec51a1d8153ed09638253d56/WebTest-2.0.29.tar.gz";
      sha256 = "0bcj1ica5lnmj5zbvk46x28kgphcsgh7sfnwjmn0cr94mhawrg6v";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "zope.deprecation" = super.buildPythonPackage {
    name = "zope.deprecation-4.3.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a1/18/2dc5e6bfe64fdc3b79411b67464c55bb0b43b127051a20f7f492ab767758/zope.deprecation-4.3.0.tar.gz";
      sha256 = "095jas41wbxgmw95kwdxqhbc3bgihw2hzj9b3qpdg85apcsf2lkx";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };
  "zope.interface" = super.buildPythonPackage {
    name = "zope.interface-4.5.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ac/8a/657532df378c2cd2a1fe6b12be3b4097521570769d4852ec02c24bd3594e/zope.interface-4.5.0.tar.gz";
      sha256 = "0k67m60ij06wkg82n15qgyn96waf4pmrkhv0njpkfzpmv5q89hsp";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };

### Test requirements

  
}
