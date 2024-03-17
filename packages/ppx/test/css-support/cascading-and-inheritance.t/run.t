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
  /* CSS Cascading and Inheritance Level 3 */
  [%css {|color: unset;|}];
  [%css {|font-weight: unset;|}];
  [%css {|background-image: unset;|}];
  [%css {|width: unset;|}];
  
  /* CSS Cascading and Inheritance Level 4 */
  /* [%css {|color: revert;|}]; */
  /* [%css {|font-weight: revert;|}]; */
  /* [%css {|background-image: revert;|}]; */
  /* [%css {|all: revert;|}]; */

  $ dune build
