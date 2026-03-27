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
    ".css-1i4dt3q{will-change:scroll-position;}\n.css-ef3vel{will-change:contents;}\n.css-1x5bobx{will-change:transform;}\n.css-6fxfnd{will-change:top, left;}\n"
  ];
  
  CSS.make("css-1i4dt3q", []);
  CSS.make("css-ef3vel", []);
  CSS.make("css-1x5bobx", []);
  CSS.make("css-6fxfnd", []);
