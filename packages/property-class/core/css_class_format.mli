type prop = Css_class_decode.prop =
  | Id of string
  | Name of string

type decoded = Css_class_decode.decoded =
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

val alphabet : string
val plain_ctx : string

(** Decodes one class token. A token that does not match a shape in tag, width
    and alphabet is [Foreign]. *)
val decode : string -> decoded

val encode_atom : prop:prop -> ctx:string -> value:string -> string

(** A cell is [pid2 ctx6], or [zz name6 ctx6] for a [Name]. *)
val encode_bundle : cells:(prop * string) list -> value:string -> string

val encode_binding_id : string -> string

(** Splits on spaces and drops empty tokens. *)
val tokens : string -> string list
