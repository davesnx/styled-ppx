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
  /* CSS Containment Module Level 1 */
  [%css {|contain: none|}];
  [%css {|contain: strict|}];
  [%css {|contain: content|}];
  [%css {|contain: size|}];
  [%css {|contain: layout|}];
  [%css {|contain: paint|}];
  [%css {|contain: size layout|}];
  [%css {|contain: size paint|}];
  [%css {|contain: size layout paint|}];
  
  /* CSS Containment Module Level 2 */
  /* [%css {|contain: style|}]; */
  /* [%css {|contain: size style|}]; */
  /* [%css {|contain: size layout style|}]; */
  /* [%css {|contain: size layout style paint|}]; */
  /* [%css {|content-visibility: visible|}]; */
  /* [%css {|content-visibility: auto|}]; */
  /* [%css {|content-visibility: hidden|}]; */

  $ dune build
