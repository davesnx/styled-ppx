(* Blockless at-rules (@import) under [%css] used to vanish silently:
   an atom was minted and then dropped, degrading the binding to an
   empty class handle. They now error like the runtime path. *)
let x = [%css "@import 'x.css';"]
