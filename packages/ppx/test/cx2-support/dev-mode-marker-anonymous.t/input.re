/* With --dev, the marker is suppressed for bindings without a meaningful
   name:
     - `let _ = ...`           : explicitly anonymous, filtered by name guard
     - inline `[%cx2 ...]` at the top level (not bound to a let): no
       enclosing-value name available

   Both cases must produce the same className output as dev-off. */

let _ = [%cx2 {| color: red; |}];

[%cx2 {| color: blue; |}];

/* Sanity: a real binding right after still gets the marker. */
let named = [%cx2 {| color: green; |}];

let _ = named;
