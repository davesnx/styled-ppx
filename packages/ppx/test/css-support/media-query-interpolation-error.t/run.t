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
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]
