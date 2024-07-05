module Std = Kloth

type animationName = string

module Cascading : sig
  type t =
    [ `inherit_
    | `initial
    | `revert
    | `revertLayer
    | `unset
    ]

  val initial : [> `initial ]
  val inherit_ : [> `inherit_ ]
  val unset : [> `unset ]
  val revert : [> `revert ]
  val revertLayer : [> `revertLayer ]
  val toString : t -> string
end

module Var : sig
  type t =
    [ `var of string
    | `varDefault of string * string
    ]

  val var : 'a -> [> `var of 'a ]
  val varDefault : 'a -> 'b -> [> `varDefault of 'a * 'b ]
  val prefix : string -> string
  val toString : t -> string
end

module Time : sig
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

  val s : 'a -> [> `s of 'a ]
  val ms : 'a -> [> `ms of 'a ]
  val toString : t -> string
end

module Percentage : sig
  type t = [ `percent of float ]

  val pct : 'a -> [> `percent of 'a ]
  val toString : t -> string
end

module Url : sig
  type t = [ `url of string ]

  val toString : t -> string
end

module Length : sig
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

  val ch : 'a -> [> `ch of 'a ]
  val em : 'a -> [> `em of 'a ]
  val ex : 'a -> [> `ex of 'a ]
  val rem : 'a -> [> `rem of 'a ]
  val vh : 'a -> [> `vh of 'a ]
  val vw : 'a -> [> `vw of 'a ]
  val vmin : 'a -> [> `vmin of 'a ]
  val vmax : 'a -> [> `vmax of 'a ]
  val px : 'a -> [> `px of 'a ]
  val pxFloat : 'a -> [> `pxFloat of 'a ]
  val cm : 'a -> [> `cm of 'a ]
  val mm : 'a -> [> `mm of 'a ]
  val inch : 'a -> [> `inch of 'a ]
  val pc : 'a -> [> `pc of 'a ]
  val pt : 'a -> [> `pt of 'a ]
  val zero : [> `zero ]
  val toString : t -> string
end

module AspectRatio : sig
  type t =
    [ `auto
    | `num of float
    | `ratio of int * int
    ]

  val toString : t -> string
end

module Angle : sig
  type t =
    [ `deg of float
    | `grad of float
    | `rad of float
    | `turn of float
    ]

  val deg : float -> [> `deg of float ]
  val rad : float -> [> `rad of float ]
  val grad : float -> [> `grad of float ]
  val turn : float -> [> `turn of float ]
  val toString : t -> string
end

module Direction : sig
  type t =
    [ `ltr
    | `rtl
    ]

  val ltr : [> `ltr ]
  val rtl : [> `rtl ]
  val toString : t -> string
end

module PropertyPosition : sig
  type t =
    [ `absolute
    | `fixed
    | `relative
    | `static
    | `sticky
    ]

  val absolute : [> `absolute ]
  val relative : [> `relative ]
  val static : [> `static ]
  val fixed : [> `fixed ]
  val sticky : [> `sticky ]
  val toString : t -> string
end

module Isolation : sig
  type t =
    [ `auto
    | `isolate
    ]

  val toString : t -> string
end

module Resize : sig
  type t =
    [ `block
    | `both
    | `horizontal
    | `inline
    | `none
    | `vertical
    ]

  val none : [> `none ]
  val both : [> `both ]
  val horizontal : [> `horizontal ]
  val vertical : [> `vertical ]
  val block : [> `block ]
  val inline : [> `inline ]
  val toString : t -> string
end

module FontVariant : sig
  type t =
    [ `normal
    | `smallCaps
    ]

  val normal : [> `normal ]
  val smallCaps : [> `smallCaps ]
  val toString : t -> string
end

module FontStyle : sig
  type t =
    [ `italic
    | `normal
    | `oblique
    ]

  val normal : [> `normal ]
  val italic : [> `italic ]
  val oblique : [> `oblique ]
  val toString : t -> string
end

