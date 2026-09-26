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
  [@css "._a_8l08bu{offset:none;}"];
  [@css "._a_8l0roh{offset:auto;}"];
  [@css "._a_8lq43b{offset:center;}"];
  [@css "._a_8l2u3l{offset:200px 100px;}"];
  [@css "._a_8lqvfn{offset:margin-box;}"];
  [@css "._a_8lfcn7{offset:border-box;}"];
  [@css "._a_8lin4h{offset:padding-box;}"];
  [@css "._a_8lcd7d{offset:content-box;}"];
  [@css "._a_8lb2is{offset:fill-box;}"];
  [@css "._a_8lbqhs{offset:stroke-box;}"];
  [@css "._a_8leoo7{offset:view-box;}"];
  [@css "._a_8l9jbl{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css "._a_8lkclk{offset:url(\"image.png\");}"];
  [@css "._a_8lin5y{offset:ray(45deg closest-side);}"];
  [@css "._a_8l0jt4{offset:ray(45deg closest-side) 10%;}"];
  [@css "._a_8ldq6h{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css "._a_8lsvdf{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css "._a_8lqvtx{offset:auto / center;}"];
  [@css "._a_8lh264{offset:center / 200px 100px;}"];
  [@css "._a_8lzycc{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css "._a_8l00499ro{offset-path:none;}"];
  [@css "._a_8l004rnrp{offset-path:ray(45deg closest-side);}"];
  [@css "._a_8l004yl6h{offset-path:ray(45deg farthest-side);}"];
  [@css "._a_8l004tk4n{offset-path:ray(45deg closest-corner);}"];
  [@css "._a_8l004a34v{offset-path:ray(45deg farthest-corner);}"];
  [@css "._a_8l004zxur{offset-path:ray(100grad closest-side contain);}"];
  [@css "._a_8l004mbjm{offset-path:margin-box;}"];
  [@css "._a_8l004ghf5{offset-path:border-box;}"];
  [@css "._a_8l0045ixk{offset-path:padding-box;}"];
  [@css "._a_8l0049k08{offset-path:content-box;}"];
  [@css "._a_8l0048rjx{offset-path:fill-box;}"];
  [@css "._a_8l004ee2x{offset-path:stroke-box;}"];
  [@css "._a_8l0043loi{offset-path:view-box;}"];
  [@css "._a_8l0046ry6{offset-path:circle(60%) margin-box;}"];
  [@css "._a_8l002kto5{offset-distance:10%;}"];
  [@css "._a_8l008ibr3{offset-position:auto;}"];
  [@css "._a_8l008z6wa{offset-position:200px;}"];
  [@css "._a_8l0083fe7{offset-position:200px 100px;}"];
  [@css "._a_8l008zfje{offset-position:center;}"];
  [@css "._a_8l00108zo{offset-anchor:auto;}"];
  [@css "._a_8l001vp1o{offset-anchor:200px;}"];
  [@css "._a_8l001ar84{offset-anchor:200px 100px;}"];
  [@css "._a_8l001gyzg{offset-anchor:center;}"];
  [@css "._a_8l00gfec8{offset-rotate:auto;}"];
  [@css "._a_8l00g6haa{offset-rotate:0deg;}"];
  [@css "._a_8l00grfcf{offset-rotate:reverse;}"];
  [@css "._a_8l00gu5ss{offset-rotate:-45deg;}"];
  [@css "._a_8l00geddq{offset-rotate:auto 180deg;}"];
  [@css "._a_8l00g3wxn{offset-rotate:reverse 45deg;}"];
  [@css "._a_8l00gkmna{offset-rotate:2turn reverse;}"];
  
  CSS.make("_a_8l08bu", []);
  CSS.make("_a_8l0roh", []);
  CSS.make("_a_8lq43b", []);
  CSS.make("_a_8l2u3l", []);
  
  CSS.make("_a_8lqvfn", []);
  CSS.make("_a_8lfcn7", []);
  CSS.make("_a_8lin4h", []);
  CSS.make("_a_8lcd7d", []);
  CSS.make("_a_8lb2is", []);
  CSS.make("_a_8lbqhs", []);
  CSS.make("_a_8leoo7", []);
  
  CSS.make("_a_8l9jbl", []);
  CSS.make("_a_8lkclk", []);
  CSS.make("_a_8lin5y", []);
  CSS.make("_a_8l0jt4", []);
  CSS.make("_a_8ldq6h", []);
  
  CSS.make("_a_8lsvdf", []);
  
  CSS.make("_a_8lqvtx", []);
  CSS.make("_a_8lh264", []);
  CSS.make("_a_8lzycc", []);
  
  CSS.make("_a_8l00499ro", []);
  CSS.make("_a_8l004rnrp", []);
  CSS.make("_a_8l004yl6h", []);
  CSS.make("_a_8l004tk4n", []);
  CSS.make("_a_8l004a34v", []);
  
  CSS.make("_a_8l004zxur", []);
  
  CSS.make("_a_8l004mbjm", []);
  CSS.make("_a_8l004ghf5", []);
  CSS.make("_a_8l0045ixk", []);
  CSS.make("_a_8l0049k08", []);
  CSS.make("_a_8l0048rjx", []);
  CSS.make("_a_8l004ee2x", []);
  CSS.make("_a_8l0043loi", []);
  CSS.make("_a_8l0046ry6", []);
  
  CSS.make("_a_8l002kto5", []);
  CSS.make("_a_8l008ibr3", []);
  CSS.make("_a_8l008z6wa", []);
  CSS.make("_a_8l0083fe7", []);
  CSS.make("_a_8l008zfje", []);
  CSS.make("_a_8l00108zo", []);
  CSS.make("_a_8l001vp1o", []);
  CSS.make("_a_8l001ar84", []);
  CSS.make("_a_8l001gyzg", []);
  CSS.make("_a_8l00gfec8", []);
  CSS.make("_a_8l00g6haa", []);
  CSS.make("_a_8l00grfcf", []);
  CSS.make("_a_8l00gu5ss", []);
  CSS.make("_a_8l00geddq", []);
  CSS.make("_a_8l00g3wxn", []);
  CSS.make("_a_8l00gkmna", []);
