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

module None = struct
  type t = [ `none ]

  let none = `none
  let toString = {js|none|js}
end

module Auto = struct
  type t = [ `auto ]

  let auto = `auto
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

  let toString x =
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
      `calc of calc_value
    | (* `num is used to represent a number in a calc expression, necessary for mult and div *)
      `num of float
    ]

  and t =
    [ time
    | `calc of calc_value
    | `min of t array
    | `max of t array
    ]

  let s (x : int) = `s x
  let ms (x : int) = `ms x

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

  let pct (x : float) = `percent x

  let toString x =
    match x with `percent x -> Kloth.Float.to_string x ^ {js|%|js}
end

module Url = struct
  type t = [ `url of string ]

  let url (x : string) = `url x
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
    | Percentage.t
    | Var.t
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
      `calc of calc_value
    | (* `num is used to represent a number in a calc expression, necessary for mult and div *)
      `num of float
    ]

  and t =
    [ length
    | `calc of calc_value
    | `min of t array
    | `max of t array
    ]

  let ch (x : float) = `ch x
  let cqw (x : float) = `cqw x
  let cqh (x : float) = `cqh x
  let cqi (x : float) = `cqi x
  let cqb (x : float) = `cqb x
  let cqmin (x : float) = `cqmin x
  let cqmax (x : float) = `cqmax x
  let em (x : float) = `em x
  let ex (x : float) = `ex x
  let rem (x : float) = `rem x
  let vh (x : float) = `vh x
  let vw (x : float) = `vw x
  let vmin (x : float) = `vmin x
  let vmax (x : float) = `vmax x
  let px (x : int) = `px x
  let pxFloat (x : float) = `pxFloat x
  let cm (x : float) = `cm x
  let mm (x : float) = `mm x
  let inch (x : float) = `inch x
  let pc (x : float) = `pc x
  let pt (x : int) = `pt x
  let zero = `zero
  let num (x : float) = `num x

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
    | #Var.t as x -> Var.toString x

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

  let deg (x : float) = `deg x
  let rad (x : float) = `rad x
  let grad (x : float) = `grad x
  let turn (x : float) = `turn x

  let toString x =
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

  let ltr = `ltr
  let rtl = `rtl

  let toString x =
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
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Isolation = struct
  type t =
    [ Auto.t
    | `isolate
    | Cascading.t
    | Var.t
    ]

  let isolate = `isolate

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `isolate -> {js|isolate|js}
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module AspectRatio = struct
  type t =
    [ Auto.t
    | `num of float
    | `ratio of int * int
    | Var.t
    | Cascading.t
    ]

  let ratio (x : int) (y : int) = `ratio (x, y)

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `smallCaps -> {js|small-caps|js}
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

  let toString x =
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
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
    | `num n -> Kloth.Float.to_string n
    | #Length.t as len -> Length.toString len
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
  let clip = `clip

  let toString x =
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

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Auto.t -> Auto.toString
    | #Length.t as l -> Length.toString l
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

  let toString x =
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

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | `normal -> {js|normal|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
end

module StrokeDashArray = struct
  type t =
    [ Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

module ScrollBehavior = struct
  type t =
    [ Auto.t
    | `smooth
    | Var.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | `baseline -> {js|baseline|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
    | `top -> {js|top|js}
    | `textTop -> {js|text-top|js}
    | `middle -> {js|middle|js}
    | `bottom -> {js|bottom|js}
    | `textBottom -> {js|text-bottom|js}
    | #Length.t as l -> Length.toString l
end

module EasingFunction = struct
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
  let steps (i : int) (dir : [ `start | `end_ ]) = `steps (i, dir)

  let cubicBezier (a : float) (b : float) (c : float) (d : float) =
    `cubicBezier (a, b, c, d)

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
end

