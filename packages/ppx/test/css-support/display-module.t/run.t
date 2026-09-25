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
  [@css ".a-5r3jk8{display:run-in;}"];
  [@css ".a-5rlerk{display:flow;}"];
  [@css ".a-5rposs{display:flow-root;}"];
  
  CSS.make("a-5r3jk8", []);
  CSS.make("a-5rlerk", []);
  CSS.make("a-5rposs", []);
