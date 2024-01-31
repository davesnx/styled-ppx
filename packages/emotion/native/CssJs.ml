include Css_Colors
include Css_Js_Core
module Core = Css_Js_Core
module Types = Css_AtomicTypes

module Array = struct
  include Stdlib.Array

  external getUnsafe : 'a array -> int -> 'a = "%array_unsafe_get"
  external setUnsafe : 'a array -> int -> 'a -> unit = "%array_unsafe_set"

  let filter_map a f =
    let l = length a in
    let r = ref None in
    let j = ref 0 in
    for i = 0 to l - 1 do
      let v = getUnsafe a i in
      match f v with
      | None -> ()
      | Some v ->
        let r =
          match !r with
          | None ->
            let newr = Array.make l v in
            r := Some newr;
            newr
          | Some r -> r
        in
        setUnsafe r !j v;
        incr j
    done;
    match !r with None -> [||] | Some r -> Stdlib.Array.sub r 0 !j
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

let render_declaration rule =
  match rule with
  (* https://emotion.sh/docs/labels should be ignored on the rendering *)
  | D ("label", _value) -> None
  | D (property, value) -> Some (Printf.sprintf "%s: %s;" property value)
  | _ -> None

let render_declarations (rules : rule array) =
  rules
  |> Array.to_list
  |> List.map Autoprefixer.prefix
  |> List.flatten
  |> List.filter_map render_declaration
  |> String.concat " "

let is_at_rule selector = String.contains selector '@'
let is_a_pseudo_selector selector = String.starts_with ~prefix:":" selector

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
  (* S (aka Selectors) are the only ones used by styled-ppx, we don't use PseudoClass neither PseucodClassParam. TODO: Remove them.
     Meanwhile we have them, it's a good idea to check if the first character of the selector is a `:` because it's expected to not have a space between the selector and the :pseudoselector. *)
  if is_a_pseudo_selector new_selector then
    Printf.sprintf ".%s%s" hash new_selector
  else Printf.sprintf ".%s %s" hash new_selector

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
      Printf.sprintf "Selector (\"%s\", %s)" selector
        (to_debug (nesting + 1) rules)
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
  rules |> Stdlib.Array.iter (fun rule -> print_endline (to_debug 0 [| rule |]))

let resolve_selectors rules =
  let rec unnest ~prefix =
    List.partition_map (function
      | S (title, selector_rules) ->
        let new_prelude = prefix ^ title in
        let content, tail =
          unnest ~prefix:(new_prelude ^ " ") (Array.to_list selector_rules)
        in
        Right (S (new_prelude, Array.of_list content) :: List.flatten tail)
      | _ as rule -> Left rule)
  in
  let resolve_selector rule =
    let declarations, selectors = unnest ~prefix:"" [ rule ] in
    List.flatten (declarations :: selectors)
  in
  rules |> List.map resolve_selector |> List.flatten

let pp_keyframes hash keyframes =
  let pp_keyframe (percentage, rules) =
    Printf.sprintf "%i%% { %s }" percentage (render_declarations rules)
  in
  let definition =
    keyframes |> Array.map pp_keyframe |> Array.to_list |> String.concat " "
  in
  Printf.sprintf "@keyframes %s { %s }" hash definition

(* Removes nesting on selectors, run the autoprefixer. *)
let pp_rules hash rules =
  (* TODO: Refactor with partition or partition_map. List.filter_map is error prone.
     Ss might need to respect the order of definition, and this breaks the order *)
  let list_of_rules = rules |> Array.to_list |> resolve_selectors in
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

(* rules_to_string renders the rule in a format where the hash matches with `@emotion/serialise`
     It doesn't render any whitespace. (compared to pp_rules)
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
      let rules = rules |> Array.to_list |> rules_to_string in
      push (Printf.sprintf "%s{%s}" selector rules)
    | PseudoClass (pseudoclass, rules) ->
      let rules = rules |> Array.to_list |> rules_to_string in
      push (Printf.sprintf ":%s{%s}" pseudoclass rules)
    | PseudoClassParam (pseudoclass, param, rules) ->
      let rules = rules |> Array.to_list |> rules_to_string in
      push (Printf.sprintf ":%s (%s) {%s}" pseudoclass param rules)
  in
  List.iter rule_to_string rules;
  Buffer.contents buff

type declarations =
  | Classnames of rule array
  | Keyframes of (int * rule array) array

module Stylesheet = struct
  module Hashes = Set.Make (String)

  type 'a t = {
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
    Printf.sprintf "%d%%{%s}" percentage
      (rules |> Array.to_list |> rules_to_string)
  in
  keyframes |> Array.map pp_keyframe |> Array.to_list |> String.concat ""

let render_hash prefix hash styles =
  let is_label = function D ("label", value) -> Some value | _ -> None in
  match Array.find_map is_label styles with
  | None -> Printf.sprintf "%s-%s" prefix hash
  | Some label -> Printf.sprintf "%s-%s-%s" prefix hash label

let instance = Stylesheet.make ()
let flush () = Stylesheet.flush instance

let style (styles : rule array) =
  match styles with
  | [||] -> ""
  | _ ->
    let hash =
      Emotion_hash.Hash.default (rules_to_string (Array.to_list styles))
    in
    let className = render_hash "css" hash styles in
    Stylesheet.push instance (className, Classnames styles);
    className

let keyframes (keyframes : (int * rule array) array) =
  match keyframes with
  | [||] -> ""
  | _ ->
    let hash = Emotion_hash.Hash.default (keyframes_to_string keyframes) in
    let animationName = Printf.sprintf "%s-%s" "animation" hash in
    Stylesheet.push instance (animationName, Keyframes keyframes);
    animationName

let render_style_tag () =
  Stylesheet.get_all instance
  |> List.fold_left
       (fun accumulator (hash, rules) ->
         match rules with
         | Classnames rules ->
           let rules = pp_rules hash rules |> String.trim in
           Printf.sprintf "%s %s" accumulator rules
         | Keyframes keyframes ->
           let rules = pp_keyframes hash keyframes |> String.trim in
           Printf.sprintf "%s %s" accumulator rules)
       ""
  |> String.trim
