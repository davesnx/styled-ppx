open Css_AtomicTypes
module Std = Kloth

type rule =
  | D of string * string
  | S of string * rule array
  | PseudoClass of string * rule array
  | PseudoClassParam of string * string * rule array

let rec ruleToDict dict rule =
  (match rule with
  | D (name, value) -> Js.Dict.set dict name (Js.Json.string value)
  | S (name, ruleset) -> Js.Dict.set dict name (toJson ruleset)
  | PseudoClass (name, ruleset) ->
    dict |. Js.Dict.set ({js|:|js} ^ name) (toJson ruleset)
  | PseudoClassParam (name, param, ruleset) ->
    dict
    |. Js.Dict.set
         ({js|:|js} ^ name ^ {js|(|js} ^ param ^ {js|)|js})
         (toJson ruleset));
  dict

and toJson rules =
  Std.Array.reduce rules (Js.Dict.empty ()) ruleToDict |. Js.Json.object_

type animationName = string

module type MakeResult = sig
  type styleEncoding
  type renderer

  val insertRule : string -> unit
  val renderRule : renderer -> string -> unit
  val global : rule array -> unit
  val renderGlobal : renderer -> string -> rule array -> unit
  val style : rule array -> styleEncoding
  val merge : styleEncoding array -> styleEncoding
  val merge2 : styleEncoding -> styleEncoding -> styleEncoding
  val merge3 : styleEncoding -> styleEncoding -> styleEncoding -> styleEncoding

  val merge4 :
    styleEncoding ->
    styleEncoding ->
    styleEncoding ->
    styleEncoding ->
    styleEncoding

  val keyframes : (int * rule array) array -> animationName
  val renderKeyframes : renderer -> (int * rule array) array -> animationName
end

module Make (CssImpl : Css_Core.CssImplementationIntf) :
  MakeResult
    with type styleEncoding := CssImpl.styleEncoding
     and type renderer := CssImpl.renderer = struct
  let insertRule css = CssImpl.injectRaw css
  let renderRule renderer css = CssImpl.renderRaw renderer css
  let global rules = CssImpl.injectRules (toJson rules)

  let renderGlobal renderer selector rules =
    CssImpl.renderRules renderer selector (toJson rules)

  let style rules = CssImpl.make (toJson rules)
  let merge styles = CssImpl.mergeStyles styles
  let merge2 s s2 = merge [| s; s2 |]
  let merge3 s s2 s3 = merge [| s; s2; s3 |]
  let merge4 s s2 s3 s4 = merge [| s; s2; s3; s4 |]

  let framesToDict frames =
    Std.Array.reduce frames (Js.Dict.empty ()) (fun dict (stop, rules) ->
        Js.Dict.set dict (Std.Int.toString stop ^ {js|%|js}) (toJson rules);
        dict)

  let keyframes frames = CssImpl.makeKeyframes (framesToDict frames)

  let renderKeyframes renderer frames =
    CssImpl.renderKeyframes renderer (framesToDict frames)
end

let join strings separator =
  Std.Array.reduceWithIndex strings {js||js} (fun acc item index ->
      if index = 0 then item else acc ^ separator ^ item)

