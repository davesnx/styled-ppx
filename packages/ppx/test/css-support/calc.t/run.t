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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  CSS.width(`calc(`add((`percent(50.), `pxFloat(4.)))));
  CSS.width(`calc(`sub((`pxFloat(20.), `pxFloat(10.)))));
  CSS.width(`calc(`sub((`vh(100.), `calc(`add((`rem(2.), `pxFloat(120.))))))));
  CSS.width(`calc(`mult((`vh(100.), `num(2.)))));
  CSS.width(`calc(`mult((`num(2.), `pxFloat(120.)))));

  $ dune build
