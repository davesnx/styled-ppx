module Ast = Styled_ppx_css_parser.Ast
module Render = Styled_ppx_css_parser.Render

type context = {
  at_rules : (string * string) list;
  selector : string;
}

type property =
  | Named of string
  | All

type covered =
  | Leaves of string list
  | Everything

type t = {
  context : context;
  property : property;
  covered : covered;
  important : bool;
}

let is_custom_property name =
  String.length name >= 2 && name.[0] = '-' && name.[1] = '-'

let normalize_property name =
  if is_custom_property name then name else String.lowercase_ascii name

(* Direct shorthand -> immediate-children edges only. A child that is
   itself a shorthand (e.g. "border" -> "border-width") is expanded by
   {!leaves_of}, not flattened here - that is what keeps nested shorthands
   (border -> border-top -> border-top-width) correct without a
   hand-maintained flat list. Cite: CSS Box Model L3 (margin/padding/inset),
   CSS Backgrounds and Borders L3/4 (border/background/radius/image), CSS
   Fonts L3 (font), CSS Basic UI L3 (outline), CSS Lists L3 (list-style),
   CSS Text Decoration L3, CSS Transitions L1, CSS Animations L1, CSS Grid
   Layout L1/L2, CSS Flexible Box Layout L1, CSS Box Alignment L3
   (place-content/place-items/place-self), CSS Overflow L3, CSS Logical
   Properties and Values L1
   (inset-*/margin-block/margin-inline/padding-block/padding-inline;
   border-block/border-inline stop at the two logical sides deliberately -
   see the module doc note below).

   How this stays current: a newly-added CSS shorthand needs one entry
   here (its own direct children, from the spec that defines it); nothing
   else in this module changes. A shorthand this table does not know about
   falls through {!leaves_of} as a plain leaf (itself), which is always
   safe (never wrongly claims to cover properties it does not) even if
   it's under-informative (never lets it remove or be removed by its own
   real longhands) until someone adds it. *)
let direct_children : (string, string list) Hashtbl.t =
  let table = Hashtbl.create 64 in
  let add shorthand children = Hashtbl.replace table shorthand children in
  add "margin" [ "margin-top"; "margin-right"; "margin-bottom"; "margin-left" ];
  add "padding"
    [ "padding-top"; "padding-right"; "padding-bottom"; "padding-left" ];
  add "margin-block" [ "margin-block-start"; "margin-block-end" ];
  add "margin-inline" [ "margin-inline-start"; "margin-inline-end" ];
  add "padding-block" [ "padding-block-start"; "padding-block-end" ];
  add "padding-inline" [ "padding-inline-start"; "padding-inline-end" ];
  add "inset" [ "top"; "right"; "bottom"; "left" ];
  add "inset-block" [ "inset-block-start"; "inset-block-end" ];
  add "inset-inline" [ "inset-inline-start"; "inset-inline-end" ];
  (* Deliberately not decomposed to -width/-style/-color, unlike the
     physical border-* family below: no live conflict has justified the
     extra table size yet. Add if one turns up. *)
  add "border-block" [ "border-block-start"; "border-block-end" ];
  add "border-inline" [ "border-inline-start"; "border-inline-end" ];
  add "border-width"
    [
      "border-top-width";
      "border-right-width";
      "border-bottom-width";
      "border-left-width";
    ];
  add "border-style"
    [
      "border-top-style";
      "border-right-style";
      "border-bottom-style";
      "border-left-style";
    ];
  add "border-color"
    [
      "border-top-color";
      "border-right-color";
      "border-bottom-color";
      "border-left-color";
    ];
  add "border-top"
    [ "border-top-width"; "border-top-style"; "border-top-color" ];
  add "border-right"
    [ "border-right-width"; "border-right-style"; "border-right-color" ];
  add "border-bottom"
    [ "border-bottom-width"; "border-bottom-style"; "border-bottom-color" ];
  add "border-left"
    [ "border-left-width"; "border-left-style"; "border-left-color" ];
  add "border" [ "border-width"; "border-style"; "border-color" ];
  add "border-radius"
    [
      "border-top-left-radius";
      "border-top-right-radius";
      "border-bottom-right-radius";
      "border-bottom-left-radius";
    ];
  add "border-image"
    [
      "border-image-source";
      "border-image-slice";
      "border-image-width";
      "border-image-outset";
      "border-image-repeat";
    ];
  add "outline" [ "outline-color"; "outline-style"; "outline-width" ];
  add "background"
    [
      "background-image";
      "background-position";
      "background-size";
      "background-repeat";
      "background-origin";
      "background-clip";
      "background-attachment";
      "background-color";
    ];
  add "font"
    [
      "font-style";
      "font-variant";
      "font-weight";
      "font-stretch";
      "font-size";
      "line-height";
      "font-family";
    ];
  add "list-style"
    [ "list-style-type"; "list-style-position"; "list-style-image" ];
  add "text-decoration"
    [
      "text-decoration-line";
      "text-decoration-style";
      "text-decoration-color";
      "text-decoration-thickness";
    ];
  (* transition/animation cover their own meta-properties only - "transition:
     opacity 200ms" does not make this atom's slot "opacity"; opacity stays
     its own, unrelated slot. See the module doc note below. *)
  add "transition"
    [
      "transition-property";
      "transition-duration";
      "transition-timing-function";
      "transition-delay";
    ];
  add "animation"
    [
      "animation-name";
      "animation-duration";
      "animation-timing-function";
      "animation-delay";
      "animation-iteration-count";
      "animation-direction";
      "animation-fill-mode";
      "animation-play-state";
    ];
  add "grid-template"
    [ "grid-template-rows"; "grid-template-columns"; "grid-template-areas" ];
  add "grid"
    [ "grid-template"; "grid-auto-rows"; "grid-auto-columns"; "grid-auto-flow" ];
  add "grid-row" [ "grid-row-start"; "grid-row-end" ];
  add "grid-column" [ "grid-column-start"; "grid-column-end" ];
  add "grid-area" [ "grid-row"; "grid-column" ];
  add "gap" [ "row-gap"; "column-gap" ];
  add "place-content" [ "align-content"; "justify-content" ];
  add "place-items" [ "align-items"; "justify-items" ];
  add "place-self" [ "align-self"; "justify-self" ];
  add "overflow" [ "overflow-x"; "overflow-y" ];
  add "flex" [ "flex-grow"; "flex-shrink"; "flex-basis" ];
  add "flex-flow" [ "flex-direction"; "flex-wrap" ];
  table

