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
  [@css ".a-60jwvb{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"];
  [@css ".a-60c6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".a-603p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".a-60fr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".a-60wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".a-60vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".a-60aax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".a-60thbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".a-60x0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".a-608a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css ".a-605q0r{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"];
  [@css
    ".a-600jqd{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}"
  ];
  
  CSS.make("a-60jwvb", []);
  CSS.make("a-60c6td", []);
  CSS.make("a-603p27", []);
  
  CSS.make("a-60fr2u", []);
  
  CSS.make("a-60wv0x", []);
  CSS.make("a-60vgg1", []);
  CSS.make("a-60aax7", []);
  
  CSS.make("a-60thbz", []);
  
  CSS.make("a-60x0uu", []);
  
  CSS.make("a-608a55", []);
  CSS.make("a-605q0r", []);
  CSS.make("a-600jqd", []);
