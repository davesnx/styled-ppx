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
  
  CSS.unsafe({js|scrollbarColor|js}, {js|auto|js});
  CSS.unsafe({js|scrollbarColor|js}, {js|dark|js});
  CSS.unsafe({js|scrollbarColor|js}, {js|light|js});
  CSS.unsafe({js|scrollbarColor|js}, {js|red blue|js});
  CSS.unsafe({js|scrollbarWidth|js}, {js|auto|js});
  CSS.unsafe({js|scrollbarWidth|js}, {js|thin|js});
  CSS.unsafe({js|scrollbarWidth|js}, {js|none|js});
  CSS.unsafe({js|scrollbarWidth|js}, {js|12px|js});
