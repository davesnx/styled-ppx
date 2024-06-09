This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ cat >input.re <<EOF
  >  [%cx {|display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 9-15:
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|width: 100%; display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 22-28:
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|
  >      width: 100%; display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 2, characters 27-33:
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|
  >      width: 100%;
  >      display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 3, characters 14-20:
  Error: Property 'display' has an invalid value: 'blocki'
  [1]
