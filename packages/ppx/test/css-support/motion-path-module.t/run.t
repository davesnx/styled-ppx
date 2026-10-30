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
  [@css
    ("._a_8l08bu{offset:none;}", "_a_8l08bu", "0,1,0 own", "309", 31, false)
  ];
  [@css
    ("._a_8l0roh{offset:auto;}", "_a_8l0roh", "0,1,0 own", "309", 31, false)
  ];
  [@css
    ("._a_8lq43b{offset:center;}", "_a_8lq43b", "0,1,0 own", "309", 31, false)
  ];
  [@css
    (
      "._a_8l2u3l{offset:200px 100px;}",
      "_a_8l2u3l",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lqvfn{offset:margin-box;}",
      "_a_8lqvfn",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lfcn7{offset:border-box;}",
      "_a_8lfcn7",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lin4h{offset:padding-box;}",
      "_a_8lin4h",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lcd7d{offset:content-box;}",
      "_a_8lcd7d",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    ("._a_8lb2is{offset:fill-box;}", "_a_8lb2is", "0,1,0 own", "309", 31, false)
  ];
  [@css
    (
      "._a_8lbqhs{offset:stroke-box;}",
      "_a_8lbqhs",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    ("._a_8leoo7{offset:view-box;}", "_a_8leoo7", "0,1,0 own", "309", 31, false)
  ];
  [@css
    (
      "._a_8l9jbl{offset:path(\"M 20 20 H 80 V 30\");}",
      "_a_8l9jbl",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lkclk{offset:url(\"image.png\");}",
      "_a_8lkclk",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lin5y{offset:ray(45deg closest-side);}",
      "_a_8lin5y",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8l0jt4{offset:ray(45deg closest-side) 10%;}",
      "_a_8l0jt4",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8ldq6h{offset:ray(45deg closest-side) 10% reverse;}",
      "_a_8ldq6h",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lsvdf{offset:ray(45deg closest-side) reverse 10%;}",
      "_a_8lsvdf",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lqvtx{offset:auto / center;}",
      "_a_8lqvtx",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lh264{offset:center / 200px 100px;}",
      "_a_8lh264",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8lzycc{offset:ray(45deg closest-side) / 200px 100px;}",
      "_a_8lzycc",
      "0,1,0 own",
      "309",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_8l000499ro{offset-path:none;}",
      "_a_8l000499ro",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004rnrp{offset-path:ray(45deg closest-side);}",
      "_a_8l0004rnrp",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004yl6h{offset-path:ray(45deg farthest-side);}",
      "_a_8l0004yl6h",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004tk4n{offset-path:ray(45deg closest-corner);}",
      "_a_8l0004tk4n",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004a34v{offset-path:ray(45deg farthest-corner);}",
      "_a_8l0004a34v",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004zxur{offset-path:ray(100grad closest-side contain);}",
      "_a_8l0004zxur",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004mbjm{offset-path:margin-box;}",
      "_a_8l0004mbjm",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004ghf5{offset-path:border-box;}",
      "_a_8l0004ghf5",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l00045ixk{offset-path:padding-box;}",
      "_a_8l00045ixk",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l00049k08{offset-path:content-box;}",
      "_a_8l00049k08",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l00048rjx{offset-path:fill-box;}",
      "_a_8l00048rjx",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0004ee2x{offset-path:stroke-box;}",
      "_a_8l0004ee2x",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l00043loi{offset-path:view-box;}",
      "_a_8l00043loi",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l00046ry6{offset-path:circle(60%) margin-box;}",
      "_a_8l00046ry6",
      "0,1,0 own",
      "309",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8l0002kto5{offset-distance:10%;}",
      "_a_8l0002kto5",
      "0,1,0 own",
      "309",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8l0008ibr3{offset-position:auto;}",
      "_a_8l0008ibr3",
      "0,1,0 own",
      "309",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_8l0008z6wa{offset-position:200px;}",
      "_a_8l0008z6wa",
      "0,1,0 own",
      "309",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_8l00083fe7{offset-position:200px 100px;}",
      "_a_8l00083fe7",
      "0,1,0 own",
      "309",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_8l0008zfje{offset-position:center;}",
      "_a_8l0008zfje",
      "0,1,0 own",
      "309",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_8l000108zo{offset-anchor:auto;}",
      "_a_8l000108zo",
      "0,1,0 own",
      "309",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8l0001vp1o{offset-anchor:200px;}",
      "_a_8l0001vp1o",
      "0,1,0 own",
      "309",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8l0001ar84{offset-anchor:200px 100px;}",
      "_a_8l0001ar84",
      "0,1,0 own",
      "309",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8l0001gyzg{offset-anchor:center;}",
      "_a_8l0001gyzg",
      "0,1,0 own",
      "309",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8l000gfec8{offset-rotate:auto;}",
      "_a_8l000gfec8",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000g6haa{offset-rotate:0deg;}",
      "_a_8l000g6haa",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000grfcf{offset-rotate:reverse;}",
      "_a_8l000grfcf",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000gu5ss{offset-rotate:-45deg;}",
      "_a_8l000gu5ss",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000geddq{offset-rotate:auto 180deg;}",
      "_a_8l000geddq",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000g3wxn{offset-rotate:reverse 45deg;}",
      "_a_8l000g3wxn",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_8l000gkmna{offset-rotate:2turn reverse;}",
      "_a_8l000gkmna",
      "0,1,0 own",
      "309",
      16,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (9, "", [4]),
      (10, "", [5]),
      (11, "", [6]),
      (12, "", [7]),
      (13, "", [8]),
      (14, "", [9]),
      (15, "", [10]),
      (17, "", [11]),
      (18, "", [12]),
      (19, "", [13]),
      (20, "", [14]),
      (21, "", [15]),
      (26, "", [16]),
      (35, "", [17]),
      (36, "", [18]),
      (37, "", [19]),
      (53, "", [20]),
      (54, "", [21]),
      (55, "", [22]),
      (56, "", [23]),
      (57, "", [24]),
      (60, "", [25]),
      (65, "", [26]),
      (66, "", [27]),
      (67, "", [28]),
      (68, "", [29]),
      (69, "", [30]),
      (70, "", [31]),
      (71, "", [32]),
      (72, "", [33]),
      (77, "", [34]),
      (78, "", [35]),
      (79, "", [36]),
      (80, "", [37]),
      (81, "", [38]),
      (82, "", [39]),
      (83, "", [40]),
      (84, "", [41]),
      (85, "", [42]),
      (86, "", [43]),
      (87, "", [44]),
      (88, "", [45]),
      (89, "", [46]),
      (90, "", [47]),
      (91, "", [48]),
      (92, "", [49]),
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
