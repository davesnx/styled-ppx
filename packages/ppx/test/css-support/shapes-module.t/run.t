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
  /* CSS Shapes Module Level 1 */
    /* [%css {|shape-outside: none|}]; */
    /* [%css {|shape-outside: inset(10% round 10% 40% 10% 40%)|}]; */
    /* [%css {|shape-outside: ellipse(at top 50% left 20%)|}]; */
    /* [%css {|shape-outside: circle(at right 5% top)|}]; */
    /* [%css {|shape-outside: polygon(100% 0, 100% 100%, 0 100%)|}]; */
    /* [%css {|shape-outside: path('M 20 20 H 80 V 30')|}]; */
    /* [%css {|shape-outside: margin-box|}]; */
    /* [%css {|shape-outside: border-box|}]; */
    /* [%css {|shape-outside: padding-box|}]; */
    /* [%css {|shape-outside: content-box|}]; */
    /* [%css {|shape-outside: inset(10% round 10% 40% 10% 40%) margin-box|}]; */
    /* [%css {|shape-outside: ellipse(at top 50% left 20%) margin-box|}]; */
    /* [%css {|shape-outside: circle(at right 5% top) margin-box|}]; */
    /* [%css {|shape-outside: polygon(100% 0, 100% 100%, 0 100%) margin-box|}]; */
    /* [%css {|shape-outside: path('M 20 20 H 80 V 30') margin-box|}]; */
    /* [%css {|shape-outside: attr(src url)|}]; */
    /* [%css {|shape-outside: url(image.png)|}]; */
    /* [%css {|shape-image-threshold: 0|}]; */
    /* [%css {|shape-image-threshold: 1|}]; */
    /* [%css {|shape-image-threshold: 0.0|}]; */
    /* [%css {|shape-image-threshold: 0.1|}]; */
    /* [%css {|shape-margin: 0|}]; */
    /* [%css {|shape-margin: 10px|}]; */
    /* [%css {|shape-margin: 50%|}]; */
    /* CSS Shapes Module Level 2 */
    /* [%css {|shape-inside: auto|}]; */
    /* [%css {|shape-inside: outside-shape|}]; */
    /* [%css {|shape-inside: shape-box|}]; */
    /* [%css {|shape-inside: display|}]; */
    /* [%css {|shape-inside: inset(10% round 10% 40% 10% 40%)|}]; */
    /* [%css {|shape-inside: ellipse(at top 50% left 20%)|}]; */
    /* [%css {|shape-inside: circle(at right 5% top)|}]; */
    /* [%css {|shape-inside: polygon(100% 0, 100% 100%, 0 100%)|}]; */
    /* [%css {|shape-inside: path('M 20 20 H 80 V 30')|}]; */
    /* [%css {|shape-inside: url(image.png)|}]; */
    /* [%css {|shape-padding: 0|}]; */
    /* [%css {|shape-padding: 10px|}]; */
    /* [%css {|shape-padding: 50%|}]; */

  $ dune build
