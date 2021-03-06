# Generated by pip2nix 0.8.0.dev1
# See https://github.com/johbo/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "atomicwrites" = super.buildPythonPackage {
    name = "atomicwrites-1.3.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ec/0f/cd484ac8820fed363b374af30049adc8fd13065720fd4f4c6be8a2309da7/atomicwrites-1.3.0.tar.gz";
      sha256 = "19ngcscdf3jsqmpcxn6zl5b6anmsajb6izp1smcd1n02midl9abm";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "attrs" = super.buildPythonPackage {
    name = "attrs-19.3.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz";
      sha256 = "0wky4h28n7xnr6xv69p9z6kv8bzn50d10c3drmd9ds8gawbcxdzp";
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
  "cffi" = super.buildPythonPackage {
    name = "cffi-1.12.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."pycparser"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/93/1a/ab8c62b5838722f29f3daffcc8d4bd61844aa9b5f437341cc890ceee483b/cffi-1.12.3.tar.gz";
      sha256 = "0x075521fxwv0mfp4cqzk7lvmw4n94bjw601qkcv314z5s182704";
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
      url = "https://code.rhodecode.com/upstream/configobj/artifacts/download/0-012de99a-b1e1-4f64-a5c0-07a98a41b324.tar.gz?md5=6a513f51fe04b2c18cf84c1395a7c626";
      sha256 = "0kqfrdfr14mw8yd8qwq14dv2xghpkjmd3yjsy8dfcbvpcc17xnxp";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "configparser" = super.buildPythonPackage {
    name = "configparser-4.0.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/16/4f/48975536bd488d3a272549eb795ac4a13a5f7fcdc8995def77fbef3532ee/configparser-4.0.2.tar.gz";
      sha256 = "1priacxym85yjcf68hh38w55nqswaxp71ryjyfdk222kg9l85ln7";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "contextlib2" = super.buildPythonPackage {
    name = "contextlib2-0.6.0.post1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/02/54/669207eb72e3d8ae8b38aa1f0703ee87a0e9f88f30d3c0a47bebdb6de242/contextlib2-0.6.0.post1.tar.gz";
      sha256 = "0bhnr2ac7wy5l85ji909gyljyk85n92w8pdvslmrvc8qih4r1x01";
    };
    meta = {
      license = [ pkgs.lib.licenses.psfl ];
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
    name = "coverage-4.5.4";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/85/d5/818d0e603685c4a613d56f065a721013e942088047ff1027a632948bdae6/coverage-4.5.4.tar.gz";
      sha256 = "0p0j4di6h8k6ica7jwwj09azdcg4ycxq60i9qsskmsg94cd9yzg0";
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
    name = "dogpile.cache-0.9.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."decorator"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ac/6a/9ac405686a94b7f009a20a50070a5786b0e1aedc707b88d40d0c4b51a82e/dogpile.cache-0.9.0.tar.gz";
      sha256 = "0sr1fn6b4k5bh0cscd9yi8csqxvj4ngzildav58x5p694mc86j5k";
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
    name = "enum34-1.1.10";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/11/c4/2da1f4952ba476677a42f25cd32ab8aaf0e1c0d0e00b89822b835c7e654c/enum34-1.1.10.tar.gz";
      sha256 = "0j7ji699fwswm4vg6w1v07fkbf8dkzdm6gfh88jvs5nqgr3sgrnc";
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
    name = "gevent-1.5.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."greenlet"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/5a/79/2c63d385d017b5dd7d70983a463dfd25befae70c824fedb857df6e72eff2/gevent-1.5.0.tar.gz";
      sha256 = "0aac3d4vhv5n4rsb6cqzq0d1xx9immqz4fmpddw35yxkwdc450dj";
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
    name = "hg-evolve-9.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/20/36/5a6655975aa0c663be91098d31a0b24841acad44fe896aa2bdee77c6b883/hg-evolve-9.1.0.tar.gz";
      sha256 = "1mna81cmzxxn7s2nwz3g1xgdjlcc1axkvfmwg7gjqghwn3pdraps";
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
    name = "hupper-1.10.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/41/24/ea90fef04706e54bd1635c05c50dc9cf87cda543c59303a03e7aa7dda0ce/hupper-1.10.2.tar.gz";
      sha256 = "0am0p6g5cz6xmcaf04xq8q6dzdd9qz0phj6gcmpsckf2mcyza61q";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "importlib-metadata" = super.buildPythonPackage {
    name = "importlib-metadata-1.6.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."zipp"
      self."pathlib2"
      self."contextlib2"
      self."configparser"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b4/1b/baab42e3cd64c9d5caac25a9d6c054f8324cdc38975a44d600569f1f7158/importlib_metadata-1.6.0.tar.gz";
      sha256 = "07icyggasn38yv2swdrd8z6i0plazmc9adavsdkbqqj91j53ll9l";
    };
    meta = {
      license = [ pkgs.lib.licenses.asl20 ];
    };
  };
  "ipdb" = super.buildPythonPackage {
    name = "ipdb-0.13.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
      self."ipython"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/2c/bb/a3e1a441719ebd75c6dac8170d3ddba884b7ee8a5c0f9aefa7297386627a/ipdb-0.13.2.tar.gz";
      sha256 = "0jcd849rx30y3wcgzsqbn06v0yjlzvb9x3076q0yxpycdwm1ryvp";
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
    name = "mako-1.1.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."markupsafe"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b0/3c/8dcd6883d009f7cae0f3157fb53e9afb05a0d3d33b3db1268ec2e6f4a56b/Mako-1.1.0.tar.gz";
      sha256 = "0jqa3qfpykyn4fmkn0kh6043sfls7br8i2bsdbccazcvk9cijsd3";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "markupsafe" = super.buildPythonPackage {
    name = "markupsafe-1.1.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz";
      sha256 = "0sqipg4fk7xbixqd8kq6rlkxj664d157bdwbh93farcphf92x1r9";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.bsd3 ];
    };
  };
  "mercurial" = super.buildPythonPackage {
    name = "mercurial-5.1.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/22/39/e1a95f6048aa0785b82f5faad8281ae7320894a635cb4a57e19479639c92/mercurial-5.1.1.tar.gz";
      sha256 = "17z42rfjdkrks4grzgac66nfh285zf1pwxd2zwx1p71pw2jqpz1m";
    };
    meta = {
      license = [ pkgs.lib.licenses.gpl1 pkgs.lib.licenses.gpl2Plus ];
    };
  };
  "mock" = super.buildPythonPackage {
    name = "mock-3.0.5";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."funcsigs"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/2e/ab/4fe657d78b270aa6a32f027849513b829b41b0f28d9d8d7f8c3d29ea559a/mock-3.0.5.tar.gz";
      sha256 = "1hrp6j0yrx2xzylfv02qa8kph661m6yq4p0mc8fnimch9j4psrc3";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "OSI Approved :: BSD License"; } ];
    };
  };
  "more-itertools" = super.buildPythonPackage {
    name = "more-itertools-5.0.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/dd/26/30fc0d541d9fdf55faf5ba4b0fd68f81d5bd2447579224820ad525934178/more-itertools-5.0.0.tar.gz";
      sha256 = "1r12cm6mcdwdzz7d47a6g4l437xsvapdlgyhqay3i2nrlv03da9q";
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
  "packaging" = super.buildPythonPackage {
    name = "packaging-20.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."pyparsing"
      self."six"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/65/37/83e3f492eb52d771e2820e88105f605335553fe10422cba9d256faeb1702/packaging-20.3.tar.gz";
      sha256 = "18xpablq278janh03bai9xd4kz9b0yfp6vflazn725ns9x3jna9w";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal { fullName = "BSD or Apache License, Version 2.0"; } pkgs.lib.licenses.asl20 ];
    };
  };
  "pastedeploy" = super.buildPythonPackage {
    name = "pastedeploy-2.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c4/e9/972a1c20318b3ae9edcab11a6cef64308fbae5d0d45ab52c6f8b2b8f35b8/PasteDeploy-2.1.0.tar.gz";
      sha256 = "16qsq5y6mryslmbp5pn35x4z8z3ndp5rpgl42h226879nrw9hmg7";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pathlib2" = super.buildPythonPackage {
    name = "pathlib2-2.3.5";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."scandir"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/94/d8/65c86584e7e97ef824a1845c72bbe95d79f5b306364fa778a3c3e401b309/pathlib2-2.3.5.tar.gz";
      sha256 = "0s4qa8c082fdkb17izh4mfgwrjd1n5pya18wvrbwqdvvb5xs9nbc";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pexpect" = super.buildPythonPackage {
    name = "pexpect-4.8.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."ptyprocess"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e5/9b/ff402e0e930e70467a7178abb7c128709a30dfb22d8777c043e501bc1b10/pexpect-4.8.0.tar.gz";
      sha256 = "032cg337h8awydgypz6f4wx848lw8dyrj4zy988x0lyib4ws8rgw";
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
    name = "plaster-pastedeploy-0.7";
    doCheck = false;
    propagatedBuildInputs = [
      self."pastedeploy"
      self."plaster"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/99/69/2d3bc33091249266a1bd3cf24499e40ab31d54dffb4a7d76fe647950b98c/plaster_pastedeploy-0.7.tar.gz";
      sha256 = "1zg7gcsvc1kzay1ry5p699rg2qavfsxqwl17mqxzr0gzw6j9679r";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pluggy" = super.buildPythonPackage {
    name = "pluggy-0.13.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."importlib-metadata"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz";
      sha256 = "1c35qyhvy27q9ih9n899f3h4sdnpgq027dbiilly2qb5cvgarchm";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "prompt-toolkit" = super.buildPythonPackage {
    name = "prompt-toolkit-1.0.18";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."wcwidth"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c5/64/c170e5b1913b540bf0c8ab7676b21fdd1d25b65ddeb10025c6ca43cccd4c/prompt_toolkit-1.0.18.tar.gz";
      sha256 = "09h1153wgr5x2ny7ds0w2m81n3bb9j8hjb8sjfnrg506r01clkyx";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "psutil" = super.buildPythonPackage {
    name = "psutil-5.7.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c4/b8/3512f0e93e0db23a71d82485ba256071ebef99b227351f0f5540f744af41/psutil-5.7.0.tar.gz";
      sha256 = "03jykdi3dgf1cdal9bv4fq9zjvzj9l9bs99gi5ar81sdl5nc2pk8";
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
    name = "py-1.8.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/f1/5a/87ca5909f400a2de1561f1648883af74345fe96349f34f737cdfc94eba8c/py-1.8.0.tar.gz";
      sha256 = "0lsy1gajva083pzc7csj1cvbmminb7b4l6a0prdzyb3fd829nqyw";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pycparser" = super.buildPythonPackage {
    name = "pycparser-2.20";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz";
      sha256 = "1w0m3xvlrzq4lkbvd1ngfm8mdw64r1yxy6n7djlw6qj5d0km6ird";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pygit2" = super.buildPythonPackage {
    name = "pygit2-0.28.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."cffi"
      self."six"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4c/64/88c2a4eb2d22ca1982b364f41ff5da42d61de791d7eb68140e7f8f7eb721/pygit2-0.28.2.tar.gz";
      sha256 = "11kzj5mjkspvplnpdb6bj8dcj6rgmkk986k8hjcklyg5yaxkz32d";
    };
    meta = {
      license = [ { fullName = "GPLv2 with linking exception"; } ];
    };
  };
  "pygments" = super.buildPythonPackage {
    name = "pygments-2.4.2";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/7e/ae/26808275fc76bf2832deb10d3a3ed3107bc4de01b85dcccbe525f2cd6d1e/Pygments-2.4.2.tar.gz";
      sha256 = "15v2sqm5g12bqa0c7wikfh9ck2nl97ayizy1hpqhmws5gqalq748";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pyparsing" = super.buildPythonPackage {
    name = "pyparsing-2.4.7";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz";
      sha256 = "1hgc8qrbq1ymxbwfbjghv01fm3fbpjwpjwi0bcailxxzhf3yq0y2";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pyramid" = super.buildPythonPackage {
    name = "pyramid-1.10.4";
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
      url = "https://files.pythonhosted.org/packages/c2/43/1ae701c9c6bb3a434358e678a5e72c96e8aa55cf4cb1d2fa2041b5dd38b7/pyramid-1.10.4.tar.gz";
      sha256 = "0rkxs1ajycg2zh1c94xlmls56mx5m161sn8112skj0amza6cn36q";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "pyramid-mako" = super.buildPythonPackage {
    name = "pyramid-mako-1.1.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."pyramid"
      self."mako"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/63/7b/5e2af68f675071a6bad148c1c393928f0ef5fcd94e95cbf53b89d6471a83/pyramid_mako-1.1.0.tar.gz";
      sha256 = "1qj0m091mnii86j2q1d82yir22nha361rvhclvg3s70z8iiwhrh0";
    };
    meta = {
      license = [ { fullName = "Repoze Public License"; } { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "pytest" = super.buildPythonPackage {
    name = "pytest-4.6.5";
    doCheck = false;
    propagatedBuildInputs = [
      self."py"
      self."six"
      self."packaging"
      self."attrs"
      self."atomicwrites"
      self."pluggy"
      self."importlib-metadata"
      self."wcwidth"
      self."funcsigs"
      self."pathlib2"
      self."more-itertools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/2a/c6/1d1f32f6a5009900521b12e6560fb6b7245b0d4bc3fb771acd63d10e30e1/pytest-4.6.5.tar.gz";
      sha256 = "0iykwwfp4h181nd7rsihh2120b0rkawlw7rvbl19sgfspncr3hwg";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-cov" = super.buildPythonPackage {
    name = "pytest-cov-2.7.1";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
      self."coverage"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/bb/0f/3db7ff86801883b21d5353b258c994b1b8e2abbc804e2273b8d0fd19004b/pytest-cov-2.7.1.tar.gz";
      sha256 = "0filvmmyqm715azsl09ql8hy2x7h286n6d8z5x42a1wpvvys83p0";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal pkgs.lib.licenses.mit ];
    };
  };
  "pytest-profiling" = super.buildPythonPackage {
    name = "pytest-profiling-1.7.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."pytest"
      self."gprof2dot"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/39/70/22a4b33739f07f1732a63e33bbfbf68e0fa58cfba9d200e76d01921eddbf/pytest-profiling-1.7.0.tar.gz";
      sha256 = "0abz9gi26jpcfdzgsvwad91555lpgdc8kbymicmms8k2fqa8z4wk";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-runner" = super.buildPythonPackage {
    name = "pytest-runner-5.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/d9/6d/4b41a74b31720e25abd4799be72d54811da4b4d0233e38b75864dcc1f7ad/pytest-runner-5.1.tar.gz";
      sha256 = "0ykfcnpp8c22winj63qzc07l5axwlc9ikl8vn05sc32gv3417815";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "pytest-sugar" = super.buildPythonPackage {
    name = "pytest-sugar-0.9.2";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
      self."termcolor"
      self."packaging"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/55/59/f02f78d1c80f7e03e23177f60624c8106d4f23d124c921df103f65692464/pytest-sugar-0.9.2.tar.gz";
      sha256 = "1asq7yc4g8bx2sn7yy974mhc9ywvaihasjab4inkirdwn9s7mn7w";
    };
    meta = {
      license = [ pkgs.lib.licenses.bsdOriginal ];
    };
  };
  "pytest-timeout" = super.buildPythonPackage {
    name = "pytest-timeout-1.3.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."pytest"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/13/48/7a166eaa29c1dca6cc253e3ba5773ff2e4aa4f567c1ea3905808e95ac5c1/pytest-timeout-1.3.3.tar.gz";
      sha256 = "1cczcjhw4xx5sjkhxlhc5c1bkr7x6fcyx12wrnvwfckshdvblc2a";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit { fullName = "DFSG approved"; } ];
    };
  };
  "redis" = super.buildPythonPackage {
    name = "redis-3.4.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ef/2e/2c0f59891db7db087a7eeaa79bc7c7f2c039e71a2b5b0a41391e9d462926/redis-3.4.1.tar.gz";
      sha256 = "07yaj0j9fs7xdkg5bg926fa990khyigjbp31si8ai20vj8sv7kqd";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
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
    name = "rhodecode-vcsserver-4.22.0";
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
      self."beautifulsoup4"
      self."configobj"
    ];
    doCheck = true;
    propagatedBuildInputs = [
      self."configobj"
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
      self."pyramid"
      self."pyramid-mako"
      self."pygit2"
      self."repoze.lru"
      self."redis"
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
      self."beautifulsoup4"
    ];
    src = ./.;
    meta = {
      license = [ { fullName = "GPL V3"; } { fullName = "GNU General Public License v3 or later (GPLv3+)"; } ];
    };
  };
  "scandir" = super.buildPythonPackage {
    name = "scandir-1.10.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/df/f5/9c052db7bd54d0cbf1bc0bb6554362bba1012d03e5888950a4f5c5dadc4e/scandir-1.10.0.tar.gz";
      sha256 = "1bkqwmf056pkchf05ywbnf659wqlp6lljcdb0y88wr9f0vv32ijd";
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
    name = "setuptools-44.1.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ed/7b/bbf89ca71e722b7f9464ebffe4b5ee20a9e5c9a555a56e2d3914bb9119a6/setuptools-44.1.0.zip";
      sha256 = "1jja896zvd1ppccnjbhkgagxbwchgq6vfamp6qn1hvywq6q9cjkr";
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
    name = "simplejson-3.16.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/e3/24/c35fb1c1c315fc0fffe61ea00d3f88e85469004713dab488dee4f35b0aff/simplejson-3.16.0.tar.gz";
      sha256 = "19cws1syk8jzq2pw43878dv6fjkb0ifvjpx0i9aajix6kc9jkwxi";
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
    name = "subprocess32-3.5.4";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/32/c8/564be4d12629b912ea431f1a50eb8b3b9d00f1a0b1ceff17f266be190007/subprocess32-3.5.4.tar.gz";
      sha256 = "17f7mvwx2271s1wrl0qac3wjqqnrqag866zs3qc8v5wp0k43fagb";
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
    name = "traitlets-4.3.3";
    doCheck = false;
    propagatedBuildInputs = [
      self."ipython-genutils"
      self."six"
      self."decorator"
      self."enum34"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/75/b0/43deb021bc943f18f07cbe3dac1d681626a48997b7ffa1e7fb14ef922b21/traitlets-4.3.3.tar.gz";
      sha256 = "1xsrwgivpkxlbr4dfndfsi098s29yqgswgjc1qqn69yxklvfw8yh";
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
    name = "venusian-1.2.0";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/7e/6f/40a9d43ac77cb51cb62be5b5662d170f43f8037bdc4eab56336c4ca92bb7/venusian-1.2.0.tar.gz";
      sha256 = "0ghyx66g8ikx9nx1mnwqvdcqm11i1vlq0hnvwl50s48bp22q5v34";
    };
    meta = {
      license = [ { fullName = "BSD-derived (http://www.repoze.org/LICENSE.txt)"; } ];
    };
  };
  "waitress" = super.buildPythonPackage {
    name = "waitress-1.3.1";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/a6/e6/708da7bba65898e5d759ade8391b1077e49d07be0b0223c39f5be04def56/waitress-1.3.1.tar.gz";
      sha256 = "1iysl8ka3l4cdrr0r19fh1cv28q41mwpvgsb81ji7k4shkb0k3i7";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };
  "wcwidth" = super.buildPythonPackage {
    name = "wcwidth-0.1.9";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/25/9d/0acbed6e4a4be4fc99148f275488580968f44ddb5e69b8ceb53fc9df55a0/wcwidth-0.1.9.tar.gz";
      sha256 = "1wf5ycjx8s066rdvr0fgz4xds9a8zhs91c4jzxvvymm1c8l8cwzf";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "webob" = super.buildPythonPackage {
    name = "webob-1.8.5";
    doCheck = false;
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/9d/1a/0c89c070ee2829c934cb6c7082287c822e28236a4fcf90063e6be7c35532/WebOb-1.8.5.tar.gz";
      sha256 = "11khpzaxc88q31v25ic330gsf56fwmbdc9b30br8mvp0fmwspah5";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "webtest" = super.buildPythonPackage {
    name = "webtest-2.0.34";
    doCheck = false;
    propagatedBuildInputs = [
      self."six"
      self."webob"
      self."waitress"
      self."beautifulsoup4"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/2c/74/a0e63feee438735d628631e2b70d82280276a930637ac535479e5fad9427/WebTest-2.0.34.tar.gz";
      sha256 = "0x1y2c8z4fmpsny4hbp6ka37si2g10r5r2jwxhvv5mx7g3blq4bi";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "zipp" = super.buildPythonPackage {
    name = "zipp-1.2.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."contextlib2"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/78/08/d52f0ea643bc1068d6dc98b412f4966a9b63255d20911a23ac3220c033c4/zipp-1.2.0.tar.gz";
      sha256 = "1c91lnv1bxjimh8as27hz7bghsjkkbxn1d37xq7in9c82iai0167";
    };
    meta = {
      license = [ pkgs.lib.licenses.mit ];
    };
  };
  "zope.deprecation" = super.buildPythonPackage {
    name = "zope.deprecation-4.4.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/34/da/46e92d32d545dd067b9436279d84c339e8b16de2ca393d7b892bc1e1e9fd/zope.deprecation-4.4.0.tar.gz";
      sha256 = "1pz2cv7gv9y1r3m0bdv7ks1alagmrn5msm5spwdzkb2by0w36i8d";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };
  "zope.interface" = super.buildPythonPackage {
    name = "zope.interface-4.6.0";
    doCheck = false;
    propagatedBuildInputs = [
      self."setuptools"
    ];
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4e/d0/c9d16bd5b38de44a20c6dc5d5ed80a49626fafcb3db9f9efdc2a19026db6/zope.interface-4.6.0.tar.gz";
      sha256 = "1rgh2x3rcl9r0v0499kf78xy86rnmanajf4ywmqb943wpk50sg8v";
    };
    meta = {
      license = [ pkgs.lib.licenses.zpl21 ];
    };
  };

### Test requirements

  
}
