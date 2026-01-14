type margin_value =
  [ `Length of Standard.length
  | `Percentage of Standard.percentage
  | `Auto
  ]

type margin = margin_value list

let margin : margin Spec.t = [%spec "[ <length> | <percentage> | 'auto' ]{1,4}"]

type padding_value =
  [ `Length of Standard.length
  | `Percentage of Standard.percentage
  ]

type padding = padding_value list

let padding : padding Spec.t = [%spec "[ <length> | <percentage> ]{1,4}"]

type position =
  [ `Static
  | `Relative
  | `Absolute
  | `Fixed
  | `Sticky
  ]

let position : position Spec.t =
  [%spec "'static' | 'relative' | 'absolute' | 'fixed' | 'sticky'"]

type line_height =
  [ `Normal
  | `Number of Standard.number
  | `Length of Standard.length
  | `Percentage of Standard.percentage
  ]

let line_height : line_height Spec.t =
  [%spec "'normal' | <number> | <length> | <percentage>"]

type color =
  [ `Hex_color of string
  | `CurrentColor
  | `Transparent
  ]

let color : color Spec.t =
  [%spec "<hex-color> | 'currentColor' | 'transparent'"]

let background_color = color
