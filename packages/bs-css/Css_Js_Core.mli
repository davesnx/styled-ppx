module Types = Css_AtomicTypes

type nonrec rule
type nonrec animationName

module type MakeResult = sig
  type nonrec styleEncoding
  type nonrec renderer

  val insertRule : (string -> unit[@bs])
  val renderRule : (renderer -> string -> unit[@bs])
  val global : (string -> rule array -> unit[@bs])
  val renderGlobal : (renderer -> string -> rule array -> unit[@bs])
  val style : (rule array -> styleEncoding[@bs])
  val merge : (styleEncoding array -> styleEncoding[@bs])
  val merge2 : (styleEncoding -> styleEncoding -> styleEncoding[@bs])

  val merge3 :
    (styleEncoding -> styleEncoding -> styleEncoding -> styleEncoding[@bs])

  val merge4 :
    (styleEncoding ->
     styleEncoding ->
     styleEncoding ->
     styleEncoding ->
     styleEncoding
    [@bs])

  val keyframes : ((int * rule array) array -> animationName[@bs])

  val renderKeyframes :
    (renderer -> (int * rule array) array -> animationName[@bs])
end

module Make : functor (C : Css_Core.CssImplementationIntf) ->
  MakeResult
    with type styleEncoding := C.styleEncoding
     and type renderer := C.renderer

val toJson : rule array -> Js.Json.t
val important : rule -> rule
val label : string -> rule

module Shadow : sig
  type nonrec 'a value
  type nonrec box
  type nonrec text

  type nonrec 'a t =
    [ `shadow of 'a value
    | `none
    ]

  val box :
    ?x:Types.Length.t ->
    ?y:Types.Length.t ->
    ?blur:Types.Length.t ->
    ?spread:Types.Length.t ->
    ?inset:bool ->
    [< Types.Color.t | Types.Var.t ] ->
    [> box t ]

  val text :
    ?x:Types.Length.t ->
    ?y:Types.Length.t ->
    ?blur:Types.Length.t ->
    [< Types.Color.t | Types.Var.t ] ->
    [> text t ]

  val toString : 'a t -> string
end

val unsafe : string -> string -> rule

