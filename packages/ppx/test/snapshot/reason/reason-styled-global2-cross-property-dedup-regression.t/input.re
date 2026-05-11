/* REGRESSION TEST — pins KNOWN-BROKEN behavior.

   `[%styled.global2]` deduplicates value interpolations by binding
   identity. When the same binding is used in two properties of
   different CSS types, only ONE toString conversion is emitted —
   the type from the FIRST declaration site. Other sites silently
   reuse that same `var(--...)` and inherit the same string form,
   even when the receiving property's type would have rejected it.

   Concretely below: `bg : Background.t` is interpolated into both
   `background:` (accepts gradients) and `color:` (does NOT accept
   gradients). The generated runtime calls only
   `Background.toString(bg)`. If a caller binds `bg` to a
   `linearGradient` (legal for Background.t), the extracted CSS
   resolves `color:` to `linear-gradient(...)`, which browsers reject
   as an invalid color — the typed OCaml API does not catch it.

   This snapshot intentionally pins that fragility so a future fix
   (most-restrictive type wins, or one custom property per
   binding-property pair) shows up as a deliberate snapshot diff
   instead of slipping through unnoticed.

   See: audit report, "MEDIUM — same OCaml binding interpolated
   into different properties picks a single, possibly-wrong type". */

let bg: CSS.Types.Background.t = `color(CSS.red);

module Theme = [%styled.global2 {|
  body {
    background: $(bg);
    color: $(bg);
  }
|}];
