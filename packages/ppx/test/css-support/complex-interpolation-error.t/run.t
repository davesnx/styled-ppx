Test what happens with complex expressions in interpolation

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
  File "input.re", line 9, characters 11-57:
  Error: Invalid interpolation expression: syntax error, consider adding a `;'
         before
