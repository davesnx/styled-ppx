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
  [@css ("._a_ecmhzu{width:5rem;}", "_a_ecmhzu", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecmtw2{width:5ch;}", "_a_ecmtw2", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecqw8v{width:5vw;}", "_a_ecqw8v", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecjpn0{width:5vh;}", "_a_ecjpn0", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_ecyuy0{width:5vmin;}", "_a_ecyuy0", "0,1,0 own", "516", 1, false)
  ];
  [@css
    ("._a_ecjkyq{width:5vmax;}", "_a_ecjkyq", "0,1,0 own", "516", 1, false)
  ];
  [@css
    (
      "._a_ecqvys{width:calc(1px + 2px);}",
      "_a_ecqvys",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecfuw8{width:calc(5px * 2);}",
      "_a_ecfuw8",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ec3oae{width:calc(5px - 10px);}",
      "_a_ec3oae",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecodca{width:calc(1vw - 1px);}",
      "_a_ecodca",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css ("._a_ectqhb{width:100%;}", "_a_ectqhb", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_941t7g{padding:5rem;}", "_a_941t7g", "0,1,0 own", "328", 15, false)
  ];
  [@css
    ("._a_948q7f{padding:5ch;}", "_a_948q7f", "0,1,0 own", "328", 15, false)
  ];
  [@css
    ("._a_94w8ry{padding:5vw;}", "_a_94w8ry", "0,1,0 own", "328", 15, false)
  ];
  [@css
    ("._a_94vl0f{padding:5vh;}", "_a_94vl0f", "0,1,0 own", "328", 15, false)
  ];
  [@css
    ("._a_94nbv5{padding:5vmin;}", "_a_94nbv5", "0,1,0 own", "328", 15, false)
  ];
  [@css
    ("._a_94tnlf{padding:5vmax;}", "_a_94tnlf", "0,1,0 own", "328", 15, false)
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
      (9, "", [7]),
      (10, "", [7]),
      (11, "", [8]),
      (12, "", [9]),
      (13, "", [10]),
      (14, "", [11]),
      (15, "", [12]),
      (16, "", [13]),
      (17, "", [14]),
      (18, "", [15]),
      (19, "", [16]),
    ]
  ];
  
  CSS.make("_a_ecmhzu", []);
  CSS.make("_a_ecmtw2", []);
  CSS.make("_a_ecqw8v", []);
  CSS.make("_a_ecjpn0", []);
  CSS.make("_a_ecyuy0", []);
  CSS.make("_a_ecjkyq", []);
  CSS.make("_a_ecqvys", []);
  CSS.make("_a_ecfuw8", []);
  CSS.make("_a_ecfuw8", []);
  CSS.make("_a_ec3oae", []);
  CSS.make("_a_ecodca", []);
  CSS.make("_a_ectqhb", []);
  CSS.make("_a_941t7g", []);
  CSS.make("_a_948q7f", []);
  CSS.make("_a_94w8ry", []);
  CSS.make("_a_94vl0f", []);
  CSS.make("_a_94nbv5", []);
  CSS.make("_a_94tnlf", []);

