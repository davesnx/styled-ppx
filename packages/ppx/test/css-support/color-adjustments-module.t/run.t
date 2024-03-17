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
  /* CSS Color Adjustment Module Level 1 */
  [%css {|color-adjust: economy|}];
  [%css {|color-adjust: exact|}];
  [%css {|forced-color-adjust: auto|}];
  [%css {|forced-color-adjust: none|}];
  [%css {|forced-color-adjust: preserve-parent-color|}];
  [%css {|color-scheme: normal|}];
  [%css {|color-scheme: light|}];
  [%css {|color-scheme: dark|}];
  [%css {|color-scheme: light dark|}];
  [%css {|color-scheme: dark light|}];
  [%css {|color-scheme: only light|}];
  [%css {|color-scheme: light only|}];
  [%css {|color-scheme: light light|}];
  [%css {|color-scheme: dark dark|}];
  [%css {|color-scheme: light purple|}];
  [%css {|color-scheme: purple dark interesting|}];
  [%css {|color-scheme: none|}];
  [%css {|color-scheme: light none|}];

  $ dune build
