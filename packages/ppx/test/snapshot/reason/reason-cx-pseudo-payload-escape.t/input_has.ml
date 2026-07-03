(* `:has(& + div)`'s subject is outside `&`'s inheritance subtree, so a
   value interpolation (lowered to a custom property set inline on `&`)
   can never reach it. The escape check used to miss `&` inside pseudo
   payloads and silently emitted a dead var(--...). *)
let c = "red"
let esc = [%css ":has(& + div) { color: $(c); }"]
