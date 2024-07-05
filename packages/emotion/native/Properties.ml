open Css_types

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

let important v =
  match v with
  | Rule.Declaration (name, value) ->
    Rule.Declaration (name, value ^ {js| !important|js})
  | Selector (_, _) -> v

let label label = Rule.Declaration ({js|label|js}, label)

let aspectRatio x =
  Rule.Declaration
    ( {js|aspect-ratio|js},
      match x with
      | #AspectRatio.t as ar -> AspectRatio.toString ar
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignContent x =
  Rule.Declaration
    ( {js|align-content|js},
      match x with
      | #AlignContent.t as ac -> AlignContent.toString ac
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignItems x =
  Rule.Declaration
    ( {js|align-items|js},
      match x with
      | #AlignItems.t as ai -> AlignItems.toString ai
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignSelf x =
  Rule.Declaration
    ( {js|align-self|js},
      match x with
      | #AlignSelf.t as a -> AlignSelf.toString a
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let animationDelay x =
  Rule.Declaration ({js|animation-delay|js}, Time.toString x)

let animationDirection x =
  Rule.Declaration ({js|animation-direction|js}, AnimationDirection.toString x)

let animationDuration x =
  Rule.Declaration ({js|animation-duration|js}, Time.toString x)

let animationFillMode x =
  Rule.Declaration ({js|animation-fill-mode|js}, AnimationFillMode.toString x)

let animationIterationCount x =
  Rule.Declaration
    ({js|animation-iteration-count|js}, AnimationIterationCount.toString x)

let animationPlayState x =
  Rule.Declaration ({js|animation-play-state|js}, AnimationPlayState.toString x)

let animationTimingFunction x =
  Rule.Declaration ({js|animation-timing-function|js}, TimingFunction.toString x)

let backfaceVisibility x =
  Rule.Declaration
    ( {js|backface-visibility|js},
      match x with
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backdropFilter x =
  Rule.Declaration
    ( {js|backdrop-filter|js},
      x |. Std.Array.map Filter.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let () =
  let _ = backdropFilter [| `none |] in
  ()

let backgroundAttachment x =
  Rule.Declaration
    ( {js|background-attachment|js},
      match x with
      | #BackgroundAttachment.t as ba -> BackgroundAttachment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundColor x =
  Rule.Declaration ({js|background-color|js}, string_of_color x)

let backgroundClip x =
  Rule.Declaration
    ( {js|background-clip|js},
      match x with
      | #BackgroundClip.t as bc -> BackgroundClip.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_backgroundImage x =
  match x with
  | #BackgroundImage.t as bi -> BackgroundImage.toString bi
  | #Url.t as u -> Url.toString u
  | #Gradient.t as g -> Gradient.toString g

let backgroundImage x =
  Rule.Declaration ({js|background-image|js}, string_of_backgroundImage x)

let backgroundImages imgs =
  Rule.Declaration
    ( {js|background-image|js},
      imgs
      |. Std.Array.map string_of_backgroundImage
      |. Std.Array.joinWith ~sep:{js|, |js} )

let maskImage x =
  Rule.Declaration
    ( {js|mask-image|js},
      match x with
      | #MaskImage.t as mi -> MaskImage.toString mi
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let imageRendering x =
  Rule.Declaration
    ( {js|image-rendering|js},
      match x with
      | #ImageRendering.t as ir -> ImageRendering.toString ir
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundOrigin x =
  Rule.Declaration
    ( {js|background-origin|js},
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
  Rule.Declaration ({js|background-position|js}, string_of_backgroundPosition x)

let backgroundPosition2 x y =
  Rule.Declaration
    ( {js|background-position|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let backgroundPositions bp =
  Rule.Declaration
    ( {js|background-position|js},
      bp
      |. Std.Array.map (fun (x, y) ->
             string_of_backgroundPosition x
             ^ {js| |js}
             ^ string_of_backgroundPosition y)
      |. Std.Array.joinWith ~sep:{js|, |js} )

let backgroundPosition4 ~x ~offsetX ~y ~offsetY =
  Rule.Declaration
    ( {js|backgroundPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ Length.toString offsetX
      ^ {js| |js}
      ^ string_of_backgroundPosition y
      ^ {js| |js}
      ^ Length.toString offsetY )

let backgroundRepeat x =
  Rule.Declaration
    ( {js|background-repeat|js},
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

let maskPosition x =
  Rule.Declaration ({js|mask-position|js}, string_of_maskposition x)

let maskPositions mp =
  Rule.Declaration
    ( {js|mask-position|js},
      mp
      |. Std.Array.map string_of_maskposition
      |. Std.Array.joinWith ~sep:{js|, |js} )

let borderImageSource x =
  Rule.Declaration
    ( {js|border-image-source|js},
      match x with
      | #BorderImageSource.t as b -> BorderImageSource.toString b
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let borderBottomColor x =
  Rule.Declaration ({js|border-bottom-color|js}, string_of_color x)

let borderBottomLeftRadius x =
  Rule.Declaration ({js|border-bottom-left-radius|js}, Length.toString x)

let borderBottomRightRadius x =
  Rule.Declaration ({js|border-bottom-right-radius|js}, Length.toString x)

let borderBottomWidth x =
  Rule.Declaration ({js|border-bottom-width|js}, LineWidth.toString x)

let borderCollapse x =
  Rule.Declaration
    ( {js|border-collapse|js},
      match x with
      | #BorderCollapse.t as bc -> BorderCollapse.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let borderColor x = Rule.Declaration ({js|border-color|js}, string_of_color x)

let borderLeftColor x =
  Rule.Declaration ({js|border-left-color|js}, string_of_color x)

let borderLeftWidth x =
  Rule.Declaration ({js|border-left-width|js}, LineWidth.toString x)

let borderSpacing x =
  Rule.Declaration ({js|border-spacing|js}, Length.toString x)

let borderRadius x = Rule.Declaration ({js|border-radius|js}, Length.toString x)

let borderRadius4 ~topLeft ~topRight ~bottomLeft ~bottomRight =
  Rule.Declaration
    ( {js|border-radius|js},
      Length.toString topLeft
      ^ {js| |js}
      ^ Length.toString topRight
      ^ {js| |js}
      ^ Length.toString bottomLeft
      ^ {js| |js}
      ^ Length.toString bottomRight )

let borderRightColor x =
  Rule.Declaration ({js|border-right-color|js}, string_of_color x)

let borderRightWidth x =
  Rule.Declaration ({js|border-right-width|js}, LineWidth.toString x)

let borderTopColor x =
  Rule.Declaration ({js|border-top-color|js}, string_of_color x)

let borderTopLeftRadius x =
  Rule.Declaration ({js|border-top-left-radius|js}, Length.toString x)

let borderTopRightRadius x =
  Rule.Declaration ({js|border-top-right-radius|js}, Length.toString x)

let borderTopWidth x =
  Rule.Declaration ({js|border-top-width|js}, LineWidth.toString x)

let borderWidth x = Rule.Declaration ({js|border-width|js}, LineWidth.toString x)
let bottom x = Rule.Declaration ({js|bottom|js}, string_of_position x)

let boxSizing x =
  Rule.Declaration
    ( {js|box-sizing|js},
      match x with
      | #BoxSizing.t as bs -> BoxSizing.toString bs
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clear x =
  Rule.Declaration
    ( {js|clear|js},
      match x with
      | #Clear.t as cl -> Clear.toString cl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clipPath x =
  Rule.Declaration
    ( {js|clip-path|js},
      match x with
      | #ClipPath.t as cp -> ClipPath.toString cp
      | #Url.t as u -> Url.toString u
      | #GeometryBox.t as gb -> GeometryBox.toString gb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let color x = Rule.Declaration ({js|color|js}, string_of_color x)

let columnCount x =
  Rule.Declaration
    ( {js|column-count|js},
      match x with
      | #ColumnCount.t as cc -> ColumnCount.toString cc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnGap x = Rule.Declaration ({js|column-gap|js}, string_of_column_gap x)
let rowGap x = Rule.Declaration ({js|row-gap|js}, string_of_row_gap x)
let contentRule x = Rule.Declaration ({js|content|js}, string_of_content x)

let contentRules xs =
  Rule.Declaration
    ( {js|content|js},
      xs |. Std.Array.map string_of_content |. Std.Array.joinWith ~sep:{js| |js}
    )

let counterIncrement x =
  Rule.Declaration ({js|counter-increment|js}, string_of_counter_increment x)

let countersIncrement xs =
  Rule.Declaration
    ( {js|counter-increment|js},
      xs
      |. Std.Array.map string_of_counter_increment
      |. Std.Array.joinWith ~sep:{js| |js} )

let counterReset x =
  Rule.Declaration ({js|counter-reset|js}, string_of_counter_reset x)

let countersReset xs =
  Rule.Declaration
    ( {js|counter-reset|js},
      xs
      |. Std.Array.map string_of_counter_reset
      |. Std.Array.joinWith ~sep:{js| |js} )

let counterSet x =
  Rule.Declaration ({js|counter-set|js}, string_of_counter_set x)

let countersSet xs =
  Rule.Declaration
    ( {js|counter-set|js},
      xs
      |. Std.Array.map string_of_counter_set
      |. Std.Array.joinWith ~sep:{js||js} )

let cursor x = Rule.Declaration ({js|cursor|js}, Cursor.toString x)

let direction x =
  Rule.Declaration
    ( {js|direction|js},
      match x with
      | #Direction.t as d -> Direction.toString d
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let display x =
  Rule.Declaration
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
  Rule.Declaration
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
  Rule.Declaration
    ( {js|flex|js},
      match x with
      | #Flex.t as f -> Flex.toString f
      | `num n -> Std.Float.toString n )

let flex2 ?basis ?shrink grow =
  Rule.Declaration
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
  Rule.Declaration
    ( {js|flex-direction|js},
      match x with
      | #FlexDirection.t as fd -> FlexDirection.toString fd
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flexGrow x = Rule.Declaration ({js|flex-grow|js}, Std.Float.toString x)
let flexShrink x = Rule.Declaration ({js|flex-shrink|js}, Std.Float.toString x)

let flexWrap x =
  Rule.Declaration
    ( {js|flex-wrap|js},
      match x with
      | #FlexWrap.t as fw -> FlexWrap.toString fw
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let float x =
  Rule.Declaration
    ( {js|float|js},
      match x with
      | #Float.t as f -> Float.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamily x =
  Rule.Declaration
    ( {js|font-family|js},
      match x with
      | #FontFamilyName.t as n -> FontFamilyName.toString n
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamilies xs =
  Rule.Declaration
    ( {js|font-family|js},
      xs
      |. Std.Array.map FontFamilyName.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let fontSize x =
  Rule.Declaration
    ( {js|font-size|js},
      match x with
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontStyle x =
  Rule.Declaration
    ( {js|font-style|js},
      match x with
      | #FontStyle.t as f -> FontStyle.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontVariant x =
  Rule.Declaration
    ( {js|font-variant|js},
      match x with
      | #FontVariant.t as f -> FontVariant.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontWeight x =
  Rule.Declaration
    ( {js|font-weight|js},
      match x with
      | #FontWeight.t as f -> FontWeight.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridAutoFlow x =
  Rule.Declaration
    ( {js|grid-auto-flow|js},
      match x with
      | #GridAutoFlow.t as f -> GridAutoFlow.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridColumn start end' =
  Rule.Declaration
    ( {js|grid-column|js},
      Std.Int.toString start ^ {js| / |js} ^ Std.Int.toString end' )

let gridColumnGap x =
  Rule.Declaration ({js|grid-column-gap|js}, string_of_column_gap x)

let gridColumnStart n =
  Rule.Declaration ({js|grid-column-start|js}, Std.Int.toString n)

let gridColumnEnd n =
  Rule.Declaration ({js|grid-column-end|js}, Std.Int.toString n)

let gridRow start end' =
  Rule.Declaration
    ( {js|grid-row|js},
      Std.Int.toString start ^ {js| / |js} ^ Std.Int.toString end' )

let gap x = Rule.Declaration ({js|gap|js}, string_of_gap x)
let gridGap x = Rule.Declaration ({js|grid-gap|js}, string_of_gap x)

let gap2 ~rowGap ~columnGap =
  Rule.Declaration
    ({js|gap|js}, string_of_gap rowGap ^ {js| |js} ^ string_of_gap columnGap)

let gridRowGap x =
  Rule.Declaration
    ( {js|grid-row-gap|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridRowEnd n = Rule.Declaration ({js|grid-row-end|js}, Std.Int.toString n)

let gridRowStart n =
  Rule.Declaration ({js|grid-row-start|js}, Std.Int.toString n)

let height x =
  Rule.Declaration
    ( {js|height|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyle x =
  Rule.Declaration
    ( {js|text-emphasis-style|js},
      match x with
      | #TextEmphasisStyle.t as tes -> TextEmphasisStyle.toString tes
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyles x y =
  Rule.Declaration
    ( {js|text-emphasis-styles|js},
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
        | #Var.t as va -> Var.toString va) )

let textEmphasisPosition' = function
  | #TextEmphasisPosition.OverOrUnder.t as ou ->
    TextEmphasisPosition.OverOrUnder.toString ou
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let textEmphasisPosition x =
  Rule.Declaration ({js|text-emphasis-position|js}, textEmphasisPosition' x)

let textEmphasisPositions x y =
  Rule.Declaration
    ( {js|text-emphasis-positions|js},
      textEmphasisPosition' x
      ^ {js| |js}
      ^
      match y with
      | #TextEmphasisPosition.LeftRightAlignment.t as lr ->
        TextEmphasisPosition.LeftRightAlignment.toString lr
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyContent x =
  Rule.Declaration
    ( {js|justify-content|js},
      match x with
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyItems x =
  Rule.Declaration
    ( {js|justify-items|js},
      match x with
      | `stretch -> {js|stretch|js}
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #LegacyAlignment.t as la -> LegacyAlignment.toString la
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let left x = Rule.Declaration ({js|left|js}, string_of_position x)

let letterSpacing x =
  Rule.Declaration
    ( {js|letter-spacing|js},
      match x with
      | #LetterSpacing.t as s -> LetterSpacing.toString s
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let lineHeight x =
  Rule.Declaration
    ( {js|line-height|js},
      match x with
      | #LineHeight.t as h -> LineHeight.toString h
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStyle style position image =
  Rule.Declaration
    ( {js|list-style|js},
      ListStyleType.toString style
      ^ {js| |js}
      ^ ListStylePosition.toString position
      ^ {js| |js}
      ^
      match image with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u )

let listStyleImage x =
  Rule.Declaration
    ( {js|list-style-image|js},
      match x with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u
      | #Var.t as va -> Var.toString va
      | #Gradient.t as g -> Gradient.toString g
      | #Cascading.t as c -> Cascading.toString c )

let listStyleType x =
  Rule.Declaration
    ( {js|list-style-type|js},
      match x with
      | #ListStyleType.t as lsp -> ListStyleType.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStylePosition x =
  Rule.Declaration
    ( {js|list-style-position|js},
      match x with
      | #ListStylePosition.t as lsp -> ListStylePosition.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let tabSize x =
  Rule.Declaration
    ( {|tab-size|},
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

let margin x = Rule.Declaration ({js|margin|js}, marginToString x)

let margin2 ~v ~h =
  Rule.Declaration
    ({js|margin|js}, marginToString v ^ {js| |js} ^ marginToString h)

let margin3 ~top ~h ~bottom =
  Rule.Declaration
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString h
      ^ {js| |js}
      ^ marginToString bottom )

let margin4 ~top ~right ~bottom ~left =
  Rule.Declaration
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString right
      ^ {js| |js}
      ^ marginToString bottom
      ^ {js| |js}
      ^ marginToString left )

let marginLeft x = Rule.Declaration ({js|margin-left|js}, marginToString x)
let marginRight x = Rule.Declaration ({js|margin-right|js}, marginToString x)
let marginTop x = Rule.Declaration ({js|margin-top|js}, marginToString x)
let marginBottom x = Rule.Declaration ({js|margin-bottom|js}, marginToString x)

let maxHeight x =
  Rule.Declaration
    ( {js|max-height|js},
      match x with
      | #Height.t as mh -> Height.toString mh
      | #MaxHeight.t as mh -> MaxHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let maxWidth x =
  Rule.Declaration
    ( {js|max-width|js},
      match x with
      | #Width.t as mw -> Width.toString mw
      | #MaxWidth.t as mw -> MaxWidth.toString mw
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minHeight x =
  Rule.Declaration
    ( {js|min-height|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #MinHeight.t as mh -> MinHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minWidth x =
  Rule.Declaration
    ( {js|min-width|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #MinWidth.t as w -> MinWidth.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectFit x =
  Rule.Declaration
    ( {js|object-fit|js},
      match x with
      | #ObjectFit.t as o -> ObjectFit.toString o
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectPosition x =
  Rule.Declaration ({js|object-position|js}, string_of_backgroundPosition x)

let objectPosition2 x y =
  Rule.Declaration
    ( {js|objectPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let opacity x = Rule.Declaration ({js|opacity|js}, Std.Float.toString x)

let outline size style color =
  Rule.Declaration
    ( {js|outline|js},
      LineWidth.toString size
      ^ {js| |js}
      ^ OutlineStyle.toString style
      ^ {js| |js}
      ^ string_of_color color )

let outlineColor x = Rule.Declaration ({js|outline-color|js}, string_of_color x)

let outlineOffset x =
  Rule.Declaration ({js|outline-offset|js}, Length.toString x)

let outlineStyle x =
  Rule.Declaration ({js|outline-style|js}, OutlineStyle.toString x)

let outlineWidth x =
  Rule.Declaration ({js|outline-width|js}, LineWidth.toString x)

let overflow x = Rule.Declaration ({js|overflow|js}, Overflow.toString x)
let overflowX x = Rule.Declaration ({js|overflow-x|js}, Overflow.toString x)
let overflowY x = Rule.Declaration ({js|overflow-y|js}, Overflow.toString x)

let overflowWrap x =
  Rule.Declaration
    ( {js|overflow-wrap|js},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let padding x = Rule.Declaration ({js|padding|js}, Length.toString x)

let padding2 ~v ~h =
  Rule.Declaration
    ({js|padding|js}, Length.toString v ^ {js| |js} ^ Length.toString h)

let padding3 ~top ~h ~bottom =
  Rule.Declaration
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString h
      ^ {js| |js}
      ^ Length.toString bottom )

let padding4 ~top ~right ~bottom ~left =
  Rule.Declaration
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString right
      ^ {js| |js}
      ^ Length.toString bottom
      ^ {js| |js}
      ^ Length.toString left )

let paddingBottom x =
  Rule.Declaration ({js|padding-bottom|js}, Length.toString x)

let paddingLeft x = Rule.Declaration ({js|padding-left|js}, Length.toString x)
let paddingRight x = Rule.Declaration ({js|padding-right|js}, Length.toString x)
let paddingTop x = Rule.Declaration ({js|padding-top|js}, Length.toString x)

let perspective x =
  Rule.Declaration
    ( {js|perspective|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let perspectiveOrigin x =
  Rule.Declaration
    ( {js|perspective-origin|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let perspectiveOrigin2 x y =
  Rule.Declaration
    ( {js|perspective-origin|js},
      (match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t)
      ^ {js| |js}
      ^
      match y with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let pointerEvents x =
  Rule.Declaration
    ( {js|pointer-events|js},
      match x with
      | #PointerEvents.t as p -> PointerEvents.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let position x =
  Rule.Declaration
    ( {js|position|js},
      match x with
      | #PropertyPosition.t as p -> PropertyPosition.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let isolation x =
  Rule.Declaration
    ( {js|isolation|js},
      match x with
      | #Isolation.t as i -> Isolation.toString i
      | #Cascading.t as c -> Cascading.toString c )

let justifySelf x =
  Rule.Declaration
    ( {js|justify-self|js},
      match x with
      | #JustifySelf.t as j -> JustifySelf.toString j
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let resize x =
  Rule.Declaration
    ( {js|resize|js},
      match x with
      | #Resize.t as r -> Resize.toString r
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let right x = Rule.Declaration ({js|right|js}, string_of_position x)

let tableLayout x =
  Rule.Declaration
    ( {js|table-layout|js},
      match x with
      | #TableLayout.t as tl -> TableLayout.toString tl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlign x =
  Rule.Declaration
    ( {js|text-align|js},
      match x with
      | #TextAlign.t as ta -> TextAlign.toString ta
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignAll x =
  Rule.Declaration
    ( {js|text-align-all|js},
      match x with
      | #TextAlignAll.t as taa -> TextAlignAll.toString taa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignLast x =
  Rule.Declaration
    ( {js|text-align-last|js},
      match x with
      | #TextAlignLast.t as tal -> TextAlignLast.toString tal
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationColor x =
  Rule.Declaration
    ( {js|text-decoration-color|js},
      match x with
      | #Color.t as co -> Color.toString co
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationLine x =
  Rule.Declaration
    ( {js|text-decoration-line|js},
      match x with
      | #TextDecorationLine.t as tdl -> TextDecorationLine.toString tdl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationStyle x =
  Rule.Declaration
    ( {js|text-decoration-style|js},
      match x with
      | #TextDecorationStyle.t as tds -> TextDecorationStyle.toString tds
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationThickness x =
  Rule.Declaration
    ( {js|text-decoration-thickness|js},
      match x with
      | #TextDecorationThickness.t as t -> TextDecorationThickness.toString t
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textIndent x =
  Rule.Declaration
    ( {js|text-indent|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInk x =
  Rule.Declaration
    ( {js|text-decoration-skip-ink|js},
      match x with
      | #TextDecorationSkipInk.t as tdsi -> TextDecorationSkipInk.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipBox x =
  Rule.Declaration
    ( {js|text-decoration-skip-box|js},
      match x with
      | #TextDecorationSkipBox.t as tdsb -> TextDecorationSkipBox.toString tdsb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInset x =
  Rule.Declaration
    ( {js|text-decoration-skip-inset|js},
      match x with
      | #TextDecorationSkipInset.t as tdsi ->
        TextDecorationSkipInset.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textOverflow x =
  Rule.Declaration
    ( {js|text-overflow|js},
      match x with
      | #TextOverflow.t as txo -> TextOverflow.toString txo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textTransform x =
  Rule.Declaration
    ( {js|text-transform|js},
      match x with
      | #TextTransform.t as tt -> TextTransform.toString tt
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let top x = Rule.Declaration ({js|top|js}, string_of_position x)

let transform x =
  Rule.Declaration
    ( {js|transform|js},
      match x with
      | `none -> {js|none|js}
      | #Transform.t as t -> Transform.toString t )

let transforms x =
  Rule.Declaration
    ( {js|transform|js},
      x |. Std.Array.map Transform.toString |. Std.Array.joinWith ~sep:{js| |js}
    )

let transformOrigin x =
  Rule.Declaration ({js|transform-origin|js}, TransformOrigin.toString x)

let transformOrigin2 x y =
  Rule.Declaration
    ( {js|transform-origin|js},
      TransformOrigin.toString x ^ {js| |js} ^ TransformOrigin.toString y )

let transformOrigin3d x y z =
  Rule.Declaration
    ( {js|transform-origin|js},
      Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString z
      ^ {js| |js} )

let transformBox x =
  Rule.Declaration
    ( {js|transform-box|js},
      match x with
      | #TransformBox.t as tb -> TransformBox.toString tb
      | #Cascading.t as c -> Cascading.toString c )

let explode s =
  let rec exp i l = if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

let camelCaseToKebabCase str =
  let insert_dash acc letter =
    match letter with
    | 'A' .. 'Z' as letter ->
      ("-" ^ String.make 1 (Char.lowercase_ascii letter)) :: acc
    | _ -> String.make 1 letter :: acc
  in
  String.concat "" (List.rev (List.fold_left insert_dash [] (explode str)))

let unsafe property value =
  Rule.declaration (camelCaseToKebabCase property) value

let userSelect x =
  Rule.Declaration
    ( {js|user-select|js},
      match x with
      | #UserSelect.t as us -> UserSelect.toString us
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let verticalAlign x =
  Rule.Declaration
    ( {js|vertical-align|js},
      match x with
      | #VerticalAlign.t as v -> VerticalAlign.toString v
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let visibility x =
  Rule.Declaration
    ( {js|visibility|js},
      match x with
      | #Visibility.t as v -> Visibility.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let scrollBehavior x =
  Rule.Declaration
    ( {js|scroll-behavior|js},
      match x with
      | #ScrollBehavior.t as sb -> ScrollBehavior.toString sb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overscrollBehavior x =
  Rule.Declaration
    ( {js|overscroll-behavior|js},
      match x with
      | #OverscrollBehavior.t as osb -> OverscrollBehavior.toString osb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overflowAnchor x =
  Rule.Declaration
    ( {js|overflow-anchor|js},
      match x with
      | #OverflowAnchor.t as oa -> OverflowAnchor.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnWidth x =
  Rule.Declaration
    ( {js|column-width|js},
      match x with
      | #ColumnWidth.t as cw -> ColumnWidth.toString cw
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let caretColor x =
  Rule.Declaration
    ( {js|caret-color|js},
      match x with
      | #CaretColor.t as ct -> CaretColor.toString ct
      | #Color.t as c -> Color.toString c
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let width x =
  Rule.Declaration
    ( {js|width|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let whiteSpace x =
  Rule.Declaration
    ( {js|white-space|js},
      match x with
      | #WhiteSpace.t as w -> WhiteSpace.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordBreak x =
  Rule.Declaration
    ( {js|word-break|js},
      match x with
      | #WordBreak.t as w -> WordBreak.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordSpacing x =
  Rule.Declaration
    ( {js|word-spacing|js},
      match x with
      | #WordSpacing.t as w -> WordSpacing.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordWrap x =
  Rule.Declaration
    ( {js|word-wrap|js},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let zIndex x = Rule.Declaration ({js|z-index|js}, ZIndex.toString x)

let flex3 ~grow ~shrink ~basis =
  Rule.Declaration
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
  Rule.Declaration
    ( {js|flex-basis|js},
      match x with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let order x = Rule.Declaration ({js|order|js}, Std.Int.toString x)

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
  | `none -> {js|none|js}
  | `auto -> {js|auto|js}
  | `subgrid -> {js|subgrid|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {js|fr|js}
  | `minContent -> {js|min-content|js}
  | `fitContent x ->
    {js|fit-content|js} ^ {js|(|js} ^ Length.toString x ^ {js|)|js}
  | `maxContent -> {js|max-content|js}
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
  Rule.Declaration
    ({js|grid-template-columns|js}, string_of_dimensions dimensions)

let gridTemplateRows dimensions =
  Rule.Declaration ({js|grid-template-rows|js}, string_of_dimensions dimensions)

let gridAutoColumns dimensions =
  Rule.Declaration ({js|grid-auto-columns|js}, string_of_dimension dimensions)

let gridAutoRows dimensions =
  Rule.Declaration ({js|grid-auto-rows|js}, string_of_dimension dimensions)

let gridArea s =
  Rule.Declaration
    ( {js|grid-area|js},
      match s with
      | #GridArea.t as t -> GridArea.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridArea2 s s2 =
  Rule.Declaration
    ( {js|grid-area|js},
      (GridArea.toString s ^ {js| / |js}) ^ GridArea.toString s2 )

let gridArea3 s s2 s3 =
  Rule.Declaration
    ( {js|grid-area|js},
      GridArea.toString s
      ^ {js|- |js}
      ^ GridArea.toString s2
      ^ {js|- |js}
      ^ GridArea.toString s3 )

let gridArea4 s s2 s3 s4 =
  Rule.Declaration
    ( {js|grid-area|js},
      GridArea.toString s
      ^ {js|- |js}
      ^ GridArea.toString s2
      ^ {js|- |js}
      ^ GridArea.toString s3
      ^ {js|- |js}
      ^ GridArea.toString s4 )

let gridTemplateAreas l =
  Rule.Declaration
    ( {js|grid-template-areas|js},
      match l with
      | #GridTemplateAreas.t as t -> GridTemplateAreas.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let filter x =
  Rule.Declaration
    ( {js|filter|js},
      x |. Std.Array.map Filter.toString |. Std.Array.joinWith ~sep:{js| |js} )

module Shadow = struct
  type 'a value = string
  type box
  type text

  type 'a t =
    [ `shadow of 'a value
    | `none
    ]

  let box ?(x = `zero) ?(y = `zero) ?(blur = `zero) ?(spread = `zero)
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
      ^ if inset then {js|inset|js} else {js||js})

  let text ?(x = `zero) ?(y = `zero) ?(blur = `zero) color =
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
  Rule.Declaration
    ( {js|box-shadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let boxShadows x =
  Rule.Declaration
    ( {js|box-shadow|js},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let string_of_borderstyle x =
  match x with
  | #BorderStyle.t as b -> BorderStyle.toString b
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let border px style color =
  Rule.Declaration
    ( {js|border|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderStyle x =
  Rule.Declaration ({js|border-style|js}, string_of_borderstyle x)

let borderLeft px style color =
  Rule.Declaration
    ( {js|border-left|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderLeftStyle x =
  Rule.Declaration ({js|border-left-style|js}, string_of_borderstyle x)

let borderRight px style color =
  Rule.Declaration
    ( {js|border-right|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderRightStyle x =
  Rule.Declaration ({js|border-right-style|js}, string_of_borderstyle x)

let borderTop px style color =
  Rule.Declaration
    ( {js|border-top|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderTopStyle x =
  Rule.Declaration ({js|border-top-style|js}, string_of_borderstyle x)

let borderBottom px style color =
  Rule.Declaration
    ( {js|border-bottom|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ string_of_color color )

let borderBottomStyle x =
  Rule.Declaration ({js|border-bottom-style|js}, string_of_borderstyle x)

let background x =
  Rule.Declaration
    ( {js|background|js},
      match x with
      | #Color.t as c -> Color.toString c
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g
      | `none -> {js|none|js} )

let backgrounds x =
  Rule.Declaration
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
  Rule.Declaration
    ( {js|background-size|js},
      match x with
      | `size (x, y) -> (Length.toString x ^ {js| |js}) ^ Length.toString y
      | `auto -> {js|auto|js}
      | `cover -> {js|cover|js}
      | `contain -> {js|contain|js} )

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let src =
    src
    |. Std.Array.map (fun x ->
           match x with
           | `localUrl value -> {js|local("|js} ^ value ^ {js|")|js}
           | `url value -> {js|url("|js} ^ value ^ {js|")|js})
    |. Std.Array.joinWith ~sep:{js|, |js}
  in
  let fontStyle =
    Belt.Option.mapWithDefault fontStyle {js||js} (fun s ->
        {js|font-style: |js} ^ FontStyle.toString s ^ {js|;|js})
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
        ({js|font-display: |js} ^ FontDisplay.toString f) ^ {js|;|js})
  in
  let sizeAdjust =
    Belt.Option.mapWithDefault sizeAdjust {js||js} (fun s ->
        ({js|size-adjust: |js} ^ Percentage.toString s) ^ {js|;|js})
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
  Rule.Declaration
    ( {js|text-decoration|js},
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
  Rule.Declaration
    ( {js|text-shadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textShadows x =
  Rule.Declaration
    ( {js|text-shadow|js},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{js|, |js}
    )

let transformStyle x =
  Rule.Declaration
    ( {js|transform-style|js},
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

let transitionValue x =
  Rule.Declaration ({js|transition|js}, Transition.toString x)

let transitionList x =
  Rule.Declaration
    ( {js|transition|js},
      x
      |. Std.Array.map Transition.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let transitions = transitionList

let transition ?duration ?delay ?timingFunction property =
  transitionValue
    (Transition.shorthand ?duration ?delay ?timingFunction property)

let transitionDelay i =
  Rule.Declaration ({js|transition-delay|js}, Time.toString i)

let transitionDuration i =
  Rule.Declaration ({js|transition-duration|js}, Time.toString i)

let transitionTimingFunction x =
  Rule.Declaration
    ({js|transition-timing-function|js}, TimingFunction.toString x)

let transitionProperty x = Rule.Declaration ({js|transition-property|js}, x)

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

let animationValue x = Rule.Declaration ({js|animation|js}, Animation.toString x)

let animation ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
  ?iterationCount name =
  animationValue
    (Animation.shorthand ?duration ?delay ?direction ?timingFunction ?fillMode
       ?playState ?iterationCount name)

let animations x =
  Rule.Declaration
    ( {js|animation|js},
      x
      |. Std.Array.map Animation.toString
      |. Std.Array.joinWith ~sep:{js|, |js} )

let animationName x = Rule.Declaration ({js|animation-name|js}, x)

module SVG = struct
  let fill x =
    Rule.Declaration
      ( {js|fill|js},
        match x with
        | #SVG.Fill.t as f -> SVG.Fill.toString f
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v
        | #Url.t as u -> Url.toString u )

  let fillOpacity opacity =
    Rule.Declaration ({js|fill-opacity|js}, Std.Float.toString opacity)

  let fillRule x =
    Rule.Declaration
      ( {js|fill-rule|js},
        match x with `evenodd -> {js|evenodd|js} | `nonzero -> {js|nonzero|js}
      )

  let stroke x = Rule.Declaration ({js|stroke|js}, string_of_color x)

  let strokeDasharray x =
    Rule.Declaration
      ( {js|stroke-dasharray|js},
        match x with
        | `none -> {js|none|js}
        | `dasharray a ->
          a
          |. Std.Array.map string_of_dasharray
          |. Std.Array.joinWith ~sep:{js||js} )

  let strokeWidth x = Rule.Declaration ({js|stroke-width|js}, Length.toString x)

  let strokeOpacity opacity =
    Rule.Declaration ({js|stroke-opacity|js}, AlphaValue.toString opacity)

  let strokeMiterlimit x =
    Rule.Declaration ({js|stroke-miterlimit|js}, Std.Float.toString x)

  let strokeLinecap x =
    Rule.Declaration
      ( {js|stroke-linecap|js},
        match x with
        | `butt -> {js|butt|js}
        | `round -> {js|round|js}
        | `square -> {js|square|js} )

  let strokeLinejoin x =
    Rule.Declaration
      ( {js|stroke-linejoin|js},
        match x with
        | `miter -> {js|miter|js}
        | `round -> {js|round|js}
        | `bevel -> {js|bevel|js} )

  let stopColor x = Rule.Declaration ({js|stop-color|js}, string_of_color x)

  let stopOpacity x =
    Rule.Declaration ({js|stop-opacity|js}, Std.Float.toString x)
end

let touchAction x =
  Rule.Declaration ({js|touch-action|js}, x |. TouchAction.toString)

let textEmphasisColor x =
  Rule.Declaration ({js|text-emphasis-color|js}, string_of_color x)

let lineBreak x =
  Rule.Declaration
    ( {js|line-break|js},
      match x with
      | #LineBreak.t as lb -> LineBreak.toString lb
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let hyphens x =
  Rule.Declaration
    ( {js|hyphens|js},
      match x with
      | #Hyphens.t as h -> Hyphens.toString h
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let textJustify x =
  Rule.Declaration
    ( {js|text-justify|js},
      match x with
      | #TextJustify.t as tj -> TextJustify.toString tj
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowInline x =
  Rule.Declaration
    ( {js|overflow-inline|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowBlock x =
  Rule.Declaration
    ( {js|overflow-block|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisWeight x =
  Rule.Declaration
    ( {js|font-synthesis-weight|js},
      match x with
      | #FontSynthesisWeight.t as fsw -> FontSynthesisWeight.toString fsw
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisStyle x =
  Rule.Declaration
    ( {js|font-synthesis-style|js},
      match x with
      | #FontSynthesisStyle.t as fss -> FontSynthesisStyle.toString fss
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisSmallCaps x =
  Rule.Declaration
    ( {js|font-synthesis-small-caps|js},
      match x with
      | #FontSynthesisSmallCaps.t as fssc ->
        FontSynthesisSmallCaps.toString fssc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisPosition x =
  Rule.Declaration
    ( {js|font-synthesis-weight|js},
      match x with
      | #FontSynthesisPosition.t as fsp -> FontSynthesisPosition.toString fsp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontKerning x =
  Rule.Declaration
    ( {js|font-kerning|js},
      match x with
      | #FontKerning.t as fk -> FontKerning.toString fk
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantPosition x =
  Rule.Declaration
    ( {js|font-variant-position|js},
      match x with
      | #FontVariantPosition.t as fvp -> FontVariantPosition.toString fvp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantCaps x =
  Rule.Declaration
    ( {js|font-variant-caps|js},
      match x with
      | #FontVariantCaps.t as fvc -> FontVariantCaps.toString fvc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontOpticalSizing x =
  Rule.Declaration
    ( {js|font-optical-sizing|js},
      match x with
      | #FontOpticalSizing.t as fos -> FontOpticalSizing.toString fos
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantEmoji x =
  Rule.Declaration
    ( {js|font-variant-emoji|js},
      match x with
      | #FontVariantEmoji.t as fve -> FontVariantEmoji.toString fve
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )
