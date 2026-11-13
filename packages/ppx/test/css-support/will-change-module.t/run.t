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
  [@css ".css-15elqts{will-change:scroll-position;}"];
  [@css ".css-1h16xht{will-change:contents;}"];
  [@css ".css-tr515w{will-change:transform;}"];
  [@css ".css-dmtnkz{will-change:top, left;}"];
  [@css.classes
    [
      ("css-15elqts", 0, "", "input.re", 2, 8, 2, 36),
      ("css-1h16xht", 1, "", "input.re", 3, 8, 3, 29),
      ("css-tr515w", 2, "", "input.re", 4, 8, 4, 30),
      ("css-dmtnkz", 3, "", "input.re", 5, 8, 5, 30),
    ]
  ];
  
  CSS.make("css-15elqts", []);
  CSS.make("css-1h16xht", []);
  CSS.make("css-tr515w", []);
  CSS.make("css-dmtnkz", []);