module TabSize : sig
  type t = [ `num of float ]

  val toString : t -> string
end

module FlexBasis : sig
  type t =
    [ `auto
    | `content
    | `fill
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val fill : [> `fill ]
  val content : [> `content ]
  val maxContent : [> `maxContent ]
  val minContent : [> `minContent ]
  val fitContent : [> `fitContent ]
  val toString : t -> string
end

module Overflow : sig
  type t =
    [ `auto
    | `clip
    | `hidden
    | `scroll
    | `visible
    ]

  val hidden : [> `hidden ]
  val visible : [> `visible ]
  val scroll : [> `scroll ]
  val auto : [> `auto ]
  val clip : [> `clip ]
  val toString : t -> string
end

module Margin : sig
  type t = [ `auto ]

  val auto : [> `auto ]
  val toString : t -> string
end

module GridAutoFlow : sig
  type t =
    [ `column
    | `columnDense
    | `row
    | `rowDense
    ]

  val toString : t -> string
end

module Gap : sig
  type t = [ `normal ]

  val toString : t -> string
end

module RowGap = Gap
module ColumnGap = Gap

module ScrollBehavior : sig
  type t =
    [ `auto
    | `smooth
    ]

  val toString : t -> string
end

module OverscrollBehavior : sig
  type t =
    [ `auto
    | `contain
    | `none
    ]

  val toString : t -> string
end

module OverflowAnchor : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module ColumnWidth : sig
  type t = [ `auto ]

  val toString : t -> string
end

module CaretColor : sig
  type t = [ `auto ]

  val toString : t -> string
end

module VerticalAlign : sig
  type t =
    [ `baseline
    | `bottom
    | `middle
    | `sub
    | `super
    | `textBottom
    | `textTop
    | `top
    ]

  val toString : t -> string
end

module TimingFunction : sig
  type t =
    [ `cubicBezier of float * float * float * float
    | `ease
    | `easeIn
    | `easeInOut
    | `easeOut
    | `jumpBoth
    | `jumpEnd
    | `jumpNone
    | `jumpStart
    | `linear
    | `stepEnd
    | `stepStart
    | `steps of int * [ `end_ | `start ]
    ]

  val linear : [> `linear ]
  val ease : [> `ease ]
  val easeIn : [> `easeIn ]
  val easeInOut : [> `easeInOut ]
  val easeOut : [> `easeOut ]
  val stepStart : [> `stepStart ]
  val stepEnd : [> `stepEnd ]
  val steps : 'a -> 'b -> [> `steps of 'a * 'b ]

  val cubicBezier :
    'a -> 'b -> 'c -> 'd -> [> `cubicBezier of 'a * 'b * 'c * 'd ]

  val jumpStart : [> `jumpStart ]
  val jumpEnd : [> `jumpEnd ]
  val jumpNone : [> `jumpNone ]
  val jumpBoth : [> `jumpBoth ]
  val toString : t -> string
end

module RepeatValue : sig
  type t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  val toString : t -> string
end

module ListStyleType : sig
  type t =
    [ `circle
    | `decimal
    | `disc
    | `lowerAlpha
    | `lowerGreek
    | `lowerLatin
    | `lowerRoman
    | `none
    | `square
    | `upperAlpha
    | `upperLatin
    | `upperRoman
    ]

  val toString : t -> string
end

module ListStylePosition : sig
  type t =
    [ `inside
    | `outside
    ]

  val toString : t -> string
end

module OutlineStyle : sig
  type t =
    [ `dashed
    | `dotted
    | `double
    | `groove
    | `hidden
    | `inset
    | `none
    | `auto
    | `outset
    | `ridge
    | `solid
    ]

  val toString : t -> string
end

module FontWeight : sig
  type t =
    [ `black
    | `bold
    | `bolder
    | `extraBold
    | `extraLight
    | `light
    | `lighter
    | `medium
    | `normal
    | `num of int
    | `semiBold
    | `thin
    ]

  val thin : [> `thin ]
  val extraLight : [> `extraLight ]
  val light : [> `light ]
  val medium : [> `medium ]
  val semiBold : [> `semiBold ]
  val bold : [> `bold ]
  val extraBold : [> `extraBold ]
  val lighter : [> `lighter ]
  val bolder : [> `bolder ]
  val toString : t -> string
end

module TransformOrigin : sig
  type t =
    [ Length.t
    | `left
    | `center
    | `right
    | `top
    | `bottom
    ]

  val toString : t -> string
end

module Transform : sig
  type t =
    [ `perspective of int
    | `rotate of Angle.t
    | `rotate3d of float * float * float * Angle.t
    | `rotateX of Angle.t
    | `rotateY of Angle.t
    | `rotateZ of Angle.t
    | `scale of float * float
    | `scale3d of float * float * float
    | `scaleX of float
    | `scaleY of float
    | `scaleZ of float
    | `skew of Angle.t * Angle.t
    | `skewX of Angle.t
    | `skewY of Angle.t
    | `translate of Length.t * Length.t
    | `translate3d of Length.t * Length.t * Length.t
    | `translateX of Length.t
    | `translateY of Length.t
    | `translateZ of Length.t
    ]

  val translate : 'a -> 'b -> [> `translate of 'a * 'b ]
  val translate3d : 'a -> 'b -> 'c -> [> `translate3d of 'a * 'b * 'c ]
  val translateX : 'a -> [> `translateX of 'a ]
  val translateY : 'a -> [> `translateY of 'a ]
  val translateZ : 'a -> [> `translateZ of 'a ]
  val scale : 'a -> 'b -> [> `scale of 'a * 'b ]
  val scale3d : 'a -> 'b -> 'c -> [> `scale3d of 'a * 'b * 'c ]
  val scaleX : 'a -> [> `scaleX of 'a ]
  val scaleY : 'a -> [> `scaleY of 'a ]
  val scaleZ : 'a -> [> `scaleZ of 'a ]
  val rotate : 'a -> [> `rotate of 'a ]
  val rotate3d : 'a -> 'b -> 'c -> 'd -> [> `rotate3d of 'a * 'b * 'c * 'd ]
  val rotateX : 'a -> [> `rotateX of 'a ]
  val rotateY : 'a -> [> `rotateY of 'a ]
  val rotateZ : 'a -> [> `rotateZ of 'a ]
  val skew : 'a -> 'b -> [> `skew of 'a * 'b ]
  val skewX : 'a -> [> `skewX of 'a ]
  val skewY : 'a -> [> `skewY of 'a ]
  val string_of_scale : float -> float -> string
  val string_of_translate3d : Length.t -> Length.t -> Length.t -> string
  val toString : t -> string
