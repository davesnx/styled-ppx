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
  
  CSS.placeContent(`center);
  CSS.placeContent(`start);
  CSS.placeContent(`end_);
  CSS.placeContent(`spaceBetween);
  CSS.placeContent(`spaceAround);
  CSS.placeContent(`spaceEvenly);
  CSS.placeContent(`stretch);
  CSS.alignContent(`center);
  CSS.alignContent(`start);
  CSS.alignContent(`spaceBetween);
  
  CSS.placeItems(`center);
  CSS.placeItems(`start);
  CSS.placeItems(`end_);
  CSS.placeItems(`stretch);
  CSS.placeItems(`baseline);
  CSS.alignItems(`center);
  CSS.alignItems(`start);
  
  CSS.placeSelf(`auto);
  CSS.placeSelf(`center);
  CSS.placeSelf(`start);
  CSS.placeSelf(`end_);
  CSS.placeSelf(`stretch);
  CSS.alignSelf(`center);
  CSS.alignSelf(`start);
  
  CSS.accentColor(`auto);
  CSS.accentColor(CSS.red);
  CSS.accentColor(`hex({js|ff0000|js}));
  CSS.accentColor(`rgb((255, 0, 0)));
  
  CSS.touchAction(`auto);
  CSS.touchAction(`none);
  CSS.touchAction(`panX);
  CSS.touchAction(`panY);
  CSS.touchAction(`manipulation);
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  
  CSS.aspectRatio(`auto);
  CSS.aspectRatio(`ratio((1, 1)));
  CSS.aspectRatio(`ratio((16, 9)));
  CSS.aspectRatio(`num(0.5));
