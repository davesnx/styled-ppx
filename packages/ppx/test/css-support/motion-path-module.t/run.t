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
  [@css "._a_8l000499ro{offset-path:none;}"];
  [@css "._a_8l0004rnrp{offset-path:ray(45deg closest-side);}"];
  [@css "._a_8l0004yl6h{offset-path:ray(45deg farthest-side);}"];
  [@css "._a_8l0004tk4n{offset-path:ray(45deg closest-corner);}"];
  [@css "._a_8l0004a34v{offset-path:ray(45deg farthest-corner);}"];
  [@css "._a_8l0004zxur{offset-path:ray(100grad closest-side contain);}"];
  [@css "._a_8l0004mbjm{offset-path:margin-box;}"];
  [@css "._a_8l0004ghf5{offset-path:border-box;}"];
  [@css "._a_8l00045ixk{offset-path:padding-box;}"];
  [@css "._a_8l00049k08{offset-path:content-box;}"];
  [@css "._a_8l00048rjx{offset-path:fill-box;}"];
  [@css "._a_8l0004ee2x{offset-path:stroke-box;}"];
  [@css "._a_8l00043loi{offset-path:view-box;}"];
  [@css "._a_8l00046ry6{offset-path:circle(60%) margin-box;}"];
  [@css "._a_8l0002kto5{offset-distance:10%;}"];
  [@css "._a_8l0008ibr3{offset-position:auto;}"];
  [@css "._a_8l0008z6wa{offset-position:200px;}"];
  [@css "._a_8l00083fe7{offset-position:200px 100px;}"];
  [@css "._a_8l0008zfje{offset-position:center;}"];
  [@css "._a_8l000108zo{offset-anchor:auto;}"];
  [@css "._a_8l0001vp1o{offset-anchor:200px;}"];
  [@css "._a_8l0001ar84{offset-anchor:200px 100px;}"];
  [@css "._a_8l0001gyzg{offset-anchor:center;}"];
  [@css "._a_8l000gfec8{offset-rotate:auto;}"];
  [@css "._a_8l000g6haa{offset-rotate:0deg;}"];
  [@css "._a_8l000grfcf{offset-rotate:reverse;}"];
  [@css "._a_8l000gu5ss{offset-rotate:-45deg;}"];
  [@css "._a_8l000geddq{offset-rotate:auto 180deg;}"];
  [@css "._a_8l000g3wxn{offset-rotate:reverse 45deg;}"];
  [@css "._a_8l000gkmna{offset-rotate:2turn reverse;}"];
  [@css.blocks
    [
      (2, "_a_8l08bu"),
      (3, "_a_8l0roh"),
      (4, "_a_8lq43b"),
      (5, "_a_8l2u3l"),
      (9, "_a_8lqvfn"),
      (10, "_a_8lfcn7"),
      (11, "_a_8lin4h"),
      (12, "_a_8lcd7d"),
      (13, "_a_8lb2is"),
      (14, "_a_8lbqhs"),
      (15, "_a_8leoo7"),
      (17, "_a_8l9jbl"),
      (18, "_a_8lkclk"),
      (19, "_a_8lin5y"),
      (20, "_a_8l0jt4"),
      (21, "_a_8ldq6h"),
      (26, "_a_8lsvdf"),
      (35, "_a_8lqvtx"),
      (36, "_a_8lh264"),
      (37, "_a_8lzycc"),
      (53, "_a_8l000499ro"),
      (54, "_a_8l0004rnrp"),
      (55, "_a_8l0004yl6h"),
      (56, "_a_8l0004tk4n"),
      (57, "_a_8l0004a34v"),
      (60, "_a_8l0004zxur"),
      (65, "_a_8l0004mbjm"),
      (66, "_a_8l0004ghf5"),
      (67, "_a_8l00045ixk"),
      (68, "_a_8l00049k08"),
      (69, "_a_8l00048rjx"),
      (70, "_a_8l0004ee2x"),
      (71, "_a_8l00043loi"),
      (72, "_a_8l00046ry6"),
      (77, "_a_8l0002kto5"),
      (78, "_a_8l0008ibr3"),
      (79, "_a_8l0008z6wa"),
      (80, "_a_8l00083fe7"),
      (81, "_a_8l0008zfje"),
      (82, "_a_8l000108zo"),
      (83, "_a_8l0001vp1o"),
      (84, "_a_8l0001ar84"),
      (85, "_a_8l0001gyzg"),
      (86, "_a_8l000gfec8"),
      (87, "_a_8l000g6haa"),
      (88, "_a_8l000grfcf"),
      (89, "_a_8l000gu5ss"),
      (90, "_a_8l000geddq"),
      (91, "_a_8l000g3wxn"),
      (92, "_a_8l000gkmna"),
    ]
  ];
  
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
  
  CSS.make("_a_8l000499ro", []);
  CSS.make("_a_8l0004rnrp", []);
  CSS.make("_a_8l0004yl6h", []);
  CSS.make("_a_8l0004tk4n", []);
  CSS.make("_a_8l0004a34v", []);
  
  CSS.make("_a_8l0004zxur", []);
  
  CSS.make("_a_8l0004mbjm", []);
  CSS.make("_a_8l0004ghf5", []);
  CSS.make("_a_8l00045ixk", []);
  CSS.make("_a_8l00049k08", []);
  CSS.make("_a_8l00048rjx", []);
  CSS.make("_a_8l0004ee2x", []);
  CSS.make("_a_8l00043loi", []);
  CSS.make("_a_8l00046ry6", []);
  
  CSS.make("_a_8l0002kto5", []);
  CSS.make("_a_8l0008ibr3", []);
  CSS.make("_a_8l0008z6wa", []);
  CSS.make("_a_8l00083fe7", []);
  CSS.make("_a_8l0008zfje", []);
  CSS.make("_a_8l000108zo", []);
  CSS.make("_a_8l0001vp1o", []);
  CSS.make("_a_8l0001ar84", []);
  CSS.make("_a_8l0001gyzg", []);
  CSS.make("_a_8l000gfec8", []);
  CSS.make("_a_8l000g6haa", []);
  CSS.make("_a_8l000grfcf", []);
  CSS.make("_a_8l000gu5ss", []);
  CSS.make("_a_8l000geddq", []);
  CSS.make("_a_8l000g3wxn", []);
  CSS.make("_a_8l000gkmna", []);
