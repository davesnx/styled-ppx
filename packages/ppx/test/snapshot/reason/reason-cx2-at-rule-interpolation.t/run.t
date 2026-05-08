cx2 must reject `$(name)` interpolation anywhere inside an at-rule
prelude — including inside nested paren blocks like the canonical
`@media (max-width: $(bp))` form. Static extraction has no way to bind
CSS custom properties into media-query conditions; users should use
[%cx] / [%styled.global] for runtime media-query interpolation.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -n 5
  File "input.re", lines 2-4, characters 2-3:
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly, or use [%cx] / [%styled.global] (runtime) instead of [%cx2] / [%styled.global2] for runtime media query interpolation.
