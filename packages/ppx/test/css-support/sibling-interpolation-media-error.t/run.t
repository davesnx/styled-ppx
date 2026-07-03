This test ensures the subtree-escaping guard also fires for a sibling selector
nested inside an at-rule (the value interpolation is still scoped inline on `&`).

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
  File "input.re", line 5, characters 4-11:
  Error: Cannot interpolate into the value of `width` under `& + td`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
