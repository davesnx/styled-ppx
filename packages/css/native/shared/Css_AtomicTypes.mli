module Std = Kloth

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

  val toString :
    [< `inherit_ | `initial | `revert | `revertLayer | `unset ] -> string
end

module Var : sig
  type t =
    [ `var of string
    | `varDefault of string * string
    ]

  val var : 'a -> [> `var of 'a ]
  val varDefault : 'a -> 'b -> [> `varDefault of 'a * 'b ]
  val prefix : string -> string
  val toString : [< `var of string | `varDefault of string * string ] -> string
end

module Time : sig
  type t =
    [ `ms of float
    | `s of float
    ]

  val s : 'a -> [> `s of 'a ]
  val ms : 'a -> [> `ms of 'a ]
  val toString : [< `ms of float | `s of float ] -> string
end

module Percentage : sig
  type t = [ `percent of float ]

  val pct : 'a -> [> `percent of 'a ]
  val toString : [< `percent of float ] -> string
end

module Url : sig
  type t = [ `url of string ]

  val toString : [< `url of string ] -> string
end

module Length : sig
  type t =
    [ `calc of [ `add of t * t | `mult of t * t | `one of t | `sub of t * t ]
    | `ch of float
    | `cm of float
    | `em of float
    | `ex of float
    | `inch of float
    | `mm of float
    | `pc of float
    | `percent of float
    | `pt of int
    | `px of int
    | `pxFloat of float
    | `rem of float
    | `vh of float
    | `vmax of float
    | `vmin of float
    | `vw of float
    | `zero
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

  val toString :
    ([< `calc of
        [< `add of 'a * 'a | `mult of 'a * 'a | `one of 'a | `sub of 'a * 'a ]
     | `ch of float
     | `cm of float
     | `em of float
     | `ex of float
     | `inch of float
     | `mm of float
     | `pc of float
     | `percent of float
     | `pt of int
     | `px of int
     | `pxFloat of float
     | `rem of float
     | `vh of float
     | `vmax of float
     | `vmin of float
     | `vw of float
     | `zero
     ]
     as
     'a) ->
    string
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

  val toString :
    [< `deg of float | `grad of float | `rad of float | `turn of float ] ->
    string
end

module Direction : sig
  type t =
    [ `ltr
    | `rtl
    ]

  val ltr : [> `ltr ]
  val rtl : [> `rtl ]
  val toString : [< `ltr | `rtl ] -> string
end

module Position : sig
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

  val toString :
    [< `absolute | `fixed | `relative | `static | `sticky ] -> string
end

module Isolation : sig
  type t =
    [ `auto
    | `isolate
    ]

  val toString : [< `auto | `isolate ] -> string
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

  val toString :
    [< `block | `both | `horizontal | `inline | `none | `vertical ] -> string
end

module FontVariant : sig
  type t =
    [ `normal
    | `smallCaps
    ]

  val normal : [> `normal ]
  val smallCaps : [> `smallCaps ]
  val toString : [< `normal | `smallCaps ] -> string
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
  val toString : [< `italic | `normal | `oblique ] -> string
end

module TabSize : sig
  type t = [ `num of float ]

  val toString : [< `num of float ] -> string
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

  val toString :
    [< `auto | `content | `fill | `fitContent | `maxContent | `minContent ] ->
    string
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
  val toString : [< `auto | `clip | `hidden | `scroll | `visible ] -> string
end

module Margin : sig
  type t = [ `auto ]

  val auto : [> `auto ]
  val toString : [< `auto ] -> string
end

module GridAutoFlow : sig
  type t =
    [ `column
    | `columnDense
    | `row
    | `rowDense
    ]

  val toString : [< `column | `columnDense | `row | `rowDense ] -> string
end

module Gap : sig
  type t = [ `normal ]

  val toString : [< `normal ] -> string
end

module RowGap = Gap
module ColumnGap = Gap

module ScrollBehavior : sig
  type t =
    [ `auto
    | `smooth
    ]

  val toString : [< `auto | `smooth ] -> string
end

module OverscrollBehavior : sig
  type t =
    [ `auto
    | `contain
    | `none
    ]

  val toString : [< `auto | `contain | `none ] -> string
end

module OverflowAnchor : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module ColumnWidth : sig
  type t = [ `auto ]

  val toString : [< `auto ] -> string
end

module CaretColor : sig
  type t = [ `auto ]

  val toString : [< `auto ] -> string
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

  val toString :
    [< `baseline
    | `bottom
    | `middle
    | `sub
    | `super
    | `textBottom
    | `textTop
    | `top
    ] ->
    string
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

  val toString :
    [< `cubicBezier of float * float * float * float
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
    | `steps of int * [< `end_ | `start ]
    ] ->
    string
end

module RepeatValue : sig
  type t =
    [ `autoFill
    | `autoFit
    | `num of int
    ]

  val toString : [< `autoFill | `autoFit | `num of int ] -> string
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

  val toString :
    [< `circle
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
    ] ->
    string
end

module ListStylePosition : sig
  type t =
    [ `inside
    | `outside
    ]

  val toString : [< `inside | `outside ] -> string
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
    | `outset
    | `ridge
    | `solid
    ]

  val toString :
    [< `dashed
    | `dotted
    | `double
    | `groove
    | `hidden
    | `inset
    | `none
    | `outset
    | `ridge
    | `solid
    ] ->
    string
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

  val toString :
    [< `black
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
    ] ->
    string
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

  val string_of_translate3d :
    ([< `calc of
        [< `add of 'a * 'a | `mult of 'a * 'a | `one of 'a | `sub of 'a * 'a ]
     | `ch of float
     | `cm of float
     | `em of float
     | `ex of float
     | `inch of float
     | `mm of float
     | `pc of float
     | `percent of float
     | `pt of int
     | `px of int
     | `pxFloat of float
     | `rem of float
     | `vh of float
     | `vmax of float
     | `vmin of float
     | `vw of float
     | `zero
     ]
     as
     'a) ->
    ([< `calc of
        [< `add of 'b * 'b | `mult of 'b * 'b | `one of 'b | `sub of 'b * 'b ]
     | `ch of float
     | `cm of float
     | `em of float
     | `ex of float
     | `inch of float
     | `mm of float
     | `pc of float
     | `percent of float
     | `pt of int
     | `px of int
     | `pxFloat of float
     | `rem of float
     | `vh of float
     | `vmax of float
     | `vmin of float
     | `vw of float
     | `zero
     ]
     as
     'b) ->
    ([< `calc of
        [< `add of 'c * 'c | `mult of 'c * 'c | `one of 'c | `sub of 'c * 'c ]
     | `ch of float
     | `cm of float
     | `em of float
     | `ex of float
     | `inch of float
     | `mm of float
     | `pc of float
     | `percent of float
     | `pt of int
     | `px of int
     | `pxFloat of float
     | `rem of float
     | `vh of float
     | `vmax of float
     | `vmin of float
     | `vw of float
     | `zero
     ]
     as
     'c) ->
    string

  val toString :
    [< `perspective of int
    | `rotate of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `rotate3d of
      float
      * float
      * float
      * [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `rotateX of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `rotateY of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `rotateZ of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `scale of float * float
    | `scale3d of float * float * float
    | `scaleX of float
    | `scaleY of float
    | `scaleZ of float
    | `skew of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
      * [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `skewX of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `skewY of
      [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `translate of
      ([< `calc of
          [< `add of 'a * 'a | `mult of 'a * 'a | `one of 'a | `sub of 'a * 'a ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'a)
      * ([< `calc of
            [< `add of 'b * 'b
            | `mult of 'b * 'b
            | `one of 'b
            | `sub of 'b * 'b
            ]
         | `ch of float
         | `cm of float
         | `em of float
         | `ex of float
         | `inch of float
         | `mm of float
         | `pc of float
         | `percent of float
         | `pt of int
         | `px of int
         | `pxFloat of float
         | `rem of float
         | `vh of float
         | `vmax of float
         | `vmin of float
         | `vw of float
         | `zero
         ]
         as
         'b)
    | `translate3d of
      ([< `calc of
          [< `add of 'c * 'c | `mult of 'c * 'c | `one of 'c | `sub of 'c * 'c ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'c)
      * ([< `calc of
            [< `add of 'd * 'd
            | `mult of 'd * 'd
            | `one of 'd
            | `sub of 'd * 'd
            ]
         | `ch of float
         | `cm of float
         | `em of float
         | `ex of float
         | `inch of float
         | `mm of float
         | `pc of float
         | `percent of float
         | `pt of int
         | `px of int
         | `pxFloat of float
         | `rem of float
         | `vh of float
         | `vmax of float
         | `vmin of float
         | `vw of float
         | `zero
         ]
         as
         'd)
      * ([< `calc of
            [< `add of 'e * 'e
            | `mult of 'e * 'e
            | `one of 'e
            | `sub of 'e * 'e
            ]
         | `ch of float
         | `cm of float
         | `em of float
         | `ex of float
         | `inch of float
         | `mm of float
         | `pc of float
         | `percent of float
         | `pt of int
         | `px of int
         | `pxFloat of float
         | `rem of float
         | `vh of float
         | `vmax of float
         | `vmin of float
         | `vw of float
         | `zero
         ]
         as
         'e)
    | `translateX of
      ([< `calc of
          [< `add of 'f * 'f | `mult of 'f * 'f | `one of 'f | `sub of 'f * 'f ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'f)
    | `translateY of
      ([< `calc of
          [< `add of 'g * 'g | `mult of 'g * 'g | `one of 'g | `sub of 'g * 'g ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'g)
    | `translateZ of
      ([< `calc of
          [< `add of 'h * 'h | `mult of 'h * 'h | `one of 'h | `sub of 'h * 'h ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'h)
    ] ->
    string
end

module AnimationDirection : sig
  type t =
    [ `alternate
    | `alternateReverse
    | `normal
    | `reverse
    ]

  val toString :
    [< `alternate | `alternateReverse | `normal | `reverse ] -> string
end

module AnimationFillMode : sig
  type t =
    [ `backwards
    | `both
    | `forwards
    | `none
    ]

  val toString : [< `backwards | `both | `forwards | `none ] -> string
end

module AnimationIterationCount : sig
  type t =
    [ `count of float
    | `infinite
    ]

  val toString : [< `count of float | `infinite ] -> string
end

module AnimationPlayState : sig
  type t =
    [ `paused
    | `running
    ]

  val toString : [< `paused | `running ] -> string
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

  val toString :
    [< `_moz_grab
    | `_moz_grabbing
    | `_moz_zoom_in
    | `_moz_zoom_out
    | `_webkit_grab
    | `_webkit_grabbing
    | `_webkit_zoom_in
    | `_webkit_zoom_out
    | `alias
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
    | `hand
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
    ] ->
    string
end

module ColorMixMethod : sig
  module PolarColorSpace : sig
    type t =
      [ `hsl
      | `hwb
      | `lch
      | `oklch
      ]

    val toString : [< `hsl | `hwb | `lch | `oklch ] -> string
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

    val toString :
      [< `srgb
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
      | `hsl
      | `hwb
      | `lch
      | `oklch
      ] ->
      string
  end

  module HueSize : sig
    type t =
      [ `shorter
      | `longer
      | `increasing
      | `decreasing
      ]

    val toString : [< `shorter | `longer | `increasing | `decreasing ] -> string
  end

  type t =
    [ `in1 of Rectangular_or_Polar_color_space.t
    | `in2 of PolarColorSpace.t * HueSize.t
    ]
end

module Color : sig
  type t =
    [ `currentColor
    | `hex of string
    | `colorMix of ColorMixMethod.t * (t * Percentage.t) * (t * Percentage.t)
    | `hsl of Angle.t * Percentage.t * Percentage.t
    | `hsla of
      Angle.t
      * Percentage.t
      * Percentage.t
      * [ `num of float | `percent of float ]
    | `rgb of int * int * int
    | `rgba of int * int * int * [ `num of float | `percent of float ]
    | `transparent
    ]

  val rgb : 'a -> 'b -> 'c -> [> `rgb of 'a * 'b * 'c ]
  val rgba : 'a -> 'b -> 'c -> 'd -> [> `rgba of 'a * 'b * 'c * 'd ]
  val hsl : 'a -> 'b -> 'c -> [> `hsl of 'a * 'b * 'c ]
  val hsla : 'a -> 'b -> 'c -> 'd -> [> `hsla of 'a * 'b * 'c * 'd ]
  val hex : 'a -> [> `hex of 'a ]
  val transparent : [> `transparent ]
  val currentColor : [> `currentColor ]
  val string_of_alpha : [< `num of float | `percent of float ] -> string

  val toString :
    [ `currentColor
    | `hex of string
    | `colorMix of ColorMixMethod.t * (t * Percentage.t) * (t * Percentage.t)
    | `hsl of
      [ `deg of float | `grad of float | `rad of float | `turn of float ]
      * [ `percent of float ]
      * [ `percent of float ]
    | `hsla of
      [ `deg of float | `grad of float | `rad of float | `turn of float ]
      * [ `percent of float ]
      * [ `percent of float ]
      * [ `num of float | `percent of float ]
    | `rgb of int * int * int
    | `rgba of int * int * int * [ `num of float | `percent of float ]
    | `transparent
    ] ->
    string
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

  val toString :
    [< `dashed
    | `dotted
    | `double
    | `groove
    | `hidden
    | `inset
    | `none
    | `outset
    | `ridge
    | `solid
    ] ->
    string
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

  val toString :
    [< `all
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
    ] ->
    string
end

module Perspective : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
end

module LetterSpacing : sig
  type t = [ `normal ]

  val normal : [> `normal ]
  val toString : [< `normal ] -> string
end

module LineHeight : sig
  type t =
    [ `abs of float
    | `normal
    ]

  val toString : [< `abs of float | `normal ] -> string
end

module LineWidth : sig
  type t =
    [ `calc of
      [ `add of Length.t * Length.t
      | `mult of Length.t * Length.t
      | `one of Length.t
      | `sub of Length.t * Length.t
      ]
    | `ch of float
    | `cm of float
    | `em of float
    | `ex of float
    | `inch of float
    | `medium
    | `mm of float
    | `pc of float
    | `percent of float
    | `pt of int
    | `px of int
    | `pxFloat of float
    | `rem of float
    | `thick
    | `thin
    | `vh of float
    | `vmax of float
    | `vmin of float
    | `vw of float
    | `zero
    ]

  val toString :
    [< `calc of
       [ `add of Length.t * Length.t
       | `mult of Length.t * Length.t
       | `one of Length.t
       | `sub of Length.t * Length.t
       ]
    | `ch of float
    | `cm of float
    | `em of float
    | `ex of float
    | `inch of float
    | `medium
    | `mm of float
    | `pc of float
    | `percent of float
    | `pt of int
    | `px of int
    | `pxFloat of float
    | `rem of float
    | `thick
    | `thin
    | `vh of float
    | `vmax of float
    | `vmin of float
    | `vw of float
    | `zero
    ] ->
    string
end

module WordSpacing : sig
  type t = [ `normal ]

  val toString : [< `normal ] -> string
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

  val toString :
    [< `flow
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
    ] ->
    string
end

module DisplayOutside : sig
  type t =
    [ `block
    | `inline
    | `runIn
    ]

  val toString : [< `block | `inline | `runIn ] -> string
end

module DisplayInside : sig
  type t =
    [ `flex
    | `grid
    | `table
    ]

  val toString : [< `flex | `grid | `table ] -> string
end

module DisplayListItem : sig
  type t = [ `listItem ]

  val toString : [< `listItem ] -> string
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

  val toString :
    [< `tableCaption
    | `tableCell
    | `tableColumn
    | `tableColumnGroup
    | `tableFooterGroup
    | `tableHeaderGroup
    | `tableRow
    | `tableRowGroup
    ] ->
    string
end

module DisplayBox : sig
  type t =
    [ `contents
    | `none
    ]

  val toString : [< `contents | `none ] -> string
end

module DisplayLegacy : sig
  type t =
    [ `inlineBlock
    | `inlineFlex
    | `inlineGrid
    | `inlineTable
    ]

  val toString :
    [< `inlineBlock | `inlineFlex | `inlineGrid | `inlineTable ] -> string
end

module JustifySelf : sig
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : [< `auto | `normal | `stretch ] -> string
end

module TextEmphasisStyle : sig
  module FilledOrOpen : sig
    type t =
      [ `filled
      | `open_
      ]

    val toString : [< `filled | `open_ ] -> string
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

  val toString :
    [< `circle
    | `dot
    | `double_circle
    | `filled
    | `none
    | `open_
    | `sesame
    | `string of string
    | `triangle
    ] ->
    string
end

module TextEmphasisPosition : sig
  module LeftRightAlignment : sig
    type t =
      [ `left
      | `right
      ]

    val toString : [< `left | `right ] -> string
  end

  module OverOrUnder : sig
    type t =
      [ `over
      | `under
      ]

    val toString : [< `over | `under ] -> string
  end
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

  val toString :
    [< `center
    | `end_
    | `flexEnd
    | `flexStart
    | `left
    | `right
    | `selfEnd
    | `selfStart
    | `start
    ] ->
    string
end

module OverflowAlignment : sig
  type t =
    [ `safe of PositionalAlignment.t
    | `unsafe of PositionalAlignment.t
    ]

  val toString :
    [< `safe of
       [< `center
       | `end_
       | `flexEnd
       | `flexStart
       | `left
       | `right
       | `selfEnd
       | `selfStart
       | `start
       ]
    | `unsafe of
      [< `center
      | `end_
      | `flexEnd
      | `flexStart
      | `left
      | `right
      | `selfEnd
      | `selfStart
      | `start
      ]
    ] ->
    string
end

module BaselineAlignment : sig
  type t =
    [ `baseline
    | `firstBaseline
    | `lastBaseline
    ]

  val toString : [< `baseline | `firstBaseline | `lastBaseline ] -> string
end

module NormalAlignment : sig
  type t = [ `normal ]

  val toString : [< `normal ] -> string
end

module DistributedAlignment : sig
  type t =
    [ `spaceAround
    | `spaceBetween
    | `spaceEvenly
    | `stretch
    ]

  val toString :
    [< `spaceAround | `spaceBetween | `spaceEvenly | `stretch ] -> string
end

module LegacyAlignment : sig
  type t =
    [ `legacy
    | `legacyCenter
    | `legacyLeft
    | `legacyRight
    ]

  val toString :
    [< `legacy | `legacyCenter | `legacyLeft | `legacyRight ] -> string
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

  val toString :
    [< `center
    | `end_
    | `justify
    | `justifyAll
    | `left
    | `matchParent
    | `right
    | `start
    ] ->
    string
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

  val toString :
    [< `center | `end_ | `justify | `left | `matchParent | `right | `start ] ->
    string
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

  val toString :
    [< `auto
    | `center
    | `end_
    | `justify
    | `left
    | `matchParent
    | `right
    | `start
    ] ->
    string
end

module WordBreak : sig
  type t =
    [ `breakAll
    | `keepAll
    | `normal
    ]

  val toString : [< `breakAll | `keepAll | `normal ] -> string
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

  val toString :
    [< `breakSpaces | `normal | `nowrap | `pre | `preLine | `preWrap ] -> string
end

module AlignItems : sig
  type t =
    [ `normal
    | `stretch
    ]

  val toString : [< `normal | `stretch ] -> string
end

module AlignSelf : sig
  type t =
    [ `auto
    | `normal
    | `stretch
    ]

  val toString : [< `auto | `normal | `stretch ] -> string
end

module AlignContent : sig
  type t =
    [ `center
    | `end_
    | `flexEnd
    | `flexStart
    | `start
    ]

  val toString : [< `center | `end_ | `flexEnd | `flexStart | `start ] -> string
end

module ObjectFit : sig
  type t =
    [ `contain
    | `cover
    | `fill
    | `none
    | `scaleDown
    ]

  val toString : [< `contain | `cover | `fill | `none | `scaleDown ] -> string
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

  val toString :
    [< `both | `inlineEnd | `inlineStart | `left | `none | `right ] -> string
end

module Float : sig
  type t =
    [ `inlineEnd
    | `inlineStart
    | `left
    | `none
    | `right
    ]

  val toString :
    [< `inlineEnd | `inlineStart | `left | `none | `right ] -> string
end

module Visibility : sig
  type t =
    [ `collapse
    | `hidden
    | `visible
    ]

  val toString : [< `collapse | `hidden | `visible ] -> string
end

module TableLayout : sig
  type t =
    [ `auto
    | `fixed
    ]

  val toString : [< `auto | `fixed ] -> string
end

module BorderImageSource : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
end

module BorderCollapse : sig
  type t =
    [ `collapse
    | `separate
    ]

  val toString : [< `collapse | `separate ] -> string
end

module FlexWrap : sig
  type t =
    [ `nowrap
    | `wrap
    | `wrapReverse
    ]

  val toString : [< `nowrap | `wrap | `wrapReverse ] -> string
end

module FlexDirection : sig
  type t =
    [ `column
    | `columnReverse
    | `row
    | `rowReverse
    ]

  val toString : [< `column | `columnReverse | `row | `rowReverse ] -> string
end

module BoxSizing : sig
  type t =
    [ `borderBox
    | `contentBox
    ]

  val toString : [< `borderBox | `contentBox ] -> string
end

module ColumnCount : sig
  type t =
    [ `auto
    | `count of int
    ]

  val toString : [< `auto | `count of int ] -> string
end

module UserSelect : sig
  type t =
    [ `all
    | `auto
    | `contain
    | `none
    | `text
    ]

  val toString : [< `all | `auto | `contain | `none | `text ] -> string
end

module TextTransform : sig
  type t =
    [ `capitalize
    | `lowercase
    | `none
    | `uppercase
    ]

  val toString : [< `capitalize | `lowercase | `none | `uppercase ] -> string
end

module GridTemplateAreas : sig
  type t =
    [ `areas of string array
    | `none
    ]

  val areas : 'a -> [> `areas of 'a ]
  val toString : [< `areas of string array | `none ] -> string
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

  val toString :
    [< `auto
    | `ident of string
    | `num of int
    | `numIdent of int * string
    | `span of [< `ident of string | `num of int ]
    ] ->
    string
end

module BackdropFilter : sig
  type t =
    [ `blur of Length.t
    | `brightness of [ `num of int | `percent of float ]
    | `contrast of [ `num of int | `percent of float ]
    | `dropShadow of [ `num of int | `percent of float ]
    | `grayscale of [ `num of int | `percent of float ]
    | `hueRotate of
      [ `deg of float
      | `grad of float
      | `rad of float
      | `turn of float
      | `zero
      ]
    | `invert of [ `num of int | `percent of float ]
    | `none
    | `opacity of [ `num of int | `percent of float ]
    | `saturate of [ `num of int | `percent of float ]
    | `sepia of [ `num of int | `percent of float ]
    ]

  val string_of_percent : float -> string

  val toString :
    [< `blur of [< Length.t ]
    | `brightness of [< `num of int | `percent of float ]
    | `contrast of [< `num of int | `percent of float ]
    | `dropShadow of [< `num of int | `percent of float ]
    | `grayscale of [< `num of int | `percent of float ]
    | `hueRotate of
      [< `deg of float
      | `grad of float
      | `rad of float
      | `turn of float
      | `zero
      ]
    | `invert of [< `num of int | `percent of float ]
    | `none
    | `opacity of [< `num of int | `percent of float ]
    | `saturate of [< `num of int | `percent of float ]
    | `sepia of [< `num of int | `percent of float ]
    ] ->
    string
end

module BackgroundAttachment : sig
  type t =
    [ `fixed
    | `local
    | `scroll
    ]

  val toString : [< `fixed | `local | `scroll ] -> string
end

module BackgroundClip : sig
  type t =
    [ `borderBox
    | `contentBox
    | `paddingBox
    ]

  val toString : [< `borderBox | `contentBox | `paddingBox ] -> string
end

module BackgroundOrigin : sig
  type t =
    [ `borderBox
    | `contentBox
    | `paddingBox
    ]

  val toString : [< `borderBox | `contentBox | `paddingBox ] -> string
end

module BackgroundPosition : sig
  module X : sig
    type t =
      [ `center
      | `left
      | `right
      ]

    val toString : [< `center | `left | `right ] -> string
  end

  module Y : sig
    type t =
      [ `bottom
      | `center
      | `top
      ]

    val toString : [< `bottom | `center | `top ] -> string
  end

  type t =
    [ `bottom
    | `center
    | `left
    | `right
    | `top
    ]

  val toString : [< `bottom | `center | `left | `right | `top ] -> string
end

module MaskPosition : sig
  module X : sig
    type t =
      [ `center
      | `left
      | `right
      ]

    val toString : [< `center | `left | `right ] -> string
  end

  module Y : sig
    type t =
      [ `bottom
      | `center
      | `top
      ]

    val toString : [< `bottom | `center | `top ] -> string
  end

  type t =
    [ `bottom
    | `center
    | `left
    | `right
    | `top
    ]

  val toString : [< `bottom | `center | `left | `right | `top ] -> string
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

  val toString :
    [< `noRepeat | `repeat | `repeatX | `repeatY | `round | `space ] -> string
end

module TextOverflow : sig
  type t =
    [ `clip
    | `ellipsis
    | `string of string
    ]

  val toString : [< `clip | `ellipsis | `string of string ] -> string
end

module TextDecorationLine : sig
  type t =
    [ `blink
    | `lineThrough
    | `none
    | `overline
    | `underline
    ]

  val toString :
    [< `blink | `lineThrough | `none | `overline | `underline ] -> string
end

module TextDecorationStyle : sig
  type t =
    [ `dashed
    | `dotted
    | `double
    | `solid
    | `wavy
    ]

  val toString : [< `dashed | `dotted | `double | `solid | `wavy ] -> string
end

module TextDecorationThickness : sig
  type t =
    [ `auto
    | `fromFont
    ]

  val toString : [< `auto | `fromFont ] -> string
end

module TextDecorationSkipInk : sig
  type t =
    [ `all
    | `auto
    | `none
    ]

  val toString : [< `all | `auto | `none ] -> string
end

module TextDecorationSkipBox : sig
  type t =
    [ `all
    | `none
    ]

  val toString : [< `all | `none ] -> string
end

module TextDecorationSkipInset : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module Width : sig
  type t =
    [ `auto
    | `fitContent
    | `maxContent
    | `minContent
    ]

  val toString : [< `auto | `fitContent | `maxContent | `minContent ] -> string
end

module None : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
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

  val toString : [< `auto | `fitContent | `maxContent | `minContent ] -> string
end

module MaxHeight = None
module MinHeight = None

module OverflowWrap : sig
  type t =
    [ `anywhere
    | `breakWord
    | `normal
    ]

  val toString : [< `anywhere | `breakWord | `normal ] -> string
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

  val toString :
    [< `Bottom
    | `BottomLeft
    | `BottomRight
    | `Left
    | `Right
    | `Top
    | `TopLeft
    | `TopRight
    ] ->
    string
end

module Gradient : sig
  type 'a t =
    [ `conicGradient of
      [ `Angle of Angle.t | `SideOrCorner of SideOrCorner.t ] option
      * ('a * Length.t option) array
    | `linearGradient of
      [ `Angle of Angle.t | `SideOrCorner of SideOrCorner.t ] option
      * ('a * Length.t option) array
    | `radialGradient of ('a * Length.t option) array
    | `repeatingLinearGradient of
      [ `Angle of Angle.t | `SideOrCorner of SideOrCorner.t ] option
      * ('a * Length.t option) array
    | `repeatingRadialGradient of ('a * Length.t option) array
    ]
    constraint
      'a =
      [< `currentColor
      | `hex of string
      | `colorMix of
        ColorMixMethod.t * (Color.t * Percentage.t) * (Color.t * Percentage.t)
      | `hsl of Angle.t * Percentage.t * Percentage.t
      | `hsla of
        Angle.t
        * Percentage.t
        * Percentage.t
        * [ `num of float | `percent of float ]
      | `rgb of int * int * int
      | `rgba of int * int * int * [ `num of float | `percent of float ]
      | `transparent
      | `var of string
      | `varDefault of string * string
      ]

  val linearGradient : 'a -> 'b -> [> `linearGradient of 'a * 'b ]

  val repeatingLinearGradient :
    'a -> 'b -> [> `repeatingLinearGradient of 'a * 'b ]

  val radialGradient : 'a -> [> `radialGradient of 'a ]
  val repeatingRadialGradient : 'a -> [> `repeatingRadialGradient of 'a ]
  val conicGradient : 'a -> 'b -> [> `conicGradient of 'a * 'b ]

  val string_of_color :
    [< `currentColor
    | `hex of string
    | `colorMix of
      ColorMixMethod.t * (Color.t * Percentage.t) * (Color.t * Percentage.t)
    | `hsl of Angle.t * Percentage.t * Percentage.t
    | `hsla of
      Angle.t
      * Percentage.t
      * Percentage.t
      * [ `num of float | `percent of float ]
    | `rgb of int * int * int
    | `rgba of int * int * int * [ `num of float | `percent of float ]
    | `transparent
    | `var of string
    | `varDefault of string * string
    ] ->
    string

  val string_of_stops :
    ([< `currentColor
     | `hex of string
     | `colorMix of
       ColorMixMethod.t * (Color.t * Percentage.t) * (Color.t * Percentage.t)
     | `hsl of Angle.t * Percentage.t * Percentage.t
     | `hsla of
       Angle.t
       * Percentage.t
       * Percentage.t
       * [ `num of float | `percent of float ]
     | `rgb of int * int * int
     | `rgba of int * int * int * [ `num of float | `percent of float ]
     | `transparent
     | `var of string
     | `varDefault of string * string
     ]
    * ([< `calc of
          [< `add of 'a * 'a | `mult of 'a * 'a | `one of 'a | `sub of 'a * 'a ]
       | `ch of float
       | `cm of float
       | `em of float
       | `ex of float
       | `inch of float
       | `mm of float
       | `pc of float
       | `percent of float
       | `pt of int
       | `px of int
       | `pxFloat of float
       | `rem of float
       | `vh of float
       | `vmax of float
       | `vmin of float
       | `vw of float
       | `zero
       ]
       as
       'a)
      option)
    array ->
    string

  val direction_to_string :
    [< `Angle of
       [< `deg of float | `grad of float | `rad of float | `turn of float ]
    | `SideOrCorner of
      [< `Bottom
      | `BottomLeft
      | `BottomRight
      | `Left
      | `Right
      | `Top
      | `TopLeft
      | `TopRight
      ]
    ] ->
    string

  val toString :
    [< `conicGradient of
       [< `Angle of
          [< `deg of float | `grad of float | `rad of float | `turn of float ]
       | `SideOrCorner of
         [< `Bottom
         | `BottomLeft
         | `BottomRight
         | `Left
         | `Right
         | `Top
         | `TopLeft
         | `TopRight
         ]
       ]
       option
       * ([< `currentColor
          | `hex of string
          | `colorMix of
            ColorMixMethod.t
            * (Color.t * Percentage.t)
            * (Color.t * Percentage.t)
          | `hsl of Angle.t * Percentage.t * Percentage.t
          | `hsla of
            Angle.t
            * Percentage.t
            * Percentage.t
            * [ `num of float | `percent of float ]
          | `rgb of int * int * int
          | `rgba of int * int * int * [ `num of float | `percent of float ]
          | `transparent
          | `var of string
          | `varDefault of string * string
          ]
         * ([< `calc of
               [< `add of 'a * 'a
               | `mult of 'a * 'a
               | `one of 'a
               | `sub of 'a * 'a
               ]
               & [< `add of 'a * 'a
                 | `mult of 'a * 'a
                 | `one of 'a
                 | `sub of 'a * 'a
                 ]
            | `ch of float
            | `cm of float
            | `em of float
            | `ex of float
            | `inch of float
            | `mm of float
            | `pc of float
            | `percent of float
            | `pt of int
            | `px of int
            | `pxFloat of float
            | `rem of float
            | `vh of float
            | `vmax of float
            | `vmin of float
            | `vw of float
            | `zero
            ]
            as
            'a)
           option)
         array
    | `linearGradient of
      [< `Angle of
         [< `deg of float | `grad of float | `rad of float | `turn of float ]
      | `SideOrCorner of
        [< `Bottom
        | `BottomLeft
        | `BottomRight
        | `Left
        | `Right
        | `Top
        | `TopLeft
        | `TopRight
        ]
      ]
      option
      * ([< `currentColor
         | `hex of string
         | `colorMix of
           ColorMixMethod.t
           * (Color.t * Percentage.t)
           * (Color.t * Percentage.t)
         | `hsl of Angle.t * Percentage.t * Percentage.t
         | `hsla of
           Angle.t
           * Percentage.t
           * Percentage.t
           * [ `num of float | `percent of float ]
         | `rgb of int * int * int
         | `rgba of int * int * int * [ `num of float | `percent of float ]
         | `transparent
         | `var of string
         | `varDefault of string * string
         ]
        * ([< `calc of
              [< `add of 'b * 'b
              | `mult of 'b * 'b
              | `one of 'b
              | `sub of 'b * 'b
              ]
              & [< `add of 'b * 'b
                | `mult of 'b * 'b
                | `one of 'b
                | `sub of 'b * 'b
                ]
           | `ch of float
           | `cm of float
           | `em of float
           | `ex of float
           | `inch of float
           | `mm of float
           | `pc of float
           | `percent of float
           | `pt of int
           | `px of int
           | `pxFloat of float
           | `rem of float
           | `vh of float
           | `vmax of float
           | `vmin of float
           | `vw of float
           | `zero
           ]
           as
           'b)
          option)
        array
    | `radialGradient of
      ([< `currentColor
       | `hex of string
       | `colorMix of
         ColorMixMethod.t * (Color.t * Percentage.t) * (Color.t * Percentage.t)
       | `hsl of Angle.t * Percentage.t * Percentage.t
       | `hsla of
         Angle.t
         * Percentage.t
         * Percentage.t
         * [ `num of float | `percent of float ]
       | `rgb of int * int * int
       | `rgba of int * int * int * [ `num of float | `percent of float ]
       | `transparent
       | `var of string
       | `varDefault of string * string
       ]
      * ([< `calc of
            [< `add of 'c * 'c
            | `mult of 'c * 'c
            | `one of 'c
            | `sub of 'c * 'c
            ]
         | `ch of float
         | `cm of float
         | `em of float
         | `ex of float
         | `inch of float
         | `mm of float
         | `pc of float
         | `percent of float
         | `pt of int
         | `px of int
         | `pxFloat of float
         | `rem of float
         | `vh of float
         | `vmax of float
         | `vmin of float
         | `vw of float
         | `zero
         ]
         as
         'c)
        option)
      array
    | `repeatingLinearGradient of
      [< `Angle of
         [< `deg of float | `grad of float | `rad of float | `turn of float ]
      | `SideOrCorner of
        [< `Bottom
        | `BottomLeft
        | `BottomRight
        | `Left
        | `Right
        | `Top
        | `TopLeft
        | `TopRight
        ]
      ]
      option
      * ([< `currentColor
         | `hex of string
         | `colorMix of
           ColorMixMethod.t
           * (Color.t * Percentage.t)
           * (Color.t * Percentage.t)
         | `hsl of Angle.t * Percentage.t * Percentage.t
         | `hsla of
           Angle.t
           * Percentage.t
           * Percentage.t
           * [ `num of float | `percent of float ]
         | `rgb of int * int * int
         | `rgba of int * int * int * [ `num of float | `percent of float ]
         | `transparent
         | `var of string
         | `varDefault of string * string
         ]
        * ([< `calc of
              [< `add of 'd * 'd
              | `mult of 'd * 'd
              | `one of 'd
              | `sub of 'd * 'd
              ]
              & [< `add of 'd * 'd
                | `mult of 'd * 'd
                | `one of 'd
                | `sub of 'd * 'd
                ]
           | `ch of float
           | `cm of float
           | `em of float
           | `ex of float
           | `inch of float
           | `mm of float
           | `pc of float
           | `percent of float
           | `pt of int
           | `px of int
           | `pxFloat of float
           | `rem of float
           | `vh of float
           | `vmax of float
           | `vmin of float
           | `vw of float
           | `zero
           ]
           as
           'd)
          option)
        array
    | `repeatingRadialGradient of
      ([< `currentColor
       | `hex of string
       | `colorMix of
         ColorMixMethod.t * (Color.t * Percentage.t) * (Color.t * Percentage.t)
       | `hsl of Angle.t * Percentage.t * Percentage.t
       | `hsla of
         Angle.t
         * Percentage.t
         * Percentage.t
         * [ `num of float | `percent of float ]
       | `rgb of int * int * int
       | `rgba of int * int * int * [ `num of float | `percent of float ]
       | `transparent
       | `var of string
       | `varDefault of string * string
       ]
      * ([< `calc of
            [< `add of 'e * 'e
            | `mult of 'e * 'e
            | `one of 'e
            | `sub of 'e * 'e
            ]
         | `ch of float
         | `cm of float
         | `em of float
         | `ex of float
         | `inch of float
         | `mm of float
         | `pc of float
         | `percent of float
         | `pt of int
         | `px of int
         | `pxFloat of float
         | `rem of float
         | `vh of float
         | `vmax of float
         | `vmin of float
         | `vw of float
         | `zero
         ]
         as
         'e)
        option)
      array
    ] ->
    string
end

module BackgroundImage : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
end

module MaskImage : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
end

module ImageRendering : sig
  type t =
    [ `auto
    | `smooth
    | `highQuality
    | `pixelated
    | `crispEdges
    ]

  val toString :
    [< `auto | `smooth | `highQuality | `pixelated | `crispEdges ] -> string
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

  val toString :
    [< `borderBox
    | `contentBox
    | `fillBox
    | `marginBox
    | `paddingBox
    | `strokeBox
    | `viewBox
    ] ->
    string
end

module ClipPath : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
end

module BackfaceVisibility : sig
  type t =
    [ `hidden
    | `visible
    ]

  val toString : [< `hidden | `visible ] -> string
end

module Flex : sig
  type t =
    [ `auto
    | `initial
    | `none
    ]

  val toString : [< `auto | `initial | `none ] -> string
end

module TransformStyle : sig
  type t =
    [ `flat
    | `preserve3d
    ]

  val toString : [< `flat | `preserve3d ] -> string
end

module TransformBox : sig
  type t =
    [ `borderBox
    | `contentBox
    | `fillBox
    | `strokeBox
    | `viewBox
    ]

  val toString :
    [< `borderBox | `contentBox | `fillBox | `strokeBox | `viewBox ] -> string
end

module ListStyleImage : sig
  type t = [ `none ]

  val toString : [< `none ] -> string
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

  val toString :
    [< `cursive
    | `custom of string
    | `emoji
    | `fangsong
    | `fantasy
    | `math
    | `monospace
    | `sansSerif
    | `serif
    | `systemUi
    ] ->
    string
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
  val toString : [< `auto | `block | `fallback | `optional | `swap ] -> string
end

module CounterStyleType : sig
  type t = ListStyleType.t

  val toString : [< ListStyleType.t ] -> string
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

  val toString :
    [< `counter of
       string
       * [< `circle
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
    ] ->
    string
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

  val toString :
    [< `counters of
       string
       * string
       * [< `circle
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
    ] ->
    string
end

module CounterIncrement : sig
  type t =
    [ `increment of string * int
    | `none
    ]

  val increment : ?value:int -> 'a -> [> `increment of 'a * int ]
  val toString : [< `increment of string * int | `none ] -> string
end

module CounterReset : sig
  type t =
    [ `none
    | `reset of string * int
    ]

  val reset : ?value:int -> 'a -> [> `reset of 'a * int ]
  val toString : [< `none | `reset of string * int ] -> string
end

module CounterSet : sig
  type t =
    [ `none
    | `set of string * int
    ]

  val set : ?value:int -> 'a -> [> `set of 'a * int ]
  val toString : [< `none | `set of string * int ] -> string
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

  val toString :
    [< `attr of string
    | `closeQuote
    | `noCloseQuote
    | `noOpenQuote
    | `none
    | `normal
    | `openQuote
    | `text of string
    ] ->
    string
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
    val toString : [< `contextFill | `contextStroke | `none ] -> string
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

  val toString :
    [< `auto
    | `manipulation
    | `none
    | `panDown
    | `panLeft
    | `panRight
    | `panUp
    | `panX
    | `panY
    | `pinchZoom
    ] ->
    string
end

module ZIndex : sig
  type t =
    [ `auto
    | `num of int
    ]

  val toString : [< `auto | `num of int ] -> string
end

module AlphaValue : sig
  type t =
    [ `num of float
    | `percent of float
    ]

  val toString : [< `num of float | `percent of float ] -> string
end

module LineBreak : sig
  type t =
    [ `anywhere
    | `auto
    | `loose
    | `normal
    | `strict
    ]

  val toString : [< `anywhere | `auto | `loose | `normal | `strict ] -> string
end

module Hyphens : sig
  type t =
    [ `auto
    | `manual
    | `none
    ]

  val toString : [< `auto | `manual | `none ] -> string
end

module TextJustify : sig
  type t =
    [ `auto
    | `interCharacter
    | `interWord
    | `none
    ]

  val toString : [< `auto | `interCharacter | `interWord | `none ] -> string
end

module OverflowInline : sig
  type t =
    [ `auto
    | `clip
    | `hidden
    | `scroll
    | `visible
    ]

  val toString : [< `auto | `clip | `hidden | `scroll | `visible ] -> string
end

module FontSynthesisWeight : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module FontSynthesisStyle : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module FontSynthesisSmallCaps : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module FontSynthesisPosition : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module FontKerning : sig
  type t =
    [ `auto
    | `none
    | `normal
    ]

  val toString : [< `auto | `none | `normal ] -> string
end

module FontVariantPosition : sig
  type t =
    [ `normal
    | `sub
    | `super
    ]

  val toString : [< `normal | `sub | `super ] -> string
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

  val toString :
    [< `allPetiteCaps
    | `allSmallCaps
    | `normal
    | `petiteCaps
    | `smallCaps
    | `titlingCaps
    | `unicase
    ] ->
    string
end

module FontOpticalSizing : sig
  type t =
    [ `auto
    | `none
    ]

  val toString : [< `auto | `none ] -> string
end

module FontVariantEmoji : sig
  type t =
    [ `emoji
    | `normal
    | `text
    | `unicode
    ]

  val toString : [< `emoji | `normal | `text | `unicode ] -> string
end
