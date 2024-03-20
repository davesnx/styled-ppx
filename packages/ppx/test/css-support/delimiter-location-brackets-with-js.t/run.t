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

  $ cat >input.re <<EOF
  >  [%cx {|display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 1, characters 8-24:
  1 |  [%cx {|display: blocki;|}];
              ^^^^^^^^^^^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|width: 100%; display: blocki;|}];
  > EOF

  $ dune build
  File "input.re", line 2, characters 20-37:
  2 |  [%cx {|width: 100%; display: blocki;|}];
                          ^^^^^^^^^^^^^^^^^
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|
  >      width: 100%; display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 3, characters 25-42:
  2 | .......
  3 | ................. display: blocki;
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

  $ cat >input.re <<EOF
  >  [%cx {|
  >      width: 100%;
  >      display: blocki;
  >  |}];
  > EOF

  $ dune build
  File "input.re", line 3, characters 25-29:
  1 | .......
  2 | .................
  3 |      display: blocki;
  Error: Property 'display' has an invalid value: 'blocki'
  [1]
