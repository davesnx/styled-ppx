/* REGRESSION TEST — same binding in different CSS property types.

   When one OCaml binding is interpolated into two CSS properties whose
   types differ, static extraction must not merge them into one custom
   property. A block has one variable per (interpolation path, runtime
   type), so each distinct serializer gets its own variable.

   Concretely below: `lengthVar` is interpolated into both
   `margin-left:` (Margin.t accepts `auto`) and `padding-left:`
   (Length.t does NOT accept `auto`). The extractor emits two variables
   and separate `Margin.toString` / `Length.toString` calls, so a fully
   type-checked build rejects invalid cross-type reuse. */

let lengthVar = CSS.px(10);

let layout = [%css
  {|
  margin-left: $(lengthVar);
  padding-left: $(lengthVar);
|}
];
