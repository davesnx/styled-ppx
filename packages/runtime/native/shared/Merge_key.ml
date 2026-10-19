(* Merge_key
   =========

   [CSS.merge]'s removal rule, applied entirely at runtime by parsing the
   fixed-width fields [Class_format] already encoded into an atom's class
   name (context/family/extended/mask/value) - no shorthand table, no CSS
   property knowledge. It mirrors [Slot_key.removes]. This module never
   needs to know WHAT a field means, only how wide it is and how two atoms'
   fields compare: context and extended are compared in place, by offset
   into the class name, the family is packed into an int, and only the mask
   is decoded (a bitwise subset check). No substring is built per field
   because merging runs on every [CSS.merge] call.

   The twin ([_t<k>_] classes, see [twin_block] and [raise_levels]) is the
   other half: where removal is not possible, the later atom's class is
   swapped for a twin that [packages/generate] gives a higher specificity.

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

let atom_prefix = "_a_"
let context_width = 5
let family_width = 2
let mask_width = 4
let value_width = 4
let extended_width = 6

(* [Slot_key.Registry]'s two reserved family markers ([all] and unregistered
   custom properties) and the two fixed registered indices
   [Slot_key.is_excluded_from_all] special-cases, base36-encoded at
   [family_width] the same way [Class_format.slot_class] encodes every family
   field. These four 2-character strings are the
   ONLY property-specific knowledge this module carries, and only for the
   [all: unset] case - everything else compares fields as opaque data. *)
let all_sentinel = "zz"
let unregistered_custom_marker = "zy"
let direction_marker = "5q"
let unicode_bidi_marker = "dp"

(* A family is the pair of its two characters packed into one int. Equal
   ints are equal strings for any characters, not only base36 ones, so the
   comparisons below match comparing the strings. *)
let family_code c0 c1 = (Char.code c0 lsl 16) lor Char.code c1
let all_family = family_code all_sentinel.[0] all_sentinel.[1]

let unregistered_custom_family =
  family_code unregistered_custom_marker.[0] unregistered_custom_marker.[1]

let direction_family = family_code direction_marker.[0] direction_marker.[1]

let unicode_bidi_family =
  family_code unicode_bidi_marker.[0] unicode_bidi_marker.[1]

let is_excluded_from_all family =
  family = unregistered_custom_family
  || family = direction_family
  || family = unicode_bidi_family

(* One [_a_] atom's merge-relevant fields, as offsets into its class name
   (see the header for why nothing is sliced out). *)
type atom = {
  token : string; (* the whole class name, to hand back untouched *)
  level : int; (* 0 for [_a_]; k for the specificity twin [_t<k>_] *)
  context : int; (* offset of the context field, [-1] for the base context *)
  family : int;
  extended : int; (* offset of the extended field, [-1] when absent *)
  mask : int;
    (* [-1] means "full" (a plain shorthand, or any non-family property) -
       see [Slot_key.t.mask]. *)
}

let base36_digit c =
  match c with
  | '0' .. '9' -> Char.code c - Char.code '0'
  | 'a' .. 'z' -> Char.code c - Char.code 'a' + 10
  | _ -> 0 (* unreachable for a real [Class_format] field *)

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

(* The specificity twin: [_t<k>_<body>] is [_a_<body>] with [k] times
   [:not(x-)] after its class in the selector (see packages/generate). Past
   [max_level] an atom stays there and the sheet order decides the tie.
   [packages/generate] emits the same number of twin selectors. *)
let max_level = 2
let twin_prefix level = "_t" ^ string_of_int level ^ "_"

(* The twin level and the prefix width of [class_name], or [None] when it
   starts with neither prefix. The [_a_] test is written out character by
   character so no [String.sub] runs per token. *)
let split_prefix class_name =
  let n = String.length class_name in
  if
    n >= 3
    && class_name.[0] = '_'
    && class_name.[1] = 'a'
    && class_name.[2] = '_'
  then Some (0, 3)
  else if
    n >= 4
    && class_name.[0] = '_'
    && class_name.[1] = 't'
    && class_name.[2] >= '1'
    && class_name.[2] <= Char.chr (Char.code '0' + max_level)
    && class_name.[3] = '_'
  then Some (Char.code class_name.[2] - Char.code '0', 4)
  else None

