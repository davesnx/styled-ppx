(* [String.sub] goes through bytes on Melange; the JS [slice] is much cheaper. *)
external slice : string -> int -> int -> string = "slice" [@@mel.send]

let sub s pos len = slice s pos (pos + len)
