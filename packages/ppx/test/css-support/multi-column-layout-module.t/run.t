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
  /* CSS Multi-column Layout Module Level 1 */
  [%css {|column-width: 10em|}];
  [%css {|column-width: auto|}];
  [%css {|column-count: 2|}];
  [%css {|column-count: auto|}];
  [%css {|columns: 100px|}];
  [%css {|columns: 3|}];
  [%css {|columns: 10em 2|}];
  /* [%css {|columns: auto 2|}]; */
  /* [%css {|columns: 10em auto|}]; */
  [%css {|columns: auto auto|}];
  [%css {|columns: 2 10em|}];
  [%css {|columns: auto 10em|}];
  [%css {|columns: 2 auto|}];
  [%css {|column-rule-color: red|}];
  [%css {|column-rule-style: none|}];
  [%css {|column-rule-style: solid|}];
  [%css {|column-rule-style: dotted|}];
  [%css {|column-rule-width: 1px|}];
  [%css {|column-rule: transparent|}];
  [%css {|column-rule: 1px solid black|}];
  [%css {|column-span: none|}];
  [%css {|column-span: all|}];
  [%css {|column-fill: auto|}];
  [%css {|column-fill: balance|}];
  [%css {|column-fill: balance-all|}];

  $ dune build
