Simple test for error locations

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

This should give an error for 'display: fley':
  $ dune build 2>&1
  File "input.re", line 4, characters 27-31:
  4 | let test1 = [%cx "display: fley"];
                                 ^^^^
  Error: Property 'display' has an invalid value: 'fley'
  [1]
