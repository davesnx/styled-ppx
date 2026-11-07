(** [merge a b] is [Css_merge.merge a b], remembered for the last few thousand
    distinct pairs. Safe to call from several threads and domains. *)
val merge : string -> string -> string
