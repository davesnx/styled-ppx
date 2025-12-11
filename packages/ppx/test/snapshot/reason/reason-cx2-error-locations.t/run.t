This test ensures error locations are reported accurately for cx2 CSS property errors

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Test cx2 error location accuracy. The error should point to the exact line where 'display: fley' is.
The error should be on line 5, not lines 3-4.

  $ dune build 2>&1 | head -n 30
  File "input.re", line 5, characters 0-16:
  5 |   display: fley;
      ^^^^^^^^^^^^^^^^
  Error: Got 'fley', did you mean 'flex'?
