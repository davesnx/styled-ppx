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
  
  CSS.pointerEvents(`auto);
  
  CSS.pointerEvents(`visiblePainted);
  CSS.pointerEvents(`visibleFill);
  CSS.pointerEvents(`visibleStroke);
  CSS.pointerEvents(`visible);
  CSS.pointerEvents(`painted);
  CSS.pointerEvents(`fill);
  CSS.pointerEvents(`stroke);
  CSS.pointerEvents(`all);
  CSS.pointerEvents(`none);
