This test captures the admin-support monorepo regressions that belong to styled-ppx itself: border-side shorthands with interpolated colors, shadow-array interpolation, and `calc()` length interpolation.

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

  $ dune describe pp ./input.re | sed -n '/let _borderTop/,$p'
  let _borderTop = CSS.borderTop(`pxFloat(1.), `solid, Color.Border.line);
  let _borderBottom =
    CSS.borderBottom(`pxFloat(1.), `solid, Color.Border.lineAlpha);
  let _borderLeft =
    CSS.borderLeft(`pxFloat(1.), `solid, Color.Border.lineAlpha);
  
  let _boxShadow1 = CSS.boxShadows(BoxShadow.deprecated__elevation1);
  let _boxShadow2 = CSS.boxShadows(BoxShadow.deprecated__elevation3);
  
  let _heightPlus = CSS.height(`calc(`add((`vh(100.), topMenuHeight))));
  let _heightMinus = CSS.height(`calc(`sub((`vh(100.), topMenuHeight))));
