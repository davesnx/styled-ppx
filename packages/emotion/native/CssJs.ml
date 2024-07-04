[@@@warning "-27-39"]

include Css_Colors
include Css_Js_Core
module Types = Css_AtomicTypes

module Array = struct
  include Stdlib.Array

  let ( @ ) = Stdlib.Array.append
  let is_empty a = Array.length a == 0
  let is_not_empty a = Array.length a != 0

  external getUnsafe : 'a array -> int -> 'a = "%array_unsafe_get"
  external setUnsafe : 'a array -> int -> 'a -> unit = "%array_unsafe_set"

  let partition_map f a =
    List.partition_map f (Array.to_list a) |> fun (a, b) ->
    Array.of_list a, Array.of_list b

  let partition f a =
    List.partition f (Array.to_list a) |> fun (a, b) ->
    Array.of_list a, Array.of_list b

  let filter_map f a =
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

  let filter f a = filter_map (fun x -> if f x then Some x else None) a
  let flatten a = Array.concat (Array.to_list a)
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

let render_declarations (rules : rule array) =
  rules
  |> Array.to_list
  |> List.map Autoprefixer.prefix
  |> List.flatten
  |> List.filter_map render_declaration
  |> String.concat " "

let is_at_rule selector = String.contains selector '@'
let starts_with_at selector = String.starts_with ~prefix:"@" selector
let starts_with_double_dot selector = String.starts_with ~prefix:":" selector
let starts_with_dot selector = String.starts_with ~prefix:"." selector
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

let remove_first_ampersand str = String.sub str 1 (String.length str - 1)

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

and to_debug nesting rules = rules |> Array.fold_left (rule_to_debug nesting) ""

let print_rules ?(initial = 0) rules =
  match rules with
  | [||] ->
    let space = if initial > 0 then String.make (initial * 2) ' ' else "" in
    print_endline @@ Printf.sprintf "\n%s Empty []\n" space
  | _ ->
    rules
    |> Array.iter (fun rule -> print_endline (to_debug initial [| rule |]))

let split_by_kind rules =
  Array.partition (function D _ -> true | _ -> false) rules

let split_by_kind_list rules =
  List.partition (function D _ -> true | _ -> false) rules

let resolve_ampersand hash selector =
  let classname = "." ^ hash in
  let resolved_selector = replace_ampersand ~by:classname selector in
  if starts_with_ampersand selector then resolved_selector
  else if starts_with_at selector then resolved_selector
  else if starts_with_double_dot selector then
    Printf.sprintf ".%s%s" hash resolved_selector
  else Printf.sprintf ".%s %s" hash resolved_selector

let remove_media_from_selector selector =
  (* replace "@media" from "@media (min-width: 768px)" *)
  chop_prefix ~pre:"@media " selector |> Option.value ~default:selector

let join_media left right = left ^ " and " ^ remove_media_from_selector right

let rules_do_not_contain_media rules =
  Array.exists
    (function S (s, _) when is_at_rule s -> false | _ -> true)
    rules

let rules_contain_media rules =
  Array.exists
    (function S (s, _) when is_at_rule s -> true | _ -> false)
    rules

(* media selectors should be at the top. .a { @media () {} }
     should be @media () { .a {}} *)
