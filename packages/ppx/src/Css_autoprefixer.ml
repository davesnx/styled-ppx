open Styled_ppx_css_parser.Ast

let webkit value = "-webkit-" ^ value
let moz value = "-moz-" ^ value
let ms value = "-ms-" ^ value
let o value = "-o-" ^ value

let prefixed_property (decl : declaration) property =
  { decl with name = property, snd decl.name }

let prefixed_value (decl : declaration) value =
  let value_loc = snd decl.value in
  { decl with value = [ Ident value, value_loc ], value_loc }

let prefix_property decl prefixes =
  prefixes
  |> List.map (fun prefixer ->
    prefixed_property decl (prefixer (fst decl.name)))

let prefix_value decl value prefixes =
  prefixes |> List.map (fun prefixer -> prefixed_value decl (prefixer value))

let rendered_value (decl : declaration) =
  decl.value
  |> fst
  |> Styled_ppx_css_parser.Render.strip_leading_whitespace
  |> Styled_ppx_css_parser.Render.component_value_list

let prefix_declaration (decl : declaration) =
  let property = fst decl.name in
  let value = rendered_value decl in

  let prefixed =
    match property with
    | "animation" | "animation-name" | "animation-duration" | "animation-delay"
    | "animation-direction" | "animation-fill-mode"
    | "animation-iteration-count" | "animation-play-state"
    | "animation-timing-function" | "text-decoration" | "filter" | "clip-path"
    | "backface-visibility" | "backdrop-filter" | "column"
    | "box-decoration-break" | "mask" | "mask-image" | "mask-mode" | "mask-clip"
    | "mask-size" | "mask-repeat" | "mask-origin" | "mask-position"
    | "mask-composite" | "column-count" | "column-fill" | "column-gap"
    | "column-rule" | "column-rule-color" | "column-rule-style"
    | "column-rule-width" | "column-span" | "column-width" | "background-clip"
    | "margin-inline-end" | "margin-inline-start" | "padding-inline-start"
    | "padding-inline-end" | "columns" ->
      prefix_property decl [ webkit ]
    | "user-select" | "appearance" | "transform" | "hyphens"
    | "text-size-adjust" ->
      prefix_property decl [ webkit; moz; ms ]
    | "grid-row" | "grid-column" -> prefix_property decl [ ms ]
    | "flex" | "flex-direction" | "scroll-snap-type" | "writing-mode" ->
      prefix_property decl [ webkit; ms ]
    | "tab-size" -> prefix_property decl [ moz; o ]
    | "color-adjust" | "print-color-adjust" ->
      [ prefixed_property decl (webkit "print-color-adjust") ]
    | "cursor" when value = "grab" || value = "grabbing" ->
      prefix_value decl value [ webkit ]
    | "width" | "min-width" | "max-width" | "height" | "min-height"
    | "max-height" | "min-block-size" | "max-block-size"
      when value = "fit-content"
           || value = "max-content"
           || value = "min-content"
           || value = "fill-available" ->
      prefix_value decl value [ webkit; moz ]
    | "width" | "min-width" | "max-width" | "height" | "min-height"
    | "max-height"
      when value = "stretch" ->
      prefix_value decl "fill-available" [ webkit ]
      @ prefix_value decl "available" [ moz ]
    | _ -> []
  in

  prefixed @ [ decl ]

let rec prefix_rule rule =
  match rule with
  | Declaration decl ->
    prefix_declaration decl |> List.map (fun decl -> Declaration decl)
  | Style_rule style_rule ->
    [ Style_rule { style_rule with block = prefix_rule_list style_rule.block } ]
  | At_rule at_rule ->
    [ At_rule { at_rule with block = prefix_block at_rule.block } ]

and prefix_rule_list (rules, loc) = List.concat_map prefix_rule rules, loc

and prefix_block block =
  match block with
  | Empty -> Empty
  | Rule_list rules -> Rule_list (prefix_rule_list rules)
  | Stylesheet rules -> Stylesheet (prefix_rule_list rules)

let render_rule rule =
  prefix_rule rule
  |> List.map Styled_ppx_css_parser.Render.rule
  |> String.concat ""
