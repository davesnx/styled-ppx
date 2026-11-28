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
  [@css ".css-ivpc25w{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"];
  [@css ".css-ivpc6se{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".css-ivpc3lc{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-ivpcv5s{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-ivpc50t{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-ivpcoij{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-ivpcurq{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-ivpcgvu{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-ivpch0q{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-ivpc0is{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css ".css-ivpcr4d{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"];
  [@css
    ".css-ivpctza{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}"
  ];
  [@css.classes
    [
      ("css-ivpc25w", 0, "", "input.re", 2, 9, 2, 21),
      ("css-ivpc6se", 1, "", "input.re", 3, 9, 3, 24),
      ("css-ivpc3lc", 2, "", "input.re", 4, 9, 4, 21),
      ("css-ivpcv5s", 3, "", "input.re", 8, 9, 8, 18),
      ("css-ivpc50t", 4, "", "input.re", 11, 9, 11, 21),
      ("css-ivpcoij", 5, "", "input.re", 12, 9, 12, 20),
      ("css-ivpcurq", 6, "", "input.re", 13, 9, 13, 28),
      ("css-ivpcgvu", 7, "", "input.re", 16, 9, 16, 23),
      ("css-ivpch0q", 8, "", "input.re", 19, 9, 19, 20),
      ("css-ivpc0is", 9, "", "input.re", 22, 9, 22, 24),
      ("css-ivpcr4d", 10, "", "input.re", 23, 9, 23, 25),
      ("css-ivpctza", 11, "", "input.re", 24, 9, 24, 32),
    ]
  ];
  
  CSS.make("css-ivpc25w", []);
  CSS.make("css-ivpc6se", []);
  CSS.make("css-ivpc3lc", []);
  
  CSS.make("css-ivpcv5s", []);
  
  CSS.make("css-ivpc50t", []);
  CSS.make("css-ivpcoij", []);
  CSS.make("css-ivpcurq", []);
  
  CSS.make("css-ivpcgvu", []);
  
  CSS.make("css-ivpch0q", []);
  
  CSS.make("css-ivpc0is", []);
  CSS.make("css-ivpcr4d", []);
  CSS.make("css-ivpctza", []);
