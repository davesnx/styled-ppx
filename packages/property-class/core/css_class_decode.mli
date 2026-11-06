type prop =
  | Id of string
  | Name of string

type decoded =
  | Atom of {
      prop : prop;
      ctx : string;
      value : string;
    }
  | Bundle of {
      cells : (prop * string) list;
      value : string;
    }
  | Binding_id of string
  | Foreign

val plain_ctx : string
val symbols_at : string -> int -> int -> bool
val id_at : string -> int -> bool

(** The decoding half of {!Css_class_format}, kept apart so that a runtime that
    only merges links no encoder. *)
val decode : string -> decoded

val tokens : string -> string list
