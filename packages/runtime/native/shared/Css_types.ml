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

  let toString x =
    match x with
    | `initial -> {js|initial|js}
    | `inherit_ -> {js|inherit|js}
    | `unset -> {js|unset|js}
    | `revert -> {js|revert|js}
    | `revertLayer -> {js|revert-layer|js}
end

module Var = struct
  type t =
    [ `var of string
    | `varDefault of string * string
    ]

  let var x = `var x
  let varDefault x default = `varDefault (x, default)

  let prefix x =
    if Kloth.String.startsWith ~prefix:{js|--|js} x then x else {js|--|js} ^ x

  let toString x =
    match x with
    | `var x -> ({js|var(|js} ^ prefix x) ^ {js|)|js}
    | `varDefault (x, v) -> {js|var(|js} ^ prefix x ^ {js|,|js} ^ v ^ {js|)|js}
end

let max_or_min_values fn values =
  Kloth.Array.joinWithMap ~sep:{js|, |js} ~f:(fun v -> {js| |js} ^ fn v) values

let calc_min_max_num_to_string fn = function
  | `calc (`add (a, b)) -> {js|calc(|js} ^ fn a ^ {js| + |js} ^ fn b ^ {js|)|js}
  | `calc (`sub (a, b)) -> {js|calc(|js} ^ fn a ^ {js| - |js} ^ fn b ^ {js|)|js}
  | `calc (`mult (a, b)) ->
    {js|calc(|js} ^ fn a ^ {js| * |js} ^ fn b ^ {js|)|js}
  | `num n -> Kloth.Float.toString n
  | `min xs -> {js|min(|js} ^ max_or_min_values fn xs ^ {js|)|js}
  | `max xs -> {js|max(|js} ^ max_or_min_values fn xs ^ {js|)|js}

let calc_min_max_to_string x =
  let aux fn fn' x' =
    match x' with
    | `add (x, y) -> {js|calc(|js} ^ fn x ^ {js| + |js} ^ fn y ^ {js|)|js}
    | `sub (x, y) -> {js|calc(|js} ^ fn x ^ {js| - |js} ^ fn y ^ {js|)|js}
    | `mult (x, y) -> {js|calc(|js} ^ fn x ^ {js| * |js} ^ fn y ^ {js|)|js}
    | (`min _ | `max _) as x -> fn' x
  in
  aux x

module Time = struct
  type time =
    [ `s of int
    | `ms of int
    ]

  type calc_value =
    [ time
    | `calc of
      [ time
      | `add of calc_value * calc_value
      | `sub of calc_value * calc_value
      | `mult of calc_value * calc_value
      ]
    | `min of t array
    | `max of t array
    | `num of float
    ]

  and t =
    [ time
    | `min of t array
    | `max of t array
    | `calc of
      [ time
      | `add of calc_value * calc_value
      | `sub of calc_value * calc_value
      | `mult of calc_value * calc_value
      ]
    ]

  let s x = `s x
  let ms x = `ms x

  let rec toString x =
    match x with
    | `s t -> Kloth.Int.toString t ^ {js|s|js}
    | `ms t -> Kloth.Int.toString t ^ {js|ms|js}
    | `calc calc -> string_of_calc_min_max calc
    | (`min _ | `max _) as x -> minmax_to_string x

  and minmax_to_string = function
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      calc_min_max_num_to_string toString x
    | #time as t -> toString t

  and calc_value_to_string x =
    match x with
    | `num x -> Kloth.Float.toString x
    | `calc calc -> string_of_calc_min_max calc
    | (`min _ | `max _) as x -> minmax_to_string x
    | #time as t -> toString t

  and string_of_calc_min_max calc =
    match calc with
    | (`add _ | `sub _ | `mult _ | `min _ | `max _) as x ->
      calc_min_max_to_string calc_value_to_string minmax_to_string x
    | #time as t -> toString t
end

module Percentage = struct
  type t = [ `percent of float ]

  let pct x = `percent x

  let toString x =
    match x with `percent x -> Kloth.Float.toString x ^ {js|%|js}
end

module Url = struct
  type t = [ `url of string ]

  let toString x = match x with `url s -> ({js|url(|js} ^ s) ^ {js|)|js}
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
    | `percent of float
    ]

  type calc_value =
    [ length
    | `calc of
      [ length
      | `add of calc_value * calc_value
      | `sub of calc_value * calc_value
      | `mult of calc_value * calc_value
      ]
    | `min of t array
    | `max of t array
    | `num of float
    ]

  and t =
    [ length
    | `calc of
      [ length
      | `add of calc_value * calc_value
      | `sub of calc_value * calc_value
      | `mult of calc_value * calc_value
      ]
    | `min of t array
    | `max of t array
    ]

  let ch x = `ch x
  let cqw x = `cqw x
  let cqh x = `cqh x
  let cqi x = `cqi x
  let cqb x = `cqb x
  let cqmin x = `cqmin x
  let cqmax x = `cqmax x
  let em x = `em x
  let ex x = `ex x
  let rem x = `rem x
  let vh x = `vh x
  let vw x = `vw x
  let vmin x = `vmin x
  let vmax x = `vmax x
  let px x = `px x
  let pxFloat x = `pxFloat x
  let cm x = `cm x
  let mm x = `mm x
  let inch x = `inch x
  let pc x = `pc x
  let pt x = `pt x
  let zero = `zero

  let rec toString x =
    match x with
    | `ch x -> Kloth.Float.toString x ^ {js|ch|js}
    | `cqw x -> Kloth.Float.toString x ^ {js|cqw|js}
    | `cqh x -> Kloth.Float.toString x ^ {js|cqh|js}
    | `cqi x -> Kloth.Float.toString x ^ {js|cqi|js}
    | `cqb x -> Kloth.Float.toString x ^ {js|cqb|js}
    | `cqmin x -> Kloth.Float.toString x ^ {js|cqmin|js}
    | `cqmax x -> Kloth.Float.toString x ^ {js|cqmax|js}
    | `em x -> Kloth.Float.toString x ^ {js|em|js}
    | `ex x -> Kloth.Float.toString x ^ {js|ex|js}
    | `rem x -> Kloth.Float.toString x ^ {js|rem|js}
    | `vh x -> Kloth.Float.toString x ^ {js|vh|js}
    | `vw x -> Kloth.Float.toString x ^ {js|vw|js}
    | `vmin x -> Kloth.Float.toString x ^ {js|vmin|js}
    | `vmax x -> Kloth.Float.toString x ^ {js|vmax|js}
    | `px x -> Kloth.Int.toString x ^ {js|px|js}
    | `pxFloat x -> Kloth.Float.toString x ^ {js|px|js}
    | `cm x -> Kloth.Float.toString x ^ {js|cm|js}
    | `mm x -> Kloth.Float.toString x ^ {js|mm|js}
    | `inch x -> Kloth.Float.toString x ^ {js|in|js}
    | `pc x -> Kloth.Float.toString x ^ {js|pc|js}
    | `pt x -> Kloth.Int.toString x ^ {js|pt|js}
    | `zero -> {js|0|js}
    | `calc calc -> string_of_calc_min_max calc
    | `percent x -> Kloth.Float.toString x ^ {js|%|js}
    | (`min _ | `max _) as x -> minmax_to_string x

  and calc_value_to_string x =
    match x with
    | `num x -> Kloth.Float.toString x
    | `calc calc -> string_of_calc_min_max calc
    | (`min _ | `max _) as x -> minmax_to_string x
    | #length as t -> toString t

  and string_of_calc_min_max calc =
    match calc with
    | (`add _ | `sub _ | `mult _ | `min _ | `max _) as x ->
      calc_min_max_to_string calc_value_to_string minmax_to_string x
    | #length as l -> toString l

  and minmax_to_string = function
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      calc_min_max_num_to_string toString x
    | #length as l -> toString l
