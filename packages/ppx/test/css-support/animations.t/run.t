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
  /* CSS Animations Level 1 */
  [%css {|animation-name: foo|}];
  [%css {|animation-name: foo, bar|}];
  [%css {|animation-duration: 0s|}];
  [%css {|animation-duration: 1s|}];
  [%css {|animation-duration: 100ms|}];
  [%css {|animation-timing-function: ease|}];
  [%css {|animation-timing-function: linear|}];
  [%css {|animation-timing-function: ease-in|}];
  [%css {|animation-timing-function: ease-out|}];
  [%css {|animation-timing-function: ease-in-out|}];
  [%css {|animation-timing-function: cubic-bezier(.5, .5, .5, .5)|}];
  [%css {|animation-timing-function: cubic-bezier(.5, 1.5, .5, -2.5)|}];
  [%css {|animation-timing-function: step-start|}];
  [%css {|animation-timing-function: step-end|}];
  [%css {|animation-timing-function: steps(3, start)|}];
  [%css {|animation-timing-function: steps(5, end)|}];
  [%css {|animation-iteration-count: infinite|}];
  [%css {|animation-iteration-count: 8|}];
  [%css {|animation-iteration-count: 4.35|}];
  [%css {|animation-direction: normal|}];
  [%css {|animation-direction: alternate|}];
  [%css {|animation-direction: reverse|}];
  [%css {|animation-direction: alternate-reverse|}];
  [%css {|animation-play-state: running|}];
  [%css {|animation-play-state: paused|}];
  [%css {|animation-delay: 1s|}];
  [%css {|animation-delay: -1s|}];
  [%css {|animation-fill-mode: none|}];
  [%css {|animation-fill-mode: forwards|}];
  [%css {|animation-fill-mode: backwards|}];
  [%css {|animation-fill-mode: both|}];
  [%css {|animation: foo 1s 2s infinite linear alternate both|}];

  $ dune build
