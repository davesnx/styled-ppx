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
  decl.value |> fst |> Styled_ppx_css_parser.Render.component_value_list

let prefix_declaration (decl : declaration) =
  let property = fst decl.name in
  let value = rendered_value decl in

  let prefixed =
    match property with
    | "animation" | "animation-name" | "animation-duration" | "animation-delay"
    | "animation-direction" | "animation-fill-mode"
    | "animation-iteration-count" | "animation-play-state"
    | "animation-timing-function" | "text-decoration" | "filter" | "clip-path"
    | "backface-visibility" | "backdrop-filter" | "box-decoration-break"
    | "mask" | "mask-image" | "mask-clip" | "mask-size" | "mask-repeat"
    | "mask-origin" | "mask-position" | "column-count" | "column-fill"
    | "column-gap" | "column-rule" | "column-rule-color" | "column-rule-style"
    | "column-rule-width" | "column-span" | "column-width" | "background-clip"
    | "columns" ->
      prefix_property decl [ webkit ]
    (* Old WebKit's logical-margin/padding properties drop "inline" from the
       name entirely (`-webkit-margin-start`, not `-webkit-margin-inline-start`);
       a plain prefix rename would mint a property no browser ever read. *)
    | "margin-inline-end" -> [ prefixed_property decl (webkit "margin-end") ]
    | "margin-inline-start" ->
      [ prefixed_property decl (webkit "margin-start") ]
    | "padding-inline-end" -> [ prefixed_property decl (webkit "padding-end") ]
    | "padding-inline-start" ->
      [ prefixed_property decl (webkit "padding-start") ]
    | "user-select" -> prefix_property decl [ webkit; moz; ms ]
    (* No browser ever shipped -ms-appearance or -ms-text-size-adjust. *)
    | "appearance" | "text-size-adjust" -> prefix_property decl [ webkit; moz ]
    | "transform" | "hyphens" -> prefix_property decl [ webkit; moz; ms ]
    | "flex" | "flex-direction" -> prefix_property decl [ webkit; ms ]
    (* -ms-writing-mode exists but reads its own value set (`lr-tb`, `tb-rl`,
       ...) instead of `horizontal-tb`/`vertical-rl`; emitting it with the
       modern value verbatim would just be a silently-ignored declaration. *)
    | "writing-mode" -> prefix_property decl [ webkit ]
    | "tab-size" -> prefix_property decl [ moz; o ]
    | "color-adjust" | "print-color-adjust" ->
      [ prefixed_property decl (webkit "print-color-adjust") ]
    | "cursor" when value = "grab" || value = "grabbing" ->
      prefix_value decl value [ webkit ]
    | "width" | "min-width" | "max-width" | "height" | "min-height"
    | "max-height" | "min-block-size" | "max-block-size"
      when value = "fit-content" || value = "max-content" ->
      prefix_value decl value [ webkit; moz ]
    (* -webkit-min-content never existed (old WebKit's alias was the
       unrelated, unprefixed keyword `min-intrinsic`); only Firefox needed a
       prefix for `min-content`. *)
    | "width" | "min-width" | "max-width" | "height" | "min-height"
    | "max-height" | "min-block-size" | "max-block-size"
      when value = "min-content" ->
      prefix_value decl value [ moz ]
    (* `fill-available` (accepted directly by min-width/max-width) and the
       modern `stretch` keyword both render the same way: WebKit kept the
       spec's old full name, Firefox dropped "fill-" from it. *)
    | "width" | "min-width" | "max-width" | "height" | "min-height"
    | "max-height" | "min-block-size" | "max-block-size"
      when value = "fill-available" || value = "stretch" ->
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
