(* Unknown at-rule names get a typo suggestion against the known
   inventory plus the list of what [%css] accepts. *)
let x = [%css "@meida (min-width: 600px) { color: red; }"]
