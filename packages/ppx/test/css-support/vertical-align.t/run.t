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
  [@css "._a_dt9eo6{vertical-align:baseline;}"];
  [@css "._a_dtkzuz{vertical-align:sub;}"];
  [@css "._a_dt1ck9{vertical-align:super;}"];
  [@css "._a_dtawz4{vertical-align:top;}"];
  [@css "._a_dtbbe2{vertical-align:text-top;}"];
  [@css "._a_dt6cul{vertical-align:middle;}"];
  [@css "._a_dt0n61{vertical-align:bottom;}"];
  [@css "._a_dtdzq1{vertical-align:text-bottom;}"];
  [@css.blocks
    [
      (1, "_a_dt9eo6"),
      (2, "_a_dtkzuz"),
      (3, "_a_dt1ck9"),
      (4, "_a_dtawz4"),
      (5, "_a_dtbbe2"),
      (6, "_a_dt6cul"),
      (7, "_a_dt0n61"),
      (8, "_a_dtdzq1"),
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
