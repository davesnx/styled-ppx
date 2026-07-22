An invalid an+b payload in `:nth-child()` is rejected with a located
error whose caret points at the payload. It used to crash the compiler
with `Fatal error: exception Failure("int_of_string")` and no location.

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
  File "input.re", line 4, characters 27-33:
  4 | let _x = [%css ":nth-child(3n-abc) { color: red; }"];
                                 ^^^^^^
  Error: Invalid an+b value in :nth-child()
  [1]
