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
  /* MathML Core */
    /* [%css {|display: math|}]; */
    /* [%css {|display: block math|}]; */
    /* [%css {|display: inline math|}]; */
    /* [%css {|text-transform: math-auto|}]; */
    /* [%css {|text-transform: math-bold|}]; */
    /* [%css {|text-transform: math-italic|}]; */
    /* [%css {|text-transform: math-bold-italic|}]; */
    /* [%css {|text-transform: math-double-struck|}]; */
    /* [%css {|text-transform: math-bold-fraktur|}]; */
    /* [%css {|text-transform: math-script|}]; */
    /* [%css {|text-transform: math-bold-script|}]; */
    /* [%css {|text-transform: math-fraktur|}]; */
    /* [%css {|text-transform: math-sans-serif|}]; */
    /* [%css {|text-transform: math-bold-sans-serif|}]; */
    /* [%css {|text-transform: math-sans-serif-italic|}]; */
    /* [%css {|text-transform: math-sans-serif-bold-italic|}]; */
    /* [%css {|text-transform: math-monospace|}]; */
    /* [%css {|text-transform: math-initial|}]; */
    /* [%css {|text-transform: math-tailed|}]; */
    /* [%css {|text-transform: math-looped|}]; */
    /* [%css {|text-transform: math-stretched|}]; */
    /* [%css {|font-size: math|}]; */
    /* [%css {|math-style: normal|}]; */
    /* [%css {|math-style: compact|}]; */
    /* [%css {|math-shift: normal|}]; */
    /* [%css {|math-shift: compact|}]; */
    /* [%css {|math-depth: auto-add|}]; */
    /* [%css {|math-depth: add(0)|}]; */
    /* [%css {|math-depth: add(1)|}]; */
    /* [%css {|math-depth: 0|}]; */
    /* [%css {|math-depth: 1|}]; */

  $ dune build