(* [None] for anything that isn't a well-formed [_a_] atom: not [_a_]
   -prefixed, or [_a_]-prefixed but not one of the six lengths
   [Class_format.possible_extra_lengths] makes possible (a stray class
   this pipeline never minted). Either way, the caller treats it as
   opaque and passes it through untouched, same as an [_id_]/
   [label:...] token. *)
let parse_atom token =
  match split_prefix token with
  | None -> None
  | Some (level, start) ->
    let floor = family_width + value_width in
    (match fields_of_extra (String.length token - start - floor) with
    | None -> None
    | Some (has_context, has_mask, has_extended) ->
      let context = if has_context then start else -1 in
      let pos = if has_context then start + context_width else start in
      let family = family_code token.[pos] token.[pos + 1] in
      let pos = pos + family_width in
      let extended = if has_extended then pos else -1 in
      let pos = if has_extended then pos + extended_width else pos in
      let mask =
        if has_mask then (
          let mask = ref 0 in
          for i = 0 to mask_width - 1 do
            mask := (!mask * 36) + base36_digit token.[pos + i]
          done;
          !mask)
        else -1
      in
      Some { token; level; context; family; extended; mask })

let same_field a offset_a b offset_b width =
  let rec go i =
    i >= width || (a.[offset_a + i] = b.[offset_b + i] && go (i + 1))
  in
  go 0

let context_equal a b =
  if a.context < 0 then b.context < 0
  else
    b.context >= 0
    && same_field a.token a.context b.token b.context context_width

(* The base context is the one [Class_format] leaves out of the class name. *)
let is_base a = a.context < 0

(* [Class_format.at_rules_marker]: the first character of a context made of
   at-rules alone (no selector, not [!important]). *)
let is_at_rules_only a = a.context >= 0 && a.token.[a.context] = '0'

let family_equal a b =
  a.family = b.family
  &&
  if a.extended < 0 then b.extended < 0
  else
    b.extended >= 0
    && same_field a.token a.extended b.token b.extended extended_width

let mask_subset a b = if a < 0 then b < 0 else b < 0 || a land b = a

(* [removes ~former ~latter]: mirrors [Slot_key.removes] exactly - same
   context, or a [latter] in the base context over a [former] whose context is
   at-rules alone (it overrides [former]'s [@media]/[@container] values on the
   same element; selector and [!important] contexts stay, a conditional
   [latter] never removes a base [former]), then either [latter]'s family is
   the [all] sentinel (former removed unless excluded), or the same family and
   [former]'s mask a subset of [latter]'s. *)
let removes ~former ~latter =
  (context_equal former latter || (is_base latter && is_at_rules_only former))
  &&
  if latter.family = all_family then not (is_excluded_from_all former.family)
  else family_equal former latter && mask_subset former.mask latter.mask

(* -- specificity twin ------------------------------------------------- *)

(* A twin only breaks a tie, so only atoms of the same kind are compared. Base
   and at-rules-only atoms have natural specificity (0,1,0); an atom with a
   selector or [!important] has more class-like parts (or more weight), so
   against a plain atom it wins or loses on its own, whatever the source order.
   A twin adds a type selector only, so it never lifts an atom over that
   difference. *)
let is_plain a = is_base a || is_at_rules_only a

(* Could [former] and [latter] set a common property? *)
let overlaps ~former ~latter =
  if latter.family = all_family then not (is_excluded_from_all former.family)
  else if former.family = all_family then
    not (is_excluded_from_all latter.family)
  else
    family_equal former latter
    && (former.mask < 0 || latter.mask < 0 || former.mask land latter.mask <> 0)

(* Does the sheet surely put [latter] after [former]? Base rules come before
   at-rule rules; inside one context a shorthand (full mask) comes before a
   longhand ([generate]'s sort_by_shorthand_first). Anything else (two
   different at-rule contexts, partial masks) depends on a hash or on the
   sheet position, so is not sure. *)
let surely_after ~former ~latter =
  if is_base former && is_at_rules_only latter then true
  else if context_equal former latter then former.mask < 0 && latter.mask >= 0
  else false

(* Atoms of one family, or the [all] sentinel on either side, are the only
   ones that can overlap or remove each other. Sets are small, so a scan
   with this cheap check beats an index by family. *)
