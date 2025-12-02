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
    ".css-djflwy { flex: auto; }\n.css-1321jgx { flex: initial; }\n.css-1vlfmts { flex: none; }\n.css-naggdn { flex: 2; }\n.css-1l636xm { flex: 10em; }\n.css-1ckya70 { flex: 30%; }\n.css-ja6bgv { flex: min-content; }\n.css-jz3hqm { flex: 1 30px; }\n.css-8j9o4z { flex: 2 2; }\n.css-1j7ej5v { flex: 2 2 10%; }\n.css-16czxug { flex: 2 2 10em; }\n.css-3s76mr { flex: 2 2 min-content; }\n"
  ];
  CSS.make("css-djflwy", []);
  CSS.make("css-1321jgx", []);
  CSS.make("css-1vlfmts", []);
  
  CSS.make("css-naggdn", []);
  
  CSS.make("css-1l636xm", []);
  CSS.make("css-1ckya70", []);
  CSS.make("css-ja6bgv", []);
  
  CSS.make("css-jz3hqm", []);
  
  CSS.make("css-8j9o4z", []);
  
  CSS.make("css-1j7ej5v", []);
  CSS.make("css-16czxug", []);
  CSS.make("css-3s76mr", []);
