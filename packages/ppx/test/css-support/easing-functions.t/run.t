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
  /* CSS Easing Functions Level 1 */
  [%css {|transition-timing-function: steps(2, jump-start)|}];
  [%css {|transition-timing-function: steps(2, jump-end)|}];
  [%css {|transition-timing-function: steps(1, jump-both)|}];
  [%css {|transition-timing-function: steps(2, jump-none)|}];

  $ dune build
