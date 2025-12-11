This test ensures error column positions are reported accurately

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Test that error positions point to the exact location of the error.
The column position should point to the value, not the start of the property.

  $ dune build 2>&1
  File "input.re", lines 3-4, characters 0-32:
  3 | display: fley"];
      ^^^^^^^^^^^^^
  Error: Got 'fley', did you mean 'flex'?
  [1]
