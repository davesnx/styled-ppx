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
  /* CSS Scroll Snap Module Level 1 */
  [%css {|scroll-margin: 0px|}];
  [%css {|scroll-margin: 6px 5px|}];
  [%css {|scroll-margin: 10px 20px 30px|}];
  [%css {|scroll-margin: 10px 20px 30px 40px|}];
  [%css {|scroll-margin: 20px 3em 1in 5rem|}];
  [%css {|scroll-margin: calc(2px)|}];
  [%css {|scroll-margin: calc(3 * 25px)|}];
  [%css {|scroll-margin: calc(3 * 25px) 5px 10em calc(1vw - 5px)|}];
  [%css {|scroll-margin-block: 10px|}];
  [%css {|scroll-margin-block: 10px 10px|}];
  [%css {|scroll-margin-block-end: 10px|}];
  [%css {|scroll-margin-block-start: 10px|}];
  [%css {|scroll-margin-bottom: 10px|}];
  [%css {|scroll-margin-inline: 10px|}];
  [%css {|scroll-margin-inline: 10px 10px|}];
  [%css {|scroll-margin-inline-start: 10px|}];
  [%css {|scroll-margin-inline-end: 10px|}];
  [%css {|scroll-margin-left: 10px|}];
  [%css {|scroll-margin-right: 10px|}];
  [%css {|scroll-margin-top: 10px|}];
  [%css {|scroll-padding: auto|}];
  [%css {|scroll-padding: 0px|}];
  [%css {|scroll-padding: 6px 5px|}];
  [%css {|scroll-padding: 10px 20px 30px|}];
  [%css {|scroll-padding: 10px 20px 30px 40px|}];
  [%css {|scroll-padding: 10px auto 30px auto|}];
  [%css {|scroll-padding: 10%|}];
  [%css {|scroll-padding: 20% 3em 1in 5rem|}];
  [%css {|scroll-padding: calc(2px)|}];
  [%css {|scroll-padding: calc(50%)|}];
  [%css {|scroll-padding: calc(3 * 25px)|}];
  [%css {|scroll-padding: calc(3 * 25px) 5px 10% calc(10% - 5px)|}];
  [%css {|scroll-padding-block: 10px|}];
  [%css {|scroll-padding-block: 50%|}];
  [%css {|scroll-padding-block: 10px 50%|}];
  [%css {|scroll-padding-block: 50% 50%|}];
  [%css {|scroll-padding-block-end: 10px|}];
  [%css {|scroll-padding-block-end: 50%|}];
  [%css {|scroll-padding-block-start: 10px|}];
  [%css {|scroll-padding-block-start: 50%|}];
  [%css {|scroll-padding-bottom: 10px|}];
  [%css {|scroll-padding-bottom: 50%|}];
  [%css {|scroll-padding-inline: 10px|}];
  [%css {|scroll-padding-inline: 50%|}];
  [%css {|scroll-padding-inline: 10px 50%|}];
  [%css {|scroll-padding-inline: 50% 50%|}];
  [%css {|scroll-padding-inline-end: 10px|}];
  [%css {|scroll-padding-inline-end: 50%|}];
  [%css {|scroll-padding-inline-start: 10px|}];
  [%css {|scroll-padding-inline-start: 50%|}];
  [%css {|scroll-padding-left: 10px|}];
  [%css {|scroll-padding-left: 50%|}];
  [%css {|scroll-padding-right: 10px|}];
  [%css {|scroll-padding-right: 50%|}];
  [%css {|scroll-padding-top: 10px|}];
  [%css {|scroll-padding-top: 50%|}];
  [%css {|scroll-snap-align: none|}];
  [%css {|scroll-snap-align: start|}];
  [%css {|scroll-snap-align: end|}];
  [%css {|scroll-snap-align: center|}];
  [%css {|scroll-snap-align: none start|}];
  [%css {|scroll-snap-align: end center|}];
  [%css {|scroll-snap-align: center start|}];
  [%css {|scroll-snap-align: end none|}];
  [%css {|scroll-snap-align: center center|}];
  [%css {|scroll-snap-stop: normal|}];
  [%css {|scroll-snap-stop: always|}];
  [%css {|scroll-snap-type: none|}];
  [%css {|scroll-snap-type: x mandatory|}];
  [%css {|scroll-snap-type: y mandatory|}];
  [%css {|scroll-snap-type: block mandatory|}];
  [%css {|scroll-snap-type: inline mandatory|}];
  [%css {|scroll-snap-type: both mandatory|}];
  [%css {|scroll-snap-type: x proximity|}];
  [%css {|scroll-snap-type: y proximity|}];
  [%css {|scroll-snap-type: block proximity|}];
  [%css {|scroll-snap-type: inline proximity|}];
  [%css {|scroll-snap-type: both proximity|}];

  $ dune build
