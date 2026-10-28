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
    (
      "._a_43gwd0{break-before:auto;}",
      "_a_43gwd0",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43sw5z{break-before:avoid;}",
      "_a_43sw5z",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43e3mx{break-before:avoid-page;}",
      "_a_43e3mx",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43u2iv{break-before:page;}",
      "_a_43u2iv",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43acmv{break-before:left;}",
      "_a_43acmv",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43s0v2{break-before:right;}",
      "_a_43s0v2",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43efcv{break-before:recto;}",
      "_a_43efcv",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43wwqb{break-before:verso;}",
      "_a_43wwqb",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43az7b{break-before:avoid-column;}",
      "_a_43az7b",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43inlv{break-before:column;}",
      "_a_43inlv",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43wpn3{break-before:avoid-region;}",
      "_a_43wpn3",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_43bno4{break-before:region;}",
      "_a_43bno4",
      "0,1,0 own",
      "147",
      1,
      false,
    )
  ];
  [@css
    ("._a_42801c{break-after:auto;}", "_a_42801c", "0,1,0 own", "146", 1, false)
  ];
  [@css
    (
      "._a_42f7vs{break-after:avoid;}",
      "_a_42f7vs",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4257zp{break-after:avoid-page;}",
      "_a_4257zp",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    ("._a_42bk6r{break-after:page;}", "_a_42bk6r", "0,1,0 own", "146", 1, false)
  ];
  [@css
    ("._a_42ekzp{break-after:left;}", "_a_42ekzp", "0,1,0 own", "146", 1, false)
  ];
  [@css
    (
      "._a_425qvb{break-after:right;}",
      "_a_425qvb",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_424tvf{break-after:recto;}",
      "_a_424tvf",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_42k4gz{break-after:verso;}",
      "_a_42k4gz",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_42iwkw{break-after:avoid-column;}",
      "_a_42iwkw",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_42l3j6{break-after:column;}",
      "_a_42l3j6",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_42yot9{break-after:avoid-region;}",
      "_a_42yot9",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4298ro{break-after:region;}",
      "_a_4298ro",
      "0,1,0 own",
      "146",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_44fnl3{break-inside:auto;}",
      "_a_44fnl3",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_44n7nl{break-inside:avoid;}",
      "_a_44n7nl",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_441xo4{break-inside:avoid-page;}",
      "_a_441xo4",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_447h5w{break-inside:avoid-column;}",
      "_a_447h5w",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_44pnax{break-inside:avoid-region;}",
      "_a_44pnax",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3sipz1{-webkit-box-decoration-break:slice;box-decoration-break:slice;}",
      "_a_3sipz1",
      "0,1,0 own",
      "136",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3sthfn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}",
      "_a_3sthfn",
      "0,1,0 own",
      "136",
      1,
      false,
    )
  ];
  [@css ("._a_8o262r{orphans:1;}", "_a_8o262r", "0,1,0 own", "312", 1, false)];
  [@css ("._a_8o85qu{orphans:2;}", "_a_8o85qu", "0,1,0 own", "312", 1, false)];
  [@css ("._a_ebq94c{widows:1;}", "_a_ebq94c", "0,1,0 own", "515", 1, false)];
  [@css ("._a_ebmc20{widows:2;}", "_a_ebmc20", "0,1,0 own", "515", 1, false)];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (18, "", [16]),
      (19, "", [17]),
      (20, "", [18]),
      (21, "", [19]),
      (22, "", [20]),
      (23, "", [21]),
      (24, "", [22]),
      (25, "", [23]),
      (26, "", [24]),
      (27, "", [25]),
      (28, "", [26]),
      (29, "", [27]),
      (30, "", [28]),
      (31, "", [29]),
      (32, "", [30]),
      (33, "", [31]),
      (34, "", [32]),
      (36, "", [33]),
      (37, "", [34]),
    ]
  ];
  
  CSS.make("_a_43gwd0", []);
  CSS.make("_a_43sw5z", []);
  CSS.make("_a_43e3mx", []);
  CSS.make("_a_43u2iv", []);
  CSS.make("_a_43acmv", []);
  CSS.make("_a_43s0v2", []);
  CSS.make("_a_43efcv", []);
  CSS.make("_a_43wwqb", []);
  CSS.make("_a_43az7b", []);
  CSS.make("_a_43inlv", []);
  CSS.make("_a_43wpn3", []);
  CSS.make("_a_43bno4", []);
  CSS.make("_a_42801c", []);
  CSS.make("_a_42f7vs", []);
  CSS.make("_a_4257zp", []);
  CSS.make("_a_42bk6r", []);
  CSS.make("_a_42ekzp", []);
  CSS.make("_a_425qvb", []);
  CSS.make("_a_424tvf", []);
  CSS.make("_a_42k4gz", []);
  CSS.make("_a_42iwkw", []);
  CSS.make("_a_42l3j6", []);
  CSS.make("_a_42yot9", []);
  CSS.make("_a_4298ro", []);
  CSS.make("_a_44fnl3", []);
  CSS.make("_a_44n7nl", []);
  CSS.make("_a_441xo4", []);
  CSS.make("_a_447h5w", []);
  CSS.make("_a_44pnax", []);
  CSS.make("_a_3sipz1", []);
  CSS.make("_a_3sthfn", []);
  CSS.make("_a_8o262r", []);
  CSS.make("_a_8o85qu", []);
  
  CSS.make("_a_ebq94c", []);
  CSS.make("_a_ebmc20", []);
