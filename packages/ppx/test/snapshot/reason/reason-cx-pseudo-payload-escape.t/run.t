Value interpolations under selectors whose `&` lives only inside a
pseudo-class payload.

`[%css]` lowers `$(expr)` values to a custom property set inline on `&`;
only `&` and its descendants inherit it. The subtree-escape check used to
inspect only top-level chain segments, so selectors like `:has(& + div)`
or `div:not(&)` — whose only `&` sits inside a pseudo payload and whose
subject is outside `&`'s subtree — slipped through and shipped a dead
`var(--...)`. They now raise the same error as `& + div`.

`:is()`/`:where()` payloads whose every branch keeps its subject inside
`&` (e.g. `:is(& div)`) prove containment and are still accepted.

  $ standalone --impl input_has.ml -o output.ml
  File "input_has.ml", line 6, characters 18-32:
  Error: Cannot interpolate into the value of `color` under `:has(& + div)`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
  $ standalone --impl input_not.ml -o output.ml
  File "input_not.ml", line 4, characters 18-29:
  Error: Cannot interpolate into the value of `color` under `div:not(&)`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
  $ standalone --impl input_is_ok.ml -o output.ml
  $ cat output.ml
  [@@@css ":is(.css-1ptjfl7-ok div){color:var(--c-qdrabr);}"]
  [@@@css.bindings [("Input_is_ok.ok", "css-1ptjfl7-ok")]]
  let c = "red"
  let ok =
    CSS.make "css-1ptjfl7-ok" [("--c-qdrabr", (CSS.Types.Color.toString c))]
