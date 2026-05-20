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
  
  CSS.touchAction(`auto);
  CSS.touchAction(`none);
  CSS.touchAction(`panX);
  CSS.touchAction(`panY);
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  CSS.touchAction(`manipulation);
  
  CSS.touchAction(`panLeft);
  CSS.touchAction(`panRight);
  CSS.touchAction(`panUp);
  CSS.touchAction(`panDown);
  CSS.unsafe({js|touchAction|js}, {js|pan-left pan-up|js});
  
  CSS.touchAction(`pinchZoom);
  CSS.unsafe({js|touchAction|js}, {js|pan-x pinch-zoom|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-y pinch-zoom|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y pinch-zoom|js});