val alignContent :
  [< Types.AlignContent.t
  | Types.NormalAlignment.t
  | Types.BaselineAlignment.t
  | Types.DistributedAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The CSS align-content property sets the distribution of space between \
     and around content items along a flexbox's\n\
    \ cross-axis or a grid's block axis.\n\
    \ "]

val alignItems :
  [< Types.AlignItems.t
  | Types.PositionalAlignment.t
  | Types.BaselineAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The CSS align-items property sets the align-self value on all direct \
     children as a group.\n\
    \ In Flexbox, it controls the alignment of items on the Cross Axis.\n\
    \ In Grid Layout, it controls the alignment of items on the Block Axis \
     within their grid area.\n\
    \ "]

val alignSelf :
  [< Types.AlignSelf.t
  | Types.PositionalAlignment.t
  | Types.BaselineAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The align-self CSS property overrides a grid or flex item's align-items \
     value.\n\
    \ In Grid, it aligns the item inside the grid area. In Flexbox, it aligns \
     the item on the cross axis.\n\
    \ "]

val animationDelay : int -> rule
  [@@ns.doc
    "\n\
    \ The animation-delay CSS property sets when an animation starts.\n\
    \ The animation can start later, immediately from its beginning, or \
     immediately and partway through the animation.\n\
    \ "]

val animationDirection : Types.AnimationDirection.t -> rule
  [@@ns.doc
    "\n\
    \ The animation-direction CSS property sets whether an animation should \
     play forwards, backwards,\n\
    \ or alternating back and forth.\n\
    \ "]

val animationDuration : int -> rule
  [@@ns.doc
    "\n\
    \ The animation-duration CSS property sets the length of time that an \
     animation takes to complete one cycle.\n\
    \ "]

val animationFillMode : Types.AnimationFillMode.t -> rule
  [@@ns.doc
    "\n\
    \ The animation-fill-mode CSS property sets how a CSS animation applies \
     styles to its target before and after\n\
    \ its execution.\n\
    \ "]

val animationIterationCount : Types.AnimationIterationCount.t -> rule
  [@@ns.doc
    "\n\
    \ The animation-iteration-count CSS property sets the number of times an \
     animation cycle should be played\n\
    \ before stopping.\n\
    \ "]

val animationPlayState : Types.AnimationPlayState.t -> rule
  [@@ns.doc
    "\n\
    \ The animation-play-state CSS property sets whether an animation is \
     running or paused.\n\
    \ "]

val animationTimingFunction : Types.TimingFunction.t -> rule
  [@@ns.doc
    "\n\
    \ The animation-timing-function CSS property sets how an animation \
     progresses through the duration of each cycle.\n\
    \ "]

val backdropFilter : Types.BackdropFilter.t array -> rule
  [@@ns.doc
    "\n\
    \ The backdrop-filter CSS property lets you apply graphical effects such \
     as blurring or color shifting to the\n\
    \ area behind an element. Because it applies to everything behind the \
     element, to see the effect you must\n\
    \ make the element or its background at least partially transparent.\n\
    \ "]

val backfaceVisibility :
  [< Types.BackfaceVisibility.t | Types.Var.t | Types.Cascading.t ] -> rule

val backgroundAttachment :
  [< Types.BackgroundAttachment.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The background-attachment CSS property sets whether a background image's \
     position is fixed within the viewport,\n\
    \ or scrolls with its containing block.\n\
    \ "]

val backgroundColor : [< Types.Color.t | Types.Var.t ] -> rule
  [@@ns.doc
    "\n\
    \ The background-color CSS property sets the background color of an element.\n\
    \ "]

val backgroundClip :
  [< Types.BackgroundClip.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The background-clip CSS property sets whether an element's background \
     extends underneath its border box,\n\
    \ padding box, or content box.\n\
    \ "]

val backgroundImage :
  [< Types.BackgroundImage.t | Types.Url.t | 'gradient Types.Gradient.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The background-image CSS property sets one or more background images on \
     an element.\n\
    \ "]

val maskImage :
  [< Types.MaskImage.t | Types.Url.t | 'gradient Types.Gradient.t ] -> rule
  [@@ns.doc
    "\n\
    \ The mask-image CSS property sets the image that is used as mask layer \
     for an element.\n\
    \ By default this means the alpha channel of the mask image will be \
     multiplied with the alpha channel of the element.\n\
    \ This can be controlled with the mask-mode property. "]

val backgroundOrigin :
  [< Types.BackgroundClip.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The background-origin CSS property sets the background's origin: from \
     the border start,\n\
    \ inside the border, or inside the padding.\n\
    \ "]

val backgroundPosition :
  [< Types.BackgroundPosition.t
  | `hv of
    [ Types.BackgroundPosition.X.t | Types.Length.t ]
    * [ Types.BackgroundPosition.Y.t | Types.Length.t ]
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The background-position CSS property sets the initial position for each \
     background image.\n\
    \ The position is relative to the position layer set by background-origin.\n\
    \ "]

val backgroundPositions :
  [< Types.BackgroundPosition.t
  | `hv of
    [ Types.BackgroundPosition.X.t | Types.Length.t ]
    * [ Types.BackgroundPosition.Y.t | Types.Length.t ]
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ]
  array ->
  rule

val backgroundPosition4 :
  x:Types.BackgroundPosition.X.t ->
  offsetX:Types.Length.t ->
  y:Types.BackgroundPosition.Y.t ->
  offsetY:Types.Length.t ->
  rule

val maskPosition :
  [< Types.MaskPosition.t
  | `hv of
    [ Types.MaskPosition.X.t | Types.Length.t ]
    * [ Types.MaskPosition.Y.t | Types.Length.t ]
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The mask-position CSS property sets the initial position, relative to \
     the mask position layer set by mask-origin,\n\
    \ for each defined mask image.\n\
    \ "]

val maskPositions :
  [< Types.MaskPosition.t
  | `hv of
    [ Types.MaskPosition.X.t | Types.Length.t ]
    * [ Types.MaskPosition.Y.t | Types.Length.t ]
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ]
  array ->
  rule

val backgroundRepeat :
  [< Types.BackgroundRepeat.t
  | `hv of Types.BackgroundRepeat.horizontal * Types.BackgroundRepeat.vertical
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The background-repeat CSS property sets how background images are \
     repeated.\n\
    \ A background image can be repeated along the horizontal and vertical \
     axes, or not repeated at all.\n\
    \ "]

val borderBottom :
  Types.Length.t ->
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] ->
  [< Types.Color.t | Types.Var.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The border-bottom shorthand CSS property sets an element's bottom border.\n\
    \ It sets the values of border-bottom-width, border-bottom-style and \
     border-bottom-color.\n\
    \ "]

val borderBottomColor : [< Types.Color.t | Types.Var.t ] -> rule
  [@@ns.doc
    "\n\
    \ The border-bottom-color CSS property sets the color of an element's \
     bottom border.\n\
    \ It can also be set with the shorthand CSS properties border-color or \
     border-bottom.\n\
    \ "]

val borderBottomLeftRadius : Types.Length.t -> rule
  [@@ns.doc
    "\n\
    \ The border-bottom-left-radius CSS property rounds the bottom-left corner \
     of an element.\n\
    \ "]

val borderBottomRightRadius : Types.Length.t -> rule
  [@@ns.doc
    "\n\
    \ The border-bottom-right-radius CSS property rounds the bottom-right \
     corner of an element.\n\
    \ "]

val borderBottomStyle :
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The border-bottom-style CSS property sets the line style of an element's \
     bottom border.\n\
    \ "]

val borderBottomWidth : Types.Length.t -> rule
  [@@ns.doc
    "\n\
    \ The border-bottom-width CSS property sets the width of the bottom border \
     of an element.\n\
    \ "]

val borderCollapse :
  [< Types.BorderCollapse.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The border-collapse CSS property sets whether cells inside a <table> \
     have shared or separate borders.\n\
    \ "]

val borderColor : [< Types.Color.t | Types.Var.t ] -> rule
  [@@ns.doc
    "\n\
    \ The border-color shorthand CSS property sets the color of an element's \
     border.\n\
    \ "]

val borderLeft :
  Types.Length.t ->
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] ->
  [< Types.Color.t | Types.Var.t ] ->
  rule
  [@@ns.doc
    "\n The border-left shorthand CSS property set an element's left border.\n "]

val borderLeftColor : [< Types.Color.t | Types.Var.t ] -> rule

val borderLeftStyle :
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] -> rule

val borderLeftWidth : Types.Length.t -> rule

val borderRight :
  Types.Length.t ->
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] ->
  [< Types.Color.t | Types.Var.t ] ->
  rule

val borderRightColor : [< Types.Color.t | Types.Var.t ] -> rule

val borderRightStyle :
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] -> rule

val borderRightWidth : Types.Length.t -> rule
val borderRadius : Types.Length.t -> rule

val borderRadius4 :
  topLeft:Types.Length.t ->
  topRight:Types.Length.t ->
  bottomLeft:Types.Length.t ->
  bottomRight:Types.Length.t ->
  rule

val borderSpacing : Types.Length.t -> rule

val borderStyle :
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The border-style shorthand CSS property sets the line style for all four \
     sides of an element's border.\n\
    \ "]

val borderTopColor : [< Types.Color.t | Types.Var.t ] -> rule
val borderTopLeftRadius : Types.Length.t -> rule
val borderTopRightRadius : Types.Length.t -> rule

val borderTopStyle :
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] -> rule

val borderTopWidth : Types.Length.t -> rule
val borderWidth : Types.Length.t -> rule

val bottom :
  [< `auto | Types.Length.t | Types.Var.t | Types.Cascading.t ] -> rule

val boxSizing : [< Types.BoxSizing.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The box-sizing CSS property sets how the total width and height of an \
     element is calculated.\n\
    \ "]

val boxShadow :
  [< Shadow.box Shadow.t | Types.Var.t | Types.Cascading.t ] -> rule

val boxShadows : Shadow.box Shadow.t array -> rule

val clear : [< Types.Clear.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The clear CSS property sets whether an element must be moved below \
     (cleared) floating elements that precede it.\n\
    \ The clear property applies to floating and non-floating elements.\n\
    \ "]

val clipPath :
  [< Types.ClipPath.t
  | Types.Url.t
  | Types.GeometryBox.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The clip-path CSS property creates a clipping region that sets what part \
     of an element should be shown.\n\
    \ Parts that are inside the region are shown, while those outside are \
     hidden.\n\
    \ "]

val color : [< Types.Color.t | Types.Var.t ] -> rule

val columnCount : [< Types.ColumnCount.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The column-count CSS property breaks an element's content into the \
     specified number of columns.\n\
    \ "]

val contentRule :
  [< Types.Content.t
  | Types.Counter.t
  | Types.Counters.t
  | 'gradient Types.Gradient.t
  | Types.Url.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule

val contentRules :
  [< Types.Content.t
  | Types.Counter.t
  | Types.Counters.t
  | 'gradient Types.Gradient.t
  | Types.Url.t
  ]
  array ->
  rule

val counterIncrement :
  [< Types.CounterIncrement.t | Types.Var.t | Types.Cascading.t ] -> rule

val countersIncrement : [< Types.CounterIncrement.t ] array -> rule

val counterReset :
  [< Types.CounterReset.t | Types.Var.t | Types.Cascading.t ] -> rule

val countersReset : [< Types.CounterReset.t ] array -> rule

val counterSet :
  [< Types.CounterSet.t | Types.Var.t | Types.Cascading.t ] -> rule

val countersSet : [< Types.CounterSet.t ] array -> rule
val cursor : Types.Cursor.t -> rule

val direction : [< Types.Direction.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The direction CSS property sets the direction of text, table columns, \
     and horizontal overflow.\n\
    \ Use rtl for languages written from right to left (like Hebrew or Arabic),\n\
    \ and ltr for those written from left to right (like English and most \
     other languages).\n\
    \ "]

val display :
  [< Types.DisplayOutside.t
  | Types.DisplayInside.t
  | Types.DisplayListItem.t
  | Types.DisplayInternal.t
  | Types.DisplayBox.t
  | Types.DisplayLegacy.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The display CSS property sets whether an element is treated as a block \
     or inline element\n\
    \ and the layout used for its children, such as grid or flex.\n\
    \ "]

val flex : [< Types.Flex.t | `num of float ] -> rule
  [@@ns.doc
    "\n\
    \ The flex CSS property sets how a flex item will grow or shrink to fit \
     the space available in its flex container.\n\
    \ It is a shorthand for flex-grow, flex-shrink, and flex-basis.\n\
    \ "]

val flexBasis :
  [< Types.FlexBasis.t | Types.Percentage.t | Types.Length.t ] -> rule
  [@@ns.doc
    "\n\
    \ The flex-basis CSS property sets the initial main size of a flex item.\n\
    \ It sets the size of the content box unless otherwise set with box-sizing.\n\
    \ "]

val flexDirection :
  [< Types.FlexDirection.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The flex-direction CSS property sets how flex items are placed in the \
     flex container defining the main axis and the direction (normal or \
     reversed).\n\
    \ "]

val flexGrow : float -> rule
val flexShrink : float -> rule

val flexWrap : [< Types.FlexWrap.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The flex-wrap CSS property sets whether flex items are forced onto one \
     line or can wrap onto multiple lines.\n\
    \ If wrapping is allowed, it sets the direction that lines are stacked.\n\
    \ "]

val float : [< Types.Float.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The float CSS property places an element on the left or right side of \
     its container,\n\
    \ allowing text and inline elements to wrap around it.\n\
    \ The element is removed from the normal flow of the page, though still \
     remaining a part of the flow\n\
    \ (in contrast to absolute positioning).\n\
    \ "]

val fontFamily :
  [< Types.FontFamilyName.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The font-family CSS property specifies a prioritized list of one or more \
     font family names and/or generic family names\n\
    \ for the selected element.\n\
    \ "]

val fontFamilies : Types.FontFamilyName.t array -> rule

val fontSize : [< Types.Length.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The font-size CSS property sets the size of the font. This property is \
     also used to compute the size of em, ex, and\n\
    \ other relative <length> units.\n\
    \ "]

val fontStyle : [< Types.FontStyle.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The font-style CSS property sets whether a font should be styled with a \
     normal, italic, or oblique face from its\n\
    \ font-family.\n\
    \ "]

val fontVariant :
  [< Types.FontVariant.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The font-variant CSS property is a shorthand for the longhand properties \
     font-variant-caps, font-variant-numeric,\n\
    \ font-variant-alternates, font-variant-ligatures, and \
     font-variant-east-asian.\n\
    \ You can also set the CSS Level 2 (Revision 1) values of font-variant, \
     (that is, normal or small-caps),\n\
    \ by using the font shorthand.\n\
    \ "]

val fontWeight :
  [< Types.FontWeight.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The font-weight CSS property sets the weight (or boldness) of the font. \
     The weights available depend on the\n\
    \ font-family you are using.\n\
    \ "]

val gridArea : [< Types.GridArea.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The grid-area CSS property is a shorthand property for grid-row-start, \
     grid-column-start, grid-row-end and\n\
    \ grid-column-end, specifying a grid item's size and location within the \
     grid by contributing a line, a span,\n\
    \ or nothing (automatic) to its grid placement, thereby specifying the \
     edges of its grid area.\n\
    \ "]

val gridArea2 : Types.GridArea.t -> Types.GridArea.t -> rule
val gridArea3 : Types.GridArea.t -> Types.GridArea.t -> Types.GridArea.t -> rule

val gridArea4 :
  Types.GridArea.t ->
  Types.GridArea.t ->
  Types.GridArea.t ->
  Types.GridArea.t ->
  rule

val gridAutoFlow :
  [< Types.GridAutoFlow.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The grid-auto-flow CSS property controls how the auto-placement \
     algorithm works,\n\
    \ specifying exactly how auto-placed items get flowed into the grid.\n\
    \ "]

val gridColumn : int -> int -> rule
  [@@ns.doc
    "\n\
    \ The grid-column CSS property is a shorthand property for \
     grid-column-start and grid-column-end\n\
    \ specifying a grid item's size and location within the grid column by \
     contributing a line, a span,\n\
    \ or nothing (automatic) to its grid placement, thereby specifying the \
     inline-start and\n\
    \ inline-end edge of its grid area.\n\
    \ "]

val gridColumnEnd : int -> rule
  [@@ns.doc
    "\n\
    \ The grid-column-end CSS property specifies a grid item's end position \
     within the grid column by contributing a line,\n\
    \ a span, or nothing (automatic) to its grid placement, thereby specifying \
     the block-end edge of its grid area.\n\
    \ "]

val columnGap :
  [< Types.ColumnGap.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The column-gap CSS property sets the size of the gap (gutter) between an \
     element's columns.\n\
    \ "]

val scrollBehavior :
  [< Types.ScrollBehavior.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The scroll-behavior CSS property sets the behavior for a scrolling box \
     when scrolling is triggered by the navigation\n\
    \ or CSSOM scrolling APIs.\n\
    \ "]

val overscrollBehavior :
  [< Types.OverscrollBehavior.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The overscroll-behavior CSS property sets what a browser does when \
     reaching the boundary of a scrolling area.\n\
    \ "]

val overflowAnchor :
  [< Types.OverflowAnchor.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The overflow-anchor CSS property provides a way to opt out of the \
     browser's scroll anchoring behavior, which adjusts scroll position to \
     minimize content shifts.\n\
    \ Scroll anchoring behavior is enabled by default in any browser that \
     supports it. Therefore, changing the value of this property is typically \
     only required if\n\
    \ you are experiencing problems with scroll anchoring in a document or \
     part of a document and need to turn the behavior off.\n\
    \ "]

val columnWidth :
  [< Types.ColumnWidth.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The column-width CSS property sets the ideal column width in a \
     multi-column layout.\n\
    \ The container will have as many columns as can fit without any of them \
     having a width less than the column-width value.\n\
    \ If the width of the container is narrower than the specified value, the \
     single column's width will be smaller than the declared column width.\n\
    \ "]

val caretColor :
  [< Types.CaretColor.t | Types.Color.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The caret-color CSS property sets the color of the insertion caret, the \
     visible marker where the next character typed will be inserted.\n\
    \ This is sometimes referred to as the text input cursor. The caret \
     appears in elements such as <input> or those with the contenteditable \
     attribute.\n\
    \ The caret is typically a thin vertical line that flashes to help make it \
     more noticeable. By default, it is black, but its color can be altered \
     with this property.\n\
    \ "]

val gridColumnGap :
  [< Types.ColumnGap.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc "\n This prefixed property is being replaced by column-gap.\n "]

val gridColumnStart : int -> rule
  [@@ns.doc
    "\n\
    \ The grid-column-start CSS property specifies a grid item's start \
     position within the grid column\n\
    \ by contributing a line, a span, or nothing (automatic) to its grid \
     placement.\n\
    \ This start position defines the block-start edge of the grid area.\n\
    \ "]

val gap :
  [< Types.Gap.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The gap CSS property sets the gaps (gutters) between rows and columns. \
     It is a shorthand for row-gap and column-gap.\n\
    \ "]

val gap2 :
  rowGap:
    [< Types.Gap.t
    | Types.Percentage.t
    | Types.Length.t
    | Types.Var.t
    | Types.Cascading.t
    ] ->
  columnGap:
    [< Types.Gap.t
    | Types.Percentage.t
    | Types.Length.t
    | Types.Var.t
    | Types.Cascading.t
    ] ->
  rule

val gridGap :
  [< Types.Gap.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc "\n deprecated, use gap\n "]

val gridRow : int -> int -> rule
  [@@ns.doc
    "\n\
    \ The grid-row CSS property is a shorthand property for grid-row-start and \
     grid-row-end specifying a grid item's size\n\
    \ and location within the grid row by contributing a line, a span, or \
     nothing (automatic) to its grid placement,\n\
    \ thereby specifying the inline-start and inline-end edge of its grid area.\n\
    \ "]

val gridRowEnd : int -> rule
  [@@ns.doc
    "\n\
    \ The grid-row-end CSS property specifies a grid item's end position \
     within the grid row by contributing a line, a span,\n\
    \ or nothing (automatic) to its grid placement, thereby specifying the \
     inline-end edge of its grid area.\n\
    \ "]

val gridRowGap :
  [< Types.Percentage.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The row-gap CSS property sets the size of the gap (gutter) between an \
     element's grid rows.\n\
    \ "]

val rowGap :
  [< Types.RowGap.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The row-gap CSS property sets the size of the gap (gutter) between an \
     element's grid rows.\n\
    \ "]

val gridRowStart : int -> rule
  [@@ns.doc
    "\n\
    \ The grid-row-start CSS property specifies a grid item?s start position \
     within the grid row by contributing a line,\n\
    \ a span, or nothing (automatic) to its grid placement, thereby specifying \
     the inline-start edge of its grid area.\n\
    \ "]

val gridTemplateAreas :
  [< Types.GridTemplateAreas.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n The grid-template-areas CSS property specifies named grid areas.\n "]

val height :
  [< Types.Height.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The height CSS property specifies the height of an element.\n\
    \ By default, the property defines the height of the content area.\n\
    \ If box-sizing is set to border-box, however, it instead determines the \
     height of the border area.\n\
    \ "]

val justifyContent :
  [< Types.PositionalAlignment.t
  | Types.NormalAlignment.t
  | Types.DistributedAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The CSS justify-content property defines how the browser distributes \
     space between and around content items\n\
    \ along the main-axis of a flex container, and the inline axis of a grid \
     container.\n\
    \ "]

val justifyItems :
  [< Types.PositionalAlignment.t
  | Types.NormalAlignment.t
  | Types.BaselineAlignment.t
  | Types.OverflowAlignment.t
  | Types.LegacyAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The CSS justify-items property defines the default justify-self for all \
     items of the box, giving them all\n\
    \ a default way of justifying each box along the appropriate axis.\n\
    \ "]

val justifySelf :
  [< Types.JustifySelf.t
  | Types.PositionalAlignment.t
  | Types.BaselineAlignment.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The CSS justify-self property sets the way a box is justified inside its \
     alignment container along the appropriate axis.\n\
    \ "]

val left : [< `auto | Types.Length.t | Types.Var.t | Types.Cascading.t ] -> rule

val letterSpacing :
  [< Types.LetterSpacing.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The letter-spacing CSS property sets the spacing behavior between text \
     characters\n\
    \ "]

val lineHeight :
  [< Types.LineHeight.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The line-height CSS property sets the height of a line box. It's \
     commonly used to set the distance between lines of text.\n\
    \ On block-level elements, it specifies the minimum height of line boxes \
     within the element.\n\
    \ On non-replaced inline elements, it specifies the height that is used to \
     calculate line box height.\n\
    \ "]

val listStyle :
  Types.ListStyleType.t ->
  Types.ListStylePosition.t ->
  [< Types.ListStyleImage.t | Types.Url.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The list-style CSS property is a shorthand to set list style properties \
     list-style-type,\n\
    \ list-style-image, and list-style-position.\n\
    \ "]

val listStyleImage :
  [< Types.ListStyleImage.t | Types.Url.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The list-style-image CSS property sets an image to be used as the list \
     item marker.\n\
    \ It is often more convenient to use the shorthand list-style.\n\
    \ "]

val listStyleType :
  [< Types.ListStyleType.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The list-style-type CSS property sets the marker (such as a disc, \
     character, or custom counter style) of a list item element.\n\
    \ "]

val listStylePosition :
  [< Types.ListStylePosition.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The list-style-position CSS property sets the position of the ::marker \
     relative to a list item.\n\
    \ "]

val margin : [< Types.Length.t | Types.Margin.t ] -> rule

val margin2 :
  v:[< Types.Length.t | Types.Margin.t ] ->
  h:[< Types.Length.t | Types.Margin.t ] ->
  rule

val margin3 :
  top:[< Types.Length.t | Types.Margin.t ] ->
  h:[< Types.Length.t | Types.Margin.t ] ->
  bottom:[< Types.Length.t | Types.Margin.t ] ->
  rule

val margin4 :
  top:[< Types.Length.t | Types.Margin.t ] ->
  right:[< Types.Length.t | Types.Margin.t ] ->
  bottom:[< Types.Length.t | Types.Margin.t ] ->
  left:[< Types.Length.t | Types.Margin.t ] ->
  rule

val marginLeft :
  [< Types.Length.t | Types.Margin.t | Types.Var.t | Types.Cascading.t ] -> rule

val marginRight :
  [< Types.Length.t | Types.Margin.t | Types.Var.t | Types.Cascading.t ] -> rule

val marginTop :
  [< Types.Length.t | Types.Margin.t | Types.Var.t | Types.Cascading.t ] -> rule

val marginBottom :
  [< Types.Length.t | Types.Margin.t | Types.Var.t | Types.Cascading.t ] -> rule

val maxHeight :
  [< Types.Height.t
  | Types.MaxHeight.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The max-height CSS property sets the maximum height of an element.\n\
    \ It prevents the used value of the height property from becoming larger \
     than the value specified for max-height.\n\
    \ "]

val maxWidth :
  [< Types.Width.t
  | Types.MaxWidth.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The max-width CSS property sets the maximum width of an element.\n\
    \ It prevents the used value of the width property from becoming larger \
     than the value specified by max-width.\n\
    \ "]

val minHeight :
  [< Types.Height.t
  | Types.MinHeight.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The min-height CSS property sets the minimum height of an element.\n\
    \ It prevents the used value of the height property from becoming smaller \
     than the value specified for min-height.\n\
    \ "]

val minWidth :
  [< Types.Width.t
  | Types.MinWidth.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The min-width CSS property sets the minimum width of an element.\n\
    \ It prevents the used value of the width property from becoming smaller \
     than the value specified for min-width.\n\
    \ "]

val objectFit : [< Types.ObjectFit.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The object-fit CSS property sets how the content of a replaced element,\n\
    \ such as an <img> or <video>, should be resized to fit its container.\n\
    \ "]

val objectPosition :
  [< Types.BackgroundPosition.t
  | `hv of
    [ Types.BackgroundPosition.X.t | Types.Length.t ]
    * [ Types.BackgroundPosition.Y.t | Types.Length.t ]
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule

val opacity : float -> rule
val order : int -> rule

val outline :
  Types.Length.t ->
  Types.OutlineStyle.t ->
  [< Types.Color.t | Types.Var.t ] ->
  rule

val outlineColor : [< Types.Color.t | Types.Var.t ] -> rule
val outlineOffset : Types.Length.t -> rule
val outlineStyle : Types.OutlineStyle.t -> rule
val outlineWidth : Types.Length.t -> rule
val overflow : Types.Overflow.t -> rule
val overflowX : Types.Overflow.t -> rule
val overflowY : Types.Overflow.t -> rule

val overflowWrap :
  [< Types.OverflowWrap.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The overflow-wrap CSS property applies to inline elements, setting \
     whether the browser\n\
    \ should insert line breaks within an otherwise unbreakable string to \
     prevent text\n\
    \ from overflowing its line box.\n\
    \ "]

val padding : Types.Length.t -> rule
val padding2 : v:Types.Length.t -> h:Types.Length.t -> rule

val padding3 :
  top:Types.Length.t -> h:Types.Length.t -> bottom:Types.Length.t -> rule

val padding4 :
  top:Types.Length.t ->
  right:Types.Length.t ->
  bottom:Types.Length.t ->
  left:Types.Length.t ->
  rule

val paddingLeft : Types.Length.t -> rule
val paddingRight : Types.Length.t -> rule
val paddingTop : Types.Length.t -> rule
val paddingBottom : Types.Length.t -> rule

val perspective :
  [< Types.Perspective.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The perspective CSS property determines the distance between the z=0 \
     plane and the user in order\n\
    \ to give a 3D-positioned element some perspective.\n\
    \ Each 3D element with z>0 becomes larger; each 3D-element with z<0 \
     becomes smaller.\n\
    \ The strength of the effect is determined by the value of this property.\n\
    \ "]

val perspectiveOrigin :
  [< Types.Perspective.t | Types.Length.t ] ->
  [< Types.Perspective.t | Types.Length.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The perspective-origin CSS property determines the position at which the \
     viewer is looking.\n\
    \ It is used as the vanishing point by the perspective property.\n\
    \ "]

val pointerEvents :
  [< Types.PointerEvents.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The pointer-events CSS property sets under what circumstances (if any) a \
     particular graphic element can become the target of pointer events.\n\
    \ "]

val position : [< Types.Position.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The position CSS property sets how an element is positioned in a document.\n\
    \ The top, right, bottom, and left properties determine the final location \
     of positioned elements.\n\
    \ "]

val isolation : [< Types.Isolation.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The isolation CSS property determines whether an element must create a \
     new stacking context.\n\
    \ "]

val resize : [< Types.Resize.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The resize CSS property sets whether an element is resizable, and if so,\n\
    \ in which directions.\n\
    \ "]

val right :
  [< `auto | Types.Length.t | Types.Var.t | Types.Cascading.t ] -> rule

val tableLayout :
  [< Types.TableLayout.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The table-layout CSS property sets the algorithm used to lay out <table> \
     cells, rows, and columns.\n\
    \ "]

val textAlign : [< Types.TextAlign.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-align CSS property sets the horizontal alignment of a block \
     element or table-cell box.\n\
    \ This means it works like vertical-align but in the horizontal direction.\n\
    \ "]

val textDecorationColor :
  [< Types.Color.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-decoration-color CSS property sets the color of decorations \
     added to text by text-decoration-line.\n\
    \ "]

val textDecorationLine :
  [< Types.TextDecorationLine.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-decoration-line CSS property sets the kind of decoration\n\
    \ that is used on text in an element, such as an underline or overline.\n\
    \ "]

val textDecorationStyle :
  [< Types.TextDecorationStyle.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-decoration-style CSS property sets the style of the lines \
     specified by text-decoration-line.\n\
    \ The style applies to all lines that are set with text-decoration-line.\n\
    \ "]

val textIndent :
  [< Types.Percentage.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The text-indent CSS property sets the length of empty space (indentation)\n\
    \ that is put before lines of text in a block.\n\
    \ "]

val textOverflow :
  [< Types.TextOverflow.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-overflow CSS property sets how hidden overflow content is \
     signaled to users.\n\
    \ It can be clipped, display an ellipsis ('...'), or display a custom \
     string.\n\
    \ "]

val textShadow :
  [< Shadow.text Shadow.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-shadow CSS property adds shadows to text.\n\
    \ It accepts a comma-separated list of shadows to be applied to the text \
     and any of its decorations.\n\
    \ Each shadow is described by some combination of X and Y offsets from the \
     element, blur radius, and color.\n\
    \ "]

val textShadows : Shadow.text Shadow.t array -> rule

val textTransform :
  [< Types.TextTransform.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The text-transform CSS property specifies how to capitalize an element's \
     text.\n\
    \ It can be used to make text appear in all-uppercase or all-lowercase, or \
     with each word capitalized.\n\
    \ "]

val top : [< `auto | Types.Length.t | Types.Var.t | Types.Cascading.t ] -> rule
val transform : [< `none | Types.Transform.t ] -> rule
val transforms : Types.Transform.t array -> rule

val transformOrigin : Types.Length.t -> Types.Length.t -> rule
  [@@ns.doc
    "\n\
    \ The transform-origin CSS property sets the origin for an element's \
     transformations.\n\
    \ "]

val transformOrigin3d :
  Types.Length.t -> Types.Length.t -> Types.Length.t -> rule

val transitionDelay : int -> rule
val transitionDuration : int -> rule
val transitionProperty : string -> rule

val transformStyle :
  [< Types.TransformStyle.t | Types.Var.t | Types.Cascading.t ] -> rule

val transitionTimingFunction : Types.TimingFunction.t -> rule

val userSelect :
  [< Types.UserSelect.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The user-select CSS property controls whether the user can select text.\n\
    \ This doesn't have any effect on content loaded as chrome, except in \
     textboxes.\n\
    \ "]

val verticalAlign :
  [< Types.VerticalAlign.t | Types.Length.t | Types.Var.t | Types.Cascading.t ] ->
  rule
  [@@ns.doc
    "\n\
    \ The vertical-align CSS property sets vertical alignment of an inline or \
     table-cell box.\n\
    \ "]

val visibility :
  [< Types.Visibility.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The visibility CSS property shows or hides an element without changing \
     the layout of a document.\n\
    \ The property can also hide rows or columns in a <table>.\n\
    \ "]

val width :
  [< Types.Width.t
  | Types.Percentage.t
  | Types.Length.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The width CSS property sets an element's width.\n\
    \ By default, it sets the width of the content area, but if box-sizing is \
     set to border-box,\n\
    \ it sets the width of the border area.\n\
    \ "]

val whiteSpace :
  [< Types.WhiteSpace.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The white-space CSS property sets how white space inside an element is \
     handled.\n\
    \ "]

val wordBreak : [< Types.WordBreak.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc
    "\n\
    \ The word-break CSS property sets whether line breaks appear wherever the \
     text would otherwise overflow its content box.\n\
    \ "]

val wordSpacing :
  [< Types.WordSpacing.t
  | Types.Length.t
  | Types.Percentage.t
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule
  [@@ns.doc
    "\n\
    \ The word-spacing CSS property sets the length of space between words and \
     between tags\n\
    \ "]

val wordWrap :
  [< Types.OverflowWrap.t | Types.Var.t | Types.Cascading.t ] -> rule
  [@@ns.doc "\n see overflowWrap\n "]

val zIndex : int -> rule
  [@@ns.doc
    "\n\
    \ The z-index CSS property sets the z-order of a positioned element and \
     its descendants or flex items.\n\
    \ Overlapping elements with a larger z-index cover those with a smaller one.\n\
    \ "]

val selector : (string -> rule array -> rule[@bs])
val media : (string -> rule array -> rule[@bs])

val active : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :active CSS pseudo-class represents an element (such as a button) \
     that is being activated by the user.\n\
    \ When using a mouse, \"activation\" typically starts when the user \
     presses down the primary mouse button.\n\
    \ "]

val checked : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :checked CSS pseudo-class selector represents any radio (<input \
     type=\"radio\">), checkbox (<input type=\"checkbox\">),\n\
    \ or option (<option> in a <select>) element that is checked or toggled to \
     an on state.\n\
    \ "]

val default : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :default CSS pseudo-class selects form elements that are the default \
     in a group of related elements.\n\
    \ "]

val defined : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :defined CSS pseudo-class represents any element that has been \
     defined.\n\
    \ This includes any standard element built in to the browser, and custom \
     elements that have been successfully defined\n\
    \ (i.e. with the CustomElementRegistry.define() method).\n\
    \ "]

val disabled : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :disabled CSS pseudo-class represents any disabled element.\n\
    \ An element is disabled if it can't be activated (selected, clicked on, \
     typed into, etc.) or accept focus.\n\
    \ The element also has an enabled state, in which it can be activated or \
     accept focus.\n\
    \ "]

val empty : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :empty CSS pseudo-class represents any element that has no children.\n\
    \ Children can be either element nodes or text (including whitespace).\n\
    \ Comments, processing instructions, and CSS content do not affect whether \
     an element is considered empty.\n\
    \ "]

val enabled : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :enabled CSS pseudo-class represents any enabled element.\n\
    \ An element is enabled if it can be activated (selected, clicked on, \
     typed into, etc.) or accept focus.\n\
    \ The element also has a disabled state, in which it can't be activated or \
     accept focus.\n\
    \ "]

val first : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :first CSS pseudo-class, used with the  @page at-rule, represents \
     the first page of a printed document.\n\
    \ "]

val firstChild : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :first-child CSS pseudo-class represents the first element among a \
     group of sibling elements.\n\
    \ "]

val firstOfType : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :first-of-type CSS pseudo-class represents the first element of its \
     type among a group of sibling elements.\n\
    \ "]

val focus : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :focus CSS pseudo-class represents an element (such as a form input) \
     that has received focus.\n\
    \ It is generally triggered when the user clicks or taps on an element or \
     selects it with the keyboard's \"tab\" key.\n\
    \ "]

val focusVisible : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :focus-visible CSS pseudo-class represents an element that has \
     received focus via a keyboard event\n\
    \ "]

val focusWithin : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :focus-within CSS pseudo-class represents an element that has \
     received focus or contains an element\n\
    \ that has received focus. In other words, it represents an element that \
     is itself matched by the :focus pseudo-class or has a descendant that is \
     matched by :focus.\n\
    \  (This includes descendants in shadow trees.)\n\
    \ "]

val host : ?selector:string -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :host CSS pseudo-class selects the shadow host of the shadow DOM \
     containing the CSS it is used inside\n\
    \ - in other words, this allows you to select a custom element from inside \
     its shadow DOM.\n\
    \ "]

val hover : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :hover CSS pseudo-class matches when the user interacts with an \
     element with a pointing device,\n\
    \ but does not necessarily activate it.\n\
    \ It is generally triggered when the user hovers over an element with the \
     cursor (mouse pointer).\n\
    \ "]

val indeterminate : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :indeterminate CSS pseudo-class represents any form element whose \
     state is indeterminate.\n\
    \ "]

val inRange : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :in-range CSS pseudo-class represents an <input> element whose \
     current value is\n\
    \ within the range limits specified by the min and max attributes.\n\
    \ "]

val invalid : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :invalid CSS pseudo-class represents any <input> or other <form> \
     element whose contents fail to validate.\n\
    \ "]

val lang : string -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :lang() CSS pseudo-class matches elements based on the language they \
     are determined to be in.\n\
    \ "]

val lastChild : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :last-child CSS pseudo-class represents the last element among a \
     group of sibling elements.\n\
    \ "]

val lastOfType : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :last-of-type CSS pseudo-class represents the last element of its \
     type among a group of sibling elements.\n\
    \ "]

val link : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :link CSS pseudo-class represents an element that has not yet been \
     visited.\n\
    \ It matches every unvisited <a>, <area>, or <link> element that has an \
     href attribute.\n\
    \ "]

val not_ : string -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :not() CSS pseudo-class represents elements that do not match a list \
     of selectors.\n\
    \ Since it prevents specific items from being selected, it is known as the \
     negation pseudo-class.\n\
    \ "]

module Nth : sig
  type nonrec t =
    [ `odd
    | `even
    | `n of int
    | `add of int * int
    ]

  val toString : t -> string
end

val nthChild : Nth.t -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :nth-child() CSS pseudo-class matches elements based on their \
     position in a group of siblings.\n\
    \ "]

val nthLastChild : Nth.t -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :nth-last-child() CSS pseudo-class matches elements based on their \
     position among a group of siblings,\n\
    \ counting from the end.\n\
    \ "]

val nthLastOfType : Nth.t -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :nth-last-of-type() CSS pseudo-class matches elements of a given type,\n\
    \ based on their position among a group of siblings, counting from the end.\n\
    \ "]

val nthOfType : Nth.t -> rule array -> rule
  [@@ns.doc
    "\n\
    \ The :nth-of-type() CSS pseudo-class matches elements of a given type,\n\
    \ based on their position among a group of siblings.\n\
    \ "]

val onlyChild : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :only-child CSS pseudo-class represents an element without any \
     siblings.\n\
    \ This is the same as :first-child:last-child or \
     :nth-child(1):nth-last-child(1),\n\
    \ but with a lower specificity.\n\
    \ "]

val onlyOfType : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :only-of-type CSS pseudo-class represents an element that has no \
     siblings of the same type.\n\
    \ "]

val optional : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :optional CSS pseudo-class represents any <input>, <select>,\n\
    \ or <textarea> element that does not have the required attribute set on it.\n\
    \ "]

val outOfRange : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :out-of-range CSS pseudo-class represents an <input> element whose \
     current value\n\
    \ is outside the range limits specified by the min and max attributes.\n\
    \ "]

val readOnly : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :read-only CSS pseudo-class represents an element (such as input or \
     textarea)\n\
    \ that is not editable by the user.\n\
    \ "]

val readWrite : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :read-write CSS pseudo-class represents an element (such as input or \
     textarea)\n\
    \ that is editable by the user.\n\
    \ "]

val required : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :required CSS pseudo-class represents any <input>, <select>, or \
     <textarea> element\n\
    \ that has the required attribute set on it.\n\
    \ "]

val root : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :root CSS pseudo-class matches the root element of a tree \
     representing the document.\n\
    \ In HTML, :root represents the <html> element and is identical to the \
     selector html,\n\
    \ except that its specificity is higher.\n\
    \ "]

val scope : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :scope CSS pseudo-class represents elements that are a reference \
     point for selectors to match against.\n\
    \ "]

val target : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :target CSS pseudo-class represents a unique element (the target \
     element) with an id matching\n\
    \ the URL's fragment.\n\
    \ "]

val valid : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :valid CSS pseudo-class represents any <input> or other <form> \
     element whose contents validate successfully.\n\
    \ This allows to easily make valid fields adopt an appearance that helps \
     the user confirm that their data is formatted properly.\n\
    \ "]

val visited : rule array -> rule
  [@@ns.doc
    "\n\
    \ The :visited CSS pseudo-class represents links that the user has already \
     visited.\n\
    \ For privacy reasons, the styles that can be modified using this selector \
     are very limited.\n\
    \ "]

val after : rule array -> rule
  [@@ns.doc
    "\n\
    \ ::after creates a pseudo-element that is the last child of the selected \
     element.\n\
    \ It is often used to add cosmetic content to an element with the content \
     property. It is inline by default.\n\
    \ "]

val before : rule array -> rule
  [@@ns.doc
    "\n\
    \ ::before creates a pseudo-element that is the first child of the \
     selected element.\n\
    \ It is often used to add cosmetic content to an element with the content \
     property. It is inline by default.\n\
    \ "]

val firstLetter : rule array -> rule
  [@@ns.doc
    "\n\
    \ The ::first-letter CSS pseudo-element applies styles to the first letter \
     of the first line of a block-level element,\n\
    \ but only when not preceded by other content (such as images or inline \
     tables).\n\
    \ "]

val firstLine : rule array -> rule
  [@@ns.doc
    "\n\
    \ The ::first-line CSS pseudo-element applies styles to the first line of \
     a block-level element.\n\
    \ Note that the length of the first line depends on many factors, \
     including the width of the element,\n\
    \ the width of the document, and the font size of the text.\n\
    \ "]

val placeholder : rule array -> rule
  [@@ns.doc
    "\n\
    \ The ::placeholder CSS pseudo-element represents the placeholder text in \
     an <input> or <textarea> element.\n\
    \ "]

val selection : rule array -> rule
  [@@ns.doc
    "\n\
    \ The ::selection CSS pseudo-element applies styles to the part of a \
     document that has been highlighted by the user\n\
    \ (such as clicking and dragging the mouse across text).\n\
    \ "]

val child : string -> rule array -> rule
  [@@ns.doc "\n Combinators selectors\n "]
  [@@ns.doc
    "\n\
    \ The > combinator selects nodes that are direct children of the first \
     element.\n\
    \ "]

val children : rule array -> rule
  [@@ns.doc
    "\n\
    \ The > * combinator selects all nodes that are direct children of the \
     first element.\n\
    \ "]

val directSibling : rule array -> rule
  [@@ns.doc
    "\n\
    \ The + combinator selects adjacent siblings.\n\
    \ This means that the second element directly follows the first, and both \
     share the same parent.\n\
    \ "]

val siblings : rule array -> rule
  [@@ns.doc
    "\n\
    \ The ~ combinator selects siblings.\n\
    \ This means that the second element follows the first (though not \
     necessarily immediately),\n\
    \ and both share the same parent.\n\
    \ "]

val anyLink : rule array -> rule
val initial : [> Types.Cascading.t ]
val inherit_ : [> Types.Cascading.t ]
val unset : [> Types.Cascading.t ]
val var : string -> [> Types.Var.t ]
val varDefault : string -> string -> [> Types.Var.t ]
val auto : [> `auto ]
val none : [> `none ]
val text : [> `text ]
val pct : float -> [> Types.Percentage.t ]
val ch : float -> [> `ch of float ]
val cm : float -> [> `cm of float ]
val em : float -> [> `em of float ]
val ex : float -> [> `ex of float ]
val mm : float -> [> `mm of float ]
val pt : int -> [> `pt of int ]
val px : int -> [> `px of int ]
val pxFloat : float -> [> `pxFloat of float ]
val rem : float -> [> `rem of float ]
val vh : float -> [> `vh of float ]
val vmin : float -> [> `vmin of float ]
val vmax : float -> [> `vmax of float ]
val zero : [> `zero ]
val deg : float -> Types.Angle.t
val rad : float -> Types.Angle.t
val grad : float -> Types.Angle.t
val turn : float -> Types.Angle.t
val ltr : [> Types.Direction.t ]
val rtl : [> Types.Direction.t ]
val absolute : [> Types.Position.t ]
val relative : [> Types.Position.t ]
val static : [> Types.Position.t ]
val fixed : [> `fixed ]
val sticky : [> Types.Position.t ]
val isolate : [> `isolate ]
val horizontal : [> Types.Resize.t ]
val vertical : [> Types.Resize.t ]
val smallCaps : [> Types.FontVariant.t ]
val italic : [> Types.FontStyle.t ]
val oblique : [> Types.FontStyle.t ]
val hidden : [> `hidden ]
val visible : [> `visible ]
val scroll : [> `scroll ]
val rgb : int -> int -> int -> [> Types.Color.t ]

val rgba :
  int ->
  int ->
  int ->
  [ `num of float | `percent of float ] ->
  [> Types.Color.t ]

val hsl :
  Types.Angle.t ->
  Types.Percentage.t ->
  Types.Percentage.t ->
  [> Types.Color.t ]

val hsla :
  Types.Angle.t ->
  Types.Percentage.t ->
  Types.Percentage.t ->
  [ `num of float | `percent of float ] ->
  [> Types.Color.t ]

val hex : string -> [> Types.Color.t ]
val transparent : [> Types.Color.t ]
val currentColor : [> Types.Color.t ]
val local : [> `local ]
val paddingBox : [> `paddingBox ]
val borderBox : [> `borderBox ]
val contentBox : [> `contentBox ]
val noRepeat : [> `noRepeat ]
val space : [> `space ]
val repeat : [> `repeat ]
val minmax : [> `minmax ]
val repeatX : [> `repeatX ]
val repeatY : [> `repeatY ]
val contain : [> `contain ]
val cover : [> `cover ]
val row : [> `row ]
val rowReverse : [> `rowReverse ]
val column : [> `column ]
val columnReverse : [> `columnReverse ]
val wrap : [> `wrap ]
val nowrap : [> `nowrap ]
val wrapReverse : [> `wrapReverse ]
val inline : [> `inline ]
val block : [> `block ]
val contents : [> `contents ]
val flexBox : [> `flex ]
val grid : [> `grid ]
val inlineBlock : [> `inlineBlock ]
val inlineFlex : [> `inlineFlex ]
val inlineGrid : [> `inlineGrid ]
val inlineTable : [> `inlineTable ]
val listItem : [> `listItem ]
val runIn : [> `runIn ]
val table : [> `table ]
val tableCaption : [> `tableCaption ]
val tableColumnGroup : [> `tableColumnGroup ]
val tableHeaderGroup : [> `tableHeaderGroup ]
val tableFooterGroup : [> `tableFooterGroup ]
val tableRowGroup : [> `tableRowGroup ]
val tableCell : [> `tableCell ]
val tableColumn : [> `tableColumn ]
val tableRow : [> `tableRow ]
val flexStart : [> `flexStart ]
val flexEnd : [> `flexEnd ]
val center : [> `center ]
val stretch : [> `stretch ]
val spaceBetween : [> `spaceBetween ]
val spaceAround : [> `spaceAround ]
val spaceEvenly : [> `spaceEvenly ]
val baseline : [> `baseline ]
val forwards : [> `forwards ]
val backwards : [> `backwards ]
val both : [> `both ]
val infinite : [> `infinite ]
val count : int -> [> `count of int ]
val paused : [> `paused ]
val running : [> `running ]
val inside : [> `inside ]
val outside : [> `outside ]
val solid : [> `solid ]
val dotted : [> `dotted ]
val dashed : [> `dashed ]
val underline : [> `underline ]
val overline : [> `overline ]
val lineThrough : [> `lineThrough ]
val clip : [> `clip ]
val ellipsis : [> `ellipsis ]
val wavy : [> `wavy ]
val double : [> `double ]
val uppercase : [> `uppercase ]
val lowercase : [> `lowercase ]
val capitalize : [> `capitalize ]
val sub : [> `sub ]
val super : [> `super ]
val textTop : [> `textTop ]
val textBottom : [> `textBottom ]
val middle : [> `middle ]
val normal : [> `normal ]
val breakAll : [> `breakAll ]
val keepAll : [> `keepAll ]
val breakWord : [> `breakWord ]
val reverse : [> `reverse ]
val alternate : [> `alternate ]
val alternateReverse : [> `alternateReverse ]
val fill : [> `fill ]
val content : [> `content ]
val maxContent : [> `maxContent ]
val minContent : [> `minContent ]
val fitContent : [> `fitContent ]
val all : [> `all ]
val round : [> `round ]
val miter : [> `miter ]
val bevel : [> `bevel ]
val butt : [> `butt ]
val square : [> `square ]
val panX : [> `panX ]
val panY : [> `panY ]
val panLeft : [> `panLeft ]
val panRight : [> `panRight ]
val panUp : [> `panUp ]
val panDown : [> `panDown ]
val pinchZoom : [> `pinchZoom ]
val manipulation : [> `manipulation ]
val thin : [> Types.FontWeight.t ]
val extraLight : [> Types.FontWeight.t ]
val light : [> Types.FontWeight.t ]
val medium : [> Types.FontWeight.t ]
val semiBold : [> Types.FontWeight.t ]
val bold : [> Types.FontWeight.t ]
val extraBold : [> Types.FontWeight.t ]
val lighter : [> Types.FontWeight.t ]
val bolder : [> Types.FontWeight.t ]
val fr : float -> [> `fr of float ]
val vw : float -> [> `vw of float ]
val localUrl : string -> [> `localUrl of string ]
val url : string -> [> `url of string ]
val linear : [> Types.TimingFunction.t ]
val ease : [> Types.TimingFunction.t ]
val easeIn : [> Types.TimingFunction.t ]
val easeOut : [> Types.TimingFunction.t ]
val easeInOut : [> Types.TimingFunction.t ]
val stepStart : [> Types.TimingFunction.t ]
val stepEnd : [> Types.TimingFunction.t ]
val steps : int -> [ `start | `end_ ] -> [> Types.TimingFunction.t ]

val cubicBezier :
  float -> float -> float -> float -> [> Types.TimingFunction.t ]

val marginBox : [> Types.GeometryBox.t ]
val fillBox : [> Types.GeometryBox.t ]
val strokeBox : [> Types.GeometryBox.t ]
val viewBox : [> Types.GeometryBox.t ]
val translate : Types.Length.t -> Types.Length.t -> [> Types.Transform.t ]

val translate3d :
  Types.Length.t -> Types.Length.t -> Types.Length.t -> [> Types.Transform.t ]

val translateX : Types.Length.t -> [> Types.Transform.t ]
val translateY : Types.Length.t -> [> Types.Transform.t ]
val translateZ : Types.Length.t -> [> Types.Transform.t ]
val scale : float -> float -> [> Types.Transform.t ]
val scale3d : float -> float -> float -> [> Types.Transform.t ]
val scaleX : float -> [> Types.Transform.t ]
val scaleY : float -> [> Types.Transform.t ]
val scaleZ : float -> [> Types.Transform.t ]
val rotate : Types.Angle.t -> [> Types.Transform.t ]

val rotate3d :
  float -> float -> float -> Types.Angle.t -> [> Types.Transform.t ]

val rotateX : Types.Angle.t -> [> Types.Transform.t ]
val rotateY : Types.Angle.t -> [> Types.Transform.t ]
val rotateZ : Types.Angle.t -> [> Types.Transform.t ]
val skew : Types.Angle.t -> Types.Angle.t -> [> Types.Transform.t ]
val skewX : Types.Angle.t -> [> Types.Transform.t ]
val skewY : Types.Angle.t -> [> Types.Transform.t ]

val linearGradient :
  Types.Angle.t ->
  (Types.Length.t * ([< Types.Color.t | Types.Var.t ] as 'colorOrVar)) array ->
  [> 'colorOrVar Types.Gradient.t ]

val repeatingLinearGradient :
  Types.Angle.t ->
  (Types.Length.t * ([< Types.Color.t | Types.Var.t ] as 'colorOrVar)) array ->
  [> 'colorOrVar Types.Gradient.t ]

val radialGradient :
  (Types.Length.t * ([< Types.Color.t | Types.Var.t ] as 'colorOrVar)) array ->
  [> 'colorOrVar Types.Gradient.t ]

val repeatingRadialGradient :
  (Types.Length.t * ([< Types.Color.t | Types.Var.t ] as 'colorOrVar)) array ->
  [> 'colorOrVar Types.Gradient.t ]

val conicGradient :
  Types.Angle.t ->
  (Types.Length.t * ([< Types.Color.t | Types.Var.t ] as 'colorOrVar)) array ->
  [> 'colorOrVar Types.Gradient.t ]

val areas : string array -> [> Types.GridTemplateAreas.t ]
val ident : string -> [> Types.GridArea.t ]
val numIdent : int -> string -> [> Types.GridArea.t ]
val contextMenu : [> Types.Cursor.t ]
val help : [> Types.Cursor.t ]
val pointer : [> Types.Cursor.t ]
val progress : [> Types.Cursor.t ]
val wait : [> Types.Cursor.t ]
val cell : [> Types.Cursor.t ]
val crosshair : [> Types.Cursor.t ]
val verticalText : [> Types.Cursor.t ]
val alias : [> Types.Cursor.t ]
val copy : [> Types.Cursor.t ]
val move : [> Types.Cursor.t ]
val noDrop : [> Types.Cursor.t ]
val notAllowed : [> Types.Cursor.t ]
val grab : [> Types.Cursor.t ]
val grabbing : [> Types.Cursor.t ]
val allScroll : [> Types.Cursor.t ]
val colResize : [> Types.Cursor.t ]
val rowResize : [> Types.Cursor.t ]
val nResize : [> Types.Cursor.t ]
val eResize : [> Types.Cursor.t ]
val sResize : [> Types.Cursor.t ]
val wResize : [> Types.Cursor.t ]
val neResize : [> Types.Cursor.t ]
val nwResize : [> Types.Cursor.t ]
val seResize : [> Types.Cursor.t ]
val swResize : [> Types.Cursor.t ]
val ewResize : [> Types.Cursor.t ]
val nsResize : [> Types.Cursor.t ]
val neswResize : [> Types.Cursor.t ]
val nwseResize : [> Types.Cursor.t ]
val zoomIn : [> Types.Cursor.t ]
val zoomOut : [> Types.Cursor.t ]

val flex3 :
  grow:float ->
  shrink:float ->
  basis:[< Types.Length.t | Types.FlexBasis.t ] ->
  rule

val border :
  Types.Length.t ->
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] ->
  [< Types.Color.t | Types.Var.t ] ->
  rule

val borderTop :
  Types.Length.t ->
  [< Types.BorderStyle.t | Types.Var.t | Types.Cascading.t ] ->
  [< Types.Color.t | Types.Var.t ] ->
  rule

val backgroundSize :
  [ `size of Types.Length.t * Types.Length.t | `auto | `cover | `contain ] ->
  rule

val textDecoration :
  [ `none
  | `underline
  | `overline
  | `lineThrough
  | Types.Var.t
  | Types.Cascading.t
  ] ->
  rule

val background :
  [< Types.Color.t | Types.Url.t | 'gradient Types.Gradient.t | `none ] -> rule

val backgrounds :
  [< Types.Color.t | Types.Url.t | 'gradient Types.Gradient.t | `none ] array ->
  rule

type nonrec minmax =
  [ `fr of float
  | `minContent
  | `maxContent
  | `auto
  | Types.Length.t
  ]

type nonrec trackLength =
  [ Types.Length.t
  | `auto
  | `fr of float
  | `minContent
  | `maxContent
  | `minmax of minmax * minmax
  ]

type nonrec gridLength =
  [ trackLength
  | `repeat of Types.RepeatValue.t * trackLength
  ]

val gridAutoColumns : [< trackLength | `auto ] -> rule
val gridAutoRows : [< trackLength | `auto ] -> rule
val gridTemplateColumns : [< gridLength | `auto ] array -> rule
val gridTemplateRows : [< gridLength | `auto ] array -> rule

module Calc : sig
  val ( - ) : Types.Length.t -> Types.Length.t -> [> Types.Length.t ]
  val ( + ) : Types.Length.t -> Types.Length.t -> [> Types.Length.t ]
end

val size :
  Types.Length.t ->
  Types.Length.t ->
  [> `size of Types.Length.t * Types.Length.t ]

type nonrec filter =
  [ `blur of Types.Length.t
  | `brightness of float
  | `contrast of float
  | `dropShadow of
    Types.Length.t * Types.Length.t * Types.Length.t * Types.Color.t
  | `grayscale of float
  | `hueRotate of Types.Angle.t
  | `invert of float
  | `opacity of float
  | `saturate of float
  | `sepia of float
  | `none
  | Types.Url.t
  | Types.Var.t
  | Types.Cascading.t
  ]

val filter : filter array -> rule

val fontFace :
  fontFamily:string ->
  src:[< `localUrl of string | Types.Url.t ] array ->
  ?fontStyle:Types.FontStyle.t ->
  ?fontWeight:[< Types.FontWeight.t | Types.Var.t | Types.Cascading.t ] ->
  ?fontDisplay:Types.FontDisplay.t ->
  ?sizeAdjust:Types.Percentage.t ->
  unit ->
  string

module Transition : sig
  type nonrec t = [ `value of string ]

  val shorthand :
    ?duration:int ->
    ?delay:int ->
    ?timingFunction:Types.TimingFunction.t ->
    string ->
    [> t ]

  val toString : t -> string
end
[@@ns.doc "\n * Transition\n "]

val transitionValue : Transition.t -> rule
val transitionList : Transition.t array -> rule

val transition :
  ?duration:int ->
  ?delay:int ->
  ?timingFunction:Types.TimingFunction.t ->
  string ->
  rule

val transitions : Transition.t array -> rule

module Animation : sig
  type nonrec t = [ `value of string ]

  val shorthand :
    ?duration:int ->
    ?delay:int ->
    ?direction:Types.AnimationDirection.t ->
    ?timingFunction:Types.TimingFunction.t ->
    ?fillMode:Types.AnimationFillMode.t ->
    ?playState:Types.AnimationPlayState.t ->
    ?iterationCount:Types.AnimationIterationCount.t ->
    animationName ->
    [> t ]

  val toString : t -> string
end
[@@ns.doc "\n * Animation\n "]

val animationValue : Animation.t -> rule

val animation :
  ?duration:int ->
  ?delay:int ->
  ?direction:Types.AnimationDirection.t ->
  ?timingFunction:Types.TimingFunction.t ->
  ?fillMode:Types.AnimationFillMode.t ->
  ?playState:Types.AnimationPlayState.t ->
  ?iterationCount:Types.AnimationIterationCount.t ->
  animationName ->
  rule

val animations : Animation.t array -> rule
val animationName : animationName -> rule

module SVG : sig
  val fill :
    [< Types.SVG.Fill.t | Types.Color.t | Types.Var.t | Types.Url.t ] -> rule

  val fillRule : [ `nonzero | `evenodd ] -> rule
  val fillOpacity : float -> rule
  val stroke : [< Types.Color.t | Types.Var.t ] -> rule

  val strokeDasharray :
    [< `none | `dasharray of [< Types.Length.t | Types.Percentage.t ] array ] ->
    rule

  val strokeLinecap : [ `butt | `round | `square ] -> rule
  val strokeLinejoin : [ `miter | `round | `bevel ] -> rule
  val strokeMiterlimit : float -> rule
  val strokeWidth : Types.Length.t -> rule
  val strokeOpacity : float -> rule
  val stopColor : [< Types.Color.t | Types.Var.t ] -> rule
  val stopOpacity : float -> rule
end

val touchAction : Types.TouchAction.t -> rule
