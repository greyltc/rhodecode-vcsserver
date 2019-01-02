# Generated by pip2nix 0.8.0.dev1
# See https://github.com/johbo/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "atomicwrites" = super.buildPythonPackage {
    name = "atomicwrites-1.2.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ac/ed/a311712ef6b4355035489f665e63e1a73f9eb371929e3c98e5efd451069e/atomicwrites-1.2.1.tar.gz";
      sha256 = "1vmkbw9j0qammwxbxycrs39gvdg4lc2d4lk98kwf8ag2manyi6pc";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "attrs" = super.buildPythonPackage {
    name = "attrs-18.2.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0f/9e/26b1d194aab960063b266170e53c39f73ea0d0d3f5ce23313e0ec8ee9bdf/attrs-18.2.0.tar.gz";
      sha256 = "0s9ydh058wmmf5v391pym877x4ahxg45dw6a0w4c7s5wgpigdjqh";
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
    name = "coverage-4.5.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/35/fe/e7df7289d717426093c68d156e0fd9117c8f4872b6588e8a8928a0f68424/coverage-4.5.1.tar.gz";
      sha256 = "1wbrzpxka3xd4nmmkc6q0ir343d91kymwsm8pbmwa0d2a7q4ir2n";
    };
    meta = {
      license = [ pkgs.lib.licenses.asl20 ];
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
    name = "dogpile.cache-0.6.7";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ee/bd/440da735a11c6087eed7cc8747fc4b995cbac2464168682f8ee1c8e43844/dogpile.cache-0.6.7.tar.gz";
      sha256 = "1aw8rx8vhb75y7zc6gi67g21sw057jdx7i8m3jq7kf3nqavxx9zw";
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
    name = "gevent-1.3.7";
    doCheck = false;
    propagatedBuildInputs = [
      self."greenlet"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/10/c1/9499b146bfa43aa4f1e0ed1bab1bd3209a4861d25650c11725036c731cf5/gevent-1.3.7.tar.gz";
      sha256 = "0b0fr04qdk1p4sniv87fh8z5psac60x01pv054kpgi94520g81iz";
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
    name = "greenlet-0.4.15";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f8/e8/b30ae23b45f69aa3f024b46064c0ac8e5fcb4f22ace0dca8d6f9c8bbe5e7/greenlet-0.4.15.tar.gz";
      sha256 = "1g4g1wwc472ds89zmqlpyan3fbnzpa8qm48z3z1y6mlk44z485ll";
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
    name = "hgsubversion-1.9.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."mercurial"
      self."subvertpy"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a3/53/6d205e641f3e09abcf1ddaed66e5e4b20da22d0145566d440a02c9e35f0d/hgsubversion-1.9.3.tar.gz";
      sha256 = "0nymcjlch8c4zjbncrs30p2nrbylsf25g3h6mr0zzzxr141h3sig";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 ];
    };
  };
  "hupper" = super.buildPythonPackage {
    name = "hupper-1.4.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f1/75/1915dc7650b4867fa3049256e24ca8eddb5989998fcec788cf52b9812dfc/hupper-1.4.2.tar.gz";
      sha256 = "16vb9fkiaakdpcp6pn56h3w0dwvm67bxq2k2dv4i382qhqwphdzb";
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
    name = "markupsafe-1.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ac/7e/1b4c2e05809a4414ebce0892fe1e32c14ace86ca7d50c70f00979ca9b3a3/MarkupSafe-1.1.0.tar.gz";
      sha256 = "1lxirjypbdd3l9jl4vliilhfnhy7c7f2vlldqg1b0i74khn375sf";
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
    name = "pastedeploy-2.0.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/19/a0/5623701df7e2478a68a1b685d1a84518024eef994cde7e4da8449a31616f/PasteDeploy-2.0.1.tar.gz";
      sha256 = "02imfbbx1mi2h546f3sr37m47dk9qizaqhzzlhx8bkzxa6fzn8yl";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pathlib2" = super.buildPythonPackage {
    name = "pathlib2-2.3.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."scandir"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/bf/d7/a2568f4596b75d2c6e2b4094a7e64f620decc7887f69a1f2811931ea15b9/pathlib2-2.3.3.tar.gz";
      sha256 = "0hpp92vqqgcd8h92msm9slv161b1q160igjwnkf2ag6cx0c96695";
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
    name = "pickleshare-0.7.5";
    doCheck = false;
    propagatedBuildInputs = [
      self."pathlib2"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/d8/b6/df3c1c9b616e9c0edbc4fbab6ddd09df9535849c64ba51fcb6531c32d4d8/pickleshare-0.7.5.tar.gz";
      sha256 = "1jmghg3c53yp1i8cm6pcrm280ayi8621rwyav9fac7awjr3kss47";
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
    name = "pluggy-0.8.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/65/25/81d0de17cd00f8ca994a4e74e3c4baf7cd25072c0b831dad5c7d9d6138f8/pluggy-0.8.0.tar.gz";
      sha256 = "1580p47l2zqzsza8jcnw1h2wh3vvmygk6ly8bvi4w0g8j14sjys4";
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
    name = "psutil-5.4.7";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/7d/9a/1e93d41708f8ed2b564395edfa3389f0fd6d567597401c2e5e2775118d8b/psutil-5.4.7.tar.gz";
      sha256 = "0fsgmvzwbdbszkwfnqhib8jcxm4w6zyhvlxlcda0rfm5cyqj4qsv";
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
    name = "py-1.6.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4f/38/5f427d1eedae73063ce4da680d2bae72014995f9fdeaa57809df61c968cd/py-1.6.0.tar.gz";
      sha256 = "1wcs3zv9wl5m5x7p16avqj2gsrviyb23yvc3pr330isqs0sh98q6";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pygments" = super.buildPythonPackage {
    name = "pygments-2.3.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/63/a2/91c31c4831853dedca2a08a0f94d788fc26a48f7281c99a303769ad2721b/Pygments-2.3.0.tar.gz";
      sha256 = "1z34ms51dh4jq4h3cizp7vd1dmsxcbvffkjsd2xxfav22nn6lrl2";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pyramid" = super.buildPythonPackage {
    name = "pyramid-1.10.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."hupper"
      self."plaster"
      self."plaster-pastedeploy"
      self."setuptools"
      self."translationstring"
      self."venusian"
      self."webob"
      self."zope.deprecation"
      self."zope.interface"
      self."repoze.lru"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0a/3e/22e3ac9be1b70a01139adba8906ee4b8f628bb469fea3c52f6c97b73063c/pyramid-1.10.1.tar.gz";
      sha256 = "1h5105nfh6rsrfjiyw20aavyibj36la3hajy6vh1fa77xb4y3hrp";
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
    name = "pytest-3.8.2";
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
      self."pathlib2"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/5f/d2/7f77f406ac505abda02ab4afb50d06ebf304f6ea42fca34f8f37529106b2/pytest-3.8.2.tar.gz";
      sha256 = "18nrwzn61kph2y6gxwfz9ms68rfvr9d4vcffsxng9p7jk9z18clk";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-cov" = super.buildPythonPackage {
    name = "pytest-cov-2.6.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
      self."coverage"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/d9/e2/58f90a316fbd94dd50bf5c826a23f3f5d079fb3cc448c1e9f0e3c33a3d2a/pytest-cov-2.6.0.tar.gz";
      sha256 = "0qnpp9y3ygx4jk4pf5ad71fh2skbvnr6gl54m7rg5qysnx4g0q73";
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
    name = "pytest-timeout-1.3.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/8c/3e/1b6a319d12ae7baa3acb7c18ff2c8630a09471a0319d43535c683b4d03eb/pytest-timeout-1.3.2.tar.gz";
      sha256 = "09wnmzvnls2mnsdz7x3c3sk2zdp6jl4dryvyj5i8hqz16q2zq5qi";
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
    name = "rhodecode-vcsserver-4.16.0";
    buildInputs = [
      self."pytest"
      self."py"
      self."pytest-cov"
      self."pytest-sugar"
      self."pytest-runner"
      self."pytest-profiling"
      self."pytest-timeout"
      self."gprof2dot"
      self."mock"
      self."cov-core"
      self."coverage"
      self."webtest"
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
      self."setproctitle"
      self."ipdb"
      self."ipython"
      self."pytest"
      self."py"
      self."pytest-cov"
      self."pytest-sugar"
      self."pytest-runner"
      self."pytest-profiling"
      self."pytest-timeout"
      self."gprof2dot"
      self."mock"
      self."cov-core"
      self."coverage"
      self."webtest"
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
    name = "setuptools-40.6.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b0/d1/8acb42f391cba52e35b131e442e80deffbb8d0676b93261d761b1f0ef8fb/setuptools-40.6.2.zip";
      sha256 = "0r2c5hapirlzm34h7pl1lgkm6gk7bcrlrdj28qgsvaqg3f74vfw6";
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
    name = "subprocess32-3.5.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c3/5f/7117737fc7114061837a4f51670d863dd7f7f9c762a6546fa8a0dcfe61c8/subprocess32-3.5.2.tar.gz";
      sha256 = "11v62shwmdys48g7ncs3a8jwwnkcl8d4zcwy6dk73z1zy2f9hazb";
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
    name = "webob-1.8.4";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e4/6c/99e322c3d4cc11d9060a67a9bf2f7c9c581f40988c11fffe89bb8c36bc5e/WebOb-1.8.4.tar.gz";
      sha256 = "16cfg5y4n6sihz59vsmns2yqbfm0gfsn3l5xgz2g0pdhilaib0x4";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "webtest" = super.buildPythonPackage {
    name = "webtest-2.0.32";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."webob"
      self."waitress"
      self."beautifulsoup4"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/27/9f/9e74449d272ffbef4fb3012e6dbc53c0b24822d545e7a33a342f80131e59/WebTest-2.0.32.tar.gz";
      sha256 = "0qp0nnbazzm4ibjiyqfcn6f230svk09i4g58zg2i9x1ga06h48a2";
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
