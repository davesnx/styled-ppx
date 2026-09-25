(** Merge-aware atom class names (atom-slot-keys, phase 2, checkpoint tweaks
    2026-09-25). Re-exported by [Hash_class] (the single source of truth for
    every hashed identifier, per its own header comment) - this module is
    standalone only so it can be unit-tested directly; [Hash_class] is still
    where a real caller should reach for it once phase 3 wires it in.

    Not wired into the real atomization/generate pipeline yet. Format, from
    `.workplace/plans/atom-slot-keys_PLAN.md` ("Direction agreed with the user",
    checkpoint decisions): a plain atom is [css-] followed by an optional
    context field, a family field, an optional extended-hash field, an optional
    mask field, and a value field, concatenated with no separator; an atom
    carrying [!important] uses [csi-] instead of [css-], same fields, same
    length. A bundle atom (any declaration with a [$(...)] value interpolation -
    see {!Slot_key.t.bundle}) uses [csv-] and none of those other fields at all.

    - [context] is 5 base36 chars, present only when {!Slot_key.context_key} is
      non-empty (a base atom has no context part at all, so it costs nothing
      there).
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
      hash. [generate] is expected to check that uniqueness (mirroring its
      existing `cid-` identity-collision check, skipping [csv-] atoms - see the
      checkpoint's collision-check notes).
    - A bundle atom ([csv-]) carries only a {!bundle_value_width}-char value
      hash - as wide as today's un-bucketed class-name hash, since it has no
      (context, family[, mask]) bucket to be unique within, unlike every other
      atom above.

    Parsing at runtime is pure arithmetic on the string's length and fixed
    slices - no shorthand table needed there. See {!possible_extra_lengths} for
    the exact, pairwise-distinct set of "extra" lengths beyond the fixed
    family+value floor that makes this possible. *)

val context_width : int
val family_width : int
val mask_width : int
val value_width : int
val extended_width : int
val bundle_value_width : int

(** The six possible values of a non-bundle atom's length minus its fixed
    [family_width + value_width] floor: [0] (base, [Registered]/[All], no mask),
    [mask_width] (a longhand/family-atom mask, base context), [context_width] (a
    non-base context, no mask), [extended_width] (an unregistered/custom marker,
    base context), [context_width + mask_width],
    [context_width + extended_width]. All six are pairwise distinct by
    construction - that is the "no shorthand table needed at runtime" property,
    checked directly by a test against this value rather than against a
    hard-coded duplicate of the arithmetic. *)
val possible_extra_lengths : int list

(** Zero-padded, fixed-width base36 encoding of a bounded non-negative int. The
    caller is responsible for [n] fitting in [width] base36 digits (36^width).
*)
val to_base36_padded : width:int -> int -> string

(** [content]'s hash, reduced to exactly [width] base36 digits - the encoding
    for a field whose input is arbitrary text ([context], atom [content]),
    unlike [family]/[mask] which are already small bounded ints. *)
val hashed_field : width:int -> string -> string

(** The [csv-] class for [content] directly - what {!slot_class} delegates to
    for a bundle atom, exposed standalone so a caller that already knows an atom
    is a bundle (e.g. [Hash_class], wiring [Css_file.re]'s existing bundle path
    \- see the checkpoint's collision-check notes) doesn't need to build a full,
    otherwise-unused {!Slot_key.t} just to reach it. *)
val bundle_class : string -> string

(** [slot_class slot content] is [slot]'s full class name: [content] is the
    atom's own rendered text (the same string [Hash_class.class_and_namespace]
    hashes today). *)
val slot_class : Slot_key.t -> string -> string
