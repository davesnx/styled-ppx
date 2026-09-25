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
  [@css ".a-ljjwvb{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"];
  [@css ".a-1ujc6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".a-me3p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".a-kzfr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".a-p6wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".a-t6vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".a-1draax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".a-ilthbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".a-6hx0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".a-1rr8a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css ".a-1hb5q0r{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"];
  [@css
    ".a-nj0jqd{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}"
  ];
  
  CSS.make("a-ljjwvb", []);
  CSS.make("a-1ujc6td", []);
  CSS.make("a-me3p27", []);
  
  CSS.make("a-kzfr2u", []);
  
  CSS.make("a-p6wv0x", []);
  CSS.make("a-t6vgg1", []);
  CSS.make("a-1draax7", []);
  
  CSS.make("a-ilthbz", []);
  
  CSS.make("a-6hx0uu", []);
  
  CSS.make("a-1rr8a55", []);
  CSS.make("a-1hb5q0r", []);
  CSS.make("a-nj0jqd", []);
