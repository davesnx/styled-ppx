/* Regression test: a runtime interpolation `$(x)` used inside a nested
   pseudo-element selector (e.g. `&::placeholder`) emits `color: var(--var-HASH)`
   in the extracted CSS and must ALSO emit the `--var-HASH` definition in the
   runtime inline-style list (the 2nd argument of `CSS.make`), exactly like a
   top-level interpolation does.

   If the inline list were empty `[]` for the `::placeholder` case while the
   extracted `[@css ...]` references `var(--var-HASH)`, the custom property would
   be undefined at runtime and the declared value would silently fall back. */

let c = CSS.hex("ff0000");

/* control: top-level interpolation — inline --var IS emitted */
let topLevel = [%css {| color: $(c); |}];

/* pseudo-class nested */
let hover = [%css {| &:hover { color: $(c); } |}];

/* pseudo-element nested (the ::placeholder bug) */
let placeholder = [%css {| &::placeholder { color: $(c); } |}];

let _ = (topLevel, hover, placeholder);
