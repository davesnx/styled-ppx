(* Implementation of stylis autoprefixer https://github.com/thysultan/stylis *)
(* This autoprefix works with ">1%, last 4 versions, Firefox ESR, not ie < 9, not dead" from browserlist and not so precise as stylis implementation *)

module Core = Css_native.Css_Legacy_Core

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
         | "mask-repeat" | "mask-origin" | "mask-position" | "mask-composite" )
        as property),
        value )
  | D
      ( (( "column-count" | "column-fill" | "column-gap" | "column-rule"
         | "column-rule-color" | "column-rule-style" | "column-rule-width"
         | "column-span" | "column-width" ) as property),
        value )
  | D (("background-clip" as property), value)
  | D
      ( (( "margin-inline-end" | "margin-inline-start" | "padding-inline-start"
         | "padding-inline-end" ) as property),
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