end

module AnimationDirection : sig
  type t =
    [ `alternate
    | `alternateReverse
    | `normal
    | `reverse
    ]

  val toString : t -> string
end

module AnimationFillMode : sig
  type t =
    [ `backwards
    | `both
    | `forwards
    | `none
    ]

  val toString : t -> string
end

module AnimationIterationCount : sig
  type t =
    [ `count of float
    | `infinite
    ]

  val toString : t -> string
end

module AnimationPlayState : sig
  type t =
    [ `paused
    | `running
    ]

  val toString : t -> string
end

module Cursor : sig
  type t =
    [ `alias
    | `allScroll
    | `auto
    | `cell
    | `colResize
    | `contextMenu
    | `copy
    | `crosshair
    | `default
    | `eResize
    | `ewResize
    | `grab
    | `grabbing
    | `help
    | `move
    | `nResize
    | `neResize
    | `neswResize
    | `noDrop
    | `none
    | `notAllowed
    | `nsResize
    | `nwResize
    | `nwseResize
    | `pointer
    | `progress
    | `rowResize
    | `sResize
    | `seResize
    | `swResize
    | `text
    | `verticalText
    | `wResize
    | `wait
    | `zoomIn
    | `zoomOut
    ]

  val auto : [> `auto ]
  val default : [> `default ]
  val none : [> `none ]
  val contextMenu : [> `contextMenu ]
  val help : [> `help ]
  val pointer : [> `pointer ]
  val progress : [> `progress ]
  val wait : [> `wait ]
  val cell : [> `cell ]
  val crosshair : [> `crosshair ]
  val text : [> `text ]
  val verticalText : [> `verticalText ]
  val alias : [> `alias ]
  val copy : [> `copy ]
  val move : [> `move ]
  val noDrop : [> `noDrop ]
  val notAllowed : [> `notAllowed ]
  val grab : [> `grab ]
  val grabbing : [> `grabbing ]
  val allScroll : [> `allScroll ]
  val colResize : [> `colResize ]
  val rowResize : [> `rowResize ]
  val nResize : [> `nResize ]
  val eResize : [> `eResize ]
  val sResize : [> `sResize ]
  val wResize : [> `wResize ]
  val neResize : [> `neResize ]
  val nwResize : [> `nwResize ]
  val seResize : [> `seResize ]
  val swResize : [> `swResize ]
  val ewResize : [> `ewResize ]
  val nsResize : [> `nsResize ]
  val neswResize : [> `neswResize ]
  val nwseResize : [> `nwseResize ]
  val zoomIn : [> `zoomIn ]
  val zoomOut : [> `zoomOut ]
  val toString : t -> string
