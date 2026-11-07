type context = {
  scope : string;
  conditions : string list;
  important : bool;
}

(** [is_legacy_pseudo_element selector i] is true when [selector] has a
    single-colon [:after], [:before], [:first-letter] or [:first-line] at [i].
*)
val is_legacy_pseudo_element : string -> int -> bool

(** Lowercases pseudo-class and pseudo-element names outside quoted strings,
    attribute selectors and escapes, then sorts the trailing pseudo-classes of
    one compound selector. Does not sort when they follow a pseudo-element, or
    when a legacy single-colon pseudo-element is among them. *)
val normalize_selector : string -> string

(** Lowercases media feature names: the name right after a [(] that does not
    open a function, when [:], [)], [<], [>] or [=] follows it. Custom property
    names and quoted text keep their case. *)
val canonical_condition : string -> string

(** {!canonical_condition}, then collapses whitespace, and removes it around
    [(], [)], [,] and [:]. *)
val normalize_condition : string -> string

(** The identity of a context: the normalized scope, the sorted normalized
    conditions and the importance, joined by [" | "]. *)
val key : context -> string
