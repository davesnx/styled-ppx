(* The merge algorithm as it was before [Merge_key] compared fields in place,
   kept unchanged as the oracle for test_merge_key_differential.ml. Do not
   optimise it. *)

(* The pre-rewrite [Merge_key]: string fields and a family tree, no in-place
   offsets. See [packages/runtime/native/shared/Merge_key.ml] for what the
   module does and why. *)

let atom_prefix = "_a_"
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

(* One [_a_] atom's merge-relevant fields, sliced out of its class name.
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
  level : int; (* 0 for [_a_]; k for the specificity twin [_t<k>_] *)
  token : string; (* the whole class name, to hand back untouched *)
  slot : int;
    (* [family] as an int: atoms of one family share it, so it keys the
       lookup that keeps merging from comparing every pair. Equal slots do
       not prove equal families; [family_equal] still decides. *)
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

(* [None] for anything that isn't a well-formed [_a_] atom: not [_a_]
   -prefixed, or [_a_]-prefixed but not one of the six lengths
   [Class_format.possible_extra_lengths] makes possible (a stray class
   this pipeline never minted). Either way, the caller treats it as
   opaque and passes it through untouched, same as an [_id_]/
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

(* The specificity twin: [_t<k>_<body>] is [_a_<body>] with [k] extra
   copies of its class in the selector (see packages/generate). *)
(* Above this level an atom stays at [max_level] and the sheet order decides
   the tie, as before the twin. [packages/generate] emits the same number of
   twin selectors. *)
let max_level = 2
let twin_prefix level = "_t" ^ string_of_int level ^ "_"

let split_prefix class_name =
  let n = String.length class_name in
  if n >= 3 && String.equal (String.sub class_name 0 3) atom_prefix then
    Some (0, 3)
  else if
    n >= 4
    && class_name.[0] = '_'
    && class_name.[1] = 't'
    && class_name.[2] >= '1'
    && class_name.[2] <= Char.chr (Char.code '0' + max_level)
    && class_name.[3] = '_'
  then Some (Char.code class_name.[2] - Char.code '0', 4)
  else None

let parse_atom class_name =
  match split_prefix class_name with
  | None -> None
  | Some (level, start) ->
    let floor = family_width + value_width in
    (match fields_of_extra (String.length class_name - start - floor) with
    | None -> None
    | Some (has_context, has_mask, has_extended) ->
      let pos = ref start in
      let take width =
        let s = String.sub class_name !pos width in
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
      Some
        {
          context;
          family;
          extended;
          mask;
          level;
          token = class_name;
          slot = base36_value family;
        })

let context_equal a b = String.equal a.context b.context

(* The base context is the one [Class_format] leaves out of the class name. *)
let is_base a = String.equal a.context ""

(* [Class_format.at_rules_marker]: the first character of a context made of
   at-rules alone (no selector, not [!important]). *)
let is_at_rules_only a = a.context <> "" && a.context.[0] = '0'

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
  if String.equal latter.family all_sentinel then
    not (is_excluded_from_all former.family)
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
  if String.equal latter.family all_sentinel then
    not (is_excluded_from_all former.family)
  else if String.equal former.family all_sentinel then
    not (is_excluded_from_all latter.family)
  else
    family_equal former latter
    &&
    match former.mask, latter.mask with
    | None, _ | _, None -> true
    | Some ma, Some mb -> ma land mb <> 0

(* Does the sheet surely put [latter] after [former]? Base rules come before
   at-rule rules; inside one context a shorthand (full mask) comes before a
   longhand ([generate]'s sort_by_shorthand_first). Anything else (two
   different at-rule contexts, partial masks) depends on a hash or on the
   sheet position, so is not sure. *)
let surely_after ~former ~latter =
  if is_base former && is_at_rules_only latter then true
  else if context_equal former latter then
    former.mask = None && latter.mask <> None
  else false

(* Atoms by family, so an atom is compared only with those that can matter:
   the same family, or the [all] sentinel (which overlaps and removes
   every family but a few). Most merges then compare almost nothing. *)
type slots =
  | Leaf
  | Node of slots * int * atom list * slots

(* A plain binary tree rather than [Map.Make]: the functor alone adds tens of
   kilobytes to the browser bundle. Slots are base36 numbers, so an unbalanced
   tree stays shallow. *)
let rec slots_find slot = function
  | Leaf -> []
  | Node (l, k, atoms, r) ->
    if slot = k then atoms
    else if slot < k then slots_find slot l
    else slots_find slot r

let rec slots_add a = function
  | Leaf -> Node (Leaf, a.slot, [ a ], Leaf)
  | Node (l, k, atoms, r) ->
    if a.slot = k then Node (l, k, a :: atoms, r)
    else if a.slot < k then Node (slots_add a l, k, atoms, r)
    else Node (l, k, atoms, slots_add a r)

type index = {
  by_slot : slots;
  alls : atom list; (* the [all]-family atoms *)
  everything : atom list;
}

type token =
  | Atom of atom
  | Opaque of string

let empty_index = { by_slot = Leaf; alls = []; everything = [] }

let add_atom index a =
  {
    by_slot = slots_add a index.by_slot;
    alls =
      (if String.equal a.family all_sentinel then a :: index.alls
       else index.alls);
    everything = a :: index.everything;
  }

(* Folds over a superset of the atoms of [index] that can overlap or remove
   with [a]: the exact checks stay in the callers. *)
let fold_candidates index a f init =
  if String.equal a.family all_sentinel then
    List.fold_left f init index.everything
  else
    List.fold_left f
      (List.fold_left f init (slots_find a.slot index.by_slot))
      index.alls

(* The level [latter] needs to beat the surviving [formers] by source order:
   one above every former of the same kind (plain or not) that it overlaps
   and does not remove, or the former's own level when the sheet order
   surely puts [latter] after it. Two atoms of different selectors but equal
   specificity (":hover", ":disabled", "& .a", "& .b") are such a tie. Whether
   they style one element is unknown at runtime; a needless raise is harmless
   because a twin never beats a rule with one more class-like part. *)
let twin_level seen latter =
  let conflicts former =
    is_plain former = is_plain latter
    && overlaps ~former ~latter
    && not (removes ~former ~latter)
  in
  let needed former =
    former.level + if surely_after ~former ~latter then 0 else 1
  in
  fold_candidates seen latter
    (fun level former ->
      if conflicts former then max level (needed former) else level)
    latter.level
  |> min max_level

let token_of a level =
  let start = if a.level = 0 then 3 else 4 in
  (if level = 0 then atom_prefix else twin_prefix level)
  ^ String.sub a.token start (String.length a.token - start)

(* [raise_levels seen latters]: [latters] as tokens, each with the twin
   level it needs against the [seen] atoms (the former survivors, already
   filtered for removal; a twin never needs an earlier atom raised) and
   against the latters before it, at the level they were just given. A latter
   raised by a former would otherwise lose to an earlier latter it sits after
   in the sheet. *)
let raise_levels seen latters =
  let _, tokens =
    List.fold_left
      (fun (seen, tokens) parsed ->
        match parsed with
        | Opaque token -> seen, token :: tokens
        | Atom a ->
          let level = twin_level seen a in
          ( add_atom seen { a with level },
            (if level = a.level then a.token else token_of a level) :: tokens ))
      (seen, []) latters
  in
  List.rev tokens

let parse_token token =
  match parse_atom token with None -> Opaque token | Some a -> Atom a

let index_of parsed =
  List.fold_left
    (fun index -> function Opaque _ -> index | Atom a -> add_atom index a)
    empty_index parsed

(* A block's classes in source order: each atom against the ones before it. *)
let twin_block tokens = raise_levels empty_index (List.map parse_token tokens)

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
   token is a parseable [_a_] atom that some [latter] atom [removes]. Every
   other token - [_id_] identities, `label:<binding>` markers, and any class
   this module fails to parse - is kept unconditionally, on both sides, in
   its original relative order (identities are never dropped and never drop
   anything; an unparseable class is not this module's concern to police).
   [latter]'s tokens are never dropped - [CSS.merge]'s right argument always
   wins outright. *)
let merge_class_names former latter =
  let former_tokens = List.map parse_token (split_tokens former) in
  let latter_tokens = List.map parse_token (split_tokens latter) in
  let latter_index = index_of latter_tokens in
  let survives = function
    | Opaque _ -> true
    | Atom former_atom ->
      not
        (fold_candidates latter_index former_atom
           (fun found latter_atom ->
             found || removes ~former:former_atom ~latter:latter_atom)
           false)
  in
  let survivors = List.filter survives former_tokens in
  let token_string = function Opaque t -> t | Atom a -> a.token in
  List.map token_string survivors
  @ raise_levels (index_of survivors) latter_tokens
  |> String.concat " "
