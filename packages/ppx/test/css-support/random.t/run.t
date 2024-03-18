This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.css_native styled-ppx.emotion_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF


  $ dune_describe_pp _build/default/input.re.pp.ml
  _build/default/input.re.pp.ml: No such file or directory

  $ dune_describe_pp _build/default/input.re.pp.ml | refmt --parse ml --print re
  Syntaxerr.Error(_)
  [1]
