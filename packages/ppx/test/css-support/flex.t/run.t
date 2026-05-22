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
  [@css ".css-ljjwvb{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"];
  [@css ".css-1ujc6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".css-me3p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-kzfr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-p6wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-t6vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-1draax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-ilthbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-6hx0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-1rr8a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css ".css-1hb5q0r{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"];
  [@css
    ".css-nj0jqd{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}"
  ];
  
  CSS.make("css-ljjwvb", []);
  CSS.make("css-1ujc6td", []);
  CSS.make("css-me3p27", []);
  
  CSS.make("css-kzfr2u", []);
  
  CSS.make("css-p6wv0x", []);
  CSS.make("css-t6vgg1", []);
  CSS.make("css-1draax7", []);
  
  CSS.make("css-ilthbz", []);
  
  CSS.make("css-6hx0uu", []);
  
  CSS.make("css-1rr8a55", []);
  CSS.make("css-1hb5q0r", []);
  CSS.make("css-nj0jqd", []);