end

module ColorMixMethod : sig
  module PolarColorSpace : sig
    type t =
      [ `hsl
      | `hwb
      | `lch
      | `oklch
      ]

    val toString : t -> string
  end

  module Rectangular_or_Polar_color_space : sig
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

    val toString : t -> string
  end

  module HueSize : sig
    type t =
      [ `shorter
      | `longer
      | `increasing
      | `decreasing
      ]

    val toString : t -> string
  end

  type t =
    [ `in1 of Rectangular_or_Polar_color_space.t
    | `in2 of PolarColorSpace.t * HueSize.t
    ]
end

module Color : sig
  type rgb = int * int * int

  type 'a calc_min_max =
    [ `calc of [ `add of 'a * 'a | `mult of 'a * 'a | `sub of 'a * 'a ]
    | `max of 'a array
    | `min of 'a array
    ]

  type rgba =
    int
    * int
    * int
    * [ Percentage.t calc_min_max | `num of float | `percent of float ]

  type hsl =
    [ Angle.t | Angle.t calc_min_max ]
    * [ Percentage.t calc_min_max | `percent of float ]
    * [ Percentage.t calc_min_max | `percent of float ]

  type hsla =
    [ Angle.t | Angle.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]
    * [ Percentage.t | Percentage.t calc_min_max ]
    * [ `num of float | `percent of float | Percentage.t calc_min_max ]

  type 'a colorMix =
    ColorMixMethod.t * ('a * Percentage.t) * ('a * Percentage.t)

  type t =
    [ `colorMix of t colorMix
    | `currentColor
    | `hex of string
    | `hsl of hsl
    | `hsla of hsla
    | `rgb of rgb
    | `rgba of rgba
    | `transparent
    ]

  val rgb : int -> int -> int -> [> `rgb of int * int * int ]
  val rgba : int -> int -> 'c -> 'd -> [> `rgba of int * int * 'c * 'd ]
  val hsl : 'a -> 'b -> 'c -> [> `hsl of 'a * 'b * 'c ]
  val hsla : 'a -> 'b -> 'c -> 'd -> [> `hsla of 'a * 'b * 'c * 'd ]
  val hex : 'a -> [> `hex of 'a ]
  val transparent : [> `transparent ]
  val currentColor : [> `currentColor ]
  val string_of_alpha : [< `num of float | `percent of float ] -> string
  val toString : t -> string
end

module BorderStyle : sig
  type t =
    [ `dashed
    | `dotted
    | `double
    | `groove
    | `hidden
    | `inset
    | `none
    | `outset
    | `ridge
    | `solid
    ]

  val toString : t -> string
end

module PointerEvents : sig
  type t =
    [ `all
    | `auto
    | `fill
    | `inherit_
    | `none
    | `painted
    | `stroke
    | `visible
    | `visibleFill
    | `visiblePainted
    | `visibleStroke
    ]

  val toString : t -> string
end

module Perspective : sig
  type t = [ `none ]

  val toString : t -> string
end

module LetterSpacing : sig
  type t = [ `normal ]

  val normal : [> `normal ]
  val toString : t -> string
end

module LineHeight : sig
  type t =
    [ `abs of float
    | `normal
    ]

  val toString : t -> string
end

module LineWidth : sig
  type t =
    [ Length.t
    | `thin
    | `medium
    | `thick
    ]

  val toString : t -> string
end

module WordSpacing : sig
  type t = [ `normal ]

  val toString : t -> string
end

module DisplayOld : sig
  type t =
    [ `flow
    | `flowRoot
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
    | `webkitBox
    | `webkitFlex
    | `webkitInlineBox
    | `webkitInlineFlex
    ]

  val toString : t -> string
end

module DisplayOutside : sig
  type t =
    [ `block
    | `inline
    | `runIn
    ]

  val toString : t -> string
end

module DisplayInside : sig
  type t =
    [ `flex
    | `grid
    | `table
    ]

  val toString : t -> string
end

module DisplayListItem : sig
  type t = [ `listItem ]

  val toString : t -> string
end

module DisplayInternal : sig
  type t =
    [ `tableCaption
    | `tableCell
    | `tableColumn
    | `tableColumnGroup
    | `tableFooterGroup
    | `tableHeaderGroup
    | `tableRow
    | `tableRowGroup
    ]

  val toString : t -> string
end

module DisplayBox : sig
  type t =
    [ `contents
    | `none
    ]

  val toString : t -> string
end

module DisplayLegacy : sig
  type t =
    [ `inlineBlock
    | `inlineFlex
    | `inlineGrid
    | `inlineTable
    ]

  val toString : t -> string
end

module JustifySelf : sig
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : t -> string
end

module TextEmphasisStyle : sig
  module FilledOrOpen : sig
    type t =
      [ `filled
      | `open_
      ]

    val toString : t -> string
  end

  module Shape : sig
    type t =
      [ `circle
      | `dot
      | `double_circle
      | `sesame
      | `triangle
      ]

    val toString :
      [< `circle | `dot | `double_circle | `sesame | `triangle ] -> string
  end

  type t =
    [ `circle
    | `dot
    | `double_circle
    | `filled
    | `none
    | `open_
    | `sesame
    | `string of string
    | `triangle
    ]

  val toString : t -> string
end

module TextEmphasisPosition : sig
  module LeftRightAlignment : sig
    type t =
      [ `left
      | `right
      ]

    val toString : t -> string
  end

  module OverOrUnder : sig
    type t =
      [ `over
      | `under
      ]

    val toString : t -> string
  end
end

module Position : sig
  type t =
    [ `top
    | `bottom
    | `left
    | `right
    | `center
    | Percentage.t
    | Length.t
    ]

  val toString : t -> string
end

module PositionalAlignment : sig
  type t =
    [ `center
    | `end_
    | `flexEnd
    | `flexStart
    | `left
    | `right
    | `selfEnd
    | `selfStart
    | `start
    ]

  val toString : t -> string
end

module OverflowAlignment : sig
  type t =
    [ `safe of PositionalAlignment.t
    | `unsafe of PositionalAlignment.t
    ]

  val toString : t -> string
end

module BaselineAlignment : sig
  type t =
    [ `baseline
    | `firstBaseline
    | `lastBaseline
    ]

  val toString : t -> string
end

module NormalAlignment : sig
  type t = [ `normal ]

  val toString : t -> string
end

module DistributedAlignment : sig
  type t =
    [ `spaceAround
    | `spaceBetween
    | `spaceEvenly
    | `stretch
    ]

  val toString : t -> string
end

module LegacyAlignment : sig
  type t =
    [ `legacy
    | `legacyCenter
    | `legacyLeft
    | `legacyRight
    ]

  val toString : t -> string
end

module TextAlign : sig
  type t =
    [ `center
    | `end_
    | `justify
    | `justifyAll
    | `left
    | `matchParent
    | `right
    | `start
    ]

  val toString : t -> string
end

module TextAlignAll : sig
  type t =
    [ `center
    | `end_
    | `justify
    | `left
    | `matchParent
    | `right
    | `start
    ]

  val toString : t -> string
end

module TextAlignLast : sig
  type t =
    [ `auto
    | `center
    | `end_
    | `justify
    | `left
    | `matchParent
    | `right
    | `start
    ]

  val toString : t -> string
end

module WordBreak : sig
  type t =
    [ `breakAll
    | `keepAll
    | `normal
    ]

  val toString : t -> string
end

module WhiteSpace : sig
  type t =
    [ `breakSpaces
    | `normal
    | `nowrap
    | `pre
    | `preLine
    | `preWrap
    ]

  val toString : t -> string
end

module AlignItems : sig
  type t =
    [ `normal
    | `stretch
    ]

  val toString : t -> string
end

module AlignSelf : sig
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : t -> string
end

module AlignContent : sig
  type t =
    [ `center
    | `end_
    | `flexEnd
    | `flexStart
    | `start
    ]

  val toString : t -> string
end

module ObjectFit : sig
  type t =
    [ `contain
    | `cover
    | `fill
    | `none
    | `scaleDown
    ]

  val toString : t -> string
end

module Clear : sig
  type t =
    [ `both
    | `inlineEnd
    | `inlineStart
    | `left
    | `none
    | `right
    ]

  val toString : t -> string
end

module Float : sig
  type t =
    [ `inlineEnd
    | `inlineStart
    | `left
    | `none
    | `right
    ]

  val toString : t -> string
end

module Visibility : sig
  type t =
    [ `collapse
    | `hidden
    | `visible
    ]

  val toString : t -> string
end

module TableLayout : sig
  type t =
    [ `auto
    | `fixed
    ]

  val toString : t -> string
end

module BorderImageSource : sig
  type t = [ `none ]

  val toString : t -> string
end

module BorderCollapse : sig
  type t =
    [ `collapse
    | `separate
    ]

  val toString : t -> string
end

module FlexWrap : sig
  type t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    ]

  val toString : t -> string
end

module FlexDirection : sig
  type t =
    [ `column
    | `columnReverse
    | `row
    | `rowReverse
    ]

  val toString : t -> string
end

module BoxSizing : sig
  type t =
    [ `borderBox
    | `contentBox
    ]

  val toString : t -> string
end

module ColumnCount : sig
  type t =
    [ `auto
    | `count of int
    ]

  val toString : t -> string
end

module UserSelect : sig
  type t =
    [ `all
    | `auto
    | `contain
    | `none
    | `text
    ]

  val toString : t -> string
end

module TextTransform : sig
  type t =
    [ `capitalize
    | `lowercase
    | `none
    | `uppercase
    ]

  val toString : t -> string
end

module GridTemplateAreas : sig
  type t =
    [ `areas of string array
    | `none
    ]

  val areas : 'a -> [> `areas of 'a ]
  val toString : t -> string