module Converter = struct
  let string_of_content x =
    match x with
    | #Content.t as c -> Content.toString c
    | #Counter.t as c -> Counter.toString c
    | #Counters.t as c -> Counters.toString c
    | #Gradient.t as g -> Gradient.toString g
    | #Url.t as u -> Url.toString u
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_counter_increment x =
    match x with
    | #CounterIncrement.t as o -> CounterIncrement.toString o
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_counter_reset x =
    match x with
    | #CounterReset.t as o -> CounterReset.toString o
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_counter_set x =
    match x with
    | #CounterSet.t as o -> CounterSet.toString o
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_column_gap x =
    match x with
    | #ColumnGap.t as gcg -> ColumnGap.toString gcg
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_row_gap x =
    match x with
    | #RowGap.t as rg -> RowGap.toString rg
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_gap x =
    match x with
    | #Gap.t as rg -> Gap.toString rg
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_position x =
    match x with
    | `auto -> {js|auto|js}
    | #Length.t as l -> Length.toString l
    | #Var.t as va -> Var.toString va
    | #Cascading.t as c -> Cascading.toString c

  let string_of_color x =
    match x with
    | #Color.t as co -> Color.toString co
    | #Var.t as va -> Var.toString va

  let string_of_dasharray x =
    match x with
    | #Percentage.t as p -> Percentage.toString p
    | #Length.t as l -> Length.toString l
end

include Converter

let important v =
  match v with
  | D (name, value) -> D (name, value ^ {js| !important|js})
  | S (_, _) | PseudoClass (_, _) | PseudoClassParam (_, _, _) -> v

let label label = D ({js|label|js}, label)

let aspectRatio x =
  D
    ( {js|aspectRatio|js},
      match x with
      | #AspectRatio.t as ar -> AspectRatio.toString ar
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignContent x =
  D
    ( {js|alignContent|js},
      match x with
      | #AlignContent.t as ac -> AlignContent.toString ac
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignItems x =
  D
    ( {js|alignItems|js},
      match x with
      | #AlignItems.t as ai -> AlignItems.toString ai
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignSelf x =
  D
    ( {js|alignSelf|js},
      match x with
      | #AlignSelf.t as a -> AlignSelf.toString a
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let animationDelay x = D ({js|animationDelay|js}, Time.toString x)

let animationDirection x =
  D ({js|animationDirection|js}, AnimationDirection.toString x)

let animationDuration x = D ({js|animationDuration|js}, Time.toString x)

let animationFillMode x =
  D ({js|animationFillMode|js}, AnimationFillMode.toString x)

let animationIterationCount x =
  D ({js|animationIterationCount|js}, AnimationIterationCount.toString x)

let animationPlayState x =
  D ({js|animationPlayState|js}, AnimationPlayState.toString x)

let animationTimingFunction x =
  D ({js|animationTimingFunction|js}, TimingFunction.toString x)

let backfaceVisibility x =
  D
    ( {js|backfaceVisibility|js},
      match x with
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backdropFilter x =
  D
    ( {js|backdropFilter|js},
      x |. Std.Array.map Filter.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let backgroundAttachment x =
  D
    ( {js|backgroundAttachment|js},
      match x with
      | #BackgroundAttachment.t as ba -> BackgroundAttachment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundColor x = D ({js|backgroundColor|js}, string_of_color x)

let backgroundClip x =
  D
    ( {js|backgroundClip|js},
      match x with
      | #BackgroundClip.t as bc -> BackgroundClip.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_backgroundImage x =
  match x with
  | #BackgroundImage.t as bi -> BackgroundImage.toString bi
  | #Url.t as u -> Url.toString u
  | #Gradient.t as g -> Gradient.toString g

let backgroundImage x = D ({js|backgroundImage|js}, string_of_backgroundImage x)

let backgroundImages imgs =
  D
    ( {js|backgroundImage|js},
      imgs
      |. Std.Array.map string_of_backgroundImage
      |. Std.Array.joinWith ~sep:{js|, |js} )

let maskImage x =
  D
    ( {js|maskImage|js},
      match x with
      | #MaskImage.t as mi -> MaskImage.toString mi
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let imageRendering x =
  D
    ( {js|imageRendering|js},
      match x with
      | #ImageRendering.t as ir -> ImageRendering.toString ir
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundOrigin x =
  D
    ( {js|backgroundOrigin|js},
      match x with
      | #BackgroundOrigin.t as bo -> BackgroundOrigin.toString bo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_backgroundPosition x =
  match x with
  | #Position.t as bp -> Position.toString bp
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let backgroundPosition x =
  D ({js|backgroundPosition|js}, string_of_backgroundPosition x)

let backgroundPosition2 x y =
  D
    ( {js|backgroundPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let backgroundPosition4 ~x ~offsetX ~y ~offsetY =
  D
    ( {js|backgroundPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ Length.toString offsetX
      ^ {js| |js}
      ^ string_of_backgroundPosition y
      ^ {js| |js}
      ^ Length.toString offsetY )

let backgroundPositions bp =
  D
    ( {js|backgroundPosition|js},
      bp
      |. Std.Array.map (fun (x, y) ->
             string_of_backgroundPosition x
             ^ {js| |js}
             ^ string_of_backgroundPosition y)
      |. Std.Array.joinWith ~sep:{js|, |js} )

let backgroundRepeat x =
  D
    ( {js|backgroundRepeat|js},
      match x with
      | #BackgroundRepeat.t as br -> BackgroundRepeat.toString br
      | `hv
          ( (#BackgroundRepeat.horizontal as h),
            (#BackgroundRepeat.vertical as v) ) ->
        BackgroundRepeat.toString h ^ {js| |js} ^ BackgroundRepeat.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_maskposition x =
  match x with
  | #MaskPosition.t as mp -> MaskPosition.toString mp
  | `hv (h, v) ->
    (match h with
    | #MaskPosition.X.t as h -> MaskPosition.X.toString h
    | #Length.t as l -> Length.toString l)
    ^ {js| |js}
    ^
    (match v with
    | #MaskPosition.Y.t as v -> MaskPosition.Y.toString v
    | #Length.t as l -> Length.toString l)
  | #Length.t as l -> Length.toString l
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let maskPosition x = D ({js|maskPosition|js}, string_of_maskposition x)

let maskPositions mp =
  D
    ( {js|maskPosition|js},
      mp
      |. Std.Array.map string_of_maskposition
      |. Std.Array.joinWith ~sep:{js|, |js} )

let borderImageSource x =
  D
    ( {js|borderImageSource|js},
      match x with
      | #BorderImageSource.t as b -> BorderImageSource.toString b
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let borderBottomColor x = D ({js|borderBottomColor|js}, string_of_color x)

let borderBottomLeftRadius x =
  D ({js|borderBottomLeftRadius|js}, Length.toString x)

let borderBottomRightRadius x =
  D ({js|borderBottomRightRadius|js}, Length.toString x)

let borderBottomWidth x = D ({js|borderBottomWidth|js}, LineWidth.toString x)

let borderCollapse x =
  D
    ( {js|borderCollapse|js},
      match x with
      | #BorderCollapse.t as bc -> BorderCollapse.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let borderColor x = D ({js|borderColor|js}, string_of_color x)
let borderLeftColor x = D ({js|borderLeftColor|js}, string_of_color x)
let borderLeftWidth x = D ({js|borderLeftWidth|js}, LineWidth.toString x)
let borderSpacing x = D ({js|borderSpacing|js}, Length.toString x)
let borderRadius x = D ({js|borderRadius|js}, Length.toString x)

let borderRadius4 ~topLeft ~topRight ~bottomLeft ~bottomRight =
  D
    ( {js|borderRadius|js},
      Length.toString topLeft
      ^ {js| |js}
      ^ Length.toString topRight
      ^ {js| |js}
      ^ Length.toString bottomLeft
      ^ {js| |js}
      ^ Length.toString bottomRight )

let borderRightColor x = D ({js|borderRightColor|js}, string_of_color x)
let borderRightWidth x = D ({js|borderRightWidth|js}, LineWidth.toString x)
let borderTopColor x = D ({js|borderTopColor|js}, string_of_color x)
let borderTopLeftRadius x = D ({js|borderTopLeftRadius|js}, Length.toString x)
let borderTopRightRadius x = D ({js|borderTopRightRadius|js}, Length.toString x)
let borderTopWidth x = D ({js|borderTopWidth|js}, LineWidth.toString x)
let borderWidth x = D ({js|borderWidth|js}, LineWidth.toString x)
let bottom x = D ({js|bottom|js}, string_of_position x)

let boxSizing x =
  D
    ( {js|boxSizing|js},
      match x with
      | #BoxSizing.t as bs -> BoxSizing.toString bs
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clear x =
  D
    ( {js|clear|js},
      match x with
      | #Clear.t as cl -> Clear.toString cl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clipPath x =
  D
    ( {js|clipPath|js},
      match x with
      | #ClipPath.t as cp -> ClipPath.toString cp
      | #Url.t as u -> Url.toString u
      | #GeometryBox.t as gb -> GeometryBox.toString gb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let color x = D ({js|color|js}, string_of_color x)

let columnCount x =
  D
    ( {js|columnCount|js},
      match x with
      | #ColumnCount.t as cc -> ColumnCount.toString cc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let rowGap x = D ({js|rowGap|js}, string_of_row_gap x)
let columnGap x = D ({js|columnGap|js}, string_of_column_gap x)
let contentRule x = D ({js|content|js}, string_of_content x)

let contentRules xs =
  D
    ( {js|content|js},
      xs |. Std.Array.map string_of_content |. Std.Array.joinWith ~sep:{js| |js}
    )

let counterIncrement x =
  D ({js|counterIncrement|js}, string_of_counter_increment x)

let countersIncrement xs =
  D
    ( {js|counterIncrement|js},
      xs
      |. Std.Array.map string_of_counter_increment
      |. Std.Array.joinWith ~sep:{js| |js} )

let counterReset x = D ({js|counterReset|js}, string_of_counter_reset x)

let countersReset xs =
  D
    ( {js|counterReset|js},
      xs
      |. Std.Array.map string_of_counter_reset
      |. Std.Array.joinWith ~sep:{js| |js} )

let counterSet x = D ({js|counterSet|js}, string_of_counter_set x)

let countersSet xs =
  D
    ( {js|counterSet|js},
      xs
      |. Std.Array.map string_of_counter_set
      |. Std.Array.joinWith ~sep:{js| |js} )

let cursor x = D ({js|cursor|js}, Cursor.toString x)

let direction x =
  D
    ( {js|direction|js},
      match x with
      | #Direction.t as d -> Direction.toString d
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let display x =
  D
    ( {js|display|js},
      match x with
      | #DisplayOutside.t as o -> DisplayOutside.toString o
      | #DisplayOld.t as o -> DisplayOld.toString o
      | #DisplayInside.t as i -> DisplayInside.toString i
      | #DisplayListItem.t as l -> DisplayListItem.toString l
      | #DisplayInternal.t as i' -> DisplayInternal.toString i'
      | #DisplayBox.t as b -> DisplayBox.toString b
      | #DisplayLegacy.t as l' -> DisplayLegacy.toString l'
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flex grow shrink basis =
  D
    ( {js|flex|js},
      Std.Float.toString grow
      ^ {js| |js}
      ^ Std.Float.toString shrink
      ^ {js| |js}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flex1 x =
  D
    ( {js|flex|js},
      match x with
      | #Flex.t as f -> Flex.toString f
      | `num n -> Std.Float.toString n )

let flex2 ?basis ?shrink grow =
  D
    ( {js|flex|js},
      Std.Float.toString grow
      ^ (match shrink with
        | Some s -> {js| |js} ^ Std.Float.toString s
        | None -> {js||js})
      ^
      match basis with
      | Some (#FlexBasis.t as b) -> {js| |js} ^ FlexBasis.toString b
      | Some (#Length.t as l) -> {js| |js} ^ Length.toString l
      | None -> {js||js} )

let flexDirection x =
  D
    ( {js|flexDirection|js},
      match x with
      | #FlexDirection.t as fd -> FlexDirection.toString fd
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flexGrow x = D ({js|flexGrow|js}, Std.Float.toString x)
let flexShrink x = D ({js|flexShrink|js}, Std.Float.toString x)

let flexWrap x =
  D
    ( {js|flexWrap|js},
      match x with
      | #FlexWrap.t as fw -> FlexWrap.toString fw
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let float x =
  D
    ( {js|float|js},
      match x with
      | #Float.t as f -> Float.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamily x =
  D
    ( {js|fontFamily|js},
      match x with
      | #FontFamilyName.t as n -> FontFamilyName.toString n
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamilies xs =
  D
    ( {js|fontFamily|js},
      xs
      |. Std.Array.map FontFamilyName.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let fontSize x =
  D
    ( {js|fontSize|js},
      match x with
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontStyle x =
  D
    ( {js|fontStyle|js},
      match x with
      | #FontStyle.t as f -> FontStyle.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontVariant x =
  D
    ( {js|fontVariant|js},
      match x with
      | #FontVariant.t as f -> FontVariant.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontWeight x =
  D
    ( {js|fontWeight|js},
      match x with
      | #FontWeight.t as f -> FontWeight.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridAutoFlow x =
  D
    ( {js|gridAutoFlow|js},
      match x with
      | #GridAutoFlow.t as f -> GridAutoFlow.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridColumn start end' =
  D
    ( {js|gridColumn|js},
      Std.Int.toString start ^ {js| / |js} ^ Std.Int.toString end' )

let gridColumnGap x = D ({js|gridColumnGap|js}, string_of_column_gap x)
let gridColumnStart n = D ({js|gridColumnStart|js}, Std.Int.toString n)
let gridColumnEnd n = D ({js|gridColumnEnd|js}, Std.Int.toString n)

let gridRow start end' =
  D
    ( {js|gridRow|js},
      Std.Int.toString start ^ {js| / |js} ^ Std.Int.toString end' )

let gap x = D ({js|gap|js}, string_of_gap x)
let gridGap x = D ({js|gridGap|js}, string_of_gap x)

let gap2 ~rowGap ~columnGap =
  D ({js|gap|js}, string_of_gap rowGap ^ {js| |js} ^ string_of_gap columnGap)

let gridRowGap x =
  D
    ( {js|gridRowGap|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridRowEnd n = D ({js|gridRowEnd|js}, Std.Int.toString n)
let gridRowStart n = D ({js|gridRowStart|js}, Std.Int.toString n)

let height x =
  D
    ( {js|height|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyle x =
  D
    ( {js|textEmphasisStyle|js},
      match x with
      | #TextEmphasisStyle.t as tes -> TextEmphasisStyle.toString tes
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyles x y =
  D
    ( {js|textEmphasisStyles|js},
      match x with
      | #TextEmphasisStyle.FilledOrOpen.t as fo ->
        TextEmphasisStyle.FilledOrOpen.toString fo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c ->
        Cascading.toString c
        ^ {js| |js}
        ^
        (match y with
        | #TextEmphasisStyle.Shape.t as shape ->
          TextEmphasisStyle.Shape.toString shape
        | #Var.t as va -> Var.toString va
        | #Cascading.t as c -> Cascading.toString c) )

let textEmphasisPosition' = function
  | #TextEmphasisPosition.OverOrUnder.t as ou ->
    TextEmphasisPosition.OverOrUnder.toString ou
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let textEmphasisPosition x =
  D ({js|textEmphasisPosition|js}, textEmphasisPosition' x)

let textEmphasisPositions x y =
  D
    ( {js|textEmphasisPositions|js},
      textEmphasisPosition' x
      ^ {js| |js}
      ^
      match y with
      | #TextEmphasisPosition.LeftRightAlignment.t as lr ->
        TextEmphasisPosition.LeftRightAlignment.toString lr
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyContent x =
  D
    ( {js|justifyContent|js},
      match x with
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyItems x =
  D
    ( {js|justifyItems|js},
      match x with
      | `stretch -> {js|stretch|js}
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #LegacyAlignment.t as la -> LegacyAlignment.toString la
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let left x = D ({js|left|js}, string_of_position x)

let letterSpacing x =
  D
    ( {js|letterSpacing|js},
      match x with
      | #LetterSpacing.t as s -> LetterSpacing.toString s
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let lineHeight x =
  D
    ( {js|lineHeight|js},
      match x with
      | #LineHeight.t as h -> LineHeight.toString h
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStyle style position image =
  D
    ( {js|listStyle|js},
      ListStyleType.toString style
      ^ {js| |js}
      ^ ListStylePosition.toString position
      ^ {js| |js}
      ^
      match image with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u )

let listStyleImage x =
  D
    ( {js|listStyleImage|js},
      match x with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u
      | #Var.t as va -> Var.toString va
      | #Gradient.t as g -> Gradient.toString g
      | #Cascading.t as c -> Cascading.toString c )

let listStyleType x =
  D
    ( {js|listStyleType|js},
      match x with
      | #ListStyleType.t as lsp -> ListStyleType.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStylePosition x =
  D
    ( {js|listStylePosition|js},
      match x with
      | #ListStylePosition.t as lsp -> ListStylePosition.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let tabSize x =
  D
    ( {|tabSize|},
      match x with
      | #TabSize.t as ts -> TabSize.toString ts
      | #Length.t as len -> Length.toString len
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let marginToString x =
  match x with
  | #Length.t as l -> Length.toString l
  | #Margin.t as m -> Margin.toString m
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let margin x = D ({js|margin|js}, marginToString x)

let margin2 ~v ~h =
  D ({js|margin|js}, marginToString v ^ {js| |js} ^ marginToString h)

let margin3 ~top ~h ~bottom =
  D
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString h
      ^ {js| |js}
      ^ marginToString bottom )

let margin4 ~top ~right ~bottom ~left =
  D
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString right
      ^ {js| |js}
      ^ marginToString bottom
      ^ {js| |js}
      ^ marginToString left )

let marginLeft x = D ({js|marginLeft|js}, marginToString x)
let marginRight x = D ({js|marginRight|js}, marginToString x)
let marginTop x = D ({js|marginTop|js}, marginToString x)
let marginBottom x = D ({js|marginBottom|js}, marginToString x)

let maxHeight x =
  D
    ( {js|maxHeight|js},
      match x with
      | #Height.t as mh -> Height.toString mh
      | #MaxHeight.t as mh -> MaxHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let maxWidth x =
  D
    ( {js|maxWidth|js},
      match x with
      | #Width.t as mw -> Width.toString mw
      | #MaxWidth.t as mw -> MaxWidth.toString mw
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minHeight x =
  D
    ( {js|minHeight|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #MinHeight.t as mh -> MinHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minWidth x =
  D
    ( {js|minWidth|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #MinWidth.t as w -> MinWidth.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectFit x =
  D
    ( {js|objectFit|js},
      match x with
      | #ObjectFit.t as o -> ObjectFit.toString o
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectPosition x = D ({js|objectPosition|js}, string_of_backgroundPosition x)

let objectPosition2 x y =
  D
    ( {js|objectPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let opacity x = D ({js|opacity|js}, Std.Float.toString x)

let outline size style color =
  D
    ( {js|outline|js},
      LineWidth.toString size
      ^ {js| |js}
      ^ OutlineStyle.toString style
      ^ {js| |js}
      ^ string_of_color color )

let outlineColor x = D ({js|outlineColor|js}, string_of_color x)
let outlineOffset x = D ({js|outlineOffset|js}, Length.toString x)
let outlineStyle x = D ({js|outlineStyle|js}, OutlineStyle.toString x)
let outlineWidth x = D ({js|outlineWidth|js}, LineWidth.toString x)
let overflow x = D ({js|overflow|js}, Overflow.toString x)
let overflowX x = D ({js|overflowX|js}, Overflow.toString x)
let overflowY x = D ({js|overflowY|js}, Overflow.toString x)

let overflowWrap x =
  D
    ( {js|overflowWrap|js},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let padding x = D ({js|padding|js}, Length.toString x)

let padding2 ~v ~h =
  D ({js|padding|js}, Length.toString v ^ {js| |js} ^ Length.toString h)

let padding3 ~top ~h ~bottom =
  D
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString h
      ^ {js| |js}
      ^ Length.toString bottom )

let padding4 ~top ~right ~bottom ~left =
  D
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString right
      ^ {js| |js}
      ^ Length.toString bottom
      ^ {js| |js}
      ^ Length.toString left )

let paddingBottom x = D ({js|paddingBottom|js}, Length.toString x)
let paddingLeft x = D ({js|paddingLeft|js}, Length.toString x)
let paddingRight x = D ({js|paddingRight|js}, Length.toString x)
let paddingTop x = D ({js|paddingTop|js}, Length.toString x)

let perspective x =
  D
    ( {js|perspective|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let perspectiveOrigin x =
  D
    ( {js|perspectiveOrigin|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let perspectiveOrigin2 x y =
  D
    ( {js|perspectiveOrigin|js},
      (match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t)
      ^ {js| |js}
      ^
      match y with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let pointerEvents x =
  D
    ( {js|pointerEvents|js},
      match x with
      | #PointerEvents.t as p -> PointerEvents.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let position x =
  D
    ( {js|position|js},
      match x with
      | #PropertyPosition.t as p -> PropertyPosition.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let isolation x =
  D
    ( {js|isolation|js},
      match x with
      | #Isolation.t as i -> Isolation.toString i
      | #Cascading.t as c -> Cascading.toString c )

let justifySelf x =
  D
    ( {js|justifySelf|js},
      match x with
      | #JustifySelf.t as j -> JustifySelf.toString j
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let resize x =
  D
    ( {js|resize|js},
      match x with
      | #Resize.t as r -> Resize.toString r
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let right x = D ({js|right|js}, string_of_position x)

let tableLayout x =
  D
    ( {js|tableLayout|js},
      match x with
      | #TableLayout.t as tl -> TableLayout.toString tl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlign x =
  D
    ( {js|textAlign|js},
      match x with
      | #TextAlign.t as ta -> TextAlign.toString ta
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignAll x =
  D
    ( {js|textAlignAll|js},
      match x with
      | #TextAlignAll.t as taa -> TextAlignAll.toString taa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignLast x =
  D
    ( {js|textAlignLast|js},
      match x with
      | #TextAlignLast.t as tal -> TextAlignLast.toString tal
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationColor x =
  D
    ( {js|textDecorationColor|js},
      match x with
      | #Color.t as co -> Color.toString co
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationLine x =
  D
    ( {js|textDecorationLine|js},
      match x with
      | #TextDecorationLine.t as tdl -> TextDecorationLine.toString tdl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationStyle x =
  D
    ( {js|textDecorationStyle|js},
      match x with
      | #TextDecorationStyle.t as tds -> TextDecorationStyle.toString tds
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationThickness x =
  D
    ( {js|textDecorationThickness|js},
      match x with
      | #TextDecorationThickness.t as t -> TextDecorationThickness.toString t
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInk x =
  D
    ( {js|textDecorationSkipInk|js},
      match x with
      | #TextDecorationSkipInk.t as tdsi -> TextDecorationSkipInk.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipBox x =
  D
    ( {js|textDecorationSkipBox|js},
      match x with
      | #TextDecorationSkipBox.t as tdsb -> TextDecorationSkipBox.toString tdsb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInset x =
  D
    ( {js|textDecorationSkipInset|js},
      match x with
      | #TextDecorationSkipInset.t as tdsi ->
        TextDecorationSkipInset.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textIndent x =
  D
    ( {js|textIndent|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textOverflow x =
  D
    ( {js|textOverflow|js},
      match x with
      | #TextOverflow.t as txo -> TextOverflow.toString txo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textTransform x =
  D
    ( {js|textTransform|js},
      match x with
      | #TextTransform.t as tt -> TextTransform.toString tt
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let top x = D ({js|top|js}, string_of_position x)

let transform x =
  D
    ( {js|transform|js},
      match x with
      | `none -> {js|none|js}
      | #Transform.t as t -> Transform.toString t )

let transforms x =
  D
    ( {js|transform|js},
      x |. Std.Array.map Transform.toString |. Std.Array.joinWith ~sep:{js| |js}
    )

let transformOrigin x = D ({js|transformOrigin|js}, TransformOrigin.toString x)

let transformOrigin2 x y =
  D
    ( {js|transformOrigin|js},
      TransformOrigin.toString x ^ {js| |js} ^ TransformOrigin.toString y )

let transformOrigin3d x y z =
  D
    ( {js|transformOrigin|js},
      Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString z
      ^ {js| |js} )

let transformBox x =
  D
    ( {js|transformBox|js},
      match x with
      | #TransformBox.t as tb -> TransformBox.toString tb
      | #Cascading.t as c -> Cascading.toString c )

let unsafe property value = D (property, value)

let userSelect x =
  D
    ( {js|userSelect|js},
      match x with
      | #UserSelect.t as us -> UserSelect.toString us
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let verticalAlign x =
  D
    ( {js|verticalAlign|js},
      match x with
      | #VerticalAlign.t as v -> VerticalAlign.toString v
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let visibility x =
  D
    ( {js|visibility|js},
      match x with
      | #Visibility.t as v -> Visibility.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let scrollBehavior x =
  D
    ( {js|scrollBehavior|js},
      match x with
      | #ScrollBehavior.t as sb -> ScrollBehavior.toString sb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overscrollBehavior x =
  D
    ( {js|overscrollBehavior|js},
      match x with
      | #OverscrollBehavior.t as osb -> OverscrollBehavior.toString osb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overflowAnchor x =
  D
    ( {js|overflowAnchor|js},
      match x with
      | #OverflowAnchor.t as oa -> OverflowAnchor.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnWidth x =
  D
    ( {js|columnWidth|js},
      match x with
      | #ColumnWidth.t as cw -> ColumnWidth.toString cw
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let caretColor x =
  D
    ( {js|caretColor|js},
      match x with
      | #CaretColor.t as ct -> CaretColor.toString ct
      | #Color.t as c -> Color.toString c
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let width x =
  D
    ( {js|width|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let whiteSpace x =
  D
    ( {js|whiteSpace|js},
      match x with
      | #WhiteSpace.t as w -> WhiteSpace.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordBreak x =
  D
    ( {js|wordBreak|js},
      match x with
      | #WordBreak.t as w -> WordBreak.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordSpacing x =
  D
    ( {js|wordSpacing|js},
      match x with
      | #WordSpacing.t as w -> WordSpacing.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordWrap = overflowWrap
let zIndex x = D ({js|zIndex|js}, ZIndex.toString x)
let media query rules = S ({js|@media |js} ^ query, rules)
let selector selector rules = S (selector, rules)
let pseudoClass selector rules = PseudoClass (selector, rules)
let active rules = pseudoClass {js|active|js} rules
let checked rules = pseudoClass {js|checked|js} rules
let default rules = pseudoClass {js|default|js} rules
let defined rules = pseudoClass {js|defined|js} rules
let disabled rules = pseudoClass {js|disabled|js} rules
let empty rules = pseudoClass {js|empty|js} rules
let enabled rules = pseudoClass {js|enabled|js} rules
let first rules = pseudoClass {js|first|js} rules
let firstChild rules = pseudoClass {js|first-child|js} rules
let firstOfType rules = pseudoClass {js|first-of-type|js} rules
let focus rules = pseudoClass {js|focus|js} rules
let focusVisible rules = pseudoClass {js|focus-visible|js} rules
let focusWithin rules = pseudoClass {js|focus-within|js} rules

let host ?selector rules =
  match selector with
  | None -> PseudoClass ({js|host|js}, rules)
  | Some s -> PseudoClassParam ({js|host|js}, s, rules)

let hover rules = pseudoClass {js|hover|js} rules
let indeterminate rules = pseudoClass {js|indeterminate|js} rules
let inRange rules = pseudoClass {js|in-range|js} rules
let invalid rules = pseudoClass {js|invalid|js} rules
let lang code rules = PseudoClassParam ({js|lang|js}, code, rules)
let lastChild rules = pseudoClass {js|last-child|js} rules
let lastOfType rules = pseudoClass {js|last-of-type|js} rules
let link rules = pseudoClass {js|link|js} rules
let not_ selector rules = PseudoClassParam ({js|not|js}, selector, rules)

module Nth = struct
  type t =
    [ `odd
    | `even
    | `n of int
    | `add of int * int
    ]

  let toString x =
    match x with
    | `odd -> {js|odd|js}
    | `even -> {js|even|js}
    | `n x -> Std.Int.toString x ^ {js|n|js}
    | `add (x, y) -> Std.Int.toString x ^ {js|n+|js} ^ Std.Int.toString y
end

let nthChild x rules =
  PseudoClassParam ({js|nth-child|js}, Nth.toString x, rules)

let nthLastChild x rules =
  PseudoClassParam ({js|nth-last-child|js}, Nth.toString x, rules)

let nthLastOfType x rules =
  PseudoClassParam ({js|nth-last-of-type|js}, Nth.toString x, rules)

let nthOfType x rules =
  PseudoClassParam ({js|nth-of-type|js}, Nth.toString x, rules)

let onlyChild rules = pseudoClass {js|only-child|js} rules
let onlyOfType rules = pseudoClass {js|only-of-type|js} rules
let optional rules = pseudoClass {js|optional|js} rules
let outOfRange rules = pseudoClass {js|out-of-range|js} rules
let readOnly rules = pseudoClass {js|read-only|js} rules
let readWrite rules = pseudoClass {js|read-write|js} rules
let required rules = pseudoClass {js|required|js} rules
let root rules = pseudoClass {js|root|js} rules
let scope rules = pseudoClass {js|scope|js} rules
let target rules = pseudoClass {js|target|js} rules
let valid rules = pseudoClass {js|valid|js} rules
let visited rules = pseudoClass {js|visited|js} rules
let after rules = selector {js|::after|js} rules
let before rules = selector {js|::before|js} rules
let firstLetter rules = selector {js|::first-letter|js} rules
let firstLine rules = selector {js|::first-line|js} rules
let selection rules = selector {js|::selection|js} rules
let child x rules = selector ({js| > |js} ^ x) rules
let children rules = selector {js| > *|js} rules
let directSibling rules = selector {js| + |js} rules
let placeholder rules = selector {js|::placeholder|js} rules
let siblings rules = selector {js| ~ |js} rules
let anyLink rules = selector {js|:any-link|js} rules

type angle = Angle.t
type animationDirection = AnimationDirection.t
type animationFillMode = AnimationFillMode.t
type animationIterationCount = AnimationIterationCount.t
type animationPlayState = AnimationPlayState.t
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

let initial = Cascading.initial
let inherit_ = Cascading.inherit_
let unset = Cascading.unset
let var = Var.var
let varDefault = Var.varDefault
let auto = `auto
let none = `none
let text = `text
let pct = Percentage.pct
let ch = Length.ch
let cm = Length.cm
let em = Length.em
let ex = Length.ex
let mm = Length.mm
let pt = Length.pt
let px = Length.px
let pxFloat = Length.pxFloat
let rem = Length.rem
let vh = Length.vh
let vmin = Length.vmin
let vmax = Length.vmax
let zero = Length.zero
let deg = Angle.deg
let rad = Angle.rad
let grad = Angle.grad
let turn = Angle.turn
let ltr = Direction.ltr
let rtl = Direction.rtl
let absolute = PropertyPosition.absolute
let relative = PropertyPosition.relative
let static = PropertyPosition.static
let fixed = PropertyPosition.fixed
let sticky = PropertyPosition.sticky
let isolate = `isolate
let horizontal = Resize.horizontal
let vertical = Resize.vertical
let smallCaps = FontVariant.smallCaps
let italic = FontStyle.italic
let oblique = FontStyle.oblique
let hidden = `hidden
let visible = `visible
let scroll = `scroll
let rgb = Color.rgb
let rgba = Color.rgba
let hsl = Color.hsl
let hsla = Color.hsla
let hex = Color.hex
let currentColor = Color.currentColor
let transparent = Color.transparent
let linear = TimingFunction.linear
let ease = TimingFunction.ease
let easeIn = TimingFunction.easeIn
let easeInOut = TimingFunction.easeInOut
let easeOut = TimingFunction.easeOut
let stepStart = TimingFunction.stepStart
let stepEnd = TimingFunction.stepEnd
let steps = TimingFunction.steps
let cubicBezier = TimingFunction.cubicBezier
let marginBox = GeometryBox.marginBox
let fillBox = GeometryBox.fillBox
let strokeBox = GeometryBox.strokeBox
let viewBox = GeometryBox.viewBox
let translate = Transform.translate
let translate3d = Transform.translate3d
let translateX = Transform.translateX
let translateY = Transform.translateY
let translateZ = Transform.translateZ
let scaleX = Transform.scaleX
let scaleY = Transform.scaleY
let scaleZ = Transform.scaleZ
let rotateX = Transform.rotateX
let rotateY = Transform.rotateY
let rotateZ = Transform.rotateZ
let scale = Transform.scale
let scale3d = Transform.scale3d
let skew = Transform.skew
let skewX = Transform.skewX
let skewY = Transform.skewY
let thin = FontWeight.thin
let extraLight = FontWeight.extraLight
let light = FontWeight.light
let medium = FontWeight.medium
let semiBold = FontWeight.semiBold
let bold = FontWeight.bold
let extraBold = FontWeight.extraBold
let lighter = FontWeight.lighter
let bolder = FontWeight.bolder
let linearGradient = Gradient.linearGradient
let repeatingLinearGradient = Gradient.repeatingLinearGradient
let radialGradient = Gradient.radialGradient
let repeatingRadialGradient = Gradient.repeatingRadialGradient
let conicGradient = Gradient.conicGradient
let areas = GridTemplateAreas.areas
let ident = GridArea.ident
let numIdent = GridArea.numIdent
let contextMenu = Cursor.contextMenu
let help = Cursor.help
let pointer = Cursor.pointer
let progress = Cursor.progress
let wait = Cursor.wait
let cell = Cursor.cell
let crosshair = Cursor.crosshair
let verticalText = Cursor.verticalText
let alias = Cursor.alias
let copy = Cursor.copy
let move = Cursor.move
let noDrop = Cursor.noDrop
let notAllowed = Cursor.notAllowed
let grab = Cursor.grab
let grabbing = Cursor.grabbing
let allScroll = Cursor.allScroll
let colResize = Cursor.colResize
let rowResize = Cursor.rowResize
let nResize = Cursor.nResize
let eResize = Cursor.eResize
let sResize = Cursor.sResize
let wResize = Cursor.wResize
let neResize = Cursor.neResize
let nwResize = Cursor.nwResize
let seResize = Cursor.seResize
let swResize = Cursor.swResize
let ewResize = Cursor.ewResize
let nsResize = Cursor.nsResize
let neswResize = Cursor.neswResize
let nwseResize = Cursor.nwseResize
let zoomIn = Cursor.zoomIn
let zoomOut = Cursor.zoomOut
let vw x = `vw x
let fr x = `fr x

module Calc = struct
  let ( - ) a b = `calc (`sub (a, b))
  let ( + ) a b = `calc (`add (a, b))
  let ( * ) a b = `calc (`mult (a, b))
end

let size x y = `size (x, y)
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
let repeat = `repeat
let minmax = `minmax
let repeatX = `repeatX
let repeatY = `repeatY
let rotate a = `rotate a
let rotate3d x y z a = `rotate3d (x, y, z, a)
let row = `row
let rowReverse = `rowReverse
let running = `running
let solid = `solid
let spaceAround = `spaceAround
let spaceBetween = `spaceBetween
let spaceEvenly = `spaceEvenly
let stretch = `stretch
let url x = `url x
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
let content = `content
let maxContent = `maxContent
let minContent = `minContent
let fitContent = `fitContent
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

let flex3 ~grow ~shrink ~basis =
  D
    ( {js|flex|js},
      Std.Float.toString grow
      ^ {js| |js}
      ^ Std.Float.toString shrink
      ^ {js| |js}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flexBasis x =
  D
    ( {js|flexBasis|js},
      match x with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let order x = D ({js|order|js}, Std.Int.toString x)

let string_of_minmax x =
  match x with
  | `auto -> {js|auto|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {js|fr|js}
  | `minContent -> {js|min-content|js}
  | `maxContent -> {js|max-content|js}

let string_of_dimension x =
  match x with
  | `auto -> {js|auto|js}
  | `none -> {js|none|js}
  | `subgrid -> {js|subgrid|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {js|fr|js}
  | `fitContent -> {js|fit-content|js}
  | `minContent -> {js|min-content|js}
  | `maxContent -> {js|max-content|js}
  | `minmax (a, b) ->
    {js|minmax(|js}
    ^ string_of_minmax a
    ^ {js|,|js}
    ^ string_of_minmax b
    ^ {js|)|js}

type minmax =
  [ `fr of float
  | `minContent
  | `maxContent
  | `auto
  | Length.t
  ]

type trackLength =
  [ Length.t
  | `auto
  | `fr of float
  | `minContent
  | `maxContent
  | `minmax of minmax * minmax
  ]

type gridLength =
  [ trackLength
  | `repeat of RepeatValue.t * trackLength array
  ]

let rec gridLengthToJs x =
  match x with
  | `name name -> name
  | `subgrid -> {js|subgrid|js}
  | `none -> {js|none|js}
  | `auto -> {js|auto|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {js|fr|js}
  | `minContent -> {js|min-content|js}
  | `maxContent -> {js|max-content|js}
  | `fitContent x ->
    {js|fit-content|js} ^ {js|(|js} ^ Length.toString x ^ {js|)|js}
  | `repeat (n, x) ->
    {js|repeat(|js}
    ^ RepeatValue.toString n
    ^ {js|, |js}
    ^ string_of_dimensions x
    ^ {js|)|js}
  | `minmax (a, b) ->
    {js|minmax(|js}
    ^ string_of_minmax a
    ^ {js|,|js}
    ^ string_of_minmax b
    ^ {js|)|js}

and string_of_dimensions dimensions =
  dimensions
  |. Std.Array.map gridLengthToJs
  |. Std.Array.joinWith ~sep:{js| |js}

let gridTemplateColumns dimensions =
  D ({js|gridTemplateColumns|js}, string_of_dimensions dimensions)

let gridTemplateRows dimensions =
  D ({js|gridTemplateRows|js}, string_of_dimensions dimensions)

let gridAutoColumns dimensions =
  D ({js|gridAutoColumns|js}, string_of_dimension dimensions)

let gridAutoRows dimensions =
  D ({js|gridAutoRows|js}, string_of_dimension dimensions)

let gridArea s =
  D
    ( {js|gridArea|js},
      match s with
      | #GridArea.t as t -> GridArea.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridArea2 s s2 =
  D
    ( {js|gridArea|js},
      (GridArea.toString s ^ {js| / |js}) ^ GridArea.toString s2 )

let gridArea3 s s2 s3 =
  D
    ( {js|gridArea|js},
      GridArea.toString s
      ^ {js| / |js}
      ^ GridArea.toString s2
      ^ {js| / |js}
      ^ GridArea.toString s3 )

let gridArea4 s s2 s3 s4 =
  D
    ( {js|gridArea|js},
      GridArea.toString s
      ^ {js| / |js}
      ^ GridArea.toString s2
      ^ {js| / |js}
      ^ GridArea.toString s3
      ^ {js| / |js}
      ^ GridArea.toString s4 )

let gridTemplateAreas l =
  D
    ( {js|gridTemplateAreas|js},
      match l with
      | #GridTemplateAreas.t as t -> GridTemplateAreas.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

type filter =
  [ `blur of Length.t
  | `brightness of [ `percent of float | `num of float ]
  | `contrast of [ `percent of float | `num of float ]
  | `dropShadow of Length.t * Length.t * Length.t * [ Color.t | Var.t ]
  | `grayscale of [ `percent of float | `num of float ]
  | `hueRotate of angle
  | `invert of [ `percent of float | `num of float ]
  | `opacity of [ `percent of float | `num of float ]
  | `saturate of [ `percent of float | `num of float ]
  | `sepia of [ `percent of float | `num of float ]
  | `url of string
  | `none
  | Var.t
  | Cascading.t
  ]

let string_of_amount x =
  match x with
  | `percent v -> Std.Float.toString v ^ {js|%|js}
  | `num v -> Std.Float.toString v

let string_of_filter x =
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

let filter x =
  D
    ( {js|filter|js},
      x |. Std.Array.map string_of_filter |. Std.Array.joinWith ~sep:{js| |js}
    )

module Shadow = struct
  type 'a value = string
  type box
  type text

  type 'a t =
    [ `shadow of 'a value
    | `none
    ]

  let box ?(x = zero) ?(y = zero) ?(blur = zero) ?(spread = zero)
    ?(inset = false) color =
    `shadow
      (Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString blur
      ^ {js| |js}
      ^ Length.toString spread
      ^ {js| |js}
      ^ string_of_color color
      ^ if inset then {js| inset|js} else {js||js})

  let text ?(x = zero) ?(y = zero) ?(blur = zero) color =
    `shadow
      (Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString blur
      ^ {js| |js}
      ^ string_of_color color)

  let (toString : 'a t -> string) =
   fun x -> match x with `shadow x -> x | `none -> {js|none|js}
end

let boxShadow x =
  D
    ( {js|boxShadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let boxShadows x =
  D
    ( {js|boxShadow|js},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let string_of_borderstyle x =
  match x with
  | #BorderStyle.t as b -> BorderStyle.toString b
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let border px style color =
  D
    ( {js|border|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderStyle x = D ({js|borderStyle|js}, string_of_borderstyle x)

let borderLeft px style color =
  D
    ( {js|borderLeft|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderLeftStyle x = D ({js|borderLeftStyle|js}, string_of_borderstyle x)

let borderRight px style color =
  D
    ( {js|borderRight|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderRightStyle x = D ({js|borderRightStyle|js}, string_of_borderstyle x)

let borderTop px style color =
  D
    ( {js|borderTop|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderTopStyle x = D ({js|borderTopStyle|js}, string_of_borderstyle x)

let borderBottom px style color =
  D
    ( {js|borderBottom|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderBottomStyle x = D ({js|borderBottomStyle|js}, string_of_borderstyle x)

let background x =
  D
    ( {js|background|js},
      match x with
      | #Color.t as c -> Color.toString c
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g
      | `none -> {js|none|js} )

let backgrounds x =
  D
    ( {js|background|js},
      x
      |. Std.Array.map (fun item ->
             match item with
             | #Color.t as c -> Color.toString c
             | #Url.t as u -> Url.toString u
             | #Gradient.t as g -> Gradient.toString g
             | `none -> {js|none|js})
      |. Std.Array.joinWith ~sep:{js|, |js} )

let backgroundSize x =
  D
    ( {js|backgroundSize|js},
      match x with
      | `size (x, y) -> (Length.toString x ^ {js| |js}) ^ Length.toString y
      | `auto -> {js|auto|js}
      | `cover -> {js|cover|js}
      | `contain -> {js|contain|js} )

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let fontStyle =
    match fontStyle with
    | Some value -> {js|font-style: |js} ^ FontStyle.toString value ^ {js|;|js}
    | _ -> ""
  in
  let src =
    src
    |. Std.Array.map (fun x ->
           match x with
           | `localUrl value -> ({js|local("|js} ^ value) ^ {js|")|js}
           | `url value -> ({js|url("|js} ^ value) ^ {js|")|js})
    |. Std.Array.joinWith ~sep:{js|, |js}
  in
  let fontWeight =
    Belt.Option.mapWithDefault fontWeight {js||js} (fun w ->
        ({js|font-weight: |js}
        ^
        match w with
        | #FontWeight.t as f -> FontWeight.toString f
        | #Var.t as va -> Var.toString va
        | #Cascading.t as c -> Cascading.toString c)
        ^ {js|;|js})
  in
  let fontDisplay =
    Belt.Option.mapWithDefault fontDisplay {js||js} (fun f ->
        {js|font-display: |js} ^ FontDisplay.toString f ^ {js|;|js})
  in
  let sizeAdjust =
    Belt.Option.mapWithDefault sizeAdjust {js||js} (fun s ->
        {js|size-adjust: |js} ^ Percentage.toString s ^ {js|;|js})
  in
  {js|@font-face {|js}
  ^ ({js|font-family: |js} ^ fontFamily)
  ^ ({js|; src: |js} ^ src ^ {js|;|js})
  ^ fontStyle
  ^ fontWeight
  ^ fontDisplay
  ^ sizeAdjust
  ^ {js|}|js}

let textDecoration x =
  D
    ( {js|textDecoration|js},
      match x with
      | `none -> {js|none|js}
      | `underline -> {js|underline|js}
      | `overline -> {js|overline|js}
      | `lineThrough -> {js|line-through|js}
      | `initial -> {js|initial|js}
      | `inherit_ -> {js|inherit|js}
      | `unset -> {js|unset|js}
      | #Var.t as va -> Var.toString va )

let textShadow x =
  D
    ( {js|textShadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textShadows x =
  D
    ( {js|textShadow|js},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let transformStyle x =
  D
    ( {js|transformStyle|js},
      match x with
      | #TransformStyle.t as ts -> TransformStyle.toString ts
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

module Transition = struct
  type t = [ `value of string ]

  let shorthand ?(duration = `ms 0) ?(delay = `ms 0) ?(timingFunction = `ease)
    property : t =
    `value
      (Time.toString duration
      ^ {js| |js}
      ^ TimingFunction.toString timingFunction
      ^ {js| |js}
      ^ Time.toString delay
      ^ {js| |js}
      ^ property)

  let toString (x : t) = match x with `value v -> v
end

let transitionValue x = D ({js|transition|js}, Transition.toString x)

let transitionList x =
  D
    ( {js|transition|js},
      x
      |. Std.Array.map Transition.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let transitions = transitionList

let transition ?duration ?delay ?timingFunction property =
  transitionValue
    (Transition.shorthand ?duration ?delay ?timingFunction property)

let transitionDelay i = D ({js|transitionDelay|js}, Time.toString i)
let transitionDuration i = D ({js|transitionDuration|js}, Time.toString i)

let transitionTimingFunction x =
  D ({js|transitionTimingFunction|js}, TimingFunction.toString x)

let transitionProperty x = D ({js|transitionProperty|js}, x)

module Animation = struct
  type t = [ `value of string ]

  let shorthand ?(duration = `ms 0) ?(delay = `ms 0) ?(direction = `normal)
    ?(timingFunction = `ease) ?(fillMode = `none) ?(playState = `running)
    ?(iterationCount = `count 1.) name =
    `value
      (name
      ^ {js| |js}
      ^ Time.toString duration
      ^ {js| |js}
      ^ TimingFunction.toString timingFunction
      ^ {js| |js}
      ^ Time.toString delay
      ^ {js| |js}
      ^ AnimationIterationCount.toString iterationCount
      ^ {js| |js}
      ^ AnimationDirection.toString direction
      ^ {js| |js}
      ^ AnimationFillMode.toString fillMode
      ^ {js| |js}
      ^ AnimationPlayState.toString playState)

  let toString x = match x with `value v -> v
end

let animationValue x = D ({js|animation|js}, Animation.toString x)

let animation ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
  ?iterationCount name =
  animationValue
    (Animation.shorthand ?duration ?delay ?direction ?timingFunction ?fillMode
       ?playState ?iterationCount name)

let animations x =
  D
    ( {js|animation|js},
      x
      |. Std.Array.map Animation.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let animationName x = D ({js|animationName|js}, x)

module SVG = struct
  let fill x =
    D
      ( {js|fill|js},
        match x with
        | #SVG.Fill.t as f -> SVG.Fill.toString f
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v
        | #Url.t as u -> Url.toString u )

  let fillOpacity opacity = D ({js|fillOpacity|js}, Std.Float.toString opacity)

  let fillRule x =
    D
      ( {js|fillRule|js},
        match x with `evenodd -> {js|evenodd|js} | `nonzero -> {js|nonzero|js}
      )

  let stroke x = D ({js|stroke|js}, string_of_color x)

  let strokeDasharray x =
    D
      ( {js|strokeDasharray|js},
        match x with
        | `none -> {js|none|js}
        | `dasharray a ->
          a
          |. Std.Array.map string_of_dasharray
          |. Std.Array.joinWith ~sep:{js| |js} )

  let strokeWidth x = D ({js|strokeWidth|js}, Length.toString x)

  let strokeOpacity opacity =
    D ({js|strokeOpacity|js}, AlphaValue.toString opacity)

  let strokeMiterlimit x = D ({js|strokeMiterlimit|js}, Std.Float.toString x)

  let strokeLinecap x =
    D
      ( {js|strokeLinecap|js},
        match x with
        | `butt -> {js|butt|js}
        | `round -> {js|round|js}
        | `square -> {js|square|js} )

  let strokeLinejoin x =
    D
      ( {js|strokeLinejoin|js},
        match x with
        | `miter -> {js|miter|js}
        | `round -> {js|round|js}
        | `bevel -> {js|bevel|js} )

  let stopColor x = D ({js|stopColor|js}, string_of_color x)
  let stopOpacity x = D ({js|stopOpacity|js}, Std.Float.toString x)
end

let touchAction x = D ({js|touchAction|js}, x |. TouchAction.toString)
let textEmphasisColor x = D ({js|textEmphasisColor|js}, string_of_color x)

let lineBreak x =
  D
    ( {js|lineBreak|js},
      match x with
      | #LineBreak.t as lb -> LineBreak.toString lb
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let hyphens x =
  D
    ( {js|hyphens|js},
      match x with
      | #Hyphens.t as h -> Hyphens.toString h
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let textJustify x =
  D
    ( {js|textJustify|js},
      match x with
      | #TextJustify.t as tj -> TextJustify.toString tj
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowInline x =
  D
    ( {js|overflowInline|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowBlock x =
  D
    ( {js|overflowBlock|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisWeight x =
  D
    ( {js|fontSynthesisWeight|js},
      match x with
      | #FontSynthesisWeight.t as fsw -> FontSynthesisWeight.toString fsw
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisStyle x =
  D
    ( {js|fontSynthesisStyle|js},
      match x with
      | #FontSynthesisStyle.t as fss -> FontSynthesisStyle.toString fss
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisSmallCaps x =
  D
    ( {js|fontSynthesisSmallCaps|js},
      match x with
      | #FontSynthesisSmallCaps.t as fssc ->
        FontSynthesisSmallCaps.toString fssc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisPosition x =
  D
    ( {js|fontSynthesisWeight|js},
      match x with
      | #FontSynthesisPosition.t as fsp -> FontSynthesisPosition.toString fsp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontKerning x =
  D
    ( {js|fontKerning|js},
      match x with
      | #FontKerning.t as fk -> FontKerning.toString fk
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantPosition x =
  D
    ( {js|fontVariantPosition|js},
      match x with
      | #FontVariantPosition.t as fvp -> FontVariantPosition.toString fvp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantCaps x =
  D
    ( {js|fontVariantCaps|js},
      match x with
      | #FontVariantCaps.t as fvc -> FontVariantCaps.toString fvc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontOpticalSizing x =
  D
    ( {js|fontOpticalSizing|js},
      match x with
      | #FontOpticalSizing.t as fos -> FontOpticalSizing.toString fos
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantEmoji x =
  D
    ( {js|fontVariantEmoji|js},
      match x with
      | #FontVariantEmoji.t as fve -> FontVariantEmoji.toString fve
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )
