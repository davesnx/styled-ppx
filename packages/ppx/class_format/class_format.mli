(** Merge-aware atom class names (atom-slot-keys, phase 2). Re-exported by
    [Hash_class] (the single source of truth for every hashed identifier, per
    its own header comment) - this module is standalone only so it can be
    unit-tested directly; [Hash_class] is still where a real caller should reach
    for it once phase 3 wires it in.

    Not wired into the real atomization/generate pipeline yet. Format, from
    `.workplace/plans/atom-slot-keys_PLAN.md` ("Direction agreed with the
    user"): a plain atom is [css-] followed by an optional context field, a
    family field, an optional mask field, and a value field, concatenated with
    no separator; an atom carrying [!important] uses [csi-] instead of [css-],
    same fields, same length.

    - [context] is 4 base36 chars, present only when {!Slot_key.context_key} is
      non-empty (a base atom has no context part at all, so it costs nothing
      there).
    - [family] is always exactly 3 base36 chars - {!Slot_key.family_id_to_int},
      a plain bounded int (a table index, a hash-fallback value, or the [all]
      sentinel), zero-padded with no further hashing.
    - [mask] is 3 base36 chars, present only when {!Slot_key.t}'s [mask] is
      [Some _] (a lone longhand or a non-full family atom) - omitted for a plain
      shorthand or any non-family property, which is what keeps the common case
      short.
    - [value] is always exactly 5 base36 chars, a hash of the atom's own
      rendered content - unique only within one (context, family[, mask])
      bucket, not globally, which is what lets it be shorter than today's class
      hash. [generate] is expected to check that uniqueness (mirroring its
      existing `cid-` identity-collision check).

    Parsing at runtime is pure arithmetic on the string's length and fixed
    slices - no shorthand table needed there. *)

val context_width : int
val family_width : int
val mask_width : int
val value_width : int

(** Zero-padded, fixed-width base36 encoding of a bounded non-negative int. The
    caller is responsible for [n] fitting in [width] base36 digits (36^width).
*)
val to_base36_padded : width:int -> int -> string

(** [content]'s hash, reduced to exactly [width] base36 digits - the encoding
    for a field whose input is arbitrary text ([context], atom [content]),
    unlike [family]/[mask] which are already small bounded ints. *)
val hashed_field : width:int -> string -> string

(** [slot_class slot content] is [slot]'s full class name: [content] is the
    atom's own rendered text (the same string [Hash_class.class_and_namespace]
    hashes today). *)
val slot_class : Slot_key.t -> string -> string
