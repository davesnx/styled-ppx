/* REGRESSION TEST — same binding in different CSS property types.

   When a single OCaml binding is interpolated into multiple CSS
   properties whose types differ, static extraction must not deduplicate
   them to one custom property. Each atomized declaration owns its
   variable, whose name is a pure function of that declaration's content
   (the same input that backs the atom's class name), the interpolation
   path, and the resolved runtime type, so each distinct serializer gets
   its own variable.

   Concretely below: `lengthVar` is interpolated into both
   `margin-left:` (Margin.t accepts `auto`) and `padding-left:`
   (Length.t does NOT accept `auto`). The extractor emits separate
   `--var-...` names and separate `Margin.toString` / `Length.toString`
   calls, so a fully type-checked build rejects invalid cross-type reuse.

   Because the variable is keyed to the atom's own declaration content,
   the same binding reused across different properties always receives a
   distinct variable per property, even when the runtime type matches. */

let lengthVar = CSS.px(10);

let layout = [%css
  {|
  margin-left: $(lengthVar);
  padding-left: $(lengthVar);
|}
];
