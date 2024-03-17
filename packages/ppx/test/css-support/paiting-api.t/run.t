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
  /* CSS Painting API Level 1 */
    /* [%css {|background-image: paint(company-logo);|}]; */
    /* [%css {|background-image: paint(chat-bubble, blue);|}]; */
    /* [%css {|background-image: paint(failing-argument-syntax, 1px, 2px);|}]; */
    /* [%css {|background-image: paint(arc, purple, 0.4turn, 0.8turn, 40px, 15px);|}]; */
    /* [%css {|list-style-image: paint(company-logo);|}]; */
    /* [%css {|list-style-image: paint(chat-bubble, blue);|}]; */
    /* [%css {|list-style-image: paint(failing-argument-syntax, 1px, 2px);|}]; */
    /* [%css {|list-style-image: paint(arc, purple, 0.4turn, 0.8turn, 40px, 15px);|}]; */
    /* [%css {|border-image: paint(company-logo);|}]; */
    /* [%css {|border-image: paint(chat-bubble, blue);|}]; */
    /* [%css {|border-image: paint(failing-argument-syntax, 1px, 2px);|}]; */
    /* [%css {|border-image: paint(arc, purple, 0.4turn, 0.8turn, 40px, 15px);|}]; */
    /* [%css {|cursor: paint(company-logo);|}]; */
    /* [%css {|cursor: paint(chat-bubble, blue);|}]; */
    /* [%css {|cursor: paint(failing-argument-syntax, 1px, 2px);|}]; */
    /* [%css {|cursor: paint(arc, purple, 0.4turn, 0.8turn, 40px, 15px);|}]; */
    /* [%css {|content: paint(company-logo);|}]; */
    /* [%css {|content: paint(chat-bubble, blue);|}]; */
    /* [%css {|content: paint(failing-argument-syntax, 1px, 2px);|}]; */
    /* [%css {|content: paint(arc, purple, 0.4turn, 0.8turn, 40px, 15px);|}]; */

  $ dune build
