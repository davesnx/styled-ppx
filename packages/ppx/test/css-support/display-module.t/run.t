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
  /* CSS Display Module Level 3 */
  [%css {|display: run-in|}];
  [%css {|display: flow|}];
  [%css {|display: flow-root|}];
  /* [%css {|display: block flow|}]; */
  /* [%css {|display: inline flow|}]; */
  /* [%css {|display: run-in flow|}]; */
  /* [%css {|display: block flow-root|}]; */
  /* [%css {|display: inline flow-root|}]; */
  /* [%css {|display: run-in flow-root|}]; */
  /* [%css {|display: block table|}]; */
  /* [%css {|display: inline table|}]; */
  /* [%css {|display: run-in table|}]; */
  /* [%css {|display: block flex|}]; */
  /* [%css {|display: inline flex|}]; */
  /* [%css {|display: run-in flex|}]; */
  /* [%css {|display: block grid|}]; */
  /* [%css {|display: inline grid|}]; */
  /* [%css {|display: run-in grid|}]; */
  /* [%css {|display: block ruby|}]; */
  /* [%css {|display: inline ruby|}]; */
  /* [%css {|display: run-in ruby|}]; */
  /* [%css {|display: inline list-item|}]; */
  /* [%css {|display: list-item inline flow|}]; */
  /* [%css {|display: list-item block flow|}]; */
  
  /* CSS Layout API Level 1 */
  /* [%css {|display: layout(foo)|}]; */

  $ dune build
