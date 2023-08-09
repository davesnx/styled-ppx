include Css_native.Css_Colors
include Css_native.Css_Js_Core

(* rules_to_string render the rule in a format where the hash matches with `@emotion/serialiseStyles`
   It doesn't render any whitespace.

   TODO: Ensure PseudoclassParam is rendered correctly.
*)
let rec rules_to_string rules =
  let buff = Buffer.create 16 in
  let push = Buffer.add_string buff in
  let rule_to_string rule =
    match rule with
    | Rule.Declaration (property, value) ->
      push (Printf.sprintf "%s:%s;" property value)
    | Selector (selector, rules) ->
      push (Printf.sprintf "%s{%s}" selector (rules_to_string rules))
    | Pseudoclass (pseudoclass, rules) ->
      push (Printf.sprintf ":%s{%s}" pseudoclass (rules_to_string rules))
    | PseudoclassParam (pseudoclass, param, rules) ->
      push
        (Printf.sprintf ":%s (%s) {%s}" pseudoclass param
           (rules_to_string rules))
  in

  rules |> List.iter rule_to_string;

  Buffer.contents buff

let render_declaration rule =
  match rule with
  | Rule.Declaration (property, value) ->
    Some (Printf.sprintf "%s: %s;" property value)
  | _ -> None

let render_declarations rules =
  rules
  |> List.map Autoprefixer.prefix
  |> List.flatten
  |> List.filter_map render_declaration
  |> String.concat " "

let is_at_rule selector = String.contains selector '@'

let prefix ~pre s =
  let len = String.length pre in
  if len > String.length s then false
  else (
    let rec check i =
      if i = len then true
      else if Stdlib.( <> ) (String.unsafe_get s i) (String.unsafe_get pre i)
      then false
      else check (i + 1)
    in
    check 0)

let chop_prefix ~pre s =
  if prefix ~pre s then
    Some
      (String.sub s (String.length pre) (String.length s - String.length pre))
  else None

let remove_first_ampersand selector =
  selector |> chop_prefix ~pre:"&" |> Option.value ~default:selector

let replace_ampersand str with_ =
  let rec replace_ampersand' str var =
    let len = String.length str in
    if len = 0 then ""
    else if str.[0] = '&' then
      var ^ replace_ampersand' (String.sub str 1 (len - 1)) var
    else
      String.sub str 0 1 ^ replace_ampersand' (String.sub str 1 (len - 1)) var
  in
  replace_ampersand' str with_

let resolve_ampersand hash selector = replace_ampersand selector ("." ^ hash)

let render_prelude hash selector =
  let new_selector =
    selector |> remove_first_ampersand |> resolve_ampersand hash
  in
  Printf.sprintf ".%s %s" hash new_selector

let render_selectors hash rule =
  match rule with
  | Rule.Selector (selector, rules) when is_at_rule selector ->
    Some
      (Printf.sprintf "%s { .%s { %s } }" selector hash
         (render_declarations rules))
  | Selector (selector, rules) ->
    let prelude = render_prelude hash selector in
    Some (Printf.sprintf "%s { %s }" prelude (render_declarations rules))
  | Pseudoclass (pseduoclass, rules) ->
    Some
      (Printf.sprintf ".%s:%s { %s }" hash pseduoclass
         (render_declarations rules))
  | PseudoclassParam (pseudoclass, param, rules) ->
    Some
      (Printf.sprintf ".%s:%s ( %s ) %s" hash pseudoclass param
         (render_declarations rules))
  | _ -> None

let rec rule_to_debug nesting accumulator rule =
  let next_rule =
    match rule with
    | Rule.Declaration (property, value) ->
      Printf.sprintf "Declaration (\"%s\", \"%s\")" property value
    | Selector (selector, rules) ->
      Printf.sprintf "Selector (\"%s\", %s)" selector
        (to_debug (nesting + 1) rules)
    | Pseudoclass (pseduoclass, rules) ->
      Printf.sprintf "Pseudoclass (\"%s\", %s)" pseduoclass
        (to_debug (nesting + 1) rules)
    | PseudoclassParam (pseudoclass, param, rules) ->
      Printf.sprintf "PseudoclassParam (\"%s\", \"%s\", %s)" pseudoclass param
        (to_debug (nesting + 1) rules)
  in
  let space = if nesting > 0 then String.make (nesting * 2) ' ' else "" in
  accumulator ^ Printf.sprintf "\n%s" space ^ next_rule

and to_debug nesting rules = rules |> List.fold_left (rule_to_debug nesting) ""

let print_rules rules =
  rules |> List.iter (fun rule -> print_endline (to_debug 0 [ rule ]))

let resolve_selectors rules =
  let rec unnest ~prefix =
    List.partition_map (function
      | Rule.Selector (title, selector_rules) ->
        let new_prelude = prefix ^ title in
        let content, tail = unnest ~prefix:(new_prelude ^ " ") selector_rules in
        Right (Rule.Selector (new_prelude, content) :: List.flatten tail)
      | _ as rule -> Left rule)
  in
  let resolve_selector rule =
    let declarations, selectors = unnest ~prefix:"" [ rule ] in
    List.flatten (declarations :: selectors)
  in
  rules |> List.map resolve_selector |> List.flatten

(* `resolved_rule` here means to print valid CSS, selectors are nested
   and properties aren't autoprefixed. This function transforms into correct CSS. *)
let resolved_rule_to_css hash rules =
  (* TODO: Refactor with partition or partition_map. List.filter_map is error prone.
     Selectors might need to respect the order of definition, and this breaks the order *)
  let list_of_rules = rules |> resolve_selectors in
  let declarations =
    list_of_rules
    |> List.map Autoprefixer.prefix
    |> List.flatten
    |> List.filter_map render_declaration
    |> String.concat " "
    |> fun all -> Printf.sprintf ".%s { %s }" hash all
  in
  let selectors =
    list_of_rules
    |> List.filter_map (render_selectors hash)
    |> String.concat " "
  in
  Printf.sprintf "%s %s" declarations selectors

let cache = ref (Hashtbl.create 1000)
let get hash = Hashtbl.mem cache.contents hash
let flush () = Hashtbl.clear cache.contents

let append hash (styles : Rule.t list) =
  if get hash then () else Hashtbl.add cache.contents hash styles

let style (styles : Rule.t list) =
  let hash = Hash.default (rules_to_string styles) |> String.cat "css-" in
  append hash styles;
  hash

let style_debug (styles : Rule.t list) =
  print_endline (rules_to_string styles);
  let hash = Hash.default (rules_to_string styles) |> String.cat "css-" in
  append hash styles;
  hash

let style_with_hash ~hash (styles : Rule.t list) =
  let hash = hash (rules_to_string styles) |> String.cat "css-" in
  append hash styles;
  hash

let render_style_tag () =
  Hashtbl.fold
    (fun hash rules accumulator ->
      let rules = rules |> resolved_rule_to_css hash |> String.trim in
      Printf.sprintf "%s %s" accumulator rules)
    cache.contents ""
