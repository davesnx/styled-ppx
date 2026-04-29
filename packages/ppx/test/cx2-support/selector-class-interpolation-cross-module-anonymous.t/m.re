/* Module M defines an anonymous [%cx2]. We're going to try to reference
   it as `M.marker` from N — but anonymous bindings don't appear in the
   aggregator's index because there's nothing to look up. */
let _ = [%cx2 {| color: red; |}];
