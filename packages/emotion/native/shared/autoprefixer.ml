(* Implementation of stylis autoprefixer https://github.com/thysultan/stylis *)
(* This autoprefix works with ">1%, last 4 versions, Firefox ESR, not ie < 9, not dead" from browserlist and not so precise as stylis implementation *)

let webkit property = Printf.sprintf "-webkit-%s" property
let moz property = Printf.sprintf "-moz-%s" property
let ms property = Printf.sprintf "-ms-%s" property
let o property = Printf.sprintf "-o-%s" property
let khtml property = Printf.sprintf "-khtml-%s" property

let prefix_property (property : string) (value : string) prefixes =
  prefixes
  |> List.map (fun prefixer -> Rule.Declaration (prefixer property, value))

let prefix_value (property : string) (value : string) prefixes =
  prefixes
  |> List.map (fun prefixer -> Rule.Declaration (property, prefixer value))

let prefix (rule : Rule.t) : Rule.t list =
  match rule with
  | Declaration
      ( (( "animation" | "animation-name" | "animation-duration"
         | "animation-delay" | "animation-direction" | "animation-fill-mode"
         | "animation-iteration-count" | "animation-play-state"
         | "animation-timing-function" ) as property),
        value )
  | Declaration (("text-decoration" as property), value)
  | Declaration (("filter" as property), value)
  | Declaration (("clip-path" as property), value)
  | Declaration (("backface-visibility" as property), value)
  | Declaration (("column" as property), value)
  | Declaration (("box-decoration-break" as property), value)
  | Declaration
      ( (( "mask" | "mask-image" | "mask-mode" | "mask-clip" | "mask-size"
         | "mask-repeat" | "mask-origin" | "mask-position" | "mask-composite" )
        as property),
        value )
  | Declaration
      ( (( "column-count" | "column-fill" | "column-gap" | "column-rule"
         | "column-rule-color" | "column-rule-style" | "column-rule-width"
         | "column-span" | "column-width" ) as property),
        value )
  | Declaration (("background-clip" as property), value)
  | Declaration
      ( (( "margin-inline-end" | "margin-inline-start" | "padding-inline-start"
         | "padding-inline-end" ) as property),
        value )
  | Declaration (("columns" as property), value) ->
      prefix_property property value [ webkit ] @ [ rule ]
  | Declaration (("user-select" as property), value)
  | Declaration (("appearance" as property), value)
  | Declaration (("transform" as property), value)
  | Declaration (("hyphens" as property), value)
  | Declaration (("text-size-adjust" as property), value) ->
      prefix_property property value [ webkit; moz; ms ] @ [ rule ]
  | Declaration ((("grid-row" | "grid-column") as property), value) ->
      prefix_property property value [ ms ] @ [ rule ]
  | Declaration (("flex" as property), value)
  | Declaration (("flex-direction" as property), value)
  | Declaration (("scroll-snap-type" as property), value)
  | Declaration (("writing-mode" as property), value) ->
      prefix_property property value [ webkit; ms ] @ [ rule ]
  | Declaration (("tab-size" as property), value) ->
      prefix_property property value [ moz; o ] @ [ rule ]
  | Declaration ("color-adjust", value) ->
      prefix_property "print-color-adjust" value [ webkit ] @ [ rule ]
  | Declaration
      ( (( "align-items" | "align-content" | "flex-shrink" | "flex-basis"
         | "align-self" | "flex-grow" | "justify-content" ) as _property),
        _value ) ->
      [ rule ]
  | Declaration (("cursor" as property), (("grab" | "grabbing") as value)) ->
      prefix_value property value [ webkit ] @ [ rule ]
  | Declaration
      ( (( "width" | "min-width" | "max-width" | "height" | "min-height"
         | "max-height" | "min-block-size" | "max-block-size" ) as property),
        (("fit-content" | "max-content" | "min-content" | "fill-available") as
        value) ) ->
      prefix_value property value [ webkit; moz ] @ [ rule ]
  | Declaration
      ( (( "width" | "min-width" | "max-width" | "height" | "min-height"
         | "max-height" ) as property),
        "stretch" ) ->
      prefix_value property "fill-available" [ webkit ]
      @ prefix_value property "available" [ moz ]
      @ [ rule ]
  (* TODO: Add -webkit-image-set on "background" | "background-image" image-set *)
  | _ -> [ rule ]
