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
  /* CSS Fragmentation Module Level 3 */
  [%css {|break-before: auto|}];
  [%css {|break-before: avoid|}];
  [%css {|break-before: avoid-page|}];
  [%css {|break-before: page|}];
  [%css {|break-before: left|}];
  [%css {|break-before: right|}];
  [%css {|break-before: recto|}];
  [%css {|break-before: verso|}];
  [%css {|break-before: avoid-column|}];
  [%css {|break-before: column|}];
  [%css {|break-before: avoid-region|}];
  [%css {|break-before: region|}];
  [%css {|break-after: auto|}];
  [%css {|break-after: avoid|}];
  [%css {|break-after: avoid-page|}];
  [%css {|break-after: page|}];
  [%css {|break-after: left|}];
  [%css {|break-after: right|}];
  [%css {|break-after: recto|}];
  [%css {|break-after: verso|}];
  [%css {|break-after: avoid-column|}];
  [%css {|break-after: column|}];
  [%css {|break-after: avoid-region|}];
  [%css {|break-after: region|}];
  [%css {|break-inside: auto|}];
  [%css {|break-inside: avoid|}];
  [%css {|break-inside: avoid-page|}];
  [%css {|break-inside: avoid-column|}];
  [%css {|break-inside: avoid-region|}];
  [%css {|box-decoration-break: slice|}];
  [%css {|box-decoration-break: clone|}];
  [%css {|orphans: 1|}];
  [%css {|orphans: 2|}];
  [%css {|widows: 1|}];
  [%css {|widows: 2|}];

  $ dune build
  File "input.re", line 1, characters 0-6:
  Error: Unbound value CssJs.widows
  [1]
