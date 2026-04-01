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
  Error: [%%cx2] does not support interpolation in @media preludes. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly or use [%%cx] for runtime media query interpolation.
  [1]
