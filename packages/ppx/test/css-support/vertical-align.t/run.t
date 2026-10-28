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
      "._a_dt9eo6{vertical-align:baseline;}",
      "_a_dt9eo6",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dtkzuz{vertical-align:sub;}",
      "_a_dtkzuz",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dt1ck9{vertical-align:super;}",
      "_a_dt1ck9",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dtawz4{vertical-align:top;}",
      "_a_dtawz4",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dtbbe2{vertical-align:text-top;}",
      "_a_dtbbe2",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dt6cul{vertical-align:middle;}",
      "_a_dt6cul",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dt0n61{vertical-align:bottom;}",
      "_a_dt0n61",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dtdzq1{vertical-align:text-bottom;}",
      "_a_dtdzq1",
      "0,1,0 own",
      "497",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (1, "", [0]),
      (2, "", [1]),
      (3, "", [2]),
      (4, "", [3]),
      (5, "", [4]),
      (6, "", [5]),
      (7, "", [6]),
      (8, "", [7]),
    ]
  ];
  CSS.make("_a_dt9eo6", []);
  CSS.make("_a_dtkzuz", []);
  CSS.make("_a_dt1ck9", []);
  CSS.make("_a_dtawz4", []);
  CSS.make("_a_dtbbe2", []);
  CSS.make("_a_dt6cul", []);
  CSS.make("_a_dt0n61", []);
  CSS.make("_a_dtdzq1", []);
