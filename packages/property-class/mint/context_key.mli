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
    open a function, when [:], [)], [<], [>] or [=] follows it. Then collapses
    whitespace to one space, and removes it at both ends, after [(], before [)],
    and around [:] and [,]. Custom property names and quoted text stay as
    written. The result is valid CSS: [screen and (min-width:1px)]. *)
val canonical_condition : string -> string

(** The identity of a context: the normalized scope, the sorted canonical
    conditions and the importance, joined by [" | "]. *)
val key : context -> string
