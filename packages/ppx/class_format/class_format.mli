(** Merge-aware atom class names. Re-exported by [Hash_class] (the single source
    of truth for every hashed identifier, per its own header comment)
    - this module is standalone only so it can be unit-tested directly;
      [Hash_class] is still where a real caller should reach for it once
      [Css_file.re]'s atomization is taught to mint family atoms and calls into
      this format for every atom, not just bundles.

    Not wired into the real atomization/generate pipeline yet, EXCEPT
    {!bundle_class}, which [Hash_class.bundle_class_and_namespace] already calls
    for real: the atom class-name collision check
    (`packages/generate/generate.ml`) needs a real, recognizable bundle prefix
    to tell a legitimate shared bundle class apart from a genuine hash
    collision.

    Prefixes: [_a_] (any non-bundle atom, important or not - see below), [_in_]
    (an interpolation bundle - see {!Slot_key.t.bundle}). Each prefix already
    carries its own trailing delimiter (the second "_"), so no separate
    separator is ever added at a call site. There is no separate important-atom
    prefix: [!important] folds into {!Slot_key.context_key} instead (see
    slot_key.mli's [context] doc), so an important atom is an ordinary [_a_]
    atom whose context happens to be non-empty. [_a_] is never a prefix of
    [_in_] or vice versa, so a literal-prefix match is unambiguous with no
    lookahead beyond the prefix itself.

    A non-bundle atom ([_a_]) is its prefix followed by an optional context
    field, a family field, an optional extended-hash field, an optional mask
    field, and a value field, concatenated with no separator. A bundle atom
    ([_in_]) carries only a hash, none of those other fields.

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
      bucket, not globally, which is what lets it be shorter than today's class
      hash. [generate] checks that uniqueness (mirroring its existing [_id_]
      identity-collision check, skipping [_in_] atoms).
    - A bundle atom ([_in_]) carries only a {!bundle_value_width}-char (upper
      bound; unpadded, so often shorter) value hash - as wide as today's
      un-bucketed class-name hash, since it has no (context, family[, mask])
      bucket to be unique within, unlike every other atom above.

    **The length table, keyed by prefix first** ({!floor_of_prefix} computes the
    floor row, {!possible_extra_lengths} the six "extra" values the floor can be
    added to; a bundle atom is a separate, simpler row entirely):

    {v
    prefix | len(prefix)+family+value floor | + extras (mask/context/extended)
    -------|---------------------------------|-----------------------------------
    _a_    | 3+2+4 = 9                       | 9, 12, 14, 15, 17, 20
    _in_   | 4, then an unpadded hash        | variable, up to 4+7=11
    v}

    An [!important] atom in an otherwise-base context is an [_a_] row atom with
    the [+context_width] extra applied (14 or 15, depending on whether it also
    needs a mask/extended field) - {!Slot_key.context_key} makes this happen
    automatically, {!slot_class} does not special-case it.

    {!floor_of_prefix} computes the [_a_] row's floor directly from the prefix
    string, so it never needs updating by hand if the prefix's length ever
    changes again - [_in_]'s row is not [floor_of_prefix]-shaped at all, see
    {!bundle_class}.)

    Parsing at runtime is pure arithmetic on the string's length and fixed
    slices once the prefix is known - no shorthand table needed there. See
    {!possible_extra_lengths} for the exact, pairwise-distinct set of "extra"
    lengths beyond a prefix's own floor that makes this possible. *)

val atom_prefix : string
val bundle_prefix : string
val context_width : int
val family_width : int
val mask_width : int
val value_width : int
val extended_width : int
val bundle_value_width : int

(** A non-bundle atom's minimum length for the given prefix (its own length,
    plus the fixed family+value floor) - before any of {!possible_extra_lengths}
    applies. Call with {!atom_prefix}; {!bundle_prefix} has no floor in this
    sense, see {!bundle_class}. *)
val floor_of_prefix : string -> int

(** The six possible values of a non-bundle atom's length minus
    {!floor_of_prefix}'s floor for its own prefix: [0] (base,
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

(** [content]'s hash, reduced to exactly [width] base36 digits - the encoding
    for a field whose input is arbitrary text ([context], atom [content]),
    unlike [family]/[mask] which are already small bounded ints. *)
val hashed_field : width:int -> string -> string

(** The {!bundle_prefix} class for [content] directly - what {!slot_class}
    delegates to for a bundle atom, exposed standalone so a caller that already
    knows an atom is a bundle (e.g. [Hash_class], wiring [Css_file.re]'s
    existing bundle path for real) doesn't need to build a full,
    otherwise-unused {!Slot_key.t} just to reach it. *)
val bundle_class : string -> string

(** [slot_class slot content] is [slot]'s full class name: [content] is the
    atom's own rendered text (the same string [Hash_class.class_and_namespace]
    hashes today). *)
val slot_class : Slot_key.t -> string -> string
