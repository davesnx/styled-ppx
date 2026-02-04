This test ensures type errors inside interpolation expressions are reported

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
  File "input.re", line 2, characters 15-23:
  Error: This constant has type string but an expression was expected of type
           int
