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
  [@css ".css-ivpckbr{vertical-align:baseline;}"];
  [@css ".css-ivpcbg6{vertical-align:sub;}"];
  [@css ".css-ivpcpms{vertical-align:super;}"];
  [@css ".css-ivpcmew{vertical-align:top;}"];
  [@css ".css-ivpco3i{vertical-align:text-top;}"];
  [@css ".css-ivpcgft{vertical-align:middle;}"];
  [@css ".css-ivpcyl9{vertical-align:bottom;}"];
  [@css ".css-ivpcqq0{vertical-align:text-bottom;}"];
  [@css.classes
    [
      ("css-ivpckbr", 0, "", "input.re", 1, 8, 1, 32),
      ("css-ivpcbg6", 1, "", "input.re", 2, 8, 2, 27),
      ("css-ivpcpms", 2, "", "input.re", 3, 8, 3, 29),
      ("css-ivpcmew", 3, "", "input.re", 4, 8, 4, 27),
      ("css-ivpco3i", 4, "", "input.re", 5, 8, 5, 32),
      ("css-ivpcgft", 5, "", "input.re", 6, 8, 6, 30),
      ("css-ivpcyl9", 6, "", "input.re", 7, 8, 7, 30),
      ("css-ivpcqq0", 7, "", "input.re", 8, 8, 8, 35),
    ]
  ];
  CSS.make("css-ivpckbr", []);
  CSS.make("css-ivpcbg6", []);
  CSS.make("css-ivpcpms", []);
  CSS.make("css-ivpcmew", []);
  CSS.make("css-ivpco3i", []);
  CSS.make("css-ivpcgft", []);
  CSS.make("css-ivpcyl9", []);
  CSS.make("css-ivpcqq0", []);
