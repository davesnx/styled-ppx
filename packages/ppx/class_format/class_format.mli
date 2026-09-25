(** Merge-aware atom class names (atom-slot-keys, phase 2, checkpoint tweaks
    2026-09-25, prefix rename 2026-09-25). Re-exported by [Hash_class] (the
    single source of truth for every hashed identifier, per its own header
    comment) - this module is standalone only so it can be unit-tested directly;
    [Hash_class] is still where a real caller should reach for it once phase 3
    wires it in.

    Not wired into the real atomization/generate pipeline yet, EXCEPT
    {!bundle_class}, which [Hash_class.bundle_class_and_namespace] already calls
    for real (see the checkpoint's collision-check notes - the atom class-name
    collision check needed a real, recognizable bundle prefix to be shown safe
    against real interpolation-bundled content).

    Prefixes, from the user's naming decision (2026-09-25): [a-] (any non-bundle
    atom, important or not - see below), [in-] (an interpolation bundle - see
    {!Slot_key.t.bundle}). An earlier version of this rename gave [!important]
    its own prefix ([ia-]); the user replaced that with folding [!important]
    into {!Slot_key.context_key} instead (see slot_key.mli's [context] doc), so
    there is no third prefix - an important atom is an ordinary [a-] atom whose
    context happens to be non-empty. [a-] is never a prefix of [in-] or vice
    versa, so a literal-prefix match is unambiguous with no lookahead beyond the
    prefix itself.

    A non-bundle atom ([a-]) is its prefix followed by an optional context
    field, a family field, an optional extended-hash field, an optional mask
    field, and a value field, concatenated with no separator. A bundle atom
    ([in-]) carries only a hash, none of those other fields.

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
      hash. [generate] checks that uniqueness (mirroring its existing [id-]
      identity-collision check, skipping [in-] atoms).
    - A bundle atom ([in-]) carries only a {!bundle_value_width}-char (upper
      bound; unpadded, so often shorter) value hash - as wide as today's
      un-bucketed class-name hash, since it has no (context, family[, mask])
      bucket to be unique within, unlike every other atom above.

    **The length table, keyed by prefix first** ({!floor_of_prefix} computes the
    floor row, {!possible_extra_lengths} the six "extra" values the floor can be
    added to; a bundle atom is a separate, simpler row entirely):

    {v
    prefix | len(prefix)+"-"+family+value floor | + extras (mask/context/extended)
    -------|--------------------------------------|-----------------------------------
    a-     | 1+1+2+4 = 8                          | 8, 11, 13, 14, 16, 19
    in-    | 2+1 = 3, then an unpadded hash        | variable, up to 3+7=10
    v}

    An [!important] atom in an otherwise-base context is an [a-] row atom with
    the [+context_width] extra applied (13 or 14, depending on whether it also
    needs a mask/extended field) - {!Slot_key.context_key} makes this happen
    automatically, {!slot_class} does not special-case it.

    {!floor_of_prefix} computes the [a-] row's floor directly from the prefix
    string, so it never needs updating by hand if the prefix's length ever
    changes again - [in-]'s row is not [floor_of_prefix]-shaped at all, see
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
    plus the ["-"] separator, plus the fixed family+value floor) - before any of
    {!possible_extra_lengths} applies. Call with {!atom_prefix};
    {!bundle_prefix} has no floor in this sense, see {!bundle_class}. *)
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
    existing bundle path for real - see the checkpoint's collision-check notes)
    doesn't need to build a full, otherwise-unused {!Slot_key.t} just to reach
    it. *)
val bundle_class : string -> string

(** [slot_class slot content] is [slot]'s full class name: [content] is the
    atom's own rendered text (the same string [Hash_class.class_and_namespace]
    hashes today). *)
val slot_class : Slot_key.t -> string -> string