(* Deliberately NOT unified: CSS Logical Properties and Values L1 makes a
   logical property's physical target depend on the element's
   writing-mode/direction at run time (margin-inline-start is margin-left
   in LTR, margin-right in RTL). This module has no access to that at
   compile time, so treating margin-inline-start and margin-left as the
   same leaf would be wrong on every RTL page, not just incomplete. Logical
   properties only expand into their own logical siblings above
   (margin-inline -> margin-inline-start/-end), never into a physical
   property. *)

let rec expand seen property =
  if List.mem property seen then [ property ]
  else (
    match Hashtbl.find_opt direct_children property with
    | None -> [ property ]
    | Some children ->
      children
      |> List.concat_map (expand (property :: seen))
      |> List.sort_uniq String.compare)

let leaves_of property = expand [] property

let excluded_from_all name =
  name = "direction" || name = "unicode-bidi" || is_custom_property name

let context_string { at_rules; selector } =
  let at_rules_part =
    at_rules
    |> List.map (fun (name, prelude) -> Printf.sprintf "@%s\x00%s" name prelude)
    |> String.concat "\x00"
  in
  at_rules_part ^ "\x00" ^ selector

let property_string = function Named p -> p | All -> "all"

let key t =
  Printf.sprintf "slot-%s"
    (Murmur2.default
       (context_string t.context ^ "\x00" ^ property_string t.property))

let covered_keys t =
  match t.covered with
  | Everything -> None
  | Leaves leaves ->
    Some (List.map (fun p -> key { t with property = Named p }) leaves)

(* Walks one atomized rule (Css_file.re's [atomize_rules] output shape:
   a bare Declaration, a same-property Declaration group wrapped in a
   [&]-only Style_rule, a resolved-selector Style_rule, any of those under
   one or more At_rule wrappers) collecting the at-rule chain outer to
   inner, the innermost selector text, and the declaration(s) at the leaf.
   [Render.selector]/[Render.component_value_list] are the same renderers
   [Hash_class] hashes for the class name, so this gets the same whitespace
   and ordering canonicalization for free - no new normalization logic. *)
let rec collect_context (rule : Ast.rule) :
  (string * string) list * string option * Ast.declaration list =
  match rule with
  | Ast.Declaration d -> [], None, [ d ]
  | Ast.Style_rule { prelude = sels, _; block = rules, _; _ } ->
    let sel_text =
      sels |> List.map (fun (s, _) -> Render.selector s) |> String.concat ", "
    in
    (* A bare `&` (the shape a same-property group with no parent selector
       is wrapped in) is the same context as no wrapping at all - both are
       "base", and must compare equal so a plain top-level declaration can
       still be removed by / remove a grouped one. *)
    let selector = if sel_text = "&" then None else Some sel_text in
    let decls =
      List.filter_map (function Ast.Declaration d -> Some d | _ -> None) rules
    in
    [], selector, decls
  | Ast.At_rule { name = name, _; prelude = pre, _; block; _ } ->
    (* Same stripping [Render.at_rule] does before rendering a prelude, so a
       leading-whitespace difference that doesn't change the class-name hash
       doesn't invent a different slot either. *)
    let prelude_text =
      Render.component_value_list (Render.strip_leading_whitespace pre)
    in
    let inner_rules =
      match block with
      | Ast.Rule_list (rules, _) | Ast.Stylesheet (rules, _) -> rules
      | Ast.Empty -> []
    in
    let at_rules, selector, decls =
      match inner_rules with
      | [ inner ] -> collect_context inner
      | _ -> [], None, []
    in
    (String.lowercase_ascii name, prelude_text) :: at_rules, selector, decls

let of_atom (rule : Ast.rule) : t option =
  let at_rules, selector, decls = collect_context rule in
  match decls with
  | [] -> None
  | (first : Ast.declaration) :: _ ->
    let property = normalize_property (fst first.name) in
    (* A group's importance is the importance of any of its members: the
       group is one atom/one class, so dropping it for not being
       "important enough" would drop an important declaration bundled
       inside it along with the rest. *)
    let important =
      List.exists (fun (d : Ast.declaration) -> fst d.important) decls
    in
    let context = { at_rules; selector = Option.value selector ~default:"" } in
    let property_v = if property = "all" then All else Named property in
    let covered =
      match property_v with
      | All -> Everything
      | Named p -> Leaves (leaves_of p)
    in
    Some { context; property = property_v; covered; important }

let context_equal a b = a.at_rules = b.at_rules && a.selector = b.selector

let covered_subset a b =
  match a, b with
  | Leaves xs, Leaves ys -> List.for_all (fun x -> List.mem x ys) xs
  | Leaves xs, Everything ->
    List.for_all (fun x -> not (excluded_from_all x)) xs
  | Everything, Leaves _ -> false
  | Everything, Everything -> true

let removes ~former ~latter =
  context_equal former.context latter.context
  && covered_subset former.covered latter.covered
  && not (former.important && not latter.important)