module ListStyleType = struct
  type t =
    [ `Custom of string
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `Custom o -> o
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let translate (x : Length.t) (y : Length.t) = `translate (x, y)

  let translate3d (x : Length.t) (y : Length.t) (z : Length.t) =
    `translate3d (x, y, z)

  let translateX (x : Length.t) = `translateX x
  let translateY (y : Length.t) = `translateY y
  let translateZ (z : Length.t) = `translateZ z
  let scale (x : float) (y : float) = `scale (x, y)
  let scale3d (x : float) (y : float) (z : float) = `scale3d (x, y, z)
  let scaleX (x : float) = `scaleX x
  let scaleY (x : float) = `scaleY x
  let scaleZ (x : float) = `scaleZ x
  let rotate (a : Angle.t) = `rotate a

  let rotate3d (x : float) (y : float) (z : float) (a : Angle.t) =
    `rotate3d (x, y, z, a)

  let rotateX (a : Angle.t) = `rotateX a
  let rotateY (a : Angle.t) = `rotateY a
  let rotateZ (a : Angle.t) = `rotateZ a
  let skew (a : Angle.t) (a' : float) = `skew (a, a')
  let skewX (a : Angle.t) = `skewX a
  let skewY (a : Angle.t) = `skewY a
  let perspective (x : int) = `perspective x

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
  val none : t
  val toString : t -> string
end = struct
  type t = string

  let make x = x
  let none = {js|none|js}
  let toString x = x
end

module AnimationDirection = struct
  module Value = struct
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

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationDuration = struct
  type t =
    [ Time.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Time.t as x -> Time.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module AnimationDelay = struct
  include AnimationDuration
end

module AnimationFillMode = struct
  module Value = struct
    type t =
      [ None.t
      | `forwards
      | `backwards
      | `both
      ]

    let toString x =
      match x with
      | #None.t -> None.toString
      | `forwards -> {js|forwards|js}
      | `backwards -> {js|backwards|js}
      | `both -> {js|both|js}
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationIterationCount = struct
  module Value = struct
    type t =
      [ `count of float
      | `infinite
      ]

    let toString x =
      match x with
      | `count x -> Kloth.Float.to_string x
      | `infinite -> {js|infinite|js}
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationPlayState = struct
  module Value = struct
    type t =
      [ `paused
      | `running
      ]

    let toString x =
      match x with `paused -> {js|paused|js} | `running -> {js|running|js}
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TransitionProperty : sig
  type t

  val make : string -> t
  val none : t
  val all : t
  val toString : t -> string
end = struct
  type t = string

  let make x = x
  let toString x = x
  let none = {js|none|js}
  let all = {js|all|js}
end

module TransitionDuration = struct
  include AnimationDuration
end

module TransitionDelay = struct
  include TransitionDuration
end

module TransitionTimingFunction = struct
  type t =
    [ EasingFunction.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #EasingFunction.t as x -> EasingFunction.toString x
    | #Var.t as x -> Var.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module TransitionBehavior = struct
  module Value = struct
    type t =
      [ `normal
      | `allowDiscrete
      ]

    let toString x =
      match x with
      | `normal -> {js|normal|js}
      | `allowDiscrete -> {js|allow-discrete|js}
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module Transition = struct
  module Value = struct
    type value = {
      behavior : TransitionBehavior.Value.t;
      duration : Time.t;
      delay : Time.t;
      timingFunction : EasingFunction.t;
      property : TransitionProperty.t;
    }

    type t = [ `value of value ]

    let make ?(behavior = `normal) ?(duration = `ms 0) ?(delay = `ms 0)
      ?(timingFunction = `ease) ?(property = TransitionProperty.make "all") () =
      `value { behavior; duration; delay; timingFunction; property }

    let toString x =
      match x with
      | `value v ->
        TransitionProperty.toString v.property
        ^ {js| |js}
        ^ Time.toString v.duration
        ^ {js| |js}
        ^ EasingFunction.toString v.timingFunction
        ^ {js| |js}
        ^ Time.toString v.delay
        ^ {js| |js}
        ^ TransitionBehavior.Value.toString v.behavior
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as x -> Var.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Animation = struct
  module Value = struct
    type value = {
      duration : Time.t;
      delay : Time.t;
      direction : AnimationDirection.Value.t;
      timingFunction : EasingFunction.t;
      fillMode : AnimationFillMode.Value.t;
      playState : AnimationPlayState.Value.t;
      iterationCount : AnimationIterationCount.Value.t;
      name : AnimationName.t;
    }

    type t = [ `value of value ]

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

    let toString x =
      match x with
      | `value v ->
        AnimationName.toString v.name
        ^ {js| |js}
        ^ Time.toString v.duration
        ^ {js| |js}
        ^ EasingFunction.toString v.timingFunction
        ^ {js| |js}
        ^ Time.toString v.delay
        ^ {js| |js}
        ^ AnimationIterationCount.Value.toString v.iterationCount
        ^ {js| |js}
        ^ AnimationDirection.Value.toString v.direction
        ^ {js| |js}
        ^ AnimationFillMode.Value.toString v.fillMode
        ^ {js| |js}
        ^ AnimationPlayState.Value.toString v.playState
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationTimingFunction = struct
  include TransitionTimingFunction
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

  let rgb (r : int) (g : int) (b : int) = `rgb (r, g, b)

  let rgba (r : int) (g : int) (b : int) (a : alpha_with_calc) =
    `rgba (r, g, b, a)

  let hsl (h : angle_with_calc) (s : percent_with_calc) (l : percent_with_calc)
      =
    `hsl (h, s, l)

  let hsla (h : angle_with_calc) (s : percent_with_calc) (l : percent_with_calc)
    (a : angle_with_calc) =
    `hsla (h, s, l, a)

  let hex (x : string) = `hex x
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
    | #Length.t as l -> Length.toString l
end

module LetterSpacing = struct
  type t =
    [ `normal
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let normal = `normal

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | `normal -> {js|normal|js}
    | #Length.t as l -> Length.toString l
end

module LineHeight = struct
  type t =
    [ `normal
    | `abs of float
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | `normal -> {js|normal|js}
    | `abs x -> Kloth.Float.to_string x
    | #Length.t as l -> Length.toString l
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
  (* https://developer.mozilla.org/en-US/docs/Web/CSS/word-spacing *)
  type t =
    [ `normal
    | Var.t
    | Cascading.t
    | Length.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | `normal -> {js|normal|js}
    | #Length.t as l -> Length.toString l
end

module Display = struct
  type t =
    [ `block
    | `contents
    | `flex
    | `flow
    | `flowRoot
    | `grid
    | `inline
    | `inlineBlock
    | `inlineFlex
    | `inlineGrid
    | `inlineTable
    | `listItem
    | `mozBox
    | `mozInlineBox
    | `mozInlineStack
    | `msFlexbox
    | `msGrid
    | `msInlineFlexbox
    | `msInlineGrid
    | `ruby
    | `rubyBase
    | `rubyBaseContainer
    | `rubyText
    | `rubyTextContainer
    | `runIn
    | `table
    | `tableCaption
    | `tableCell
    | `tableColumn
    | `tableColumnGroup
    | `tableFooterGroup
    | `tableHeaderGroup
    | `tableRow
    | `tableRowGroup
    | `webkitBox
    | `webkitFlex
    | `webkitInlineBox
    | `webkitInlineFlex
    | None.t
    ]

  let toString x =
    match x with
    | `block -> {js|block|js}
    | `contents -> {js|contents|js}
    | `flex -> {js|flex|js}
    | `flow -> "flow"
    | `flowRoot -> "flow-root"
    | `grid -> {js|grid|js}
    | `inline -> {js|inline|js}
    | `inlineBlock -> {js|inline-block|js}
    | `inlineFlex -> {js|inline-flex|js}
    | `inlineGrid -> {js|inline-grid|js}
    | `inlineTable -> {js|inline-table|js}
    | `listItem -> {js|list-item|js}
    | `mozBox -> "-moz-box"
    | `mozInlineBox -> "-moz-inline-box"
    | `mozInlineStack -> "-moz-inline-stack"
    | `msFlexbox -> "-ms-flexbox"
    | `msGrid -> "-ms-grid"
    | `msInlineFlexbox -> "-ms-inline-flexbox"
    | `msInlineGrid -> "-ms-inline-grid"
    | `ruby -> "ruby"
    | `rubyBase -> "ruby-base"
    | `rubyBaseContainer -> "ruby-base-container"
    | `rubyText -> "ruby-text"
    | `rubyTextContainer -> "ruby-text-container"
    | `runIn -> {js|run-in|js}
    | `table -> {js|table|js}
    | `tableCaption -> {js|table-caption|js}
    | `tableCell -> {js|table-cell|js}
    | `tableColumn -> {js|table-column|js}
    | `tableColumnGroup -> {js|table-column-group|js}
    | `tableFooterGroup -> {js|table-footer-group|js}
    | `tableHeaderGroup -> {js|table-header-group|js}
    | `tableRow -> {js|table-row|js}
    | `tableRowGroup -> {js|table-row-group|js}
    | `webkitBox -> "-webkit-box"
    | `webkitFlex -> "-webkit-flex"
    | `webkitInlineBox -> "-webkit-inline-box"
    | `webkitInlineFlex -> "-webkit-inline-flex"
    | #None.t -> None.toString
end

module TextEmphasisStyle = struct
  module FilledOrOpen = struct
    type t =
      [ `filled
      | `open_
      | Var.t
      | Cascading.t
      ]

    let toString x =
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

    let toString x =
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

  let toString x =
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

    let toString x =
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

    let toString x =
      match x with
      | `over -> {js|over|js}
      | `under -> {js|under|js}
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c
  end

  type t =
    [ `TextEmphasisPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextEmphasisPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Position = struct
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
    | `hv of [ X.t | Length.t ] * [ Y.t | Length.t ]
    | `hvOffset of X.t * Length.t * Y.t * Length.t
    | Length.t
    ]

  let hv (x : [ X.t | Length.t ]) (y : [ Y.t | Length.t ]) = `hv (x, y)

  let hvOffset (x : X.t) (xo : Length.t) (y : Y.t) (yo : Length.t) =
    `hvOffset (x, xo, y, yo)

  let top = `top
  let bottom = `bottom
  let left = `left
  let right = `right
  let center = `center

  let toString x =
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
      ^ begin match v with
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

module TransformOrigin = struct
  module X = Position.X
  module Y = Position.Y

  let top = `top
  let bottom = `bottom
  let left = `left
  let right = `right
  let center = `center
  let hv = Position.hv

  let hvOffset (h : [ X.t | Length.t ]) (v : [ Y.t | Length.t ])
    (offset : Length.t) =
    `hvOffset (h, v, offset)

  type t =
    [ X.t
    | Y.t
    | Length.t
    | `hv of [ X.t | Length.t ] * [ Y.t | Length.t ]
    | `hvOffset of [ X.t | Length.t ] * [ Y.t | Length.t ] * Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #X.t as x -> X.toString x
    | #Y.t as x -> Y.toString x
    | #Length.t as x -> Length.toString x
    | `hv (h, v) ->
      (match h with
        | #X.t as h -> X.toString h
        | #Length.t as l -> Length.toString l)
      ^ {js| |js}
      ^
        (match v with
        | #Y.t as v -> Y.toString v
        | #Length.t as l -> Length.toString l)
    | `hvOffset (h, v, o) ->
      (match h with
        | #X.t as h -> X.toString h
        | #Length.t as l -> Length.toString l)
      ^ {js| |js}
      ^ (match v with
        | #Y.t as v -> Y.toString v
        | #Length.t as l -> Length.toString l)
      ^ {js||js}
      ^ Length.toString o
end

module OffsetAnchor = struct
  type t =
    [ Auto.t
    | Position.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
    | #Auto.t -> Auto.toString
    | #Position.t as x -> Position.toString x
end

module MaskPosition = struct
  type t =
    [ Position.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
    | #Position.t as x -> Position.toString x
end

module ObjectPosition = struct
  include MaskPosition
end

module PerspectiveOrigin = struct
  include MaskPosition
end

module BackgroundPosition = struct
  module Value = struct
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

    let hv = Position.hv

    let hvOffset
      (x : [ X.t | `leftOffset of Length.t | `rightOffset of Length.t ])
      (y : [ Y.t | `topOffset of Length.t | `bottomOffset of Length.t ]) =
      `hvOffset (x, y)

    let top = `top
    let bottom = `bottom
    let left = `left
    let right = `right
    let center = `center
    let topOffset (x : Length.t) = `topOffset x
    let bottomOffset (x : Length.t) = `bottomOffset x
    let leftOffset (x : Length.t) = `leftOffset x
    let rightOffset (x : Length.t) = `rightOffset x

    let toString x =
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
        ^ begin match v with
        | #Y.t as v -> Y.toString v
        | #Length.t as l -> Length.toString l
        end
      | `hvOffset (h, v) ->
        (match h with
          | #X.t as h -> X.toString h
          | `leftOffset l -> Length.toString l
          | `rightOffset l -> Length.toString l)
        ^ {js| |js}
        ^ begin match v with
        | #Y.t as v -> Y.toString v
        | `topOffset l -> Length.toString l
        | `bottomOffset l -> Length.toString l
        end
      | #Length.t as l -> Length.toString l
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
    | #Value.t as x -> Value.toString x
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let areas (x : string array) = `areas x

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
    | `span of [ `num of int | `ident of string | `numIdent of int * string ]
    ]

  let ident (x : string) = `ident x
  let num (x : int) = `num x
  let numIdent (x : int) (y : string) = `numIdent (x, y)

  let span (x : [ `num of int | `ident of string | `numIdent of int * string ])
      =
    `span x

  let rec toString (x : t) =
    match x with
    | #Auto.t -> Auto.toString
    | `ident s -> s
    | `num i -> string_of_int i
    | `numIdent (i, s) -> (string_of_int i ^ {js| |js}) ^ s
    | `span e -> {js|span |js} ^ toString (e :> t)
end

module GridArea = struct
  type t =
    [ GridLine.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
    match x with
    | `scroll -> {js|scroll|js}
    | `fixed -> {js|fixed|js}
    | `local -> {js|local|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundClip = struct
  module Value = struct
    type t =
      [ `borderBox
      | `paddingBox
      | `contentBox
      | `borderArea
      | `text
      ]

    let toString x =
      match x with
      | `borderBox -> {js|border-box|js}
      | `contentBox -> {js|content-box|js}
      | `paddingBox -> {js|padding-box|js}
      | `borderArea -> {js|border-area|js}
      | `text -> {js|text|js}
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
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

  let toString x =
    match x with
    | `borderBox -> {js|border-box|js}
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundRepeat = struct
  module Value = struct
    type style =
      [ `repeat
      | `space
      | `round
      | `noRepeat
      ]

    type t =
      [ `repeatX
      | `repeatY
      | style
      | `hv of style * style
      ]

    let rec toString (x : t) =
      match x with
      | `repeatX -> {js|repeat-x|js}
      | `repeatY -> {js|repeat-y|js}
      | `repeat -> {js|repeat|js}
      | `space -> {js|space|js}
      | `round -> {js|round|js}
      | `noRepeat -> {js|no-repeat|js}
      | `hv (h, v) -> toString (h :> t) ^ {js| |js} ^ toString (v :> t)
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextOverflow = struct
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `clip -> {js|clip|js}
    | `ellipsis -> {js|ellipsis|js}
    | `string s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationLine = struct
  module Value = struct
    type value = {
      underline : bool;
      overline : bool;
      lineThrough : bool;
      blink : bool;
    }

    type t =
      [ None.t
      | `value of value
      ]

    let make ?(underline = false) ?(overline = false) ?(lineThrough = false)
      ?(blink = false) () =
      `value { underline; overline; lineThrough; blink }

    let toString x =
      match x with
      | `value { underline; overline; lineThrough; blink } ->
        (match underline, overline, lineThrough, blink with
        | false, false, false, false -> None.toString
        | _, _, _, _ ->
          [|
            (if underline then Some {js|underline|js} else None);
            (if overline then Some {js|overline|js} else None);
            (if lineThrough then Some {js|line-through|js} else None);
            (if blink then Some {js|blink|js} else None);
          |]
          |> Kloth.Array.filter_map ~f:Kloth.Fun.id
          |> Kloth.Array.map_and_join ~f:Kloth.Fun.id ~sep:{js| |js})
      | #None.t -> None.toString
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationStyle = struct
  module Value = struct
    type t =
      [ None.t
      | `solid
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
      | #None.t -> None.toString
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationThickness = struct
  module Value = struct
    type t =
      [ `fromFont
      | Auto.t
      | None.t
      | Length.t
      ]

    let toString x =
      match x with
      | `fromFont -> {js|from-font|js}
      | #Auto.t -> Auto.toString
      | #None.t -> None.toString
      | #Length.t as l -> Length.toString l
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Value.t as x -> Value.toString x
end

module TextDecorationSkipInk = struct
  type t =
    [ Auto.t
    | None.t
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `none -> None.toString
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecoration = struct
  type value = {
    line : TextDecorationLine.Value.t option;
    thickness : TextDecorationThickness.Value.t option;
    style : TextDecorationStyle.Value.t option;
    color : Color.t option;
  }

  type t =
    [ `value of value
    | Cascading.t
    | Var.t
    | None.t
    ]

  let make ?line ?thickness ?style ?color () =
    `value { line; thickness; style; color }

  let toString x =
    match x with
    | `value x ->
      String.trim
        (match x.line with
        | Some line -> TextDecorationLine.Value.toString line ^ {js| |js}
        | None -> {js||js})
      ^ (match x.thickness with
        | Some thickness ->
          TextDecorationThickness.Value.toString thickness ^ {js| |js}
        | None -> {js||js})
      ^ (match x.style with
        | Some style -> TextDecorationStyle.Value.toString style ^ {js| |js}
        | None -> {js||js})
      ^
        (match x.color with
        | Some color -> Color.toString color
        | None -> {js||js})
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
end

module Width = struct
  module Value = struct
    type t =
      [ Auto.t
      | `fitContent
      | `maxContent
      | `minContent
      | Length.t
      ]

    let toString x =
      match x with
      | #Auto.t -> Auto.toString
      | `fitContent -> {js|fit-content|js}
      | `maxContent -> {js|max-content|js}
      | `minContent -> {js|min-content|js}
      | #Length.t as l -> Length.toString l
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Value.t as x -> Value.toString x
end

module MinWidth = struct
  type t =
    [ None.t
    | Width.Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
    | #Width.Value.t as w -> Width.Value.toString w
end

module MaxWidth = struct
  type t =
    [ None.t
    | Width.Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
    | #Width.Value.t as mw -> Width.Value.toString mw
end

module FlexBasis = struct
  module Value = struct
    type t =
      [ `content
      | Width.Value.t
      ]

    let toString x =
      match x with
      | `content -> {js|content|js}
      | #Width.Value.t as x -> Width.Value.toString x
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Value.t as x -> Value.toString x
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

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Auto.t -> Auto.toString
    | `fitContent -> {js|fit-content|js}
    | `maxContent -> {js|max-content|js}
    | `minContent -> {js|min-content|js}
    | #Length.t as l -> Length.toString l
end

module MaxHeight = struct
  type t =
    [ None.t
    | Height.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Height.t as mh -> Height.toString mh
end

module MinHeight = struct
  type t = Height.t

  let toString x = match x with #Height.t as h -> Height.toString h
end

module OverflowWrap = struct
  type t =
    [ `normal
    | `breakWord
    | `anywhere
    | Var.t
    | Cascading.t
    ]

  let toString x =
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

(* Shadow module handles the actual shadow value rendering *)
module Shadow = struct
  type t = string

  let box ?(x = `zero) ?(y = `zero) ?(blur = `zero) ?(spread = `zero)
    ?(inset = false) (color : Color.t) : t =
    Length.toString x
    ^ {js| |js}
    ^ Length.toString y
    ^ {js| |js}
    ^ Length.toString blur
    ^ {js| |js}
    ^ Length.toString spread
    ^ {js| |js}
    ^ Color.toString color
    ^ if inset then {js| inset|js} else {js||js}

  let text ?(x = `zero) ?(y = `zero) ?(blur = `zero) (color : Color.t) : t =
    Length.toString x
    ^ {js| |js}
    ^ Length.toString y
    ^ {js| |js}
    ^ Length.toString blur
    ^ {js| |js}
    ^ Color.toString color

  let toString (x : t) = x

  let many (arr : t array) : string =
    Kloth.Array.map_and_join ~sep:{js|, |js} ~f:toString arr
end

(* BoxShadow wraps Shadow.t with property-level variants *)
module BoxShadow = struct
  type t =
    [ `shadow of Shadow.t
    | `shadows of Shadow.t array
    | None.t
    | Var.t
    | Cascading.t
    ]

  (* Create a single box shadow *)
  let box = Shadow.box

  (* Wrap an array of shadows into BoxShadow.t *)
  let make (arr : Shadow.t array) : t = `shadows arr

  let toString (x : t) : string =
    match x with
    | `shadow s -> Shadow.toString s
    | `shadows arr -> Shadow.many arr
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* TextShadow wraps Shadow.t with property-level variants *)
module TextShadow = struct
  type t =
    [ `shadow of Shadow.t
    | `shadows of Shadow.t array
    | None.t
    | Var.t
    | Cascading.t
    ]

  (* Create a single text shadow *)
  let text = Shadow.text

  (* Wrap an array of shadows into TextShadow.t *)
  let make (arr : Shadow.t array) : t = `shadows arr

  let toString (x : t) : string =
    match x with
    | `shadow s -> Shadow.toString s
    | `shadows arr -> Shadow.many arr
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

  let linearGradient (direction : direction option) (stops : color_stop_list) =
    `linearGradient (Some direction, stops)

  let repeatingLinearGradient (direction : direction option)
    (stops : color_stop_list) =
    `repeatingLinearGradient (Some direction, stops)

  let radialGradient (shape : shape) (size : radial_size)
    (position : Position.t) (stops : color_stop_list) =
    `radialGradient (Some shape, Some size, Some position, stops)

  let repeatingRadialGradient (shape : shape) (size : radial_size)
    (position : Position.t) (stops : color_stop_list) =
    `repeatingRadialGradient (Some shape, Some size, Some position, stops)

  let conicGradient (angle : direction option) (stops : color_stop_list) =
    `conicGradient (Some angle, stops)

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

  let toString x =
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
  module Value = struct
    type t =
      [ `size of [ Length.t | Auto.t ] * [ Length.t | Auto.t ]
      | Length.t
      | Auto.t
      | `cover
      | `contain
      ]

    let size (x : [ Length.t | Auto.t ]) (y : [ Length.t | Auto.t ]) =
      `size (x, y)

    let size_to_string (x : [ Length.t | Auto.t ]) =
      match x with
      | #Length.t as l -> Length.toString l
      | #Auto.t -> Auto.toString

    let toString (x : t) =
      match x with
      | `size (x, y) -> size_to_string x ^ {js| |js} ^ size_to_string y
      | `cover -> {js|cover|js}
      | `contain -> {js|contain|js}
      | #Length.t -> Auto.toString
      | #Auto.t -> Auto.toString
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Value.t as x -> Value.toString x
end

module Image = struct
  type t =
    [ Url.t
    | Gradient.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | #Color.t as c -> Color.toString c
    | #BackgroundImage.t as u -> BackgroundImage.toString u
end

module BorderImageSource = struct
  module Value = struct
    type t =
      [ None.t
      | Image.t
      ]

    let toString x =
      match x with
      | #None.t -> None.toString
      | #Image.t as i -> Image.toString i
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module MaskImage = struct
  type t =
    [ None.t
    | Image.t
    ]

  let toString x =
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

module ImageOrientation = struct
  type t =
    [ None.t
    | `fromImage
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | #None.t -> None.toString
    | `fromImage -> {js|from-image|js}
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Flex = struct
  type t =
    [ FlexBasis.Value.t
    | `num of float
    | None.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #None.t -> None.toString
    | #FlexBasis.Value.t as x -> FlexBasis.Value.toString x
    | `num x -> Kloth.Float.to_string x
end

module TransformStyle = struct
  type t =
    [ `preserve3d
    | `flat
    | Var.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `local value -> ({js|local("|js} ^ value) ^ {js|")|js}
    | `url value -> ({js|url("|js} ^ value) ^ {js|")|js}
end

module FontFamilyName = struct
  type t =
    [ `serif
    | `sans_serif
    | `monospace
    | `cursive
    | `fantasy
    | `system_ui
    | `ui_serif
    | `ui_sans_serif
    | `ui_monospace
    | `ui_rounded
    | `emoji
    | `math
    | `fangsong
    | `apple_system
    | `quoted of string
    ]

  let toString x =
    match x with
    | `serif -> {js|serif|js}
    | `sans_serif -> {js|sans-serif|js}
    | `monospace -> {js|monospace|js}
    | `cursive -> {js|cursive|js}
    | `fantasy -> {js|fantasy|js}
    | `system_ui -> {js|system-ui|js}
    | `ui_serif -> {js|ui-serif|js}
    | `ui_sans_serif -> {js|ui-sans-serif|js}
    | `ui_monospace -> {js|ui-monospace|js}
    | `ui_rounded -> {js|ui-rounded|js}
    | `emoji -> {js|emoji|js}
    | `math -> {js|math|js}
    | `fangsong -> {js|fangsong|js}
    | `apple_system -> {js|-apple-system|js}
    | `quoted s ->
      (match String.get s 0 with
      | '\'' -> s
      | '"' -> s
      | _ -> ({js|"|js} ^ s) ^ {js|"|js})
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

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `block -> {js|block|js}
    | `swap -> {js|swap|js}
    | `fallback -> {js|fallback|js}
    | `optional -> {js|optional|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module SymbolsType = struct
  type t =
    [ `cyclic
    | `numeric
    | `alphabetic
    | `symbolic
    | `fixed
    ]

  let toString x =
    match x with
    | `cyclic -> {js|cyclic|js}
    | `numeric -> {js|numeric|js}
    | `alphabetic -> {js|alphabetic|js}
    | `symbolic -> {js|symbolic|js}
    | `fixed -> {js|fixed|js}
end

module Symbols = struct
  type t =
    SymbolsType.t option * [ `String of string | `Image of Image.t ] array

  let image_or_string_to_string = function
    | `String s -> s
    | `Image i -> Image.toString i

  let toString (x : t) =
    match x with
    | Some s, images ->
      {js|symbols(|js}
      ^ SymbolsType.toString s
      ^ {js|, |js}
      ^ Kloth.Array.map_and_join ~sep:{js|,|js} ~f:image_or_string_to_string
          images
      ^ {js|)|js}
    | None, images ->
      {js|symbols(|js}
      ^ Kloth.Array.map_and_join ~sep:{js|,|js} ~f:image_or_string_to_string
          images
      ^ {js|)|js}
end

module CounterStyleType = struct
  type t =
    [ ListStyleType.t
    | `Symbols of Symbols.t
    | `unset
    ]

  let toString (x : t) =
    match (x : t) with
    | #ListStyleType.t as c -> ListStyleType.toString c
    | `Symbols s -> Symbols.toString s
end

module Counter = struct
  type t = [ `counter of string * CounterStyleType.t option ]

  let counter ?(style = None) name = `counter (name, style)

  let toString x =
    match x with
    | `counter (counter, style) ->
      (match style with
      | None -> ({js|counter(|js} ^ counter) ^ {js|)|js}
      | Some s ->
        {js|counter(|js}
        ^ counter
        ^ {js|,|js}
        ^ CounterStyleType.toString s
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
    [ None.t
    | `increment of string * int
    | Var.t
    | Cascading.t
    ]

  let increment ?(value = 1) name = `increment (name, value)

  let toString x =
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

  let toString x =
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

  let toString x =
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
    if Kloth.String.length value = 0 then {js|""|js}
    else if Kloth.String.length value = 1 && Kloth.String.get value 0 = '"' then
      {js|'\"'|js}
    else if Kloth.String.length value = 1 && Kloth.String.get value 0 = '\''
    then {js|"'"|js}
    else (
      match Kloth.String.get value 0 with
      | '\'' | '"' -> value
      | _ -> {js|"|js} ^ value ^ {js|"|js})

  let toString x =
    match x with
    | #None.t -> None.toString
    | `normal -> {js|normal|js}
    | `openQuote -> {js|open-quote|js}
    | `closeQuote -> {js|close-quote|js}
    | `noOpenQuote -> {js|no-open-quote|js}
    | `noCloseQuote -> {js|no-close-quote|js}
    | `attr name -> ({js|attr(|js} ^ name) ^ {js|)|js}
    | `attrWithType (name, attr_type) ->
      ({js|attr(|js} ^ name) ^ {js| |js} ^ attr_type ^ {js|)|js}
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

    let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `hidden -> {js|hidden|js}
    | `visible -> {js|visible|js}
    | `scroll -> {js|scroll|js}
    | `clip -> {js|clip|js}
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module OverflowBlock = struct
  include OverflowInline
end

module FontSynthesisWeight = struct
  type t =
    [ Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module FontSynthesisStyle = struct
  include FontSynthesisWeight
end

module FontSynthesisSmallCaps = struct
  include FontSynthesisWeight
end

module FontSynthesisPosition = struct
  include FontSynthesisWeight
end

module FontKerning = struct
  type t =
    [ `normal
    | None.t
    | Var.t
    | Auto.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `text -> {js|text|js}
    | `emoji -> {js|emoji|js}
    | `unicode -> {js|unicode|js}
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module URange = struct
  type t =
    [ `single of string
    | `range of string * string
    | `wildcard of string * string
    ]
    array

  let toString x =
    Kloth.Array.map_and_join
      ~f:(function
        | `single x -> "U+" ^ x
        | `range (x, y) -> "U+" ^ x ^ "-" ^ y
        | `wildcard (x, y) -> "U+" ^ x ^ y)
      ~sep:{js|, |js} x
end

module InflexibleBreadth = struct
  type t =
    [ Length.t
    | Auto.t
    | `minContent
    | `maxContent
    ]

  let toString x =
    match x with
    | #Length.t as x -> Length.toString x
    | #Auto.t -> Auto.toString
    | `minContent -> {js|min-content|js}
    | `maxContent -> {js|max-content|js}
end

module TrackBreadth = struct
  type t =
    [ InflexibleBreadth.t
    | `fr of float
    ]

  let fr (x : float) = `fr x

  let toString x =
    match x with
    | #InflexibleBreadth.t as x -> InflexibleBreadth.toString x
    | `fr x -> Kloth.Float.to_string x ^ {js|fr|js}
end

module MinMax = struct
  type t = [ `minmax of InflexibleBreadth.t * TrackBreadth.t ]

  let minmax (x : InflexibleBreadth.t) (y : TrackBreadth.t) = `minmax (x, y)

  let toString x =
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

  let fitContent (x : Length.t) = `fitContent x

  let toString x =
    match x with
    | #TrackBreadth.t as x -> TrackBreadth.toString x
    | #MinMax.t as x -> MinMax.toString x
    | `fitContent x ->
      {js|fit-content|js} ^ {js|(|js} ^ Length.toString x ^ {js|)|js}
end

module GridAutoRows = struct
  type t =
    [ `trackSizes of TrackSize.t array
    | Var.t
    | Cascading.t
    | Auto.t
    ]

  let trackSizes (x : TrackSize.t array) = `trackSizes x

  let toString x =
    match x with
    | `trackSizes xs ->
      Kloth.Array.map_and_join ~f:TrackSize.toString ~sep:{js| |js} xs
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
    | #Auto.t -> Auto.toString
end

module GridAutoColumns = struct
  include GridAutoRows
end

module FixedSize = struct
  type t =
    [ Length.t
    | MinMax.t
    ]

  let toString x =
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

  let toString x =
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

  let toString x =
    match x with
    | `lineNames name -> name
    | #FixedSize.t as x -> FixedSize.toString x
    | #TrackSize.t as x -> TrackSize.toString x
end

module Repeat = struct
  type t = [ `repeat of RepeatValue.t * RepeatTrack.t array ]

  let repeat (x : RepeatValue.t) (y : RepeatTrack.t array) = `repeat (x, y)

  let toString x =
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

  let subgrid = `subgrid
  let lineNames (x : string) = `lineNames x

  let toString x =
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

  let toString x =
    match x with
    | `lineNames names -> names
    | #TrackSize.t as x -> TrackSize.toString x
end

module ExplicitTrackWithArea = struct
  type t =
    [ ExplicitTrack.t
    | `area of string
    ]

  let area (x : string) = `area x

  let toString x =
    match x with
    | `area x -> {js|'|js} ^ x ^ {js|'|js}
    | #ExplicitTrack.t as x -> ExplicitTrack.toString x
end

module GridTemplateRows = struct
  module Value = struct
    type t =
      [ None.t
      | `masonry
      | `tracks of Track.t array
      ]

    let tracks (x : Track.t array) = `tracks x

    let toString x =
      match x with
      | #None.t -> None.toString
      | `masonry -> {js|masonry|js}
      | `tracks x -> Kloth.Array.map_and_join ~f:Track.toString ~sep:{js| |js} x
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
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

    let toString x =
      match x with
      | #Var.t as x -> Var.toString x
      | #Length.t as x -> Length.toString x
  end

  type t =
    [ Value.t
    | None.t
    | Cascading.t
    ]

  let toString x =
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

  let toString x =
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

    let toString x =
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

  let toString x =
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
  module Value = struct
    type t =
      [ None.t
      | `rowsColumns of GridTemplateRows.Value.t * GridTemplateColumns.Value.t
      | `areasRows of ExplicitTrackWithArea.t array
      | `areasRowsColumns of
        ExplicitTrackWithArea.t array * ExplicitTrack.t array
      ]

    let rowsColumns (x : GridTemplateRows.Value.t)
      (y : GridTemplateColumns.Value.t) =
      `rowsColumns (x, y)

    let areasRows (x : ExplicitTrackWithArea.t) = `areasRows x

    let areasRowsColumns (x : ExplicitTrackWithArea.t array)
      (y : ExplicitTrack.t array) =
      `areasRowsColumns (x, y)

    let toString x =
      match x with
      | #None.t -> None.toString
      | `rowsColumns (r, c) ->
        GridTemplateRows.Value.toString r
        ^ {js| / |js}
        ^ GridTemplateColumns.Value.toString c
      | `areasRows x ->
        Kloth.Array.map_and_join ~sep:{js| |js}
          ~f:ExplicitTrackWithArea.toString x
      | `areasRowsColumns (ar, c) ->
        Kloth.Array.map_and_join ~sep:{js| |js}
          ~f:ExplicitTrackWithArea.toString ar
        ^ {js| / |js}
        ^ Kloth.Array.map_and_join ~sep:{js| |js} ~f:ExplicitTrack.toString c
  end

  type t =
    [ Value.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Var.t as x -> Var.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Bottom = struct
  type t =
    [ Length.t
    | Cascading.t
    | Var.t
    | Auto.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as x -> Var.toString x
    | #Length.t as x -> Length.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Top = struct
  type t =
    [ Length.t
    | Cascading.t
    | Var.t
    | Auto.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as x -> Var.toString x
    | #Length.t as x -> Length.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Right = struct
  type t =
    [ Length.t
    | Cascading.t
    | Var.t
    | Auto.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as x -> Var.toString x
    | #Length.t as x -> Length.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Left = struct
  type t =
    [ Length.t
    | Cascading.t
    | Var.t
    | Auto.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as x -> Var.toString x
    | #Length.t as x -> Length.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module Grid = struct
  type t =
    [ `template of GridTemplate.Value.t
    | `autoColumns of GridTemplateRows.Value.t * bool * TrackSize.t array option
    | `autoRows of bool * TrackSize.t array option * GridTemplateColumns.Value.t
    | Var.t
    | Cascading.t
    ]

  let template (x : GridTemplate.Value.t) = `template x

  let autoColumns ~(templateRows : GridTemplateRows.Value.t) ~(dense : bool)
    ~(autoColumns : TrackSize.t array option) =
    `autoColumns (templateRows, dense, autoColumns)

  let autoRows ~(dense : bool) ~(autoRows : TrackSize.t array option)
    ~(templateColumns : GridTemplateColumns.Value.t) =
    `autoRows (dense, autoRows, templateColumns)

  let toString x =
    match x with
    | `template x -> GridTemplate.Value.toString x
    | `autoColumns (templateRows, dense, autoColumns) ->
      GridTemplateRows.Value.toString templateRows
      ^ {js| / auto-flow|js}
      ^ (if dense then {js| dense|js} else {js||js})
      ^
        (match autoColumns with
        | Some cols ->
          {js| |js}
          ^ Kloth.Array.map_and_join ~f:TrackSize.toString ~sep:{js| |js} cols
        | None -> {js||js})
    | `autoRows (dense, autoRows, templateColumns) ->
      {js|auto-flow|js}
      ^ (if dense then {js| dense|js} else {js||js})
      ^ (match autoRows with
        | Some rows ->
          {js| |js}
          ^ Kloth.Array.map_and_join ~f:TrackSize.toString ~sep:{js| |js} rows
        | None -> {js||js})
      ^ {js| / |js}
      ^ GridTemplateColumns.Value.toString templateColumns
    | #Var.t as x -> Var.toString x
    | #Cascading.t as x -> Cascading.toString x
end

module BorderImageSlice = struct
  module Value = struct
    type t =
      [ `num of float
      | Percentage.t
      ]

    let toString x =
      match x with
      | `num x -> Kloth.Float.to_string x
      | #Percentage.t as x -> Percentage.toString x
  end

  module Fill = struct
    let toString = {js|fill|js}
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module BorderImageWidth = struct
  module Value = struct
    type t =
      [ Auto.t
      | `num of float
      | Length.t
      ]

    let toString x =
      match x with
      | `num x -> Kloth.Float.to_string x
      | #Auto.t -> Auto.toString
      | #Length.t as x -> Length.toString x
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
    | #Value.t as x -> Value.toString x
end

module BorderImageOutset = struct
  module Value = struct
    type t =
      [ `num of float
      | Length.t
      ]

    let toString x =
      match x with
      | `num x -> Kloth.Float.to_string x
      | #Length.t as x -> Length.toString x
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
    | #Value.t as x -> Value.toString x
end

module BorderImageRepeat = struct
  module Value = struct
    type t =
      [ `stretch
      | `repeat
      | `round
      | `space
      ]

    let toString x =
      match x with
      | `stretch -> {js|stretch|js}
      | `repeat -> {js|repeat|js}
      | `round -> {js|round|js}
      | `space -> {js|space|js}
  end

  type t =
    [ Value.t
    | Cascading.t
    | Var.t
    ]

  let toString x =
    match x with
    | #Value.t as x -> Value.toString x
    | #Cascading.t as x -> Cascading.toString x
    | #Var.t as x -> Var.toString x
end

module ScrollbarWidth = struct
  type t =
    [ `thin
    | Auto.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `thin -> {js|thin|js}
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollbarGutter = struct
  type t =
    [ `stable
    | `stableBothEdges
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `stable -> {js|stable|js}
    | `stableBothEdges -> {js|stable both-edges|js}
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollbarColor = struct
  type t =
    [ `thumbTrackColor of Color.t * Color.t
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `thumbTrackColor (a, b) -> Color.toString a ^ {js| |js} ^ Color.toString b
    | #Auto.t -> Auto.toString
    | #Var.t as var -> Var.toString var
    | #Cascading.t as c -> Cascading.toString c
end

module VisualBox = struct
  type t =
    [ `contentBox
    | `paddingBox
    | `borderBox
    ]

  let toString x =
    match x with
    | `contentBox -> {js|content-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `borderBox -> {js|border-box|js}
end

module OverflowClipMargin = struct
  module ClipEdgeOrigin = struct
    type t =
      [ VisualBox.t
      | Var.t
      ]

    let toString x =
      match x with
      | #VisualBox.t as vb -> VisualBox.toString vb
      | #Var.t as va -> Var.toString va
  end

  module Margin = struct
    type t =
      [ Length.t
      | Var.t
      ]

    let toString x =
      match x with
      | #Var.t as va -> Var.toString va
      | #Length.t as l -> Length.toString l
  end

  type t =
    [ ClipEdgeOrigin.t
    | Margin.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #ClipEdgeOrigin.t as ceo -> ClipEdgeOrigin.toString ceo
    | #Margin.t as m -> Margin.toString m
    | #Cascading.t as c -> Cascading.toString c
end

(* Border radius properties *)
module BorderRadius = struct
  type t =
    [ Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

module BorderSpacing = struct
  type t =
    [ Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

(* Flex grow/shrink - simple number properties *)
module FlexGrow = struct
  type t =
    [ `num of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Float.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FlexShrink = struct
  include FlexGrow
end

(* Order property *)
module Order = struct
  type t =
    [ `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Orphans and Widows - print properties *)
module Orphans = struct
  type t =
    [ `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Widows = struct
  include Orphans
end

(* Inset properties - logical positioning *)
module Inset = struct
  type t =
    [ Length.t
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

module InsetBlock = struct
  include Inset
end

module InsetInline = struct
  include Inset
end

(* Margin/Padding logical properties *)
module MarginBlock = struct
  include Margin
end

module MarginInline = struct
  include Margin
end

module PaddingBlock = struct
  include Margin
end

module PaddingInline = struct
  include Margin
end

(* Scroll margin and padding *)
module ScrollMargin = struct
  type t =
    [ Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

module ScrollPadding = struct
  type t =
    [ Auto.t
    | Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
    | #Length.t as l -> Length.toString l
end

(* Scroll snap properties *)
module ScrollSnapAlign = struct
  type t =
    [ None.t
    | `start
    | `end_
    | `center
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `start -> {js|start|js}
    | `end_ -> {js|end|js}
    | `center -> {js|center|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollSnapStop = struct
  type t =
    [ `normal
    | `always
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `always -> {js|always|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollSnapType = struct
  type t =
    [ None.t
    | `x
    | `y
    | `block
    | `inline
    | `both
    | `xMandatory
    | `yMandatory
    | `blockMandatory
    | `inlineMandatory
    | `bothMandatory
    | `xProximity
    | `yProximity
    | `blockProximity
    | `inlineProximity
    | `bothProximity
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `x -> {js|x|js}
    | `y -> {js|y|js}
    | `block -> {js|block|js}
    | `inline -> {js|inline|js}
    | `both -> {js|both|js}
    | `xMandatory -> {js|x mandatory|js}
    | `yMandatory -> {js|y mandatory|js}
    | `blockMandatory -> {js|block mandatory|js}
    | `inlineMandatory -> {js|inline mandatory|js}
    | `bothMandatory -> {js|both mandatory|js}
    | `xProximity -> {js|x proximity|js}
    | `yProximity -> {js|y proximity|js}
    | `blockProximity -> {js|block proximity|js}
    | `inlineProximity -> {js|inline proximity|js}
    | `bothProximity -> {js|both proximity|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Font properties *)
module FontSize = struct
  type t =
    [ `xxSmall
    | `xSmall
    | `small
    | `medium
    | `large
    | `xLarge
    | `xxLarge
    | `xxxLarge
    | `larger
    | `smaller
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `xxSmall -> {js|xx-small|js}
    | `xSmall -> {js|x-small|js}
    | `small -> {js|small|js}
    | `medium -> {js|medium|js}
    | `large -> {js|large|js}
    | `xLarge -> {js|x-large|js}
    | `xxLarge -> {js|xx-large|js}
    | `xxxLarge -> {js|xxx-large|js}
    | `larger -> {js|larger|js}
    | `smaller -> {js|smaller|js}
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module FontStretch = struct
  type t =
    [ `normal
    | `ultraCondensed
    | `extraCondensed
    | `condensed
    | `semiCondensed
    | `semiExpanded
    | `expanded
    | `extraExpanded
    | `ultraExpanded
    | Percentage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `ultraCondensed -> {js|ultra-condensed|js}
    | `extraCondensed -> {js|extra-condensed|js}
    | `condensed -> {js|condensed|js}
    | `semiCondensed -> {js|semi-condensed|js}
    | `semiExpanded -> {js|semi-expanded|js}
    | `expanded -> {js|expanded|js}
    | `extraExpanded -> {js|extra-expanded|js}
    | `ultraExpanded -> {js|ultra-expanded|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Cascading.t as c -> Cascading.toString c
end

(* Layout and appearance *)
module Appearance = struct
  type t =
    [ None.t
    | Auto.t
    | `button
    | `textfield
    | `menulistButton
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | `button -> {js|button|js}
    | `textfield -> {js|textfield|js}
    | `menulistButton -> {js|menulist-button|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Contain = struct
  type t =
    [ None.t
    | `strict
    | `content
    | `size
    | `layout
    | `style
    | `paint
    | `sizeLayout
    | `sizeStyle
    | `sizePaint
    | `layoutStyle
    | `layoutPaint
    | `stylePaint
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `strict -> {js|strict|js}
    | `content -> {js|content|js}
    | `size -> {js|size|js}
    | `layout -> {js|layout|js}
    | `style -> {js|style|js}
    | `paint -> {js|paint|js}
    | `sizeLayout -> {js|size layout|js}
    | `sizeStyle -> {js|size style|js}
    | `sizePaint -> {js|size paint|js}
    | `layoutStyle -> {js|layout style|js}
    | `layoutPaint -> {js|layout paint|js}
    | `stylePaint -> {js|style paint|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ContentVisibility = struct
  type t =
    [ `visible
    | `hidden
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WillChange = struct
  type t =
    [ Auto.t
    | `scrollPosition
    | `contents
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `scrollPosition -> {js|scroll-position|js}
    | `contents -> {js|contents|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WritingMode = struct
  type t =
    [ `horizontalTb
    | `verticalRl
    | `verticalLr
    | `sidewaysRl
    | `sidewaysLr
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `horizontalTb -> {js|horizontal-tb|js}
    | `verticalRl -> {js|vertical-rl|js}
    | `verticalLr -> {js|vertical-lr|js}
    | `sidewaysRl -> {js|sideways-rl|js}
    | `sidewaysLr -> {js|sideways-lr|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module UnicodeBidi = struct
  type t =
    [ `normal
    | `embed
    | `isolate
    | `bidiOverride
    | `isolateOverride
    | `plaintext
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `embed -> {js|embed|js}
    | `isolate -> {js|isolate|js}
    | `bidiOverride -> {js|bidi-override|js}
    | `isolateOverride -> {js|isolate-override|js}
    | `plaintext -> {js|plaintext|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Blend modes *)
module MixBlendMode = struct
  type t =
    [ `normal
    | `multiply
    | `screen
    | `overlay
    | `darken
    | `lighten
    | `colorDodge
    | `colorBurn
    | `hardLight
    | `softLight
    | `difference
    | `exclusion
    | `hue
    | `saturation
    | `color
    | `luminosity
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `multiply -> {js|multiply|js}
    | `screen -> {js|screen|js}
    | `overlay -> {js|overlay|js}
    | `darken -> {js|darken|js}
    | `lighten -> {js|lighten|js}
    | `colorDodge -> {js|color-dodge|js}
    | `colorBurn -> {js|color-burn|js}
    | `hardLight -> {js|hard-light|js}
    | `softLight -> {js|soft-light|js}
    | `difference -> {js|difference|js}
    | `exclusion -> {js|exclusion|js}
    | `hue -> {js|hue|js}
    | `saturation -> {js|saturation|js}
    | `color -> {js|color|js}
    | `luminosity -> {js|luminosity|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundBlendMode = struct
  include MixBlendMode
end

(* Break properties *)
module BreakAfter = struct
  type t =
    [ Auto.t
    | `avoid
    | `always
    | `all
    | `avoidPage
    | `page
    | `left
    | `right
    | `recto
    | `verso
    | `avoidColumn
    | `column
    | `avoidRegion
    | `region
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `avoid -> {js|avoid|js}
    | `always -> {js|always|js}
    | `all -> {js|all|js}
    | `avoidPage -> {js|avoid-page|js}
    | `page -> {js|page|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `recto -> {js|recto|js}
    | `verso -> {js|verso|js}
    | `avoidColumn -> {js|avoid-column|js}
    | `column -> {js|column|js}
    | `avoidRegion -> {js|avoid-region|js}
    | `region -> {js|region|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BreakBefore = struct
  include BreakAfter
end

module BreakInside = struct
  type t =
    [ Auto.t
    | `avoid
    | `avoidPage
    | `avoidColumn
    | `avoidRegion
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `avoid -> {js|avoid|js}
    | `avoidPage -> {js|avoid-page|js}
    | `avoidColumn -> {js|avoid-column|js}
    | `avoidRegion -> {js|avoid-region|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module PageBreakAfter = struct
  type t =
    [ Auto.t
    | `always
    | `avoid
    | `left
    | `right
    | `recto
    | `verso
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `always -> {js|always|js}
    | `avoid -> {js|avoid|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `recto -> {js|recto|js}
    | `verso -> {js|verso|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module PageBreakBefore = struct
  include PageBreakAfter
end

module PageBreakInside = struct
  type t =
    [ Auto.t
    | `avoid
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `avoid -> {js|avoid|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Column properties - combines width and count *)
module Columns = struct
  type t =
    [ ColumnWidth.t
    | `count of int
    | Cascading.t
    ]

  let toString x =
    match x with
    | #ColumnWidth.t as cw -> ColumnWidth.toString cw
    | `count v -> Kloth.Int.to_string v
    | #Cascading.t as c -> Cascading.toString c
end

module ColumnFill = struct
  type t =
    [ Auto.t
    | `balance
    | `balanceAll
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `balance -> {js|balance|js}
    | `balanceAll -> {js|balance-all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ColumnSpan = struct
  type t =
    [ None.t
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Container queries *)
module ContainerName = struct
  type t =
    [ None.t
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ContainerType = struct
  type t =
    [ `normal
    | `size
    | `inlineSize
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `size -> {js|size|js}
    | `inlineSize -> {js|inline-size|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Table properties *)
module CaptionSide = struct
  type t =
    [ `top
    | `bottom
    | `blockStart
    | `blockEnd
    | `inlineStart
    | `inlineEnd
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `top -> {js|top|js}
    | `bottom -> {js|bottom|js}
    | `blockStart -> {js|block-start|js}
    | `blockEnd -> {js|block-end|js}
    | `inlineStart -> {js|inline-start|js}
    | `inlineEnd -> {js|inline-end|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module EmptyCells = struct
  type t =
    [ `show
    | `hide
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `show -> {js|show|js}
    | `hide -> {js|hide|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Quotes = struct
  type t =
    [ None.t
    | Auto.t
    | `quotes of (string * string) array
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | `quotes pairs ->
      pairs
      |> Array.to_list
      |> List.map (fun (open_, close) ->
        {js|"|js} ^ open_ ^ {js|" "|js} ^ close ^ {js|"|js})
      |> String.concat {js| |js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Text properties *)
module TextIndent = struct
  type t =
    [ Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module TextUnderlineOffset = struct
  type t =
    [ Auto.t
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module TextUnderlinePosition = struct
  type t =
    [ Auto.t
    | `fromFont
    | `under
    | `left
    | `right
    | `underLeft
    | `underRight
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `fromFont -> {js|from-font|js}
    | `under -> {js|under|js}
    | `left -> {js|left|js}
    | `right -> {js|right|js}
    | `underLeft -> {js|under left|js}
    | `underRight -> {js|under right|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextRendering = struct
  type t =
    [ Auto.t
    | `optimizeSpeed
    | `optimizeLegibility
    | `geometricPrecision
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `optimizeSpeed -> {js|optimizeSpeed|js}
    | `optimizeLegibility -> {js|optimizeLegibility|js}
    | `geometricPrecision -> {js|geometricPrecision|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Offset/motion path properties *)
module OffsetDistance = struct
  type t =
    [ Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module OffsetRotate = struct
  type t =
    [ Auto.t
    | `reverse
    | Angle.t
    | `autoAngle of Angle.t
    | `reverseAngle of Angle.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `reverse -> {js|reverse|js}
    | #Angle.t as a -> Angle.toString a
    | `autoAngle a -> {js|auto |js} ^ Angle.toString a
    | `reverseAngle a -> {js|reverse |js} ^ Angle.toString a
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Color interpolation and adjustment *)
module ColorInterpolation = struct
  type t =
    [ Auto.t
    | `sRGB
    | `linearRGB
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `sRGB -> {js|sRGB|js}
    | `linearRGB -> {js|linearRGB|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ColorInterpolationFilters = struct
  include ColorInterpolation
end

module ColorAdjust = struct
  type t =
    [ `economy
    | `exact
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `economy -> {js|economy|js}
    | `exact -> {js|exact|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ColorScheme = struct
  type t =
    [ `normal
    | `light
    | `dark
    | `lightDark
    | `only of [ `light | `dark ]
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `light -> {js|light|js}
    | `dark -> {js|dark|js}
    | `lightDark -> {js|light dark|js}
    | `only `light -> {js|light only|js}
    | `only `dark -> {js|dark only|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Clip = struct
  type t =
    [ Auto.t
    | `rect of Length.t * Length.t * Length.t * Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `rect (top, right, bottom, left) ->
      {js|rect(|js}
      ^ Length.toString top
      ^ {js|, |js}
      ^ Length.toString right
      ^ {js|, |js}
      ^ Length.toString bottom
      ^ {js|, |js}
      ^ Length.toString left
      ^ {js|)|js}
    | #Cascading.t as c -> Cascading.toString c
end

module ClipRule = struct
  type t =
    [ `nonzero
    | `evenodd
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `nonzero -> {js|nonzero|js}
    | `evenodd -> {js|evenodd|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Zoom property *)
module Zoom = struct
  type t =
    [ `normal
    | `reset
    | `num of float
    | Percentage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `reset -> {js|reset|js}
    | `num n -> Kloth.Float.to_string n
    | #Percentage.t as p -> Percentage.toString p
    | #Cascading.t as c -> Cascading.toString c
end

(* Font advanced properties *)
module FontSizeAdjust = struct
  type t =
    [ None.t
    | `num of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `num n -> Kloth.Float.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Text advanced properties *)
module TextAnchor = struct
  type t =
    [ `start
    | `middle
    | `end_
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `middle -> {js|middle|js}
    | `end_ -> {js|end|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextSizeAdjust = struct
  type t =
    [ None.t
    | Auto.t
    | Percentage.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Auto.t -> Auto.toString
    | #Percentage.t as p -> Percentage.toString p
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Shape properties *)
module ShapeMargin = struct
  type t =
    [ Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module ShapeImageThreshold = struct
  type t =
    [ `num of float
    | Percentage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Float.to_string n
    | #Percentage.t as p -> Percentage.toString p
    | #Cascading.t as c -> Cascading.toString c
end

(* Baseline properties *)
module BaselineShift = struct
  type t =
    [ `baseline
    | `sub
    | `super
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `baseline -> {js|baseline|js}
    | `sub -> {js|sub|js}
    | `super -> {js|super|js}
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module DominantBaseline = struct
  type t =
    [ Auto.t
    | `useScript
    | `noChange
    | `resetSize
    | `ideographic
    | `alphabetic
    | `hanging
    | `mathematical
    | `central
    | `middle
    | `textAfterEdge
    | `textBeforeEdge
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `useScript -> {js|use-script|js}
    | `noChange -> {js|no-change|js}
    | `resetSize -> {js|reset-size|js}
    | `ideographic -> {js|ideographic|js}
    | `alphabetic -> {js|alphabetic|js}
    | `hanging -> {js|hanging|js}
    | `mathematical -> {js|mathematical|js}
    | `central -> {js|central|js}
    | `middle -> {js|middle|js}
    | `textAfterEdge -> {js|text-after-edge|js}
    | `textBeforeEdge -> {js|text-before-edge|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module AlignmentBaseline = struct
  include DominantBaseline
end

(* Hyphenate properties *)
module HyphenateCharacter = struct
  type t =
    [ Auto.t
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `string s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module HyphenateLimitChars = struct
  type t =
    [ Auto.t
    | `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module HyphenateLimitLines = struct
  type t =
    [ `noLimit
    | `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `noLimit -> {js|no-limit|js}
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module HyphenateLimitZone = struct
  type t =
    [ Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

(* Initial letter *)
module InitialLetter = struct
  type t =
    [ `normal
    | `num of float
    | `numInt of float * int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `num n -> Kloth.Float.to_string n
    | `numInt (n, i) ->
      Kloth.Float.to_string n ^ {js| |js} ^ Kloth.Int.to_string i
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module InitialLetterAlign = struct
  type t =
    [ Auto.t
    | `alphabetic
    | `hanging
    | `ideographic
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `alphabetic -> {js|alphabetic|js}
    | `hanging -> {js|hanging|js}
    | `ideographic -> {js|ideographic|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Line clamp *)
module LineClamp = struct
  type t =
    [ None.t
    | `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaxLines = struct
  include LineClamp
end

module BoxDecorationBreak = struct
  type t =
    [ `slice
    | `clone
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `slice -> {js|slice|js}
    | `clone -> {js|clone|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Ruby properties *)
module RubyAlign = struct
  type t =
    [ `start
    | `center
    | `spaceBetween
    | `spaceAround
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `center -> {js|center|js}
    | `spaceBetween -> {js|space-between|js}
    | `spaceAround -> {js|space-around|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module RubyMerge = struct
  type t =
    [ `separate
    | `collapse
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `separate -> {js|separate|js}
    | `collapse -> {js|collapse|js}
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module RubyPosition = struct
  type t =
    [ `over
    | `under
    | `interCharacter
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `over -> {js|over|js}
    | `under -> {js|under|js}
    | `interCharacter -> {js|inter-character|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Place properties - shorthands for align + justify *)
module PlaceContent = struct
  type t = AlignContent.t

  let toString x = AlignContent.toString x
end

module PlaceItems = struct
  type t = AlignItems.t

  let toString x = AlignItems.toString x
end

module PlaceSelf = struct
  type t = AlignSelf.t

  let toString x = AlignSelf.toString x
end

(* Margin trim *)
module MarginTrim = struct
  type t =
    [ None.t
    | `inFlow
    | `all
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `inFlow -> {js|in-flow|js}
    | `all -> {js|all|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Additional scroll snap properties *)
module ScrollSnapCoordinate = struct
  type t =
    [ None.t
    | Position.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Position.t as p -> Position.toString p
end

module ScrollSnapDestination = struct
  type t = Position.t

  let toString x = Position.toString x
end

(* Image properties *)
module ImageResolution = struct
  type t =
    [ `fromImage
    | `dpi of float
    | `dpcm of float
    | `dppx of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `fromImage -> {js|from-image|js}
    | `dpi n -> Kloth.Float.to_string n ^ {js|dpi|js}
    | `dpcm n -> Kloth.Float.to_string n ^ {js|dpcm|js}
    | `dppx n -> Kloth.Float.to_string n ^ {js|dppx|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Additional text properties *)
module TextOrientation = struct
  type t =
    [ `mixed
    | `upright
    | `sideways
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `mixed -> {js|mixed|js}
    | `upright -> {js|upright|js}
    | `sideways -> {js|sideways|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextCombineUpright = struct
  type t =
    [ None.t
    | `all
    | `digits of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `all -> {js|all|js}
    | `digits n -> {js|digits |js} ^ Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module HangingPunctuation = struct
  type t =
    [ None.t
    | `first
    | `last
    | `forceEnd
    | `allowEnd
    | `firstForceEnd
    | `firstAllowEnd
    | `lastForceEnd
    | `lastAllowEnd
    | `firstLast
    | `firstForceEndLast
    | `firstAllowEndLast
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `first -> {js|first|js}
    | `last -> {js|last|js}
    | `forceEnd -> {js|force-end|js}
    | `allowEnd -> {js|allow-end|js}
    | `firstForceEnd -> {js|first force-end|js}
    | `firstAllowEnd -> {js|first allow-end|js}
    | `lastForceEnd -> {js|last force-end|js}
    | `lastAllowEnd -> {js|last allow-end|js}
    | `firstLast -> {js|first last|js}
    | `firstForceEndLast -> {js|first force-end last|js}
    | `firstAllowEndLast -> {js|first allow-end last|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Column rule *)
module ColumnRule = struct
  type t =
    [ LineWidth.t
    | BorderStyle.t
    | Color.t
    ]

  let toString x =
    match x with
    | #LineWidth.t as lw -> LineWidth.toString lw
    | #BorderStyle.t as bs -> BorderStyle.toString bs
    | #Color.t as c -> Color.toString c
end

module ColumnRuleStyle = struct
  include BorderStyle
end

module ColumnRuleWidth = struct
  include LineWidth
end

module ColumnRuleColor = struct
  include Color
end

(* All property *)
module All = struct
  type t =
    [ `initial
    | `inherit_
    | `unset
    | `revert
    ]

  let toString x =
    match x with
    | `initial -> {js|initial|js}
    | `inherit_ -> {js|inherit|js}
    | `unset -> {js|unset|js}
    | `revert -> {js|revert|js}
end

(* Font family - uses existing FontFamilyName *)
module FontFamily = struct
  type t =
    [ `families of FontFamilyName.t array
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `families families ->
      families
      |> Array.to_list
      |> List.map FontFamilyName.toString
      |> String.concat {js|, |js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Font palette *)
module FontPalette = struct
  type t =
    [ `normal
    | `light
    | `dark
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `light -> {js|light|js}
    | `dark -> {js|dark|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Font variant properties *)
module FontVariantAlternates = struct
  type t =
    [ `normal
    | `stylistic of string
    | `historicalForms
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `stylistic s -> {js|stylistic(|js} ^ s ^ {js|)|js}
    | `historicalForms -> {js|historical-forms|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantEastAsian = struct
  type t =
    [ `normal
    | `jis78
    | `jis83
    | `jis90
    | `jis04
    | `simplified
    | `traditional
    | `fullWidth
    | `proportionalWidth
    | `ruby
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `jis78 -> {js|jis78|js}
    | `jis83 -> {js|jis83|js}
    | `jis90 -> {js|jis90|js}
    | `jis04 -> {js|jis04|js}
    | `simplified -> {js|simplified|js}
    | `traditional -> {js|traditional|js}
    | `fullWidth -> {js|full-width|js}
    | `proportionalWidth -> {js|proportional-width|js}
    | `ruby -> {js|ruby|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantLigatures = struct
  type t =
    [ `normal
    | None.t
    | `commonLigatures
    | `noCommonLigatures
    | `discretionaryLigatures
    | `noDiscretionaryLigatures
    | `historicalLigatures
    | `noHistoricalLigatures
    | `contextual
    | `noContextual
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | #None.t -> None.toString
    | `commonLigatures -> {js|common-ligatures|js}
    | `noCommonLigatures -> {js|no-common-ligatures|js}
    | `discretionaryLigatures -> {js|discretionary-ligatures|js}
    | `noDiscretionaryLigatures -> {js|no-discretionary-ligatures|js}
    | `historicalLigatures -> {js|historical-ligatures|js}
    | `noHistoricalLigatures -> {js|no-historical-ligatures|js}
    | `contextual -> {js|contextual|js}
    | `noContextual -> {js|no-contextual|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantNumeric = struct
  type t =
    [ `normal
    | `liningNums
    | `oldstyleNums
    | `proportionalNums
    | `tabularNums
    | `diagonalFractions
    | `stackedFractions
    | `ordinal
    | `slashedZero
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `liningNums -> {js|lining-nums|js}
    | `oldstyleNums -> {js|oldstyle-nums|js}
    | `proportionalNums -> {js|proportional-nums|js}
    | `tabularNums -> {js|tabular-nums|js}
    | `diagonalFractions -> {js|diagonal-fractions|js}
    | `stackedFractions -> {js|stacked-fractions|js}
    | `ordinal -> {js|ordinal|js}
    | `slashedZero -> {js|slashed-zero|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontFeatureSettings = struct
  type t =
    [ `normal
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariationSettings = struct
  include FontFeatureSettings
end

module FontLanguageOverride = struct
  type t =
    [ `normal
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `string s -> {js|"|js} ^ s ^ {js|"|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Text decoration skip properties *)
module TextDecorationSkip = struct
  type t =
    [ None.t
    | `objects
    | `spaces
    | `leadingSpaces
    | `trailingSpaces
    | `edges
    | `boxDecoration
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `objects -> {js|objects|js}
    | `spaces -> {js|spaces|js}
    | `leadingSpaces -> {js|leading-spaces|js}
    | `trailingSpaces -> {js|trailing-spaces|js}
    | `edges -> {js|edges|js}
    | `boxDecoration -> {js|box-decoration|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextDecorationSkipSelf = struct
  include TextDecorationSkip
end

module TextDecorationSkipSpaces = struct
  include TextDecorationSkip
end

(* Additional text properties *)
module TextAutospace = struct
  type t =
    [ None.t
    | `ideographAlpha
    | `ideographNumeric
    | `ideographParenthesis
    | `ideographSpace
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `ideographAlpha -> {js|ideograph-alpha|js}
    | `ideographNumeric -> {js|ideograph-numeric|js}
    | `ideographParenthesis -> {js|ideograph-parenthesis|js}
    | `ideographSpace -> {js|ideograph-space|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextBlink = struct
  type t =
    [ None.t
    | `blink
    | `blinkAnywhere
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `blink -> {js|blink|js}
    | `blinkAnywhere -> {js|blink-anywhere|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextJustifyTrim = struct
  type t =
    [ None.t
    | `all
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `all -> {js|all|js}
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextKashida = struct
  type t =
    [ None.t
    | `horizontal
    | `vertical
    | `both
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `horizontal -> {js|horizontal|js}
    | `vertical -> {js|vertical|js}
    | `both -> {js|both|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module TextKashidaSpace = struct
  type t =
    [ `normal
    | `pre
    | `post
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `pre -> {js|pre|js}
    | `post -> {js|post|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Line height step *)
module LineHeightStep = struct
  type t =
    [ Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

(* Shape outside *)
module ShapeOutside = struct
  type t =
    [ None.t
    | `marginBox
    | `borderBox
    | `paddingBox
    | `contentBox
    | Image.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `marginBox -> {js|margin-box|js}
    | `borderBox -> {js|border-box|js}
    | `paddingBox -> {js|padding-box|js}
    | `contentBox -> {js|content-box|js}
    | #Image.t as i -> Image.toString i
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ShapeRendering = struct
  type t =
    [ Auto.t
    | `optimizeSpeed
    | `crispEdges
    | `geometricPrecision
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `optimizeSpeed -> {js|optimizeSpeed|js}
    | `crispEdges -> {js|crispEdges|js}
    | `geometricPrecision -> {js|geometricPrecision|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Remaining offset properties *)
module OffsetPosition = struct
  type t =
    [ Auto.t
    | Position.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Position.t as p -> Position.toString p
end

module OffsetPath = struct
  type t =
    [ None.t
    | Url.t
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Url.t as u -> Url.toString u
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Offset = struct
  type t = OffsetPath.t

  let toString x = OffsetPath.toString x
end

(* SVG properties *)
module FillOpacity = struct
  include AlphaValue
end

module FillRule = struct
  type t =
    [ `nonzero
    | `evenodd
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `nonzero -> {js|nonzero|js}
    | `evenodd -> {js|evenodd|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeWidth = struct
  type t =
    [ Length.t
    | `num of float
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | `num n -> Kloth.Float.to_string n
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeLinecap = struct
  type t =
    [ `butt
    | `round
    | `square
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `butt -> {js|butt|js}
    | `round -> {js|round|js}
    | `square -> {js|square|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeLinejoin = struct
  type t =
    [ `miter
    | `round
    | `bevel
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `miter -> {js|miter|js}
    | `round -> {js|round|js}
    | `bevel -> {js|bevel|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeMiterlimit = struct
  type t =
    [ `num of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Float.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeDashoffset = struct
  type t =
    [ Length.t
    | `num of float
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | `num n -> Kloth.Float.to_string n
    | #Cascading.t as c -> Cascading.toString c
end

module Marker = struct
  type t =
    [ None.t
    | Url.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Url.t as u -> Url.toString u
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MarkerStart = struct
  include Marker
end

module MarkerMid = struct
  include Marker
end

module MarkerEnd = struct
  include Marker
end

module PaintOrder = struct
  type t =
    [ `normal
    | `fill
    | `stroke
    | `markers
    | `fillStroke
    | `fillMarkers
    | `strokeFill
    | `strokeMarkers
    | `markersFill
    | `markersStroke
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `fill -> {js|fill|js}
    | `stroke -> {js|stroke|js}
    | `markers -> {js|markers|js}
    | `fillStroke -> {js|fill stroke|js}
    | `fillMarkers -> {js|fill markers|js}
    | `strokeFill -> {js|stroke fill|js}
    | `strokeMarkers -> {js|stroke markers|js}
    | `markersFill -> {js|markers fill|js}
    | `markersStroke -> {js|markers stroke|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Kerning = struct
  type t =
    [ Auto.t
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

module GlyphOrientationHorizontal = struct
  type t =
    [ Angle.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Angle.t as a -> Angle.toString a
    | #Cascading.t as c -> Cascading.toString c
end

module GlyphOrientationVertical = struct
  include GlyphOrientationHorizontal
end

(* Remaining misc properties *)
module ImeMode = struct
  type t =
    [ Auto.t
    | `normal
    | `active
    | `inactive
    | `disabled
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `normal -> {js|normal|js}
    | `active -> {js|active|js}
    | `inactive -> {js|inactive|js}
    | `disabled -> {js|disabled|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Azimuth = struct
  type t =
    [ Angle.t
    | `leftSide
    | `farLeft
    | `left
    | `centerLeft
    | `center
    | `centerRight
    | `right
    | `farRight
    | `rightSide
    | `behind
    | `leftwards
    | `rightwards
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Angle.t as a -> Angle.toString a
    | `leftSide -> {js|left-side|js}
    | `farLeft -> {js|far-left|js}
    | `left -> {js|left|js}
    | `centerLeft -> {js|center-left|js}
    | `center -> {js|center|js}
    | `centerRight -> {js|center-right|js}
    | `right -> {js|right|js}
    | `farRight -> {js|far-right|js}
    | `rightSide -> {js|right-side|js}
    | `behind -> {js|behind|js}
    | `leftwards -> {js|leftwards|js}
    | `rightwards -> {js|rightwards|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Behavior = struct
  type t =
    [ `urls of string array
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `urls urls ->
      urls
      |> Array.to_list
      |> List.map (fun u -> {js|url(|js} ^ u ^ {js|)|js})
      |> String.concat {js| |js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MasonryAutoFlow = struct
  type t =
    [ `pack
    | `next
    | `definiteFirst
    | `ordered
    | `packDefiniteFirst
    | `packOrdered
    | `nextDefiniteFirst
    | `nextOrdered
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `pack -> {js|pack|js}
    | `next -> {js|next|js}
    | `definiteFirst -> {js|definite-first|js}
    | `ordered -> {js|ordered|js}
    | `packDefiniteFirst -> {js|pack definite-first|js}
    | `packOrdered -> {js|pack ordered|js}
    | `nextDefiniteFirst -> {js|next definite-first|js}
    | `nextOrdered -> {js|next ordered|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ForcedColorAdjust = struct
  type t =
    [ Auto.t
    | None.t
    | `preserveParentColor
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `preserveParentColor -> {js|preserve-parent-color|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BlockOverflow = struct
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `clip -> {js|clip|js}
    | `ellipsis -> {js|ellipsis|js}
    | `string s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Navigation properties (obsolete but adding for completeness) *)
module NavIndex = struct
  type t =
    [ Auto.t
    | `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module NavDown = struct
  include NavIndex
end

module NavLeft = struct
  include NavIndex
end

module NavRight = struct
  include NavIndex
end

module NavUp = struct
  include NavIndex
end

(* Container shorthand *)
module Container = struct
  type t =
    [ `name of string
    | `type_ of [ `normal | `size | `inlineSize ]
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `name s -> s
    | `type_ `normal -> {js|normal|js}
    | `type_ `size -> {js|size|js}
    | `type_ `inlineSize -> {js|inline-size|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Scroll snap points (legacy) *)
module ScrollSnapPointsX = struct
  type t =
    [ None.t
    | `repeat of Length.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `repeat l -> {js|repeat(|js} ^ Length.toString l ^ {js|)|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollSnapPointsY = struct
  include ScrollSnapPointsX
end

(* Legacy box properties *)
module BoxAlign = struct
  type t =
    [ `start
    | `center
    | `end_
    | `baseline
    | `stretch
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `center -> {js|center|js}
    | `end_ -> {js|end|js}
    | `baseline -> {js|baseline|js}
    | `stretch -> {js|stretch|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxDirection = struct
  type t =
    [ `normal
    | `reverse
    | `inherit_
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `reverse -> {js|reverse|js}
    | `inherit_ -> {js|inherit|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxFlex = struct
  type t =
    [ `num of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Float.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxFlexGroup = struct
  type t =
    [ `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxLines = struct
  type t =
    [ `single
    | `multiple
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `single -> {js|single|js}
    | `multiple -> {js|multiple|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxOrdinalGroup = struct
  type t =
    [ `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxOrient = struct
  type t =
    [ `horizontal
    | `vertical
    | `inlineAxis
    | `blockAxis
    | `inherit_
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `horizontal -> {js|horizontal|js}
    | `vertical -> {js|vertical|js}
    | `inlineAxis -> {js|inline-axis|js}
    | `blockAxis -> {js|block-axis|js}
    | `inherit_ -> {js|inherit|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module BoxPack = struct
  type t =
    [ `start
    | `center
    | `end_
    | `justify
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `start -> {js|start|js}
    | `center -> {js|center|js}
    | `end_ -> {js|end|js}
    | `justify -> {js|justify|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Layout grid (legacy IE) *)
module LayoutGrid = struct
  type t =
    [ Auto.t
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module LayoutGridChar = struct
  include LayoutGrid
end

module LayoutGridLine = struct
  include LayoutGrid
end

module LayoutGridMode = struct
  include LayoutGrid
end

module LayoutGridType = struct
  include LayoutGrid
end

(* Font smooth (non-standard) *)
module FontSmooth = struct
  type t =
    [ Auto.t
    | `never
    | `always
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `never -> {js|never|js}
    | `always -> {js|always|js}
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

(* Src (for @font-face) *)
module Src = struct
  type t =
    [ `urls of FontFace.t array
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `urls sources ->
      sources
      |> Array.to_list
      |> List.map FontFace.toString
      |> String.concat {js|, |js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Voice/Speech properties for audio rendering *)
module VoiceVolume = struct
  type t =
    [ `silent
    | `xSoft
    | `soft
    | `medium
    | `loud
    | `xLoud
    | `num of float
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `silent -> {js|silent|js}
    | `xSoft -> {js|x-soft|js}
    | `soft -> {js|soft|js}
    | `medium -> {js|medium|js}
    | `loud -> {js|loud|js}
    | `xLoud -> {js|x-loud|js}
    | `num n -> Kloth.Float.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module VoiceBalance = struct
  type t =
    [ `num of float
    | `left
    | `center
    | `right
    | `leftwards
    | `rightwards
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Float.to_string n
    | `left -> {js|left|js}
    | `center -> {js|center|js}
    | `right -> {js|right|js}
    | `leftwards -> {js|leftwards|js}
    | `rightwards -> {js|rightwards|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module VoiceDuration = struct
  type t =
    [ Auto.t
    | Time.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #Time.t as t -> Time.toString t
    | #Cascading.t as c -> Cascading.toString c
end

module VoiceRate = struct
  type t =
    [ `normal
    | `xSlow
    | `slow
    | `medium
    | `fast
    | `xFast
    | Percentage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `xSlow -> {js|x-slow|js}
    | `slow -> {js|slow|js}
    | `medium -> {js|medium|js}
    | `fast -> {js|fast|js}
    | `xFast -> {js|x-fast|js}
    | #Percentage.t as p -> Percentage.toString p
    | #Cascading.t as c -> Cascading.toString c
end

module VoiceStress = struct
  type t =
    [ `normal
    | `strong
    | `moderate
    | None.t
    | `reduced
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `strong -> {js|strong|js}
    | `moderate -> {js|moderate|js}
    | #None.t -> None.toString
    | `reduced -> {js|reduced|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module Speak = struct
  type t =
    [ Auto.t
    | None.t
    | `normal
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `normal -> {js|normal|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module SpeakAs = struct
  type t =
    [ `normal
    | `spellOut
    | `digits
    | `literalPunctuation
    | `noPunctuation
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `normal -> {js|normal|js}
    | `spellOut -> {js|spell-out|js}
    | `digits -> {js|digits|js}
    | `literalPunctuation -> {js|literal-punctuation|js}
    | `noPunctuation -> {js|no-punctuation|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module PauseBefore = struct
  type t =
    [ Time.t
    | None.t
    | `xWeak
    | `weak
    | `medium
    | `strong
    | `xStrong
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Time.t as t -> Time.toString t
    | #None.t -> None.toString
    | `xWeak -> {js|x-weak|js}
    | `weak -> {js|weak|js}
    | `medium -> {js|medium|js}
    | `strong -> {js|strong|js}
    | `xStrong -> {js|x-strong|js}
    | #Cascading.t as c -> Cascading.toString c
end

module PauseAfter = struct
  include PauseBefore
end

module RestBefore = struct
  include PauseBefore
end

module RestAfter = struct
  include PauseBefore
end

module CueBefore = struct
  type t =
    [ Url.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Url.t as u -> Url.toString u
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module CueAfter = struct
  include CueBefore
end

(* Vendor-prefixed properties - Mozilla *)
module MozAppearance = struct
  type t =
    [ None.t
    | `button
    | `checkbox
    | `radio
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `button -> {js|button|js}
    | `checkbox -> {js|checkbox|js}
    | `radio -> {js|radio|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozBackgroundClip = struct
  type t =
    [ `padding
    | `border
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `padding -> {js|padding|js}
    | `border -> {js|border|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozBinding = struct
  type t =
    [ Url.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Url.t as u -> Url.toString u
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozBorderColors = struct
  type t =
    [ `colors of Color.t array
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `colors colors ->
      colors
      |> Array.to_list
      |> List.map Color.toString
      |> String.concat {js| |js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozBorderBottomColors = struct
  include MozBorderColors
end

module MozBorderLeftColors = struct
  include MozBorderColors
end

module MozBorderRightColors = struct
  include MozBorderColors
end

module MozBorderTopColors = struct
  include MozBorderColors
end

(* Vendor-prefixed properties - WebKit *)
module WebkitAppearance = struct
  include MozAppearance
end

module WebkitBackgroundClip = struct
  include BackgroundClip
end

module WebkitMask = struct
  type t =
    [ None.t
    | Image.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | #Image.t as i -> Image.toString i
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitBoxReflect = struct
  type t =
    [ `above
    | `below
    | `right
    | `left
    | Length.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `above -> {js|above|js}
    | `below -> {js|below|js}
    | `right -> {js|right|js}
    | `left -> {js|left|js}
    | #Length.t as l -> Length.toString l
    | #Cascading.t as c -> Cascading.toString c
end

(* Font synthesis shorthand *)
module FontSynthesis = struct
  type t =
    [ None.t
    | `weight
    | `style
    | `smallCaps
    | `position
    | `weightStyle
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `weight -> {js|weight|js}
    | `style -> {js|style|js}
    | `smallCaps -> {js|small-caps|js}
    | `position -> {js|position|js}
    | `weightStyle -> {js|weight style|js}
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Text emphasis shorthand *)
module TextEmphasis = struct
  type t =
    [ TextEmphasisStyle.t
    | Color.t
    ]

  let toString x =
    match x with
    | #TextEmphasisStyle.t as tes -> TextEmphasisStyle.toString tes
    | #Color.t as c -> Color.toString c
end

(* Remaining shorthands and border/outline complete forms *)
module BorderImage = struct
  type t = BorderImageSource.t

  let toString x = BorderImageSource.toString x
end

module Outline = struct
  type t =
    [ LineWidth.t
    | OutlineStyle.t
    | Color.t
    ]

  let toString x =
    match x with
    | #LineWidth.t as lw -> LineWidth.toString lw
    | #OutlineStyle.t as os -> OutlineStyle.toString os
    | #Color.t as c -> Color.toString c
end

module BorderTop = struct
  include Outline
end

module BorderBottom = struct
  include Outline
end

module BorderLeft = struct
  include Outline
end

module BorderRight = struct
  include Outline
end

module BorderShorthand = struct
  include Outline
end

module Padding = struct
  include Margin
end

(* Remaining voice properties *)
module VoiceFamily = struct
  type t =
    [ `custom of string
    | `preserve
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `custom s -> s
    | `preserve -> {js|preserve|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module VoicePitch = struct
  type t =
    [ `xLow
    | `low
    | `medium
    | `high
    | `xHigh
    | `num of float
    | Percentage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `xLow -> {js|x-low|js}
    | `low -> {js|low|js}
    | `medium -> {js|medium|js}
    | `high -> {js|high|js}
    | `xHigh -> {js|x-high|js}
    | `num n -> Kloth.Float.to_string n
    | #Percentage.t as p -> Percentage.toString p
    | #Cascading.t as c -> Cascading.toString c
end

module VoiceRange = struct
  include VoicePitch
end

module Pause = struct
  type t = PauseBefore.t

  let toString x = PauseBefore.toString x
end

module Rest = struct
  type t = RestBefore.t

  let toString x = RestBefore.toString x
end

module Cue = struct
  type t = CueBefore.t

  let toString x = CueBefore.toString x
end

(* Font shorthand - complex *)
module Font = struct
  type t =
    [ FontStyle.t
    | FontWeight.t
    | FontSize.t
    | FontFamily.t
    | `caption
    | `icon
    | `menu
    | `messageBox
    | `smallCaption
    | `statusBar
    ]

  let toString x =
    match x with
    | #FontStyle.t as fs -> FontStyle.toString fs
    | #FontWeight.t as fw -> FontWeight.toString fw
    | #FontSize.t as fs -> FontSize.toString fs
    | #FontFamily.t as ff -> FontFamily.toString ff
    | `caption -> {js|caption|js}
    | `icon -> {js|icon|js}
    | `menu -> {js|menu|js}
    | `messageBox -> {js|message-box|js}
    | `smallCaption -> {js|small-caption|js}
    | `statusBar -> {js|status-bar|js}
end

(* Background shorthand *)
module BackgroundShorthand = struct
  type t =
    [ BackgroundImage.t
    | Background.t
    ]

  let toString x =
    match x with
    | #BackgroundImage.t as bi -> BackgroundImage.toString bi
    | #Background.t as b -> Background.toString b
end

(* Remaining moz properties *)
module MozBorderRadiusBottomleft = struct
  include BorderRadius
end

module MozBorderRadiusBottomright = struct
  include BorderRadius
end

module MozBorderRadiusTopleft = struct
  include BorderRadius
end

module MozBorderRadiusTopright = struct
  include BorderRadius
end

module MozContextProperties = struct
  type t =
    [ None.t
    | `fill
    | `fillOpacity
    | `stroke
    | `strokeOpacity
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `fill -> {js|fill|js}
    | `fillOpacity -> {js|fill-opacity|js}
    | `stroke -> {js|stroke|js}
    | `strokeOpacity -> {js|stroke-opacity|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozControlCharacterVisibility = struct
  type t =
    [ `visible
    | `hidden
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `visible -> {js|visible|js}
    | `hidden -> {js|hidden|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozFloatEdge = struct
  include GeometryBox
end

module MozForceBrokenImageIcon = struct
  type t =
    [ `num of int
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `num n -> Kloth.Int.to_string n
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozImageRegion = struct
  type t =
    [ Auto.t
    | `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozOrient = struct
  type t =
    [ `inline
    | `block
    | `horizontal
    | `vertical
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `inline -> {js|inline|js}
    | `block -> {js|block|js}
    | `horizontal -> {js|horizontal|js}
    | `vertical -> {js|vertical|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozOsxFontSmoothing = struct
  type t =
    [ Auto.t
    | `grayscale
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `grayscale -> {js|grayscale|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozOutlineRadius = struct
  include BorderRadius
end

module MozOutlineRadiusBottomleft = struct
  include BorderRadius
end

module MozOutlineRadiusBottomright = struct
  include BorderRadius
end

module MozOutlineRadiusTopleft = struct
  include BorderRadius
end

module MozOutlineRadiusTopright = struct
  include BorderRadius
end

module MozStackSizing = struct
  type t =
    [ `ignore
    | `stretchToFit
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `ignore -> {js|ignore|js}
    | `stretchToFit -> {js|stretch-to-fit|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozTextBlink = struct
  include TextBlink
end

module MozUserFocus = struct
  type t =
    [ `ignore
    | `normal
    | `selectAfter
    | `selectBefore
    | `selectMenu
    | `selectSame
    | `selectAll
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `ignore -> {js|ignore|js}
    | `normal -> {js|normal|js}
    | `selectAfter -> {js|select-after|js}
    | `selectBefore -> {js|select-before|js}
    | `selectMenu -> {js|select-menu|js}
    | `selectSame -> {js|select-same|js}
    | `selectAll -> {js|select-all|js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozUserInput = struct
  type t =
    [ Auto.t
    | None.t
    | `enabled
    | `disabled
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `enabled -> {js|enabled|js}
    | `disabled -> {js|disabled|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozUserModify = struct
  type t =
    [ `readOnly
    | `readWrite
    | `writeOnly
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `readOnly -> {js|read-only|js}
    | `readWrite -> {js|read-write|js}
    | `writeOnly -> {js|write-only|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozUserSelect = struct
  include UserSelect
end

module MozWindowDragging = struct
  type t =
    [ `drag
    | `noDrag
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `drag -> {js|drag|js}
    | `noDrag -> {js|no-drag|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MozWindowShadow = struct
  type t =
    [ `default
    | `menu
    | `tooltip
    | `sheet
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `default -> {js|default|js}
    | `menu -> {js|menu|js}
    | `tooltip -> {js|tooltip|js}
    | `sheet -> {js|sheet|js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Remaining webkit properties *)
module WebkitBorderBefore = struct
  include Outline
end

module WebkitBorderBeforeColor = struct
  include Color
end

module WebkitBorderBeforeStyle = struct
  include BorderStyle
end

module WebkitBorderBeforeWidth = struct
  include LineWidth
end

module WebkitColumnBreakAfter = struct
  type t =
    [ `always
    | Auto.t
    | `avoid
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `always -> {js|always|js}
    | #Auto.t -> Auto.toString
    | `avoid -> {js|avoid|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitColumnBreakBefore = struct
  include WebkitColumnBreakAfter
end

module WebkitColumnBreakInside = struct
  include WebkitColumnBreakAfter
end

module WebkitFontSmoothing = struct
  type t =
    [ Auto.t
    | None.t
    | `antialiased
    | `subpixelAntialiased
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | #None.t -> None.toString
    | `antialiased -> {js|antialiased|js}
    | `subpixelAntialiased -> {js|subpixel-antialiased|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitLineClamp = struct
  include LineClamp
end

module WebkitMaskAttachment = struct
  include BackgroundAttachment
end

module WebkitMaskBoxImage = struct
  type t =
    [ Url.t
    | Gradient.t
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Url.t as u -> Url.toString u
    | #Gradient.t as g -> Gradient.toString g
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskClip = struct
  include BackgroundClip
end

module WebkitMaskComposite = struct
  type t =
    [ `clear
    | `copy
    | `sourceOver
    | `sourceIn
    | `sourceOut
    | `sourceAtop
    | `destinationOver
    | `destinationIn
    | `destinationOut
    | `destinationAtop
    | `xor
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `clear -> {js|clear|js}
    | `copy -> {js|copy|js}
    | `sourceOver -> {js|source-over|js}
    | `sourceIn -> {js|source-in|js}
    | `sourceOut -> {js|source-out|js}
    | `sourceAtop -> {js|source-atop|js}
    | `destinationOver -> {js|destination-over|js}
    | `destinationIn -> {js|destination-in|js}
    | `destinationOut -> {js|destination-out|js}
    | `destinationAtop -> {js|destination-atop|js}
    | `xor -> {js|xor|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskImage = struct
  include MaskImage
end

module WebkitMaskOrigin = struct
  include BackgroundOrigin
end

module WebkitMaskPosition = struct
  include MaskPosition
end

module WebkitMaskPositionX = struct
  type t =
    [ Length.t
    | `left
    | `center
    | `right
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | `left -> {js|left|js}
    | `center -> {js|center|js}
    | `right -> {js|right|js}
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskPositionY = struct
  type t =
    [ Length.t
    | `top
    | `center
    | `bottom
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | `top -> {js|top|js}
    | `center -> {js|center|js}
    | `bottom -> {js|bottom|js}
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskRepeat = struct
  include BackgroundRepeat
end

module WebkitMaskRepeatX = struct
  type t =
    [ `repeat
    | `noRepeat
    | `space
    | `round
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `repeat -> {js|repeat|js}
    | `noRepeat -> {js|no-repeat|js}
    | `space -> {js|space|js}
    | `round -> {js|round|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskRepeatY = struct
  include WebkitMaskRepeatX
end

module WebkitMaskSize = struct
  include BackgroundSize
end

module WebkitOverflowScrolling = struct
  type t =
    [ Auto.t
    | `touch
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #Auto.t -> Auto.toString
    | `touch -> {js|touch|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitPrintColorAdjust = struct
  type t =
    [ `economy
    | `exact
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `economy -> {js|economy|js}
    | `exact -> {js|exact|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitTapHighlightColor = struct
  include Color
end

module WebkitTextFillColor = struct
  include Color
end

module WebkitTextSecurity = struct
  type t =
    [ None.t
    | `circle
    | `disc
    | `square
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `circle -> {js|circle|js}
    | `disc -> {js|disc|js}
    | `square -> {js|square|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitTextStroke = struct
  type t =
    [ Length.t
    | Color.t
    ]

  let toString x =
    match x with
    | #Length.t as l -> Length.toString l
    | #Color.t as c -> Color.toString c
end

module WebkitTextStrokeColor = struct
  include Color
end

module WebkitTextStrokeWidth = struct
  include Length
end

module WebkitTouchCallout = struct
  type t =
    [ `default
    | None.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `default -> {js|default|js}
    | #None.t -> None.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitUserDrag = struct
  type t =
    [ None.t
    | `element
    | Auto.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #None.t -> None.toString
    | `element -> {js|element|js}
    | #Auto.t -> Auto.toString
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitUserModify = struct
  type t =
    [ `readOnly
    | `readWrite
    | `readWritePlaintextOnly
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `readOnly -> {js|read-only|js}
    | `readWrite -> {js|read-write|js}
    | `readWritePlaintextOnly -> {js|read-write-plaintext-only|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitUserSelect = struct
  include UserSelect
end

(* Scrollbar color variants *)
module Scrollbar3dlightColor = struct
  include Color
end

module ScrollbarArrowColor = struct
  include Color
end

module ScrollbarBaseColor = struct
  include Color
end

module ScrollbarDarkshadowColor = struct
  include Color
end

module ScrollbarFaceColor = struct
  include Color
end

module ScrollbarHighlightColor = struct
  include Color
end

module ScrollbarShadowColor = struct
  include Color
end

module ScrollbarTrackColor = struct
  include Color
end

(* Unicode range *)
module UnicodeRange = struct
  type t =
    [ `ranges of URange.t
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `ranges r -> URange.toString r
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

(* Remaining mask properties *)
module Mask = struct
  type t =
    [ MaskImage.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | #MaskImage.t as mi -> MaskImage.toString mi
    | #Cascading.t as c -> Cascading.toString c
end

module MaskBorder = struct
  type t =
    [ `custom of string
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `custom s -> s
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaskBorderMode = struct
  type t =
    [ `luminance
    | `alpha
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `luminance -> {js|luminance|js}
    | `alpha -> {js|alpha|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaskBorderOutset = struct
  include BorderImageOutset
end

module MaskBorderRepeat = struct
  include BorderImageRepeat
end

module MaskBorderSlice = struct
  include BorderImageSlice
end

module MaskBorderSource = struct
  include BorderImageSource
end

module MaskBorderWidth = struct
  include BorderImageWidth
end

module MaskClip = struct
  type t =
    [ GeometryBox.t
    | `noClip
    ]

  let toString x =
    match x with
    | #GeometryBox.t as gb -> GeometryBox.toString gb
    | `noClip -> {js|no-clip|js}
end

module MaskComposite = struct
  type t =
    [ `add
    | `subtract
    | `intersect
    | `exclude
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `add -> {js|add|js}
    | `subtract -> {js|subtract|js}
    | `intersect -> {js|intersect|js}
    | `exclude -> {js|exclude|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaskMode = struct
  type t =
    [ `alpha
    | `luminance
    | `matchSource
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `alpha -> {js|alpha|js}
    | `luminance -> {js|luminance|js}
    | `matchSource -> {js|match-source|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end

module MaskOrigin = struct
  include GeometryBox
end

module MaskRepeat = struct
  include BackgroundRepeat
end

module MaskSize = struct
  include BackgroundSize
end

module MaskType = struct
  type t =
    [ `luminance
    | `alpha
    | Var.t
    | Cascading.t
    ]

  let toString x =
    match x with
    | `luminance -> {js|luminance|js}
    | `alpha -> {js|alpha|js}
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c
end
(* Auto-generated wrapper modules for CSS value types - 456 modules *)

module AbsoluteSize = struct
  type t =
    [ `AbsoluteSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AbsoluteSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AccentColor = struct
  type t =
    [ `AccentColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AccentColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Age = struct
  type t =
    [ `Age of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Age s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnchorName = struct
  type t =
    [ `AnchorName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnchorName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnchorScope = struct
  type t =
    [ `AnchorScope of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnchorScope s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AngularColorHint = struct
  type t =
    [ `AngularColorHint of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AngularColorHint s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AngularColorStop = struct
  type t =
    [ `AngularColorStop of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AngularColorStop s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AngularColorStopList = struct
  type t =
    [ `AngularColorStopList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AngularColorStopList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimateableFeature = struct
  type t =
    [ `AnimateableFeature of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimateableFeature s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationComposition = struct
  type t =
    [ `AnimationComposition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationComposition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationDelayEnd = struct
  type t =
    [ `AnimationDelayEnd of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationDelayEnd s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationDelayStart = struct
  type t =
    [ `AnimationDelayStart of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationDelayStart s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationRange = struct
  type t =
    [ `AnimationRange of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationRange s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationRangeEnd = struct
  type t =
    [ `AnimationRangeEnd of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationRangeEnd s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationRangeStart = struct
  type t =
    [ `AnimationRangeStart of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationRangeStart s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AnimationTimeline = struct
  type t =
    [ `AnimationTimeline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AnimationTimeline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Attachment = struct
  type t =
    [ `Attachment of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Attachment s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrFallback = struct
  type t =
    [ `AttrFallback of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrFallback s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrMatcher = struct
  type t =
    [ `AttrMatcher of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrMatcher s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrModifier = struct
  type t =
    [ `AttrModifier of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrModifier s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrName = struct
  type t =
    [ `AttrName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrType = struct
  type t =
    [ `AttrType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttrUnit = struct
  type t =
    [ `AttrUnit of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttrUnit s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AttributeSelector = struct
  type t =
    [ `AttributeSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AttributeSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AutoRepeat = struct
  type t =
    [ `AutoRepeat of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AutoRepeat s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module AutoTrackList = struct
  type t =
    [ `AutoTrackList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `AutoTrackList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BackdropBlur = struct
  type t =
    [ `BackdropBlur of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BackdropBlur s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundPositionX = struct
  type t =
    [ `BackgroundPositionX of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BackgroundPositionX s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BackgroundPositionY = struct
  type t =
    [ `BackgroundPositionY of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BackgroundPositionY s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BaselinePosition = struct
  type t =
    [ `BaselinePosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BaselinePosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BasicShape = struct
  type t =
    [ `BasicShape of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BasicShape s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BgImage = struct
  type t =
    [ `BgImage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BgImage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BgLayer = struct
  type t =
    [ `BgLayer of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BgLayer s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BgPosition = struct
  type t =
    [ `BgPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BgPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BgSize = struct
  type t =
    [ `BgSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BgSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Bleed = struct
  type t =
    [ `Bleed of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Bleed s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BlendMode = struct
  type t =
    [ `BlendMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BlendMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlock = struct
  type t =
    [ `BorderBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockColor = struct
  type t =
    [ `BorderBlockColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockEnd = struct
  type t =
    [ `BorderBlockEnd of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockEnd s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockEndColor = struct
  type t =
    [ `BorderBlockEndColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockEndColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockEndStyle = struct
  type t =
    [ `BorderBlockEndStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockEndStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockEndWidth = struct
  type t =
    [ `BorderBlockEndWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockEndWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockStart = struct
  type t =
    [ `BorderBlockStart of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockStart s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockStartColor = struct
  type t =
    [ `BorderBlockStartColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockStartColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockStartStyle = struct
  type t =
    [ `BorderBlockStartStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockStartStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockStartWidth = struct
  type t =
    [ `BorderBlockStartWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockStartWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockStyle = struct
  type t =
    [ `BorderBlockStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderBlockWidth = struct
  type t =
    [ `BorderBlockWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderBlockWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInline = struct
  type t =
    [ `BorderInline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineColor = struct
  type t =
    [ `BorderInlineColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineEnd = struct
  type t =
    [ `BorderInlineEnd of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineEnd s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineEndColor = struct
  type t =
    [ `BorderInlineEndColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineEndColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineEndStyle = struct
  type t =
    [ `BorderInlineEndStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineEndStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineEndWidth = struct
  type t =
    [ `BorderInlineEndWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineEndWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineStart = struct
  type t =
    [ `BorderInlineStart of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineStart s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineStartColor = struct
  type t =
    [ `BorderInlineStartColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineStartColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineStartStyle = struct
  type t =
    [ `BorderInlineStartStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineStartStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineStartWidth = struct
  type t =
    [ `BorderInlineStartWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineStartWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineStyle = struct
  type t =
    [ `BorderInlineStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module BorderInlineWidth = struct
  type t =
    [ `BorderInlineWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `BorderInlineWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Box = struct
  type t =
    [ `Box of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Box s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CalcProduct = struct
  type t =
    [ `CalcProduct of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CalcProduct s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CalcSum = struct
  type t =
    [ `CalcSum of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CalcSum s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CalcValue = struct
  type t =
    [ `CalcValue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CalcValue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CfFinalImage = struct
  type t =
    [ `CfFinalImage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CfFinalImage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CfMixingImage = struct
  type t =
    [ `CfMixingImage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CfMixingImage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ClassSelector = struct
  type t =
    [ `ClassSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ClassSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ClipSource = struct
  type t =
    [ `ClipSource of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ClipSource s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorInterpolationMethod = struct
  type t =
    [ `ColorInterpolationMethod of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorInterpolationMethod s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorRendering = struct
  type t =
    [ `ColorRendering of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorRendering s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorStop = struct
  type t =
    [ `ColorStop of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorStop s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorStopAngle = struct
  type t =
    [ `ColorStopAngle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorStopAngle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorStopLength = struct
  type t =
    [ `ColorStopLength of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorStopLength s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ColorStopList = struct
  type t =
    [ `ColorStopList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ColorStopList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Combinator = struct
  type t =
    [ `Combinator of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Combinator s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CommonLigValues = struct
  type t =
    [ `CommonLigValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CommonLigValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CompatAuto = struct
  type t =
    [ `CompatAuto of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CompatAuto s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ComplexSelector = struct
  type t =
    [ `ComplexSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ComplexSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ComplexSelectorList = struct
  type t =
    [ `ComplexSelectorList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ComplexSelectorList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CompositeStyle = struct
  type t =
    [ `CompositeStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CompositeStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CompositingOperator = struct
  type t =
    [ `CompositingOperator of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CompositingOperator s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CompoundSelector = struct
  type t =
    [ `CompoundSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CompoundSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CompoundSelectorList = struct
  type t =
    [ `CompoundSelectorList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CompoundSelectorList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainIntrinsicBlockSize = struct
  type t =
    [ `ContainIntrinsicBlockSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainIntrinsicBlockSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainIntrinsicHeight = struct
  type t =
    [ `ContainIntrinsicHeight of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainIntrinsicHeight s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainIntrinsicInlineSize = struct
  type t =
    [ `ContainIntrinsicInlineSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainIntrinsicInlineSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainIntrinsicSize = struct
  type t =
    [ `ContainIntrinsicSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainIntrinsicSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainIntrinsicWidth = struct
  type t =
    [ `ContainIntrinsicWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainIntrinsicWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainerCondition = struct
  type t =
    [ `ContainerCondition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainerCondition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainerConditionList = struct
  type t =
    [ `ContainerConditionList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainerConditionList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainerNameComputed = struct
  type t =
    [ `ContainerNameComputed of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainerNameComputed s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContainerQuery = struct
  type t =
    [ `ContainerQuery of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContainerQuery s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContentDistribution = struct
  type t =
    [ `ContentDistribution of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContentDistribution s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContentList = struct
  type t =
    [ `ContentList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContentList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContentPosition = struct
  type t =
    [ `ContentPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContentPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContentReplacement = struct
  type t =
    [ `ContentReplacement of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContentReplacement s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ContextualAltValues = struct
  type t =
    [ `ContextualAltValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ContextualAltValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CounterName = struct
  type t =
    [ `CounterName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CounterName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CounterStyle = struct
  type t =
    [ `CounterStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CounterStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CounterStyleName = struct
  type t =
    [ `CounterStyleName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CounterStyleName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module CubicBezierTimingFunction = struct
  type t =
    [ `CubicBezierTimingFunction of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `CubicBezierTimingFunction s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Declaration = struct
  type t =
    [ `Declaration of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Declaration s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DeclarationList = struct
  type t =
    [ `DeclarationList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DeclarationList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DeprecatedSystemColor = struct
  type t =
    [ `DeprecatedSystemColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DeprecatedSystemColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Dimension = struct
  type t =
    [ `Dimension of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Dimension s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DiscretionaryLigValues = struct
  type t =
    [ `DiscretionaryLigValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DiscretionaryLigValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayBox = struct
  type t =
    [ `DisplayBox of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayBox s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayInside = struct
  type t =
    [ `DisplayInside of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayInside s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayInternal = struct
  type t =
    [ `DisplayInternal of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayInternal s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayLegacy = struct
  type t =
    [ `DisplayLegacy of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayLegacy s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayListitem = struct
  type t =
    [ `DisplayListitem of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayListitem s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module DisplayOutside = struct
  type t =
    [ `DisplayOutside of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `DisplayOutside s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module EastAsianVariantValues = struct
  type t =
    [ `EastAsianVariantValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `EastAsianVariantValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module EastAsianWidthValues = struct
  type t =
    [ `EastAsianWidthValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `EastAsianWidthValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module EndingShape = struct
  type t =
    [ `EndingShape of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `EndingShape s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExplicitTrackList = struct
  type t =
    [ `ExplicitTrackList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExplicitTrackList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedAngle = struct
  type t =
    [ `ExtendedAngle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedAngle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedFrequency = struct
  type t =
    [ `ExtendedFrequency of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedFrequency s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedLength = struct
  type t =
    [ `ExtendedLength of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedLength s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedPercentage = struct
  type t =
    [ `ExtendedPercentage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedPercentage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedTime = struct
  type t =
    [ `ExtendedTime of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedTime s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ExtendedTimeNoInterp = struct
  type t =
    [ `ExtendedTimeNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ExtendedTimeNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FamilyName = struct
  type t =
    [ `FamilyName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FamilyName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureTagValue = struct
  type t =
    [ `FeatureTagValue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureTagValue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureType = struct
  type t =
    [ `FeatureType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureValueBlock = struct
  type t =
    [ `FeatureValueBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureValueBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureValueBlockList = struct
  type t =
    [ `FeatureValueBlockList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureValueBlockList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureValueDeclaration = struct
  type t =
    [ `FeatureValueDeclaration of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureValueDeclaration s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureValueDeclarationList = struct
  type t =
    [ `FeatureValueDeclarationList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureValueDeclarationList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FeatureValueName = struct
  type t =
    [ `FeatureValueName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FeatureValueName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FieldSizing = struct
  type t =
    [ `FieldSizing of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FieldSizing s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Fill = struct
  type t =
    [ `Fill of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Fill s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FilterFunction = struct
  type t =
    [ `FilterFunction of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FilterFunction s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FilterFunctionList = struct
  type t =
    [ `FilterFunctionList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FilterFunctionList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FinalBgLayer = struct
  type t =
    [ `FinalBgLayer of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FinalBgLayer s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FixedBreadth = struct
  type t =
    [ `FixedBreadth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FixedBreadth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FixedRepeat = struct
  type t =
    [ `FixedRepeat of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FixedRepeat s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FlexFlow = struct
  type t =
    [ `FlexFlow of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FlexFlow s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FontFamilies = struct
  type t =
    [ `FontFamilies of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FontFamilies s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FontStretchAbsolute = struct
  type t =
    [ `FontStretchAbsolute of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FontStretchAbsolute s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FontVariantCss21 = struct
  type t =
    [ `FontVariantCss21 of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FontVariantCss21 s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FontWeightAbsolute = struct
  type t =
    [ `FontWeightAbsolute of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FontWeightAbsolute s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionAttr = struct
  type t =
    [ `FunctionAttr of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionAttr s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionBlur = struct
  type t =
    [ `FunctionBlur of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionBlur s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionBrightness = struct
  type t =
    [ `FunctionBrightness of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionBrightness s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionCalc = struct
  type t =
    [ `FunctionCalc of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionCalc s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionCircle = struct
  type t =
    [ `FunctionCircle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionCircle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionClamp = struct
  type t =
    [ `FunctionClamp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionClamp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionConicGradient = struct
  type t =
    [ `FunctionConicGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionConicGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionContrast = struct
  type t =
    [ `FunctionContrast of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionContrast s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionCounter = struct
  type t =
    [ `FunctionCounter of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionCounter s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionCounters = struct
  type t =
    [ `FunctionCounters of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionCounters s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionCrossFade = struct
  type t =
    [ `FunctionCrossFade of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionCrossFade s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionDropShadow = struct
  type t =
    [ `FunctionDropShadow of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionDropShadow s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionElement = struct
  type t =
    [ `FunctionElement of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionElement s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionEllipse = struct
  type t =
    [ `FunctionEllipse of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionEllipse s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionEnv = struct
  type t =
    [ `FunctionEnv of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionEnv s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionFitContent = struct
  type t =
    [ `FunctionFitContent of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionFitContent s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionGrayscale = struct
  type t =
    [ `FunctionGrayscale of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionGrayscale s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionHsl = struct
  type t =
    [ `FunctionHsl of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionHsl s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionHsla = struct
  type t =
    [ `FunctionHsla of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionHsla s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionHueRotate = struct
  type t =
    [ `FunctionHueRotate of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionHueRotate s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionImage = struct
  type t =
    [ `FunctionImage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionImage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionImageSet = struct
  type t =
    [ `FunctionImageSet of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionImageSet s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionInset = struct
  type t =
    [ `FunctionInset of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionInset s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionInvert = struct
  type t =
    [ `FunctionInvert of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionInvert s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionLeader = struct
  type t =
    [ `FunctionLeader of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionLeader s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionLinearGradient = struct
  type t =
    [ `FunctionLinearGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionLinearGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionMatrix = struct
  type t =
    [ `FunctionMatrix of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionMatrix s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionMatrix3d = struct
  type t =
    [ `FunctionMatrix3d of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionMatrix3d s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionMax = struct
  type t =
    [ `FunctionMax of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionMax s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionMin = struct
  type t =
    [ `FunctionMin of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionMin s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionMinmax = struct
  type t =
    [ `FunctionMinmax of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionMinmax s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionOpacity = struct
  type t =
    [ `FunctionOpacity of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionOpacity s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionPaint = struct
  type t =
    [ `FunctionPaint of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionPaint s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionPath = struct
  type t =
    [ `FunctionPath of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionPath s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionPerspective = struct
  type t =
    [ `FunctionPerspective of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionPerspective s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionPolygon = struct
  type t =
    [ `FunctionPolygon of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionPolygon s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRadialGradient = struct
  type t =
    [ `FunctionRadialGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRadialGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRepeatingLinearGradient = struct
  type t =
    [ `FunctionRepeatingLinearGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRepeatingLinearGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRepeatingRadialGradient = struct
  type t =
    [ `FunctionRepeatingRadialGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRepeatingRadialGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRgb = struct
  type t =
    [ `FunctionRgb of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRgb s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRgba = struct
  type t =
    [ `FunctionRgba of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRgba s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRotate = struct
  type t =
    [ `FunctionRotate of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRotate s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRotate3d = struct
  type t =
    [ `FunctionRotate3d of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRotate3d s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRotatex = struct
  type t =
    [ `FunctionRotatex of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRotatex s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRotatey = struct
  type t =
    [ `FunctionRotatey of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRotatey s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionRotatez = struct
  type t =
    [ `FunctionRotatez of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionRotatez s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSaturate = struct
  type t =
    [ `FunctionSaturate of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSaturate s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionScale = struct
  type t =
    [ `FunctionScale of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionScale s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionScale3d = struct
  type t =
    [ `FunctionScale3d of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionScale3d s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionScalex = struct
  type t =
    [ `FunctionScalex of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionScalex s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionScaley = struct
  type t =
    [ `FunctionScaley of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionScaley s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionScalez = struct
  type t =
    [ `FunctionScalez of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionScalez s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSepia = struct
  type t =
    [ `FunctionSepia of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSepia s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSkew = struct
  type t =
    [ `FunctionSkew of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSkew s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSkewx = struct
  type t =
    [ `FunctionSkewx of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSkewx s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSkewy = struct
  type t =
    [ `FunctionSkewy of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSkewy s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionSymbols = struct
  type t =
    [ `FunctionSymbols of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionSymbols s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTargetCounter = struct
  type t =
    [ `FunctionTargetCounter of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTargetCounter s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTargetCounters = struct
  type t =
    [ `FunctionTargetCounters of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTargetCounters s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTargetText = struct
  type t =
    [ `FunctionTargetText of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTargetText s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTranslate = struct
  type t =
    [ `FunctionTranslate of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTranslate s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTranslate3d = struct
  type t =
    [ `FunctionTranslate3d of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTranslate3d s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTranslatex = struct
  type t =
    [ `FunctionTranslatex of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTranslatex s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTranslatey = struct
  type t =
    [ `FunctionTranslatey of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTranslatey s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionTranslatez = struct
  type t =
    [ `FunctionTranslatez of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionTranslatez s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionVar = struct
  type t =
    [ `FunctionVar of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionVar s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module FunctionWebkitGradient = struct
  type t =
    [ `FunctionWebkitGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `FunctionWebkitGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Gender = struct
  type t =
    [ `Gender of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Gender s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module GeneralEnclosed = struct
  type t =
    [ `GeneralEnclosed of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `GeneralEnclosed s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module GenericFamily = struct
  type t =
    [ `GenericFamily of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `GenericFamily s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module GenericName = struct
  type t =
    [ `GenericName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `GenericName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module GenericVoice = struct
  type t =
    [ `GenericVoice of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `GenericVoice s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module HistoricalLigValues = struct
  type t =
    [ `HistoricalLigValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `HistoricalLigValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Hue = struct
  type t =
    [ `Hue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Hue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module HueInterpolationMethod = struct
  type t =
    [ `HueInterpolationMethod of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `HueInterpolationMethod s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module HyphenateLimitLast = struct
  type t =
    [ `HyphenateLimitLast of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `HyphenateLimitLast s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module IdSelector = struct
  type t =
    [ `IdSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `IdSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ImageSetOption = struct
  type t =
    [ `ImageSetOption of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ImageSetOption s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ImageSrc = struct
  type t =
    [ `ImageSrc of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ImageSrc s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ImageTags = struct
  type t =
    [ `ImageTags of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ImageTags s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Inherits = struct
  type t =
    [ `Inherits of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Inherits s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module InitialValue = struct
  type t =
    [ `InitialValue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `InitialValue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module InsetArea = struct
  type t =
    [ `InsetArea of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `InsetArea s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module InterpolateSize = struct
  type t =
    [ `InterpolateSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `InterpolateSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module KeyframeBlock = struct
  type t =
    [ `KeyframeBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `KeyframeBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module KeyframeBlockList = struct
  type t =
    [ `KeyframeBlockList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `KeyframeBlockList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module KeyframeSelector = struct
  type t =
    [ `KeyframeSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `KeyframeSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module KeyframesName = struct
  type t =
    [ `KeyframesName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `KeyframesName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LeaderType = struct
  type t =
    [ `LeaderType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LeaderType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyGradient = struct
  type t =
    [ `LegacyGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyLinearGradient = struct
  type t =
    [ `LegacyLinearGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyLinearGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyLinearGradientArguments = struct
  type t =
    [ `LegacyLinearGradientArguments of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyLinearGradientArguments s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRadialGradient = struct
  type t =
    [ `LegacyRadialGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRadialGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRadialGradientArguments = struct
  type t =
    [ `LegacyRadialGradientArguments of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRadialGradientArguments s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRadialGradientShape = struct
  type t =
    [ `LegacyRadialGradientShape of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRadialGradientShape s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRadialGradientSize = struct
  type t =
    [ `LegacyRadialGradientSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRadialGradientSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRepeatingLinearGradient = struct
  type t =
    [ `LegacyRepeatingLinearGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRepeatingLinearGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LegacyRepeatingRadialGradient = struct
  type t =
    [ `LegacyRepeatingRadialGradient of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LegacyRepeatingRadialGradient s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LengthPercentage = struct
  type t =
    [ `LengthPercentage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LengthPercentage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LineNameList = struct
  type t =
    [ `LineNameList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LineNameList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LineNames = struct
  type t =
    [ `LineNames of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LineNames s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LineStyle = struct
  type t =
    [ `LineStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LineStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LinearColorHint = struct
  type t =
    [ `LinearColorHint of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LinearColorHint s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module LinearColorStop = struct
  type t =
    [ `LinearColorStop of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `LinearColorStop s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ListStyle = struct
  type t =
    [ `ListStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ListStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Marks = struct
  type t =
    [ `Marks of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Marks s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MaskLayer = struct
  type t =
    [ `MaskLayer of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MaskLayer s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MaskReference = struct
  type t =
    [ `MaskReference of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MaskReference s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MaskSource = struct
  type t =
    [ `MaskSource of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MaskSource s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MaskingMode = struct
  type t =
    [ `MaskingMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MaskingMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MathDepth = struct
  type t =
    [ `MathDepth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MathDepth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MathShift = struct
  type t =
    [ `MathShift of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MathShift s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MathStyle = struct
  type t =
    [ `MathStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MathStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaAnd = struct
  type t =
    [ `MediaAnd of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaAnd s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaAnyHover = struct
  type t =
    [ `MediaAnyHover of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaAnyHover s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaAnyPointer = struct
  type t =
    [ `MediaAnyPointer of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaAnyPointer s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaColorGamut = struct
  type t =
    [ `MediaColorGamut of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaColorGamut s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaColorIndex = struct
  type t =
    [ `MediaColorIndex of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaColorIndex s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaCondition = struct
  type t =
    [ `MediaCondition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaCondition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaConditionWithoutOr = struct
  type t =
    [ `MediaConditionWithoutOr of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaConditionWithoutOr s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaDisplayMode = struct
  type t =
    [ `MediaDisplayMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaDisplayMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaFeature = struct
  type t =
    [ `MediaFeature of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaFeature s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaForcedColors = struct
  type t =
    [ `MediaForcedColors of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaForcedColors s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaGrid = struct
  type t =
    [ `MediaGrid of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaGrid s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaHover = struct
  type t =
    [ `MediaHover of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaHover s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaInParens = struct
  type t =
    [ `MediaInParens of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaInParens s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaInvertedColors = struct
  type t =
    [ `MediaInvertedColors of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaInvertedColors s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMaxAspectRatio = struct
  type t =
    [ `MediaMaxAspectRatio of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMaxAspectRatio s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMaxResolution = struct
  type t =
    [ `MediaMaxResolution of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMaxResolution s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMinAspectRatio = struct
  type t =
    [ `MediaMinAspectRatio of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMinAspectRatio s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMinColor = struct
  type t =
    [ `MediaMinColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMinColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMinColorIndex = struct
  type t =
    [ `MediaMinColorIndex of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMinColorIndex s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMinResolution = struct
  type t =
    [ `MediaMinResolution of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMinResolution s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaMonochrome = struct
  type t =
    [ `MediaMonochrome of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaMonochrome s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaNot = struct
  type t =
    [ `MediaNot of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaNot s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaOr = struct
  type t =
    [ `MediaOr of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaOr s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaOrientation = struct
  type t =
    [ `MediaOrientation of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaOrientation s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaPointer = struct
  type t =
    [ `MediaPointer of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaPointer s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaPrefersColorScheme = struct
  type t =
    [ `MediaPrefersColorScheme of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaPrefersColorScheme s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaPrefersContrast = struct
  type t =
    [ `MediaPrefersContrast of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaPrefersContrast s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaPrefersReducedMotion = struct
  type t =
    [ `MediaPrefersReducedMotion of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaPrefersReducedMotion s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaQuery = struct
  type t =
    [ `MediaQuery of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaQuery s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaQueryList = struct
  type t =
    [ `MediaQueryList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaQueryList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaResolution = struct
  type t =
    [ `MediaResolution of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaResolution s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaScripting = struct
  type t =
    [ `MediaScripting of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaScripting s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaType = struct
  type t =
    [ `MediaType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MediaUpdate = struct
  type t =
    [ `MediaUpdate of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MediaUpdate s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfBoolean = struct
  type t =
    [ `MfBoolean of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfBoolean s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfComparison = struct
  type t =
    [ `MfComparison of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfComparison s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfEq = struct
  type t =
    [ `MfEq of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfEq s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfGt = struct
  type t =
    [ `MfGt of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfGt s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfLt = struct
  type t =
    [ `MfLt of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfLt s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfName = struct
  type t =
    [ `MfName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfPlain = struct
  type t =
    [ `MfPlain of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfPlain s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfRange = struct
  type t =
    [ `MfRange of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfRange s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module MfValue = struct
  type t =
    [ `MfValue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `MfValue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NameRepeat = struct
  type t =
    [ `NameRepeat of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NameRepeat s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NamedColor = struct
  type t =
    [ `NamedColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NamedColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NamespacePrefix = struct
  type t =
    [ `NamespacePrefix of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NamespacePrefix s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NonStandardColor = struct
  type t =
    [ `NonStandardColor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NonStandardColor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NonStandardFont = struct
  type t =
    [ `NonStandardFont of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NonStandardFont s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NonStandardImageRendering = struct
  type t =
    [ `NonStandardImageRendering of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NonStandardImageRendering s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NonStandardOverflow = struct
  type t =
    [ `NonStandardOverflow of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NonStandardOverflow s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NonStandardWidth = struct
  type t =
    [ `NonStandardWidth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NonStandardWidth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NsPrefix = struct
  type t =
    [ `NsPrefix of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NsPrefix s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Nth = struct
  type t =
    [ `Nth of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Nth s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumberOneOrGreater = struct
  type t =
    [ `NumberOneOrGreater of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumberOneOrGreater s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumberPercentage = struct
  type t =
    [ `NumberPercentage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumberPercentage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumberZeroOne = struct
  type t =
    [ `NumberZeroOne of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumberZeroOne s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumericFigureValues = struct
  type t =
    [ `NumericFigureValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumericFigureValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumericFractionValues = struct
  type t =
    [ `NumericFractionValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumericFractionValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module NumericSpacingValues = struct
  type t =
    [ `NumericSpacingValues of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `NumericSpacingValues s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OneBgSize = struct
  type t =
    [ `OneBgSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OneBgSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OutlineRadius = struct
  type t =
    [ `OutlineRadius of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OutlineRadius s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OverflowPosition = struct
  type t =
    [ `OverflowPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OverflowPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Overlay = struct
  type t =
    [ `Overlay of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Overlay s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OverscrollBehaviorBlock = struct
  type t =
    [ `OverscrollBehaviorBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OverscrollBehaviorBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OverscrollBehaviorInline = struct
  type t =
    [ `OverscrollBehaviorInline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OverscrollBehaviorInline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OverscrollBehaviorX = struct
  type t =
    [ `OverscrollBehaviorX of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OverscrollBehaviorX s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module OverscrollBehaviorY = struct
  type t =
    [ `OverscrollBehaviorY of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `OverscrollBehaviorY s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Page = struct
  type t =
    [ `Page of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Page s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PageBody = struct
  type t =
    [ `PageBody of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PageBody s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PageMarginBox = struct
  type t =
    [ `PageMarginBox of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PageMarginBox s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PageMarginBoxType = struct
  type t =
    [ `PageMarginBoxType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PageMarginBoxType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PageSelector = struct
  type t =
    [ `PageSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PageSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PageSelectorList = struct
  type t =
    [ `PageSelectorList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PageSelectorList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Paint = struct
  type t =
    [ `Paint of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Paint s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PolarColorSpace = struct
  type t =
    [ `PolarColorSpace of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PolarColorSpace s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionAnchor = struct
  type t =
    [ `PositionAnchor of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionAnchor s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionArea = struct
  type t =
    [ `PositionArea of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionArea s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionTry = struct
  type t =
    [ `PositionTry of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionTry s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionTryFallbacks = struct
  type t =
    [ `PositionTryFallbacks of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionTryFallbacks s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionTryOptions = struct
  type t =
    [ `PositionTryOptions of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionTryOptions s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositionVisibility = struct
  type t =
    [ `PositionVisibility of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositionVisibility s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PositiveInteger = struct
  type t =
    [ `PositiveInteger of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PositiveInteger s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PrintColorAdjust = struct
  type t =
    [ `PrintColorAdjust of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PrintColorAdjust s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PseudoClassSelector = struct
  type t =
    [ `PseudoClassSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PseudoClassSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PseudoElementSelector = struct
  type t =
    [ `PseudoElementSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PseudoElementSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module PseudoPage = struct
  type t =
    [ `PseudoPage of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `PseudoPage s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module QueryInParens = struct
  type t =
    [ `QueryInParens of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `QueryInParens s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Quote = struct
  type t =
    [ `Quote of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Quote s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RadialSize = struct
  type t =
    [ `RadialSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RadialSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Ratio = struct
  type t =
    [ `Ratio of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Ratio s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RaySize = struct
  type t =
    [ `RaySize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RaySize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ReadingFlow = struct
  type t =
    [ `ReadingFlow of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ReadingFlow s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RectangularColorSpace = struct
  type t =
    [ `RectangularColorSpace of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RectangularColorSpace s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RelativeSelector = struct
  type t =
    [ `RelativeSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RelativeSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RelativeSelectorList = struct
  type t =
    [ `RelativeSelectorList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RelativeSelectorList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RelativeSize = struct
  type t =
    [ `RelativeSize of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RelativeSize s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RepeatStyle = struct
  type t =
    [ `RepeatStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RepeatStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module RubyOverhang = struct
  type t =
    [ `RubyOverhang of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `RubyOverhang s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SVGPath = struct
  type t =
    [ `SVGPath of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SVGPath s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollMarkerGroup = struct
  type t =
    [ `ScrollMarkerGroup of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollMarkerGroup s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStart = struct
  type t =
    [ `ScrollStart of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStart s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartBlock = struct
  type t =
    [ `ScrollStartBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartInline = struct
  type t =
    [ `ScrollStartInline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartInline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartTarget = struct
  type t =
    [ `ScrollStartTarget of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartTarget s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartTargetBlock = struct
  type t =
    [ `ScrollStartTargetBlock of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartTargetBlock s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartTargetInline = struct
  type t =
    [ `ScrollStartTargetInline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartTargetInline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartTargetX = struct
  type t =
    [ `ScrollStartTargetX of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartTargetX s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartTargetY = struct
  type t =
    [ `ScrollStartTargetY of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartTargetY s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartX = struct
  type t =
    [ `ScrollStartX of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartX s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollStartY = struct
  type t =
    [ `ScrollStartY of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollStartY s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollTimeline = struct
  type t =
    [ `ScrollTimeline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollTimeline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollTimelineAxis = struct
  type t =
    [ `ScrollTimelineAxis of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollTimelineAxis s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollTimelineName = struct
  type t =
    [ `ScrollTimelineName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollTimelineName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ScrollbarColorLegacy = struct
  type t =
    [ `ScrollbarColorLegacy of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ScrollbarColorLegacy s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SelfPosition = struct
  type t =
    [ `SelfPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SelfPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Shape = struct
  type t =
    [ `Shape of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Shape s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ShapeBox = struct
  type t =
    [ `ShapeBox of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ShapeBox s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ShapeRadius = struct
  type t =
    [ `ShapeRadius of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ShapeRadius s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimation = struct
  type t =
    [ `SingleAnimation of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimation s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationDirection = struct
  type t =
    [ `SingleAnimationDirection of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationDirection s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationDirectionNoInterp = struct
  type t =
    [ `SingleAnimationDirectionNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationDirectionNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationFillMode = struct
  type t =
    [ `SingleAnimationFillMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationFillMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationFillModeNoInterp = struct
  type t =
    [ `SingleAnimationFillModeNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationFillModeNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationIterationCount = struct
  type t =
    [ `SingleAnimationIterationCount of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationIterationCount s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationIterationCountNoInterp = struct
  type t =
    [ `SingleAnimationIterationCountNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationIterationCountNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationNoInterp = struct
  type t =
    [ `SingleAnimationNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationPlayState = struct
  type t =
    [ `SingleAnimationPlayState of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationPlayState s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleAnimationPlayStateNoInterp = struct
  type t =
    [ `SingleAnimationPlayStateNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleAnimationPlayStateNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleTransition = struct
  type t =
    [ `SingleTransition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleTransition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleTransitionNoInterp = struct
  type t =
    [ `SingleTransitionNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleTransitionNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleTransitionProperty = struct
  type t =
    [ `SingleTransitionProperty of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleTransitionProperty s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SingleTransitionPropertyNoInterp = struct
  type t =
    [ `SingleTransitionPropertyNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SingleTransitionPropertyNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Size = struct
  type t =
    [ `Size of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Size s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SizeFeature = struct
  type t =
    [ `SizeFeature of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SizeFeature s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StepPosition = struct
  type t =
    [ `StepPosition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StepPosition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StepTimingFunction = struct
  type t =
    [ `StepTimingFunction of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StepTimingFunction s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Stroke = struct
  type t =
    [ `Stroke of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Stroke s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StrokeOpacity = struct
  type t =
    [ `StrokeOpacity of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StrokeOpacity s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StyleFeature = struct
  type t =
    [ `StyleFeature of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StyleFeature s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StyleInParens = struct
  type t =
    [ `StyleInParens of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StyleInParens s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module StyleQuery = struct
  type t =
    [ `StyleQuery of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `StyleQuery s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SubclassSelector = struct
  type t =
    [ `SubclassSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SubclassSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SupportsCondition = struct
  type t =
    [ `SupportsCondition of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SupportsCondition s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SupportsDecl = struct
  type t =
    [ `SupportsDecl of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SupportsDecl s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SupportsFeature = struct
  type t =
    [ `SupportsFeature of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SupportsFeature s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SupportsInParens = struct
  type t =
    [ `SupportsInParens of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SupportsInParens s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SupportsSelectorFn = struct
  type t =
    [ `SupportsSelectorFn of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SupportsSelectorFn s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SvgLength = struct
  type t =
    [ `SvgLength of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SvgLength s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SvgWritingMode = struct
  type t =
    [ `SvgWritingMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SvgWritingMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Symbol = struct
  type t =
    [ `Symbol of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Symbol s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Syntax = struct
  type t =
    [ `Syntax of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Syntax s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxCombinator = struct
  type t =
    [ `SyntaxCombinator of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxCombinator s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxComponent = struct
  type t =
    [ `SyntaxComponent of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxComponent s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxMultiplier = struct
  type t =
    [ `SyntaxMultiplier of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxMultiplier s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxSingleComponent = struct
  type t =
    [ `SyntaxSingleComponent of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxSingleComponent s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxString = struct
  type t =
    [ `SyntaxString of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxString s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module SyntaxTypeName = struct
  type t =
    [ `SyntaxTypeName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `SyntaxTypeName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Target = struct
  type t =
    [ `Target of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Target s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextBoxEdge = struct
  type t =
    [ `TextBoxEdge of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextBoxEdge s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextBoxTrim = struct
  type t =
    [ `TextBoxTrim of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextBoxTrim s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextEdge = struct
  type t =
    [ `TextEdge of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextEdge s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextSpacingTrim = struct
  type t =
    [ `TextSpacingTrim of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextSpacingTrim s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextWrap = struct
  type t =
    [ `TextWrap of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextWrap s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextWrapMode = struct
  type t =
    [ `TextWrapMode of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextWrapMode s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TextWrapStyle = struct
  type t =
    [ `TextWrapStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TextWrapStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TimelineScope = struct
  type t =
    [ `TimelineScope of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TimelineScope s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TimingFunction = struct
  type t =
    [ `TimingFunction of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TimingFunction s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TimingFunctionNoInterp = struct
  type t =
    [ `TimingFunctionNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TimingFunctionNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TrackGroup = struct
  type t =
    [ `TrackGroup of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TrackGroup s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TrackList = struct
  type t =
    [ `TrackList of string
    | `tracks of Track.t array
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TrackList s -> s
    | `tracks x -> Kloth.Array.map_and_join ~f:Track.toString ~sep:{js| |js} x
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TrackListV0 = struct
  type t =
    [ `TrackListV0 of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TrackListV0 s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TrackMinmax = struct
  type t =
    [ `TrackMinmax of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TrackMinmax s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TrackRepeat = struct
  type t =
    [ `TrackRepeat of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TrackRepeat s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TransformFunction = struct
  type t =
    [ `TransformFunction of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TransformFunction s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TransformList = struct
  type t =
    [ `TransformList of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TransformList s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TransitionBehaviorValue = struct
  type t =
    [ `TransitionBehaviorValue of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TransitionBehaviorValue s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TransitionBehaviorValueNoInterp = struct
  type t =
    [ `TransitionBehaviorValueNoInterp of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TransitionBehaviorValueNoInterp s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TryTactic = struct
  type t =
    [ `TryTactic of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TryTactic s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TypeOrUnit = struct
  type t =
    [ `TypeOrUnit of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TypeOrUnit s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module TypeSelector = struct
  type t =
    [ `TypeSelector of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `TypeSelector s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module VectorEffect = struct
  type t =
    [ `VectorEffect of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `VectorEffect s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewTimeline = struct
  type t =
    [ `ViewTimeline of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewTimeline s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewTimelineAxis = struct
  type t =
    [ `ViewTimelineAxis of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewTimelineAxis s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewTimelineInset = struct
  type t =
    [ `ViewTimelineInset of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewTimelineInset s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewTimelineName = struct
  type t =
    [ `ViewTimelineName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewTimelineName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewTransitionName = struct
  type t =
    [ `ViewTransitionName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewTransitionName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module ViewportLength = struct
  type t =
    [ `ViewportLength of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `ViewportLength s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitGradientColorStop = struct
  type t =
    [ `WebkitGradientColorStop of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitGradientColorStop s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitGradientPoint = struct
  type t =
    [ `WebkitGradientPoint of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitGradientPoint s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitGradientRadius = struct
  type t =
    [ `WebkitGradientRadius of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitGradientRadius s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitGradientType = struct
  type t =
    [ `WebkitGradientType of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitGradientType s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskBoxRepeat = struct
  type t =
    [ `WebkitMaskBoxRepeat of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitMaskBoxRepeat s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WebkitMaskClipStyle = struct
  type t =
    [ `WebkitMaskClipStyle of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WebkitMaskClipStyle s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WhiteSpaceCollapse = struct
  type t =
    [ `WhiteSpaceCollapse of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WhiteSpaceCollapse s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WordSpaceTransform = struct
  type t =
    [ `WordSpaceTransform of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WordSpaceTransform s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WordWrap = struct
  type t =
    [ `WordWrap of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WordWrap s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module WqName = struct
  type t =
    [ `WqName of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `WqName s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module X = struct
  type t =
    [ `X of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `X s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end

module Y = struct
  type t =
    [ `Y of string
    | Var.t
    | Cascading.t
    ]

  let toString = function
    | `Y s -> s
    | #Var.t as v -> Var.toString v
    | #Cascading.t as c -> Cascading.toString c
end
(* Value type wrapper modules for interpolation - 0 modules *)
