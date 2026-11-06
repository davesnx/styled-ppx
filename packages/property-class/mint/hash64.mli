(** MurmurHash64A over the bytes of the string, with seed 0. *)
val hash : string -> int64

(** [chars h n] writes the low [6 * n] bits of [h] as [n] symbols of
    {!Css_class_format.alphabet}, most significant symbol first. [n] is between
    1 and 10. *)
val chars : int64 -> int -> string
