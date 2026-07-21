(* Compile-time validation of conditional group rule preludes:
   `@media` / `@supports` / `@container`.

   Two layers:
   - structure, via the registered grammars (media-query-list,
     supports-condition, container-condition-list);
   - feature names, via the spec inventories below. The `mf-name` grammar
     is a bare <ident>, so feature-name typos (`min-widht`) are only
     catchable against a list. `@supports` is exempt from the second layer
     on purpose: probing syntax the compiler doesn't know is the whole
     point of the rule. *)

open Types
module Ast = Styled_ppx_css_parser.Ast

let prelude_grammar_key (name : string) : string option =
  match String.lowercase_ascii name with
  | "media" -> Some "media-query-list"
  | "supports" -> Some "supports-condition"
  | "container" -> Some "container-condition-list"
  | _ -> None

(* Media Queries 3/4/5 feature inventory. Range-type features also accept
   their legacy `min-`/`max-` prefixed spellings, derived below. *)
let media_range_features =
  [
    "width";
    "height";
    "aspect-ratio";
    "resolution";
    "color";
    "color-index";
    "monochrome";
    "device-width";
    "device-height";
    "device-aspect-ratio";
    "horizontal-viewport-segments";
    "vertical-viewport-segments";
    (* Firefox's historical spellings are `min--moz-device-pixel-ratio` /
       `max--moz-device-pixel-ratio`, which the min-/max- derivation below
       produces. WebKit's infix spellings are listed explicitly. *)
    "-moz-device-pixel-ratio";
  ]

let media_discrete_features =
  [
    "orientation";
    "grid";
    "scan";
    "update";
    "overflow-block";
    "overflow-inline";
    "color-gamut";
    "dynamic-range";
    "video-dynamic-range";
    "inverted-colors";
    "pointer";
    "hover";
    "any-pointer";
    "any-hover";
    "nav-controls";
    "environment-blending";
    "prefers-reduced-motion";
    "prefers-reduced-transparency";
    "prefers-contrast";
    "forced-colors";
    "prefers-color-scheme";
    "prefers-reduced-data";
    "scripting";
    "display-mode";
    "device-posture";
    "shape";
    "-webkit-transform-3d";
    "-webkit-device-pixel-ratio";
    "-webkit-min-device-pixel-ratio";
    "-webkit-max-device-pixel-ratio";
    "display-state";
    "resizable";
    "ua-color-scheme";
    "video-color-gamut";
  ]

let media_feature_inventory =
  media_range_features
  @ List.concat_map
      (fun name -> [ "min-" ^ name; "max-" ^ name ])
      media_range_features
  @ media_discrete_features

(* Containment 3 size features (style()/scroll-state() queries are function
   blocks and are not name-checked here). *)
let container_feature_inventory =
  [
    "width";
    "height";
    "inline-size";
    "block-size";
    "aspect-ratio";
    "orientation";
  ]

let is_comparison_delim = function
  | Ast.Delimiter_less_than | Delimiter_greater_than | Delimiter_equals
  | Delimiter_gte | Delimiter_lte ->
    true
  | _ -> false

let significant (values : Ast.component_value_list) =
  List.filter
    (fun ((v, _) : _ Ast.with_loc) -> (v : Ast.component_value) <> Whitespace)
    values

(* The three feature shapes of a paren block in a condition. [Opaque] is
   anything else -- nested conditions, style() queries, interpolations. *)
type feature_block =
  | Boolean of string * Ast.loc (* (monochrome) *)
  | Plain of string * Ast.loc * Ast.component_value_list
    (* (min-width: 768px) *)
  | Range of Ast.component_value_list list
    (* (500px <= width <= 700px): the operand segments between comparison
       operators, one of which is the feature name *)
  | Opaque

(* Split a range-form block into its operand segments: everything between
   comparison operators, whitespace already stripped. *)
let split_on_comparisons (values : Ast.component_value_list) :
  Ast.component_value_list list =
  let flush segment segments =
    match segment with [] -> segments | s -> List.rev s :: segments
  in
  let segments, last =
    List.fold_left
      (fun (segments, segment) ((v, _) as value : _ Ast.with_loc) ->
        match (v : Ast.component_value) with
        | Delim d when is_comparison_delim d -> flush segment segments, []
        | _ -> segments, value :: segment)
      ([], []) values
  in
  List.rev (flush last segments)

let classify_block (inner : Ast.component_value_list) : feature_block =
  match significant inner with
  | [ (Ident name, name_loc) ] -> Boolean (name, name_loc)
  | (Ident name, name_loc) :: (Delim Delimiter_colon, _) :: rest ->
    Plain (name, name_loc, rest)
  | inner_values
    when List.exists
           (fun ((v, _) : _ Ast.with_loc) ->
             match (v : Ast.component_value) with
             | Delim d -> is_comparison_delim d
             | _ -> false)
           inner_values ->
    Range (split_on_comparisons inner_values)
  | _ -> Opaque

(* Collect the feature-shaped paren blocks of a condition; opaque blocks
   containing further groups are conditions-in-parens and recurse instead. *)
let rec collect_feature_blocks acc (values : Ast.component_value_list) =
  List.fold_left
    (fun acc ((value, _) : _ Ast.with_loc) ->
      match (value : Ast.component_value) with
      | Paren_block inner ->
        (match classify_block inner with
        | Opaque ->
          let has_nested_group =
            List.exists
              (fun ((v, _) : _ Ast.with_loc) ->
                match (v : Ast.component_value) with
                | Paren_block _ | Function _ -> true
                | _ -> false)
              inner
          in
          if has_nested_group then collect_feature_blocks acc inner else acc
        | classified -> classified :: acc)
      | _ -> acc)
    acc values

(* Validate one feature value against the feature's registered grammar
   (keyed `media-<name>`; @container size features share the namespace).
   Values nesting functions (`calc()`, `env()`) skip value validation: the
   feature grammars only model literal values. Features without a grammar
   stay name-checked only. *)
let validate_feature_value ~at_rule_name ~name ~error_loc
  (value : Ast.component_value_list) :
  (unit, Ast.loc * [> `Invalid_prelude of string ]) result =
  let has_function =
    List.exists
      (fun ((v, _) : _ Ast.with_loc) ->
        match (v : Ast.component_value) with Function _ -> true | _ -> false)
      value
  in
  if has_function then Ok ()
  else (
    match
      Registry.find_by_key ("property_media-" ^ String.lowercase_ascii name)
    with
    | Some (Pack_rule { validate; _ }) ->
      (match validate value with
      | Ok () -> Ok ()
      | Error error_info ->
        Error
          ( error_loc,
            `Invalid_prelude
              (Printf.sprintf "Invalid value for @%s feature '%s', %s"
                 at_rule_name name
                 (Rule.format_error_info error_info)) ))
    | None -> Ok ())

