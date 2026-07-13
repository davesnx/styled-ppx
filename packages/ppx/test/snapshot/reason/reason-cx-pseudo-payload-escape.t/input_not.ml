(* `div:not(&)` matches every div that is NOT the styled element - all of
   them outside `&`'s inheritance subtree. *)
let c = "red"
let esc = [%css "div:not(&) { color: $(c); }"]
