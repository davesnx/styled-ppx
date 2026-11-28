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
  [@css ".css-ivpcqts{will-change:scroll-position;}"];
  [@css ".css-ivpcxht{will-change:contents;}"];
  [@css ".css-ivpc15w{will-change:transform;}"];
  [@css ".css-ivpcnkz{will-change:top, left;}"];
  [@css.classes
    [
      ("css-ivpcqts", 0, "", "input.re", 2, 8, 2, 36),
      ("css-ivpcxht", 1, "", "input.re", 3, 8, 3, 29),
      ("css-ivpc15w", 2, "", "input.re", 4, 8, 4, 30),
      ("css-ivpcnkz", 3, "", "input.re", 5, 8, 5, 30),
    ]
  ];
  
  CSS.make("css-ivpcqts", []);
  CSS.make("css-ivpcxht", []);
  CSS.make("css-ivpc15w", []);
  CSS.make("css-ivpcnkz", []);
