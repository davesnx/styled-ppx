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
  /* CSS Box Sizing Module Level 3 */
  [%css {|width: max-content|}];
  [%css {|width: min-content|}];
  [%css {|width: fit-content(10%)|}];
  [%css {|min-width: max-content|}];
  [%css {|min-width: min-content|}];
  [%css {|min-width: fit-content(10%)|}];
  [%css {|max-width: max-content|}];
  [%css {|max-width: min-content|}];
  [%css {|max-width: fit-content(10%)|}];
  [%css {|height: max-content|}];
  [%css {|height: min-content|}];
  [%css {|height: fit-content(10%)|}];
  [%css {|min-height: max-content|}];
  [%css {|min-height: min-content|}];
  [%css {|min-height: fit-content(10%)|}];
  [%css {|max-height: max-content|}];
  [%css {|max-height: min-content|}];
  [%css {|max-height: fit-content(10%)|}];
  /* [%css {|column-width: max-content|}]; */
  /* [%css {|column-width: min-content|}]; */
  /* [%css {|column-width: fit-content(10%)|}]; */
  
  /* CSS Box Sizing Module Level 4 */
  [%css {|aspect-ratio: auto|}];
  [%css {|aspect-ratio: 2|}];
  [%css {|aspect-ratio: 16 / 9|}];
  /* [%css {|aspect-ratio: auto 16 / 9|}]; */
  /* [%css {|contain-intrinsic-size: none|}]; */
  /* [%css {|contain-intrinsic-size: 10px|}]; */
  /* [%css {|contain-intrinsic-size: 10px 15px|}]; */
  /* [%css {|contain-intrinsic-width: none|}]; */
  /* [%css {|contain-intrinsic-width: 10px|}]; */
  /* [%css {|contain-intrinsic-height: none|}]; */
  /* [%css {|contain-intrinsic-height: 10px|}]; */
  /* [%css {|contain-intrinsic-block-size: none|}]; */
  /* [%css {|contain-intrinsic-block-size: 10px|}]; */
  /* [%css {|contain-intrinsic-inline-size: none|}]; */
  /* [%css {|contain-intrinsic-inline-size: 10px|}]; */
  /* [%css {|width: stretch|}]; */
  [%css {|width: fit-content|}];
  /* [%css {|width: contain|}]; */
  /* [%css {|min-width: stretch|}]; */
  [%css {|min-width: fit-content|}];
  /* [%css {|min-width: contain|}]; */
  /* [%css {|max-width: stretch|}]; */
  [%css {|max-width: fit-content|}];
  /* [%css {|max-width: contain|}]; */
  /* [%css {|height: stretch|}]; */
  [%css {|height: fit-content|}];
  /* [%css {|height: contain|}]; */
  /* [%css {|min-height: stretch|}]; */
  [%css {|min-height: fit-content|}];
  /* [%css {|min-height: contain|}]; */
  /* [%css {|max-height: stretch|}]; */
  [%css {|max-height: fit-content|}];
  /* [%css {|max-height: contain|}]; */
  /* [%css {|inline-size: stretch|}]; */
  /* [%css {|inline-size: fit-content|}]; */
  /* [%css {|inline-size: contain|}]; */
  /* [%css {|min-inline-size: stretch|}]; */
  /* [%css {|min-inline-size: fit-content|}]; */
  /* [%css {|min-inline-size: contain|}]; */
  /* [%css {|max-inline-size: stretch|}]; */
  /* [%css {|max-inline-size: fit-content|}]; */
  /* [%css {|max-inline-size: contain|}]; */
  /* [%css {|block-size: stretch|}]; */
  /* [%css {|block-size: fit-content|}]; */
  /* [%css {|block-size: contain|}]; */
  /* [%css {|min-block-size: stretch|}]; */
  /* [%css {|min-block-size: fit-content|}]; */
  /* [%css {|min-block-size: contain|}]; */
  /* [%css {|max-block-size: stretch|}]; */
  /* [%css {|max-block-size: fit-content|}]; */
  /* [%css {|max-block-size: contain|}]; */

  $ dune build
