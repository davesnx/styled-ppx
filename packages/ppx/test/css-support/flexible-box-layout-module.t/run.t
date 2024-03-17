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

  $ dune build

  $ dune describe pp input.re
  module X = {
    let value = 1.;
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  /* CSS Flexible Box Layout Module Level 1 */
  [%css {|align-content: flex-start|}];
  [%css {|align-content: flex-end|}];
  [%css {|align-content: space-between|}];
  [%css {|align-content: space-around|}];
  [%css {|align-items: flex-start|}];
  [%css {|align-items: flex-end|}];
  [%css {|align-self: flex-start|}];
  [%css {|align-self: flex-end|}];
  [%css {|display: flex|}];
  [%css {|display: inline-flex|}];
  [%css {|flex: none|}];
  [%css {|flex: 5 7 10%|}];
  [%css {|flex: 2;|}];
  [%css {|flex: 10em;|}];
  [%css {|flex: 30%;|}];
  [%css {|flex: min-content;|}];
  [%css {|flex: 1 30px;|}];
  [%css {|flex: 2 2;|}];
  [%css {|flex: 2 2 10%;|}];
  [%css {|flex: $(X.flex1);|}];
  [%css {|flex: $(X.value) $(X.value);|}];
  [%css {|flex: $(X.value) $(X.value) $(X.min);|}];
  [%css {|flex-basis: auto|}];
  [%css {|flex-basis: content|}];
  [%css {|flex-basis: 1px|}];
  [%css {|flex-direction: row|}];
  [%css {|flex-direction: row-reverse|}];
  [%css {|flex-direction: column|}];
  [%css {|flex-direction: column-reverse|}];
  [%css {|flex-flow: row|}];
  [%css {|flex-flow: row-reverse|}];
  [%css {|flex-flow: column|}];
  [%css {|flex-flow: column-reverse|}];
  [%css {|flex-flow: wrap|}];
  [%css {|flex-flow: wrap-reverse|}];
  [%css {|flex-grow: 0|}];
  [%css {|flex-grow: 5|}];
  [%css {|flex-shrink: 1|}];
  [%css {|flex-shrink: 10|}];
  [%css {|flex-wrap: nowrap|}];
  [%css {|flex-wrap: wrap|}];
  [%css {|flex-wrap: wrap-reverse|}];
  [%css {|justify-content: flex-start|}];
  [%css {|justify-content: flex-end|}];
  [%css {|justify-content: space-between|}];
  [%css {|justify-content: space-around|}];
  [%css {|min-height: auto|}];
  [%css {|min-width: auto|}];
  [%css {|order: 0|}];
  [%css {|order: 1|}];
