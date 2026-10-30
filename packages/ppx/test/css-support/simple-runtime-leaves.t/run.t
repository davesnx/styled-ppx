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
    ("._a_5u2ddt{empty-cells:show;}", "_a_5u2ddt", "0,1,0 own", "210", 1, false)
  ];
  [@css
    ("._a_5uav7h{empty-cells:hide;}", "_a_5uav7h", "0,1,0 own", "210", 1, false)
  ];
  [@css
    (
      "._a_5vzhlp{field-sizing:content;}",
      "_a_5vzhlp",
      "0,1,0 own",
      "211",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5vat5c{field-sizing:fixed;}",
      "_a_5vat5c",
      "0,1,0 own",
      "211",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_797wts{interpolate-size:numeric-only;}",
      "_a_797wts",
      "0,1,0 own",
      "261",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_794lek{interpolate-size:allow-keywords;}",
      "_a_794lek",
      "0,1,0 own",
      "261",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6xo2dy{initial-letter:normal;}",
      "_a_6xo2dy",
      "0,1,0 own",
      "249",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6xwub8{initial-letter:1.5;}",
      "_a_6xwub8",
      "0,1,0 own",
      "249",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6x0l7m{initial-letter:1.5 2;}",
      "_a_6x0l7m",
      "0,1,0 own",
      "249",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ybm9f{initial-letter-align:auto;}",
      "_a_6ybm9f",
      "0,1,0 own",
      "250",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ynpsj{initial-letter-align:alphabetic;}",
      "_a_6ynpsj",
      "0,1,0 own",
      "250",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ywje6{initial-letter-align:hanging;}",
      "_a_6ywje6",
      "0,1,0 own",
      "250",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ytz0y{initial-letter-align:ideographic;}",
      "_a_6ytz0y",
      "0,1,0 own",
      "250",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6uqonx{image-resolution:from-image;}",
      "_a_6uqonx",
      "0,1,0 own",
      "246",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6u4m46{image-resolution:96dpi;}",
      "_a_6u4m46",
      "0,1,0 own",
      "246",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ubtb7{image-resolution:2dppx;}",
      "_a_6ubtb7",
      "0,1,0 own",
      "246",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6uwnyr{image-resolution:from-image snap;}",
      "_a_6uwnyr",
      "0,1,0 own",
      "246",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6uehnm{image-resolution:96dpi snap;}",
      "_a_6uehnm",
      "0,1,0 own",
      "246",
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
  
  CSS.make("_a_5u2ddt", []);
  CSS.make("_a_5uav7h", []);
  CSS.make("_a_5vzhlp", []);
  CSS.make("_a_5vat5c", []);
  CSS.make("_a_797wts", []);
  CSS.make("_a_794lek", []);
  CSS.make("_a_6xo2dy", []);
  CSS.make("_a_6xwub8", []);
  CSS.make("_a_6x0l7m", []);
  CSS.make("_a_6ybm9f", []);
  CSS.make("_a_6ynpsj", []);
  CSS.make("_a_6ywje6", []);
  CSS.make("_a_6ytz0y", []);
  CSS.make("_a_6uqonx", []);
  CSS.make("_a_6u4m46", []);
  CSS.make("_a_6ubtb7", []);
  CSS.make("_a_6uwnyr", []);
  CSS.make("_a_6uehnm", []);
