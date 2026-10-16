(* Merge_key
   =========

   [CSS.merge]'s removal rule, applied entirely at runtime by parsing the
   fixed-width fields [Class_format] already encoded into an atom's class
   name (context/family/extended/mask/value) - no shorthand table, no CSS
   property knowledge. Every field is compared as an opaque string (context,
   family, extended) or an opaque bounded int (mask, via a bitwise subset
   check); this module never needs to know WHAT a field means, only how
   wide it is and how two atoms' fields compare.

   The twin ([_t<k>_] classes, see [twin_level]) is the other half: where
   removal is not possible, the later atom's class is swapped for a twin that
   [packages/generate] gives a higher specificity.

   This is the single rule [Slot_key.removes] defines, minus the [bundle]
   short-circuit (an [_in_] token never reaches {!parse_atom}'s callers in
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
  body : string; (* the class name without its prefix *)
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
   opaque and passes it through untouched, same as an [_in_]/[_id_]/
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
let twin_prefix level = Printf.sprintf "_t%d_" level

let split_prefix class_name =
  let n = String.length class_name in
  if n >= 3 && String.equal (String.sub class_name 0 3) atom_prefix then
    Some (0, String.sub class_name 3 (n - 3))
  else if
    n >= 4
    && class_name.[0] = '_'
    && class_name.[1] = 't'
    && class_name.[2] >= '1'
    && class_name.[2] <= Char.chr (Char.code '0' + max_level)
    && class_name.[3] = '_'
  then
    Some
      (Char.code class_name.[2] - Char.code '0', String.sub class_name 4 (n - 4))
  else None

let parse_atom class_name =
  match split_prefix class_name with
  | None -> None
  | Some (level, body) ->
    let floor = family_width + value_width in
    (match fields_of_extra (String.length body - floor) with
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
      Some { context; family; extended; mask; level; body })

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

(* [removes ~former ~latter]: mirrors [Slot_key.removes] exactly (minus
   the bundle check, already handled by the caller) - same context, or a
   [latter] in the base context over a [former] whose context is at-rules
   alone (it overrides [former]'s [@media]/[@container] values on the same
   element; selector and [!important] contexts stay, a conditional [latter]
   never removes a base [former]), then
   either [latter]'s family is the [all] sentinel (former removed unless
   excluded), or the same family and [former]'s mask a subset of
   [latter]'s. *)
let removes ~former ~latter =
  (context_equal former latter || (is_base latter && is_at_rules_only former))
  &&
  if String.equal latter.family all_sentinel then
    not (is_excluded_from_all former.family)
  else family_equal former latter && mask_subset former.mask latter.mask

(* -- specificity twin ------------------------------------------------- *)

(* Only atoms in the base context or under at-rules alone take part: both
   have natural specificity (0,1,0), so source order alone decides between
   them. Selector and [!important] contexts keep their own, higher
   specificity and are left alone. *)
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

(* The level [latter] needs to beat the surviving [formers] by source order.
   A plain [latter] must clear every plain, overlapping former. A [latter]
   with a selector context (":hover", "& .child", "!important") already has
   higher natural specificity; it only has to keep it over a twin: it takes
   the level of the highest overlapping plain former. *)
let twin_level formers latter =
  let conflicts former =
    is_plain former && overlaps ~former ~latter && not (removes ~former ~latter)
  in
  let needed former =
    if is_plain latter then
      former.level + if surely_after ~former ~latter then 0 else 1
    else former.level
  in
  List.fold_left
    (fun level former ->
      if conflicts former then max level (needed former) else level)
    latter.level formers
  |> min max_level

let token_of a level =
  (if level = 0 then atom_prefix else twin_prefix level) ^ a.body

(* A [former] with a selector context must also keep its natural specificity
   over a [latter] twin that overlaps it. *)
let twin_former latters former =
  if is_plain former then former.level
  else
    List.fold_left
      (fun level latter ->
        if is_plain latter && overlaps ~former ~latter then
          max level latter.level
        else level)
      former.level latters

(* [raise_levels formers latters]: the [formers] (already filtered for
   removal) and [latters] as tokens, each with the twin level it needs. *)
let raise_levels formers latters =
  let former_atoms = List.filter_map parse_atom formers in
  let relevel token a level =
    if level = a.level then token else token_of a level
  in
  let latters' =
    List.map
      (fun token ->
        match parse_atom token with
        | None -> token
        | Some a -> relevel token a (twin_level former_atoms a))
      latters
  in
  let latter_atoms = List.filter_map parse_atom latters' in
  let formers' =
    List.map
      (fun token ->
        match parse_atom token with
        | None -> token
        | Some a -> relevel token a (min max_level (twin_former latter_atoms a)))
      formers
  in
  formers', latters'

(* A block's classes in source order: each atom against the ones before it. *)
let twin_block tokens =
  List.fold_left
    (fun acc token ->
      let formers, latters = raise_levels acc [ token ] in
      formers @ latters)
    [] tokens

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
   other token - [_in_] bundles, [_id_] identities, `label:<binding>`
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
  let survivors = List.filter survives former_tokens in
  let survivors, latter_tokens = raise_levels survivors latter_tokens in
  survivors @ latter_tokens |> String.concat " "
