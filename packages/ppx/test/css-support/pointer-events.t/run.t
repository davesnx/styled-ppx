This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune describe pp input.re
  /* Pointer Events Level 1 */
  [%css {|touch-action: auto|}];
  [%css {|touch-action: none|}];
  [%css {|touch-action: pan-x|}];
  [%css {|touch-action: pan-y|}];
  [%css {|touch-action: pan-x pan-y|}];
  [%css {|touch-action: manipulation|}];
  
  /* Pointer Events Level 3 */
  [%css {|touch-action: pan-left|}];
  [%css {|touch-action: pan-right|}];
  [%css {|touch-action: pan-up|}];
  [%css {|touch-action: pan-down|}];
  [%css {|touch-action: pan-left pan-up|}];
  
  /* Compatibility */
  [%css {|touch-action: pinch-zoom|}];
  [%css {|touch-action: pan-x pinch-zoom|}];
  [%css {|touch-action: pan-y pinch-zoom|}];
  [%css {|touch-action: pan-x pan-y pinch-zoom|}];

  $ dune build
