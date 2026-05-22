/* Module M defines an anonymous [%css]. We're going to try to reference
   it as `M.marker` from N — but anonymous bindings don't appear in the
   aggregator's index because there's nothing to look up. */
let _ = [%css {| color: red; |}];
