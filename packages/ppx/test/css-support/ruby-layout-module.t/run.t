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
  /* CSS Ruby Layout Module Level 1 */
  [%css {|display: ruby|}];
  [%css {|display: ruby-base|}];
  [%css {|display: ruby-text|}];
  [%css {|display: ruby-base-container|}];
  [%css {|display: ruby-text-container|}];
  /* [%css {|ruby-position: alternate|}]; */
  /* [%css {|ruby-position: over|}]; */
  /* [%css {|ruby-position: under|}]; */
  /* [%css {|ruby-position: alternate over|}]; */
  /* [%css {|ruby-position: alternate under|}]; */
  /* [%css {|ruby-position: inter-character|}]; */
  /* [%css {|ruby-merge: separate|}]; */
  /* [%css {|ruby-merge: collapse|}]; */
  /* [%css {|ruby-merge: auto|}]; */
  /* [%css {|ruby-align: start|}]; */
  /* [%css {|ruby-align: center|}]; */
  /* [%css {|ruby-align: space-between|}]; */
  /* [%css {|ruby-align: space-around|}]; */

  $ dune build