let validate_feature_names ~at_rule_name ~inventory
  (prelude : Ast.component_value_list) :
  (unit, Ast.loc * [> `Invalid_prelude of string ]) result =
  let known name = List.mem (String.lowercase_ascii name) inventory in
  let unknown_error name loc =
    let msg =
      match Levenshtein.find_closest_match name inventory with
      | Some suggestion ->
        Printf.sprintf "Unknown @%s feature '%s'. Did you mean '%s'?"
          at_rule_name name suggestion
      | None -> Printf.sprintf "Unknown @%s feature '%s'" at_rule_name name
    in
    Error (loc, `Invalid_prelude msg)
  in
  let check = function
    | Boolean (name, name_loc) ->
      if known name then Ok () else unknown_error name name_loc
    | Plain (name, name_loc, value) ->
      if not (known name) then unknown_error name name_loc
      else validate_feature_value ~at_rule_name ~name ~error_loc:name_loc value
    | Range segments ->
      (* A segment that is exactly one known ident is the feature name;
         the remaining segments are its comparison operands and validate
         against the same grammar as colon-form values. *)
      let feature_of segment =
        match (segment : Ast.component_value_list) with
        | [ (Ident name, loc) ] when known name -> Some (name, loc)
        | _ -> None
      in
      (match List.filter_map feature_of segments with
      | [ (name, _) ] ->
        List.fold_left
          (fun acc segment ->
            match acc, feature_of segment, segment with
            | Ok (), None, (_, error_loc) :: _ ->
              validate_feature_value ~at_rule_name ~name ~error_loc segment
            | acc, _, _ -> acc)
          (Ok ()) segments
      | _ :: _ ->
        (* Several known names ((width < height)): structure checked only. *)
        Ok ()
      | [] ->
        (* No identifiable feature: keep the historical name check over the
           bare idents. *)
        let idents =
          List.concat segments
          |> List.filter_map (fun ((v, loc) : _ Ast.with_loc) ->
            match (v : Ast.component_value) with
            | Ident name -> Some (name, loc)
            | _ -> None)
        in
        (match idents with
        | [] -> Ok ()
        | idents when List.exists (fun (name, _) -> known name) idents -> Ok ()
        | (name, loc) :: _ -> unknown_error name loc))
    | Opaque -> Ok ()
  in
  collect_feature_blocks [] prelude
  |> List.fold_left
       (fun acc block -> match acc with Ok () -> check block | e -> e)
       (Ok ())

let validate_at_rule_prelude ~loc ~name (prelude : Ast.component_value_list) :
  ( unit,
    Ast.loc
    * [> `Invalid_value of Rule.error_info | `Invalid_prelude of string ] )
  result
  option =
  match prelude_grammar_key name with
  | None -> None
  | Some key ->
    (match Registry.find_by_key key with
    | None -> None
    | Some (Pack_rule { validate; _ }) ->
      (match validate prelude with
      | Error error_info -> Some (Error (loc, `Invalid_value error_info))
      | Ok () ->
        (match String.lowercase_ascii name with
        | "media" ->
          Some
            (validate_feature_names ~at_rule_name:name
               ~inventory:media_feature_inventory prelude)
        | "container" ->
          Some
            (validate_feature_names ~at_rule_name:name
               ~inventory:container_feature_inventory prelude)
        | _ -> Some (Ok ()))))
