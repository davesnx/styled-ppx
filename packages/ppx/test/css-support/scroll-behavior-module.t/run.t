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
  [@css ".css-89hc5w{scroll-behavior:auto}"];
  [@css ".css-pdjuhq{scroll-behavior:smooth}"];
  
  CSS.make("css-89hc5w", []);
  CSS.make("css-pdjuhq", []);
