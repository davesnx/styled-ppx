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
  CSS.width(`rem(5.));
  CSS.width(`ch(5.));
  CSS.width(`vw(5.));
  CSS.width(`vh(5.));
  CSS.width(`vmin(5.));
  CSS.width(`vmax(5.));
  CSS.width(`calc(`add((`pxFloat(1.), `pxFloat(2.)))));
  CSS.width(`calc(`mult((`pxFloat(5.), `num(2.)))));
  CSS.width(`calc(`mult((`pxFloat(5.), `num(2.)))));
  CSS.width(`calc(`sub((`pxFloat(5.), `pxFloat(10.)))));
  CSS.width(`calc(`sub((`vw(1.), `pxFloat(1.)))));
  CSS.width(`percent(100.));
  CSS.padding(`rem(5.));
  CSS.padding(`ch(5.));
  CSS.padding(`vw(5.));
  CSS.padding(`vh(5.));
  CSS.padding(`vmin(5.));
  CSS.padding(`vmax(5.));
