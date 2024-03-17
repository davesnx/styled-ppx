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
  /* CSS Exclusions Module Level 1 */
    /* [%css {|wrap-flow: auto|}]; */
    /* [%css {|wrap-flow: both|}]; */
    /* [%css {|wrap-flow: start|}]; */
    /* [%css {|wrap-flow: end|}]; */
    /* [%css {|wrap-flow: minimum|}]; */
    /* [%css {|wrap-flow: maximum|}]; */
    /* [%css {|wrap-flow: clear|}]; */
    /* [%css {|wrap-through: wrap|}]; */
    /* [%css {|wrap-through: none|}]; */

  $ dune build
