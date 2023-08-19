include Css_native.Css_Colors
include Css_native.Css_Js_Core
module Core = Css_native.Css_Js_Core

module Array = struct
  include Stdlib.Array

  let filter_map arr fn = Belt.Array.keepMap fn arr
  let iter arr fn = Belt.Array.forEach fn arr
  let flatten arr = arr |> Array.to_list |> List.flatten |> Array.of_list
  let cons arr item = Belt.Array.push item arr

  let partition_map (fn: 'a -> ('b, 'c) Either.t) (arr: 'a array): ('b array * 'c array) =
    let list = Array.to_list arr in
    let (left, right) = List.partition_map fn list in
    (Array.of_list (left), Array.of_list (right))
end

module Autoprefixer = struct
  (* Implementation of stylis autoprefixer https://github.com/thysultan/stylis *)
  (* This autoprefix works with ">1%, last 4 versions, Firefox ESR, not ie < 9, not dead" from browserlist and not so precise as stylis implementation *)

  let webkit property = Printf.sprintf "-webkit-%s" property
  let moz property = Printf.sprintf "-moz-%s" property
  let ms property = Printf.sprintf "-ms-%s" property
  let o property = Printf.sprintf "-o-%s" property
  let khtml property = Printf.sprintf "-khtml-%s" property

  let prefix_property (property : string) (value : string) prefixes =
    prefixes |> List.map (fun prefixer -> Core.D (prefixer property, value))

  let prefix_value (property : string) (value : string) prefixes =
    prefixes |> List.map (fun prefixer -> Core.D (property, prefixer value))

  let prefix (rule : Core.rule) : Core.rule list =
    match rule with
    | D
        ( (( "animation" | "animation-name" | "animation-duration"
           | "animation-delay" | "animation-direction" | "animation-fill-mode"
           | "animation-iteration-count" | "animation-play-state"
           | "animation-timing-function" ) as property),
          value )
    | D (("text-decoration" as property), value)
    | D (("filter" as property), value)
    | D (("clip-path" as property), value)
    | D (("backface-visibility" as property), value)
    | D (("column" as property), value)
    | D (("box-decoration-break" as property), value)
    | D
        ( (( "mask" | "mask-image" | "mask-mode" | "mask-clip" | "mask-size"
           | "mask-repeat" | "mask-origin" | "mask-position" | "mask-composite"
             ) as property),
          value )
    | D
        ( (( "column-count" | "column-fill" | "column-gap" | "column-rule"
           | "column-rule-color" | "column-rule-style" | "column-rule-width"
           | "column-span" | "column-width" ) as property),
          value )
    | D (("background-clip" as property), value)
    | D
        ( (( "margin-inline-end" | "margin-inline-start"
           | "padding-inline-start" | "padding-inline-end" ) as property),
          value )
    | D (("columns" as property), value) ->
      prefix_property property value [ webkit ] @ [ rule ]
    | D (("user-select" as property), value)
    | D (("appearance" as property), value)
    | D (("transform" as property), value)
    | D (("hyphens" as property), value)
    | D (("text-size-adjust" as property), value) ->
      prefix_property property value [ webkit; moz; ms ] @ [ rule ]
    | D ((("grid-row" | "grid-column") as property), value) ->
      prefix_property property value [ ms ] @ [ rule ]
    | D (("flex" as property), value)
    | D (("flex-direction" as property), value)
    | D (("scroll-snap-type" as property), value)
    | D (("writing-mode" as property), value) ->
      prefix_property property value [ webkit; ms ] @ [ rule ]
    | D (("tab-size" as property), value) ->
      prefix_property property value [ moz; o ] @ [ rule ]
    | D ("color-adjust", value) ->
      prefix_property "print-color-adjust" value [ webkit ] @ [ rule ]
    | D
        ( (( "align-items" | "align-content" | "flex-shrink" | "flex-basis"
           | "align-self" | "flex-grow" | "justify-content" ) as _property),
          _value ) ->
      [ rule ]
    | D (("cursor" as property), (("grab" | "grabbing") as value)) ->
      prefix_value property value [ webkit ] @ [ rule ]
    | D
        ( (( "width" | "min-width" | "max-width" | "height" | "min-height"
           | "max-height" | "min-block-size" | "max-block-size" ) as property),
          (("fit-content" | "max-content" | "min-content" | "fill-available") as
          value) ) ->
      prefix_value property value [ webkit; moz ] @ [ rule ]
    | D
        ( (( "width" | "min-width" | "max-width" | "height" | "min-height"
           | "max-height" ) as property),
          "stretch" ) ->
      prefix_value property "fill-available" [ webkit ]
      @ prefix_value property "available" [ moz ]
      @ [ rule ]
    (* TODO: Add -webkit-image-set on "background" | "background-image" image-set *)
    | _ -> [ rule ]
end

(* rules_to_string render the rule in a format where the hash matches with `@emotion/serialiseStyles`
   It doesn't render any whitespace.

   TODO: Ensure PseudoClassParam is rendered correctly.
*)
let rec rules_to_string rules =
  let buff = Buffer.create 16 in
  let push = Buffer.add_string buff in
  let rule_to_string rule =
    match rule with
    (* https://emotion.sh/docs/labels should be ignored on the rendering *)
    | D ("label", _value) -> ()
    | D (property, value) -> push (Printf.sprintf "%s:%s;" property value)
    | S (selector, rules) ->
      push (Printf.sprintf "%s{%s}" selector (rules_to_string rules))
    | PseudoClass (pseudoclass, rules) ->
      push (Printf.sprintf ":%s{%s}" pseudoclass (rules_to_string rules))
    | PseudoClassParam (pseudoclass, param, rules) ->
      push
        (Printf.sprintf ":%s (%s) {%s}" pseudoclass param
           (rules_to_string rules))
  in

  rules |> Array.iter rule_to_string;

  Buffer.contents buff

let render_declaration rule =
  match rule with
  (* https://emotion.sh/docs/labels should be ignored on the rendering *)
  | D ("label", _value) -> None
  | D (property, value) -> Some (Printf.sprintf "%s: %s;" property value)
  | _ -> None

let render_declarations (rules : rule array) =
  rules
  |> Array.map Autoprefixer.prefix
  |> Array.flatten
  |> Array.filter_map render_declaration
  |> Array.to_list
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
  | S (selector, rules) when is_at_rule selector ->
    Some
      (Printf.sprintf "%s { .%s { %s } }" selector hash
         (render_declarations rules))
  | S (selector, rules) ->
    let prelude = render_prelude hash selector in
    Some (Printf.sprintf "%s { %s }" prelude (render_declarations rules))
  | PseudoClass (pseduoclass, rules) ->
    Some
      (Printf.sprintf ".%s:%s { %s }" hash pseduoclass
         (render_declarations rules))
  | PseudoClassParam (pseudoclass, param, rules) ->
    Some
      (Printf.sprintf ".%s:%s ( %s ) %s" hash pseudoclass param
         (render_declarations rules))
  | _ -> None

let rec rule_to_debug nesting accumulator rule =
  let next_rule =
    match rule with
    | D (property, value) ->
      Printf.sprintf "Declaration (\"%s\", \"%s\")" property value
    | S (selector, rules) ->
      Printf.sprintf "Selector (\"%s\", %s)" selector (to_debug (nesting + 1) rules)
    | PseudoClass (pseduoclass, rules) ->
      Printf.sprintf "PseudoClass (\"%s\", %s)" pseduoclass
        (to_debug (nesting + 1) rules)
    | PseudoClassParam (pseudoclass, param, rules) ->
      Printf.sprintf "PseudoClassParam (\"%s\", \"%s\", %s)" pseudoclass param
        (to_debug (nesting + 1) rules)
  in
  let space = if nesting > 0 then String.make (nesting * 2) ' ' else "" in
  accumulator ^ Printf.sprintf "\n%s" space ^ next_rule

and to_debug nesting rules = rules |> Array.fold_left (rule_to_debug nesting) ""

let print_rules rules =
  rules |> Array.iter (fun rule -> print_endline (to_debug 0 [| rule |]))

let resolve_selectors rules = rules

(* `resolved_rule` here means to print valid CSS, selectors are nested
   and properties aren't autoprefixed. This function transforms into correct CSS. *)
let resolved_rule_to_css hash rules =
  (* TODO: Refactor with partition or partition_map. List.filter_map is error prone.
     Ss might need to respect the order of definition, and this breaks the order *)
  let list_of_rules = rules |> resolve_selectors in
  let declarations =
    list_of_rules
    |> Array.map Autoprefixer.prefix
    |> Array.flatten
    |> Array.filter_map render_declaration
    |> Array.to_list
    |> String.concat " "
    |> fun all -> Printf.sprintf ".%s { %s }" hash all
  in
  let selectors =
    list_of_rules
    |> Array.filter_map (render_selectors hash)
    |> Array.to_list
    |> String.concat " "
  in
  Printf.sprintf "%s %s" declarations selectors

let cache = ref (Hashtbl.create 1000)
let get hash = Hashtbl.mem cache.contents hash
let flush () = Hashtbl.clear cache.contents

let append hash (styles : rule array) =
  if get hash then () else Hashtbl.add cache.contents hash styles

let render_hash prefix hash label =
  match label with
  | None -> (Printf.sprintf "%s-%s" prefix hash)
  | Some label -> (Printf.sprintf "%s-%s-%s" prefix hash label)

let style (styles : rule array) =
  let is_label = function
    | D ("label", value) -> Some value
    | _ -> None in
  let label = Array.find_map is_label styles in
  let hash = Emotion_hash.Hash.default (rules_to_string styles) in
  let className = render_hash "css" hash label in
  append className styles;
  hash

let style_debug (styles : rule array) =
  print_endline (rules_to_string styles);
  style styles

let style_with_hash ~hash (styles : rule array) =
    let is_label = function
    | D ("label", value) -> Some value
    | _ -> None in
  let label = Array.find_map is_label styles in
  let className = render_hash "css" hash label in
  append className styles;
  hash

let render_style_tag () =
  Hashtbl.fold
    (fun hash rules accumulator ->
      let rules = rules |> resolved_rule_to_css hash |> String.trim in
      Printf.sprintf "%s %s" accumulator rules)
    cache.contents ""