end

module Angle = struct
  type t =
    [ `deg of float
    | `rad of float
    | `grad of float
    | `turn of float
    ]

  let deg (x : float) = `deg x
  let rad (x : float) = `rad x
  let grad (x : float) = `grad x
  let turn (x : float) = `turn x

  let toString x =
    match x with
    | `deg x -> Kloth.Float.toString x ^ {js|deg|js}
    | `rad x -> Kloth.Float.toString x ^ {js|rad|js}
    | `grad x -> Kloth.Float.toString x ^ {js|grad|js}
    | `turn x -> Kloth.Float.toString x ^ {js|turn|js}
end

module Direction = struct
  type t =
    [ `ltr
    | `rtl
    ]

  let ltr = `ltr
  let rtl = `rtl
  let toString x = match x with `ltr -> {js|ltr|js} | `rtl -> {js|rtl|js}
end

(* Don't confuse with Position (from object-position or background-position) *)
module PropertyPosition = struct
  type t =
    [ `absolute
    | `relative
    | `static
    | `fixed
    | `sticky
    ]

  let absolute = `absolute
  let relative = `relative
  let static = `static
  let fixed = `fixed
  let sticky = `sticky

  let toString x =
    match x with
    | `absolute -> {js|absolute|js}
    | `relative -> {js|relative|js}
    | `static -> {js|static|js}
    | `fixed -> {js|fixed|js}
    | `sticky -> {js|sticky|js}
end

module Isolation = struct
  type t =
    [ `auto
    | `isolate
    ]

  let toString x =
    match x with `auto -> {js|auto|js} | `isolate -> {js|isolate|js}
end

module AspectRatio = struct
  type t =
    [ `auto
    | `num of float
    | `ratio of int * int
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `num num -> Kloth.Float.toString num
    | `ratio (up, down) ->
      Kloth.Int.toString up ^ {js| / |js} ^ Kloth.Int.toString down
end

module Resize = struct
  type t =
    [ `none
    | `both
    | `horizontal
    | `vertical
    | `block
    | `inline
    ]

  let none = `none
  let both = `both
  let horizontal = `horizontal
  let vertical = `vertical
  let block = `block
  let inline = `inline

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `both -> {js|both|js}
    | `horizontal -> {js|horizontal|js}
    | `vertical -> {js|vertical|js}
    | `block -> {js|block|js}
    | `inline -> {js|inline|js}
end

module FontVariant = struct
  type t =
    [ `normal
    | `smallCaps
    ]

  let normal = `normal
  let smallCaps = `smallCaps

  let toString x =
    match x with `normal -> {js|normal|js} | `smallCaps -> {js|smallCaps|js}
end

module FontStyle = struct
  type t =
    [ `normal
    | `italic
    | `oblique
    ]

  let normal = `normal
  let italic = `italic
  let oblique = `oblique

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `italic -> {js|italic|js}
    | `oblique -> {js|oblique|js}
end

module TabSize = struct
  type t = [ `num of float ]

  let toString = function `num n -> Kloth.Float.toString n
end

module FlexBasis = struct
  type t =
    [ `auto
    | `fill
    | `content
    | `maxContent
    | `minContent
    | `fitContent
    ]

  let fill = `fill
  let content = `content
  let maxContent = `maxContent
  let minContent = `minContent
  let fitContent = `fitContent

  let toString x =
    match x with
    | `auto -> {js|auto|js}
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
    | `auto
    | `clip
    ]

  let hidden = `hidden
  let visible = `visible
  let scroll = `scroll
  let auto = `auto
  let clip = `clip

  let toString x =
    match x with
    | `hidden -> {js|hidden|js}
    | `visible -> {js|visible|js}
    | `scroll -> {js|scroll|js}
    | `auto -> {js|auto|js}
    | `clip -> {js|clip|js}
end

module Margin = struct
  type t = [ `auto ]

  let auto = `auto
  let toString x = match x with `auto -> {js|auto|js}
end

module GridAutoFlow = struct
  type t =
    [ `column
    | `row
    | `columnDense
    | `rowDense
    ]

  let toString x =
    match x with
    | `column -> {js|column|js}
    | `row -> {js|row|js}
    | `columnDense -> {js|column dense|js}
    | `rowDense -> {js|row dense|js}
end

module Gap = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {js|normal|js}
end

module RowGap = Gap
module ColumnGap = Gap

module ScrollBehavior = struct
  type t =
    [ `auto
    | `smooth
    ]

  let toString x =
    match x with `auto -> {js|auto|js} | `smooth -> {js|smooth|js}
end

