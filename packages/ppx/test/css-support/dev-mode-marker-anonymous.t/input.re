/* With --dev, the marker is suppressed for bindings without a meaningful
   name:
     - `let _ = ...`           : explicitly anonymous, filtered by name guard
     - inline `[%css ...]` at the top level (not bound to a let): no
       enclosing-value name available

   Both cases must produce the same className output as dev-off. */

let _ = [%css {| color: red; |}];

[%css {| color: blue; |}];

/* Sanity: a real binding right after still gets the marker. */
let named = [%css {| color: green; |}];

let _ = named;
