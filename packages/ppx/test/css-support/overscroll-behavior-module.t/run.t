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
  
  CSS.unsafe({js|overscrollBehavior|js}, {js|contain|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|none|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|auto|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|contain contain|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|none contain|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|auto contain|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|contain none|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|none none|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|auto none|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|contain auto|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|none auto|js});
  CSS.unsafe({js|overscrollBehavior|js}, {js|auto auto|js});
  CSS.unsafe({js|overscrollBehaviorX|js}, {js|contain|js});
  CSS.unsafe({js|overscrollBehaviorX|js}, {js|none|js});
  CSS.unsafe({js|overscrollBehaviorX|js}, {js|auto|js});
  CSS.unsafe({js|overscrollBehaviorY|js}, {js|contain|js});
  CSS.unsafe({js|overscrollBehaviorY|js}, {js|none|js});
  CSS.unsafe({js|overscrollBehaviorY|js}, {js|auto|js});
  CSS.unsafe({js|overscrollBehaviorInline|js}, {js|contain|js});
  CSS.unsafe({js|overscrollBehaviorInline|js}, {js|none|js});
  CSS.unsafe({js|overscrollBehaviorInline|js}, {js|auto|js});
  CSS.unsafe({js|overscrollBehaviorBlock|js}, {js|contain|js});
  CSS.unsafe({js|overscrollBehaviorBlock|js}, {js|none|js});
  CSS.unsafe({js|overscrollBehaviorBlock|js}, {js|auto|js});
