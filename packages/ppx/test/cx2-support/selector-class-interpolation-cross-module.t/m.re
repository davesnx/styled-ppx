/* Module M defines a marker [%cx2] binding. The body is empty so the
   binding mints only a deterministic class handle for cross-module refs
   to point at. */
let marker = [%cx2 {||}];
