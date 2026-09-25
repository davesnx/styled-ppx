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
  [@css ".a-eddt3q{will-change:scroll-position;}"];
  [@css ".a-ed3vel{will-change:contents;}"];
  [@css ".a-edbobx{will-change:transform;}"];
  [@css ".a-edxfnd{will-change:top, left;}"];
  
  CSS.make("a-eddt3q", []);
  CSS.make("a-ed3vel", []);
  CSS.make("a-edbobx", []);
  CSS.make("a-edxfnd", []);
