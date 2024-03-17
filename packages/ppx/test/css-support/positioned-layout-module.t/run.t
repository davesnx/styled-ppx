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
  /* CSS Positioned Layout Module Level 3 */
  [%css {|position: sticky|}];
  /* [%css {|inset-before: auto|}]; */
  /* [%css {|inset-before: 10px|}]; */
  /* [%css {|inset-before: 50%|}]; */
  /* [%css {|inset-after: auto|}]; */
  /* [%css {|inset-after: 10px|}]; */
  /* [%css {|inset-after: 50%|}]; */
  /* [%css {|inset-start: auto|}]; */
  /* [%css {|inset-start: 10px|}]; */
  /* [%css {|inset-start: 50%|}]; */
  /* [%css {|inset-end: auto|}]; */
  /* [%css {|inset-end: 10px|}]; */
  /* [%css {|inset-end: 50%|}]; */

  $ dune build
