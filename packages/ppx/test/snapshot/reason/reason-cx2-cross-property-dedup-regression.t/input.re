/* REGRESSION TEST — pins KNOWN-BROKEN behavior.

   When a single OCaml binding is interpolated into multiple CSS
   properties whose types differ, static extraction dedups the
   interpolation to one custom property and one toString call. The
   chosen toString uses whichever type matches the FIRST property
   site, even if later sites have a stricter type that would reject
   some values of the chosen type.

   Concretely below: `lengthVar` is interpolated into both
   `margin-left:` (Margin.t accepts `auto`) and `padding-left:`
   (Padding.t does NOT accept `auto`). The extractor emits a single
   `--var-...` and calls `Margin.toString(lengthVar)`. If a caller
   ever passes ``auto`` (legal for the OCaml type the toString
   accepts), the extracted CSS resolves to `padding-left: auto;`
   which is invalid and rejected by browsers.

   This snapshot intentionally pins that fragility so a future fix
   (most-restrictive type wins, or one custom property per
   binding-property pair) shows up as a deliberate snapshot diff
   instead of slipping through unnoticed.

   See: https://github.com/anomalyco/styled-ppx (audit report,
   "MEDIUM — same OCaml binding interpolated into different
   properties picks a single, possibly-wrong type"). */

let lengthVar = CSS.px(10);

let layout = [%css
  {|
  margin-left: $(lengthVar);
  padding-left: $(lengthVar);
|}
];
