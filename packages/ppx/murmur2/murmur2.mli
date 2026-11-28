(** [default s] is the base36 form of [murmur2 s], the same string as
    [@emotion/hash] on ASCII input. *)
val default : string -> string

(** [murmur2 s] is the 32-bit murmur2 hash of the bytes of [s], as a
    non-negative int. *)
val murmur2 : string -> int

(** [base36 ~width n] is the last [width] base36 digits of the non-negative [n],
    left-padded with ['0']: the base36 form of [n mod 36^width]. *)
val base36 : width:int -> int -> string
