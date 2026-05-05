This test ensures [%cx2] rejects interpolation in @media preludes with a clear error.
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
  File "input.re", lines 3-5, characters 2-3:
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly, or use [%cx] / [%styled.global] (runtime) instead of [%cx2] / [%styled.global2] for runtime media query interpolation.
  [1]
