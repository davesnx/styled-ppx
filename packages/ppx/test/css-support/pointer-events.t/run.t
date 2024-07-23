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
  
  CSS.unsafe({js|touchAction|js}, {js|auto|js});
  CSS.unsafe({js|touchAction|js}, {js|none|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-y|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  CSS.unsafe({js|touchAction|js}, {js|manipulation|js});
  
  CSS.unsafe({js|touchAction|js}, {js|pan-left|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-right|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-up|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-down|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-left pan-up|js});
  
  CSS.unsafe({js|touchAction|js}, {js|pinch-zoom|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pinch-zoom|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-y pinch-zoom|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y pinch-zoom|js});
