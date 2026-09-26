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
  [@css "._a_aahc5w{scroll-behavior:auto;}"];
  [@css "._a_aajuhq{scroll-behavior:smooth;}"];
  
  CSS.make("_a_aahc5w", []);
  CSS.make("_a_aajuhq", []);
