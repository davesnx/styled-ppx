/* REGRESSION TEST — same binding in different CSS property types.

   When a single OCaml binding is interpolated into multiple CSS
   properties whose types differ, static extraction must not deduplicate
   them to one custom property. The custom-property name includes the
   binding source, owning style namespace, and resolved runtime type, so
   each distinct serializer gets its own variable.

   Concretely below: `lengthVar` is interpolated into both
   `margin-left:` (Margin.t accepts `auto`) and `padding-left:`
   (Length.t does NOT accept `auto`). The extractor emits separate
   `--var-...` names and separate `Margin.toString` / `Length.toString`
   calls, so a fully type-checked build rejects invalid cross-type reuse.

   Same binding + same runtime type still deduplicates within one owning
   style expression; only cross-type reuse receives distinct variables. */

let lengthVar = CSS.px(10);

let layout = [%css
  {|
  margin-left: $(lengthVar);
  padding-left: $(lengthVar);
|}
];
