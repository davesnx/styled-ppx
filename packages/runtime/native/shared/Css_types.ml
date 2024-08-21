(* TODO: Split Types and Properties from this file, types are (the rest are properties) https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Types *)

module Cascading = struct
  type t =
    [ `initial
    | `inherit_
    | `unset
    | `revert
    | `revertLayer
    ]

  let initial = `initial
  let inherit_ = `inherit_
  let unset = `unset
  let revert = `revert
  let revertLayer = `revertLayer

  let toString (x : t) =
    match x with
    | `initial -> {js|initial|js}
    | `inherit_ -> {js|inherit|js}
    | `unset -> {js|unset|js}
    | `revert -> {js|revert|js}
    | `revertLayer -> {js|revert-layer|js}
end

module None = struct
  type t = [ `none ]

  let none : [> t ] = `none
  let toString = {js|none|js}
end

module Auto = struct
  type t = [ `auto ]

  let auto : [> t ] = `auto
  let toString = {js|auto|js}
end

module Var = struct
  type t =
    [ `var of string
    | `varDefault of string * string
    ]

  let var x = `var x
  let varDefault x default = `varDefault (x, default)

  let prefix x =
    if Kloth.String.starts_with ~prefix:{js|--|js} x then x else {js|--|js} ^ x

  let toString (x : t) =
    match x with
    | `var x -> {js|var(|js} ^ prefix x ^ {js|)|js}
    | `varDefault (x, v) -> {js|var(|js} ^ prefix x ^ {js|,|js} ^ v ^ {js|)|js}
end

module Calc = struct
  (* Since calc is recursive, we need to have some abstract functions to print depending on each type: calc of time, length, angle, etc. *)
  let max_or_min_values fn values =
    Kloth.Array.map_and_join ~sep:{js|, |js}
      ~f:(fun v -> {js| |js} ^ fn v)
      values

  let min_max_num_to_string fn = function
    | `calc (`add (a, b)) ->
      {js|calc(|js} ^ fn a ^ {js| + |js} ^ fn b ^ {js|)|js}
    | `calc (`sub (a, b)) ->
      {js|calc(|js} ^ fn a ^ {js| - |js} ^ fn b ^ {js|)|js}
    | `calc (`mult (a, b)) ->
      {js|calc(|js} ^ fn a ^ {js| * |js} ^ fn b ^ {js|)|js}
    | `calc (`div (a, b)) ->
      {js|calc(|js} ^ fn a ^ {js| / |js} ^ Kloth.Float.to_string b ^ {js|)|js}
    | `calc (`num a) -> {js|calc(|js} ^ Kloth.Float.to_string a ^ {js|)|js}
    | `num n -> Kloth.Float.to_string n
    | `min xs -> {js|min(|js} ^ max_or_min_values fn xs ^ {js|)|js}
    | `max xs -> {js|max(|js} ^ max_or_min_values fn xs ^ {js|)|js}

  let min_max_to_string x =
    let aux fn fn_max_min x' =
      match x' with
      | `add (x, y) -> {js|calc(|js} ^ fn x ^ {js| + |js} ^ fn y ^ {js|)|js}
      | `sub (x, y) -> {js|calc(|js} ^ fn x ^ {js| - |js} ^ fn y ^ {js|)|js}
      | `mult (x, y) -> {js|calc(|js} ^ fn x ^ {js| * |js} ^ fn y ^ {js|)|js}
      | `div (x, y) ->
        {js|calc(|js} ^ fn x ^ {js| / |js} ^ Kloth.Float.to_string y ^ {js|)|js}
      | (`min _ | `max _) as x -> fn_max_min x
    in
    aux x
end

module Time = struct
  type time =
    [ `s of int
    | `ms of int
    ]

  type calc_value =
    [ time
    | `min of t array
    | `max of t array
    | `add of calc_value * calc_value
    | `sub of calc_value * calc_value
    | `mult of calc_value * calc_value
    | `div of calc_value * float
    | (* calc_value can be a nested `calc.
         Ej. width: calc(100vh - calc(2rem + 120px))) *)
      `calc of
      calc_value
    | (* `num is used to represent a number in a calc expression, necessary for mult and div *)
      `num of
      float
    ]

  and t =
    [ time
    | `calc of calc_value
    | `min of t array
    | `max of t array
    ]

  let s x = `s x
  let ms x = `ms x

  let rec toString (x : t) =
    match x with
    | `s t -> Kloth.Int.to_string t ^ {js|s|js}
    | `ms t -> Kloth.Int.to_string t ^ {js|ms|js}
    | `calc calc -> calc_value_to_string calc
    | (`min _ | `max _) as x -> minmax_to_string x

  and minmax_to_string = function
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      Calc.min_max_num_to_string toString x
    | #time as t -> toString t

  and calc_value_to_string x =
    match x with
    | `num x -> Kloth.Float.to_string x
    | `calc calc -> calc_value_to_string calc
    | (`add _ | `sub _ | `mult _ | `div _ | `min _ | `max _) as x ->
      Calc.min_max_to_string calc_value_to_string minmax_to_string x
    | #time as t -> toString t
end

module Percentage = struct
  type t = [ `percent of float ]

  let pct x : [> t ] = `percent x

  let toString (x : t) =
    match x with `percent x -> Kloth.Float.to_string x ^ {js|%|js}
end

module Url = struct
  type t = [ `url of string ]

  let toString (x : t) = match x with `url s -> ({js|url(|js} ^ s) ^ {js|)|js}
end

module Length = struct
  type length =
    [ `ch of float
    | `cqw of float
    | `cqh of float
    | `cqi of float
    | `cqb of float
    | `cqmin of float
    | `cqmax of float
    | `em of float
    | `ex of float
    | `rem of float
    | `vh of float
    | `vw of float
    | `vmin of float
    | `vmax of float
    | `px of int
    | `pxFloat of float
    | `cm of float
    | `mm of float
    | `inch of float
    | `pc of float
    | `pt of int
    | `zero
    | Percentage.t
    ]

  type calc_value =
    [ length
    | `min of t array
    | `max of t array
    | `add of calc_value * calc_value
    | `sub of calc_value * calc_value
    | `mult of calc_value * calc_value
    | `div of calc_value * float
    | (* calc_value can be a nested `calc.
         Ej. width: calc(100vh - calc(2rem + 120px))) *)
      `calc of
      calc_value
    | (* `num is used to represent a number in a calc expression, necessary for mult and div *)
      `num of
      float
    ]

  and t =
    [ length
    | `calc of calc_value
    | `min of t array
    | `max of t array
    ]

  let ch x : [> t ] = `ch x
  let cqw x : [> t ] = `cqw x
  let cqh x : [> t ] = `cqh x
  let cqi x : [> t ] = `cqi x
  let cqb x : [> t ] = `cqb x
  let cqmin x : [> t ] = `cqmin x
  let cqmax x : [> t ] = `cqmax x
  let em x : [> t ] = `em x
  let ex x : [> t ] = `ex x
  let rem x : [> t ] = `rem x
  let vh x : [> t ] = `vh x
  let vw x : [> t ] = `vw x
  let vmin x : [> t ] = `vmin x
  let vmax x : [> t ] = `vmax x
  let px x : [> t ] = `px x
  let pxFloat x : [> t ] = `pxFloat x
  let cm x : [> t ] = `cm x
  let mm x : [> t ] = `mm x
  let inch x : [> t ] = `inch x
  let pc x : [> t ] = `pc x
  let pt x : [> t ] = `pt x
  let zero : [> t ] = `zero

  let rec toString (x : t) =
    match x with
    | `ch x -> Kloth.Float.to_string x ^ {js|ch|js}
    | `cqw x -> Kloth.Float.to_string x ^ {js|cqw|js}
    | `cqh x -> Kloth.Float.to_string x ^ {js|cqh|js}
    | `cqi x -> Kloth.Float.to_string x ^ {js|cqi|js}
    | `cqb x -> Kloth.Float.to_string x ^ {js|cqb|js}
    | `cqmin x -> Kloth.Float.to_string x ^ {js|cqmin|js}
    | `cqmax x -> Kloth.Float.to_string x ^ {js|cqmax|js}
    | `em x -> Kloth.Float.to_string x ^ {js|em|js}
    | `ex x -> Kloth.Float.to_string x ^ {js|ex|js}
    | `rem x -> Kloth.Float.to_string x ^ {js|rem|js}
    | `vh x -> Kloth.Float.to_string x ^ {js|vh|js}
    | `vw x -> Kloth.Float.to_string x ^ {js|vw|js}
    | `vmin x -> Kloth.Float.to_string x ^ {js|vmin|js}
    | `vmax x -> Kloth.Float.to_string x ^ {js|vmax|js}
    | `px x -> Kloth.Int.to_string x ^ {js|px|js}
    | `pxFloat x -> Kloth.Float.to_string x ^ {js|px|js}
    | `cm x -> Kloth.Float.to_string x ^ {js|cm|js}
    | `mm x -> Kloth.Float.to_string x ^ {js|mm|js}
    | `inch x -> Kloth.Float.to_string x ^ {js|in|js}
    | `pc x -> Kloth.Float.to_string x ^ {js|pc|js}
    | `pt x -> Kloth.Int.to_string x ^ {js|pt|js}
    | `zero -> {js|0|js}
    | #Percentage.t as p -> Percentage.toString p
    | `calc calc -> calc_value_to_string calc
    | (`min _ | `max _) as x -> minmax_to_string x

  and calc_value_to_string x =
    match x with
    | #length as t -> toString t
    | `num x -> Kloth.Float.to_string x
    | `calc calc -> calc_value_to_string calc
    | (`min _ | `max _) as x -> minmax_to_string x
    | (`add _ | `sub _ | `mult _ | `div _) as x ->
      Calc.min_max_to_string calc_value_to_string minmax_to_string x

  and minmax_to_string = function
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      Calc.min_max_num_to_string toString x
    | #length as l -> toString l
end

module Angle = struct
  type t =
    [ `deg of float
    | `rad of float
    | `grad of float
    | `turn of float
    ]

  let deg x : [> t ] = `deg x
  let rad x : [> t ] = `rad x
  let grad x : [> t ] = `grad x
  let turn x : [> t ] = `turn x

  let toString (x : t) =
    match x with
    | `deg x -> Kloth.Float.to_string x ^ {js|deg|js}
    | `rad x -> Kloth.Float.to_string x ^ {js|rad|js}
    | `grad x -> Kloth.Float.to_string x ^ {js|grad|js}
    | `turn x -> Kloth.Float.to_string x ^ {js|turn|js}
end

module Direction = struct
  type t =
    [ `ltr
    | `rtl
    | Var.t
    | Cascading.t
    ]

  let ltr : [> t ] = `ltr
  let rtl : [> t ] = `rtl

  let toString (x : t) =
    match x with
    | `ltr -> {js|ltr|js}
    | `rtl -> {js|rtl|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Don't confuse with Position (from object-position or background-position) *)
module PropertyPosition = struct
  type t =
    [ `absolute
    | `relative
    | `static
    | `fixed
    | `sticky
    | Var.t
    | Cascading.t
    ]

  let absolute : [> t ] = `absolute
  let relative : [> t ] = `relative
  let static : [> t ] = `static
  let fixed : [> t ] = `fixed
  let sticky : [> t ] = `sticky

  let toString (x : t) =
    match x with
    | `absolute -> {js|absolute|js}
    | `relative -> {js|relative|js}
    | `static -> {js|static|js}
    | `fixed -> {js|fixed|js}
    | `sticky -> {js|sticky|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Isolation = struct
  type t =
    [ Auto.t
    | `isolate
    ]

  let isolate : [> t ] = `isolate

  let toString (x : t) =
    match x with #Auto.t -> Auto.toString | `isolate -> {js|isolate|js}
end

module AspectRatio = struct
  type t =
    [ Auto.t
    | `num of float
    | `ratio of int * int
    | Var.t
    | Cascading.t
    ]

  let ratio x y : [> t ] = `ratio (x, y)

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `num num -> Kloth.Float.to_string num
    | `ratio (up, down) ->
      Kloth.Int.to_string up ^ {js| / |js} ^ Kloth.Int.to_string down
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Resize = struct
  type t =
    [ None.t
    | `both
    | `horizontal
    | `vertical
    | `block
    | `inline
    | Var.t
    | Cascading.t
    ]

  let both = `both
  let horizontal = `horizontal
  let vertical = `vertical
  let block = `block
  let inline = `inline

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `both -> {js|both|js}
    | `horizontal -> {js|horizontal|js}
    | `vertical -> {js|vertical|js}
    | `block -> {js|block|js}
    | `inline -> {js|inline|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariant = struct
  type t =
    [ `normal
    | `smallCaps
    | Var.t
    | Cascading.t
    ]

  let normal = `normal
  let smallCaps = `smallCaps

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `smallCaps -> {js|smallCaps|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontStyle = struct
  type t =
    [ `normal
    | `italic
    | `oblique
    | Var.t
    | Cascading.t
    ]

  let normal = `normal
  let italic = `italic
  let oblique = `oblique

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `italic -> {js|italic|js}
    | `oblique -> {js|oblique|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TabSize = struct
  type t =
    [ `num of float
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `num n -> Kloth.Float.to_string n
    | #Length.t as len -> Length.toString len
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FlexBasis = struct
  type t =
    [ Auto.t
    | `fill
    | `content
    | `maxContent
    | `minContent
    | `fitContent
    ]

  let fill = `fill
  let content_ = `content
  let maxContent = `maxContent
  let minContent = `minContent
  let fitContent = `fitContent

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `fill -> {js|fill|js}
    | `content -> {js|content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
    | `fitContent -> {js|fit-content|js}
end

module Overflow = struct
  type t =
    [ `hidden
    | `visible
    | `scroll
    | Auto.t
    | `clip
    ]

  let hidden = `hidden
  let visible = `visible
  let scroll = `scroll
  let auto = `auto
  let clip = `clip

  let toString (x : t) =
    match x with
    | `hidden -> {js|hidden|js}
    | `visible -> {js|visible|js}
    | `scroll -> {js|scroll|js}
    | #Auto.t -> Auto.toString
    | `clip -> {js|clip|js}
end

module Margin = struct
  type t =
    [ Auto.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module GridAutoFlow = struct
  type t =
    [ `column
    | `row
    | `columnDense
    | `rowDense
    | `dense
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `column -> {js|column|js}
    | `row -> {js|row|js}
    | `columnDense -> {js|column dense|js}
    | `rowDense -> {js|row dense|js}
    | `dense -> {js|dense|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Gap = struct
  type t =
    [ `normal
    | Percentage.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeDashArray = struct
  type t =
    [ Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollBehavior = struct
  type t =
    [ Auto.t
    | `smooth
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `smooth -> {js|smooth|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module OverscrollBehavior = struct
  type t =
    [ Auto.t
    | `contain
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `contain -> {js|contain|js}
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module OverflowAnchor = struct
  type t =
    [ Auto.t
    | None.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Cascading.t as c -> Cascading.toString c
end

module ColumnWidth = struct
  type t =
    [ Auto.t
    | Length.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #Length.t as l -> Length.toString l
end

module VerticalAlign = struct
  type t =
    [ `baseline
    | `sub
    | `super
    | `top
    | `textTop
    | `middle
    | `bottom
    | `textBottom
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `baseline -> {js|baseline|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
    | `top -> {js|top|js}
    | `textTop -> {js|text-top|js}
    | `middle -> {js|middle|js}
    | `bottom -> {js|bottom|js}
    | `textBottom -> {js|text-bottom|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TimingFunction = struct
  type t =
    [ `linear
    | `ease
    | `easeIn
    | `easeOut
    | `easeInOut
    | `stepStart
    | `stepEnd
    | `steps of int * [ `start | `end_ ]
    | `cubicBezier of float * float * float * float
    | `jumpStart
    | `jumpEnd
    | `jumpNone
    | `jumpBoth
    | Var.t
    | Cascading.t
    ]

  let linear = `linear
  let ease = `ease
  let easeIn = `easeIn
  let easeInOut = `easeInOut
  let easeOut = `easeOut
  let stepStart = `stepStart
  let stepEnd = `stepEnd
  let steps i dir = `steps (i, dir)
  let cubicBezier a b c d = `cubicBezier (a, b, c, d)
  let jumpStart = `jumpStart
  let jumpEnd = `jumpEnd
  let jumpNone = `jumpNone
  let jumpBoth = `jumpBoth

  let toString (x : t) =
    match x with
    | `linear -> {js|linear|js}
    | `ease -> {js|ease|js}
    | `easeIn -> {js|ease-in|js}
    | `easeOut -> {js|ease-out|js}
    | `easeInOut -> {js|ease-in-out|js}
    | `stepStart -> {js|step-start|js}
    | `stepEnd -> {js|step-end|js}
    | `steps (i, `start) ->
      ({js|steps(|js} ^ Kloth.Int.to_string i) ^ {js|, start)|js}
    | `steps (i, `end_) ->
      ({js|steps(|js} ^ Kloth.Int.to_string i) ^ {js|, end)|js}
    | `cubicBezier (a, b, c, d) ->
      {js|cubic-bezier(|js}
      ^ Kloth.Float.to_string a
      ^ {js|, |js}
      ^ Kloth.Float.to_string b
      ^ {js|, |js}
      ^ Kloth.Float.to_string c
      ^ {js|, |js}
      ^ Kloth.Float.to_string d
      ^ {js|)|js}
    | `jumpStart -> {js|jump-start|js}
    | `jumpEnd -> {js|jump-end|js}
    | `jumpNone -> {js|jump-none|js}
    | `jumpBoth -> {js|jump-both|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ListStyleType = struct
  type t =
    [ `disc
    | `circle
    | `square
    | `decimal
    | `lowerAlpha
    | `upperAlpha
    | `lowerGreek
    | `lowerLatin
    | `upperLatin
    | `lowerRoman
    | `upperRoman
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `disc -> {js|disc|js}
    | `circle -> {js|circle|js}
    | `square -> {js|square|js}
    | `decimal -> {js|decimal|js}
    | `lowerAlpha -> {js|lower-alpha|js}
    | `upperAlpha -> {js|upper-alpha|js}
    | `lowerGreek -> {js|lower-greek|js}
    | `lowerLatin -> {js|lower-latin|js}
    | `upperLatin -> {js|upper-latin|js}
    | `lowerRoman -> {js|lower-roman|js}
    | `upperRoman -> {js|upper-roman|js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ListStylePosition = struct
  type t =
    [ `inside
    | `outside
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `inside -> {js|inside|js}
    | `outside -> {js|outside|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module OutlineStyle = struct
  type t =
    [ None.t
    | Auto.t
    | `hidden
    | `dotted
    | `dashed
    | `solid
    | `double
    | `groove
    | `ridge
    | `inset
    | `outset
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | `hidden -> {js|hidden|js}
    | `dotted -> {js|dotted|js}
    | `dashed -> {js|dashed|js}
    | `solid -> {js|solid|js}
    | `double -> {js|double|js}
    | `groove -> {js|grove|js}
    | `ridge -> {js|ridge|js}
    | `inset -> {js|inset|js}
    | `outset -> {js|outset|js}
end

module FontWeight = struct
  type t =
    [ `num of int
    | `thin
    | `extraLight
    | `light
    | `normal
    | `medium
    | `semiBold
    | `bold
    | `extraBold
    | `black
    | `lighter
    | `bolder
    | Var.t
    | Cascading.t
    ]

  let thin = `thin
  let extraLight = `extraLight
  let light = `light
  let medium = `medium
  let semiBold = `semiBold
  let bold = `bold
  let extraBold = `extraBold
  let lighter = `lighter
  let bolder = `bolder

  let toString (x : t) =
    match x with
    | `num n -> Kloth.Int.to_string n
    | `thin -> {js|100|js}
    | `extraLight -> {js|200|js}
    | `light -> {js|300|js}
    | `normal -> {js|400|js}
    | `medium -> {js|500|js}
    | `semiBold -> {js|600|js}
    | `bold -> {js|700|js}
    | `extraBold -> {js|800|js}
    | `black -> {js|900|js}
    | `lighter -> {js|lighter|js}
    | `bolder -> {js|bolder|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TransformOrigin = struct
  type t =
    [ Length.t
    | `left
    | `center
    | `right
    | `top
    | `bottom
    ]

  let toString (x : t) =
    match x with
    | `left -> {js|left|js}
    | `center -> {js|center|js}
    | `right -> {js|right|js}
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | #Length.t as x -> Length.toString x
end

module Transform = struct
  type t =
    [ `translate of Length.t * Length.t
    | `translate3d of Length.t * Length.t * Length.t
    | `translateX of Length.t
    | `translateY of Length.t
    | `translateZ of Length.t
    | `scale of float * float
    | `scale3d of float * float * float
    | `scaleX of float
    | `scaleY of float
    | `scaleZ of float
    | `rotate of Angle.t
    | `rotate3d of float * float * float * Angle.t
    | `rotateX of Angle.t
    | `rotateY of Angle.t
    | `rotateZ of Angle.t
    | `skew of Angle.t * Angle.t
    | `skewX of Angle.t
    | `skewY of Angle.t
    | `perspective of int
    | Var.t
    | Cascading.t
    | None.t
    ]

  let translate x y = `translate (x, y)
  let translate3d x y z = `translate3d (x, y, z)
  let translateX x = `translateX x
  let translateY y = `translateY y
  let translateZ z = `translateZ z
  let scale x y = `scale (x, y)
  let scale3d x y z = `scale3d (x, y, z)
  let scaleX x = `scaleX x
  let scaleY x = `scaleY x
  let scaleZ x = `scaleZ x
  let rotate a = `rotate a
  let rotate3d x y z a = `rotate3d (x, y, z, a)
  let rotateX a = `rotateX a
  let rotateY a = `rotateY a
  let rotateZ a = `rotateZ a
  let skew a a' = `skew (a, a')
  let skewX a = `skewX a
  let skewY a = `skewY a

  let string_of_scale x y =
    {js|scale(|js}
    ^ Kloth.Float.to_string x
    ^ {js|, |js}
    ^ Kloth.Float.to_string y
    ^ {js|)|js}

  let string_of_translate3d x y z =
    {js|translate3d(|js}
    ^ Length.toString x
    ^ {js|, |js}
    ^ Length.toString y
    ^ {js|, |js}
    ^ Length.toString z
    ^ {js|)|js}

  let toString (x : t) =
    match x with
    | `translate (x, y) ->
      {js|translate(|js}
      ^ Length.toString x
      ^ {js|, |js}
      ^ Length.toString y
      ^ {js|)|js}
    | `translate3d (x, y, z) -> string_of_translate3d x y z
    | `translateX x -> {js|translateX(|js} ^ Length.toString x ^ {js|)|js}
    | `translateY y -> {js|translateY(|js} ^ Length.toString y ^ {js|)|js}
    | `translateZ z -> {js|translateZ(|js} ^ Length.toString z ^ {js|)|js}
    | `scale (x, y) -> string_of_scale x y
    | `scale3d (x, y, z) ->
      {js|scale3d(|js}
      ^ Kloth.Float.to_string x
      ^ {js|, |js}
      ^ Kloth.Float.to_string y
      ^ {js|, |js}
      ^ Kloth.Float.to_string z
      ^ {js|)|js}
    | `scaleX x -> {js|scaleX(|js} ^ Kloth.Float.to_string x ^ {js|)|js}
    | `scaleY y -> {js|scaleY(|js} ^ Kloth.Float.to_string y ^ {js|)|js}
    | `scaleZ z -> {js|scaleZ(|js} ^ Kloth.Float.to_string z ^ {js|)|js}
    | `rotate a -> {js|rotate(|js} ^ Angle.toString a ^ {js|)|js}
    | `rotate3d (x, y, z, a) ->
      {js|rotate3d(|js}
      ^ Kloth.Float.to_string x
      ^ {js|, |js}
      ^ Kloth.Float.to_string y
      ^ {js|, |js}
      ^ Kloth.Float.to_string z
      ^ {js|, |js}
      ^ Angle.toString a
      ^ {js|)|js}
    | `rotateX a -> {js|rotateX(|js} ^ Angle.toString a ^ {js|)|js}
    | `rotateY a -> {js|rotateY(|js} ^ Angle.toString a ^ {js|)|js}
    | `rotateZ a -> {js|rotateZ(|js} ^ Angle.toString a ^ {js|)|js}
    | `skew (x, y) ->
      {js|skew(|js}
      ^ Angle.toString x
      ^ {js|, |js}
      ^ Angle.toString y
      ^ {js|)|js}
    | `skewX a -> {js|skewX(|js} ^ Angle.toString a ^ {js|)|js}
    | `skewY a -> {js|skewY(|js} ^ Angle.toString a ^ {js|)|js}
    | `perspective x -> {js|perspective(|js} ^ Kloth.Int.to_string x ^ {js|)|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
end

module AnimationName : sig
  type t

  val make : string -> t
  val toString : t -> string
end = struct
  type t = string

  let make x = x
  let toString (x : t) = x
end

module AnimationDirection = struct
  type t =
    [ `normal
    | `reverse
    | `alternate
    | `alternateReverse
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `reverse -> {js|reverse|js}
    | `alternate -> {js|alternate|js}
    | `alternateReverse -> {js|alternate-reverse|js}
end

module AnimationFillMode = struct
  type t =
    [ None.t
    | `forwards
    | `backwards
    | `both
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `forwards -> {js|forwards|js}
    | `backwards -> {js|backwards|js}
    | `both -> {js|both|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationIterationCount = struct
  type t =
    [ `count of float
    | `infinite
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `count x -> Kloth.Float.to_string x
    | `infinite -> {js|infinite|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationPlayState = struct
  type t =
    [ `paused
    | `running
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `paused -> {js|paused|js}
    | `running -> {js|running|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module SingleTransitionProperty = struct
  type t =
    [ `all
    | `ident of string
    ]

  let toString (x : t) = match x with `all -> {js|all|js} | `ident x -> x
end

module TransitionProperty = struct
  type t =
    [ None.t
    | SingleTransitionProperty.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #SingleTransitionProperty.t as x -> SingleTransitionProperty.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module Transition = struct
  type transitionValue = {
    duration : Time.t;
    delay : Time.t;
    timingFunction : TimingFunction.t;
    property : [ SingleTransitionProperty.t | None.t ];
  }

  type t =
    [ `value of transitionValue
    | None.t
    ]

  let make ?(duration = `ms 0) ?(delay = `ms 0) ?(timingFunction = `ease)
    ?(property = `all) () : t =
    `value { duration; delay; timingFunction; property }

  let toString (x : t) =
    match x with
    | `value v ->
      Time.toString v.duration
      ^ {js| |js}
      ^ TimingFunction.toString v.timingFunction
      ^ {js| |js}
      ^ Time.toString v.delay
      ^ {js| |js}
      ^
      (match v.property with
      | #SingleTransitionProperty.t as x -> SingleTransitionProperty.toString x
      | #None.t -> None.toString)
    | #None.t -> None.toString
end

module Animation = struct
  type animationValue = {
    duration : Time.t;
    delay : Time.t;
    direction : AnimationDirection.t;
    timingFunction : TimingFunction.t;
    fillMode : AnimationFillMode.t;
    playState : AnimationPlayState.t;
    iterationCount : AnimationIterationCount.t;
    name : AnimationName.t;
  }

  type t =
    [ None.t
    | `value of animationValue
    | Var.t
    | Cascading.t
    ]

  let make ?(duration = `ms 0) ?(delay = `ms 0) ?(direction = `normal)
    ?(timingFunction = `ease) ?(fillMode = `none) ?(playState = `running)
    ?(iterationCount = `count 1.) ?(name = AnimationName.make "none") () =
    `value
      {
        duration;
        delay;
        direction;
        timingFunction;
        fillMode;
        playState;
        iterationCount;
        name;
      }

  let toString (x : t) =
    match x with
    | `value v ->
      AnimationName.toString v.name
      ^ {js| |js}
      ^ Time.toString v.duration
      ^ {js| |js}
      ^ TimingFunction.toString v.timingFunction
      ^ {js| |js}
      ^ Time.toString v.delay
      ^ {js| |js}
      ^ AnimationIterationCount.toString v.iterationCount
      ^ {js| |js}
      ^ AnimationDirection.toString v.direction
      ^ {js| |js}
      ^ AnimationFillMode.toString v.fillMode
      ^ {js| |js}
      ^ AnimationPlayState.toString v.playState
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module Cursor = struct
  type t =
    [ `_moz_grab
    | `_moz_grabbing
    | `_moz_zoom_in
    | `_moz_zoom_out
    | `_webkit_grab
    | `_webkit_grabbing
    | `_webkit_zoom_in
    | `_webkit_zoom_out
    | Auto.t
    | `default
    | None.t
    | `contextMenu
    | `help
    | `pointer
    | `progress
    | `wait
    | `cell
    | `crosshair
    | `text
    | `hand
    | `verticalText
    | `alias
    | `copy
    | `move
    | `noDrop
    | `notAllowed
    | `grab
    | `grabbing
    | `allScroll
    | `colResize
    | `rowResize
    | `nResize
    | `eResize
    | `sResize
    | `wResize
    | `neResize
    | `nwResize
    | `seResize
    | `swResize
    | `ewResize
    | `nsResize
    | `neswResize
    | `nwseResize
    | `zoomIn
    | `zoomOut
    | Var.t
    | Cascading.t
    ]

  let auto = `auto
  let default = `default
  let none = `none
  let contextMenu = `contextMenu
  let help = `help
  let pointer = `pointer
  let progress = `progress
  let wait = `wait
  let cell = `cell
  let crosshair = `crosshair
  let text = `text
  let verticalText = `verticalText
  let alias = `alias
  let copy = `copy
  let move = `move
  let noDrop = `noDrop
  let notAllowed = `notAllowed
  let grab = `grab
  let grabbing = `grabbing
  let allScroll = `allScroll
  let colResize = `colResize
  let rowResize = `rowResize
  let nResize = `nResize
  let eResize = `eResize
  let sResize = `sResize
  let wResize = `wResize
  let neResize = `neResize
  let nwResize = `nwResize
  let seResize = `seResize
  let swResize = `swResize
  let ewResize = `ewResize
  let nsResize = `nsResize
  let neswResize = `neswResize
  let nwseResize = `nwseResize
  let zoomIn = `zoomIn
  let zoomOut = `zoomOut

  let toString (x : t) =
    match x with
    | `_moz_grab -> {js|-moz-grab|js}
    | `_moz_grabbing -> {js|-moz-grabbing|js}
    | `_moz_zoom_in -> {js|-moz-zoom-in|js}
    | `_moz_zoom_out -> {js|-moz-zoom-out|js}
    | `_webkit_grab -> {js|-webkit-grab|js}
    | `_webkit_grabbing -> {js|-webkit-grabbing|js}
    | `_webkit_zoom_in -> {js|-webkit-zoom-in|js}
    | `_webkit_zoom_out -> {js|-webkit-zoom-out|js}
    | `alias -> {js|alias|js}
    | `allScroll -> {js|all-scroll|js}
    | #Auto.t -> Auto.toString
    | `cell -> {js|cell|js}
    | `colResize -> {js|col-resize|js}
    | `contextMenu -> {js|context-menu|js}
    | `copy -> {js|copy|js}
    | `crosshair -> {js|crosshair|js}
    | `default -> {js|default|js}
    | `eResize -> {js|e-resize|js}
    | `ewResize -> {js|ew-resize|js}
    | `grab -> {js|grab|js}
    | `grabbing -> {js|grabbing|js}
    | `hand -> {js|hand|js}
    | `help -> {js|help|js}
    | `move -> {js|move|js}
    | `neResize -> {js|ne-resize|js}
    | `neswResize -> {js|nesw-resize|js}
    | `noDrop -> {js|no-drop|js}
    | #None.t -> None.toString
    | `notAllowed -> {js|not-allowed|js}
    | `nResize -> {js|n-resize|js}
    | `nsResize -> {js|ns-resize|js}
    | `nwResize -> {js|nw-resize|js}
    | `nwseResize -> {js|nwse-resize|js}
    | `pointer -> {js|pointer|js}
    | `progress -> {js|progress|js}
    | `rowResize -> {js|row-resize|js}
    | `seResize -> {js|se-resize|js}
    | `sResize -> {js|s-resize|js}
    | `swResize -> {js|sw-resize|js}
    | `text -> {js|text|js}
    | `verticalText -> {js|vertical-text|js}
    | `wait -> {js|wait|js}
    | `wResize -> {js|w-resize|js}
    | `zoomIn -> {js|zoom-in|js}
    | `zoomOut -> {js|zoom-out|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Color = struct
  type rgb = int * int * int

  let rgb_to_string r g b =
    {js|rgb(|js}
    ^ Kloth.Int.to_string r
    ^ {js|, |js}
    ^ Kloth.Int.to_string g
    ^ {js|, |js}
    ^ Kloth.Int.to_string b
    ^ {js|)|js}

  type 'a calc_min_max =
    [ `calc of
      [ `add of 'a * 'a
      | `sub of 'a * 'a
      | `mult of 'a * 'a
      | `div of 'a * float
      | `num of float
      ]
    | `min of 'a array
    | `max of 'a array
    ]

  type alpha =
    [ `num of float
    | Percentage.t
    ]

  type alpha_with_calc =
    [ alpha
    | alpha calc_min_max
    ]

  type rgba = int * int * int * alpha_with_calc

  let string_of_alpha : alpha -> string = function
    | `num x -> Kloth.Float.to_string x
    | #Percentage.t as pc -> Percentage.toString pc

  let string_of_alpha_with_calc (x : alpha_with_calc) =
    match x with
    | `num _ as alpha -> string_of_alpha alpha
    | #Percentage.t as alpha -> string_of_alpha alpha
    | (`calc _ | `min _ | `max _) as x ->
      Calc.min_max_num_to_string string_of_alpha x

  let rgba_to_string r g b a =
    {js|rgba(|js}
    ^ Kloth.Int.to_string r
    ^ {js|, |js}
    ^ Kloth.Int.to_string g
    ^ {js|, |js}
    ^ Kloth.Int.to_string b
    ^ {js|, |js}
    ^ string_of_alpha_with_calc a
    ^ {js|)|js}

  type percent_with_calc =
    [ Percentage.t
    | Percentage.t calc_min_max
    ]

  type angle_with_calc =
    [ Angle.t
    | Angle.t calc_min_max
    ]

  type hsl = angle_with_calc * percent_with_calc * percent_with_calc

  let string_of_angle_with_calc x =
    match x with
    | #Angle.t as pc -> Angle.toString pc
    | (`calc _ | `min _ | `max _) as x ->
      Calc.min_max_num_to_string Angle.toString x

  let string_of_percent_with_calc x =
    match x with
    | #Percentage.t as pc -> Percentage.toString pc
    | (`calc _ | `min _ | `max _) as x ->
      Calc.min_max_num_to_string Percentage.toString x

  let hsl_to_string h s l =
    {js|hsl(|js}
    ^ string_of_angle_with_calc h
    ^ {js|, |js}
    ^ string_of_percent_with_calc s
    ^ {js|, |js}
    ^ string_of_percent_with_calc l
    ^ {js|)|js}

  type hsla =
    angle_with_calc * percent_with_calc * percent_with_calc * alpha_with_calc

  let hsla_to_string h s l a =
    {js|hsla(|js}
    ^ string_of_angle_with_calc h
    ^ {js|, |js}
    ^ string_of_percent_with_calc s
    ^ {js|, |js}
    ^ string_of_percent_with_calc l
    ^ {js|, |js}
    ^ string_of_alpha_with_calc a
    ^ {js|)|js}

  type polar_color_space =
    [ `hsl
    | `hwb
    | `lch
    | `oklch
    ]

  let polar_color_space_to_string = function
    | `hsl -> {js|hsl|js}
    | `hwb -> {js|hwb|js}
    | `lch -> {js|lch|js}
    | `oklch -> {js|oklch|js}

  type rectangular_color_space =
    [ `srgb
    | `srgbLinear
    | `displayP3
    | `a98Rgb
    | `prophotoRgb
    | `rec2020
    | `lab
    | `oklab
    | `xyz
    | `xyzD50
    | `xyzD65
    ]

  let rectangular_color_space_to_string = function
    | `srgb -> {js|srgb|js}
    | `srgbLinear -> {js|srgb-linear|js}
    | `displayP3 -> {js|display-p3|js}
    | `a98Rgb -> {js|a98-rgb|js}
    | `prophotoRgb -> {js|prophoto-rgb|js}
    | `rec2020 -> {js|rec2020|js}
    | `lab -> {js|lab|js}
    | `oklab -> {js|oklab|js}
    | `xyz -> {js|xyz|js}
    | `xyzD50 -> {js|xyz-d50|js}
    | `xyzD65 -> {js|xyz-d65|js}

  type hue_size =
    [ `shorter
    | `longer
    | `increasing
    | `decreasing
    ]

  let hue_size_to_string = function
    | `shorter -> {js|shorter|js}
    | `longer -> {js|longer|js}
    | `increasing -> {js|increasing|js}
    | `decreasing -> {js|decreasing|js}

  type color_interpolation_method =
    [ rectangular_color_space
    | polar_color_space
    | `polar_with_hue of polar_color_space * hue_size
    ]

  type t =
    [ `rgb of rgb
    | `colorMix of
      color_interpolation_method
      * (t * Percentage.t option)
      * (t * Percentage.t option)
    | `rgba of rgba
    | `hsl of hsl
    | `hsla of hsla
    | `hex of string
    | `transparent
    | `currentColor
    | Var.t
    | Cascading.t
    ]

  let rgb r g b = `rgb (r, g, b)
  let rgba r g b a = `rgba (r, g, b, a)
  let hsl h s l = `hsl (h, s, l)
  let hsla h s l a = `hsla (h, s, l, a)
  let hex x = `hex x
  let transparent = `transparent
  let currentColor = `currentColor

  let color_interpolation_method_to_string = function
    | #rectangular_color_space as rcs -> rectangular_color_space_to_string rcs
    | #polar_color_space as pcs -> polar_color_space_to_string pcs
    | `polar_with_hue (pcs, hs) ->
      polar_color_space_to_string pcs
      ^ {js| |js}
      ^ hue_size_to_string hs
      ^ {js| hue|js}

  let rec toString (x : t) =
    match x with
    | `hex s -> {js|#|js} ^ s
    | `transparent -> {js|transparent|js}
    | `currentColor -> {js|currentColor|js}
    | `rgb (r, g, b) -> rgb_to_string r g b
    | `rgba (r, g, b, a) -> rgba_to_string r g b a
    | `hsl (h, s, l) -> hsl_to_string h s l
    | `hsla (h, s, l, a) -> hsla_to_string h s l a
    | `colorMix (method', x, y) ->
      {js|color-mix(in |js}
      ^ color_interpolation_method_to_string method'
      ^ {js|, |js}
      ^ string_of_color_with_percentage x
      ^ {js|, |js}
      ^ string_of_color_with_percentage y
      ^ {js|)|js}
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c

  and string_of_color_with_percentage (x : t * Percentage.t option) =
    match x with
    | color, None -> toString color
    | color, Some percent ->
      toString color ^ {js| |js} ^ Percentage.toString percent
end

module CaretColor = struct
  type t =
    [ Auto.t
    | Color.t
    ]

  let toString (x : t) =
    match x with #Auto.t -> Auto.toString | #Color.t as c -> Color.toString c
end

module BorderStyle = struct
  type t =
    [ None.t
    | `hidden
    | `dotted
    | `dashed
    | `solid
    | `double
    | `groove
    | `ridge
    | `inset
    | `outset
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `hidden -> {js|hidden|js}
    | `dotted -> {js|dotted|js}
    | `dashed -> {js|dashed|js}
    | `solid -> {js|solid|js}
    | `double -> {js|double|js}
    | `groove -> {js|groove|js}
    | `ridge -> {js|ridge|js}
    | `inset -> {js|inset|js}
    | `outset -> {js|outset|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module PointerEvents = struct
  type t =
    [ Auto.t
    | None.t
    | `visiblePainted
    | `visibleFill
    | `visibleStroke
    | `visible
    | `painted
    | `fill
    | `stroke
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `visiblePainted -> {js|visiblePainted|js}
    | `visibleFill -> {js|visibleFill|js}
    | `visibleStroke -> {js|visibleStroke|js}
    | `visible -> {js|visible|js}
    | `painted -> {js|painted|js}
    | `fill -> {js|fill|js}
    | `stroke -> {js|stroke|js}
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Perspective = struct
  type t =
    [ None.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module PerspectiveOrigin = struct
  type t =
    [ Perspective.t
    | TransformOrigin.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Perspective.t as p -> Perspective.toString p
    | #TransformOrigin.t as t -> TransformOrigin.toString t
end

module LetterSpacing = struct
  type t =
    [ `normal
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let normal = `normal

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module LineHeight = struct
  type t =
    [ `normal
    | `abs of float
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `abs x -> Kloth.Float.to_string x
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module LineWidth = struct
  type t =
    [ Length.t
    | `thin
    | `medium
    | `thick
    ]

  let toString (x : t) =
    match x with
    | `thin -> {js|thin|js}
    | `medium -> {js|medium|js}
    | `thick -> {js|thick|js}
    | #Length.t as l -> Length.toString l
end

module WordSpacing = struct
  (* https://developer.mozilla.org/en-US/docs/Web/CSS/word-spacing *)
  type t =
    [ `normal
    | Var.t
    | Cascading.t
    | Length.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Display = struct
  module Old = struct
    type t =
      [ `flow
      | `flowRoot
      | `ruby
      | `rubyBase
      | `rubyBaseContainer
      | `rubyText
      | `rubyTextContainer
      | `runIn
      | `mozBox
      | `mozInlineBox
      | `mozInlineStack
      | `msFlexbox
      | `msGrid
      | `msInlineFlexbox
      | `msInlineGrid
      | `webkitBox
      | `webkitFlex
      | `webkitInlineBox
      | `webkitInlineFlex
      ]

    let toString = function
      | `flow -> "flow"
      | `flowRoot -> "flow-root"
      | `ruby -> "ruby"
      | `rubyBase -> "ruby-base"
      | `rubyBaseContainer -> "ruby-base-container"
      | `rubyText -> "ruby-text"
      | `rubyTextContainer -> "ruby-text-container"
      | `runIn -> "run-in"
      | `mozBox -> "-moz-box"
      | `mozInlineBox -> "-moz-inline-box"
      | `mozInlineStack -> "-moz-inline-stack"
      | `msFlexbox -> "-ms-flexbox"
      | `msGrid -> "-ms-grid"
      | `msInlineFlexbox -> "-ms-inline-flexbox"
      | `msInlineGrid -> "-ms-inline-grid"
      | `webkitBox -> "-webkit-box"
      | `webkitFlex -> "-webkit-flex"
      | `webkitInlineBox -> "-webkit-inline-box"
      | `webkitInlineFlex -> "-webkit-inline-flex"
  end

  module Outside = struct
    type t =
      [ `block
      | `inline
      | `runIn
      ]

    let toString (x : t) =
      match x with
      | `block -> {js|block|js}
      | `inline -> {js|inline|js}
      | `runIn -> {js|run-in|js}
  end

  module Inside = struct
    type t =
      [ `table
      | `flex
      | `grid
      ]

    let toString (x : t) =
      match x with
      | `table -> {js|table|js}
      | `flex -> {js|flex|js}
      | `grid -> {js|grid|js}
  end

  module ListItem = struct
    type t = [ `listItem ]

    let toString (x : t) = match x with `listItem -> {js|list-item|js}
  end

  module Internal = struct
    type t =
      [ `tableRowGroup
      | `tableHeaderGroup
      | `tableFooterGroup
      | `tableRow
      | `tableCell
      | `tableColumnGroup
      | `tableColumn
      | `tableCaption
      ]

    let toString (x : t) =
      match x with
      | `tableRowGroup -> {js|table-row-group|js}
      | `tableHeaderGroup -> {js|table-header-group|js}
      | `tableFooterGroup -> {js|table-footer-group|js}
      | `tableRow -> {js|table-row|js}
      | `tableCell -> {js|table-cell|js}
      | `tableColumnGroup -> {js|table-column-group|js}
      | `tableColumn -> {js|table-column|js}
      | `tableCaption -> {js|table-caption|js}
  end

  module Box = struct
    type t =
      [ `contents
      | None.t
      ]

    let toString (x : t) =
      match x with `contents -> {js|contents|js} | #None.t -> None.toString
  end

  module Legacy = struct
    type t =
      [ `inlineBlock
      | `inlineFlex
      | `inlineGrid
      | `inlineTable
      ]

    let toString (x : t) =
      match x with
      | `inlineBlock -> {js|inline-block|js}
      | `inlineFlex -> {js|inline-flex|js}
      | `inlineGrid -> {js|inline-grid|js}
      | `inlineTable -> {js|inline-table|js}
  end

  type t =
    [ Outside.t
    | Old.t
    | Inside.t
    | ListItem.t
    | Internal.t
    | Box.t
    | Legacy.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Outside.t as o -> Outside.toString o
    | #Old.t as o -> Old.toString o
    | #Inside.t as i -> Inside.toString i
    | #ListItem.t as l -> ListItem.toString l
    | #Internal.t as i' -> Internal.toString i'
    | #Box.t as b -> Box.toString b
    | #Legacy.t as l' -> Legacy.toString l'
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextEmphasisStyle = struct
  module FilledOrOpen = struct
    type t =
      [ `filled
      | `open_
      | Var.t
      | Cascading.t
      ]

    let toString (x : t) =
      match x with
      | `filled -> {js|filled|js}
      | `open_ -> {js|open|js}
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c
  end

  module Shape = struct
    type t =
      [ `dot
      | `circle
      | `double_circle
      | `triangle
      | `sesame
      | Var.t
      | Cascading.t
      ]

    let toString (x : t) =
      match x with
      | `dot -> {js|dot|js}
      | `circle -> {js|circle|js}
      | `double_circle -> {js|double-circle|js}
      | `triangle -> {js|triangle|js}
      | `sesame -> {js|sesame|js}
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c
  end

  type t =
    [ None.t
    | FilledOrOpen.t
    | Shape.t
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `filled -> {js|filled|js}
    | `open_ -> {js|open|js}
    | `dot -> {js|dot|js}
    | `circle -> {js|circle|js}
    | `double_circle -> {js|double-circle|js}
    | `triangle -> {js|triangle|js}
    | `sesame -> {js|sesame|js}
    | `string s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextEmphasisPosition = struct
  module LeftRightAlignment = struct
    type t =
      [ `left
      | `right
      | Var.t
      | Cascading.t
      ]

    let toString (x : t) =
      match x with
      | `left -> {js|left|js}
      | `right -> {js|right|js}
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c
  end

  module OverOrUnder = struct
    type t =
      [ `over
      | `under
      | Var.t
      | Cascading.t
      ]

    let toString (x : t) =
      match x with
      | `over -> {js|over|js}
      | `under -> {js|under|js}
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c
  end
end

module Position = struct
  module X = struct
    type t =
      [ `left
      | `right
      | `center
      ]

    let toString (x : t) =
      match x with
      | `left -> {js|left|js}
      | `right -> {js|right|js}
      | `center -> {js|center|js}
  end

  module Y = struct
    type t =
      [ `top
      | `bottom
      | `center
      ]

    let toString (x : t) =
      match x with
      | `top -> {js|top|js}
      | `bottom -> {js|bottom|js}
      | `center -> {js|center|js}
  end

  type t =
    [ X.t
    | Y.t
    | `hv of [ X.t | Length.t ] * [ Y.t | Length.t ]
    | `hvOffset of X.t * Length.t * Y.t * Length.t
    | Length.t
    ]

  let hv x y : [> t ] = `hv (x, y)
  let hvOffset x xo y yo : [> t ] = `hvOffset (x, xo, y, yo)
  let top : [> t ] = `top
  let bottom : [> t ] = `bottom
  let left : [> t ] = `left
  let right : [> t ] = `right
  let center : [> t ] = `center

  let toString (x : t) =
    match x with
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `center -> {js|center|js}
    | `hv (h, v) ->
      (match h with
      | #X.t as h -> X.toString h
      | #Length.t as l -> Length.toString l)
      ^ {js| |js}
      ^ begin
          match v with
          | #Y.t as v -> Y.toString v
          | #Length.t as l -> Length.toString l
        end
    | `hvOffset (h, ho, v, vo) ->
      X.toString h
      ^ {js| |js}
      ^ Length.toString ho
      ^ {js| |js}
      ^ Y.toString v
      ^ {js| |js}
      ^ Length.toString vo
    | #Length.t as l -> Length.toString l
end

module BgPosition = struct
  module X = Position.X
  module Y = Position.Y

  type t =
    [ X.t
    | Y.t
    | `hv of [ X.t | Length.t ] * [ Y.t | Length.t ]
    | `hvOffset of
      [ X.t | `leftOffset of Length.t | `rightOffset of Length.t ]
      * [ Y.t | `topOffset of Length.t | `bottomOffset of Length.t ]
    | Length.t
    ]

  let hv x y : [> t ] = `hv (x, y)
  let hvOffset x y : [> t ] = `hvOffset (x, y)
  let top : [> t ] = `top
  let bottom : [> t ] = `bottom
  let left : [> t ] = `left
  let right : [> t ] = `right
  let center : [> t ] = `center
  let topOffset (x : Length.t) = `topOffset x
  let bottomOffset (x : Length.t) = `bottomOffset x
  let leftOffset (x : Length.t) = `leftOffset x
  let rightOffset (x : Length.t) = `rightOffset x

  let toString (x : t) =
    match x with
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `center -> {js|center|js}
    | `hv (h, v) ->
      (match h with
      | #X.t as h -> X.toString h
      | #Length.t as l -> Length.toString l)
      ^ {js| |js}
      ^ begin
          match v with
          | #Y.t as v -> Y.toString v
          | #Length.t as l -> Length.toString l
        end
    | `hvOffset (h, v) ->
      (match h with
      | #X.t as h -> X.toString h
      | `leftOffset l -> Length.toString l
      | `rightOffset l -> Length.toString l)
      ^ {js| |js}
      ^ begin
          match v with
          | #Y.t as v -> Y.toString v
          | `topOffset l -> Length.toString l
          | `bottomOffset l -> Length.toString l
        end
    | #Length.t as l -> Length.toString l
end

module MaskPosition = struct
  type t =
    [ Position.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #Position.t as x -> Position.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module ObjectPosition = struct
  include MaskPosition
end

module BackgroundPosition = struct
  type t =
    [ BgPosition.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #BgPosition.t as x -> BgPosition.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module PositionalAlignment = struct
  type t =
    [ `center
    | `start
    | `end_
    | `flexStart
    | `flexEnd
    | `selfStart
    | `selfEnd
    | `left
    | `right
    ]

  let toString (x : t) =
    match x with
    | `center -> {js|center|js}
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `flexStart -> {js|flex-start|js}
    | `flexEnd -> {js|flex-end|js}
    | `selfStart -> {js|self-start|js}
    | `selfEnd -> {js|self-end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
end

module OverflowAlignment = struct
  type t =
    [ `safe of PositionalAlignment.t
    | `unsafe of PositionalAlignment.t
    ]

  let toString (x : t) =
    match x with
    | `safe pa -> {js|safe |js} ^ PositionalAlignment.toString pa
    | `unsafe pa -> {js|unsafe |js} ^ PositionalAlignment.toString pa
end

module BaselineAlignment = struct
  type t =
    [ `baseline
    | `firstBaseline
    | `lastBaseline
    ]

  let toString (x : t) =
    match x with
    | `baseline -> {js|baseline|js}
    | `firstBaseline -> {js|first baseline|js}
    | `lastBaseline -> {js|last baseline|js}
end

module NormalAlignment = struct
  type t = [ `normal ]

  let toString (x : t) = match x with `normal -> {js|normal|js}
end

module DistributedAlignment = struct
  type t =
    [ `spaceBetween
    | `spaceAround
    | `spaceEvenly
    | `stretch
    ]

  let toString (x : t) =
    match x with
    | `spaceBetween -> {js|space-between|js}
    | `spaceAround -> {js|space-around|js}
    | `spaceEvenly -> {js|space-evenly|js}
    | `stretch -> {js|stretch|js}
end

module LegacyAlignment = struct
  type t =
    [ `legacy
    | `legacyRight
    | `legacyLeft
    | `legacyCenter
    ]

  let toString (x : t) =
    match x with
    | `legacy -> {js|legacy|js}
    | `legacyRight -> {js|legacy right|js}
    | `legacyLeft -> {js|legacy left|js}
    | `legacyCenter -> {js|legacy center|js}
end

module JustifySelf = struct
  type t =
    [ Auto.t
    | `normal
    | `stretch
    | PositionalAlignment.t
    | OverflowAlignment.t
    | BaselineAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `normal -> {js|normal|js}
    | `stretch -> {js|stretch|js}
    | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
    | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
    | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextAlign = struct
  type t =
    [ `start
    | `end_
    | `left
    | `right
    | `center
    | `justify
    | `matchParent
    | `justifyAll
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
    | `justifyAll -> {js|justify-all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextAlignAll = struct
  type t =
    [ `start
    | `end_
    | `left
    | `right
    | `center
    | `justify
    | `matchParent
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextAlignLast = struct
  type t =
    [ Auto.t
    | `start
    | `end_
    | `left
    | `right
    | `center
    | `justify
    | `matchParent
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WordBreak = struct
  type t =
    [ `normal
    | `breakAll
    | `keepAll
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `breakAll -> {js|break-all|js}
    | `keepAll -> {js|keep-all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WhiteSpace = struct
  type t =
    [ `normal
    | `nowrap
    | `pre
    | `preLine
    | `preWrap
    | `breakSpaces
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `nowrap -> {js|nowrap|js}
    | `pre -> {js|pre|js}
    | `preLine -> {js|pre-line|js}
    | `preWrap -> {js|pre-wrap|js}
    | `breakSpaces -> {js|break-spaces|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AlignItems = struct
  type t =
    [ `normal
    | `stretch
    | PositionalAlignment.t
    | BaselineAlignment.t
    | OverflowAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `stretch -> {js|stretch|js}
    | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
    | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
    | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AlignSelf = struct
  type t =
    [ Auto.t
    | `normal
    | `stretch
    | PositionalAlignment.t
    | OverflowAlignment.t
    | BaselineAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `normal -> {js|normal|js}
    | `stretch -> {js|stretch|js}
    | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
    | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
    | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AlignContent = struct
  type t =
    [ `center
    | `start
    | `end_
    | `flexStart
    | `flexEnd
    | NormalAlignment.t
    | BaselineAlignment.t
    | OverflowAlignment.t
    | DistributedAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `center -> {js|center|js}
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `flexStart -> {js|flex-start|js}
    | `flexEnd -> {js|flex-end|js}
    | #NormalAlignment.t as na -> NormalAlignment.toString na
    | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
    | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
    | #DistributedAlignment.t as da -> DistributedAlignment.toString da
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module JustifyItems = struct
  type t =
    [ `stretch
    | PositionalAlignment.t
    | NormalAlignment.t
    | BaselineAlignment.t
    | OverflowAlignment.t
    | LegacyAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `stretch -> {js|stretch|js}
    | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
    | #NormalAlignment.t as na -> NormalAlignment.toString na
    | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
    | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
    | #LegacyAlignment.t as la -> LegacyAlignment.toString la
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module JustifyContent = struct
  type t =
    [ PositionalAlignment.t
    | NormalAlignment.t
    | DistributedAlignment.t
    | OverflowAlignment.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
    | #NormalAlignment.t as na -> NormalAlignment.toString na
    | #DistributedAlignment.t as da -> DistributedAlignment.toString da
    | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ObjectFit = struct
  type t =
    [ `fill
    | `contain
    | `cover
    | None.t
    | `scaleDown
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `fill -> {js|fill|js}
    | `contain -> {js|contain|js}
    | `cover -> {js|cover|js}
    | #None.t -> None.toString
    | `scaleDown -> {js|scale-down|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Clear = struct
  type t =
    [ None.t
    | `left
    | `right
    | `both
    | `inlineStart
    | `inlineEnd
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `both -> {js|both|js}
    | `inlineStart -> {js|inline-start|js}
    | `inlineEnd -> {js|inline-end|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Float = struct
  type t =
    [ `left
    | `right
    | None.t
    | `inlineStart
    | `inlineEnd
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | #None.t -> None.toString
    | `inlineStart -> {js|inline-start|js}
    | `inlineEnd -> {js|inline-end|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Visibility = struct
  type t =
    [ `visible
    | `hidden
    | `collapse
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | `collapse -> {js|collapse|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TableLayout = struct
  type t =
    [ Auto.t
    | `fixed
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `fixed -> {js|fixed|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Border = struct
  let toString px style color =
    LineWidth.toString px
    ^ {js| |js}
    ^ BorderStyle.toString style
    ^ {js| |js}
    ^ Color.toString color
end

module BorderCollapse = struct
  type t =
    [ `collapse
    | `separate
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `collapse -> {js|collapse|js}
    | `separate -> {js|separate|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FlexWrap = struct
  type t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `nowrap -> {js|nowrap|js}
    | `wrap -> {js|wrap|js}
    | `wrapReverse -> {js|wrap-reverse|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FlexDirection = struct
  type t =
    [ `row
    | `rowReverse
    | `column
    | `columnReverse
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `row -> {js|row|js}
    | `rowReverse -> {js|row-reverse|js}
    | `column -> {js|column|js}
    | `columnReverse -> {js|column-reverse|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxSizing = struct
  type t =
    [ `contentBox
    | `borderBox
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `contentBox -> {js|content-box|js}
    | `borderBox -> {js|border-box|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ColumnCount = struct
  type t =
    [ Auto.t
    | `count of int
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `count v -> Kloth.Int.to_string v
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module UserSelect = struct
  type t =
    [ None.t
    | Auto.t
    | `text
    | `contain
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | `text -> {js|text|js}
    | `contain -> {js|contain|js}
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextTransform = struct
  type t =
    [ None.t
    | `capitalize
    | `uppercase
    | `lowercase
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `capitalize -> {js|capitalize|js}
    | `uppercase -> {js|uppercase|js}
    | `lowercase -> {js|lowercase|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module GridTemplateAreas = struct
  type t =
    [ None.t
    | `areas of string array
    | Var.t
    | Cascading.t
    ]

  let areas x = `areas x

  let toString (x : t) : string =
    match x with
    | #None.t -> None.toString
    | `areas (items : string array) ->
      Kloth.Array.map_and_join ~sep:{js| |js}
        ~f:(fun item -> {js|'|js} ^ item ^ {js|'|js})
        items
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module GridLine = struct
  type t =
    [ Auto.t
    | `ident of string
    | `num of int
    | `numIdent of int * string
    | `spanNum of int
    | `spanIdent of string
    | `spanNumIdent of int * string
    ]

  let auto : [> t ] = `auto
  let ident x : [> t ] = `ident x
  let num x : [> t ] = `num x
  let numIdent x y : [> t ] = `numIdent (x, y)
  let spanNum x : [> t ] = `span x
  let spanIdent x : [> t ] = `span x
  let spanNumIdent x y : [> t ] = `spanNumIdent (x, y)

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `ident s -> s
    | `num i -> string_of_int i
    | `numIdent (i, s) -> (string_of_int i ^ {js| |js}) ^ s
    | `spanNum n -> {js|span |js} ^ string_of_int n
    | `spanIdent i -> {js|span |js} ^ i
    | `spanNumIdent (n, i) -> {js|span |js} ^ string_of_int n ^ {js| |js} ^ i
end

module GridArea = struct
  type t =
    [ GridLine.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #GridLine.t as x -> GridLine.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module GridRow = struct
  include GridArea
end

module GridColumn = struct
  include GridArea
end

module Filter = struct
  type t =
    [ None.t
    | `blur of Length.t
    | `brightness of [ Percentage.t | `num of float ]
    | `contrast of [ Percentage.t | `num of float ]
    | `dropShadow of Length.t * Length.t * Length.t * [ Color.t | Var.t ]
    | `grayscale of [ Percentage.t | `num of float ]
    | `hueRotate of Angle.t
    | `invert of [ Percentage.t | `num of float ]
    | `opacity of [ Percentage.t | `num of float ]
    | `saturate of [ Percentage.t | `num of float ]
    | `sepia of [ Percentage.t | `num of float ]
    | Url.t
    | Var.t
    | Cascading.t
    ]

  let string_of_amount x =
    match x with
    | #Percentage.t as p -> Percentage.toString p
    | `num v -> Kloth.Float.to_string v

  let toString (x : t) =
    match x with
    | `blur v -> {js|blur(|js} ^ Length.toString v ^ {js|)|js}
    | `brightness v -> {js|brightness(|js} ^ string_of_amount v ^ {js|%)|js}
    | `contrast v -> {js|contrast(|js} ^ string_of_amount v ^ {js|%)|js}
    | `dropShadow (a, b, c, d) ->
      {js|drop-shadow(|js}
      ^ Length.toString a
      ^ {js| |js}
      ^ Length.toString b
      ^ {js| |js}
      ^ Length.toString c
      ^ {js| |js}
      ^ Color.toString d
      ^ {js|)|js}
    | `grayscale v -> {js|grayscale(|js} ^ string_of_amount v ^ {js|%)|js}
    | `hueRotate v -> {js|hue-rotate(|js} ^ Angle.toString v ^ {js|)|js}
    | `invert v -> {js|invert(|js} ^ string_of_amount v ^ {js|%)|js}
    | `opacity v -> {js|opacity(|js} ^ string_of_amount v ^ {js|%)|js}
    | `saturate v -> {js|saturate(|js} ^ string_of_amount v ^ {js|%)|js}
    | `sepia v -> {js|sepia(|js} ^ string_of_amount v ^ {js|%)|js}
    | #None.t -> None.toString
    | #Url.t as u -> Url.toString u
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundAttachment = struct
  type t =
    [ `scroll
    | `fixed
    | `local
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `scroll -> {js|scroll|js}
    | `fixed -> {js|fixed|js}
    | `local -> {js|local|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundClip = struct
  type t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    | `text
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `borderBox -> {js|border-box|js}
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `text -> {js|text|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundOrigin = struct
  type t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `borderBox -> {js|border-box|js}
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundRepeat = struct
  type twoValue =
    [ `repeat
    | `space
    | `round
    | `noRepeat
    ]

  type t =
    [ `repeatX
    | `repeatY
    | twoValue
    | Var.t
    | Cascading.t
    ]

  type horizontal = twoValue
  type vertical = twoValue

  let rec toString x =
    match x with
    | `repeatX -> {js|repeat-x|js}
    | `repeatY -> {js|repeat-y|js}
    | `repeat -> {js|repeat|js}
    | `space -> {js|space|js}
    | `round -> {js|round|js}
    | `noRepeat -> {js|no-repeat|js}
    | `hv (h, v) -> hv_to_string h v
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  and hv_to_string h v = toString h ^ {js| |js} ^ toString v
end

module TextOverflow = struct
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `clip -> {js|clip|js}
    | `ellipsis -> {js|ellipsis|js}
    | `string s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationLine = struct
  type t =
    [ None.t
    | `underline
    | `overline
    | `lineThrough
    | `blink
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `underline -> {js|underline|js}
    | `overline -> {js|overline|js}
    | `lineThrough -> {js|line-through|js}
    | `blink -> {js|blink|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationStyle = struct
  type t =
    [ None.t
    | `solid
    | `double
    | `dotted
    | `dashed
    | `wavy
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `solid -> {js|solid|js}
    | `double -> {js|double|js}
    | `dotted -> {js|dotted|js}
    | `dashed -> {js|dashed|js}
    | `wavy -> {js|wavy|js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationThickness = struct
  type t =
    [ `fromFont
    | Auto.t
    | None.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `fromFont -> {js|from-font|js}
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationSkipInk = struct
  type t =
    [ Auto.t
    | None.t
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationSkipBox = struct
  type t =
    [ None.t
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `none -> None.toString
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationSkipInset = struct
  type t =
    [ None.t
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `none -> None.toString
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecoration = struct
  type t =
    [ None.t
    | `underline
    | `overline
    | `lineThrough
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `underline -> {js|underline|js}
    | `overline -> {js|overline|js}
    | `lineThrough -> {js|line-through|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Width = struct
  type t =
    [ Auto.t
    | `fitContent
    | `maxContent
    | `minContent
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `fitContent -> {js|fit-content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MinWidth = struct
  type t =
    [ None.t
    | Width.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with #None.t -> None.toString | #Width.t as w -> Width.toString w
end

module MaxWidth = struct
  type t =
    [ None.t
    | Width.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Width.t as mw -> Width.toString mw
end

module Height = struct
  type t =
    [ Auto.t
    | `fitContent
    | `maxContent
    | `minContent
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `fitContent -> {js|fit-content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaxHeight = struct
  type t =
    [ None.t
    | Height.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Height.t as mh -> Height.toString mh
end

module MinHeight = struct
  type t = Height.t

  let toString (x : t) = match x with #Height.t as h -> Height.toString h
end

module OverflowWrap = struct
  type t =
    [ `normal
    | `breakWord
    | `anywhere
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `breakWord -> {js|break-word|js}
    | `anywhere -> {js|anywhere|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module SideOrCorner = struct
  type t =
    [ `Top
    | `Left
    | `Bottom
    | `Right
    | `TopLeft
    | `TopRight
    | `BottomLeft
    | `BottomRight
    ]

  let toString = function
    | `Top -> "to top"
    | `Left -> "to left"
    | `Bottom -> "to bottom"
    | `Right -> "to right"
    | `TopLeft -> "to top left"
    | `TopRight -> "to top right"
    | `BottomLeft -> "to bottom left"
    | `BottomRight -> "to bottom right"
end

module Shadow = struct
  type 'a value = string
  type box
  type text

  type 'a t =
    [ `shadow of 'a value
    | None.t
    | Var.t
    | Cascading.t
    ]

  let box ?(x = `zero) ?(y = `zero) ?(blur = `zero) ?(spread = `zero)
    ?(inset = false) (color : Color.t) : box t =
    `shadow
      (Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString blur
      ^ {js| |js}
      ^ Length.toString spread
      ^ {js| |js}
      ^ Color.toString color
      ^ if inset then {js| inset|js} else {js||js})

  let text ?(x = `zero) ?(y = `zero) ?(blur = `zero) (color : Color.t) : text t
      =
    `shadow
      (Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString blur
      ^ {js| |js}
      ^ Color.toString color)

  let toString (x : 'a t) =
    match x with
    | `shadow x -> x
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Gradient = struct
  type direction =
    [ Angle.t
    | `Bottom
    | `BottomLeft
    | `BottomRight
    | `Left
    | `Right
    | `Top
    | `TopLeft
    | `TopRight
    ]

  type color_stop_list = ([ Color.t | Var.t ] option * Length.t option) array

  type shape =
    [ `ellipse
    | `circle
    ]

  type radial_size =
    [ `closestSide
    | `closestCorner
    | `farthestSide
    | `farthestCorner
    ]

  type t =
    [ `linearGradient of direction option * color_stop_list
    | `repeatingLinearGradient of direction option * color_stop_list
    | `radialGradient of
      shape option * radial_size option * Position.t option * color_stop_list
    | `repeatingRadialGradient of
      shape option * radial_size option * Position.t option * color_stop_list
    | `conicGradient of direction option * color_stop_list
    ]

  let linearGradient direction stops = `linearGradient (Some direction, stops)

  let repeatingLinearGradient direction stops =
    `repeatingLinearGradient (Some direction, stops)

  let radialGradient (shape : shape) (size : radial_size)
    (position : Position.t) (stops : color_stop_list) =
    `radialGradient (Some shape, Some size, Some position, stops)

  let repeatingRadialGradient (shape : shape) (size : radial_size)
    (position : Position.t) (stops : color_stop_list) =
    `repeatingRadialGradient (Some shape, Some size, Some position, stops)

  let conicGradient angle stops = `conicGradient (Some angle, stops)

  let string_of_stops stops =
    Kloth.Array.map_and_join ~sep:{js|, |js}
      ~f:(fun (c, l) ->
        match c, l with
        (* This is the consequence of having wrong spec, we can generate broken CSS for gradients, very unlickely that manually you construct a gradient with (None, None), but still. *)
        | None, None -> {| |}
        | None, Some l -> Length.toString l
        | Some c, None -> Color.toString c
        | Some c, Some l -> Color.toString c ^ {js| |js} ^ Length.toString l)
      stops

  let direction_to_string = function
    | #Angle.t as a -> Angle.toString a
    | #SideOrCorner.t as s -> SideOrCorner.toString s

  let string_of_shape shape =
    match shape with `ellipse -> {js|ellipse|js} | `circle -> {js|circle|js}

  let string_of_size size =
    match size with
    | `closestSide -> {js|closest-side|js}
    | `closestCorner -> {js|closest-corner|js}
    | `farthestSide -> {js|farthest-side|js}
    | `farthestCorner -> {js|farthest-corner|js}

  let maybe_string_of_shape = function
    | None -> {js||js}
    | Some shape -> string_of_shape shape ^ {js| |js}

  let maybe_string_of_size = function
    | None -> {js||js}
    | Some size -> string_of_size size ^ {js| |js}

  let maybe_string_of_position = function
    | None -> {js||js}
    | Some position -> {|at |} ^ Position.toString position ^ {js| |js}

  let string_of_radialGradient gradient =
    match gradient with
    | None, None, None, stops ->
      {js|radial-gradient(|js} ^ string_of_stops stops ^ {js|)|js}
    | shape, size, position, stops ->
      {js|radial-gradient(|js}
      ^ maybe_string_of_shape shape
      ^ maybe_string_of_size size
      ^ maybe_string_of_position position
      ^ ","
      ^ string_of_stops stops
      ^ {js|)|js}

  let string_of_repeatingRadialGradients gradient =
    match gradient with
    | None, None, None, stops ->
      {js|repeating-radial-gradient(|js} ^ string_of_stops stops ^ {js|)|js}
    | shape, size, position, stops ->
      {js|repeating-radial-gradient(|js}
      ^ maybe_string_of_shape shape
      ^ maybe_string_of_size size
      ^ maybe_string_of_position position
      ^ ","
      ^ string_of_stops stops
      ^ {js|)|js}

  let toString (x : t) =
    match x with
    | `linearGradient (None, stops) ->
      {js|linear-gradient(|js} ^ string_of_stops stops ^ {js|)|js}
    | `linearGradient (Some direction, stops) ->
      {js|linear-gradient(|js}
      ^ direction_to_string direction
      ^ {js|, |js}
      ^ string_of_stops stops
      ^ {js|)|js}
    | `repeatingLinearGradient (None, stops) ->
      {js|repeating-linear-gradient(|js} ^ string_of_stops stops ^ {js|)|js}
    | `repeatingLinearGradient (Some direction, stops) ->
      {js|repeating-linear-gradient(|js}
      ^ direction_to_string direction
      ^ {js|, |js}
      ^ string_of_stops stops
      ^ {js|)|js}
    | `radialGradient radialGradient -> string_of_radialGradient radialGradient
    | `repeatingRadialGradient radialGradient ->
      string_of_repeatingRadialGradients radialGradient
    | `conicGradient (None, stops) ->
      {js|conic-gradient(|js} ^ string_of_stops stops ^ {js|)|js}
    | `conicGradient (Some direction, stops) ->
      {js|conic-gradient(|js}
      ^ direction_to_string direction
      ^ {js|, |js}
      ^ string_of_stops stops
      ^ {js|)|js}
end

module BackgroundSize = struct
  type t =
    [ None.t
    | `size of Length.t * Length.t
    | Auto.t
    | `cover
    | `contain
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `size (x, y) -> (Length.toString x ^ {js| |js}) ^ Length.toString y
    | `cover -> {js|cover|js}
    | `contain -> {js|contain|js}
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Image = struct
  type t =
    [ Url.t
    | Gradient.t
    ]

  let toString (x : t) =
    match x with
    | #Url.t as u -> Url.toString u
    | #Gradient.t as g -> Gradient.toString g
end

module BackgroundImage = struct
  type t =
    [ None.t
    | Image.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Url.t as u -> Url.toString u
    | #Gradient.t as g -> Gradient.toString g
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Background = struct
  (* https://developer.mozilla.org/en-US/docs/Web/CSS/background *)
  type t =
    [ BackgroundImage.t
    | Color.t
    ]

  let toString (x : t) =
    match x with
    | #Color.t as c -> Color.toString c
    | #BackgroundImage.t as u -> BackgroundImage.toString u
end

module BorderImageSource = struct
  type t =
    [ None.t
    | Image.t
    ]

  let toString (x : t) =
    match x with #None.t -> None.toString | #Image.t as i -> Image.toString i
end

module MaskImage = struct
  type t =
    [ None.t
    | Image.t
    ]

  let toString (x : t) =
    match x with #None.t -> None.toString | #Image.t as i -> Image.toString i
end

module ImageRendering = struct
  type t =
    [ Auto.t
    | `smooth
    | `highQuality
    | `pixelated
    | `crispEdges
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | #Auto.t -> Auto.toString
    | `smooth -> {js|smooth|js}
    | `highQuality -> {js|high-quality|js}
    | `pixelated -> {js|pixelated|js}
    | `crispEdges -> {js|crisp-edges|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module GeometryBox = struct
  type t =
    [ `marginBox
    | `borderBox
    | `paddingBox
    | `contentBox
    | `fillBox
    | `strokeBox
    | `viewBox
    | Var.t
    | Cascading.t
    ]

  let marginBox = `marginBox
  let borderBox = `borderBox
  let paddingBox = `paddingBox
  let contentBox = `contentBox
  let fillBox = `fillBox
  let strokeBox = `strokeBox
  let viewBox = `viewBox

  let toString (x : t) =
    match x with
    | `marginBox -> {js|margin-box|js}
    | `borderBox -> {js|border-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `contentBox -> {js|content-box|js}
    | `fillBox -> {js|fill-box|js}
    | `strokeBox -> {js|stroke-box|js}
    | `viewBox -> {js|view-box|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ClipPath = struct
  (* https://developer.mozilla.org/en-US/docs/Web/CSS/clip-path *)
  type t =
    [ None.t
    | Url.t
    | GeometryBox.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Url.t as u -> Url.toString u
    | #GeometryBox.t as gb -> GeometryBox.toString gb
end

module BackfaceVisibility = struct
  type t =
    [ `visible
    | `hidden
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Flex = struct
  type t =
    [ Auto.t
    | `initial
    | None.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `initial -> {js|initial|js}
    | #None.t -> None.toString
end

module TransformStyle = struct
  type t =
    [ `preserve3d
    | `flat
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `preserve3d -> {js|preserve-3d|js}
    | `flat -> {js|flat|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TransformBox = struct
  type t =
    [ `contentBox
    | `borderBox
    | `fillBox
    | `strokeBox
    | `viewBox
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `contentBox -> {js|content-box|js}
    | `borderBox -> {js|border-box|js}
    | `fillBox -> {js|fill-box|js}
    | `strokeBox -> {js|stroke-box|js}
    | `viewBox -> {js|view-box|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ListStyleImage = struct
  type t =
    [ None.t
    | Image.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | #Image.t as i -> Image.toString i
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontFace = struct
  type t =
    [ Url.t
    | `local of string
    ]

  let toString (x : t) =
    match x with
    | `local value -> ({js|local("|js} ^ value) ^ {js|")|js}
    | `url value -> ({js|url("|js} ^ value) ^ {js|")|js}
end

module FontFamilyName = struct
  type t = string

  let toString (x : t) =
    match String.get x 0 with
    | '\'' -> x
    | '"' -> x
    | _ -> ({js|"|js} ^ x) ^ {js|"|js}
end

module FontDisplay = struct
  type t =
    [ Auto.t
    | `block
    | `swap
    | `fallback
    | `optional
    | Var.t
    | Cascading.t
    ]

  let auto = `auto
  let block = `block
  let swap = `swap
  let fallback = `fallback
  let optional = `optional

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `block -> {js|block|js}
    | `swap -> {js|swap|js}
    | `fallback -> {js|fallback|js}
    | `optional -> {js|optional|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module CounterStyleType = struct
  type t = ListStyleType.t

  let toString (x : t) =
    match x with #ListStyleType.t as c -> ListStyleType.toString c
end

module Counter = struct
  type style =
    [ CounterStyleType.t
    | `unset
    ]

  type t = [ `counter of string * style ]

  let counter ?(style = `unset) name = `counter (name, style)

  let toString (x : t) =
    match x with
    | `counter (counter, style) ->
      (match style with
      | `unset -> ({js|counter(|js} ^ counter) ^ {js|)|js}
      | #CounterStyleType.t as t ->
        {js|counter(|js}
        ^ counter
        ^ {js|,|js}
        ^ CounterStyleType.toString t
        ^ {js|)|js})
end

module Counters = struct
  type style =
    [ CounterStyleType.t
    | `unset
    ]

  type t = [ `counters of string * string * style ]

  let counters ?(style = `unset) ?(separator = {js||js}) name =
    `counters (name, separator, style)

  let toString (x : t) =
    match x with
    | `counters (name, separator, style) ->
      (match style with
      | `unset -> {js|counters(|js} ^ name ^ {js|,"|js} ^ separator ^ {js|")|js}
      | #CounterStyleType.t as s ->
        {js|counters(|js}
        ^ name
        ^ {js|,"|js}
        ^ separator
        ^ {js|",|js}
        ^ CounterStyleType.toString s
        ^ {js|)|js})
end

module CounterIncrement = struct
  type t =
    [ None.t
    | `increment of string * int
    | Var.t
    | Cascading.t
    ]

  let increment ?(value = 1) name = `increment (name, value)

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `increment (name, value) -> (name ^ {js| |js}) ^ string_of_int value
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module CounterReset = struct
  type t =
    [ None.t
    | `reset of string * int
    | Var.t
    | Cascading.t
    ]

  let reset ?(value = 0) name = `reset (name, value)

  let toString (x : t) =
    match x with
    | `reset (name, value) -> (name ^ {js| |js}) ^ string_of_int value
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module CounterSet = struct
  type t =
    [ None.t
    | `set of string * int
    | Var.t
    | Cascading.t
    ]

  let set ?(value = 0) name = `set (name, value)

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `set (name, value) -> (name ^ {js| |js}) ^ string_of_int value
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Content = struct
  type t =
    [ None.t
    | `normal
    | `openQuote
    | `closeQuote
    | `noOpenQuote
    | `noCloseQuote
    | `attr of string
    | `text of string
    | Counter.t
    | Counters.t
    | Image.t
    | Var.t
    | Cascading.t
    ]

  let text_to_string value =
    if Kloth.String.length value = 0 then {js|''|js} (* value = "" -> '' *)
    else if Kloth.String.length value = 1 && Kloth.String.get value 0 = '"' then
      {js|'"'|js}
    else if Kloth.String.length value = 1 && Kloth.String.get value 0 = '\''
    then {js|"'"|js}
    else if
      Kloth.String.length value = 2
      && Kloth.String.get value 0 = '"'
      && Kloth.String.get value 1 = '"'
    then {js|''|js}
    else (
      match Kloth.String.get value 0 with
      | '\'' | '"' -> value
      | _ -> {js|"|js} ^ value ^ {js|"|js})

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `normal -> {js|normal|js}
    | `openQuote -> {js|open-quote|js}
    | `closeQuote -> {js|close-quote|js}
    | `noOpenQuote -> {js|no-open-quote|js}
    | `noCloseQuote -> {js|no-close-quote|js}
    | `attr name -> ({js|attr(|js} ^ name) ^ {js|)|js}
    | `text v -> text_to_string v
    | #Image.t as c -> Image.toString c
    | #Counter.t as c -> Counter.toString c
    | #Counters.t as c -> Counters.toString c
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module SVG = struct
  module Fill = struct
    type t =
      [ None.t
      | `contextFill
      | `contextStroke
      | Color.t
      | Url.t
      ]

    let contextFill = `contextFill
    let contextStroke = `contextStroke

    let toString (x : t) =
      match x with
      | #None.t -> None.toString
      | `contextFill -> {js|context-fill|js}
      | `contextStroke -> {js|context-stroke|js}
      | #Color.t as c -> Color.toString c
      | #Url.t as u -> Url.toString u
  end
end

module TouchAction = struct
  type t =
    [ Auto.t
    | None.t
    | `panX
    | `panY
    | `panLeft
    | `panRight
    | `panUp
    | `panDown
    | `pinchZoom
    | `manipulation
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `panX -> {js|pan-x|js}
    | `panY -> {js|pan-y|js}
    | `panLeft -> {js|pan-left|js}
    | `panRight -> {js|pan-right|js}
    | `panUp -> {js|pan-up|js}
    | `panDown -> {js|pan-down|js}
    | `pinchZoom -> {js|pinch-zoom|js}
    | `manipulation -> {js|manipulation|js}
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module ZIndex = struct
  type t =
    [ Auto.t
    | `num of int
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `num x -> Kloth.Int.to_string x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AlphaValue = struct
  type t =
    [ `num of float
    | Percentage.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `num x -> Kloth.Float.to_string x
    | #Percentage.t as p -> Percentage.toString p
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module LineBreak = struct
  type t =
    [ Auto.t
    | `loose
    | `normal
    | `strict
    | `anywhere
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `loose -> {js|loose|js}
    | `normal -> {js|normal|js}
    | `strict -> {js|strict|js}
    | `anywhere -> {js|anywhere|js}
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module Hyphens = struct
  type t =
    [ None.t
    | `manual
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `manual -> {js|manual|js}
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module TextJustify = struct
  type t =
    [ `interWord
    | `interCharacter
    | Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `interWord -> {js|inter-word|js}
    | `interCharacter -> {js|inter-character|js}
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module OverflowInline = struct
  type t =
    [ `hidden
    | `visible
    | `scroll
    | `clip
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `hidden -> {js|hidden|js}
    | `visible -> {js|visible|js}
    | `scroll -> {js|scroll|js}
    | `clip -> {js|clip|js}
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontSynthesisWeight = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontSynthesisStyle = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontSynthesisSmallCaps = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontSynthesisPosition = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontKerning = struct
  type t =
    [ `normal
    | None.t
    | Var.t
    | Auto.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantPosition = struct
  type t =
    [ `normal
    | `sub
    | `super
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantCaps = struct
  type t =
    [ `normal
    | `smallCaps
    | `allSmallCaps
    | `petiteCaps
    | `allPetiteCaps
    | `unicase
    | `titlingCaps
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `smallCaps -> {js|small-caps|js}
    | `allSmallCaps -> {js|all-small-caps|js}
    | `petiteCaps -> {js|petite-caps|js}
    | `allPetiteCaps -> {js|all-petite-caps|js}
    | `unicase -> {js|unicase|js}
    | `titlingCaps -> {js|titling-caps|js}
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontOpticalSizing = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantEmoji = struct
  type t =
    [ `normal
    | `text
    | `emoji
    | `unicode
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `normal -> {js|normal|js}
    | `text -> {js|text|js}
    | `emoji -> {js|emoji|js}
    | `unicode -> {js|unicode|js}
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module InflexibleBreadth = struct
  type t =
    [ Length.t
    | `minContent
    | `maxContent
    | `auto
    ]

  let toString (x : t) =
    match x with
    | #Length.t as x -> Length.toString x
    | `minContent -> {js|min-content|js}
    | `maxContent -> {js|max-content|js}
    | `auto -> {js|auto|js}
end

module TrackBreadth = struct
  type t =
    [ InflexibleBreadth.t
    | `fr of float
    ]

  let toString (x : t) =
    match x with
    | #InflexibleBreadth.t as x -> InflexibleBreadth.toString x
    | `fr x -> Kloth.Float.to_string x ^ {js|fr|js}
end

module MinMax = struct
  type t = [ `minmax of InflexibleBreadth.t * TrackBreadth.t ]

  let minmax x y : [> t ] = `minmax (x, y)

  let toString (x : t) =
    match x with
    | `minmax (a, b) ->
      {js|minmax(|js}
      ^ InflexibleBreadth.toString a
      ^ {js|,|js}
      ^ TrackBreadth.toString b
      ^ {js|)|js}
end

module TrackSize = struct
  type t =
    [ TrackBreadth.t
    | MinMax.t
    | `fitContent of Length.t
    ]

  let fitContent x : [> t ] = `fitContent x

  let toString (x : t) =
    match x with
    | #TrackBreadth.t as x -> TrackBreadth.toString x
    | #MinMax.t as x -> MinMax.toString x
    | `fitContent x ->
      {js|fit-content|js} ^ {js|(|js} ^ Length.toString x ^ {js|)|js}
end

module GridAutoRows = struct
  type t =
    [ `value of TrackSize.t array
    | Var.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | `value xs ->
      Kloth.Array.map_and_join ~f:TrackSize.toString ~sep:{js| |js} xs
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module GridAutoColumns = struct
  include GridAutoRows
end

module FixedSize = struct
  type t =
    [ Length.t
    | MinMax.t
    ]

  let toString (x : t) =
    match x with
    | #Length.t as x -> Length.toString x
    | #MinMax.t as x -> MinMax.toString x
end

module RepeatValue = struct
  type t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  let toString (x : t) =
    match x with
    | `autoFill -> {js|auto-fill|js}
    | `autoFit -> {js|auto-fit|js}
    | `num x -> Kloth.Int.to_string x
end

module RepeatTrack = struct
  type t =
    [ `lineNames of string
    | FixedSize.t
    | TrackSize.t
    ]

  let toString (x : t) =
    match x with
    | `lineNames name -> name
    | #FixedSize.t as x -> FixedSize.toString x
    | #TrackSize.t as x -> TrackSize.toString x
end

module Repeat = struct
  type t = [ `repeat of RepeatValue.t * RepeatTrack.t array ]

  let repeat x y : [> t ] = `repeat (x, y)

  let toString (x : t) =
    match x with
    | `repeat (n, x) ->
      {js|repeat(|js}
      ^ RepeatValue.toString n
      ^ {js|, |js}
      ^ Kloth.Array.map_and_join ~f:RepeatTrack.toString ~sep:{js| |js} x
      ^ {js|)|js}
end

module Track = struct
  type t =
    [ `lineNames of string
    | `subgrid
    | FixedSize.t
    | Repeat.t
    | TrackSize.t
    ]

  let toString (x : t) =
    match x with
    | `lineNames names -> names
    | `subgrid -> {js|subgrid|js}
    | #FixedSize.t as x -> FixedSize.toString x
    | #Repeat.t as x -> Repeat.toString x
    | #TrackSize.t as x -> TrackSize.toString x
end

module ExplicitTrack = struct
  type t =
    [ `lineNames of string
    | TrackSize.t
    ]

  let toString (x : t) =
    match x with
    | `lineNames names -> names
    | #TrackSize.t as x -> TrackSize.toString x
end

module ExplicitTrackWithArea = struct
  type t =
    [ ExplicitTrack.t
    | `area of string
    ]

  let toString (x : t) =
    match x with
    | `area x -> {js|'|js} ^ x ^ {js|'|js}
    | #ExplicitTrack.t as x -> ExplicitTrack.toString x
end

module GridTemplateRows = struct
  module Value = struct
    type t =
      [ None.t
      | `value of Track.t array
      ]

    let value x : [> t ] = `value x

    let toString (x : t) =
      match x with
      | #None.t -> None.toString
      | `value x -> Kloth.Array.map_and_join ~f:Track.toString ~sep:{js| |js} x
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #Value.t as x -> Value.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module GridTemplateColumns = struct
  include GridTemplateRows
end

module Translate = struct
  module Value = struct
    type t =
      [ Length.t
      | Var.t
      ]

    let toString (x : t) =
      match x with
      | #Length.t as x -> Length.toString x
      | #Var.t as x -> Var.toString x
  end

  type t =
    [ Value.t
    | None.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Value.t as x -> Value.toString x
    | #None.t -> None.toString
    | #Cascading.t as x -> Cascading.toString x
end

module Rotate = struct
  type t =
    [ None.t
    | `rotate of Angle.t
    | `rotateX of Angle.t
    | `rotateY of Angle.t
    | `rotateZ of Angle.t
    | `rotate3d of float * float * float * Angle.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `rotate v -> Angle.toString v
    | `rotateX v -> {js|x |js} ^ Angle.toString v
    | `rotateY v -> {js|y |js} ^ Angle.toString v
    | `rotateZ v -> {js|z |js} ^ Angle.toString v
    | `rotate3d (x, y, z, a) ->
      Kloth.Float.to_string x
      ^ {js| |js}
      ^ Kloth.Float.to_string y
      ^ {js| |js}
      ^ Kloth.Float.to_string z
      ^ {js| |js}
      ^ Angle.toString a
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module Scale = struct
  module Value = struct
    type t =
      [ `num of float
      | Percentage.t
      | Var.t
      ]

    let toString (x : t) =
      match x with
      | `num x -> Kloth.Float.to_string x
      | #Percentage.t as x -> Percentage.toString x
      | #Var.t as x -> Var.toString x
  end

  type t =
    [ Value.t
    | None.t
    | Cascading.t
    ]

  let toString (x : t) =
    match x with
    | #Value.t as x -> Value.toString x
    | #None.t -> None.toString
    | #Cascading.t as x -> Cascading.toString x
end

module GridRowStart = struct
  include GridArea
end

module GridRowEnd = struct
  include GridArea
end

module GridColumnStart = struct
  include GridArea
end

module GridColumnEnd = struct
  include GridArea
end

module GridTemplate = struct
  type t =
    [ None.t
    | `rowsColumns of GridTemplateRows.Value.t * GridTemplateColumns.Value.t
    | `areasRows of ExplicitTrackWithArea.t array
    | `areasRowsColumns of ExplicitTrackWithArea.t array * ExplicitTrack.t array
    | Var.t
    | Cascading.t
    ]

  let rowsColumns x y : [> t ] = `rowsColumns (x, y)
  let areasRows x : [> t ] = `areasRows x
  let areasRowsColumns x y : [> t ] = `areasRowsColumns (x, y)

  let toString (x : t) =
    match x with
    | #None.t -> None.toString
    | `rowsColumns (r, c) ->
      GridTemplateRows.Value.toString r
      ^ {js| / |js}
      ^ GridTemplateColumns.Value.toString c
    | `areasRows x ->
      Kloth.Array.map_and_join ~sep:{js| |js} ~f:ExplicitTrackWithArea.toString
        x
    | `areasRowsColumns (ar, c) ->
      Kloth.Array.map_and_join ~sep:{js| |js} ~f:ExplicitTrackWithArea.toString
        ar
      ^ {js| / |js}
      ^ Kloth.Array.map_and_join ~sep:{js| |js} ~f:ExplicitTrack.toString c
    | #Var.t as x -> Var.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Bottom = struct
  type t =
    [ Length.t
    | Cascading.t
    | Var.t
    ]

  let toString (x : t) =
    match x with
    | #Length.t as x -> Length.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module Top = struct
  include Bottom
end

module Right = struct
  include Bottom
end

module Left = struct
  include Bottom
end
