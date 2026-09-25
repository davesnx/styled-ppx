This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".a-8l08bu{offset:none;}"];
  [@css ".a-8l0roh{offset:auto;}"];
  [@css ".a-8lq43b{offset:center;}"];
  [@css ".a-8l2u3l{offset:200px 100px;}"];
  [@css ".a-8lqvfn{offset:margin-box;}"];
  [@css ".a-8lfcn7{offset:border-box;}"];
  [@css ".a-8lin4h{offset:padding-box;}"];
  [@css ".a-8lcd7d{offset:content-box;}"];
  [@css ".a-8lb2is{offset:fill-box;}"];
  [@css ".a-8lbqhs{offset:stroke-box;}"];
  [@css ".a-8leoo7{offset:view-box;}"];
  [@css ".a-8l9jbl{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css ".a-8lkclk{offset:url(\"image.png\");}"];
  [@css ".a-8lin5y{offset:ray(45deg closest-side);}"];
  [@css ".a-8l0jt4{offset:ray(45deg closest-side) 10%;}"];
  [@css ".a-8ldq6h{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css ".a-8lsvdf{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css ".a-8lqvtx{offset:auto / center;}"];
  [@css ".a-8lh264{offset:center / 200px 100px;}"];
  [@css ".a-8lzycc{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css ".a-8l00499ro{offset-path:none;}"];
  [@css ".a-8l004rnrp{offset-path:ray(45deg closest-side);}"];
  [@css ".a-8l004yl6h{offset-path:ray(45deg farthest-side);}"];
  [@css ".a-8l004tk4n{offset-path:ray(45deg closest-corner);}"];
  [@css ".a-8l004a34v{offset-path:ray(45deg farthest-corner);}"];
  [@css ".a-8l004zxur{offset-path:ray(100grad closest-side contain);}"];
  [@css ".a-8l004mbjm{offset-path:margin-box;}"];
  [@css ".a-8l004ghf5{offset-path:border-box;}"];
  [@css ".a-8l0045ixk{offset-path:padding-box;}"];
  [@css ".a-8l0049k08{offset-path:content-box;}"];
  [@css ".a-8l0048rjx{offset-path:fill-box;}"];
  [@css ".a-8l004ee2x{offset-path:stroke-box;}"];
  [@css ".a-8l0043loi{offset-path:view-box;}"];
  [@css ".a-8l0046ry6{offset-path:circle(60%) margin-box;}"];
  [@css ".a-8l002kto5{offset-distance:10%;}"];
  [@css ".a-8l008ibr3{offset-position:auto;}"];
  [@css ".a-8l008z6wa{offset-position:200px;}"];
  [@css ".a-8l0083fe7{offset-position:200px 100px;}"];
  [@css ".a-8l008zfje{offset-position:center;}"];
  [@css ".a-8l00108zo{offset-anchor:auto;}"];
  [@css ".a-8l001vp1o{offset-anchor:200px;}"];
  [@css ".a-8l001ar84{offset-anchor:200px 100px;}"];
  [@css ".a-8l001gyzg{offset-anchor:center;}"];
  [@css ".a-8l00gfec8{offset-rotate:auto;}"];
  [@css ".a-8l00g6haa{offset-rotate:0deg;}"];
  [@css ".a-8l00grfcf{offset-rotate:reverse;}"];
  [@css ".a-8l00gu5ss{offset-rotate:-45deg;}"];
  [@css ".a-8l00geddq{offset-rotate:auto 180deg;}"];
  [@css ".a-8l00g3wxn{offset-rotate:reverse 45deg;}"];
  [@css ".a-8l00gkmna{offset-rotate:2turn reverse;}"];
  
  CSS.make("a-8l08bu", []);
  CSS.make("a-8l0roh", []);
  CSS.make("a-8lq43b", []);
  CSS.make("a-8l2u3l", []);
  
  CSS.make("a-8lqvfn", []);
  CSS.make("a-8lfcn7", []);
  CSS.make("a-8lin4h", []);
  CSS.make("a-8lcd7d", []);
  CSS.make("a-8lb2is", []);
  CSS.make("a-8lbqhs", []);
  CSS.make("a-8leoo7", []);
  
  CSS.make("a-8l9jbl", []);
  CSS.make("a-8lkclk", []);
  CSS.make("a-8lin5y", []);
  CSS.make("a-8l0jt4", []);
  CSS.make("a-8ldq6h", []);
  
  CSS.make("a-8lsvdf", []);
  
  CSS.make("a-8lqvtx", []);
  CSS.make("a-8lh264", []);
  CSS.make("a-8lzycc", []);
  
  CSS.make("a-8l00499ro", []);
  CSS.make("a-8l004rnrp", []);
  CSS.make("a-8l004yl6h", []);
  CSS.make("a-8l004tk4n", []);
  CSS.make("a-8l004a34v", []);
  
  CSS.make("a-8l004zxur", []);
  
  CSS.make("a-8l004mbjm", []);
  CSS.make("a-8l004ghf5", []);
  CSS.make("a-8l0045ixk", []);
  CSS.make("a-8l0049k08", []);
  CSS.make("a-8l0048rjx", []);
  CSS.make("a-8l004ee2x", []);
  CSS.make("a-8l0043loi", []);
  CSS.make("a-8l0046ry6", []);
  
  CSS.make("a-8l002kto5", []);
  CSS.make("a-8l008ibr3", []);
  CSS.make("a-8l008z6wa", []);
  CSS.make("a-8l0083fe7", []);
  CSS.make("a-8l008zfje", []);
  CSS.make("a-8l00108zo", []);
  CSS.make("a-8l001vp1o", []);
  CSS.make("a-8l001ar84", []);
  CSS.make("a-8l001gyzg", []);
  CSS.make("a-8l00gfec8", []);
  CSS.make("a-8l00g6haa", []);
  CSS.make("a-8l00grfcf", []);
  CSS.make("a-8l00gu5ss", []);
  CSS.make("a-8l00geddq", []);
  CSS.make("a-8l00g3wxn", []);
  CSS.make("a-8l00gkmna", []);
