(** Merge-aware atom class names. Re-exported by [Hash_class] (the single source
    of truth for every hashed identifier, per its own header comment)
    - this module is standalone only so it can be unit-tested directly;
      [Hash_class] is where a real caller reaches for it, and [Css_file.re]'s
      atomization mints every atom through this format.

    Prefix: [_a_], for every atom, important or not (see below). It carries its
    own trailing delimiter (the second "_"), so no separate separator is ever
    added at a call site. There is no separate important-atom prefix:
    [!important] folds into {!Slot_key.context_key} instead (see slot_key.mli's
    [context] doc), so an important atom is an ordinary [_a_] atom whose context
    happens to be non-empty. A member of a group of atoms that share one
    interpolation variable is an ordinary [_a_] atom too ([Hash_class] hashes
    its value field together with the group seed).

    An atom is its prefix followed by an optional context field, a family field,
    an optional extended-hash field, an optional mask field, and a value field,
    concatenated with no separator.

    - [context] is 5 base36 chars, present only when {!Slot_key.context_key} is
      non-empty (a base, non-important atom has no context part at all, so it
      costs nothing there; an [!important] atom always has one, even in an
      otherwise-base context, since importance is folded into the context key).
    - [family] is always exactly 2 base36 chars - {!Slot_key.family_marker}, a
      plain bounded int (a table index, or one of two reserved
      unregistered/custom markers, or the [all] sentinel), zero-padded with no
      further hashing.
    - [extended] is {!Slot_key.extended_hash_width} base36 chars, present only
      when {!Slot_key.extended_hash} is [Some _] (the family field held one of
      the two unregistered markers, which carry no identity of their own - the
      real hash lives here instead). Never present together with [mask] - a mask
      only ever applies to a [Registered] family (see {!Slot_key.t.mask}), and a
      marker family never has one.
    - [mask] is 3 base36 chars, present only when {!Slot_key.t}'s [mask] is
      [Some _] (a lone longhand or a non-full family atom) - omitted for a plain
      shorthand or any non-family property, which is what keeps the common case
      short.
    - [value] is always exactly 4 base36 chars, a hash of the atom's own
      rendered content - unique only within one (context, family[, mask])
      bucket, not globally, which is what lets it be short. [generate] checks
      that uniqueness (mirroring its existing [_id_] identity-collision check).

    **The length table**: the floor, {!atom_floor}, is the prefix plus family
    and value, 3+2+4 = 9. {!possible_extra_lengths} are the six "extra" values
    the floor can be added to (mask, context, extended), so an atom is 9, 12,
    14, 15, 17 or 20 characters long.

    An [!important] atom in an otherwise-base context has the [+context_width]
    extra applied (14 or 15, depending on whether it also needs a mask/extended
    field) - {!Slot_key.context_key} makes this happen automatically,
    {!slot_class} does not special-case it.

    Parsing at runtime is pure arithmetic on the string's length and fixed
    slices once the prefix is known - no shorthand table needed there. See
    {!possible_extra_lengths} for the exact, pairwise-distinct set of "extra"
    lengths beyond the floor that makes this possible. *)

val atom_prefix : string
val context_width : int
val family_width : int
val mask_width : int
val value_width : int
val extended_width : int

(** An atom's minimum length (its prefix, plus the fixed family+value floor) -
    before any of {!possible_extra_lengths} applies. *)
val atom_floor : int

(** The six possible values of an atom's length minus {!atom_floor}: [0] (base,
    [Registered]/[All], no mask), [mask_width] (a longhand/family-atom mask,
    base context), [context_width] (a non-base context, no mask),
    [extended_width] (an unregistered/custom marker, base context),
    [context_width + mask_width], [context_width + extended_width]. All six are
    pairwise distinct by construction - that is the "no shorthand table needed
    at runtime" property, checked directly by a test against this value rather
    than against a hard-coded duplicate of the arithmetic. *)
val possible_extra_lengths : int list

(** Zero-padded, fixed-width base36 encoding of a bounded non-negative int. The
    caller is responsible for [n] fitting in [width] base36 digits (36^width).
*)
val to_base36_padded : width:int -> int -> string

(** [slot_class slot content] is [slot]'s full class name: [content] is the
    atom's own rendered text (the same string [Hash_class.class_and_namespace]
    hashes). *)
val slot_class : Slot_key.t -> string -> string
