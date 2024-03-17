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
  /* Environment Variables Level 1 */
    /* [%css {|width: env(safe-area-inset-top);|}]; */
    /* [%css {|width: env(safe-area-inset-top, 12px);|}]; */
    /* [%css {|width: env(safe-area-inset-right);|}]; */
    /* [%css {|width: env(safe-area-inset-right, 12px);|}]; */
    /* [%css {|width: env(safe-area-inset-bottom);|}]; */
    /* [%css {|width: env(safe-area-inset-bottom, 12px);|}]; */
    /* [%css {|width: env(safe-area-inset-left);|}]; */
    /* [%css {|width: env(safe-area-inset-left, 12px);|}]; */
    /* [%css {|padding: env(safe-area-inset-top);|}]; */
    /* [%css {|padding: env(safe-area-inset-top, 12px);|}]; */
    /* [%css {|padding: env(safe-area-inset-right);|}]; */
    /* [%css {|padding: env(safe-area-inset-right, 12px);|}]; */
    /* [%css {|padding: env(safe-area-inset-bottom);|}]; */
    /* [%css {|padding: env(safe-area-inset-bottom, 12px);|}]; */
    /* [%css {|padding: env(safe-area-inset-left);|}]; */
    /* [%css {|padding: env(safe-area-inset-left, 12px);|}]; */

  $ dune build
