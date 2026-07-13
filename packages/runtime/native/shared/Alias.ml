(* Alias is used to have a few utilities for users that are not aware of the underlying type *)

open Css_types

let initial = `initial
let inherit_ = `inherit_
let unset = `unset

let var ?default (x : string) : [> Var.t ] =
  match default with None -> `var x | Some default -> `varDefault (x, default)

let auto = `auto
let none = `none
let text = `text
let pct (x : float) = `percent x
let num (x : float) = `num x
let ch (x : float) = `ch x
let cm (x : float) = `cm x
let em (x : float) = `em x
let ex (x : float) = `ex x
let mm (x : float) = `mm x
let pt (x : int) = `pt x
let px (x : int) = `px x
let pxFloat (x : float) = `pxFloat x
let rem (x : float) = `rem x
let vh (x : float) = `vh x
let vw (x : float) = `vw x
let vmin (x : float) = `vmin x
let vmax (x : float) = `vmax x
let zero = `zero
let fr (x : float) = `fr x
let deg (x : float) = `deg x
let rad (x : float) = `rad x
let grad (x : float) = `grad x
let turn (x : float) = `turn x
let ltr = `ltr
let rtl = `rtl
let absolute = `absolute
let relative = `relative
let static = `static
let fixed = `fixed
let sticky = `sticky
let isolate = `isolate
let horizontal = `horizontal
let vertical = `vertical
let smallCaps = `smallCaps
let italic = `italic
let oblique = `oblique
let hidden = `hidden
let visible = `visible
let scroll = `scroll
let rgb (r : int) (g : int) (b : int) = `rgb (r, g, b)

let rgba (r : int) (g : int) (b : int) (a : Color.alpha_with_calc) =
  `rgba (r, g, b, a)

let hsl (h : Color.angle_with_calc) (s : Color.percent_with_calc)
  (l : Color.percent_with_calc) =
  `hsl (h, s, l)

let hsla (h : Color.angle_with_calc) (s : Color.percent_with_calc)
  (l : Color.percent_with_calc) (a : Color.angle_with_calc) =
  `hsla (h, s, l, a)

let hex (x : string) = `hex x
let currentColor = `currentColor
let transparent = `transparent
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

let marginBox = `marginBox
let fillBox = `fillBox
let strokeBox = `strokeBox
let viewBox = `viewBox
let translate (x : Length.t) (y : Length.t) = `translate (x, y)

let translate3d (x : Length.t) (y : Length.t) (z : Length.t) =
  `translate3d (x, y, z)

let translateX (x : Length.t) = `translateX x
let translateY (y : Length.t) = `translateY y
let translateZ (z : Length.t) = `translateZ z
let scaleX (x : float) = `scaleX x
let scaleY (x : float) = `scaleY x
let scaleZ (x : float) = `scaleZ x
let rotateX (a : Angle.t) = `rotateX a
let rotateY (a : Angle.t) = `rotateY a
let rotateZ (a : Angle.t) = `rotateZ a
let scale (x : float) (y : float) = `scale (x, y)
let scale3d (x : float) (y : float) (z : float) = `scale3d (x, y, z)
let skew (a : Angle.t) (a' : float) = `skew (a, a')
let skewX (a : Angle.t) = `skewX a
let skewY (a : Angle.t) = `skewY a
let thin = `thin
let extraLight = `extraLight
let light = `light
let medium = `medium
let semiBold = `semiBold
let bold = `bold
let extraBold = `extraBold
let lighter = `lighter
let bolder = `bolder

let linearGradient (direction : Gradient.direction option)
  (stops : Gradient.color_stop_list) =
  `linearGradient (Some direction, stops)

let repeatingLinearGradient (direction : Gradient.direction option)
  (stops : Gradient.color_stop_list) =
  `repeatingLinearGradient (Some direction, stops)

let radialGradient (shape : Gradient.shape) (size : Gradient.radial_size)
  (position : Position.t) (stops : Gradient.color_stop_list) =
  `radialGradient (Some shape, Some size, Some position, stops)

let repeatingRadialGradient (shape : Gradient.shape)
  (size : Gradient.radial_size) (position : Position.t)
  (stops : Gradient.color_stop_list) =
  `repeatingRadialGradient (Some shape, Some size, Some position, stops)

let conicGradient (angle : Gradient.direction option)
  (stops : Gradient.color_stop_list) =
  `conicGradient (Some angle, stops)

let area (x : string) = `area x
let areas (x : string array) = `areas x
let trackSizes (x : TrackSize.t array) = `trackSizes x
let tracks (x : Track.t array) = `tracks x
let numInt (x : int) = `num x
let ident (x : string) = `ident x
let numIdent (x : int) (y : string) = `numIdent (x, y)

let span (x : [ `num of int | `ident of string | `numIdent of int * string ]) =
  `span x

let contextMenu = `contextMenu
let help = `help
let pointer = `pointer
let progress = `progress
let wait = `wait
let cell = `cell
let crosshair = `crosshair
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

