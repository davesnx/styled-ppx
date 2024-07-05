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

let render_declaration rule =
  match rule with
  (* https://emotion.sh/docs/labels should be ignored on the rendering *)
  | Rule.Declaration ("label", _value) -> None
  | Rule.Declaration (property, value) ->
    Some (Printf.sprintf "%s: %s;" property value)
  | _ -> None

let render_declarations rules =
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
    | Rule.Declaration (property, value) ->
      Printf.sprintf "Declaration (\"%s\", \"%s\")" property value
    | Rule.Selector (selector, rules) ->
      if nesting = 0 then
        Printf.sprintf "Selector (\"%s\", [%s])" selector
          (to_debug (nesting + 1) rules)
      else
        Printf.sprintf "Selector (\"%s\", [%s\n%s])" selector
          (to_debug (nesting + 1) rules)
          (String.make (nesting + 1) ' ')
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
  Array.partition (function Rule.Declaration _ -> true | _ -> false) rules

let split_by_kind_list rules =
  List.partition (function Rule.Declaration _ -> true | _ -> false) rules

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
    (function Rule.Selector (s, _) when is_at_rule s -> false | _ -> true)
    rules

let rules_contain_media rules =
  Array.exists
    (function Rule.Selector (s, _) when is_at_rule s -> true | _ -> false)
    rules

(* media selectors should be at the top. .a { @media () {} }
     should be @media () { .a {}} *)
let rec move_media_at_top (rule_list : Rule.t array) : Rule.t array =
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
      | Rule.Selector (current_selector, rules)
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
      | Rule.Selector (current_selector, rules)
        when Array.is_not_empty rules && rules_contain_media rules ->
        let declarations, selectors = split_by_kind rules in
        let media_selectors, non_media_selectors =
          Array.partition
            (function
              | Rule.Selector (s, _) when is_at_rule s -> true | _ -> false)
            selectors
        in
        let new_media_rules =
          Array.map
            (fun media_rules ->
              match media_rules with
              | Rule.Selector (nested_media_selector, nested_media_rule_list)
                when is_at_rule nested_media_selector ->
                [|
                  Rule.Selector
                    ( nested_media_selector,
                      [|
                        Rule.Selector (current_selector, nested_media_rule_list);
                      |] );
                |]
              | _ -> [||])
            media_selectors
          |> Array.flatten
        in
        let selector_without_media =
          [|
            Rule.Selector
              (current_selector, Array.(declarations @ non_media_selectors));
          |]
        in
        Array.(acc @ selector_without_media @ new_media_rules)
      (* media query may be inside a selector *)
      | Rule.Selector (_current_selector, rules) when Array.is_not_empty rules
        ->
        Array.append acc [| rule |]
      | Rule.Declaration (_, _) as rule -> Array.append acc [| rule |]
      | _ -> acc)
    [||] rule_list

and swap at_media_selector media_rules =
  let media_declarations, media_rules_selectors = split_by_kind media_rules in
  let resolved_media_selectors =
    Array.map
      (fun media_rules ->
        match media_rules with
        | Rule.Selector (nested_media_selector, nested_media_rule_list) ->
          [|
            Rule.Selector (at_media_selector, media_declarations);
            Rule.Selector
              ( join_media at_media_selector nested_media_selector,
                nested_media_rule_list );
          |]
        | _ -> [||])
      media_rules_selectors
    |> Array.flatten
  in
  move_media_at_top resolved_media_selectors

(* multiple selectors are defined with commas: like .a, .b {}
     we split those into separate rules *)
let split_multiple_selectors rule_list =
  Array.fold_left
    (fun acc rule ->
      match rule with
      | Rule.Selector (selector, rules)
        when contains_multiple_selectors selector ->
        let selector_list = String.split_on_char ',' selector in
        let new_rules =
          (* for each selector, we apply the same rules *)
          List.map
            (fun selector -> Rule.Selector (String.trim selector, rules))
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
         | Rule.Selector (current_selector, selector_rules)
           when starts_with_at current_selector ->
           Right [ Rule.Selector (current_selector, selector_rules) ]
         | Rule.Selector (current_selector, selector_rules) ->
           let is_first_level = prefix != "" in
           (* TODO: Simplify this monstruosity *)
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
           let new_selector =
             Rule.Selector (new_prelude, Array.of_list selectors)
           in
           Right (new_selector :: List.flatten rest_of_declarations)
         | _ as rule -> Left rule)
  in

  let rules = move_media_at_top rules in
  let rules = split_multiple_selectors rules in
  let declarations, selectors = unnest_selectors ~prefix:"" rules in
  List.flatten (declarations :: selectors)

let render_keyframes animationName keyframes =
  let definition =
    keyframes
    |> Array.map (fun (percentage, rules) ->
           Printf.sprintf "%i%% { %s }" percentage (render_declarations rules))
    |> Array.to_list
    |> String.concat " "
  in
  Printf.sprintf "@keyframes %s { %s }" animationName definition

(* Removes nesting on selectors, uplifts media-queries, runs the autoprefixer *)
let rec render_rules className rules =
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

  (* Trimming is necessary to ensure there isn't an empty space when one of `declarations` or `selectors` is empty. *)
  String.trim @@ String.concat " " [ declarations; selectors ]

(* Renders all selectors with the hash given *)
and render_selectors hash rule =
  match rule with
  | Rule.Selector (_selector, rules) when Array.is_empty rules -> None
  (* In case of being @media (or any at_rule) render the selector first and declarations with the hash inside *)
  | Rule.Selector (selector, rules) when is_at_rule selector ->
    let nested_selectors = render_rules hash rules in
    Some (Printf.sprintf "%s { %s }" selector nested_selectors)
  | Rule.Selector (selector, rules) ->
    let new_selector = resolve_ampersand hash selector in
    (* Resolving the ampersand means to replace all ampersands by the hash *)
    Some (Printf.sprintf "%s { %s }" new_selector (render_declarations rules))
  (* Declarations aren't there *)
  | _ -> None

(* rules_to_string renders the rule in a format where the hash matches with `@emotion/serialise`. It doesn't render any whitespace. (compared to render_rules) *)
(* TODO: Ensure Selector is serialised correctly *)
let rec rules_to_string rules =
  let buff = Buffer.create 16 in
  let push = Buffer.add_string buff in
  let rule_to_string rule =
    match rule with
    | Rule.Declaration (property, value) ->
      push (Printf.sprintf "%s:%s;" property value)
    | Rule.Selector (selector, rules) ->
      let rules = rules |> Array.to_list |> rules_to_string in
      push (Printf.sprintf "%s{%s}" selector rules)
  in
  List.iter rule_to_string rules;
  Buffer.contents buff

type declarations =
  | Globals of Rule.t array
  | Classnames of {
      className : string;
      styles : Rule.t array;
    }
  | Keyframes of {
      animationName : string;
      keyframes : (int * Rule.t array) array;
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
  let is_label = function
    | Rule.Declaration ("label", value) -> Some value
    | _ -> None
  in
  match Array.find_map is_label styles with
  | Some label -> Printf.sprintf "%s-%s" hash label
  | None -> Printf.sprintf "%s" hash

let instance = Stylesheet.make ()
let flush () = Stylesheet.flush instance

let style (styles : Rule.t array) =
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

let global (styles : Rule.t array) =
  match styles with
  | [||] -> ()
  | _ ->
    let hash = Murmur2.default (rules_to_string (Array.to_list styles)) in
    Stylesheet.push instance (hash, Globals styles)

let keyframes (keyframes : (int * Rule.t array) array) =
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
