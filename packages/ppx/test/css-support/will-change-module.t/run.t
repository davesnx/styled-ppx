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
  [@css ".a-1i4dt3q{will-change:scroll-position;}"];
  [@css ".a-ef3vel{will-change:contents;}"];
  [@css ".a-1x5bobx{will-change:transform;}"];
  [@css ".a-6fxfnd{will-change:top, left;}"];
  
  CSS.make("a-1i4dt3q", []);
  CSS.make("a-ef3vel", []);
  CSS.make("a-1x5bobx", []);
  CSS.make("a-6fxfnd", []);
