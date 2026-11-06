module Format_ = Property_class_core.Css_class_format
module Cover = Property_class_core.Css_cover
module Strings = Set.Make (String)

type context = Context_key.context = {
  scope : string;
  conditions : string list;
  important : bool;
}

type decl = {
  context : context;
  prop : string;
  text : string;
}

type unit_ = {
  pieces : decl list;
  bundle : bool;
  tier : int;
  conds : int;
  cover : int;
}

type property =
  | Known of string
  | Unknown of string

let property name =
  let name =
    if String.length name >= 2 && String.sub name 0 2 = "--" then name
    else String.lowercase_ascii name
  in
  match Cover.id_of_name name with Some id -> Known id | None -> Unknown name

let leaves name =
  match property name with
  | Known id ->
    List.map
      (function Format_.Id leaf | Format_.Name leaf -> "#" ^ leaf)
      (Cover.leaves (Format_.Id id))
  | Unknown name -> [ "." ^ name ]

let last_combinator selector =
  let depth = ref 0 in
  let last = ref (-1) in
  String.iteri
    (fun i ch ->
      if ch = '(' || ch = '[' then incr depth
      else if ch = ')' || ch = ']' then decr depth
      else if !depth = 0 && (ch = ' ' || ch = '>' || ch = '+' || ch = '~') then
        last := i)
    selector;
  !last

let tier context =
  let cut = last_combinator context.scope in
  if cut >= 0 && String.contains (String.sub context.scope 0 cut) '&' then 0
  else if context.scope = "&" && context.conditions = [] then 1
  else 2

let condition_count context =
  List.length context.conditions + if context.scope = "&" then 0 else 1

let is_pseudo_char c = (c >= 'a' && c <= 'z') || c = '-'

let pseudo_element scope =
  let len = String.length scope in
  let rec find i =
    if i + 2 >= len then None
    else if
      scope.[i] = ':' && scope.[i + 1] = ':' && is_pseudo_char scope.[i + 2]
    then (
      let rec stop j =
        if j < len && is_pseudo_char scope.[j] then stop (j + 1) else j
      in
      Some (String.sub scope i (stop (i + 2) - i)))
    else find (i + 1)
  in
  find 0

let subject context =
  if tier context = 0 then "descendant"
  else Option.value (pseudo_element context.scope) ~default:"own"

type entry = {
  decl : decl;
  key : string;
  leaves : Strings.t;
  rank : int * int;
}

let entry decl =
  {
    decl;
    key = Context_key.key decl.context;
    leaves = Strings.of_list (leaves decl.prop);
    rank = tier decl.context, condition_count decl.context;
  }

let before (a1, b1) (a2, b2) = a1 < a2 || (a1 = a2 && b1 < b2)
let cell_name e leaf = e.key ^ "#" ^ leaf

let cells_of es =
  List.fold_left
    (fun acc e -> Strings.union acc (Strings.map (cell_name e) e.leaves))
    Strings.empty es

let is_bundle es =
  match es with
  | [] -> false
  | first :: rest ->
    List.exists
      (fun e -> e.key <> first.key || e.decl.prop <> first.decl.prop)
      rest

let group entries =
  let n = Array.length entries in
  let parent = Array.init n (fun i -> i) in
  let rec find i =
    if parent.(i) = i then i
    else (
      let root = find parent.(i) in
      parent.(i) <- root;
      root)
  in
  let join i j =
    let a = find i
    and b = find j in
    if a = b then false
    else (
      parent.(max a b) <- min a b;
      true)
  in
  for i = 0 to n - 1 do
    for j = i + 1 to n - 1 do
      if
        entries.(i).key = entries.(j).key
        && entries.(i).decl.prop = entries.(j).decl.prop
      then ignore (join i j)
    done
  done;
  let members root =
    List.filter (fun k -> find k = root) (List.init n (fun k -> k))
  in
  let es root = List.map (fun k -> entries.(k)) (members root) in
  let unit_rank root =
    List.fold_left
      (fun (t, c) e -> max t (fst e.rank), max c (snd e.rank))
      (0, 0) (es root)
  in
  let joinable i j =
    let d = entries.(i)
    and e = entries.(j) in
    let ri = find i
    and rj = find j in
    if ri = rj || subject d.decl.context <> subject e.decl.context then false
    else if d.decl.context.important <> e.decl.context.important then false
    else if Strings.disjoint d.leaves e.leaves then false
    else (
      let nested =
        Strings.subset d.leaves e.leaves || Strings.subset e.leaves d.leaves
      in
      let bi = is_bundle (es ri)
      and bj = is_bundle (es rj) in
      if d.key = e.key && nested && (not bi) && not bj then false
      else if d.key <> e.key && (not bi) && (not bj) && before d.rank e.rank
      then false
      else if (bi || bj) && before (unit_rank ri) (unit_rank rj) then false
      else true)
  in
  let changed = ref true in
  while !changed do
    changed := false;
    for i = 0 to n - 1 do
      for j = i + 1 to n - 1 do
        if joinable i j then (
          let joined = join i j in
          changed := joined || !changed)
      done
    done
  done;
  let roots = List.filter (fun k -> find k = k) (List.init n (fun k -> k)) in
  let groups = List.map members roots in
  let last ks = List.fold_left max (-1) ks in
  List.sort (fun a b -> compare (last a) (last b)) groups
  |> List.map (List.map (fun k -> entries.(k)))

let to_unit es =
  {
    pieces = List.map (fun e -> e.decl) es;
    bundle = is_bundle es;
    tier = List.fold_left (fun m e -> max m (fst e.rank)) 0 es;
    conds = List.fold_left (fun m e -> max m (snd e.rank)) 0 es;
    cover = Strings.cardinal (cells_of es);
  }

let units decls =
  let entries = Array.of_list (List.map entry decls) in
  let groups = group entries in
  let rec drop later = function
    | [] -> []
    | es :: earlier ->
      let cells = cells_of es in
      let dead = Strings.subset cells later in
      let kept = drop (Strings.union later cells) earlier in
      if dead then kept else es :: kept
  in
  List.map to_unit (List.rev (drop Strings.empty (List.rev groups)))
