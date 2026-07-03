(* `:is(& div)` is exactly `& div`: the subject is a descendant of `&`
   and inherits the custom property, so interpolation is fine. *)
let c = "red"
let ok = [%css ":is(& div) { color: $(c); }"]