let may_interact a b =
  a.family = b.family || a.family = all_family || b.family = all_family

(* The atoms seen so far, in a fixed-size array filled up to [count]. *)
type seen = {
  atoms : atom array;
  mutable count : int;
}

let placeholder =
  { token = ""; level = 0; context = -1; family = -1; extended = -1; mask = -1 }

let make_seen capacity = { atoms = Array.make capacity placeholder; count = 0 }

let add seen a =
  seen.atoms.(seen.count) <- a;
  seen.count <- seen.count + 1

(* The level [latter] needs to beat the surviving [formers] by source order:
   one above every former of the same kind (plain or not) that it overlaps
   and does not remove, or the former's own level when the sheet order
   surely puts [latter] after it. Two atoms of different selectors but equal
   specificity (":hover", ":disabled", "& .a", "& .b") are such a tie. Whether
   they style one element is unknown at runtime; a needless raise is harmless
   because a twin never beats a rule with one more class-like part. *)
let twin_level seen latter =
  let level = ref latter.level in
  for i = 0 to seen.count - 1 do
    let former = seen.atoms.(i) in
    if
      may_interact former latter
      && is_plain former = is_plain latter
      && overlaps ~former ~latter
      && not (removes ~former ~latter)
    then (
      let needed =
        former.level + if surely_after ~former ~latter then 0 else 1
      in
      if needed > !level then level := needed)
  done;
  min !level max_level

let token_of a level =
  let start = if a.level = 0 then 3 else 4 in
  (if level = 0 then atom_prefix else twin_prefix level)
  ^ Str_sub.sub a.token start (String.length a.token - start)

type token =
  | Atom of atom
  | Opaque of string

let token_string = function Opaque t -> t | Atom a -> a.token

let parse_token token =
  match parse_atom token with None -> Opaque token | Some a -> Atom a

(* [raise_levels seen latters]: [latters] as tokens, each with the twin
   level it needs against the [seen] atoms (the former survivors, already
   filtered for removal; a twin never needs an earlier atom raised) and
   against the latters before it, at the level they were just given. A latter
   raised by a former would otherwise lose to an earlier latter it sits after
   in the sheet. [seen] must have room for every atom of [latters]. *)
let raise_levels seen latters =
  List.fold_left
    (fun tokens -> function
      | Opaque token -> token :: tokens
      | Atom a ->
        let level = twin_level seen a in
        add seen { a with level };
        (if level = a.level then a.token else token_of a level) :: tokens)
    [] latters
  |> List.rev

let atom_count tokens =
  List.fold_left (fun n -> function Atom _ -> n + 1 | Opaque _ -> n) 0 tokens

(* A block's classes in source order: each atom against the ones before it. *)
let twin_block tokens =
  let parsed = List.map parse_token tokens in
  raise_levels (make_seen (atom_count parsed)) parsed

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
      loop !j (Str_sub.sub s i (!j - i) :: acc))
  in
  loop 0 []

(* [merge_class_names former latter]: [former]'s tokens survive unless a
   token is a parseable [_a_] atom that some [latter] atom [removes]. Every
   other token - [_id_] identities, `label:<binding>` markers, and any class
   this module fails to parse - is kept unconditionally, on both sides, in
   its original relative order (identities are never dropped and never drop
   anything; an unparseable class is not this module's concern to police).
   [latter]'s tokens are never dropped and keep their place, but an atom may
   come back with a twin prefix (see [raise_levels]). *)
let merge_class_names former latter =
  let former_tokens = List.map parse_token (split_tokens former) in
  let latter_tokens = List.map parse_token (split_tokens latter) in
  let latter_atoms =
    Array.of_list
      (List.filter_map
         (function Atom a -> Some a | Opaque _ -> None)
         latter_tokens)
  in
  let survives = function
    | Opaque _ -> true
    | Atom former_atom ->
      not
        (Array.exists
           (fun latter_atom ->
             may_interact former_atom latter_atom
             && removes ~former:former_atom ~latter:latter_atom)
           latter_atoms)
  in
  let survivors = List.filter survives former_tokens in
  let seen = make_seen (atom_count survivors + Array.length latter_atoms) in
  List.iter (function Atom a -> add seen a | Opaque _ -> ()) survivors;
  List.map token_string survivors @ raise_levels seen latter_tokens
  |> String.concat " "
