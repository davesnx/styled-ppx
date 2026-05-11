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
  
  CSS.overscrollBehavior(`contain);
  CSS.overscrollBehavior(`none);
  CSS.overscrollBehavior(`auto);
  CSS.overscrollBehavior2(`contain, `contain);
  CSS.overscrollBehavior2(`none, `contain);
  CSS.overscrollBehavior2(`auto, `contain);
  CSS.overscrollBehavior2(`contain, `none);
  CSS.overscrollBehavior2(`none, `none);
  CSS.overscrollBehavior2(`auto, `none);
  CSS.overscrollBehavior2(`contain, `auto);
  CSS.overscrollBehavior2(`none, `auto);
  CSS.overscrollBehavior2(`auto, `auto);
  CSS.overscrollBehaviorX(`contain);
  CSS.overscrollBehaviorX(`none);
  CSS.overscrollBehaviorX(`auto);
  CSS.overscrollBehaviorY(`contain);
  CSS.overscrollBehaviorY(`none);
  CSS.overscrollBehaviorY(`auto);
  CSS.overscrollBehaviorInline(`contain);
  CSS.overscrollBehaviorInline(`none);
  CSS.overscrollBehaviorInline(`auto);
  CSS.overscrollBehaviorBlock(`contain);
  CSS.overscrollBehaviorBlock(`none);
  CSS.overscrollBehaviorBlock(`auto);