let rec move_media_at_top (rule_list : rule array) : rule array =
  Array.fold_left
    (fun acc rule ->
      match rule with
      (* current_select is a @media and contains @media inside their rules:

         @media (min-width: 768px) {
           display: block;

           @media (min-width: 1200px) {
             height: auto;
           }
         }
      *)
      | S (current_selector, rules)
        when is_at_rule current_selector && rules_contain_media rules ->
        let new_rules = swap current_selector rules in
        Array.append acc new_rules
      (* current_selector isn't a media query, but it's a selecotr. It may contain media-queries inside the rules: Example:

         display: block;

         & div {
           @media (min-width: 768px) {
             height: auto;
           }
         }
      *)
      | S (current_selector, rules)
        when Array.is_not_empty rules && rules_contain_media rules ->
        print_endline
        @@ Printf.sprintf "\n!! WPOWPWOPW (rules_contain_media) %s !!\n" current_selector;
        let declarations, selectors = split_by_kind rules in
        let media_selectors, non_media_selectors =
          Array.partition
            (function S (s, _) when is_at_rule s -> true | _ -> false)
            selectors
        in
        print_endline @@ Printf.sprintf "    declarations";
        print_rules ~initial:4 declarations;
        (* print_endline @@ Printf.sprintf "    selectors";
           print_rules ~initial:4 selectors; *)
        print_endline @@ Printf.sprintf "    media_selectors";
        print_rules ~initial:4 media_selectors;
        print_endline @@ Printf.sprintf "    non_media_selectors";
        print_rules ~initial:4 non_media_selectors;
        let new_media_rules =
          Array.map
            (fun media_rules ->
              match media_rules with
              | S (nested_media_selector, nested_media_rule_list)
                when is_at_rule nested_media_selector ->
                [|
                  S
                    ( nested_media_selector,
                      [| S (current_selector, nested_media_rule_list) |] );
                  (* S
                     ( join_media at_media_selector nested_media_selector,
                       nested_media_rule_list ); *)
                |]
              | S (nested_media_selector, nested_media_rule_list) ->
                print_endline nested_media_selector;
                [|
                  (* S
                     ( join_media at_media_selector nested_media_selector,
                       nested_media_rule_list ); *)
                |]
              | _ -> [||])
            media_selectors
          |> Array.flatten
        in
        Array.( acc @ [|S (current_selector, declarations)|] @ new_media_rules)
      (* media query may be inside a selector *)
      | S (current_selector, rules) when Array.is_not_empty rules ->
        Array.append acc [| rule |]
      | D (_, _) as rule -> Array.append acc [| rule |]
      | _ -> acc)
    [||] rule_list

and swap at_media_selector media_rules =
  print_endline @@ Printf.sprintf "\n!! SWAP !!\n";
  print_endline @@ Printf.sprintf "at_media_selector %s" at_media_selector;
  print_endline @@ Printf.sprintf "media_rules";
  print_rules media_rules;
  let media_declarations, media_rules_selectors = split_by_kind media_rules in
  print_endline @@ Printf.sprintf "media_declarations";
  print_rules media_declarations;
  print_endline @@ Printf.sprintf "media_rules_selectors";
  print_rules media_rules_selectors;
  let resolved_media_selectors =
    Array.map
      (fun media_rules ->
        match media_rules with
        | S (nested_media_selector, nested_media_rule_list) ->
          [|
            S (at_media_selector, media_declarations);
            S
              ( join_media at_media_selector nested_media_selector,
                nested_media_rule_list );
          |]
        | _ -> [||])
      media_rules_selectors
    |> Array.flatten
  in
  print_endline @@ Printf.sprintf "resolved_media_selectors";
  print_rules resolved_media_selectors;
  move_media_at_top resolved_media_selectors

(* multiple selectors are defined with commas: like .a, .b {}
     we split those into separate rules *)
let split_multiple_selectors rule_list =
  Array.fold_left
    (fun acc rule ->
      match rule with
      | S (selector, rules) when contains_multiple_selectors selector ->
        let selector_list = String.split_on_char ',' selector in
        let new_rules =
          (* for each selector, we apply the same rules *)
          List.map
            (fun selector -> S (String.trim selector, rules))
            selector_list
        in
        List.append acc new_rules
      | rule -> List.append acc [ rule ])
    [] rule_list