module OverscrollBehavior = struct
  type t =
    [ `auto
    | `contain
    | `none
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `contain -> {js|contain|js}
    | `none -> {js|none|js}
end

module OverflowAnchor = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module ColumnWidth = struct
  type t = [ `auto ]

  let toString x = match x with `auto -> {js|auto|js}
end

module CaretColor = struct
  type t = [ `auto ]

  let toString x = match x with `auto -> {js|auto|js}
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
    ]

  let toString x =
    match x with
    | `baseline -> {js|baseline|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
    | `top -> {js|top|js}
    | `textTop -> {js|text-top|js}
    | `middle -> {js|middle|js}
    | `bottom -> {js|bottom|js}
    | `textBottom -> {js|text-bottom|js}
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

  let toString x =
    match x with
    | `linear -> {js|linear|js}
    | `ease -> {js|ease|js}
    | `easeIn -> {js|ease-in|js}
    | `easeOut -> {js|ease-out|js}
    | `easeInOut -> {js|ease-in-out|js}
    | `stepStart -> {js|step-start|js}
    | `stepEnd -> {js|step-end|js}
    | `steps (i, `start) ->
      ({js|steps(|js} ^ Kloth.Int.toString i) ^ {js|, start)|js}
    | `steps (i, `end_) ->
      ({js|steps(|js} ^ Kloth.Int.toString i) ^ {js|, end)|js}
    | `cubicBezier (a, b, c, d) ->
      {js|cubic-bezier(|js}
      ^ Kloth.Float.toString a
      ^ {js|, |js}
      ^ Kloth.Float.toString b
      ^ {js|, |js}
      ^ Kloth.Float.toString c
      ^ {js|, |js}
      ^ Kloth.Float.toString d
      ^ {js|)|js}
    | `jumpStart -> {js|jump-start|js}
    | `jumpEnd -> {js|jump-end|js}
    | `jumpNone -> {js|jump-none|js}
    | `jumpBoth -> {js|jump-both|js}
end

module RepeatValue = struct
  type t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  let toString x =
    match x with
    | `autoFill -> {js|auto-fill|js}
    | `autoFit -> {js|auto-fit|js}
    | `num x -> Kloth.Int.toString x
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
    | `none
    ]

  let toString x =
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
    | `none -> {js|none|js}
end

module ListStylePosition = struct
  type t =
    [ `inside
    | `outside
    ]

  let toString x =
    match x with `inside -> {js|inside|js} | `outside -> {js|outside|js}
end

module OutlineStyle = struct
  type t =
    [ `none
    | `auto
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

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `auto -> {js|auto|js}
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

  let toString x =
    match x with
    | `num n -> Kloth.Int.toString n
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

  let toString x =
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
    ^ Kloth.Float.toString x
    ^ {js|, |js}
    ^ Kloth.Float.toString y
    ^ {js|)|js}

  let string_of_translate3d x y z =
    {js|translate3d(|js}
    ^ Length.toString x
    ^ {js|, |js}
    ^ Length.toString y
    ^ {js|, |js}
    ^ Length.toString z
    ^ {js|)|js}

  let toString x =
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
      ^ Kloth.Float.toString x
      ^ {js|, |js}
      ^ Kloth.Float.toString y
      ^ {js|, |js}
      ^ Kloth.Float.toString z
      ^ {js|)|js}
    | `scaleX x -> {js|scaleX(|js} ^ Kloth.Float.toString x ^ {js|)|js}
    | `scaleY y -> {js|scaleY(|js} ^ Kloth.Float.toString y ^ {js|)|js}
    | `scaleZ z -> {js|scaleZ(|js} ^ Kloth.Float.toString z ^ {js|)|js}
    | `rotate a -> {js|rotate(|js} ^ Angle.toString a ^ {js|)|js}
    | `rotate3d (x, y, z, a) ->
      {js|rotate3d(|js}
      ^ Kloth.Float.toString x
      ^ {js|, |js}
      ^ Kloth.Float.toString y
      ^ {js|, |js}
      ^ Kloth.Float.toString z
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
    | `perspective x -> {js|perspective(|js} ^ Kloth.Int.toString x ^ {js|)|js}
end

module AnimationName = struct
  type t
end

