include Declarations
include Colors
include Alias
include Rule

(* The reason to have a module called Css_types and not Types directly, is because we use a unwrapped library, so all modules are exposed. "Types" would collide with a lot of modules in user's application *)
module Types = Css_types

module Array = struct
  include Kloth.Array
  include Stdlib.ArrayLabels

  type 'a t = 'a array

  let ( @ ) = Stdlib.Array.append
  let is_empty a = Array.length a == 0
  let is_not_empty a = Array.length a != 0
  let join ~sep a = String.concat sep (Array.to_list a)

  let partition_map ~f t =
    let (both : _ Either.t t) = map t ~f in
    let firsts =
      filter_map ~f:(function Either.Left x -> Some x | Right _ -> None) both
    in
    let seconds =
      filter_map ~f:(function Either.Left _ -> None | Right x -> Some x) both
    in
    firsts, seconds

  let partition ~f t =
    (partition_map t ~f:(fun x ->
         match f x with true -> Left x | false -> Right x)
    [@nontail])

  let flatten a = Array.concat (Array.to_list a)
end

let approximate_chars_in_rules = 50

let render_declaration ~buffer (property, value) =
  Buffer.add_string buffer property;
  Buffer.add_string buffer ": ";
  Buffer.add_string buffer value;
  Buffer.add_char buffer ';'

let render_declarations ~buffer rules =
  rules
  |> Array.map ~f:Autoprefixer.prefix
  |> Array.flatten
  |> Array.filter_map ~f:(function
       | Rule.Declaration ("label", _value) -> None
       | Rule.Declaration (property, value) -> Some (property, value)
       | _ -> None)
  |> Array.iteri ~f:(fun i decl ->
         if i > 0 then Buffer.add_char buffer ' ';
         render_declaration ~buffer decl)

let contains_at selector = String.contains selector '@'
let contains_ampersand selector = String.contains selector '&'
let contains_a_coma selector = String.contains selector ','
let starts_with_at selector = String.starts_with ~prefix:"@" selector
let starts_with_dot selector = String.starts_with ~prefix:"." selector
let starts_with_double_dot selector = String.starts_with ~prefix:":" selector
let starts_with_ampersand selector = String.starts_with ~prefix:"&" selector

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

and to_debug nesting rules =
  rules |> Array.fold_left ~f:(rule_to_debug nesting) ~init:""

let print_rules ?(initial = 0) rules =
  match rules with
  | [||] ->
    let space = if initial > 0 then String.make (initial * 2) ' ' else "" in
    print_endline @@ Printf.sprintf "\n%s Empty []\n" space
  | _ ->
    rules
    |> Array.iter ~f:(fun rule -> print_endline (to_debug initial [| rule |]))

let split_by_kind rules =
  Array.partition ~f:(function Rule.Declaration _ -> true | _ -> false) rules

let resolve_ampersand hash selector =
  let classname = "." ^ hash in
  let resolved_selector = replace_ampersand ~by:classname selector in
  if contains_ampersand selector then resolved_selector
  else if starts_with_at selector then resolved_selector
    (* This is the differente between SASS and Emotion. Emotion doesn't add a space on pseuo-selectors, while SASS does *)
  else if starts_with_double_dot selector then
    Printf.sprintf ".%s%s" hash resolved_selector
  else Printf.sprintf ".%s %s" hash resolved_selector

let remove_media_from_selector selector =
  (* replace "@media" from "@media (min-width: 768px)" *)
  chop_prefix ~pre:"@media " selector |> Option.value ~default:selector

let join_media left right = left ^ " and " ^ remove_media_from_selector right

let rules_do_not_contain_media rules =
  Array.exists
    ~f:(function Rule.Selector (s, _) when contains_at s -> false | _ -> true)
    rules

let rules_contain_media rules =
  Array.exists
    ~f:(function Rule.Selector (s, _) when contains_at s -> true | _ -> false)
    rules

(* media selectors should be at the top. .a { @media () {} }
     should be @media () { .a {}} *)
let rec move_media_at_top (rule_list : rule array) : rule array =
  Array.fold_left
    ~f:(fun acc rule ->
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
        when contains_at current_selector && rules_contain_media rules ->
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
          Array.partition selectors ~f:(function
            | Rule.Selector (s, _) when contains_at s -> true
            | _ -> false)
        in
        let new_media_rules =
          Array.map
            ~f:(fun media_rules ->
              match media_rules with
              | Rule.Selector (nested_media_selector, nested_media_rule_list)
                when contains_at nested_media_selector ->
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
    ~init:[||] rule_list

and swap at_media_selector media_rules =
  let media_declarations, media_rules_selectors = split_by_kind media_rules in
  let resolved_media_selectors =
    Array.map
      ~f:(fun media_rules ->
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
    ~f:(fun acc rule ->
      match rule with
      | Rule.Selector (selector, rules) when contains_a_coma selector ->
        let selector_list = String.split_on_char ',' selector in
        let new_rules =
          (* for each selector, we apply the same rules *)
          List.map
            (fun selector -> Rule.Selector (String.trim selector, rules))
            selector_list
        in
        List.append acc new_rules
      | rule -> List.append acc [ rule ])
    ~init:[] rule_list
  |> Array.of_list

let resolve_selectors rules =
  (* unnest takes a list of rules and unnest them into a flat list of rules *)
  let rec unnest_selectors ~prefix rules =
    (* multiple selectors are defined with commas: like .a, .b {}
       we split those into separate selectors with the same rules *)
    Array.partition_map rules ~f:(function
      (* in case of being at @media, don't do anything to it *)
      | Rule.Selector (current_selector, selector_rules)
        when starts_with_at current_selector ->
        Right [| Rule.Selector (current_selector, selector_rules) |]
      | Rule.Selector (current_selector, selector_rules) ->
        (* we derive the new prefix based on the current_selector and the previous "prefix" (aka the prefix added by the parent selector) *)
        let new_prefix =
          match prefix with
          | None -> current_selector
          | Some prefix ->
            if contains_ampersand current_selector then
              (* reemplazar el ampersand del current_selector, con el padre *)
              replace_ampersand ~by:prefix current_selector
            else if starts_with_double_dot current_selector then
              prefix ^ current_selector
              (* This case is the same as the "else", but I keep it for reference *)
            else if starts_with_dot current_selector then
              prefix ^ " " ^ current_selector
            else prefix ^ " " ^ current_selector
        in
        let selector_rules = split_multiple_selectors selector_rules in
        let selectors, rest_of_declarations =
          unnest_selectors ~prefix:(Some new_prefix) selector_rules
        in
        let new_selector = Rule.Selector (new_prefix, selectors) in
        Right (Array.append [| new_selector |] rest_of_declarations)
      | _ as rule -> Left rule)
    |> fun (selectors, declarations) -> selectors, Array.flatten declarations
  in

  let rules = move_media_at_top rules in
  let rules = split_multiple_selectors rules in
  (* The base case for unnesting is without any prefix *)
  let declarations, selectors = unnest_selectors ~prefix:None rules in
  Array.append declarations selectors

let render_keyframes ~buffer animationName keyframes =
  Buffer.add_string buffer "@keyframes ";
  Buffer.add_string buffer animationName;
  Buffer.add_string buffer " { ";
  Array.iteri keyframes ~f:(fun i (percentage, rules) ->
      if i > 0 then Buffer.add_char buffer ' ';
      Buffer.add_string buffer (string_of_int percentage);
      Buffer.add_string buffer "% { ";
      render_declarations ~buffer rules;
      Buffer.add_string buffer " }");
  Buffer.add_string buffer " }"

(* Removes nesting on selectors, uplifts media-queries, runs the autoprefixer *)
let rec render_rules ~buffer className rules =
  let declarations, selectors = split_by_kind (resolve_selectors rules) in
  (match declarations with
  | [||] -> ()
  | _ ->
    Buffer.add_string buffer ".";
    Buffer.add_string buffer className;
    Buffer.add_string buffer " { ";
    render_declarations ~buffer declarations;
    Buffer.add_string buffer " }");
  match selectors with
  | [||] -> ()
  | _ ->
    if Array.length declarations > 0 then Buffer.add_char buffer ' ';
    selectors
    |> Array.filter_map ~f:(function
         | Rule.Selector (_selector, rules) when Array.is_empty rules -> None
         | Rule.Selector (selector, rules) -> Some (selector, rules)
         | _ -> None)
    |> Array.iteri ~f:(fun i rule ->
           if i > 0 then Buffer.add_char buffer ' ';
           render_selectors ~buffer className rule)

(* Renders all selectors with the hash given *)
and render_selectors ~buffer hash (selector, rules) =
  if contains_at selector then (
    Buffer.add_string buffer selector;
    Buffer.add_string buffer " { ";
    render_rules ~buffer hash rules;
    Buffer.add_string buffer " }")
  else (
    Buffer.add_string buffer (resolve_ampersand hash selector);
    Buffer.add_string buffer " { ";
    render_declarations ~buffer rules;
    Buffer.add_string buffer " }")

(* rules_to_string renders the rule in a format where the hash matches with `@emotion/serialise`. It doesn't render any whitespace. (compared to render_rules) *)
(* TODO: Ensure Selector is serialised correctly *)
let rules_to_string rules =
  let initial_size = Array.length rules * approximate_chars_in_rules in
  let buffer = Buffer.create initial_size in
  let rec go rules =
    Array.iter rules ~f:(function
      | Rule.Declaration (property, value) ->
        Buffer.add_string buffer property;
        Buffer.add_char buffer ':';
        Buffer.add_string buffer value;
        Buffer.add_char buffer ';'
      | Rule.Selector (selector, rules) ->
        Buffer.add_string buffer selector;
        Buffer.add_char buffer '{';
        go rules;
        Buffer.add_char buffer '}')
  in
  go rules;
  Buffer.contents buffer

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
  let buffer = Buffer.create 1024 in
  Array.iter keyframes ~f:(fun (percentage, rules) ->
      Buffer.add_string buffer (string_of_int percentage);
      Buffer.add_string buffer "%{";
      Buffer.add_string buffer (rules_to_string rules);
      Buffer.add_char buffer '}');
  Buffer.contents buffer

let render_hash hash styles =
  let is_label = function
    | Rule.Declaration ("label", value) -> Some value
    | _ -> None
  in
  match Array.find_map ~f:is_label styles with
  | Some label -> Printf.sprintf "%s-%s" hash label
  | None -> Printf.sprintf "%s" hash

let instance = Stylesheet.make ()
let flush () = Stylesheet.flush instance

let style (styles : rule array) =
  match styles with
  | [||] -> "css-0"
  | _ ->
    let hash = render_hash (Murmur2.default (rules_to_string styles)) styles in
    let className = Printf.sprintf "%s-%s" "css" hash in
    Stylesheet.push instance (hash, Classnames { className; styles });
    className

let global (styles : rule array) =
  match styles with
  | [||] -> ()
  | _ ->
    let hash = Murmur2.default (rules_to_string styles) in
    Stylesheet.push instance (hash, Globals styles)

let keyframes (keyframes : (int * rule array) array) =
  match keyframes with
  | [||] -> Types.AnimationName.make ""
  | _ ->
    let hash = Murmur2.default (keyframes_to_string keyframes) in
    let animationName = Printf.sprintf "%s-%s" "animation" hash in
    Stylesheet.push instance (hash, Keyframes { animationName; keyframes });
    Types.AnimationName.make animationName

let get_stylesheet () =
  let stylesheet = Stylesheet.get_all instance in
  let initial_size = List.length stylesheet * approximate_chars_in_rules in
  let buffer = Buffer.create initial_size in
  List.iteri
    (fun i (_, rule) ->
      if i > 0 then Buffer.add_char buffer ' ';
      match rule with
      | Globals rule ->
        let new_rule = resolve_selectors rule in
        Buffer.add_string buffer (rules_to_string new_rule)
      | Classnames { className; styles } ->
        render_rules ~buffer className styles
      | Keyframes { animationName; keyframes } ->
        render_keyframes ~buffer animationName keyframes)
    stylesheet;
  Buffer.contents buffer

let get_string_style_hashes () =
  Stylesheet.get_all instance
  |> List.fold_left
       (fun accumulator (hash, _) ->
         String.trim @@ Printf.sprintf "%s %s" accumulator hash)
       ""

let style_tag ?key:_ ?children:_ () =
  React.createElement "style"
    [
      String ("data-emotion", "css " ^ get_string_style_hashes ());
      Bool ("data-s", true);
      DangerouslyInnerHtml (get_stylesheet ());
    ]
    []

(* This method is a Css_type function, but with side-effects. It pushes the fontFace as global style *)
let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust
  ?unicodeRange () =
  let fontFace =
    [|
      Kloth.Option.map ~f:Declarations.fontStyle fontStyle;
      Kloth.Option.map ~f:Declarations.fontWeight fontWeight;
      Kloth.Option.map ~f:Declarations.fontDisplay fontDisplay;
      Kloth.Option.map ~f:Declarations.sizeAdjust sizeAdjust;
      Kloth.Option.map ~f:Declarations.unicodeRange unicodeRange;
      Some (Declarations.fontFamily fontFamily);
      Some
        (Rule.Declaration
           ( "src",
             Kloth.Array.map_and_join ~sep:{js|, |js}
               ~f:Css_types.FontFace.toString src ));
    |]
    |> Kloth.Array.filter_map ~f:(fun i -> i)
  in
  global [| Rule.Selector ("@font-face", fontFace) |];
  fontFamily
