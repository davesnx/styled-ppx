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
  /* CSS Writing Modes Level 3 */
  [%css {|direction: ltr|}];
  [%css {|direction: rtl|}];
  [%css {|unicode-bidi: normal|}];
  [%css {|unicode-bidi: embed|}];
  [%css {|unicode-bidi: isolate|}];
  [%css {|unicode-bidi: bidi-override|}];
  [%css {|unicode-bidi: isolate-override|}];
  [%css {|unicode-bidi: plaintext|}];
  [%css {|writing-mode: horizontal-tb|}];
  [%css {|writing-mode: vertical-rl|}];
  [%css {|writing-mode: vertical-lr|}];
  [%css {|text-orientation: mixed|}];
  [%css {|text-orientation: upright|}];
  [%css {|text-orientation: sideways|}];
  [%css {|text-combine-upright: none|}];
  [%css {|text-combine-upright: all|}];
  
  /* CSS Writing Modes Level 4 */
  [%css {|writing-mode: sideways-rl|}];
  [%css {|writing-mode: sideways-lr|}];
  [%css {|text-combine-upright: digits 2|}];

  $ dune build
