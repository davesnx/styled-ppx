This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "input.re", line 11, characters 21-29:
  11 |     text-decoration: $(cosas);
                            ^^^^^^^^
  Error: This expression has type [> `bold ]
         but an expression was expected of type
           Css_types.TextDecorationLine.Value.t
         The second variant type does not allow tag(s) `bold
  [1]
