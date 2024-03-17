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
  /* Compositing and Blending Level 1 */
  [%css {|mix-blend-mode: normal|}];
  [%css {|mix-blend-mode: multiply|}];
  [%css {|mix-blend-mode: screen|}];
  [%css {|mix-blend-mode: overlay|}];
  [%css {|mix-blend-mode: darken|}];
  [%css {|mix-blend-mode: lighten|}];
  [%css {|mix-blend-mode: color-dodge|}];
  [%css {|mix-blend-mode: color-burn|}];
  [%css {|mix-blend-mode: hard-light|}];
  [%css {|mix-blend-mode: soft-light|}];
  [%css {|mix-blend-mode: difference|}];
  [%css {|mix-blend-mode: exclusion|}];
  [%css {|mix-blend-mode: hue|}];
  [%css {|mix-blend-mode: saturation|}];
  [%css {|mix-blend-mode: color|}];
  [%css {|mix-blend-mode: luminosity|}];
  [%css {|isolation: auto|}];
  [%css {|isolation: isolate|}];
  [%css {|background-blend-mode: normal|}];
  [%css {|background-blend-mode: multiply|}];
  [%css {|background-blend-mode: screen|}];
  [%css {|background-blend-mode: overlay|}];
  [%css {|background-blend-mode: darken|}];
  [%css {|background-blend-mode: lighten|}];
  [%css {|background-blend-mode: color-dodge|}];
  [%css {|background-blend-mode: color-burn|}];
  [%css {|background-blend-mode: hard-light|}];
  [%css {|background-blend-mode: soft-light|}];
  [%css {|background-blend-mode: difference|}];
  [%css {|background-blend-mode: exclusion|}];
  [%css {|background-blend-mode: hue|}];
  [%css {|background-blend-mode: saturation|}];
  [%css {|background-blend-mode: color|}];
  [%css {|background-blend-mode: luminosity|}];
  [%css {|background-blend-mode: normal, multiply|}];

  $ dune build