module Calc = struct
  let ( - ) a b = `calc (`sub (a, b))
  let ( + ) a b = `calc (`add (a, b))
  let ( * ) a b = `calc (`mult (a, b))
end

let size (x : [ Length.t | Auto.t ]) (y : [ Length.t | Auto.t ]) = `size (x, y)
let all = `all
let backwards = `backwards
let baseline = `baseline
let block = `block
let borderBox = `borderBox
let both = `both
let center = `center
let column = `column
let columnReverse = `columnReverse
let contain = `contain
let contentBox = `contentBox
let count x = `count x
let cover = `cover
let dashed = `dashed
let dotted = `dotted
let flexBox = `flex
let grid = `grid
let inlineGrid = `inlineGrid
let flexEnd = `flexEnd
let flexStart = `flexStart
let forwards = `forwards
let infinite = `infinite
let inline = `inline
let contents = `contents
let inlineBlock = `inlineBlock
let inlineFlex = `inlineFlex
let inlineTable = `inlineTable
let listItem = `listItem
let runIn = `runIn
let table = `table
let tableCaption = `tableCaption
let tableColumnGroup = `tableColumnGroup
let tableHeaderGroup = `tableHeaderGroup
let tableFooterGroup = `tableFooterGroup
let tableRowGroup = `tableRowGroup
let tableCell = `tableCell
let tableColumn = `tableColumn
let tableRow = `tableRow
let local = `local
let localUrl x = `localUrl x
let noRepeat = `noRepeat
let space = `space
let nowrap = `nowrap
let paddingBox = `paddingBox
let paused = `paused
let repeatFn (x : RepeatValue.t) (y : RepeatTrack.t array) = `repeat (x, y)
let repeat = `repeat
let minmax (x : InflexibleBreadth.t) (y : TrackBreadth.t) = `minmax (x, y)
let repeatX = `repeatX
let repeatY = `repeatY
let rotate (a : Angle.t) = `rotate a

let rotate3d (x : float) (y : float) (z : float) (a : Angle.t) =
  `rotate3d (x, y, z, a)

let row = `row
let rowReverse = `rowReverse
let running = `running
let solid = `solid
let spaceAround = `spaceAround
let spaceBetween = `spaceBetween
let spaceEvenly = `spaceEvenly
let stretch = `stretch
let url (x : string) = `url x
let wrap = `wrap
let wrapReverse = `wrapReverse
let inside = `inside
let outside = `outside
let underline = `underline
let overline = `overline
let lineThrough = `lineThrough
let clip = `clip
let ellipsis = `ellipsis
let wavy = `wavy
let double = `double
let uppercase = `uppercase
let lowercase = `lowercase
let capitalize = `capitalize
let sub = `sub
let super = `super
let textTop = `textTop
let textBottom = `textBottom
let middle = `middle
let normal = `normal
let breakAll = `breakAll
let keepAll = `keepAll
let breakWord = `breakWord
let reverse = `reverse
let alternate = `alternate
let alternateReverse = `alternateReverse
let fill = `fill
let maxContent = `maxContent
let minContent = `minContent
let fitContent = `fitContent
let fitContentFn (x : Length.t) = `fitContent x
let round = `round
let miter = `miter
let bevel = `bevel
let butt = `butt
let square = `square
let panX = `panX
let panY = `panY
let panLeft = `panLeft
let panRight = `panRight
let panUp = `panUp
let panDown = `panDown
let pinchZoom = `pinchZoom
let manipulation = `manipulation
let subgrid = `subgrid
let lineNames (x : string) = `lineNames x

module Shadow = struct
  type box = Css_types.Shadow.box Css_types.Shadow.t
  type text = Css_types.Shadow.text Css_types.Shadow.t

  (* [t] is an alias for [box] for backwards compatibility. *)
  type t = box

  let box ?x ?y ?blur ?spread ?inset color =
    Css_types.Shadow.box ?x ?y ?blur ?spread ?inset color

  let text ?x ?y ?blur color = Css_types.Shadow.text ?x ?y ?blur color
end

module Animation = struct
  (* backwards compatibility *)
  let shorthand ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
    ?iterationCount ?name () =
    Css_types.Animation.Value.make ?duration ?delay ?direction ?timingFunction
      ?fillMode ?playState ?iterationCount ?name ()
end

module Transition = struct
  (* backwards compatibility *)
  let shorthand ?behavior ?duration ?delay ?timingFunction ?property () =
    Css_types.Transition.Value.make ?behavior ?duration ?delay ?timingFunction
      ?property ()
end

type animationName = AnimationName.t
type angle = Angle.t
type animationDirection = AnimationDirection.Value.t
type animationFillMode = AnimationFillMode.Value.t
type animationIterationCount = AnimationIterationCount.Value.t
type animationPlayState = AnimationPlayState.Value.t
type cascading = Cascading.t
type color = Color.t
type fontStyle = FontStyle.t
type fontWeight = FontWeight.t
type length = Length.t
type listStyleType = ListStyleType.t
type repeatValue = RepeatValue.t
type outlineStyle = OutlineStyle.t
type transform = Transform.t
type gradient = Gradient.t
