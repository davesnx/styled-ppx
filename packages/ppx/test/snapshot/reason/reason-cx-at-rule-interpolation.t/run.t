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
  File "input.re", line 2, characters 8-28:
  2 |   @media (max-width: $(bp)) {
              ^^^^^^^^^^^^^^^^^^^^
  Error: Interpolation is not supported in @media preludes: `$(x)` compiles to a CSS custom property (var(--x)), and var() is not valid in @media conditions. Write the value literally.
