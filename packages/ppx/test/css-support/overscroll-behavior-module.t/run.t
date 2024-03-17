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
  /* CSS Overscroll Behavior Module Level 1 */
  [%css {|overscroll-behavior: contain|}];
  [%css {|overscroll-behavior: none|}];
  [%css {|overscroll-behavior: auto|}];
  [%css {|overscroll-behavior: contain contain|}];
  [%css {|overscroll-behavior: none contain|}];
  [%css {|overscroll-behavior: auto contain|}];
  [%css {|overscroll-behavior: contain none|}];
  [%css {|overscroll-behavior: none none|}];
  [%css {|overscroll-behavior: auto none|}];
  [%css {|overscroll-behavior: contain auto|}];
  [%css {|overscroll-behavior: none auto|}];
  [%css {|overscroll-behavior: auto auto|}];
  [%css {|overscroll-behavior-x: contain|}];
  [%css {|overscroll-behavior-x: none|}];
  [%css {|overscroll-behavior-x: auto|}];
  [%css {|overscroll-behavior-y: contain|}];
  [%css {|overscroll-behavior-y: none|}];
  [%css {|overscroll-behavior-y: auto|}];
  [%css {|overscroll-behavior-inline: contain|}];
  [%css {|overscroll-behavior-inline: none|}];
  [%css {|overscroll-behavior-inline: auto|}];
  [%css {|overscroll-behavior-block: contain|}];
  [%css {|overscroll-behavior-block: none|}];
  [%css {|overscroll-behavior-block: auto|}];

  $ dune build
