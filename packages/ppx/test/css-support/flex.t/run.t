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
  [@css ".css-1ky925w{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"];
  [@css ".css-1zk6se{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".css-krl3lc{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-pz7v5s{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-1x8t50t{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-h2ioij{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-1ql9urq{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-p0kgvu{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-pfrh0q{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-1v0k0is{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css ".css-gx8r4d{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"];
  [@css
    ".css-v15tza{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}"
  ];
  [@css.classes
    [
      ("css-1ky925w", 0, "", "input.re", 2, 9, 2, 21),
      ("css-1zk6se", 1, "", "input.re", 3, 9, 3, 24),
      ("css-krl3lc", 2, "", "input.re", 4, 9, 4, 21),
      ("css-pz7v5s", 3, "", "input.re", 8, 9, 8, 18),
      ("css-1x8t50t", 4, "", "input.re", 11, 9, 11, 21),
      ("css-h2ioij", 5, "", "input.re", 12, 9, 12, 20),
      ("css-1ql9urq", 6, "", "input.re", 13, 9, 13, 28),
      ("css-p0kgvu", 7, "", "input.re", 16, 9, 16, 23),
      ("css-pfrh0q", 8, "", "input.re", 19, 9, 19, 20),
      ("css-1v0k0is", 9, "", "input.re", 22, 9, 22, 24),
      ("css-gx8r4d", 10, "", "input.re", 23, 9, 23, 25),
      ("css-v15tza", 11, "", "input.re", 24, 9, 24, 32),
    ]
  ];
  
  CSS.make("css-1ky925w", []);
  CSS.make("css-1zk6se", []);
  CSS.make("css-krl3lc", []);
  
  CSS.make("css-pz7v5s", []);
  
  CSS.make("css-1x8t50t", []);
  CSS.make("css-h2ioij", []);
  CSS.make("css-1ql9urq", []);
  
  CSS.make("css-p0kgvu", []);
  
  CSS.make("css-pfrh0q", []);
  
  CSS.make("css-1v0k0is", []);
  CSS.make("css-gx8r4d", []);
  CSS.make("css-v15tza", []);
