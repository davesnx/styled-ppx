type context = {
  scope : string;
  conditions : string list;
  important : bool;
}

(** Sorts the trailing pseudo-classes of one compound selector. Leaves the
    selector unchanged when they follow a pseudo-element. *)
val normalize_selector : string -> string

(** Collapses whitespace, and removes it around [(], [)], [,] and [:]. *)
val normalize_condition : string -> string

(** The identity of a context: the normalized scope, the sorted normalized
    conditions and the importance, joined by [" | "]. *)
val key : context -> string
