(* @property under [%css] used to be split per-descriptor AND have its
   descriptors wrapped in a class selector — doubly invalid CSS. *)
let prop = [%css "@property --my-color { syntax: '<color>'; inherits: false; }"]
