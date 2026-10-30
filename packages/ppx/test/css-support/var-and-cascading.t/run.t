This test ensures the ppx generates the correct output for CSS var() and cascading keywords
If this test fails, the var() and cascading support is broken

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
      "._a_4en3kf{color:var(--primary-color);}",
      "_a_4en3kf",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_390004fuqy{background-color:var(--bg-color);}",
      "_a_390004fuqy",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7pcrrr{margin:var(--spacing);}",
      "_a_7pcrrr",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_947rr7{padding:var(--padding);}",
      "_a_947rr7",
      "0,1,0 own",
      "328",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_65000wykz8{font-size:var(--font-size);}",
      "_a_65000wykz8",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_ecra93{width:var(--width);}",
      "_a_ecra93",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6lqm6h{height:var(--height);}",
      "_a_6lqm6h",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    ("._a_4ey3yl{color:inherit;}", "_a_4ey3yl", "0,1,0 own", "158", 1, false)
  ];
  [@css
    ("._a_4e8crh{color:initial;}", "_a_4e8crh", "0,1,0 own", "158", 1, false)
  ];
  [@css
    ("._a_4eyg6i{color:unset;}", "_a_4eyg6i", "0,1,0 own", "158", 1, false)
  ];
  [@css
    ("._a_4ejbf2{color:revert;}", "_a_4ejbf2", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_4e07lq{color:revert-layer;}",
      "_a_4e07lq",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    ("._a_5rvscd{display:inherit;}", "_a_5rvscd", "0,1,0 own", "207", 1, false)
  ];
  [@css
    ("._a_5rh118{display:initial;}", "_a_5rh118", "0,1,0 own", "207", 1, false)
  ];
  [@css
    ("._a_5rhxe5{display:unset;}", "_a_5rhxe5", "0,1,0 own", "207", 1, false)
  ];
  [@css
    ("._a_5rcx45{display:revert;}", "_a_5rcx45", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_5rojml{display:revert-layer;}",
      "_a_5rojml",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    ("._a_7pqj8z{margin:inherit;}", "_a_7pqj8z", "0,1,0 own", "277", 15, false)
  ];
  [@css
    ("._a_7pgxfx{margin:initial;}", "_a_7pgxfx", "0,1,0 own", "277", 15, false)
  ];
  [@css
    ("._a_7pzsk3{margin:unset;}", "_a_7pzsk3", "0,1,0 own", "277", 15, false)
  ];
  [@css
    ("._a_7p2sph{margin:revert;}", "_a_7p2sph", "0,1,0 own", "277", 15, false)
  ];
  [@css
    (
      "._a_7pkzq5{margin:revert-layer;}",
      "_a_7pkzq5",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_60nah6{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}",
      "_a_60nah6",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60c6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}",
      "_a_60c6td",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_6042ms{-webkit-flex:unset;-ms-flex:unset;flex:unset;}",
      "_a_6042ms",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_608jui{-webkit-flex:revert;-ms-flex:revert;flex:revert;}",
      "_a_608jui",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_604fps{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}",
      "_a_604fps",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_65000we5f8{font-size:inherit;}",
      "_a_65000we5f8",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_65000w53xd{font-size:initial;}",
      "_a_65000w53xd",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_65000wswxq{font-size:unset;}",
      "_a_65000wswxq",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_65000wntfo{font-size:revert;}",
      "_a_65000wntfo",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_65000wpi5f{font-size:revert-layer;}",
      "_a_65000wpi5f",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (17, "", [12]),
      (18, "", [13]),
      (19, "", [14]),
      (20, "", [15]),
      (21, "", [16]),
      (23, "", [17]),
      (24, "", [18]),
      (25, "", [19]),
      (26, "", [20]),
      (27, "", [21]),
      (29, "", [22]),
      (30, "", [23]),
      (31, "", [24]),
      (32, "", [25]),
      (33, "", [26]),
      (35, "", [27]),
      (36, "", [28]),
      (37, "", [29]),
      (38, "", [30]),
      (39, "", [31]),
    ]
  ];
  
  CSS.make("_a_4en3kf", []);
  CSS.make("_a_390004fuqy", []);
  CSS.make("_a_7pcrrr", []);
  CSS.make("_a_947rr7", []);
  CSS.make("_a_65000wykz8", []);
  CSS.make("_a_ecra93", []);
  CSS.make("_a_6lqm6h", []);
  
  CSS.make("_a_4ey3yl", []);
  CSS.make("_a_4e8crh", []);
  CSS.make("_a_4eyg6i", []);
  CSS.make("_a_4ejbf2", []);
  CSS.make("_a_4e07lq", []);
  
  CSS.make("_a_5rvscd", []);
  CSS.make("_a_5rh118", []);
  CSS.make("_a_5rhxe5", []);
  CSS.make("_a_5rcx45", []);
  CSS.make("_a_5rojml", []);
  
  CSS.make("_a_7pqj8z", []);
  CSS.make("_a_7pgxfx", []);
  CSS.make("_a_7pzsk3", []);
  CSS.make("_a_7p2sph", []);
  CSS.make("_a_7pkzq5", []);
  
  CSS.make("_a_60nah6", []);
  CSS.make("_a_60c6td", []);
  CSS.make("_a_6042ms", []);
  CSS.make("_a_608jui", []);
  CSS.make("_a_604fps", []);
  
  CSS.make("_a_65000we5f8", []);
  CSS.make("_a_65000w53xd", []);
  CSS.make("_a_65000wswxq", []);
  CSS.make("_a_65000wntfo", []);
  CSS.make("_a_65000wpi5f", []);
