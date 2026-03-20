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
    ".css-ljjwvb{flex:auto;}\n.css-1ujc6td{flex:initial;}\n.css-me3p27{flex:none;}\n.css-kzfr2u{flex:2;}\n.css-p6wv0x{flex:10em;}\n.css-t6vgg1{flex:30%;}\n.css-1draax7{flex:min-content;}\n.css-ilthbz{flex:1 30px;}\n.css-6hx0uu{flex:2 2;}\n.css-1rr8a55{flex:2 2 10%;}\n.css-1hb5q0r{flex:2 2 10em;}\n.css-nj0jqd{flex:2 2 min-content;}\n"
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
