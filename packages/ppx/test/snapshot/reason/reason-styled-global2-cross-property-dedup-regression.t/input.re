/* REGRESSION TEST — same binding in different CSS property types.

   `[%styled.global]` custom-property names include the binding source,
   owning style namespace, and resolved runtime type. When the same binding
   is used in two properties of different CSS types, the generated CSS uses
   two custom properties and the generated runtime emits two toString calls.

   Concretely below: `bg : Background.t` is interpolated into both
   `background:` and `color:`. The generated `Color.toString(bg)` call is
   intentionally visible in the snapshot: a fully type-checked build should
   reject this instead of silently serializing a background as a color.

   Same binding + same runtime type still deduplicates within one owning
   style expression; only cross-type reuse receives distinct variables. */

let bg: CSS.Types.Background.t = `color(CSS.red);

module Theme = [%styled.global
  {|
  body {
    background: $(bg);
    color: $(bg);
  }
|}
];
