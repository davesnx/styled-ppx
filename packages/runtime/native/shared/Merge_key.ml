(* Merge_key
   =========

   [CSS.merge]'s removal rule, applied entirely at runtime by parsing the
   fixed-width fields [Class_format] already encoded into an atom's class
   name (context/family/extended/mask/value) - no shorthand table, no CSS
   property knowledge. Every field is compared as an opaque string (context,
   family, extended) or an opaque bounded int (mask, via a bitwise subset
   check); this module never needs to know WHAT a field means, only how
   wide it is and how two atoms' fields compare.

   This is the single rule [Slot_key.removes] defines, minus the [bundle]
   short-circuit (an [in-] token never reaches {!parse_atom}'s callers in
   the first place - see [merge_class_names] below).

   Why this duplicates [Class_format]'s widths instead of depending on it:
   this module ships in the melange runtime bundle (real browser JS).
   [Class_format]/[Slot_key]/[Css_grammar] exist to build the ppx's
   compile-time property registry; depending on them here would ship that
   whole registry to the browser for a module whose entire point is that
   runtime merge needs no such registry. The widths and markers below are
   a deliberate, narrow duplication - see
   [packages/ppx/class_format/class_format.mli]'s length table for the
   authoritative definition, and [packages/runtime/test]'s own tests for
   the cross-check against the real [Slot_key]/[Class_format] values (that
   test, not this library, is allowed to depend on them). *)

let atom_prefix = "a-"
let context_width = 5
let family_width = 2
let mask_width = 3
let value_width = 4
let extended_width = 6

(* [Slot_key.Registry]'s three reserved family markers and the two fixed
   registered indices [Slot_key.is_excluded_from_all] special-cases,
   base36-encoded at [family_width] the same way [Class_format.slot_class]
   encodes every family field. These five 2-character strings are the
   ONLY property-specific knowledge this module carries, and only for the
   [all: unset] case - everything else compares fields as opaque data. *)
let all_sentinel = "zz"
let unregistered_custom_marker = "zy"
let direction_marker = "5q"
let unicode_bidi_marker = "dp"

let is_excluded_from_all family =
  String.equal family unregistered_custom_marker
  || String.equal family direction_marker
  || String.equal family unicode_bidi_marker

(* One [a-] atom's merge-relevant fields, sliced out of its class name.
   [context]/[family]/[extended] are the raw base36 substrings (compared
   for string equality only); [mask] is the one field decoded to an int,
   since only it needs a bitwise subset check. *)
type atom = {
  context : string; (* "" for the base context *)
  family : string;
  extended : string option;
  mask : int option;
    (* [None] means "full" (a plain shorthand, or any
                         non-family property) - see [Slot_key.t.mask]. *)
}

let base36_value s =
  let value = ref 0 in
  String.iter
    (fun c ->
      let digit =
        match c with
        | '0' .. '9' -> Char.code c - Char.code '0'
        | 'a' .. 'z' -> Char.code c - Char.code 'a' + 10
        | _ -> 0 (* unreachable for a real [Class_format] field *)
      in
      value := (!value * 36) + digit)
    s;
  !value

(* [None] for anything that isn't a well-formed [a-] atom: not [a-]
   -prefixed, or [a-]-prefixed but not one of the six lengths
   [Class_format.possible_extra_lengths] makes possible (a stray class
   this pipeline never minted). Either way, the caller treats it as
   opaque and passes it through untouched, same as an [in-]/[id-]/
   [label:...] token. *)
(* Which optional fields [extra] chars beyond the family+value floor
   implies - the six values [Class_format.possible_extra_lengths]
   guarantees are pairwise distinct. [None] for anything else: not a
   shape this pipeline ever mints. *)
let fields_of_extra extra =
  if extra = 0 then Some (false, false, false)
  else if extra = mask_width then Some (false, true, false)
  else if extra = context_width then Some (true, false, false)
  else if extra = extended_width then Some (false, false, true)
  else if extra = context_width + mask_width then Some (true, true, false)
  else if extra = context_width + extended_width then Some (true, false, true)
  else None

let parse_atom class_name =
  let prefix_len = String.length atom_prefix in
  if
    String.length class_name < prefix_len
    || not (String.equal (String.sub class_name 0 prefix_len) atom_prefix)
  then None
  else (
    let body =
      String.sub class_name prefix_len (String.length class_name - prefix_len)
    in
    let floor = family_width + value_width in
    match fields_of_extra (String.length body - floor) with
    | None -> None
    | Some (has_context, has_mask, has_extended) ->
      let pos = ref 0 in
      let take width =
        let s = String.sub body !pos width in
        pos := !pos + width;
        s
      in
      let context = if has_context then take context_width else "" in
      let family = take family_width in
      let extended =
        if has_extended then Some (take extended_width) else None
      in
      let mask =
        if has_mask then Some (base36_value (take mask_width)) else None
      in
      ignore (take value_width);
      Some { context; family; extended; mask })

let context_equal a b = String.equal a.context b.context

let family_equal a b =
  String.equal a.family b.family
  &&
  match a.extended, b.extended with
  | None, None -> true
  | Some x, Some y -> String.equal x y
  | Some _, None | None, Some _ -> false

let mask_subset a b =
  match a, b with
  | None, None -> true
  | None, Some _ -> false
  | Some _, None -> true
  | Some ma, Some mb -> ma land mb = ma

(* [removes ~former ~latter]: mirrors [Slot_key.removes] exactly (minus
   the bundle check, already handled by the caller) - same context, then
   either [latter]'s family is the [all] sentinel (former removed unless
   excluded), or the same family and [former]'s mask a subset of
   [latter]'s. *)
let removes ~former ~latter =
  context_equal former latter
  &&
  if String.equal latter.family all_sentinel then
    not (is_excluded_from_all former.family)
  else family_equal former latter && mask_subset former.mask latter.mask

(* -- className string merge --------------------------------------------- *)

let is_space = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let split_tokens s =
  let n = String.length s in
  let rec loop i acc =
    if i >= n then List.rev acc
    else if is_space s.[i] then loop (i + 1) acc
    else (
      let j = ref i in
      while !j < n && not (is_space s.[!j]) do
        incr j
      done;
      loop !j (String.sub s i (!j - i) :: acc))
  in
  loop 0 []

(* [merge_class_names former latter]: [former]'s tokens survive unless a
   token is a parseable [a-] atom that some [latter] atom [removes]. Every
   other token - [in-] bundles, [id-] identities, `label:<binding>`
   markers, and any class this module fails to parse - is kept
   unconditionally, on both sides, in its original relative order (bundles
   and identities are never dropped and never drop anything, by
   [Slot_key.removes]'s own contract; an unparseable class is not this
   module's concern to police). [latter]'s tokens are never dropped -
   [CSS.merge]'s right argument always wins outright. *)
let merge_class_names former latter =
  let former_tokens = split_tokens former in
  let latter_tokens = split_tokens latter in
  let latter_atoms =
    List.filter_map parse_atom latter_tokens |> Array.of_list
  in
  let survives token =
    match parse_atom token with
    | None -> true
    | Some former_atom ->
      not
        (Array.exists
           (fun latter_atom -> removes ~former:former_atom ~latter:latter_atom)
           latter_atoms)
  in
  List.filter survives former_tokens @ latter_tokens |> String.concat " "
