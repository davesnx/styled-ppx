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

  $ ../../../standalone.exe --impl input_has.ml -o output.ml
  File "input_has.ml", line 6, characters 17-30:
  6 | let esc = [%css ":has(& + div) { color: $(c); }"]
                       ^^^^^^^^^^^^^
  Error: Cannot interpolate into the value of `color` under `:has(& + div)`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
  $ ../../../standalone.exe --impl input_not.ml -o output.ml
  File "input_not.ml", line 4, characters 17-27:
  4 | let esc = [%css "div:not(&) { color: $(c); }"]
                       ^^^^^^^^^^
  Error: Cannot interpolate into the value of `color` under `div:not(&)`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.
  [1]
  $ ../../../standalone.exe --impl input_is_ok.ml -o output.ml
  $ cat output.ml
  [@@@css.atoms
    [("_c7fgksIS66PPXO4",
       [":is(._c7fgksIS66PPXO4 div){color:var(--c-17791e8);}"], 2, 1, 1,
       [("ctx", "gksIS6", "ctx\\0:is(& div) | ");
       ("value", "6PPXO4", "val\\07f\\0:is(& div) | \\0color:$(c)")]);
    ("_iWVKnbVPs", [], 1, 0, 0,
      [("id", "_iWVKnbVPs", "bind\\0\\0Input_is_ok\\0\\0ok\\00")])]]
  [@@@css.bindings
    [("Input_is_ok.ok", "_iWVKnbVPs _c7fgksIS66PPXO4", "_iWVKnbVPs")]]
  let c = "red"
  let ok =
    CSS.make "_iWVKnbVPs _c7fgksIS66PPXO4"
      [("--c-17791e8", (CSS.Types.Color.toString c))]
