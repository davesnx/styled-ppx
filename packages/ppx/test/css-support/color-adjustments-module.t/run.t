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
      "._a_4fjsr1{-webkit-print-color-adjust:economy;color-adjust:economy;}",
      "_a_4fjsr1",
      "0,1,0 own",
      "159",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4fuoce{-webkit-print-color-adjust:exact;color-adjust:exact;}",
      "_a_4fuoce",
      "0,1,0 own",
      "159",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ejaoo{forced-color-adjust:auto;}",
      "_a_6ejaoo",
      "0,1,0 own",
      "230",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6eg3m8{forced-color-adjust:none;}",
      "_a_6eg3m8",
      "0,1,0 own",
      "230",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6esf9s{forced-color-adjust:preserve-parent-color;}",
      "_a_6esf9s",
      "0,1,0 own",
      "230",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jmdkq{color-scheme:normal;}",
      "_a_4jmdkq",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j0ddm{color-scheme:light;}",
      "_a_4j0ddm",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j8a77{color-scheme:dark;}",
      "_a_4j8a77",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jor4h{color-scheme:light dark;}",
      "_a_4jor4h",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jsghk{color-scheme:dark light;}",
      "_a_4jsghk",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j6avj{color-scheme:only light;}",
      "_a_4j6avj",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jbop6{color-scheme:light only;}",
      "_a_4jbop6",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j24tl{color-scheme:light light;}",
      "_a_4j24tl",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jd4nr{color-scheme:dark dark;}",
      "_a_4jd4nr",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j2q1k{color-scheme:light purple;}",
      "_a_4j2q1k",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jcn74{color-scheme:purple dark interesting;}",
      "_a_4jcn74",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4jh2ut{color-scheme:none;}",
      "_a_4jh2ut",
      "0,1,0 own",
      "163",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4j6jec{color-scheme:light none;}",
      "_a_4j6jec",
      "0,1,0 own",
      "163",
      1,
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
    ]
  ];
  
  CSS.make("_a_4fjsr1", []);
  CSS.make("_a_4fuoce", []);
  CSS.make("_a_6ejaoo", []);
  CSS.make("_a_6eg3m8", []);
  CSS.make("_a_6esf9s", []);
  CSS.make("_a_4jmdkq", []);
  CSS.make("_a_4j0ddm", []);
  CSS.make("_a_4j8a77", []);
  CSS.make("_a_4jor4h", []);
  CSS.make("_a_4jsghk", []);
  CSS.make("_a_4j6avj", []);
  CSS.make("_a_4jbop6", []);
  CSS.make("_a_4j24tl", []);
  CSS.make("_a_4jd4nr", []);
  CSS.make("_a_4j2q1k", []);
  CSS.make("_a_4jcn74", []);
  CSS.make("_a_4jh2ut", []);
  CSS.make("_a_4j6jec", []);
