This test ensures type mismatches between interpolation result and CSS types

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -30
  File "input.re", line 4, characters 13-17:
  Error: The value size has type int but an expression was expected of type
           Css_types.Color.t
