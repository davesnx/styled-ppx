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
  /* CSS Rhythmic Sizing */
  /* [%css {|line-height-step: none|}]; */
  [%css {|line-height-step: 30px|}];
  [%css {|line-height-step: 2em|}];
  /* [%css {|block-step-size: none|}]; */
  /* [%css {|block-step-size: 30px|}]; */
  /* [%css {|block-step-size: 2em|}]; */
  /* [%css {|block-step-insert: margin|}]; */
  /* [%css {|block-step-insert: padding|}]; */
  /* [%css {|block-step-align: auto|}]; */
  /* [%css {|block-step-align: center|}]; */
  /* [%css {|block-step-align: start|}]; */
  /* [%css {|block-step-align: end|}]; */
  /* [%css {|block-step-round: up|}]; */
  /* [%css {|block-step-round: down|}]; */
  /* [%css {|block-step-round: nearest|}]; */
  /* [%css {|block-step: none|}]; */
  /* [%css {|block-step: padding|}]; */
  /* [%css {|block-step: end|}]; */
  /* [%css {|block-step: down|}]; */
  /* [%css {|block-step: 30px margin|}]; */
  /* [%css {|block-step: 30px padding center|}]; */
  /* [%css {|block-step: 2em padding start nearest|}]; */

  $ dune build
  File "input.re", line 1, characters 0-16:
  Error: Unbound value CssJs.lineHeightStep
  [1]
