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
  /* CSS Transitions */
  [%css {|transition-property: none|}];
  [%css {|transition-property: all|}];
  [%css {|transition-property: width|}];
  [%css {|transition-property: width, height|}];
  [%css {|transition-duration: 0s|}];
  [%css {|transition-duration: 1s|}];
  [%css {|transition-duration: 100ms|}];
  [%css {|transition-timing-function: ease|}];
  [%css {|transition-timing-function: linear|}];
  [%css {|transition-timing-function: ease-in|}];
  [%css {|transition-timing-function: ease-out|}];
  [%css {|transition-timing-function: ease-in-out|}];
  [%css {|transition-timing-function: cubic-bezier(.5, .5, .5, .5)|}];
  [%css {|transition-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)|}];
  [%css {|transition-timing-function: step-start|}];
  [%css {|transition-timing-function: step-end|}];
  [%css {|transition-timing-function: steps(3, start)|}];
  [%css {|transition-timing-function: steps(5, end)|}];
  [%css {|transition-delay: 1s|}];
  [%css {|transition-delay: -1s|}];
  [%css {|transition: 1s 2s width linear|}];

  $ dune build
