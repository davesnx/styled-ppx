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
  /* CSS Overflow Module Level 3 */
  [%css {|line-clamp: none|}];
  [%css {|line-clamp: 1|}];
  /* [%css {|line-clamp: 5 clip|}]; */
  /* [%css {|line-clamp: 5 ellipsis|}]; */
  [%css {|max-lines: none|}];
  [%css {|max-lines: 1|}];
  [%css {|overflow-x: visible|}];
  [%css {|overflow-x: hidden|}];
  [%css {|overflow-x: clip|}];
  [%css {|overflow-x: scroll|}];
  [%css {|overflow-x: auto|}];
  [%css {|overflow-y: visible|}];
  [%css {|overflow-y: hidden|}];
  [%css {|overflow-y: clip|}];
  [%css {|overflow-y: scroll|}];
  [%css {|overflow-y: auto|}];
  [%css {|overflow-inline: visible|}];
  [%css {|overflow-inline: hidden|}];
  [%css {|overflow-inline: clip|}];
  [%css {|overflow-inline: scroll|}];
  [%css {|overflow-inline: auto|}];
  [%css {|overflow-block: visible|}];
  [%css {|overflow-block: hidden|}];
  [%css {|overflow-block: clip|}];
  [%css {|overflow-block: scroll|}];
  [%css {|overflow-block: auto|}];
  /* [%css {|overflow-clip-margin: content-box|}]; */
  /* [%css {|overflow-clip-margin: padding-box|}]; */
  /* [%css {|overflow-clip-margin: border-box|}]; */
  /* [%css {|overflow-clip-margin: 20px|}]; */
  /* [%css {|continue: auto|}]; */
  /* [%css {|continue: discard|}]; */

  $ dune build
