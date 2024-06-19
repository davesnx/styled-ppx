module Std = Kloth

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
    | `initial -> {|initial|}
    | `inherit_ -> {|inherit|}
    | `unset -> {|unset|}
    | `revert -> {|revert|}
    | `revertLayer -> {|revert-layer|}
end

module Var = struct
  type t =
    [ `var of string
    | `varDefault of string * string
    ]

  let var x = `var x
  let varDefault x default = `varDefault (x, default)
  let prefix x = if Std.String.startsWith {|--|} x then x else {|--|} ^ x

  let toString x =
    match x with
    | `var x -> ({|var(|} ^ prefix x) ^ {|)|}
    | `varDefault (x, v) -> {|var(|} ^ prefix x ^ {|,|} ^ v ^ {|)|}
end

let max_or_min_values fn values =
  values
  |. Std.Array.map (fun v -> {| |} ^ fn v)
  |. Std.Array.joinWith ~sep:{|, |}

let calc_min_max_num_to_string fn = function
  | `calc (`add (a, b)) -> {|calc(|} ^ fn a ^ {| + |} ^ fn b ^ {|)|}
  | `calc (`sub (a, b)) -> {|calc(|} ^ fn a ^ {| - |} ^ fn b ^ {|)|}
  | `calc (`mult (a, b)) -> {|calc(|} ^ fn a ^ {| * |} ^ fn b ^ {|)|}
  | `num n -> Std.Float.toString n
  | `min xs -> {|min(|} ^ max_or_min_values fn xs ^ {|)|}
  | `max xs -> {|max(|} ^ max_or_min_values fn xs ^ {|)|}

let calc_min_max_to_string x =
  let aux fn fn' x' =
    match x' with
    | `add (x, y) -> {|calc(|} ^ fn x ^ {| + |} ^ fn y ^ {|)|}
    | `sub (x, y) -> {|calc(|} ^ fn x ^ {| - |} ^ fn y ^ {|)|}
    | `mult (x, y) -> {|calc(|} ^ fn x ^ {| * |} ^ fn y ^ {|)|}
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
    | `s t -> Std.Int.toString t ^ {|s|}
    | `ms t -> Std.Int.toString t ^ {|ms|}
    | `calc calc -> string_of_calc_min_max calc
    | (`min _ | `max _) as x -> minmax_to_string x

  and minmax_to_string = function
    | (`calc _ | `min _ | `max _ | `num _) as x ->
      calc_min_max_num_to_string toString x
    | #time as t -> toString t

  and calc_value_to_string x =
    match x with
    | `num x -> Std.Float.toString x
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
  let toString x = match x with `percent x -> Std.Float.toString x ^ {|%|}
end

module Url = struct
  type t = [ `url of string ]

  let toString x = match x with `url s -> ({|url(|} ^ s) ^ {|)|}
end

module Length = struct
  type length =
    [ `ch of float
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
    | `ch x -> Std.Float.toString x ^ {|ch|}
    | `em x -> Std.Float.toString x ^ {|em|}
    | `ex x -> Std.Float.toString x ^ {|ex|}
    | `rem x -> Std.Float.toString x ^ {|rem|}
    | `vh x -> Std.Float.toString x ^ {|vh|}
    | `vw x -> Std.Float.toString x ^ {|vw|}
    | `vmin x -> Std.Float.toString x ^ {|vmin|}
    | `vmax x -> Std.Float.toString x ^ {|vmax|}
    | `px x -> Std.Int.toString x ^ {|px|}
    | `pxFloat x -> Std.Float.toString x ^ {|px|}
    | `cm x -> Std.Float.toString x ^ {|cm|}
    | `mm x -> Std.Float.toString x ^ {|mm|}
    | `inch x -> Std.Float.toString x ^ {|in|}
    | `pc x -> Std.Float.toString x ^ {|pc|}
    | `pt x -> Std.Int.toString x ^ {|pt|}
    | `zero -> {|0|}
    | `calc calc -> string_of_calc_min_max calc
    | `percent x -> Std.Float.toString x ^ {|%|}
    | (`min _ | `max _) as x -> minmax_to_string x

  and calc_value_to_string x =
    match x with
    | `num x -> Std.Float.toString x
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
    | `deg x -> Std.Float.toString x ^ {|deg|}
    | `rad x -> Std.Float.toString x ^ {|rad|}
    | `grad x -> Std.Float.toString x ^ {|grad|}
    | `turn x -> Std.Float.toString x ^ {|turn|}
end

module Direction = struct
  type t =
    [ `ltr
    | `rtl
    ]

  let ltr = `ltr
  let rtl = `rtl
  let toString x = match x with `ltr -> {|ltr|} | `rtl -> {|rtl|}
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
    | `absolute -> {|absolute|}
    | `relative -> {|relative|}
    | `static -> {|static|}
    | `fixed -> {|fixed|}
    | `sticky -> {|sticky|}
end

module Isolation = struct
  type t =
    [ `auto
    | `isolate
    ]

  let toString x = match x with `auto -> {|auto|} | `isolate -> {|isolate|}
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
    | `none -> {|none|}
    | `both -> {|both|}
    | `horizontal -> {|horizontal|}
    | `vertical -> {|vertical|}
    | `block -> {|block|}
    | `inline -> {|inline|}
end

module FontVariant = struct
  type t =
    [ `normal
    | `smallCaps
    ]

  let normal = `normal
  let smallCaps = `smallCaps

  let toString x =
    match x with `normal -> {|normal|} | `smallCaps -> {|smallCaps|}
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
    | `normal -> {|normal|}
    | `italic -> {|italic|}
    | `oblique -> {|oblique|}
end

module TabSize = struct
  type t = [ `num of float ]

  let toString = function `num n -> Std.Float.toString n
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
    | `auto -> {|auto|}
    | `fill -> {|fill|}
    | `content -> {|content|}
    | `maxContent -> {|max-content|}
    | `minContent -> {|min-content|}
    | `fitContent -> {|fit-content|}
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
    | `hidden -> {|hidden|}
    | `visible -> {|visible|}
    | `scroll -> {|scroll|}
    | `auto -> {|auto|}
    | `clip -> {|clip|}
end

module Margin = struct
  type t = [ `auto ]

  let auto = `auto
  let toString x = match x with `auto -> {|auto|}
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
    | `column -> {|column|}
    | `row -> {|row|}
    | `columnDense -> {|column dense|}
    | `rowDense -> {|row dense|}
end

module Gap = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {|normal|}
end

module RowGap = Gap
module ColumnGap = Gap

module ScrollBehavior = struct
  type t =
    [ `auto
    | `smooth
    ]

  let toString x = match x with `auto -> {|auto|} | `smooth -> {|smooth|}
end

module OverscrollBehavior = struct
  type t =
    [ `auto
    | `contain
    | `none
    ]

  let toString x =
    match x with
    | `auto -> {|auto|}
    | `contain -> {|contain|}
    | `none -> {|none|}
end

module OverflowAnchor = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
end

module ColumnWidth = struct
  type t = [ `auto ]

  let toString x = match x with `auto -> {|auto|}
end

module CaretColor = struct
  type t = [ `auto ]

  let toString x = match x with `auto -> {|auto|}
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
    | `baseline -> {|baseline|}
    | `sub -> {|sub|}
    | `super -> {|super|}
    | `top -> {|top|}
    | `textTop -> {|text-top|}
    | `middle -> {|middle|}
    | `bottom -> {|bottom|}
    | `textBottom -> {|text-bottom|}
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
    | `linear -> {|linear|}
    | `ease -> {|ease|}
    | `easeIn -> {|ease-in|}
    | `easeOut -> {|ease-out|}
    | `easeInOut -> {|ease-in-out|}
    | `stepStart -> {|step-start|}
    | `stepEnd -> {|step-end|}
    | `steps (i, `start) -> ({|steps(|} ^ Std.Int.toString i) ^ {|, start)|}
    | `steps (i, `end_) -> ({|steps(|} ^ Std.Int.toString i) ^ {|, end)|}
    | `cubicBezier (a, b, c, d) ->
      {|cubic-bezier(|}
      ^ Std.Float.toString a
      ^ {|, |}
      ^ Std.Float.toString b
      ^ {|, |}
      ^ Std.Float.toString c
      ^ {|, |}
      ^ Std.Float.toString d
      ^ {|)|}
    | `jumpStart -> {|jump-start|}
    | `jumpEnd -> {|jump-end|}
    | `jumpNone -> {|jump-none|}
    | `jumpBoth -> {|jump-both|}
end

module RepeatValue = struct
  type t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  let toString x =
    match x with
    | `autoFill -> {|auto-fill|}
    | `autoFit -> {|auto-fit|}
    | `num x -> Std.Int.toString x
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
    | `disc -> {|disc|}
    | `circle -> {|circle|}
    | `square -> {|square|}
    | `decimal -> {|decimal|}
    | `lowerAlpha -> {|lower-alpha|}
    | `upperAlpha -> {|upper-alpha|}
    | `lowerGreek -> {|lower-greek|}
    | `lowerLatin -> {|lower-latin|}
    | `upperLatin -> {|upper-latin|}
    | `lowerRoman -> {|lower-roman|}
    | `upperRoman -> {|upper-roman|}
    | `none -> {|none|}
end

module ListStylePosition = struct
  type t =
    [ `inside
    | `outside
    ]

  let toString x =
    match x with `inside -> {|inside|} | `outside -> {|outside|}
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
    | `none -> {|none|}
    | `auto -> {|auto|}
    | `hidden -> {|hidden|}
    | `dotted -> {|dotted|}
    | `dashed -> {|dashed|}
    | `solid -> {|solid|}
    | `double -> {|double|}
    | `groove -> {|grove|}
    | `ridge -> {|ridge|}
    | `inset -> {|inset|}
    | `outset -> {|outset|}
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
    | `num n -> Std.Int.toString n
    | `thin -> {|100|}
    | `extraLight -> {|200|}
    | `light -> {|300|}
    | `normal -> {|400|}
    | `medium -> {|500|}
    | `semiBold -> {|600|}
    | `bold -> {|700|}
    | `extraBold -> {|800|}
    | `black -> {|900|}
    | `lighter -> {|lighter|}
    | `bolder -> {|bolder|}
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
    | `left -> {|left|}
    | `center -> {|center|}
    | `right -> {|right|}
    | `top -> {|top|}
    | `bottom -> {|bottom|}
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
    {|scale(|} ^ Std.Float.toString x ^ {|, |} ^ Std.Float.toString y ^ {|)|}

  let string_of_translate3d x y z =
    {|translate3d(|}
    ^ Length.toString x
    ^ {|, |}
    ^ Length.toString y
    ^ {|, |}
    ^ Length.toString z
    ^ {|)|}

  let toString x =
    match x with
    | `translate (x, y) ->
      {|translate(|} ^ Length.toString x ^ {|, |} ^ Length.toString y ^ {|)|}
    | `translate3d (x, y, z) -> string_of_translate3d x y z
    | `translateX x -> {|translateX(|} ^ Length.toString x ^ {|)|}
    | `translateY y -> {|translateY(|} ^ Length.toString y ^ {|)|}
    | `translateZ z -> {|translateZ(|} ^ Length.toString z ^ {|)|}
    | `scale (x, y) -> string_of_scale x y
    | `scale3d (x, y, z) ->
      {|scale3d(|}
      ^ Std.Float.toString x
      ^ {|, |}
      ^ Std.Float.toString y
      ^ {|, |}
      ^ Std.Float.toString z
      ^ {|)|}
    | `scaleX x -> {|scaleX(|} ^ Std.Float.toString x ^ {|)|}
    | `scaleY y -> {|scaleY(|} ^ Std.Float.toString y ^ {|)|}
    | `scaleZ z -> {|scaleZ(|} ^ Std.Float.toString z ^ {|)|}
    | `rotate a -> {|rotate(|} ^ Angle.toString a ^ {|)|}
    | `rotate3d (x, y, z, a) ->
      {|rotate3d(|}
      ^ Std.Float.toString x
      ^ {|, |}
      ^ Std.Float.toString y
      ^ {|, |}
      ^ Std.Float.toString z
      ^ {|, |}
      ^ Angle.toString a
      ^ {|)|}
    | `rotateX a -> {|rotateX(|} ^ Angle.toString a ^ {|)|}
    | `rotateY a -> {|rotateY(|} ^ Angle.toString a ^ {|)|}
    | `rotateZ a -> {|rotateZ(|} ^ Angle.toString a ^ {|)|}
    | `skew (x, y) ->
      {|skew(|} ^ Angle.toString x ^ {|, |} ^ Angle.toString y ^ {|)|}
    | `skewX a -> {|skewX(|} ^ Angle.toString a ^ {|)|}
    | `skewY a -> {|skewY(|} ^ Angle.toString a ^ {|)|}
    | `perspective x -> {|perspective(|} ^ Std.Int.toString x ^ {|)|}
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
    | `normal -> {|normal|}
    | `reverse -> {|reverse|}
    | `alternate -> {|alternate|}
    | `alternateReverse -> {|alternate-reverse|}
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
    | `none -> {|none|}
    | `forwards -> {|forwards|}
    | `backwards -> {|backwards|}
    | `both -> {|both|}
end

module AnimationIterationCount = struct
  type t =
    [ `count of float
    | `infinite
    ]

  let toString x =
    match x with `count x -> Std.Float.toString x | `infinite -> {|infinite|}
end

module AnimationPlayState = struct
  type t =
    [ `paused
    | `running
    ]

  let toString x =
    match x with `paused -> {|paused|} | `running -> {|running|}
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
    | `alias -> {|alias|}
    | `allScroll -> {|all-scroll|}
    | `auto -> {|auto|}
    | `cell -> {|cell|}
    | `colResize -> {|col-resize|}
    | `contextMenu -> {|context-menu|}
    | `copy -> {|copy|}
    | `crosshair -> {|crosshair|}
    | `default -> {|default|}
    | `eResize -> {|e-resize|}
    | `ewResize -> {|ew-resize|}
    | `grab -> {|grab|}
    | `grabbing -> {|grabbing|}
    | `hand -> {|hand|}
    | `help -> {|help|}
    | `move -> {|move|}
    | `neResize -> {|ne-resize|}
    | `neswResize -> {|nesw-resize|}
    | `noDrop -> {|no-drop|}
    | `none -> {|none|}
    | `notAllowed -> {|not-allowed|}
    | `nResize -> {|n-resize|}
    | `nsResize -> {|ns-resize|}
    | `nwResize -> {|nw-resize|}
    | `nwseResize -> {|nwse-resize|}
    | `pointer -> {|pointer|}
    | `progress -> {|progress|}
    | `rowResize -> {|row-resize|}
    | `seResize -> {|se-resize|}
    | `sResize -> {|s-resize|}
    | `swResize -> {|sw-resize|}
    | `text -> {|text|}
    | `verticalText -> {|vertical-text|}
    | `wait -> {|wait|}
    | `wResize -> {|w-resize|}
    | `zoomIn -> {|zoom-in|}
    | `zoomOut -> {|zoom-out|}
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
      | `hsl -> {|hsl|}
      | `hwb -> {|hwb|}
      | `lch -> {|lch|}
      | `oklch -> {|oklch|}
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
      | `srgb -> {|srgb|}
      | `srgbLinear -> {|srgb-linear|}
      | `displayP3 -> {|display-p3|}
      | `a98Rgb -> {|a98-rgb|}
      | `prophotoRgb -> {|prophoto-rgb|}
      | `rec2020 -> {|rec2020|}
      | `lab -> {|lab|}
      | `oklab -> {|oklab|}
      | `xyz -> {|xyz|}
      | `xyzD50 -> {|xyz-d50|}
      | `xyzD65 -> {|xyz-d65|}
      | `hsl -> {|hsl|}
      | `hwb -> {|hwb|}
      | `lch -> {|lch|}
      | `oklch -> {|oklch|}
  end

  module HueSize = struct
    type t =
      [ `shorter
      | `longer
      | `increasing
      | `decreasing
      ]

    let toString = function
      | `shorter -> {|shorter|}
      | `longer -> {|longer|}
      | `increasing -> {|increasing|}
      | `decreasing -> {|decreasing|}
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
    Std.Int.toString r
    ^ {|, |}
    ^ Std.Int.toString g
    ^ {|, |}
    ^ Std.Int.toString b

  let rec toString x =
    match x with
    | `colorMix (method', color_x, color_y) ->
      {|color-mix(|}
      ^ (match method' with
        | `in1 x -> ColorMixMethod.Rectangular_or_Polar_color_space.toString x
        | `in2 (x, y) ->
          ColorMixMethod.PolarColorSpace.toString x
          ^ {| |}
          ^ ColorMixMethod.HueSize.toString y)
      ^ {|, |}
      ^ string_of_color color_x color_y
      ^ {|)|}
    | `rgb (r, g, b) -> {|rgb(|} ^ rgb_to_string r g b ^ {|)|}
    | `rgba (r, g, b, a) ->
      {|rgba(|} ^ rgb_to_string r g b ^ {|, |} ^ string_of_alpha a ^ {|)|}
    | `hsl (h, s, l) ->
      {|hsl(|}
      ^ string_of_angle h
      ^ {|, |}
      ^ string_of_alpha' s
      ^ {|, |}
      ^ string_of_alpha' l
      ^ {|)|}
    | `hsla (h, s, l, a) ->
      {|hsla(|}
      ^ string_of_angle h
      ^ {|, |}
      ^ string_of_alpha' s
      ^ {|, |}
      ^ string_of_alpha' l
      ^ {|, |}
      ^ string_of_alpha a
      ^ {|)|}
    | `hex s -> {|#|} ^ s
    | `transparent -> {|transparent|}
    | `currentColor -> {|currentColor|}

  and string_of_color x y =
    string_of_actual_color x ^ {|, |} ^ string_of_actual_color y

  and string_of_actual_color = function
    | color, percent -> toString color ^ {| |} ^ Percentage.toString percent
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
    | `none -> {|none|}
    | `hidden -> {|hidden|}
    | `dotted -> {|dotted|}
    | `dashed -> {|dashed|}
    | `solid -> {|solid|}
    | `double -> {|double|}
    | `groove -> {|groove|}
    | `ridge -> {|ridge|}
    | `inset -> {|inset|}
    | `outset -> {|outset|}
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
    | `auto -> {|auto|}
    | `none -> {|none|}
    | `visiblePainted -> {|visiblePainted|}
    | `visibleFill -> {|visibleFill|}
    | `visibleStroke -> {|visibleStroke|}
    | `visible -> {|visible|}
    | `painted -> {|painted|}
    | `fill -> {|fill|}
    | `stroke -> {|stroke|}
    | `all -> {|all|}
    | `inherit_ -> {|inherit|}
end

module Perspective = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
end

module LetterSpacing = struct
  type t = [ `normal ]

  let normal = `normal
  let toString x = match x with `normal -> {|normal|}
end

module LineHeight = struct
  type t =
    [ `normal
    | `abs of float
    ]

  let toString x =
    match x with `normal -> {|normal|} | `abs x -> Std.Float.toString x
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
    | `thin -> {|thin|}
    | `medium -> {|medium|}
    | `thick -> {|thick|}
    | #Length.t as l -> Length.toString l
end

module WordSpacing = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {|normal|}
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
    | `block -> {|block|}
    | `inline -> {|inline|}
    | `runIn -> {|run-in|}
end

module DisplayInside = struct
  type t =
    [ `table
    | `flex
    | `grid
    ]

  let toString x =
    match x with `table -> {|table|} | `flex -> {|flex|} | `grid -> {|grid|}
end

module DisplayListItem = struct
  type t = [ `listItem ]

  let toString x = match x with `listItem -> {|list-item|}
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
    | `tableRowGroup -> {|table-row-group|}
    | `tableHeaderGroup -> {|table-header-group|}
    | `tableFooterGroup -> {|table-footer-group|}
    | `tableRow -> {|table-row|}
    | `tableCell -> {|table-cell|}
    | `tableColumnGroup -> {|table-column-group|}
    | `tableColumn -> {|table-column|}
    | `tableCaption -> {|table-caption|}
end

module DisplayBox = struct
  type t =
    [ `contents
    | `none
    ]

  let toString x = match x with `contents -> {|contents|} | `none -> {|none|}
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
    | `inlineBlock -> {|inline-block|}
    | `inlineFlex -> {|inline-flex|}
    | `inlineGrid -> {|inline-grid|}
    | `inlineTable -> {|inline-table|}
end

module JustifySelf = struct
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  let toString x =
    match x with
    | `auto -> {|auto|}
    | `normal -> {|normal|}
    | `stretch -> {|stretch|}
end

module TextEmphasisStyle = struct
  module FilledOrOpen = struct
    type t =
      [ `filled
      | `open_
      ]

    let toString x = match x with `filled -> {|filled|} | `open_ -> {|open|}
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
      | `dot -> {|dot|}
      | `circle -> {|circle|}
      | `double_circle -> {|double-circle|}
      | `triangle -> {|triangle|}
      | `sesame -> {|sesame|}
  end

  type t =
    [ `none
    | FilledOrOpen.t
    | Shape.t
    | `string of string
    ]

  let toString x =
    match x with
    | `none | `filled -> {|filled|}
    | `open_ -> {|open|}
    | `dot -> {|dot|}
    | `circle -> {|circle|}
    | `double_circle -> {|double-circle|}
    | `triangle -> {|triangle|}
    | `sesame -> {|sesame|}
    | `string s -> s
end

module TextEmphasisPosition = struct
  module LeftRightAlignment = struct
    type t =
      [ `left
      | `right
      ]

    let toString x = match x with `left -> {|left|} | `right -> {|right|}
  end

  module OverOrUnder = struct
    type t =
      [ `over
      | `under
      ]

    let toString x = match x with `over -> {|over|} | `under -> {|under|}
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
    | `top -> {|top|}
    | `bottom -> {|bottom|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `center -> {|center|}
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
    | `center -> {|center|}
    | `start -> {|start|}
    | `end_ -> {|end|}
    | `flexStart -> {|flex-start|}
    | `flexEnd -> {|flex-end|}
    | `selfStart -> {|self-start|}
    | `selfEnd -> {|self-end|}
    | `left -> {|left|}
    | `right -> {|right|}
end

module OverflowAlignment = struct
  type t =
    [ `safe of PositionalAlignment.t
    | `unsafe of PositionalAlignment.t
    ]

  let toString x =
    match x with
    | `safe pa -> {|safe |} ^ PositionalAlignment.toString pa
    | `unsafe pa -> {|unsafe |} ^ PositionalAlignment.toString pa
end

module BaselineAlignment = struct
  type t =
    [ `baseline
    | `firstBaseline
    | `lastBaseline
    ]

  let toString x =
    match x with
    | `baseline -> {|baseline|}
    | `firstBaseline -> {|first baseline|}
    | `lastBaseline -> {|last baseline|}
end

module NormalAlignment = struct
  type t = [ `normal ]

  let toString x = match x with `normal -> {|normal|}
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
    | `spaceBetween -> {|space-between|}
    | `spaceAround -> {|space-around|}
    | `spaceEvenly -> {|space-evenly|}
    | `stretch -> {|stretch|}
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
    | `legacy -> {|legacy|}
    | `legacyRight -> {|legacy right|}
    | `legacyLeft -> {|legacy left|}
    | `legacyCenter -> {|legacy center|}
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
    | `start -> {|start|}
    | `end_ -> {|end|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `center -> {|center|}
    | `justify -> {|justify|}
    | `matchParent -> {|match-parent|}
    | `justifyAll -> {|justify-all|}
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
    | `start -> {|start|}
    | `end_ -> {|end|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `center -> {|center|}
    | `justify -> {|justify|}
    | `matchParent -> {|match-parent|}
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
    | `auto -> {|auto|}
    | `start -> {|start|}
    | `end_ -> {|end|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `center -> {|center|}
    | `justify -> {|justify|}
    | `matchParent -> {|match-parent|}
end

module WordBreak = struct
  type t =
    [ `normal
    | `breakAll
    | `keepAll
    ]

  let toString x =
    match x with
    | `normal -> {|normal|}
    | `breakAll -> {|break-all|}
    | `keepAll -> {|keep-all|}
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
    | `normal -> {|normal|}
    | `nowrap -> {|nowrap|}
    | `pre -> {|pre|}
    | `preLine -> {|pre-line|}
    | `preWrap -> {|pre-wrap|}
    | `breakSpaces -> {|break-spaces|}
end

module AlignItems = struct
  type t =
    [ `normal
    | `stretch
    ]

  let toString x =
    match x with `normal -> {|normal|} | `stretch -> {|stretch|}
end

module AlignSelf = struct
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  let toString x =
    match x with
    | `auto -> {|auto|}
    | `normal -> {|normal|}
    | `stretch -> {|stretch|}
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
    | `center -> {|center|}
    | `start -> {|start|}
    | `end_ -> {|end|}
    | `flexStart -> {|flex-start|}
    | `flexEnd -> {|flex-end|}
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
    | `fill -> {|fill|}
    | `contain -> {|contain|}
    | `cover -> {|cover|}
    | `none -> {|none|}
    | `scaleDown -> {|scale-down|}
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
    | `none -> {|none|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `both -> {|both|}
    | `inlineStart -> {|inline-start|}
    | `inlineEnd -> {|inline-end|}
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
    | `left -> {|left|}
    | `right -> {|right|}
    | `none -> {|none|}
    | `inlineStart -> {|inline-start|}
    | `inlineEnd -> {|inline-end|}
end

module Visibility = struct
  type t =
    [ `visible
    | `hidden
    | `collapse
    ]

  let toString x =
    match x with
    | `visible -> {|visible|}
    | `hidden -> {|hidden|}
    | `collapse -> {|collapse|}
end

module TableLayout = struct
  type t =
    [ `auto
    | `fixed
    ]

  let toString x = match x with `auto -> {|auto|} | `fixed -> {|fixed|}
end

module BorderImageSource = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
end

module BorderCollapse = struct
  type t =
    [ `collapse
    | `separate
    ]

  let toString x =
    match x with `collapse -> {|collapse|} | `separate -> {|separate|}
end

module FlexWrap = struct
  type t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    ]

  let toString x =
    match x with
    | `nowrap -> {|nowrap|}
    | `wrap -> {|wrap|}
    | `wrapReverse -> {|wrap-reverse|}
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
    | `row -> {|row|}
    | `rowReverse -> {|row-reverse|}
    | `column -> {|column|}
    | `columnReverse -> {|column-reverse|}
end

module BoxSizing = struct
  type t =
    [ `contentBox
    | `borderBox
    ]

  let toString x =
    match x with `contentBox -> {|content-box|} | `borderBox -> {|border-box|}
end

module ColumnCount = struct
  type t =
    [ `auto
    | `count of int
    ]

  let toString x =
    match x with `auto -> {|auto|} | `count v -> Std.Int.toString v
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
    | `none -> {|none|}
    | `auto -> {|auto|}
    | `text -> {|text|}
    | `contain -> {|contain|}
    | `all -> {|all|}
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
    | `none -> {|none|}
    | `capitalize -> {|capitalize|}
    | `uppercase -> {|uppercase|}
    | `lowercase -> {|lowercase|}
end

module GridTemplateAreas = struct
  type t =
    [ `none
    | `areas of string array
    ]

  let areas x = `areas x

  let toString x =
    match x with
    | `none -> {|none|}
    | `areas items ->
      String.trim
        (Std.Array.reduce items {||} (fun carry item ->
             carry ^ {|'|} ^ item ^ {|' |}))
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
    | `auto -> {|auto|}
    | `ident s -> s
    | `num i -> string_of_int i
    | `numIdent (i, s) -> (string_of_int i ^ {| |}) ^ s
    | `span e ->
      {|span |} ^ (match e with `num i -> string_of_int i | `ident s -> s)
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
    | `percent v -> Std.Float.toString v ^ {|%|}
    | `num v -> Std.Float.toString v

  let toString x =
    match x with
    | `blur v -> {|blur(|} ^ Length.toString v ^ {|)|}
    | `brightness v -> {|brightness(|} ^ string_of_amount v ^ {|%)|}
    | `contrast v -> {|contrast(|} ^ string_of_amount v ^ {|%)|}
    | `dropShadow (a, b, c, d) ->
      {|drop-shadow(|}
      ^ Length.toString a
      ^ {| |}
      ^ Length.toString b
      ^ {| |}
      ^ Length.toString c
      ^ {| |}
      ^ (match (d : [ Color.t | Var.t ]) with
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v)
      ^ {|)|}
    | `grayscale v -> {|grayscale(|} ^ string_of_amount v ^ {|%)|}
    | `hueRotate v -> {|hue-rotate(|} ^ Angle.toString v ^ {|)|}
    | `invert v -> {|invert(|} ^ string_of_amount v ^ {|%)|}
    | `opacity v -> {|opacity(|} ^ string_of_amount v ^ {|%)|}
    | `saturate v -> {|saturate(|} ^ string_of_amount v ^ {|%)|}
    | `sepia v -> {|sepia(|} ^ string_of_amount v ^ {|%)|}
    | `none -> {|none|}
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
    | `scroll -> {|scroll|}
    | `fixed -> {|fixed|}
    | `local -> {|local|}
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
    | `borderBox -> {|border-box|}
    | `contentBox -> {|content-box|}
    | `paddingBox -> {|padding-box|}
    | `text -> {|text|}
end

module BackgroundOrigin = struct
  type t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    ]

  let toString x =
    match x with
    | `borderBox -> {|border-box|}
    | `contentBox -> {|content-box|}
    | `paddingBox -> {|padding-box|}
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
      | `left -> {|left|}
      | `right -> {|right|}
      | `center -> {|center|}
  end

  module Y = struct
    type t =
      [ `top
      | `bottom
      | `center
      ]

    let toString x =
      match x with
      | `top -> {|top|}
      | `bottom -> {|bottom|}
      | `center -> {|center|}
  end

  type t =
    [ X.t
    | Y.t
    ]

  let toString x =
    match x with
    | `left -> {|left|}
    | `right -> {|right|}
    | `top -> {|top|}
    | `bottom -> {|bottom|}
    | `center -> {|center|}
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
    | `repeatX -> {|repeat-x|}
    | `repeatY -> {|repeat-y|}
    | `repeat -> {|repeat|}
    | `space -> {|space|}
    | `round -> {|round|}
    | `noRepeat -> {|no-repeat|}
end

module TextOverflow = struct
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    ]

  let toString x =
    match x with
    | `clip -> {|clip|}
    | `ellipsis -> {|ellipsis|}
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
    | `none -> {|none|}
    | `underline -> {|underline|}
    | `overline -> {|overline|}
    | `lineThrough -> {|line-through|}
    | `blink -> {|blink|}
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
    | `solid -> {|solid|}
    | `double -> {|double|}
    | `dotted -> {|dotted|}
    | `dashed -> {|dashed|}
    | `wavy -> {|wavy|}
end

module TextDecorationThickness = struct
  type t =
    [ `fromFont
    | `auto
    ]

  let toString x = match x with `fromFont -> {|from-font|} | `auto -> {|auto|}
end

module TextDecorationSkipInk = struct
  type t =
    [ `auto
    | `none
    | `all
    ]

  let toString x =
    match x with `auto -> {|auto|} | `none -> {|none|} | `all -> {|all|}
end

module TextDecorationSkipBox = struct
  type t =
    [ `none
    | `all
    ]

  let toString x = match x with `none -> {|none|} | `all -> {|all|}
end

module TextDecorationSkipInset = struct
  type t =
    [ `none
    | `auto
    ]

  let toString x = match x with `none -> {|none|} | `auto -> {|auto|}
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
    | `auto -> {|auto|}
    | `fitContent -> {|fit-content|}
    | `maxContent -> {|max-content|}
    | `minContent -> {|min-content|}
end

module None = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
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
    | `auto -> {|auto|}
    | `fitContent -> {|fit-content|}
    | `maxContent -> {|max-content|}
    | `minContent -> {|min-content|}
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
    | `normal -> {|normal|}
    | `breakWord -> {|break-word|}
    | `anywhere -> {|anywhere|}
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
    stops
    |. Std.Array.map (fun (c, l) ->
           match c, l with
           (* This is the consequence of having wrong spec, we can generate broken CSS for gradients, very unlickely that manually you construct a gradient with (None, None), but still. *)
           | None, None -> {| |}
           | None, Some l -> Length.toString l
           | Some c, None -> string_of_color c
           | Some c, Some l -> string_of_color c ^ {| |} ^ Length.toString l)
    |. Std.Array.joinWith ~sep:{|, |}

  let direction_to_string = function
    | #Angle.t as a -> Angle.toString a
    | #SideOrCorner.t as s -> SideOrCorner.toString s

  let string_of_shape shape =
    match shape with `ellipse -> {|ellipse|} | `circle -> {|circle|}

  let string_of_size size =
    match size with
    | `closestSide -> {|closest-side|}
    | `closestCorner -> {|closest-corner|}
    | `farthestSide -> {|farthest-side|}
    | `farthestCorner -> {|farthest-corner|}

  let string_of_position position =
    match position with
    | `top -> {|top|}
    | `bottom -> {|bottom|}
    | `left -> {|left|}
    | `right -> {|right|}
    | `center -> {|center|}
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l

  let maybe_string_of_shape = function
    | None -> {||}
    | Some shape -> string_of_shape shape ^ {| |}

  let maybe_string_of_size = function
    | None -> {||}
    | Some size -> string_of_size size ^ {| |}

  let maybe_string_of_position = function
    | None -> {||}
    | Some position -> {|at |} ^ string_of_position position ^ {| |}

  let string_of_radialGradient gradient =
    match gradient with
    | None, None, None, stops ->
      {|radial-gradient(|} ^ string_of_stops stops ^ {|)|}
    | shape, size, position, stops ->
      {|radial-gradient(|}
      ^ maybe_string_of_shape shape
      ^ maybe_string_of_size size
      ^ maybe_string_of_position position
      ^ ","
      ^ string_of_stops stops
      ^ {|)|}

  let string_of_repeatingRadialGradients gradient =
    match gradient with
    | None, None, None, stops ->
      {|repeating-radial-gradient(|} ^ string_of_stops stops ^ {|)|}
    | shape, size, position, stops ->
      {|repeating-radial-gradient(|}
      ^ maybe_string_of_shape shape
      ^ maybe_string_of_size size
      ^ maybe_string_of_position position
      ^ ","
      ^ string_of_stops stops
      ^ {|)|}

  let toString (x : t) =
    match x with
    | `linearGradient (None, stops) ->
      {|linear-gradient(|} ^ string_of_stops stops ^ {|)|}
    | `linearGradient (Some direction, stops) ->
      {|linear-gradient(|}
      ^ direction_to_string direction
      ^ {|, |}
      ^ string_of_stops stops
      ^ {|)|}
    | `repeatingLinearGradient (None, stops) ->
      {|repeating-linear-gradient(|} ^ string_of_stops stops ^ {|)|}
    | `repeatingLinearGradient (Some direction, stops) ->
      {|repeating-linear-gradient(|}
      ^ direction_to_string direction
      ^ {|, |}
      ^ string_of_stops stops
      ^ {|)|}
    | `radialGradient radialGradient -> string_of_radialGradient radialGradient
    | `repeatingRadialGradient radialGradient ->
      string_of_repeatingRadialGradients radialGradient
    | `conicGradient (None, stops) ->
      {|conic-gradient(|} ^ string_of_stops stops ^ {|)|}
    | `conicGradient (Some direction, stops) ->
      {|conic-gradient(|}
      ^ direction_to_string direction
      ^ {|, |}
      ^ string_of_stops stops
      ^ {|)|}
end

module BackgroundImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
end

module MaskImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
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
    | `auto -> {|auto|}
    | `smooth -> {|smooth|}
    | `highQuality -> {|high-quality|}
    | `pixelated -> {|pixelated|}
    | `crispEdges -> {|crisp-edges|}
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
    | `marginBox -> {|margin-box|}
    | `borderBox -> {|border-box|}
    | `paddingBox -> {|padding-box|}
    | `contentBox -> {|content-box|}
    | `fillBox -> {|fill-box|}
    | `strokeBox -> {|stroke-box|}
    | `viewBox -> {|view-box|}
end

module ClipPath = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
end

module BackfaceVisibility = struct
  type t =
    [ `visible
    | `hidden
    ]

  let toString x =
    match x with `visible -> {|visible|} | `hidden -> {|hidden|}
end

module Flex = struct
  type t =
    [ `auto
    | `initial
    | `none
    ]

  let toString x =
    match x with
    | `auto -> {|auto|}
    | `initial -> {|initial|}
    | `none -> {|none|}
end

module TransformStyle = struct
  type t =
    [ `preserve3d
    | `flat
    ]

  let toString x =
    match x with `preserve3d -> {|preserve-3d|} | `flat -> {|flat|}
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
    | `contentBox -> {|content-box|}
    | `borderBox -> {|border-box|}
    | `fillBox -> {|fill-box|}
    | `strokeBox -> {|stroke-box|}
    | `viewBox -> {|view-box|}
end

module ListStyleImage = struct
  type t = [ `none ]

  let toString x = match x with `none -> {|none|}
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
      | _ -> ({|"|} ^ value) ^ {|"|})
    | `serif -> {|serif|}
    | `sansSerif -> {|sans-serif|}
    | `cursive -> {|cursive|}
    | `fantasy -> {|fantasy|}
    | `monospace -> {|monospace|}
    | `systemUi -> {|system-ui|}
    | `emoji -> {|emoji|}
    | `math -> {|math|}
    | `fangsong -> {|fangsong|}
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
    | `auto -> {|auto|}
    | `block -> {|block|}
    | `swap -> {|swap|}
    | `fallback -> {|fallback|}
    | `optional -> {|optional|}
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
      | `unset -> ({|counter(|} ^ counter) ^ {|)|}
      | #CounterStyleType.t as t ->
        {|counter(|} ^ counter ^ {|,|} ^ CounterStyleType.toString t ^ {|)|})
end

module Counters = struct
  type style =
    [ CounterStyleType.t
    | `unset
    ]

  type t = [ `counters of string * string * style ]

  let counters ?(style = `unset) ?(separator = {||}) name =
    `counters (name, separator, style)

  let toString x =
    match x with
    | `counters (name, separator, style) ->
      (match style with
      | `unset -> {|counters(|} ^ name ^ {|,"|} ^ separator ^ {|")|}
      | #CounterStyleType.t as s ->
        {|counters(|}
        ^ name
        ^ {|,"|}
        ^ separator
        ^ {|",|}
        ^ CounterStyleType.toString s
        ^ {|)|})
end

module CounterIncrement = struct
  type t =
    [ `none
    | `increment of string * int
    ]

  let increment ?(value = 1) name = `increment (name, value)

  let toString x =
    match x with
    | `none -> {|none|}
    | `increment (name, value) -> (name ^ {| |}) ^ string_of_int value
end

module CounterReset = struct
  type t =
    [ `none
    | `reset of string * int
    ]

  let reset ?(value = 0) name = `reset (name, value)

  let toString x =
    match x with
    | `none -> {|none|}
    | `reset (name, value) -> (name ^ {| |}) ^ string_of_int value
end

module CounterSet = struct
  type t =
    [ `none
    | `set of string * int
    ]

  let set ?(value = 0) name = `set (name, value)

  let toString x =
    match x with
    | `none -> {|none|}
    | `set (name, value) -> (name ^ {| |}) ^ string_of_int value
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
    if Std.String.length value = 0 then {|''|} (* value = "" -> '' *)
    else if
      Std.String.length value = 2
      && Std.String.get value 0 = '"'
      && Std.String.get value 1 = '"'
    then {|''|}
    else (
      match Std.String.get value 0, Std.String.length value with
      | '\'', 1 -> {|"'"|}
      | '"', 1 -> {|'"'|}
      | '\'', _ | '"', _ -> value
      | _ -> {|"|} ^ value ^ {|"|})

  let toString x =
    match x with
    | `none -> {|none|}
    | `normal -> {|normal|}
    | `openQuote -> {|open-quote|}
    | `closeQuote -> {|close-quote|}
    | `noOpenQuote -> {|no-open-quote|}
    | `noCloseQuote -> {|no-close-quote|}
    | `attr name -> ({|attr(|} ^ name) ^ {|)|}
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
      | `none -> {|none|}
      | `contextFill -> {|context-fill|}
      | `contextStroke -> {|context-stroke|}
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
    | `auto -> {|auto|}
    | `none -> {|none|}
    | `panX -> {|pan-x|}
    | `panY -> {|pan-y|}
    | `panLeft -> {|pan-left|}
    | `panRight -> {|pan-right|}
    | `panUp -> {|pan-up|}
    | `panDown -> {|pan-down|}
    | `pinchZoom -> {|pinch-zoom|}
    | `manipulation -> {|manipulation|}
end

module ZIndex = struct
  type t =
    [ `auto
    | `num of int
    ]

  let toString x =
    match x with `auto -> {|auto|} | `num x -> Std.Int.toString x
end

module AlphaValue = struct
  type t =
    [ `num of float
    | `percent of float
    ]

  let toString x =
    match x with
    | `num x -> Std.Float.toString x
    | `percent x -> Std.Float.toString x ^ {|%|}
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
    | `auto -> {|auto|}
    | `loose -> {|loose|}
    | `normal -> {|normal|}
    | `strict -> {|strict|}
    | `anywhere -> {|anywhere|}
end

module Hyphens = struct
  type t =
    [ `none
    | `manual
    | `auto
    ]

  let toString x =
    match x with `none -> {|none|} | `manual -> {|manual|} | `auto -> {|auto|}
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
    | `auto -> {|auto|}
    | `none -> {|none|}
    | `interWord -> {|inter-word|}
    | `interCharacter -> {|inter-character|}
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
    | `hidden -> {|hidden|}
    | `visible -> {|visible|}
    | `scroll -> {|scroll|}
    | `auto -> {|auto|}
    | `clip -> {|clip|}
end

module FontSynthesisWeight = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
end

module FontSynthesisStyle = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
end

module FontSynthesisSmallCaps = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
end

module FontSynthesisPosition = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
end

module FontKerning = struct
  type t =
    [ `auto
    | `none
    | `normal
    ]

  let toString x =
    match x with `auto -> {|auto|} | `none -> {|none|} | `normal -> {|normal|}
end

module FontVariantPosition = struct
  type t =
    [ `normal
    | `sub
    | `super
    ]

  let toString x =
    match x with `normal -> {|normal|} | `sub -> {|sub|} | `super -> {|super|}
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
    | `normal -> {|normal|}
    | `smallCaps -> {|small-caps|}
    | `allSmallCaps -> {|all-small-caps|}
    | `petiteCaps -> {|petite-caps|}
    | `allPetiteCaps -> {|all-petite-caps|}
    | `unicase -> {|unicase|}
    | `titlingCaps -> {|titling-caps|}
end

module FontOpticalSizing = struct
  type t =
    [ `auto
    | `none
    ]

  let toString x = match x with `auto -> {|auto|} | `none -> {|none|}
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
    | `normal -> {|normal|}
    | `text -> {|text|}
    | `emoji -> {|emoji|}
    | `unicode -> {|unicode|}
end
