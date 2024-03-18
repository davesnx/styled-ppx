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
  /* CSS Values and Units Module Level 3 */
  [%css {|width: 5rem;|}];
  [%css {|width: 5ch;|}];
  [%css {|width: 5vw;|}];
  [%css {|width: 5vh;|}];
  [%css {|width: 5vmin;|}];
  [%css {|width: 5vmax;|}];
  /* [%css {|width: 5q;|}]; */
  /* [%css {|width: attr(data-px);|}]; */
  /* [%css {|width: attr(data-px px);|}]; */
  /* [%css {|width: attr(data-px px, initial);|}]; */
  [%css {|width: calc(1px + 2px);|}];
  [%css {|width: calc(5px * 2);|}];
  [%css {|width: calc(5px / 2);|}];
  /* [%css {|width: calc(100%/3 - 2*1em - 2*1px);|}]; */
  /* [%css {|width: calc(attr(data-px)*2);|}]; */
  [%css {|width: calc(5px - 10px);|}];
  [%css {|width: calc(1vw - 1px);|}];
  [%css {|width: calc(100%);|}];
  [%css {|padding: 5rem;|}];
  [%css {|padding: 5ch;|}];
  [%css {|padding: 5vw;|}];
  [%css {|padding: 5vh;|}];
  [%css {|padding: 5vmin;|}];
  [%css {|padding: 5vmax;|}];
  /* [%css {|padding: 5q;|}]; */
  /* [%css {|padding: attr(data-px);|}]; */
  /* [%css {|padding: attr(data-px px);|}]; */
  /* [%css {|padding: attr(data-px px, initial);|}]; */
  /* [%css {|padding: calc(1px + 2px);|}]; */
  /* [%css {|padding: calc(5px*2);|}]; */
  /* [%css {|padding: calc(5px/2);|}]; */
  /* [%css {|padding: calc(100%/3 - 2*1em - 2*1px);|}]; */
  /* [%css {|padding: calc(attr(data-px)*2);|}]; */
  /* [%css {|padding: calc(5px - 10px);|}]; */
  /* [%css {|padding: calc(1vw - 1px);|}]; */
  /* [%css {|padding: calc(calc(100%));|}]; */
  
  /* CSS Values and Units Module Level 4 */
  /* [%css {|width: toggle(1px, 2px);|}]; */
  /* [%css {|width: min(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|width: max(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|width: clamp(12px, 10 * (1vw + 1vh) / 2, 100px);|}]; */
  /* [%css {|padding: toggle(1px, 2px);|}]; */
  /* [%css {|padding: min(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|padding: max(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|padding: clamp(12px, 10 * (1vw + 1vh) / 2, 100px);|}]; */

  $ dune build
