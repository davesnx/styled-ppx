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
  [@css "._a_5r3jk8{display:run-in;}"];
  [@css "._a_5rlerk{display:flow;}"];
  [@css "._a_5rposs{display:flow-root;}"];
  
  CSS.make("_a_5r3jk8", []);
  CSS.make("_a_5rlerk", []);
  CSS.make("_a_5rposs", []);