end

module GridArea : sig
  type t =
    [ `auto
    | `ident of string
    | `num of int
    | `numIdent of int * string
    | `span of [ `ident of string | `num of int ]
    ]

  val auto : [> `auto ]
  val ident : 'a -> [> `ident of 'a ]
  val num : 'a -> [> `num of 'a ]
  val numIdent : 'a -> 'b -> [> `numIdent of 'a * 'b ]
  val span : 'a -> [> `span of 'a ]
  val toString : t -> string
end

module Filter : sig
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

  val toString : t -> string
end

module BackgroundAttachment : sig
  type t =
    [ `fixed
    | `local
    | `scroll
    ]

  val toString : t -> string
end

module BackgroundClip : sig
  type t =
    [ `borderBox
    | `contentBox
    | `paddingBox
    | `text
    ]

  val toString : t -> string
end

module BackgroundOrigin : sig
  type t =
    [ `borderBox
    | `contentBox
    | `paddingBox
    ]

  val toString : t -> string
end

module MaskPosition : sig
  module X : sig
    type t =
      [ `center
      | `left
      | `right
      ]

    val toString : t -> string
  end

  module Y : sig
    type t =
      [ `bottom
      | `center
      | `top
      ]

    val toString : t -> string
  end

  type t =
    [ `bottom
    | `center
    | `left
    | `right
    | `top
    ]

  val toString : t -> string
end

module BackgroundRepeat : sig
  type twoValue =
    [ `noRepeat
    | `repeat
    | `round
    | `space
    ]

  type t =
    [ `noRepeat
    | `repeat
    | `repeatX
    | `repeatY
    | `round
    | `space
    ]

  type horizontal = twoValue
  type vertical = twoValue

  val toString : t -> string
end

module TextOverflow : sig
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    ]

  val toString : t -> string
end

module TextDecorationLine : sig
  type t =
    [ `blink
    | `lineThrough
    | `none
    | `overline
    | `underline
    ]

  val toString : t -> string
end

module TextDecorationStyle : sig
  type t =
    [ `dashed
    | `dotted
    | `double
    | `solid
    | `wavy
    ]

  val toString : t -> string
end

module TextDecorationThickness : sig
  type t =
    [ `auto
    | `fromFont
    ]

  val toString : t -> string
end

module TextDecorationSkipInk : sig
  type t =
    [ `all
    | `auto
    | `none
    ]

  val toString : t -> string
end

module TextDecorationSkipBox : sig
  type t =
    [ `all
    | `none
    ]

  val toString : t -> string
end

module TextDecorationSkipInset : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module Width : sig
  type t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val toString : t -> string
end

module None : sig
  type t = [ `none ]

  val toString : t -> string
end

module MinWidth = None
module MaxWidth = None

module Height : sig
  type t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val toString : t -> string
end

module MaxHeight = None
module MinHeight = None

module OverflowWrap : sig
  type t =
    [ `anywhere
    | `breakWord
    | `normal
    ]

  val toString : t -> string
end

module SideOrCorner : sig
  type t =
    [ `Bottom
    | `BottomLeft
    | `BottomRight
    | `Left
    | `Right
    | `Top
    | `TopLeft
    | `TopRight
    ]

  val toString : t -> string
end

module Gradient : sig
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

  val linearGradient :
    direction ->
    color_stop_list ->
    [> `linearGradient of direction option * color_stop_list ]

  val repeatingLinearGradient :
    direction ->
    color_stop_list ->
    [> `repeatingLinearGradient of direction option * color_stop_list ]

  val radialGradient :
    shape ->
    radial_size ->
    Position.t ->
    color_stop_list ->
    [> `radialGradient of
       shape option * radial_size option * Position.t option * color_stop_list
    ]

  val repeatingRadialGradient :
    shape ->
    radial_size ->
    Position.t ->
    color_stop_list ->
    [> `repeatingRadialGradient of
       shape option * radial_size option * Position.t option * color_stop_list
    ]

  val conicGradient :
    direction ->
    color_stop_list ->
    [> `conicGradient of direction option * color_stop_list ]

  val string_of_color : [ Color.t | Var.t ] -> string

  val string_of_stops :
    ([ Color.t | Var.t ] option * Length.t option) array -> string

  val direction_to_string : direction -> string
  val toString : t -> string
end

module BackgroundImage : sig
  type t = [ `none ]

  val toString : t -> string
end

module MaskImage : sig
  type t = [ `none ]

  val toString : t -> string
end

module ImageRendering : sig
  type t =
    [ `auto
    | `smooth
    | `highQuality
    | `pixelated
    | `crispEdges
    ]

  val toString : t -> string
end

module GeometryBox : sig
  type t =
    [ `borderBox
    | `contentBox
    | `fillBox
    | `marginBox
    | `paddingBox
    | `strokeBox
    | `viewBox
    ]

  val marginBox : [> `marginBox ]
  val borderBox : [> `borderBox ]
  val paddingBox : [> `paddingBox ]
  val contentBox : [> `contentBox ]
  val fillBox : [> `fillBox ]
  val strokeBox : [> `strokeBox ]
  val viewBox : [> `viewBox ]
  val toString : t -> string
end

module ClipPath : sig
  type t = [ `none ]

  val toString : t -> string
end

module BackfaceVisibility : sig
  type t =
    [ `hidden
    | `visible
    ]

  val toString : t -> string
end

module Flex : sig
  type t =
    [ `auto
    | `initial
    | `none
    ]

  val toString : t -> string
end

module TransformStyle : sig
  type t =
    [ `flat
    | `preserve3d
    ]

  val toString : t -> string
end

module TransformBox : sig
  type t =
    [ `borderBox
    | `contentBox
    | `fillBox
    | `strokeBox
    | `viewBox
    ]

  val toString : t -> string
end

module ListStyleImage : sig
  type t = [ `none ]

  val toString : t -> string
end

module FontFamilyName : sig
  type t =
    [ `cursive
    | `custom of string
    | `emoji
    | `fangsong
    | `fantasy
    | `math
    | `monospace
    | `sansSerif
    | `serif
    | `systemUi
    ]

  val custom : [> `custom ]
  val serif : [> `serif ]
  val sansSerif : [> `sansSerif ]
  val cursive : [> `cursive ]
  val fantasy : [> `fantasy ]
  val monospace : [> `monospace ]
  val systemUi : [> `systemUi ]
  val emoji : [> `emoji ]
  val math : [> `math ]
  val fangsong : [> `fangsong ]
  val toString : t -> string
end

module FontDisplay : sig
  type t =
    [ `auto
    | `block
    | `fallback
    | `optional
    | `swap
    ]

  val auto : [> `auto ]
  val block : [> `block ]
  val swap : [> `swap ]
  val fallback : [> `fallback ]
  val optional : [> `optional ]
  val toString : t -> string
end

module CounterStyleType : sig
  type t = ListStyleType.t

  val toString : t -> string
end

module Counter : sig
  type style =
    [ `circle
    | `decimal
    | `disc
    | `lowerAlpha
    | `lowerGreek
    | `lowerLatin
    | `lowerRoman
    | `none
    | `square
    | `unset
    | `upperAlpha
    | `upperLatin
    | `upperRoman
    ]

  type t = [ `counter of string * style ]

  val counter : ?style:([> `unset ] as 'a) -> 'b -> [> `counter of 'b * 'a ]
  val toString : t -> string
end

module Counters : sig
  type style =
    [ `circle
    | `decimal
    | `disc
    | `lowerAlpha
    | `lowerGreek
    | `lowerLatin
    | `lowerRoman
    | `none
    | `square
    | `unset
    | `upperAlpha
    | `upperLatin
    | `upperRoman
    ]

  type t = [ `counters of string * string * style ]

  val counters :
    ?style:([> `unset ] as 'a) ->
    ?separator:string ->
    'b ->
    [> `counters of 'b * string * 'a ]

  val toString : t -> string
end

module CounterIncrement : sig
  type t =
    [ `increment of string * int
    | `none
    ]

  val increment : ?value:int -> 'a -> [> `increment of 'a * int ]
  val toString : t -> string
end

module CounterReset : sig
  type t =
    [ `none
    | `reset of string * int
    ]

  val reset : ?value:int -> 'a -> [> `reset of 'a * int ]
  val toString : t -> string
end

module CounterSet : sig
  type t =
    [ `none
    | `set of string * int
    ]

  val set : ?value:int -> 'a -> [> `set of 'a * int ]
  val toString : t -> string
