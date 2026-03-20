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
  
  CSS.unsafe({js|placeContent|js}, {js|center|js});
  CSS.unsafe({js|placeContent|js}, {js|start|js});
  CSS.unsafe({js|placeContent|js}, {js|end|js});
  CSS.unsafe({js|placeContent|js}, {js|space-between|js});
  CSS.unsafe({js|placeContent|js}, {js|space-around|js});
  CSS.unsafe({js|placeContent|js}, {js|space-evenly|js});
  CSS.unsafe({js|placeContent|js}, {js|stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|center start|js});
  CSS.unsafe({js|placeContent|js}, {js|start end|js});
  CSS.unsafe({js|placeContent|js}, {js|space-between center|js});
  
  CSS.unsafe({js|placeItems|js}, {js|center|js});
  CSS.unsafe({js|placeItems|js}, {js|start|js});
  CSS.unsafe({js|placeItems|js}, {js|end|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|center start|js});
  CSS.unsafe({js|placeItems|js}, {js|start end|js});
  
  CSS.unsafe({js|placeSelf|js}, {js|auto|js});
  CSS.unsafe({js|placeSelf|js}, {js|center|js});
  CSS.unsafe({js|placeSelf|js}, {js|start|js});
  CSS.unsafe({js|placeSelf|js}, {js|end|js});
  CSS.unsafe({js|placeSelf|js}, {js|stretch|js});
  CSS.unsafe({js|placeSelf|js}, {js|center start|js});
  CSS.unsafe({js|placeSelf|js}, {js|start end|js});
  
  CSS.unsafe({js|accentColor|js}, {js|auto|js});
  CSS.unsafe({js|accentColor|js}, {js|red|js});
  CSS.unsafe({js|accentColor|js}, {js|#ff0000|js});
  CSS.unsafe({js|accentColor|js}, {js|rgb(255, 0, 0)|js});
  
  CSS.unsafe({js|touchAction|js}, {js|auto|js});
  CSS.unsafe({js|touchAction|js}, {js|none|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-y|js});
  CSS.unsafe({js|touchAction|js}, {js|manipulation|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  
  CSS.aspectRatio(`auto);
  CSS.aspectRatio(`ratio((1, 1)));
  CSS.aspectRatio(`ratio((16, 9)));
  CSS.aspectRatio(`num(0.5));