module AnimationDirection = struct
  type t =
    [ `normal
    | `reverse
    | `alternate
    | `alternateReverse
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `reverse -> {js|reverse|js}
    | `alternate -> {js|alternate|js}
    | `alternateReverse -> {js|alternate-reverse|js}
end

module AnimationFillMode = struct
  type t =
    [ `none
    | `forwards
    | `backwards
    | `both
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `forwards -> {js|forwards|js}
    | `backwards -> {js|backwards|js}
    | `both -> {js|both|js}
end

module AnimationIterationCount = struct
  type t =
    [ `count of float
    | `infinite
    ]

  let toString x =
    match x with
    | `count x -> Kloth.Float.toString x
    | `infinite -> {js|infinite|js}
end

module AnimationPlayState = struct
  type t =
    [ `paused
    | `running
    ]

  let toString x =
    match x with `paused -> {js|paused|js} | `running -> {js|running|js}
end

module Cursor = struct
  type t =
    [ `auto
    | `default
    | `none
    | `contextMenu
    | `help
    | `pointer
    | `progress
    | `wait
    | `cell
    | `crosshair
    | `text
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

  let toString x =
    match x with
    | `_moz_grab -> {|-moz-grab|}
    | `_moz_grabbing -> {|-moz-grabbing|}
    | `_moz_zoom_in -> {|-moz-zoom-in|}
    | `_moz_zoom_out -> {|-moz-zoom-out|}
    | `_webkit_grab -> {|-webkit-grab|}
    | `_webkit_grabbing -> {|-webkit-grabbing|}
    | `_webkit_zoom_in -> {|-webkit-zoom-in|}
    | `_webkit_zoom_out -> {|-webkit-zoom-out|}
    | `alias -> {js|alias|js}
    | `allScroll -> {js|all-scroll|js}
    | `auto -> {js|auto|js}
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
    | `none -> {js|none|js}
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
end

module ColorMixMethod = struct
  module PolarColorSpace = struct
    type t =
      [ `hsl
      | `hwb
      | `lch
      | `oklch
      ]

    let toString = function
      | `hsl -> {js|hsl|js}
      | `hwb -> {js|hwb|js}
      | `lch -> {js|lch|js}
      | `oklch -> {js|oklch|js}
  end

  module Rectangular_or_Polar_color_space = struct
    type t =
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
      | PolarColorSpace.t
      ]

    let toString = function
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
      | `hsl -> {js|hsl|js}
      | `hwb -> {js|hwb|js}
      | `lch -> {js|lch|js}
      | `oklch -> {js|oklch|js}
  end

  module HueSize = struct
    type t =
      [ `shorter
      | `longer
      | `increasing
      | `decreasing
      ]

    let toString = function
      | `shorter -> {js|shorter|js}
      | `longer -> {js|longer|js}
      | `increasing -> {js|increasing|js}
      | `decreasing -> {js|decreasing|js}
  end

  type t =
    [ `in1 of Rectangular_or_Polar_color_space.t
    | `in2 of PolarColorSpace.t * HueSize.t
    ]
end

module Color = struct
  type rgb = int * int * int

  type 'a calc_min_max =
    (*TODO: Support `num on calc *)
    [ `calc of [ `add of 'a * 'a | `sub of 'a * 'a | `mult of 'a * 'a ]
    | `min of 'a array
    | `max of 'a array
    ]

  type rgba =
    int
    * int
    * int
    * [ `num of float | Percentage.t | Percentage.t calc_min_max ]

  type hsl =
    [ Angle.t | Angle.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]

  type hsla =
    [ Angle.t | Angle.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]
    * [ `num of float | `percent of float | Percentage.t calc_min_max ]

  type 'a colorMix =
    ColorMixMethod.t * ('a * Percentage.t) * ('a * Percentage.t)

  type t =
    [ `rgb of rgb
    | `colorMix of t colorMix
    | `rgba of rgba
    | `hsl of hsl
    | `hsla of hsla
    | `hex of string
    | `transparent
    | `currentColor
    ]

  let rgb r g b = `rgb (r, g, b)
  let rgba r g b a = `rgba (r, g, b, a)
  let hsl h s l = `hsl (h, s, l)
  let hsla h s l a = `hsla (h, s, l, a)
  let hex x = `hex x
  let transparent = `transparent
  let currentColor = `currentColor

  let string_of_angle x =
    match x with
    | (`calc _ | `min _ | `max _) as x ->
      calc_min_max_num_to_string Angle.toString x
    | #Angle.t as pc -> Angle.toString pc

  let string_of_alpha x =
    match x with
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      calc_min_max_num_to_string Percentage.toString x
    | #Percentage.t as pc -> Percentage.toString pc

  let string_of_alpha' x =
    match x with
    | (`calc _ | `min _ | `max _) as x ->
      calc_min_max_num_to_string Percentage.toString x
    | #Percentage.t as pc -> Percentage.toString pc

  let rgb_to_string r g b =
    Kloth.Int.toString r
    ^ {js|, |js}
    ^ Kloth.Int.toString g
    ^ {js|, |js}
    ^ Kloth.Int.toString b

  let rec toString x =
    match x with
    | `colorMix (method', color_x, color_y) ->
      {js|color-mix(|js}
      ^ (match method' with
        | `in1 x -> ColorMixMethod.Rectangular_or_Polar_color_space.toString x
        | `in2 (x, y) ->
          ColorMixMethod.PolarColorSpace.toString x
          ^ {js| |js}
          ^ ColorMixMethod.HueSize.toString y)
      ^ {js|, |js}
      ^ string_of_color color_x color_y
      ^ {js|)|js}
    | `rgb (r, g, b) -> {js|rgb(|js} ^ rgb_to_string r g b ^ {js|)|js}
    | `rgba (r, g, b, a) ->
      {js|rgba(|js}
      ^ rgb_to_string r g b
      ^ {js|, |js}
      ^ string_of_alpha a
      ^ {js|)|js}
    | `hsl (h, s, l) ->
      {js|hsl(|js}
      ^ string_of_angle h
      ^ {js|, |js}
      ^ string_of_alpha' s
      ^ {js|, |js}
      ^ string_of_alpha' l
      ^ {js|)|js}
    | `hsla (h, s, l, a) ->
      {js|hsla(|js}
      ^ string_of_angle h
      ^ {js|, |js}
      ^ string_of_alpha' s
      ^ {js|, |js}
      ^ string_of_alpha' l
      ^ {js|, |js}
      ^ string_of_alpha a
      ^ {js|)|js}
    | `hex s -> {js|#|js} ^ s
    | `transparent -> {js|transparent|js}
    | `currentColor -> {js|currentColor|js}

  and string_of_color x y =
    string_of_actual_color x ^ {js|, |js} ^ string_of_actual_color y

  and string_of_actual_color = function
    | color, percent -> toString color ^ {js| |js} ^ Percentage.toString percent
end

module BorderStyle = struct
  type t =
    [ `none
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

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `hidden -> {js|hidden|js}
    | `dotted -> {js|dotted|js}
    | `dashed -> {js|dashed|js}
    | `solid -> {js|solid|js}
    | `double -> {js|double|js}
    | `groove -> {js|groove|js}
    | `ridge -> {js|ridge|js}
    | `inset -> {js|inset|js}
    | `outset -> {js|outset|js}
end

module PointerEvents = struct
  type t =
    [ `auto
    | `none
    | `visiblePainted
    | `visibleFill
    | `visibleStroke
    | `visible
    | `painted
    | `fill
    | `stroke
    | `all
    | `inherit_
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `none -> {js|none|js}
    | `visiblePainted -> {js|visiblePainted|js}
    | `visibleFill -> {js|visibleFill|js}
    | `visibleStroke -> {js|visibleStroke|js}
    | `visible -> {js|visible|js}
    | `painted -> {js|painted|js}
    | `fill -> {js|fill|js}
    | `stroke -> {js|stroke|js}
    | `all -> {js|all|js}
    | `inherit_ -> {js|inherit|js}
end

module Perspective = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module LetterSpacing = struct
  type t = [ `normal ]

  let normal = `normal
  let toString x = match x with `normal -> {js|normal|js}
end

module LineHeight = struct
  type t =
    [ `normal
    | `abs of float
    ]

  let toString x =
    match x with `normal -> {js|normal|js} | `abs x -> Kloth.Float.toString x
end

module LineWidth = struct
  type t =
    [ Length.t
    | `thin
    | `medium
    | `thick
    ]

  let toString x =
    match x with
    | `thin -> {js|thin|js}
    | `medium -> {js|medium|js}
    | `thick -> {js|thick|js}
    | #Length.t as l -> Length.toString l
end

module WordSpacing = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {js|normal|js}
end

module DisplayOld = struct
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

module DisplayOutside = struct
  type t =
    [ `block
    | `inline
    | `runIn
    ]

  let toString x =
    match x with
    | `block -> {js|block|js}
    | `inline -> {js|inline|js}
    | `runIn -> {js|run-in|js}
end

module DisplayInside = struct
  type t =
    [ `table
    | `flex
    | `grid
    ]

  let toString x =
    match x with
    | `table -> {js|table|js}
    | `flex -> {js|flex|js}
    | `grid -> {js|grid|js}
end

module DisplayListItem = struct
  type t = [ `listItem ]

  let toString x = match x with `listItem -> {js|list-item|js}
end

module DisplayInternal = struct
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

  let toString x =
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

module DisplayBox = struct
  type t =
    [ `contents
    | `none
    ]

  let toString x =
    match x with `contents -> {js|contents|js} | `none -> {js|none|js}
end

module DisplayLegacy = struct
  type t =
    [ `inlineBlock
    | `inlineFlex
    | `inlineGrid
    | `inlineTable
    ]

  let toString x =
    match x with
    | `inlineBlock -> {js|inline-block|js}
    | `inlineFlex -> {js|inline-flex|js}
    | `inlineGrid -> {js|inline-grid|js}
    | `inlineTable -> {js|inline-table|js}
end

module JustifySelf = struct
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `normal -> {js|normal|js}
    | `stretch -> {js|stretch|js}
end

module TextEmphasisStyle = struct
  module FilledOrOpen = struct
    type t =
      [ `filled
      | `open_
      ]

    let toString x =
      match x with `filled -> {js|filled|js} | `open_ -> {js|open|js}
  end

  module Shape = struct
    type t =
      [ `dot
      | `circle
      | `double_circle
      | `triangle
      | `sesame
      ]

    let toString x =
      match x with
      | `dot -> {js|dot|js}
      | `circle -> {js|circle|js}
      | `double_circle -> {js|double-circle|js}
      | `triangle -> {js|triangle|js}
      | `sesame -> {js|sesame|js}
  end

  type t =
    [ `none
    | FilledOrOpen.t
    | Shape.t
    | `string of string
    ]

  let toString x =
    match x with
    | `none | `filled -> {js|filled|js}
    | `open_ -> {js|open|js}
    | `dot -> {js|dot|js}
    | `circle -> {js|circle|js}
    | `double_circle -> {js|double-circle|js}
    | `triangle -> {js|triangle|js}
    | `sesame -> {js|sesame|js}
    | `string s -> s
end

module TextEmphasisPosition = struct
  module LeftRightAlignment = struct
    type t =
      [ `left
      | `right
      ]

    let toString x =
      match x with `left -> {js|left|js} | `right -> {js|right|js}
  end

  module OverOrUnder = struct
    type t =
      [ `over
      | `under
      ]

    let toString x =
      match x with `over -> {js|over|js} | `under -> {js|under|js}
  end
end

module Position = struct
  type t =
    [ `top
    | `bottom
    | `left
    | `right
    | `center
    | Percentage.t
    | Length.t
    ]

  let toString p =
    match p with
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `baseline -> {js|baseline|js}
    | `firstBaseline -> {js|first baseline|js}
    | `lastBaseline -> {js|last baseline|js}
end

module NormalAlignment = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {js|normal|js}
end

module DistributedAlignment = struct
  type t =
    [ `spaceBetween
    | `spaceAround
    | `spaceEvenly
    | `stretch
    ]

  let toString x =
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

  let toString x =
    match x with
    | `legacy -> {js|legacy|js}
    | `legacyRight -> {js|legacy right|js}
    | `legacyLeft -> {js|legacy left|js}
    | `legacyCenter -> {js|legacy center|js}
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
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
    | `justifyAll -> {js|justify-all|js}
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
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
end

module TextAlignLast = struct
  type t =
    [ `auto
    | `start
    | `end_
    | `left
    | `right
    | `center
    | `justify
    | `matchParent
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | `justify -> {js|justify|js}
    | `matchParent -> {js|match-parent|js}
end

module WordBreak = struct
  type t =
    [ `normal
    | `breakAll
    | `keepAll
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `breakAll -> {js|break-all|js}
    | `keepAll -> {js|keep-all|js}
end

module WhiteSpace = struct
  type t =
    [ `normal
    | `nowrap
    | `pre
    | `preLine
    | `preWrap
    | `breakSpaces
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `nowrap -> {js|nowrap|js}
    | `pre -> {js|pre|js}
    | `preLine -> {js|pre-line|js}
    | `preWrap -> {js|pre-wrap|js}
    | `breakSpaces -> {js|break-spaces|js}
end

module AlignItems = struct
  type t =
    [ `normal
    | `stretch
    ]

  let toString x =
    match x with `normal -> {js|normal|js} | `stretch -> {js|stretch|js}
end

module AlignSelf = struct
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `normal -> {js|normal|js}
    | `stretch -> {js|stretch|js}
end

module AlignContent = struct
  type t =
    [ `center
    | `start
    | `end_
    | `flexStart
    | `flexEnd
    ]

  let toString x =
    match x with
    | `center -> {js|center|js}
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `flexStart -> {js|flex-start|js}
    | `flexEnd -> {js|flex-end|js}
end

module ObjectFit = struct
  type t =
    [ `fill
    | `contain
    | `cover
    | `none
    | `scaleDown
    ]

  let toString x =
    match x with
    | `fill -> {js|fill|js}
    | `contain -> {js|contain|js}
    | `cover -> {js|cover|js}
    | `none -> {js|none|js}
    | `scaleDown -> {js|scale-down|js}
end

module Clear = struct
  type t =
    [ `none
    | `left
    | `right
    | `both
    | `inlineStart
    | `inlineEnd
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `both -> {js|both|js}
    | `inlineStart -> {js|inline-start|js}
    | `inlineEnd -> {js|inline-end|js}
end

module Float = struct
  type t =
    [ `left
    | `right
    | `none
    | `inlineStart
    | `inlineEnd
    ]

  let toString x =
    match x with
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `none -> {js|none|js}
    | `inlineStart -> {js|inline-start|js}
    | `inlineEnd -> {js|inline-end|js}
end

module Visibility = struct
  type t =
    [ `visible
    | `hidden
    | `collapse
    ]

  let toString x =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | `collapse -> {js|collapse|js}
end

module TableLayout = struct
  type t =
    [ `auto
    | `fixed
    ]

  let toString x =
    match x with `auto -> {js|auto|js} | `fixed -> {js|fixed|js}
end

module BorderImageSource = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module BorderCollapse = struct
  type t =
    [ `collapse
    | `separate
    ]

  let toString x =
    match x with `collapse -> {js|collapse|js} | `separate -> {js|separate|js}
end

module FlexWrap = struct
  type t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    ]

  let toString x =
    match x with
    | `nowrap -> {js|nowrap|js}
    | `wrap -> {js|wrap|js}
    | `wrapReverse -> {js|wrap-reverse|js}
end

module FlexDirection = struct
  type t =
    [ `row
    | `rowReverse
    | `column
    | `columnReverse
    ]

  let toString x =
    match x with
    | `row -> {js|row|js}
    | `rowReverse -> {js|row-reverse|js}
    | `column -> {js|column|js}
    | `columnReverse -> {js|column-reverse|js}
end

module BoxSizing = struct
  type t =
    [ `contentBox
    | `borderBox
    ]

  let toString x =
    match x with
    | `contentBox -> {js|content-box|js}
    | `borderBox -> {js|border-box|js}
end

module ColumnCount = struct
  type t =
    [ `auto
    | `count of int
    ]

  let toString x =
    match x with `auto -> {js|auto|js} | `count v -> Kloth.Int.toString v
end

module UserSelect = struct
  type t =
    [ `none
    | `auto
    | `text
    | `contain
    | `all
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `auto -> {js|auto|js}
    | `text -> {js|text|js}
    | `contain -> {js|contain|js}
    | `all -> {js|all|js}
end

module TextTransform = struct
  type t =
    [ `none
    | `capitalize
    | `uppercase
    | `lowercase
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `capitalize -> {js|capitalize|js}
    | `uppercase -> {js|uppercase|js}
    | `lowercase -> {js|lowercase|js}
end

module GridTemplateAreas = struct
  type t =
    [ `none
    | `areas of string array
    ]

  let areas x = `areas x

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `areas items ->
      String.trim
        (Kloth.Array.reduce items {js||js} (fun carry item ->
             carry ^ {js|'|js} ^ item ^ {js|' |js}))
end

module GridArea = struct
  type t =
    [ `auto
    | `ident of string
    | `num of int
    | `numIdent of int * string
    | `span of [ `num of int | `ident of string ]
    ]

  let auto = `auto
  let ident x = `ident x
  let num x = `num x
  let numIdent x y = `numIdent (x, y)
  let span x = `span x

  let toString t =
    match t with
    | `auto -> {js|auto|js}
    | `ident s -> s
    | `num i -> string_of_int i
    | `numIdent (i, s) -> (string_of_int i ^ {js| |js}) ^ s
    | `span e ->
      {js|span |js} ^ (match e with `num i -> string_of_int i | `ident s -> s)
end

module Filter = struct
  type t =
    [ `none
    | `blur of Length.t
    | `brightness of [ `percent of float | `num of float ]
    | `contrast of [ `percent of float | `num of float ]
    | `dropShadow of Length.t * Length.t * Length.t * [ Color.t | Var.t ]
    | `grayscale of [ `percent of float | `num of float ]
    | `hueRotate of Angle.t
    | `invert of [ `percent of float | `num of float ]
    | `opacity of [ `percent of float | `num of float ]
    | `saturate of [ `percent of float | `num of float ]
    | `sepia of [ `percent of float | `num of float ]
    | Url.t
    | Var.t
    | Cascading.t
    ]

  let string_of_amount x =
    match x with
    | `percent v -> Kloth.Float.toString v ^ {js|%|js}
    | `num v -> Kloth.Float.toString v

  let toString x =
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
      ^ (match (d : [ Color.t | Var.t ]) with
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v)
      ^ {js|)|js}
    | `grayscale v -> {js|grayscale(|js} ^ string_of_amount v ^ {js|%)|js}
    | `hueRotate v -> {js|hue-rotate(|js} ^ Angle.toString v ^ {js|)|js}
    | `invert v -> {js|invert(|js} ^ string_of_amount v ^ {js|%)|js}
    | `opacity v -> {js|opacity(|js} ^ string_of_amount v ^ {js|%)|js}
    | `saturate v -> {js|saturate(|js} ^ string_of_amount v ^ {js|%)|js}
    | `sepia v -> {js|sepia(|js} ^ string_of_amount v ^ {js|%)|js}
    | `none -> {js|none|js}
    | #Url.t as u -> Url.toString u
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundAttachment = struct
  type t =
    [ `scroll
    | `fixed
    | `local
    ]

  let toString x =
    match x with
    | `scroll -> {js|scroll|js}
    | `fixed -> {js|fixed|js}
    | `local -> {js|local|js}
end

module BackgroundClip = struct
  type t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    | `text
    ]

  let toString x =
    match x with
    | `borderBox -> {js|border-box|js}
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `text -> {js|text|js}
end

module BackgroundOrigin = struct
  type t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    ]

  let toString x =
    match x with
    | `borderBox -> {js|border-box|js}
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
end

module MaskPosition = struct
  module X = struct
    type t =
      [ `left
      | `right
      | `center
      ]

    let toString x =
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

    let toString x =
      match x with
      | `top -> {js|top|js}
      | `bottom -> {js|bottom|js}
      | `center -> {js|center|js}
  end

  type t =
    [ X.t
    | Y.t
    ]

  let toString x =
    match x with
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `center -> {js|center|js}
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
    ]

  type horizontal = twoValue
  type vertical = twoValue

  let toString x =
    match x with
    | `repeatX -> {js|repeat-x|js}
    | `repeatY -> {js|repeat-y|js}
    | `repeat -> {js|repeat|js}
    | `space -> {js|space|js}
    | `round -> {js|round|js}
    | `noRepeat -> {js|no-repeat|js}
end

module TextOverflow = struct
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    ]

  let toString x =
    match x with
    | `clip -> {js|clip|js}
    | `ellipsis -> {js|ellipsis|js}
    | `string s -> s
end

module TextDecorationLine = struct
  type t =
    [ `none
    | `underline
    | `overline
    | `lineThrough
    | `blink
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `underline -> {js|underline|js}
    | `overline -> {js|overline|js}
    | `lineThrough -> {js|line-through|js}
    | `blink -> {js|blink|js}
end

module TextDecorationStyle = struct
  type t =
    [ `solid
    | `double
    | `dotted
    | `dashed
    | `wavy
    ]

  let toString x =
    match x with
    | `solid -> {js|solid|js}
    | `double -> {js|double|js}
    | `dotted -> {js|dotted|js}
    | `dashed -> {js|dashed|js}
    | `wavy -> {js|wavy|js}
end

module TextDecorationThickness = struct
  type t =
    [ `fromFont
    | `auto
    ]

  let toString x =
    match x with `fromFont -> {js|from-font|js} | `auto -> {js|auto|js}
end

module TextDecorationSkipInk = struct
  type t =
    [ `auto
    | `none
    | `all
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `none -> {js|none|js}
    | `all -> {js|all|js}
end

module TextDecorationSkipBox = struct
  type t =
    [ `none
    | `all
    ]

  let toString x = match x with `none -> {js|none|js} | `all -> {js|all|js}
end

module TextDecorationSkipInset = struct
  type t =
    [ `none
    | `auto
    ]

  let toString x = match x with `none -> {js|none|js} | `auto -> {js|auto|js}
end

module Width = struct
  type t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `fitContent -> {js|fit-content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
end

module None = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module MinWidth = None
module MaxWidth = None

module Height = struct
  type t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `fitContent -> {js|fit-content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
end

module MaxHeight = None
module MinHeight = None

module OverflowWrap = struct
  type t =
    [ `normal
    | `breakWord
    | `anywhere
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `breakWord -> {js|break-word|js}
    | `anywhere -> {js|anywhere|js}
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

  let string_of_color x =
    match x with
    | #Color.t as co -> Color.toString co
    | #Var.t as va -> Var.toString va

  let string_of_stops stops =
    Kloth.Array.joinWithMap ~sep:{js|, |js}
      ~f:(fun (c, l) ->
        match c, l with
        (* This is the consequence of having wrong spec, we can generate broken CSS for gradients, very unlickely that manually you construct a gradient with (None, None), but still. *)
        | None, None -> {| |}
        | None, Some l -> Length.toString l
        | Some c, None -> string_of_color c
        | Some c, Some l -> string_of_color c ^ {js| |js} ^ Length.toString l)
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

  let string_of_position position =
    match position with
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `center -> {js|center|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l

  let maybe_string_of_shape = function
    | None -> {js||js}
    | Some shape -> string_of_shape shape ^ {js| |js}

  let maybe_string_of_size = function
    | None -> {js||js}
    | Some size -> string_of_size size ^ {js| |js}

  let maybe_string_of_position = function
    | None -> {js||js}
    | Some position -> {|at |} ^ string_of_position position ^ {js| |js}

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

module BackgroundImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module MaskImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module ImageRendering = struct
  type t =
    [ `auto
    | `smooth
    | `highQuality
    | `pixelated
    | `crispEdges
    ]

  let toString = function
    | `auto -> {js|auto|js}
    | `smooth -> {js|smooth|js}
    | `highQuality -> {js|high-quality|js}
    | `pixelated -> {js|pixelated|js}
    | `crispEdges -> {js|crisp-edges|js}
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
    ]

  let marginBox = `marginBox
  let borderBox = `borderBox
  let paddingBox = `paddingBox
  let contentBox = `contentBox
  let fillBox = `fillBox
  let strokeBox = `strokeBox
  let viewBox = `viewBox

  let toString x =
    match x with
    | `marginBox -> {js|margin-box|js}
    | `borderBox -> {js|border-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `contentBox -> {js|content-box|js}
    | `fillBox -> {js|fill-box|js}
    | `strokeBox -> {js|stroke-box|js}
    | `viewBox -> {js|view-box|js}
end

module ClipPath = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module BackfaceVisibility = struct
  type t =
    [ `visible
    | `hidden
    ]

  let toString x =
    match x with `visible -> {js|visible|js} | `hidden -> {js|hidden|js}
end

module Flex = struct
  type t =
    [ `auto
    | `initial
    | `none
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `initial -> {js|initial|js}
    | `none -> {js|none|js}
end

module TransformStyle = struct
  type t =
    [ `preserve3d
    | `flat
    ]

  let toString x =
    match x with `preserve3d -> {js|preserve-3d|js} | `flat -> {js|flat|js}
end

module TransformBox = struct
  type t =
    [ `contentBox
    | `borderBox
    | `fillBox
    | `strokeBox
    | `viewBox
    ]

  let toString x =
    match x with
    | `contentBox -> {js|content-box|js}
    | `borderBox -> {js|border-box|js}
    | `fillBox -> {js|fill-box|js}
    | `strokeBox -> {js|stroke-box|js}
    | `viewBox -> {js|view-box|js}
end

module ListStyleImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {js|none|js}
end

module FontFace = struct
  type t =
    [ Url.t
    | `local of string
    ]

  let toString x =
    match x with
    | `local value -> ({js|local("|js} ^ value) ^ {js|")|js}
    | `url value -> ({js|url("|js} ^ value) ^ {js|")|js}
end

module FontFamilyName = struct
  type t =
    [ `custom of string
    | `serif
    | `sansSerif
    | `cursive
    | `fantasy
    | `monospace
    | `systemUi
    | `emoji
    | `math
    | `fangsong
    ]

  let custom = `custom
  let serif = `serif
  let sansSerif = `sansSerif
  let cursive = `cursive
  let fantasy = `fantasy
  let monospace = `monospace
  let systemUi = `systemUi
  let emoji = `emoji
  let math = `math
  let fangsong = `fangsong

  let toString x =
    match x with
    | `custom value ->
      (match String.get value 0 with
      | '\'' -> value
      | '"' -> value
      | _ -> ({js|"|js} ^ value) ^ {js|"|js})
    | `serif -> {js|serif|js}
    | `sansSerif -> {js|sans-serif|js}
    | `cursive -> {js|cursive|js}
    | `fantasy -> {js|fantasy|js}
    | `monospace -> {js|monospace|js}
    | `systemUi -> {js|system-ui|js}
    | `emoji -> {js|emoji|js}
    | `math -> {js|math|js}
    | `fangsong -> {js|fangsong|js}
end

module FontDisplay = struct
  type t =
    [ `auto
    | `block
    | `swap
    | `fallback
    | `optional
    ]

  let auto = `auto
  let block = `block
  let swap = `swap
  let fallback = `fallback
  let optional = `optional

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `block -> {js|block|js}
    | `swap -> {js|swap|js}
    | `fallback -> {js|fallback|js}
    | `optional -> {js|optional|js}
end

module CounterStyleType = struct
  type t = ListStyleType.t

  let toString x =
    match x with #ListStyleType.t as c -> ListStyleType.toString c
end

module Counter = struct
  type style =
    [ CounterStyleType.t
    | `unset
    ]

  type t = [ `counter of string * style ]

  let counter ?(style = `unset) name = `counter (name, style)

  let toString x =
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

  let toString x =
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
    [ `none
    | `increment of string * int
    ]

  let increment ?(value = 1) name = `increment (name, value)

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `increment (name, value) -> (name ^ {js| |js}) ^ string_of_int value
end

module CounterReset = struct
  type t =
    [ `none
    | `reset of string * int
    ]

  let reset ?(value = 0) name = `reset (name, value)

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `reset (name, value) -> (name ^ {js| |js}) ^ string_of_int value
end

module CounterSet = struct
  type t =
    [ `none
    | `set of string * int
    ]

  let set ?(value = 0) name = `set (name, value)

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `set (name, value) -> (name ^ {js| |js}) ^ string_of_int value
end

module Content = struct
  type t =
    [ `none
    | `normal
    | `openQuote
    | `closeQuote
    | `noOpenQuote
    | `noCloseQuote
    | `attr of string
    | `text of string
    ]

  let text_to_string value =
    if Kloth.String.length value = 0 then {js|''|js} (* value = "" -> '' *)
    else if
      Kloth.String.length value = 2
      && Kloth.String.get value 0 = '"'
      && Kloth.String.get value 1 = '"'
    then {js|''|js}
    else (
      match Kloth.String.get value 0, Kloth.String.length value with
      | '\'', 1 -> {js|"'"|js}
      | '"', 1 -> {js|'"'|js}
      | '\'', _ | '"', _ -> value
      | _ -> {js|"|js} ^ value ^ {js|"|js})

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `normal -> {js|normal|js}
    | `openQuote -> {js|open-quote|js}
    | `closeQuote -> {js|close-quote|js}
    | `noOpenQuote -> {js|no-open-quote|js}
    | `noCloseQuote -> {js|no-close-quote|js}
    | `attr name -> ({js|attr(|js} ^ name) ^ {js|)|js}
    | `text v -> text_to_string v
end

module SVG = struct
  module Fill = struct
    type t =
      [ `none
      | `contextFill
      | `contextStroke
      ]

    let contextFill = `contextFill
    let contextStroke = `contextStroke

    let toString x =
      match x with
      | `none -> {js|none|js}
      | `contextFill -> {js|context-fill|js}
      | `contextStroke -> {js|context-stroke|js}
  end
end

module TouchAction = struct
  type t =
    [ `auto
    | `none
    | `panX
    | `panY
    | `panLeft
    | `panRight
    | `panUp
    | `panDown
    | `pinchZoom
    | `manipulation
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `none -> {js|none|js}
    | `panX -> {js|pan-x|js}
    | `panY -> {js|pan-y|js}
    | `panLeft -> {js|pan-left|js}
    | `panRight -> {js|pan-right|js}
    | `panUp -> {js|pan-up|js}
    | `panDown -> {js|pan-down|js}
    | `pinchZoom -> {js|pinch-zoom|js}
    | `manipulation -> {js|manipulation|js}
end

module ZIndex = struct
  type t =
    [ `auto
    | `num of int
    ]

  let toString x =
    match x with `auto -> {js|auto|js} | `num x -> Kloth.Int.toString x
end

module AlphaValue = struct
  type t =
    [ `num of float
    | `percent of float
    ]

  let toString x =
    match x with
    | `num x -> Kloth.Float.toString x
    | `percent x -> Kloth.Float.toString x ^ {js|%|js}
end

module LineBreak = struct
  type t =
    [ `auto
    | `loose
    | `normal
    | `strict
    | `anywhere
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `loose -> {js|loose|js}
    | `normal -> {js|normal|js}
    | `strict -> {js|strict|js}
    | `anywhere -> {js|anywhere|js}
end

module Hyphens = struct
  type t =
    [ `none
    | `manual
    | `auto
    ]

  let toString x =
    match x with
    | `none -> {js|none|js}
    | `manual -> {js|manual|js}
    | `auto -> {js|auto|js}
end

module TextJustify = struct
  type t =
    [ `auto
    | `none
    | `interWord
    | `interCharacter
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `none -> {js|none|js}
    | `interWord -> {js|inter-word|js}
    | `interCharacter -> {js|inter-character|js}
end

module OverflowInline = struct
  type t =
    [ `hidden
    | `visible
    | `scroll
    | `auto
    | `clip
    ]

  let toString x =
    match x with
    | `hidden -> {js|hidden|js}
    | `visible -> {js|visible|js}
    | `scroll -> {js|scroll|js}
    | `auto -> {js|auto|js}
    | `clip -> {js|clip|js}
end

module FontSynthesisWeight = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module FontSynthesisStyle = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module FontSynthesisSmallCaps = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module FontSynthesisPosition = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module FontKerning = struct
  type t =
    [ `auto
    | `none
    | `normal
    ]

  let toString x =
    match x with
    | `auto -> {js|auto|js}
    | `none -> {js|none|js}
    | `normal -> {js|normal|js}
end

module FontVariantPosition = struct
  type t =
    [ `normal
    | `sub
    | `super
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
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
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `smallCaps -> {js|small-caps|js}
    | `allSmallCaps -> {js|all-small-caps|js}
    | `petiteCaps -> {js|petite-caps|js}
    | `allPetiteCaps -> {js|all-petite-caps|js}
    | `unicase -> {js|unicase|js}
    | `titlingCaps -> {js|titling-caps|js}
end

module FontOpticalSizing = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {js|auto|js} | `none -> {js|none|js}
end

module FontVariantEmoji = struct
  type t =
    [ `normal
    | `text
    | `emoji
    | `unicode
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `text -> {js|text|js}
    | `emoji -> {js|emoji|js}
    | `unicode -> {js|unicode|js}
end