end

module Content : sig
  type t =
    [ `attr of string
    | `closeQuote
    | `noCloseQuote
    | `noOpenQuote
    | `none
    | `normal
    | `openQuote
    | `text of string
    ]

  val text_to_string : string -> string
  val toString : t -> string
end

module SVG : sig
  module Fill : sig
    type t =
      [ `contextFill
      | `contextStroke
      | `none
      ]

    val contextFill : [> `contextFill ]
    val contextStroke : [> `contextStroke ]
    val toString : t -> string
  end
end

module TouchAction : sig
  type t =
    [ `auto
    | `manipulation
    | `none
    | `panDown
    | `panLeft
    | `panRight
    | `panUp
    | `panX
    | `panY
    | `pinchZoom
    ]

  val toString : t -> string
end

module ZIndex : sig
  type t =
    [ `auto
    | `num of int
    ]

  val toString : t -> string
end

module AlphaValue : sig
  type t =
    [ `num of float
    | `percent of float
    ]

  val toString : t -> string
end

module LineBreak : sig
  type t =
    [ `anywhere
    | `auto
    | `loose
    | `normal
    | `strict
    ]

  val toString : t -> string
end

module Hyphens : sig
  type t =
    [ `auto
    | `manual
    | `none
    ]

  val toString : t -> string
end

module TextJustify : sig
  type t =
    [ `auto
    | `interCharacter
    | `interWord
    | `none
    ]

  val toString : t -> string
end

module OverflowInline : sig
  type t =
    [ `auto
    | `clip
    | `hidden
    | `scroll
    | `visible
    ]

  val toString : t -> string
end

module FontSynthesisWeight : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module FontSynthesisStyle : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module FontSynthesisSmallCaps : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module FontSynthesisPosition : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module FontKerning : sig
  type t =
    [ `auto
    | `none
    | `normal
    ]

  val toString : t -> string
end

module FontVariantPosition : sig
  type t =
    [ `normal
    | `sub
    | `super
    ]

  val toString : t -> string
end

module FontVariantCaps : sig
  type t =
    [ `allPetiteCaps
    | `allSmallCaps
    | `normal
    | `petiteCaps
    | `smallCaps
    | `titlingCaps
    | `unicase
    ]

  val toString : t -> string
end

module FontOpticalSizing : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : t -> string
end

module FontVariantEmoji : sig
  type t =
    [ `emoji
    | `normal
    | `text
    | `unicode
    ]

  val toString : t -> string
end
