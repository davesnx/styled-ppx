This test ensures [%css] rejects interpolation in @media preludes with a clear error.
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
  File "input.re", line 5, characters 8-18:
  5 |   @media $(query) {
              ^^^^^^^^^^
  Error: Interpolation is not supported in @media preludes: `$(x)` compiles to a CSS custom property (var(--x)), and var() is not valid in @media conditions. Write the value literally.
  [1]
