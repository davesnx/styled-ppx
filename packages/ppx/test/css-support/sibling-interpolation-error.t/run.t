This test ensures [%css] rejects a value interpolation under a subtree-escaping
sibling selector with a clear error, rather than silently dropping it. The
custom property would be scoped inline on `&`, which the sibling target cannot
inherit.

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
  File "input.re", line 6, characters 2-15:
  Error: Cannot interpolate into the value of `border-color` under `& + .sibling`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so a sibling can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
