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
    ".css-1uqp1bd{scrollbar-color:auto;}\n.css-1xd6oa{scrollbar-color:red blue;}\n.css-1tn07g6{scrollbar-width:auto;}\n.css-osrmx3{scrollbar-width:thin;}\n.css-1y6rjsx{scrollbar-width:none;}\n"
  ];
  
  CSS.make("css-1uqp1bd", []);
  CSS.make("css-1xd6oa", []);
  CSS.make("css-1tn07g6", []);
  CSS.make("css-osrmx3", []);
  CSS.make("css-1y6rjsx", []);
