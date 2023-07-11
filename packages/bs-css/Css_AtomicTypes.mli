module Cascading : sig
  type nonrec t =
    [ `initial
    | `inherit_
    | `unset
    ]

  val initial : [> t ]
  val inherit_ : [> t ]
  val unset : [> t ]
  val toString : t -> string
end

module Var : sig
  type nonrec t =
    [ `var of string
    | `varDefault of string * string
    ]

  val var : string -> [> t ]
  val varDefault : string -> string -> [> t ]
  val toString : t -> string
end

module Time : sig
  type nonrec t =
    [ `s of float
    | `ms of float
    ]
  [@@ns.doc
    "\n\
    \   The <time> CSS data type represents a time value expressed in seconds \
     or milliseconds.\n\
    \   It is used in animation, transition, and related properties.\n\
    \ "]

  val s : float -> [> `s of float ]
  val ms : float -> [> `ms of float ]
  val toString : t -> string
end

module Percentage : sig
  type nonrec t = [ `percent of float ]
  [@@ns.doc
    "\n\
    \   The <percentage> CSS data type represents a percentage value.\n\
    \   It is often used to define a size as relative to an element's parent \
     object.\n\
    \ "]

  val pct : float -> [> t ]
  val toString : t -> string
end

module Url : sig
  type nonrec t = [ `url of string ]
  [@@ns.doc
    "\n\
    \   The <url> CSS data type denotes a pointer to a resource, such as an \
     image or a font.\n\
    \   URLs can be used in numerous CSS properties, such as background-image, \
     cursor, and list-style.\n\
    \ "]

  val toString : t -> string
end

module Length : sig
  type t =
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
    | `calc of [ `add | `sub | `mult ] * t * t
    | `percent of float
    ]

  val ch : float -> [> `ch of float ]
  val em : float -> [> `em of float ]
  val ex : float -> [> `ex of float ]
  val rem : float -> [> `rem of float ]
  val vh : float -> [> `vh of float ]
  val vw : float -> [> `vw of float ]
  val vmin : float -> [> `vmin of float ]
  val vmax : float -> [> `vmax of float ]
  val px : int -> [> `px of int ]
  val pxFloat : float -> [> `pxFloat of float ]
  val cm : float -> [> `cm of float ]
  val mm : float -> [> `mm of float ]
  val inch : float -> [> `inch of float ]
  val pc : float -> [> `pc of float ]
  val pt : int -> [> `pt of int ]
  val zero : [> `zero ]
  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/length\n "]

module Angle : sig
  type nonrec t =
    [ `deg of float
    | `rad of float
    | `grad of float
    | `turn of float
    ]
  [@@ns.doc
    "\n\
    \   The angle CSS data type represents an angle value expressed in \
     degrees, gradians, radians, or turns.\n\
    \   It is used, for example, in <gradient>s and in some transform functions.\n\
    \ "]

  val deg : float -> t
  val rad : float -> t
  val grad : float -> t
  val turn : float -> t
  val toString : t -> string
end

module Direction : sig
  type nonrec t =
    [ `ltr
    | `rtl
    ]

  val ltr : [> t ]
  val rtl : [> t ]
  val toString : t -> string
end

module Position : sig
  type nonrec t =
    [ `absolute
    | `relative
    | `static
    | `fixed
    | `sticky
    ]

  val absolute : [> t ]
  val relative : [> t ]
  val static : [> t ]
  val fixed : [> t ]
  val sticky : [> t ]
  val toString : t -> string
end

module Isolation : sig
  type nonrec t =
    [ `auto
    | `isolate
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/isolation\n "]

module Resize : sig
  type nonrec t =
    [ `none
    | `both
    | `horizontal
    | `vertical
    | `block
    | `inline
    ]

  val none : [> t ]
  val both : [> t ]
  val horizontal : [> t ]
  val vertical : [> t ]
  val block : [> t ]
  val inline : [> t ]
  val toString : t -> string
end

module FontVariant : sig
  type nonrec t =
    [ `normal
    | `smallCaps
    ]

  val normal : [> t ]
  val smallCaps : [> t ]
  val toString : t -> string
end

module FontStyle : sig
  type nonrec t =
    [ `normal
    | `italic
    | `oblique
    ]

  val normal : [> t ]
  val italic : [> t ]
  val oblique : [> t ]
  val toString : t -> string
end

module FlexBasis : sig
  type nonrec t =
    [ `auto
    | `fill
    | `content
    | `maxContent
    | `minContent
    | `fitContent
    ]

  val fill : [> t ]
  val content : [> t ]
  val maxContent : [> t ]
  val minContent : [> t ]
  val fitContent : [> t ]
  val toString : t -> string
end

module Overflow : sig
  type nonrec t =
    [ `hidden
    | `visible
    | `scroll
    | `auto
    | `clip
    ]

  val hidden : [> t ]
  val visible : [> t ]
  val scroll : [> t ]
  val auto : [> t ]
  val clip : [> t ]
  val toString : t -> string
end

module Margin : sig
  type nonrec t = [ `auto ]

  val auto : [> t ]
  val toString : t -> string
end

module GridAutoFlow : sig
  type nonrec t =
    [ `column
    | `row
    | `columnDense
    | `rowDense
    ]

  val toString : t -> string
end

module Gap : sig
  type nonrec t = [ `normal ]

  val toString : t -> string
end

module RowGap = Gap
module ColumnGap = Gap

module ScrollBehavior : sig
  type nonrec t =
    [ `auto
    | `smooth
    ]

  val toString : t -> string
end

module OverscrollBehavior : sig
  type nonrec t =
    [ `auto
    | `contain
    | `none
    ]

  val toString : t -> string
end

module OverflowAnchor : sig
  type nonrec t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module ColumnWidth : sig
  type nonrec t = [ `auto ]

  val toString : t -> string
end

module CaretColor : sig
  type nonrec t = [ `auto ]

  val toString : t -> string
end

module VerticalAlign : sig
  type nonrec t =
    [ `baseline
    | `sub
    | `super
    | `top
    | `textTop
    | `middle
    | `bottom
    | `textBottom
    ]

  val toString : t -> string
end

module TimingFunction : sig
  type nonrec t =
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

  val linear : [> t ]
  val ease : [> t ]
  val easeIn : [> t ]
  val easeOut : [> t ]
  val easeInOut : [> t ]
  val stepStart : [> t ]
  val stepEnd : [> t ]
  val steps : int -> [ `start | `end_ ] -> [> t ]
  val cubicBezier : float -> float -> float -> float -> [> t ]
  val jumpStart : [> t ]
  val jumpEnd : [> t ]
  val jumpNone : [> t ]
  val jumpBoth : [> t ]
  val toString : t -> string
end

module RepeatValue : sig
  type nonrec t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  val toString : t -> string
end

module ListStyleType : sig
  type nonrec t =
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

  val toString : t -> string
end

module ListStylePosition : sig
  type nonrec t =
    [ `inside
    | `outside
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/list-style-position\n "]

module OutlineStyle : sig
  type nonrec t =
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

  val toString : t -> string
end

module FontWeight : sig
  type nonrec t =
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

  val thin : [> t ]
  val extraLight : [> t ]
  val light : [> t ]
  val medium : [> t ]
  val semiBold : [> t ]
  val bold : [> t ]
  val extraBold : [> t ]
  val lighter : [> t ]
  val bolder : [> t ]
  val toString : t -> string
end

module Transform : sig
  type nonrec t =
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

  val translate : Length.t -> Length.t -> [> `translate of Length.t * Length.t ]

  val translate3d :
    Length.t ->
    Length.t ->
    Length.t ->
    [> `translate3d of Length.t * Length.t * Length.t ]

  val translateX : Length.t -> [> t ]
  val translateY : Length.t -> [> t ]
  val translateZ : Length.t -> [> t ]
  val scale : float -> float -> [> t ]
  val scale3d : float -> float -> float -> [> t ]
  val scaleX : float -> [> t ]
  val scaleY : float -> [> t ]
  val scaleZ : float -> [> t ]
  val rotate : Angle.t -> [> t ]
  val rotate3d : float -> float -> float -> Angle.t -> [> t ]
  val rotateX : Angle.t -> [> t ]
  val rotateY : Angle.t -> [> t ]
  val rotateZ : Angle.t -> [> t ]
  val skew : Angle.t -> Angle.t -> [> t ]
  val skewX : Angle.t -> [> t ]
  val skewY : Angle.t -> [> t ]
  val toString : t -> string
end

module AnimationDirection : sig
  type nonrec t =
    [ `normal
    | `reverse
    | `alternate
    | `alternateReverse
    ]

  val toString : t -> string
end

module AnimationFillMode : sig
  type nonrec t =
    [ `none
    | `forwards
    | `backwards
    | `both
    ]

  val toString : t -> string
end

module AnimationIterationCount : sig
  type nonrec t =
    [ `infinite
    | `count of int
    ]

  val toString : t -> string
end

module AnimationPlayState : sig
  type nonrec t =
    [ `paused
    | `running
    ]

  val toString : t -> string
end

module Cursor : sig
  type nonrec t =
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

  val auto : [> t ]
  val default : [> t ]
  val none : [> t ]
  val contextMenu : [> t ]
  val help : [> t ]
  val pointer : [> t ]
  val progress : [> t ]
  val wait : [> t ]
  val cell : [> t ]
  val crosshair : [> t ]
  val text : [> t ]
  val verticalText : [> t ]
  val alias : [> t ]
  val copy : [> t ]
  val move : [> t ]
  val noDrop : [> t ]
  val notAllowed : [> t ]
  val grab : [> t ]
  val grabbing : [> t ]
  val allScroll : [> t ]
  val colResize : [> t ]
  val rowResize : [> t ]
  val nResize : [> t ]
  val eResize : [> t ]
  val sResize : [> t ]
  val wResize : [> t ]
  val neResize : [> t ]
  val nwResize : [> t ]
  val seResize : [> t ]
  val swResize : [> t ]
  val ewResize : [> t ]
  val nsResize : [> t ]
  val neswResize : [> t ]
  val nwseResize : [> t ]
  val zoomIn : [> t ]
  val zoomOut : [> t ]
  val toString : t -> string
end

module Color : sig
  type nonrec t =
    [ `rgb of int * int * int
    | `rgba of int * int * int * [ `num of float | Percentage.t ]
    | `hsl of Angle.t * Percentage.t * Percentage.t
    | `hsla of
      Angle.t * Percentage.t * Percentage.t * [ `num of float | Percentage.t ]
    | `hex of string
    | `transparent
    | `currentColor
    ]

  val rgb : int -> int -> int -> [> t ]
  val rgba : int -> int -> int -> [ `num of float | Percentage.t ] -> [> t ]
  val hsl : Angle.t -> Percentage.t -> Percentage.t -> [> t ]

  val hsla :
    Angle.t ->
    Percentage.t ->
    Percentage.t ->
    [ `num of float | Percentage.t ] ->
    [> t ]

  val hex : string -> [> t ]
  val transparent : [> t ]
  val currentColor : [> t ]
  val toString : t -> string
end

module BorderStyle : sig
  type nonrec t =
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

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/border-style\n "]

module PointerEvents : sig
  type nonrec t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module Perspective : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end

module LetterSpacing : sig
  type nonrec t = [ `normal ]

  val normal : [> t ]
    [@@ns.doc
      "\n\
      \   The normal letter spacing for the current font.\n\
      \   Unlike a value of 0, this keyword allows the user agent to alter the \
       space between characters in order to justify text.\n\
      \ "]

  val toString : t -> string
end

module LineHeight : sig
  type nonrec t =
    [ `normal
    | `abs of float
    ]

  val toString : t -> string
end

module WordSpacing : sig
  type nonrec t = [ `normal ]

  val toString : t -> string
end

module DisplayOutside : sig
  type nonrec t =
    [ `block
    | `inline
    | `runIn
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display\n "]

module DisplayInside : sig
  type nonrec t =
    [ `table
    | `flex
    | `grid
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display\n "]

module DisplayListItem : sig
  type nonrec t = [ `listItem ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display\n "]

module DisplayInternal : sig
  type nonrec t =
    [ `tableRowGroup
    | `tableHeaderGroup
    | `tableFooterGroup
    | `tableRow
    | `tableCell
    | `tableColumnGroup
    | `tableColumn
    | `tableCaption
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display\n "]

module DisplayBox : sig
  type nonrec t =
    [ `contents
    | `none
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display-box\n "]

module DisplayLegacy : sig
  type nonrec t =
    [ `inlineBlock
    | `inlineFlex
    | `inlineGrid
    | `inlineTable
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/display\n "]

module JustifySelf : sig
  type nonrec t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/justify-self\n "]

module PositionalAlignment : sig
  type nonrec t =
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

  val toString : t -> string
end
[@@ns.doc
  "\n\
  \ https://developer.mozilla.org/docs/Web/CSS/justify-self\n\
  \ https://developer.mozilla.org/docs/Web/CSS/justify-content\n\
  \ "]

module OverflowAlignment : sig
  type nonrec t =
    [ `safe of PositionalAlignment.t
    | `unsafe of PositionalAlignment.t
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n\
  \ \
   https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Alignment#Overflow_alignment\n\
  \ "]

module BaselineAlignment : sig
  type nonrec t =
    [ `baseline
    | `firstBaseline
    | `lastBaseline
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n\
  \ \
   https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Alignment#Baseline_alignment\n\
  \ "]

module NormalAlignment : sig
  type nonrec t = [ `normal ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/justify-content\n "]

module DistributedAlignment : sig
  type nonrec t =
    [ `spaceBetween
    | `spaceAround
    | `spaceEvenly
    | `stretch
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/justify-content\n "]

module LegacyAlignment : sig
  type nonrec t =
    [ `legacy
    | `legacyRight
    | `legacyLeft
    | `legacyCenter
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://drafts.csswg.org/css-align-3/#propdef-justify-items\n "]

module TextAlign : sig
  type nonrec t =
    [ `start
    | `left
    | `right
    | `center
    | `justify
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/text-align\n "]

module WordBreak : sig
  type nonrec t =
    [ `normal
    | `breakAll
    | `keepAll
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/word-break\n "]

module WhiteSpace : sig
  type nonrec t =
    [ `normal
    | `nowrap
    | `pre
    | `preLine
    | `preWrap
    | `breakSpaces
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/white-space\n "]

module AlignItems : sig
  type nonrec t =
    [ `normal
    | `stretch
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/align-items\n "]

module AlignSelf : sig
  type nonrec t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/align-self\n "]

module AlignContent : sig
  type nonrec t =
    [ `center
    | `start
    | `end_
    | `flexStart
    | `flexEnd
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/align-content\n "]

module ObjectFit : sig
  type nonrec t =
    [ `fill
    | `contain
    | `cover
    | `none
    | `scaleDown
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/object-fit\n "]

module Clear : sig
  type nonrec t =
    [ `none
    | `left
    | `right
    | `both
    | `inlineStart
    | `inlineEnd
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/clear\n "]

module Float : sig
  type nonrec t =
    [ `left
    | `right
    | `none
    | `inlineStart
    | `inlineEnd
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/float\n "]

module Visibility : sig
  type nonrec t =
    [ `visible
    | `hidden
    | `collapse
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/visibility\n "]

module TableLayout : sig
  type nonrec t =
    [ `auto
    | `fixed
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/table-layout\n "]

module BorderCollapse : sig
  type nonrec t =
    [ `collapse
    | `separate
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/border-collapse\n "]

module FlexWrap : sig
  type nonrec t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/flex-wrap\n "]

module FlexDirection : sig
  type nonrec t =
    [ `row
    | `rowReverse
    | `column
    | `columnReverse
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/flex-direction\n "]

module BoxSizing : sig
  type nonrec t =
    [ `contentBox
    | `borderBox
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/box-sizing\n "]

module ColumnCount : sig
  type nonrec t =
    [ `auto
    | `count of int
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/box-sizing\n "]

module UserSelect : sig
  type nonrec t =
    [ `none
    | `auto
    | `text
    | `contain
    | `all
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/user-select\n "]

module TextTransform : sig
  type nonrec t =
    [ `none
    | `capitalize
    | `uppercase
    | `lowercase
    ]

  val toString : t -> string
end

module GridTemplateAreas : sig
  type nonrec t =
    [ `none
    | `areas of string array
    ]

  val areas : string array -> [> t ]
  val toString : t -> string
end

module GridArea : sig
  type nonrec t =
    [ `auto
    | `ident of string
    | `num of int
    | `numIdent of int * string
    | `span of [ `num of int | `ident of string ]
    ]

  val auto : [> t ]
  val ident : string -> [> t ]
  val num : int -> [> t ]
  val numIdent : int -> string -> [> t ]
  val span : [ `num of int | `ident of string ] -> [> t ]
  val toString : t -> string
end

module BackdropFilter : sig
  type nonrec t =
    [ `blur of Length.t
    | `brightness of [ `num of int | `percent of float ]
    | `contrast of [ `num of int | `percent of float ]
    | `dropShadow of [ `num of int | `percent of float ]
    | `grayscale of [ `num of int | `percent of float ]
    | `hueRotate of [ Angle.t | `zero ]
    | `invert of [ `num of int | `percent of float ]
    | `none
    | `opacity of [ `num of int | `percent of float ]
    | `saturate of [ `num of int | `percent of float ]
    | `sepia of [ `num of int | `percent of float ]
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n  https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter\n "]

module BackgroundAttachment : sig
  type nonrec t =
    [ `scroll
    | `fixed
    | `local
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/background-attachment\n "]

module BackgroundClip : sig
  type nonrec t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/background-clip\n "]

module BackgroundOrigin : sig
  type nonrec t =
    [ `borderBox
    | `paddingBox
    | `contentBox
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/background-origin\n "]

module BackgroundPosition : sig
  module X : sig
    type nonrec t =
      [ `left
      | `right
      | `center
      ]

    val toString : t -> string
  end

  module Y : sig
    type nonrec t =
      [ `top
      | `bottom
      | `center
      ]

    val toString : t -> string
  end

  type nonrec t =
    [ X.t
    | Y.t
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/background-position\n "]

module MaskPosition : sig
  module X : sig
    type nonrec t =
      [ `left
      | `right
      | `center
      ]

    val toString : t -> string
  end

  module Y : sig
    type nonrec t =
      [ `top
      | `bottom
      | `center
      ]

    val toString : t -> string
  end

  type nonrec t =
    [ X.t
    | Y.t
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/en-US/docs/Web/CSS/mask-position\n "]

module BackgroundRepeat : sig
  type nonrec twoValue =
    [ `repeat
    | `space
    | `round
    | `noRepeat
    ]

  type nonrec t =
    [ `repeatX
    | `repeatY
    | twoValue
    ]

  type nonrec horizontal = twoValue
  type nonrec vertical = twoValue

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/background-origin\n "]

module TextOverflow : sig
  type nonrec t =
    [ `clip
    | `ellipsis
    | `string of string
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/text-overflow\n "]

module TextDecorationLine : sig
  type nonrec t =
    [ `none
    | `underline
    | `overline
    | `lineThrough
    | `blink
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/text-decoration-line\n "]

module TextDecorationStyle : sig
  type nonrec t =
    [ `solid
    | `double
    | `dotted
    | `dashed
    | `wavy
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/text-decoration-style\n "]

module TextDecorationThickness : sig
  type nonrec t =
    [ `fromFont
    | `auto
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n\
  \ https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-thickness\n\
  \ "]

module Width : sig
  type nonrec t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/width\n "]

module MaxWidth : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/max-width\n "]

module MinWidth : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/max-width\n "]

module Height : sig
  type nonrec t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/height\n "]

module MaxHeight : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/max-height\n "]

module MinHeight : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/min-height\n "]

module OverflowWrap : sig
  type nonrec t =
    [ `normal
    | `breakWord
    | `anywhere
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/overflow-wrap\n "]

module Gradient : sig
  type nonrec 'colorOrVar t =
    [ `linearGradient of
      Angle.t * (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array
    | `repeatingLinearGradient of
      Angle.t * (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array
    | `radialGradient of
      (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array
    | `repeatingRadialGradient of
      (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array
    | `conicGradient of
      Angle.t * (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array
    ]

  val linearGradient :
    Angle.t ->
    (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array ->
    [> 'colorOrVar t ]

  val radialGradient :
    (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array ->
    [> 'colorOrVar t ]

  val repeatingLinearGradient :
    Angle.t ->
    (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array ->
    [> 'colorOrVar t ]

  val repeatingRadialGradient :
    (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array ->
    [> 'colorOrVar t ]

  val conicGradient :
    Angle.t ->
    (Length.t * ([< Color.t | Var.t ] as 'colorOrVar)) array ->
    [> 'colorOrVar t ]

  val toString : [< Color.t | Var.t ] t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/gradient\n "]

module BackgroundImage : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/background-image\n "]

module MaskImage : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/en-US/docs/Web/CSS/mask-image\n "]

module GeometryBox : sig
  type nonrec t =
    [ `marginBox
    | `borderBox
    | `paddingBox
    | `contentBox
    | `fillBox
    | `strokeBox
    | `viewBox
    ]

  val marginBox : [> t ]
  val borderBox : [> t ]
  val paddingBox : [> t ]
  val contentBox : [> t ]
  val fillBox : [> t ]
  val strokeBox : [> t ]

  val viewBox : [> t ]
    [@@ns.doc
      "\n\
      \   Uses the nearest SVG viewport as the reference box.\n\
      \   If a viewBox attribute is specified for the element creating the SVG \
       viewport,\n\
      \   the reference box is positioned at the origin of the coordinate \
       system established by the viewBox attribute and\n\
      \   the dimension of the size of the reference box is set to the width \
       and height values of the viewBox attribute.\n\
      \ "]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/en-US/docs/Web/CSS/clip-path\n "]

module ClipPath : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/clip-path\n "]

module BackfaceVisibility : sig
  type nonrec t =
    [ `visible
    | `hidden
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n https://developer.mozilla.org/docs/Web/CSS/backface-visibility\n "]

module Flex : sig
  type nonrec t =
    [ `auto
    | `initial
    | `none
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/flex\n "]

module TransformStyle : sig
  type nonrec t =
    [ `preserve3d
    | `flat
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/transform-style\n "]

module TransformBox : sig
  type nonrec t =
    [ `contentBox
    | `borderBox
    | `fillBox
    | `strokeBox
    | `viewBox
    ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/transform-box\n "]

module ListStyleImage : sig
  type nonrec t = [ `none ]

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/list-style-image\n "]

module FontFamilyName : sig
  type nonrec t =
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

  val toString : t -> string
end
[@@ns.doc "\n https://developer.mozilla.org/docs/Web/CSS/font-family\n "]

module FontDisplay : sig
  type nonrec t =
    [ `auto
    | `block
    | `swap
    | `fallback
    | `optional
    ]

  val toString : t -> string
end
[@@ns.doc
  "\n\
  \ * https://developer.mozilla.org/fr/docs/Web/CSS/@font-face/font-display\n\
  \ "]

module CounterStyleType : sig
  type nonrec t = ListStyleType.t

  val toString : t -> string
end
[@@ns.doc "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counters\n "]

module Counter : sig
  type nonrec style =
    [ CounterStyleType.t
    | `unset
    ]

  type nonrec t = [ `counter of string * style ]

  val counter : ?style:(style[@ns.namedArgLoc]) -> string -> t
  val toString : t -> string
end
[@@ns.doc "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counter\n "]

module Counters : sig
  type nonrec style =
    [ CounterStyleType.t
    | `unset
    ]

  type nonrec t = [ `counters of string * string * style ]

  val counters :
    ?style:(style[@ns.namedArgLoc]) ->
    ?separator:(string[@ns.namedArgLoc]) ->
    string ->
    t

  val toString : t -> string
end
[@@ns.doc "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counters\n "]

module CounterIncrement : sig
  type nonrec t =
    [ `none
    | `increment of string * int
    ]

  val increment : ?value:(int[@ns.namedArgLoc]) -> string -> t
  val toString : t -> string
end
[@@ns.doc
  "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counter-increment\n "]

module CounterReset : sig
  type nonrec t =
    [ `none
    | `reset of string * int
    ]

  val reset : ?value:(int[@ns.namedArgLoc]) -> string -> t
  val toString : t -> string
end
[@@ns.doc
  "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counter-reset\n "]

module CounterSet : sig
  type nonrec t =
    [ `none
    | `set of string * int
    ]

  val set : ?value:(int[@ns.namedArgLoc]) -> string -> t
  val toString : t -> string
end
[@@ns.doc
  "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/counter-set\n "]

module Content : sig
  type nonrec t =
    [ `none
    | `normal
    | `openQuote
    | `closeQuote
    | `noOpenQuote
    | `noCloseQuote
    | `attr of string
    | `text of string
    ]

  val toString : t -> string
end
[@@ns.doc "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/content\n "]

module SVG : sig
  module Fill : sig
    type nonrec t =
      [ `none
      | `contextFill
      | `contextStroke
      ]

    val contextFill : [> t ]
    val contextStroke : [> t ]
    val toString : t -> string
  end
end

module TouchAction : sig
  type nonrec t =
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

  val toString : t -> string
end
[@@ns.doc
  "\n * https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action\n "]
