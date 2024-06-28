include Css_Colors
include Css_Legacy_Core
module Types = Css_AtomicTypes

module Autoprefixer = struct
  (* Implementation of stylis autoprefixer https://github.com/thysultan/stylis *)
  (* This autoprefix works with ">1%, last 4 versions, Firefox ESR, not ie < 9, not dead" from browserlist and not so precise as stylis implementation *)

  let webkit property = Printf.sprintf "-webkit-%s" property
  let moz property = Printf.sprintf "-moz-%s" property
  let ms property = Printf.sprintf "-ms-%s" property
  let o property = Printf.sprintf "-o-%s" property
  let khtml property = Printf.sprintf "-khtml-%s" property

  let prefix_property (property : string) (value : string) prefixes =
    prefixes |> List.map (fun prefixer -> D (prefixer property, value))

  let prefix_value (property : string) (value : string) prefixes =
    prefixes |> List.map (fun prefixer -> D (property, prefixer value))

  let prefix (rule : rule) : rule list =
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

let render_declaration rule =
  match rule with
  (* https://emotion.sh/docs/labels should be ignored on the rendering *)
  | D ("label", _value) -> None
  | D (property, value) -> Some (Printf.sprintf "%s: %s;" property value)
  | _ -> None

let render_declarations (rules : rule list) =
  rules
  |> List.map Autoprefixer.prefix
  |> List.flatten
  |> List.filter_map render_declaration
  |> String.concat " "

let is_at_rule selector = String.contains selector '@'
let is_a_pseudo_selector selector = String.starts_with ~prefix:":" selector
let starts_with_at selector = String.starts_with ~prefix:"@" selector
let starts_with_double_dot selector = String.starts_with ~prefix:":" selector
let starts_with_ampersand selector = String.starts_with ~prefix:"&" selector
let contains_multiple_selectors selector = String.contains selector ','

let prefix ~pre s =
  let len = String.length pre in
  if len > String.length s then false
  else (
    let rec check i =
      if i = len then true
      else if String.unsafe_get s i <> String.unsafe_get pre i then false
      else check (i + 1)
    in
    check 0)

let chop_prefix ~pre s =
  if prefix ~pre s then
    Some
      (String.sub s (String.length pre) (String.length s - String.length pre))
  else None

let replace_ampersand ~by str =
  let rec replace_ampersand' str var =
    let len = String.length str in
    if len = 0 then ""
    else if str.[0] = '&' then
      var ^ replace_ampersand' (String.sub str 1 (len - 1)) var
    else
      String.sub str 0 1 ^ replace_ampersand' (String.sub str 1 (len - 1)) var
  in
  replace_ampersand' str by

let rec rule_to_debug nesting accumulator rule =
  let next_rule =
    match rule with
    | D (property, value) ->
      Printf.sprintf "Declaration (\"%s\", \"%s\")" property value
    | S (selector, rules) ->
      if nesting = 0 then
        Printf.sprintf "Selector (\"%s\", [%s])" selector
          (to_debug (nesting + 1) rules)
      else
        Printf.sprintf "Selector (\"%s\", [%s\n%s])" selector
          (to_debug (nesting + 1) rules)
          (String.make (nesting + 1) ' ')
    | PseudoClass (pseduoclass, rules) ->
      Printf.sprintf "PseudoClass (\"%s\", %s)" pseduoclass
        (to_debug (nesting + 1) rules)
    | PseudoClassParam (pseudoclass, param, rules) ->
      Printf.sprintf "PseudoClassParam (\"%s\", \"%s\", %s)" pseudoclass param
        (to_debug (nesting + 1) rules)
  in
  let space = if nesting > 0 then String.make (nesting * 2) ' ' else "" in
  accumulator ^ Printf.sprintf "\n%s" space ^ next_rule

and to_debug nesting rules = rules |> List.fold_left (rule_to_debug nesting) ""

let print_rules rules =
  rules |> List.iter (fun rule -> print_endline (to_debug 0 [ rule ]))

let resolve_selectors rules =
  let rules_contain_media rules =
    List.exists
      (function S (s, _) when is_at_rule s -> true | _ -> false)
      rules
  in

  let remove_media_from_selector selector =
    (* replace "@media" (min-width: 768px) from @media (min-width: 768px) *)
    chop_prefix ~pre:"@media " selector |> Option.value ~default:selector
  in

  let create_and_medias left right =
    left ^ " and " ^ remove_media_from_selector right
  in

  (* media selectors should be at the top. .a { @media () {} }
     should be @media () { .a {}} *)
  (* TODO: Only works with 2 levels *)
  (* TODO: Should push to top any selector *)
  let move_media_at_top rule_list =
    List.fold_left
      (fun acc rule ->
        match rule with
        | S (selector, rules) when rules_contain_media rules ->
          let media_rule_list =
            List.find_map
              (function S (s, r) when is_at_rule s -> Some (s, r) | _ -> None)
              rules
          in
          (match media_rule_list with
          | None -> []
          | Some (media_selector, media_rule_list) when starts_with_at selector
            ->
            (* parent and current are "@media" -> join them with " and " *)
            (* We take media_rule_list from the first selector, and append it on an "and" rule list *)
            let diff =
              List.filter
                (fun rule -> rule <> S (media_selector, media_rule_list))
                rules
            in
            List.append acc
              [
                S (selector, diff);
                S (create_and_medias media_selector selector, media_rule_list);
              ]
          | Some (media_selector, media_rule_list) ->
            List.append acc
              [ S (media_selector, [ S (selector, media_rule_list) ]) ])
        | _ -> List.append acc [ rule ])
      [] rule_list
  in

  print_rules rules;
  let rules = move_media_at_top rules in

  (* unnest takes a list of rules and unnest them into a flat list of rules *)
  let rec unnest ~prefix =
    (* multiple selectors are defined with commas: like .a, .b {}
       we split those into separate selectors with the same rules *)
    let split_multiple_selectors rule_list =
      List.fold_left
        (fun acc rule ->
          match rule with
          | S (selector, rules) when contains_multiple_selectors selector ->
            let selector_list = String.split_on_char ',' selector in
            let new_rules =
              List.map
                (* for each selector, we apply the same rules *)
                  (fun selector -> S (String.trim selector, rules))
                selector_list
            in
            List.append acc new_rules
          | rule -> List.append acc [ rule ])
        [] rule_list
    in

    List.partition_map (function
      (* in case of being at @media, don't do anything to it *)
      | S (title, selector_rules) when starts_with_at title ->
        Right [ S (title, selector_rules) ]
      (* in case of being a regular selector, unnest with the prefix *)
      | S (title, selector_rules) ->
        let new_prelude = prefix ^ title in
        let new_rules = split_multiple_selectors selector_rules in
        let content, tail = unnest ~prefix:(new_prelude ^ " ") new_rules in
        let new_selector = S (new_prelude, content) in
        Right (new_selector :: List.flatten tail)
      | _ as rule -> Left rule)
  in
  let declarations, selectors = unnest ~prefix:"" rules in
  List.flatten (declarations :: selectors)

let pp_keyframes animationName keyframes =
  let pp_keyframe (percentage, rules) =
    Printf.sprintf "%i%% { %s }" percentage (render_declarations rules)
  in
  let definition = keyframes |> List.map pp_keyframe |> String.concat " " in
  Printf.sprintf "@keyframes %s { %s }" animationName definition

(* Removes nesting on selectors, run the autoprefixer. *)
let rec render_rules className rules =
  (* TODO: Refactor with partition or partition_map. List.filter_map is error prone.
     Also it might need to respect the order of definition, and this breaks the order *)
  let list_of_rules = rules |> resolve_selectors in
  let declarations =
    list_of_rules
    |> List.map Autoprefixer.prefix
    |> List.flatten
    |> List.filter_map render_declaration
    |> String.concat " "
    |> fun all -> Printf.sprintf ".%s { %s }" className all
  in

  let selectors =
    list_of_rules
    |> List.filter_map (render_selectors className)
    |> String.concat " "
  in

  print_endline "After moving media at top:";
  print_rules list_of_rules;

  Printf.sprintf "%s %s" declarations selectors

(* Renders all selectors with the hash given *)
and render_selectors hash rule =
  match rule with
  | S (_selector, rules) when List.length rules == 0 -> None
  (* In case of being @media (or any at_rule) render the selector first and declarations with the hash inside *)
  | S (selector, rules) when is_at_rule selector ->
    let nested_selectors = render_rules hash rules in
    Some (Printf.sprintf "%s { %s }" selector nested_selectors)
  | S (selector, rules) ->
    (* Resolving the ampersand means to replace all ampersands by the hash *)
    let classname = "." ^ hash in
    let resolved_selector = replace_ampersand ~by:classname selector in
    let new_selector =
      if starts_with_ampersand selector then resolved_selector
      else if starts_with_at selector then resolved_selector
      else if starts_with_double_dot selector then
        Printf.sprintf ".%s%s" hash resolved_selector
      else Printf.sprintf ".%s %s" hash resolved_selector
    in
    Some (Printf.sprintf "%s { %s }" new_selector (render_declarations rules))
  (* S (aka Selectors) are the only ones used by styled-ppx, we don't use PseudoClass neither PseucodClassParam. TODO: Remove them.
     Meanwhile we have them, it's a good idea to check if the first character of the selector is a `:` because it's expected to not have a space between the selector and the :pseudoselector. *)
  | PseudoClass (pseduoclass, rules) ->
    Some
      (Printf.sprintf ".%s:%s { %s }" hash pseduoclass
         (render_declarations rules))
  | PseudoClassParam (pseudoclass, param, rules) ->
    Some
      (Printf.sprintf ".%s:%s ( %s ) %s" hash pseudoclass param
         (render_declarations rules))
  (* Declarations aren't there *)
  | D (_, _) -> None

(* rules_to_string renders the rule in a format where the hash matches with `@emotion/serialise`
     It doesn't render any whitespace. (compared to render_rules)
     TODO: Ensure Selector is rendered correctly.
     TODO: Ensure PsuedoClass is rendered correctly.
     TODO: Ensure PseudoClassParam is rendered correctly.
*)
let rec rules_to_string rules =
  let buff = Buffer.create 16 in
  let push = Buffer.add_string buff in
  let rule_to_string rule =
    match rule with
    | D (property, value) -> push (Printf.sprintf "%s:%s;" property value)
    | S (selector, rules) ->
      let rules = rules |> rules_to_string in
      push (Printf.sprintf "%s{%s}" selector rules)
    | PseudoClass (pseudoclass, rules) ->
      let rules = rules |> rules_to_string in
      push (Printf.sprintf ":%s{%s}" pseudoclass rules)
    | PseudoClassParam (pseudoclass, param, rules) ->
      let rules = rules |> rules_to_string in
      push (Printf.sprintf ":%s (%s) {%s}" pseudoclass param rules)
  in
  List.iter rule_to_string rules;
  Buffer.contents buff

type declarations =
  | Globals of rule list
  | Classnames of {
      className : string;
      styles : rule list;
    }
  | Keyframes of {
      animationName : string;
      keyframes : (int * rule list) list;
    }

module Stylesheet = struct
  module Hashes = Set.Make (String)

  type t = {
    mutable rules : (string * declarations) list;
    mutable hashes : Hashes.t;
  }

  let make () = { rules = []; hashes = Hashes.empty }

  let push stylesheet item =
    let hash = fst item in
    if Hashes.mem hash stylesheet.hashes then ()
    else (
      stylesheet.hashes <- Hashes.add hash stylesheet.hashes;
      stylesheet.rules <- item :: stylesheet.rules)

  let get_all stylesheet = List.rev stylesheet.rules

  let flush stylesheet =
    stylesheet.rules <- [];
    stylesheet.hashes <- Hashes.empty
end

let keyframes_to_string keyframes =
  let pp_keyframe (percentage, rules) =
    Printf.sprintf "%d%%{%s}" percentage (rules_to_string rules)
  in
  keyframes |> List.map pp_keyframe |> String.concat ""

let render_hash hash styles =
  let is_label = function D ("label", value) -> Some value | _ -> None in
  match List.find_map is_label styles with
  | Some label -> Printf.sprintf "%s-%s" hash label
  | None -> Printf.sprintf "%s" hash

let instance = Stylesheet.make ()
let flush () = Stylesheet.flush instance

let style (styles : rule list) =
  match styles with
  | [] -> ""
  | _ ->
    let hash = render_hash (Murmur2.default (rules_to_string styles)) styles in
    let className = Printf.sprintf "%s-%s" "css" hash in
    Stylesheet.push instance (hash, Classnames { className; styles });
    className

let global (styles : rule list) =
  match styles with
  | [] -> ()
  | _ ->
    let hash = Murmur2.default (rules_to_string styles) in
    Stylesheet.push instance (hash, Globals styles)

let keyframes (keyframes : (int * rule list) list) =
  match keyframes with
  | [] -> ""
  | _ ->
    let hash = Murmur2.default (keyframes_to_string keyframes) in
    let animationName = Printf.sprintf "%s-%s" "animation" hash in
    Stylesheet.push instance (hash, Keyframes { animationName; keyframes });
    animationName

let get_stylesheet () =
  Stylesheet.get_all instance
  |> List.fold_left
       (fun accumulator (_, rules) ->
         match rules with
         | Globals rules ->
           Printf.sprintf "%s %s" accumulator (rules_to_string rules)
         | Classnames { className; styles } ->
           let rules = render_rules className styles |> String.trim in
           Printf.sprintf "%s %s" accumulator rules
         | Keyframes { animationName; keyframes } ->
           let rules = pp_keyframes animationName keyframes |> String.trim in
           Printf.sprintf "%s %s" accumulator rules)
       ""
  |> String.trim

let get_string_style_hashes () =
  Stylesheet.get_all instance
  |> List.fold_left
       (fun accumulator (hash, _) ->
         Printf.sprintf "%s %s" accumulator hash |> String.trim)
       ""

let style_tag ?key:_ ?children:_ () =
  React.createElement "style"
    [
      String ("data-emotion", "css " ^ get_string_style_hashes ());
      Bool ("data-s", true);
      DangerouslyInnerHtml (get_stylesheet ());
    ]
    []
