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
    ".css-1y379uf { pointer-events: auto; }\n.css-rta4kt { pointer-events: visiblePainted; }\n.css-1k88vpe { pointer-events: visibleFill; }\n.css-1jsv80n { pointer-events: visibleStroke; }\n.css-tzpzd1 { pointer-events: visible; }\n.css-rrflvv { pointer-events: painted; }\n.css-15y8g1h { pointer-events: fill; }\n.css-fuat2p { pointer-events: stroke; }\n.css-borfo9 { pointer-events: all; }\n.css-1spsi3r { pointer-events: none; }\n"
  ];
  
  CSS.make("css-1y379uf", []);
  
  CSS.make("css-rta4kt", []);
  CSS.make("css-1k88vpe", []);
  CSS.make("css-1jsv80n", []);
  CSS.make("css-tzpzd1", []);
  CSS.make("css-rrflvv", []);
  CSS.make("css-15y8g1h", []);
  CSS.make("css-fuat2p", []);
  CSS.make("css-borfo9", []);
  CSS.make("css-1spsi3r", []);
