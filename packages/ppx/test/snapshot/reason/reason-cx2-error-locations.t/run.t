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
  File "input.re", lines 2-6, characters 2-2:
  2 | ..{|
  3 |   color: $(main);
  4 |   background-color: $(CSS.black);
  5 |   display: fley;
  6 | |}
  Error: Type error on cx2 definition
  File "input.re", lines 4-5, characters 37-20:
  3 | ...
  4 | .................................
  5 |   display: fley;
    Got 'fley', did you mean 'flex'?