let resolve_selectors rules =
  (* unnest takes a list of rules and unnest them into a flat list of rules *)
  let rec unnest_selectors ~prefix rules =
    (* multiple selectors are defined with commas: like .a, .b {}
       we split those into separate selectors with the same rules *)
    rules
    |> List.partition_map (function
         (* in case of being at @media, don't do anything to it *)
         | S (current_selector, selector_rules)
           when starts_with_at current_selector ->
           Right [ S (current_selector, selector_rules) ]
         | S (current_selector, selector_rules) ->
           let is_first_level = prefix != "" in
           let new_prelude =
             if is_first_level && starts_with_ampersand current_selector then
               prefix ^ remove_first_ampersand current_selector
             else if is_first_level && starts_with_dot current_selector then
               prefix ^ remove_first_ampersand current_selector
             else if is_first_level && starts_with_double_dot current_selector
             then prefix ^ current_selector
             else if is_first_level || starts_with_dot current_selector then
               prefix ^ " " ^ current_selector
             else prefix ^ current_selector
           in
           let selector_rules = split_multiple_selectors selector_rules in
           let selectors, rest_of_declarations =
             unnest_selectors ~prefix:new_prelude selector_rules
           in
           let new_selector = S (new_prelude, Array.of_list selectors) in
           Right (new_selector :: List.flatten rest_of_declarations)
         | _ as rule -> Left rule)
  in

  print_endline "\n - RESOLVE SELECTORS --------";
  let rules = move_media_at_top rules in
  print_endline "\n -- After moving media at top --";
  print_rules rules;
  let rules = split_multiple_selectors rules in
  let declarations, selectors = unnest_selectors ~prefix:"" rules in
  let rut = List.flatten (declarations :: selectors) in
  print_endline "\n -- FINAL --";
  print_rules (Array.of_list rules);
  rut

let render_keyframes animationName keyframes =
  let definition =
    keyframes
    |> Array.map (fun (percentage, rules) ->
           Printf.sprintf "%i%% { %s }" percentage (render_declarations rules))
    |> Array.to_list
    |> String.concat " "
  in
  Printf.sprintf "@keyframes %s { %s }" animationName definition

(* Removes nesting on selectors, run the autoprefixer. *)
let rec render_rules className rules =
  print_endline "\n - RENDER RULES --------";
  print_rules rules;
  let declarations, selectors = split_by_kind_list (resolve_selectors rules) in

  let declarations =
    match declarations with
    | [] -> ""
    | _ ->
      declarations
      |> List.map Autoprefixer.prefix
      |> List.flatten
      |> List.filter_map render_declaration
      |> String.concat " "
      |> fun all -> Printf.sprintf ".%s { %s }" className all
  in

  let selectors =
    match selectors with
    | [] -> ""
    | _ ->
      selectors
      |> List.filter_map (render_selectors className)
      |> String.concat " "
  in

  (* This trim is to ensure there isn't an empty space when one of `declarations` or `selectors` is empty. *)
  String.trim @@ String.concat " " [ declarations; selectors ]

(* Renders all selectors with the hash given *)
and render_selectors hash rule =
  match rule with
  | S (_selector, rules) when Array.is_empty rules -> None
  (* In case of being @media (or any at_rule) render the selector first and declarations with the hash inside *)
  | S (selector, rules) when is_at_rule selector ->
    let nested_selectors = render_rules hash rules in
    Some (Printf.sprintf "%s { %s }" selector nested_selectors)
  | S (selector, rules) ->
    let new_selector = resolve_ampersand hash selector in
    (* Resolving the ampersand means to replace all ampersands by the hash *)
    Some (Printf.sprintf "%s { %s }" new_selector (render_declarations rules))
  (* Declarations aren't there *)
  | _ -> None

(* rules_to_string renders the rule in a format where the hash matches with `@emotion/serialise`. It doesn't render any whitespace. (compared to render_rules) *)
(* TODO: Ensure Selector is rendered correctly *)
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
  | Globals of rule array
  | Classnames of {
      className : string;
      styles : rule array;
    }
  | Keyframes of {
      animationName : string;
      keyframes : (int * rule array) array;
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
    Printf.sprintf "%d%%{%s}" percentage
      (rules |> Array.to_list |> rules_to_string)
  in
  keyframes |> Array.map pp_keyframe |> Array.to_list |> String.concat ""

let render_hash hash styles =
  let is_label = function D ("label", value) -> Some value | _ -> None in
  match Array.find_map is_label styles with
  | Some label -> Printf.sprintf "%s-%s" hash label
  | None -> Printf.sprintf "%s" hash

let instance = Stylesheet.make ()
let flush () = Stylesheet.flush instance

let style (styles : rule array) =
  match styles with
  | [||] -> "css-0"
  | _ ->
    let hash =
      render_hash
        (Murmur2.default (rules_to_string (Array.to_list styles)))
        styles
    in
    let className = Printf.sprintf "%s-%s" "css" hash in
    Stylesheet.push instance (hash, Classnames { className; styles });
    className

let global (styles : rule array) =
  match styles with
  | [||] -> ()
  | _ ->
    let hash = Murmur2.default (rules_to_string (Array.to_list styles)) in
    Stylesheet.push instance (hash, Globals styles)

let keyframes (keyframes : (int * rule array) array) =
  match keyframes with
  | [||] -> ""
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
           Printf.sprintf "%s %s" accumulator
             (rules_to_string (Array.to_list rules))
         | Classnames { className; styles } ->
           let rules = render_rules className styles |> String.trim in
           Printf.sprintf "%s %s" accumulator rules
         | Keyframes { animationName; keyframes } ->
           let rules =
             render_keyframes animationName keyframes |> String.trim
           in
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
