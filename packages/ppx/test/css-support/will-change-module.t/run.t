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
  [@css "._a_eddt3q{will-change:scroll-position;}"];
  [@css "._a_ed3vel{will-change:contents;}"];
  [@css "._a_edbobx{will-change:transform;}"];
  [@css "._a_edxfnd{will-change:top, left;}"];
  
  CSS.make("_a_eddt3q", []);
  CSS.make("_a_ed3vel", []);
  CSS.make("_a_edbobx", []);
  CSS.make("_a_edxfnd", []);
