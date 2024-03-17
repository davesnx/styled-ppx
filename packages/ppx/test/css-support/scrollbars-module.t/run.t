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
  /* CSS Scrollbars Module Level 1 */
  [%css {|scrollbar-color: auto|}];
  [%css {|scrollbar-color: dark|}];
  [%css {|scrollbar-color: light|}];
  [%css {|scrollbar-color: red blue|}];
  [%css {|scrollbar-width: auto|}];
  [%css {|scrollbar-width: thin|}];
  [%css {|scrollbar-width: none|}];
  [%css {|scrollbar-width: 12px|}];

  $ dune build
