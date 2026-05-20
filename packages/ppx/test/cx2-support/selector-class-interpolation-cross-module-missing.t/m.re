/* Module M does NOT define a `marker` binding. The ref in n.re below
   should fail with a clear error from the aggregator. */
let other = [%cx2 {| color: green; |}];
