let base36_chars = "0123456789abcdefghijklmnopqrstuvwxyz"

let to_base36_padded ~width n =
  let buf = Bytes.make width '0' in
  let rec fill i n =
    if i >= 0 then (
      Bytes.set buf i base36_chars.[n mod 36];
      fill (i - 1) (n / 36))
  in
  fill (width - 1) n;
  Bytes.unsafe_to_string buf

let pow36 width =
  let rec go acc n = if n = 0 then acc else go (acc * 36) (n - 1) in
  go 1 width

let hashed_field ~width s =
  to_base36_padded ~width (Murmur2.default_int s mod pow36 width)

(* [extended_width] is not a free choice - it must equal
   [Slot_key.extended_hash_width] (Slot_key owns that constant, Class_format
   only reads it, so the two can never drift out of sync - see its own doc
   comment for why the dependency runs that direction). [bundle_value_width]
   is the UPPER bound of a bundle atom's hash field, not a padded width like
   the others: a bundle atom carries none of the other fields (see
   [bundle_class] below), so it needs its own, globally-unique-scale hash
   instead of one only unique within a (context,family[,mask]) bucket, and
   {!bundle_class} deliberately reuses [Murmur2.default]'s own *unpadded*
   base36 output (never [to_base36_padded]) so a bundle atom's length
   distribution matches today's un-bucketed class-name hash exactly, not a
   zero-padded, usually-longer stand-in for it. *)
let context_width = 5
let family_width = 2
let mask_width = 3
let value_width = 4
let extended_width = Slot_key.extended_hash_width
let bundle_value_width = 7

(* The prefixes themselves, not the field widths above. Named here (not
   just inlined as string literals in [slot_class]/[bundle_class]) so a
   parser has one place to read them from. Each prefix already carries its
   own trailing delimiter (the second "_"); no site below adds a separator.

   There is no separate important-atom prefix: [!important] folds into
   {!Slot_key.context_key} instead (see slot_key.mli's [context] doc), so
   an important atom is an ordinary [atom_prefix] atom whose context
   happens to be non-empty - it pays for a context field instead of a
   different prefix letter. *)
let atom_prefix = "_a_"
let bundle_prefix = "_in_"

(* A non-bundle atom's minimum length: its own prefix (delimiter included)
   plus the fixed family + value floor, before any of
   [possible_extra_lengths] applies. Takes a prefix argument (rather than
   hard-coding [atom_prefix]) purely so a caller/test can compute a floor
   from a prefix string without duplicating the arithmetic; only
   [atom_prefix] is ever passed today. *)
let floor_of_prefix prefix = String.length prefix + family_width + value_width

(* The four "extra" lengths beyond the fixed [family_width + value_width]
   floor a non-bundle atom can have - context, mask, extended, or context
   combined with either mask or extended (mask and extended never combine
   with each other: a mask only ever applies to a [Registered] family, and
   a marker family never has one - see [Slot_key.t.mask]/[family_id]).
   Chosen so all six sums here
   (0 and every non-empty combination) are pairwise distinct, which is what
   lets a parser recover which optional fields are present from
   [String.length] alone, with no shorthand table and no per-family
   metadata - see slot_key.mli's module doc. Exposed so a test can assert
   the "unambiguous" property directly against these values instead of
   against a hard-coded table that could silently drift from the widths
   above. *)
let possible_extra_lengths =
  [
    0;
    mask_width;
    context_width;
    extended_width;
    context_width + mask_width;
    context_width + extended_width;
  ]

(* Opaque to CSS.merge in both directions (see Slot_key.removes) - no
   context/family/mask fields, since nothing about them is ever consulted
   for a bundle atom. Exposed standalone (not just inlined in [slot_class])
   so [Hash_class] can mint a real [_in_] class for [Css_file.re]'s
   existing bundle path without needing to build a full, otherwise-unused
   [Slot_key.t] just to reach it. Uses [Murmur2.default] directly, NOT
   [hashed_field] - unpadded, so a bundle atom's hash digits are exactly
   what they would be under today's [Hash_class.class_and_namespace] (only
   the prefix changes), never zero-padded to [bundle_value_width] (which
   would make short hashes needlessly longer than today for no benefit -
   nothing about a bundle atom is ever parsed back apart, so a fixed
   width buys this field nothing). *)
let bundle_class content = bundle_prefix ^ Murmur2.default content

let slot_class (slot : Slot_key.t) content =
  if slot.bundle then bundle_class content
  else (
    (* No important-atom prefix (see the note above [floor_of_prefix]) - an
       !important atom already pays for a real context field instead, since
       {!Slot_key.context_key} folds importance into the context. *)
    let context_part =
      let key = Slot_key.context_key slot.context in
      if key = "" then "" else hashed_field ~width:context_width key
    in
    let family_part =
      to_base36_padded ~width:family_width (Slot_key.family_marker slot.family)
    in
    let extended_part =
      match Slot_key.extended_hash slot.family with
      | None -> ""
      | Some h -> to_base36_padded ~width:extended_width h
    in
    let mask_part =
      match slot.mask with
      | None -> ""
      | Some m -> to_base36_padded ~width:mask_width m
    in
    let value_part = hashed_field ~width:value_width content in
    Printf.sprintf "%s%s%s%s%s%s" atom_prefix context_part family_part
      extended_part mask_part value_part)
