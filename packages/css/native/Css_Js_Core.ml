open Css_AtomicTypes
module Std = Kloth

type rule =
  | D of string * string
  | S of string * rule array
  | PseudoClass of string * rule array
  | PseudoClassParam of string * string * rule array

type animationName = string

let join strings separator =
  Std.Array.reduceWithIndexU strings {||} (fun [@u] acc item index ->
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
    | `auto -> {|auto|}
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
  | D (name, value) -> D (name, value ^ {| !important|})
  | S (_, _) | PseudoClass (_, _) | PseudoClassParam (_, _, _) -> v

let label label = D ({|label|}, label)

let alignContent x =
  D
    ( {|align-content|},
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
    ( {|align-items|},
      match x with
      | #AlignItems.t as ai -> AlignItems.toString ai
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignSelf x =
  D
    ( {|align-self|},
      match x with
      | #AlignSelf.t as a -> AlignSelf.toString a
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let animationDelay x = D ({|animation-delay|}, Time.toString x)

let animationDirection x =
  D ({|animation-direction|}, AnimationDirection.toString x)

let animationDuration x = D ({|animation-duration|}, Time.toString x)

let animationFillMode x =
  D ({|animation-fill-mode|}, AnimationFillMode.toString x)

let animationIterationCount x =
  D ({|animation-iteration-count|}, AnimationIterationCount.toString x)

let animationPlayState x =
  D ({|animation-play-state|}, AnimationPlayState.toString x)

let animationTimingFunction x =
  D ({|animation-timing-function|}, TimingFunction.toString x)

let backfaceVisibility x =
  D
    ( {|backface-visibility|},
      match x with
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backdropFilter x =
  D
    ( {|backdrop-filter|},
      x |. Std.Array.map Filter.toString |. Std.Array.joinWith ~sep:{|, |} )

let () =
  let _ = backdropFilter [| `none |] in
  ()

let backgroundAttachment x =
  D
    ( {|background-attachment|},
      match x with
      | #BackgroundAttachment.t as ba -> BackgroundAttachment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundColor x = D ({|background-color|}, string_of_color x)

let backgroundClip x =
  D
    ( {|background-clip|},
      match x with
      | #BackgroundClip.t as bc -> BackgroundClip.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_backgroundImage x =
  match x with
  | #BackgroundImage.t as bi -> BackgroundImage.toString bi
  | #Url.t as u -> Url.toString u
  | #Gradient.t as g -> Gradient.toString g

let backgroundImage x = D ({|background-image|}, string_of_backgroundImage x)

let backgroundImages imgs =
  D
    ( {|background-image|},
      imgs
      |. Std.Array.map string_of_backgroundImage
      |. Std.Array.joinWith ~sep:{|, |} )

let maskImage x =
  D
    ( {|mask-image|},
      match x with
      | #MaskImage.t as mi -> MaskImage.toString mi
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let imageRendering x =
  D
    ( {|image-rendering|},
      match x with
      | #ImageRendering.t as ir -> ImageRendering.toString ir
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundOrigin x =
  D
    ( {|background-origin|},
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
  D ({|backgroundPosition|}, string_of_backgroundPosition x)

let backgroundPosition2 x y =
  D
    ( {|backgroundPosition|},
      string_of_backgroundPosition x ^ {| |} ^ string_of_backgroundPosition y )

let backgroundPositions bp =
  D
    ( {|backgroundPosition|},
      bp
      |. Std.Array.map (fun (x, y) ->
             string_of_backgroundPosition x
             ^ {| |}
             ^ string_of_backgroundPosition y)
      |. Std.Array.joinWith ~sep:{|, |} )

let backgroundPosition4 ~x ~offsetX ~y ~offsetY =
  D
    ( {|backgroundPosition|},
      string_of_backgroundPosition x
      ^ {| |}
      ^ Length.toString offsetX
      ^ {| |}
      ^ string_of_backgroundPosition y
      ^ {| |}
      ^ Length.toString offsetY )

let backgroundRepeat x =
  D
    ( {|background-repeat|},
      match x with
      | #BackgroundRepeat.t as br -> BackgroundRepeat.toString br
      | `hv
          ( (#BackgroundRepeat.horizontal as h),
            (#BackgroundRepeat.vertical as v) ) ->
        BackgroundRepeat.toString h ^ {| |} ^ BackgroundRepeat.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_maskposition x =
  match x with
  | #MaskPosition.t as mp -> MaskPosition.toString mp
  | `hv (h, v) ->
    (match h with
    | #MaskPosition.X.t as h -> MaskPosition.X.toString h
    | #Length.t as l -> Length.toString l)
    ^ {| |}
    ^
    (match v with
    | #MaskPosition.Y.t as v -> MaskPosition.Y.toString v
    | #Length.t as l -> Length.toString l)
  | #Length.t as l -> Length.toString l
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let maskPosition x = D ({|mask-position|}, string_of_maskposition x)

let maskPositions mp =
  D
    ( {|mask-position|},
      mp
      |. Std.Array.map string_of_maskposition
      |. Std.Array.joinWith ~sep:{|, |} )

let borderImageSource x =
  D
    ( {|border-image-source|},
      match x with
      | #BorderImageSource.t as b -> BorderImageSource.toString b
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let borderBottomColor x = D ({|border-bottom-color|}, string_of_color x)

let borderBottomLeftRadius x =
  D ({|border-bottom-left-radius|}, Length.toString x)

let borderBottomRightRadius x =
  D ({|border-bottom-right-radius|}, Length.toString x)

let borderBottomWidth x = D ({|border-bottom-width|}, LineWidth.toString x)

let borderCollapse x =
  D
    ( {|border-collapse|},
      match x with
      | #BorderCollapse.t as bc -> BorderCollapse.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let borderColor x = D ({|border-color|}, string_of_color x)
let borderLeftColor x = D ({|border-left-color|}, string_of_color x)
let borderLeftWidth x = D ({|border-left-width|}, LineWidth.toString x)
let borderSpacing x = D ({|border-spacing|}, Length.toString x)
let borderRadius x = D ({|border-radius|}, Length.toString x)

let borderRadius4 ~topLeft ~topRight ~bottomLeft ~bottomRight =
  D
    ( {|border-radius|},
      Length.toString topLeft
      ^ {| |}
      ^ Length.toString topRight
      ^ {| |}
      ^ Length.toString bottomLeft
      ^ {| |}
      ^ Length.toString bottomRight )

let borderRightColor x = D ({|border-right-color|}, string_of_color x)
let borderRightWidth x = D ({|border-right-width|}, LineWidth.toString x)
let borderTopColor x = D ({|border-top-color|}, string_of_color x)
let borderTopLeftRadius x = D ({|border-top-left-radius|}, Length.toString x)
let borderTopRightRadius x = D ({|border-top-right-radius|}, Length.toString x)
let borderTopWidth x = D ({|border-top-width|}, LineWidth.toString x)
let borderWidth x = D ({|border-width|}, LineWidth.toString x)
let bottom x = D ({|bottom|}, string_of_position x)

let boxSizing x =
  D
    ( {|box-sizing|},
      match x with
      | #BoxSizing.t as bs -> BoxSizing.toString bs
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clear x =
  D
    ( {|clear|},
      match x with
      | #Clear.t as cl -> Clear.toString cl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clipPath x =
  D
    ( {|clip-path|},
      match x with
      | #ClipPath.t as cp -> ClipPath.toString cp
      | #Url.t as u -> Url.toString u
      | #GeometryBox.t as gb -> GeometryBox.toString gb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let color x = D ({|color|}, string_of_color x)

let columnCount x =
  D
    ( {|column-count|},
      match x with
      | #ColumnCount.t as cc -> ColumnCount.toString cc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let rowGap x = D ({|row-gap|}, string_of_row_gap x)
let columnGap x = D ({|column-gap|}, string_of_column_gap x)
let contentRule x = D ({|content|}, string_of_content x)

let contentRules xs =
  D
    ( {|content|},
      xs |. Std.Array.map string_of_content |. Std.Array.joinWith ~sep:{| |} )

let counterIncrement x = D ({|counter-increment|}, string_of_counter_increment x)

let countersIncrement xs =
  D
    ( {|counter-increment|},
      xs
      |. Std.Array.map string_of_counter_increment
      |. Std.Array.joinWith ~sep:{| |} )

let counterReset x = D ({|counter-reset|}, string_of_counter_reset x)

let countersReset xs =
  D
    ( {|counter-reset|},
      xs
      |. Std.Array.map string_of_counter_reset
      |. Std.Array.joinWith ~sep:{| |} )

let counterSet x = D ({|counter-set|}, string_of_counter_set x)

let countersSet xs =
  D
    ( {|counter-set|},
      xs |. Std.Array.map string_of_counter_set |. Std.Array.joinWith ~sep:{||}
    )

let cursor x = D ({|cursor|}, Cursor.toString x)

let direction x =
  D
    ( {|direction|},
      match x with
      | #Direction.t as d -> Direction.toString d
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let display x =
  D
    ( {|display|},
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
    ( {|flex|},
      Std.Float.toString grow
      ^ {| |}
      ^ Std.Float.toString shrink
      ^ {| |}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flex1 x =
  D
    ( {|flex|},
      match x with
      | #Flex.t as f -> Flex.toString f
      | `num n -> Std.Float.toString n )

let flex2 ?basis ?shrink grow =
  D
    ( {|flex|},
      Std.Float.toString grow
      ^ (match shrink with
        | Some s -> {| |} ^ Std.Float.toString s
        | None -> {||})
      ^
      match basis with
      | Some (#FlexBasis.t as b) -> {| |} ^ FlexBasis.toString b
      | Some (#Length.t as l) -> {| |} ^ Length.toString l
      | None -> {||} )

let flexDirection x =
  D
    ( {|flex-direction|},
      match x with
      | #FlexDirection.t as fd -> FlexDirection.toString fd
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flexGrow x = D ({|flex-grow|}, Std.Float.toString x)
let flexShrink x = D ({|flex-shrink|}, Std.Float.toString x)

let flexWrap x =
  D
    ( {|flex-wrap|},
      match x with
      | #FlexWrap.t as fw -> FlexWrap.toString fw
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let float x =
  D
    ( {|float|},
      match x with
      | #Float.t as f -> Float.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamily x =
  D
    ( {|font-family|},
      match x with
      | #FontFamilyName.t as n -> FontFamilyName.toString n
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamilies xs =
  D
    ( {|font-family|},
      xs
      |. Std.Array.map FontFamilyName.toString
      |. Std.Array.joinWith ~sep:{|, |} )

let fontSize x =
  D
    ( {|font-size|},
      match x with
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontStyle x =
  D
    ( {|font-style|},
      match x with
      | #FontStyle.t as f -> FontStyle.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontVariant x =
  D
    ( {|font-variant|},
      match x with
      | #FontVariant.t as f -> FontVariant.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontWeight x =
  D
    ( {|font-weight|},
      match x with
      | #FontWeight.t as f -> FontWeight.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridAutoFlow x =
  D
    ( {|grid-auto-flow|},
      match x with
      | #GridAutoFlow.t as f -> GridAutoFlow.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridColumn start end' =
  D ({|grid-column|}, Std.Int.toString start ^ {|- |} ^ Std.Int.toString end')

let gridColumnGap x = D ({|grid-column-gap|}, string_of_column_gap x)
let gridColumnStart n = D ({|grid-column-start|}, Std.Int.toString n)
let gridColumnEnd n = D ({|grid-column-end|}, Std.Int.toString n)

let gridRow start end' =
  D ({|grid-row|}, Std.Int.toString start ^ {|- |} ^ Std.Int.toString end')

let gap x = D ({|gap|}, string_of_gap x)
let gridGap x = D ({|grid-gap|}, string_of_gap x)

let gap2 ~rowGap ~columnGap =
  D ({|gap|}, string_of_gap rowGap ^ {| |} ^ string_of_gap columnGap)

let gridRowGap x =
  D
    ( {|grid-row-gap|},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridRowEnd n = D ({|grid-row-end|}, Std.Int.toString n)
let gridRowStart n = D ({|grid-row-start|}, Std.Int.toString n)

let height x =
  D
    ( {|height|},
      match x with
      | #Height.t as h -> Height.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyle x =
  D
    ( {|text-emphasis-style|},
      match x with
      | #TextEmphasisStyle.t as tes -> TextEmphasisStyle.toString tes
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyles x y =
  D
    ( {|text-emphasis-styles|},
      match x with
      | #TextEmphasisStyle.FilledOrOpen.t as fo ->
        TextEmphasisStyle.FilledOrOpen.toString fo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c ->
        Cascading.toString c
        ^ {| |}
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
  D ({|text-emphasis-position|}, textEmphasisPosition' x)

let textEmphasisPositions x y =
  D
    ( {|text-emphasis-positions|},
      textEmphasisPosition' x
      ^ {| |}
      ^
      match y with
      | #TextEmphasisPosition.LeftRightAlignment.t as lr ->
        TextEmphasisPosition.LeftRightAlignment.toString lr
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyContent x =
  D
    ( {|justify-content|},
      match x with
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyItems x =
  D
    ( {|justify-items|},
      match x with
      | `stretch -> {|stretch|}
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #LegacyAlignment.t as la -> LegacyAlignment.toString la
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let left x = D ({|left|}, string_of_position x)

let letterSpacing x =
  D
    ( {|letter-spacing|},
      match x with
      | #LetterSpacing.t as s -> LetterSpacing.toString s
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let lineHeight x =
  D
    ( {|line-height|},
      match x with
      | #LineHeight.t as h -> LineHeight.toString h
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStyle style position image =
  D
    ( {|list-style|},
      ListStyleType.toString style
      ^ {| |}
      ^ ListStylePosition.toString position
      ^ {| |}
      ^
      match image with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u )

let listStyleImage x =
  D
    ( {|list-style-image|},
      match x with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u
      | #Var.t as va -> Var.toString va
      | #Gradient.t as g -> Gradient.toString g
      | #Cascading.t as c -> Cascading.toString c )

let listStyleType x =
  D
    ( {|list-style-type|},
      match x with
      | #ListStyleType.t as lsp -> ListStyleType.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStylePosition x =
  D
    ( {|list-style-position|},
      match x with
      | #ListStylePosition.t as lsp -> ListStylePosition.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let tabSize x =
  D
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

let margin x = D ({|margin|}, marginToString x)
let margin2 ~v ~h = D ({|margin|}, marginToString v ^ {| |} ^ marginToString h)

let margin3 ~top ~h ~bottom =
  D
    ( {|margin|},
      marginToString top
      ^ {| |}
      ^ marginToString h
      ^ {| |}
      ^ marginToString bottom )

let margin4 ~top ~right ~bottom ~left =
  D
    ( {|margin|},
      marginToString top
      ^ {| |}
      ^ marginToString right
      ^ {| |}
      ^ marginToString bottom
      ^ {| |}
      ^ marginToString left )

let marginLeft x = D ({|margin-left|}, marginToString x)
let marginRight x = D ({|margin-right|}, marginToString x)
let marginTop x = D ({|margin-top|}, marginToString x)
let marginBottom x = D ({|margin-bottom|}, marginToString x)

let maxHeight x =
  D
    ( {|max-height|},
      match x with
      | #Height.t as mh -> Height.toString mh
      | #MaxHeight.t as mh -> MaxHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let maxWidth x =
  D
    ( {|max-width|},
      match x with
      | #Width.t as mw -> Width.toString mw
      | #MaxWidth.t as mw -> MaxWidth.toString mw
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minHeight x =
  D
    ( {|min-height|},
      match x with
      | #Height.t as h -> Height.toString h
      | #MinHeight.t as mh -> MinHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minWidth x =
  D
    ( {|min-width|},
      match x with
      | #Width.t as w -> Width.toString w
      | #MinWidth.t as w -> MinWidth.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectFit x =
  D
    ( {|object-fit|},
      match x with
      | #ObjectFit.t as o -> ObjectFit.toString o
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectPosition x = D ({|object-position|}, string_of_backgroundPosition x)

let objectPosition2 x y =
  D
    ( {|objectPosition|},
      string_of_backgroundPosition x ^ {| |} ^ string_of_backgroundPosition y )

let opacity x = D ({|opacity|}, Std.Float.toString x)

let outline size style color =
  D
    ( {|outline|},
      LineWidth.toString size
      ^ {| |}
      ^ OutlineStyle.toString style
      ^ {| |}
      ^ string_of_color color )

let outlineColor x = D ({|outline-color|}, string_of_color x)
let outlineOffset x = D ({|outline-offset|}, Length.toString x)
let outlineStyle x = D ({|outline-style|}, OutlineStyle.toString x)
let outlineWidth x = D ({|outline-width|}, LineWidth.toString x)
let overflow x = D ({|overflow|}, Overflow.toString x)
let overflowX x = D ({|overflow-x|}, Overflow.toString x)
let overflowY x = D ({|overflow-y|}, Overflow.toString x)

let overflowWrap x =
  D
    ( {|overflow-wrap|},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let padding x = D ({|padding|}, Length.toString x)

let padding2 ~v ~h =
  D ({|padding|}, Length.toString v ^ {| |} ^ Length.toString h)

let padding3 ~top ~h ~bottom =
  D
    ( {|padding|},
      Length.toString top
      ^ {| |}
      ^ Length.toString h
      ^ {| |}
      ^ Length.toString bottom )

let padding4 ~top ~right ~bottom ~left =
  D
    ( {|padding|},
      Length.toString top
      ^ {| |}
      ^ Length.toString right
      ^ {| |}
      ^ Length.toString bottom
      ^ {| |}
      ^ Length.toString left )

let paddingBottom x = D ({|padding-bottom|}, Length.toString x)
let paddingLeft x = D ({|padding-left|}, Length.toString x)
let paddingRight x = D ({|padding-right|}, Length.toString x)
let paddingTop x = D ({|padding-top|}, Length.toString x)

let perspective x =
  D
    ( {|perspective|},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let perspectiveOrigin x =
  D
    ( {|perspective-origin|},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let perspectiveOrigin2 x y =
  D
    ( {|perspective-origin|},
      (match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t)
      ^ {| |}
      ^
      match y with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let pointerEvents x =
  D
    ( {|pointer-events|},
      match x with
      | #PointerEvents.t as p -> PointerEvents.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let position x =
  D
    ( {|position|},
      match x with
      | #PropertyPosition.t as p -> PropertyPosition.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let isolation x =
  D
    ( {|isolation|},
      match x with
      | #Isolation.t as i -> Isolation.toString i
      | #Cascading.t as c -> Cascading.toString c )

let justifySelf x =
  D
    ( {|justify-self|},
      match x with
      | #JustifySelf.t as j -> JustifySelf.toString j
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let resize x =
  D
    ( {|resize|},
      match x with
      | #Resize.t as r -> Resize.toString r
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let right x = D ({|right|}, string_of_position x)

let tableLayout x =
  D
    ( {|table-layout|},
      match x with
      | #TableLayout.t as tl -> TableLayout.toString tl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlign x =
  D
    ( {|text-align|},
      match x with
      | #TextAlign.t as ta -> TextAlign.toString ta
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignAll x =
  D
    ( {|text-align-all|},
      match x with
      | #TextAlignAll.t as taa -> TextAlignAll.toString taa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignLast x =
  D
    ( {|text-align-last|},
      match x with
      | #TextAlignLast.t as tal -> TextAlignLast.toString tal
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationColor x =
  D
    ( {|text-decoration-color|},
      match x with
      | #Color.t as co -> Color.toString co
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationLine x =
  D
    ( {|text-decoration-line|},
      match x with
      | #TextDecorationLine.t as tdl -> TextDecorationLine.toString tdl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationStyle x =
  D
    ( {|text-decoration-style|},
      match x with
      | #TextDecorationStyle.t as tds -> TextDecorationStyle.toString tds
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationThickness x =
  D
    ( {|text-decoration-thickness|},
      match x with
      | #TextDecorationThickness.t as t -> TextDecorationThickness.toString t
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textIndent x =
  D
    ( {|text-indent|},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInk x =
  D
    ( {|text-decoration-skip-ink|},
      match x with
      | #TextDecorationSkipInk.t as tdsi -> TextDecorationSkipInk.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipBox x =
  D
    ( {|text-decoration-skip-box|},
      match x with
      | #TextDecorationSkipBox.t as tdsb -> TextDecorationSkipBox.toString tdsb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInset x =
  D
    ( {|text-decoration-skip-inset|},
      match x with
      | #TextDecorationSkipInset.t as tdsi ->
        TextDecorationSkipInset.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textOverflow x =
  D
    ( {|text-overflow|},
      match x with
      | #TextOverflow.t as txo -> TextOverflow.toString txo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textTransform x =
  D
    ( {|text-transform|},
      match x with
      | #TextTransform.t as tt -> TextTransform.toString tt
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let top x = D ({|top|}, string_of_position x)

let transform x =
  D
    ( {|transform|},
      match x with
      | `none -> {|none|}
      | #Transform.t as t -> Transform.toString t )

let transforms x =
  D
    ( {|transform|},
      x |. Std.Array.map Transform.toString |. Std.Array.joinWith ~sep:{| |} )

let transformOrigin x = D ({|transform-origin|}, TransformOrigin.toString x)

let transformOrigin2 x y =
  D
    ( {|transform-origin|},
      TransformOrigin.toString x ^ {| |} ^ TransformOrigin.toString y )

let transformOrigin3d x y z =
  D
    ( {|transform-origin|},
      Length.toString x
      ^ {| |}
      ^ Length.toString y
      ^ {| |}
      ^ Length.toString z
      ^ {| |} )

let transformBox x =
  D
    ( {|transform-box|},
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

let unsafe property value = D (camelCaseToKebabCase property, value)

let userSelect x =
  D
    ( {|user-select|},
      match x with
      | #UserSelect.t as us -> UserSelect.toString us
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let verticalAlign x =
  D
    ( {|vertical-align|},
      match x with
      | #VerticalAlign.t as v -> VerticalAlign.toString v
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let visibility x =
  D
    ( {|visibility|},
      match x with
      | #Visibility.t as v -> Visibility.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let scrollBehavior x =
  D
    ( {|scroll-behavior|},
      match x with
      | #ScrollBehavior.t as sb -> ScrollBehavior.toString sb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overscrollBehavior x =
  D
    ( {|overscroll-behavior|},
      match x with
      | #OverscrollBehavior.t as osb -> OverscrollBehavior.toString osb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overflowAnchor x =
  D
    ( {|overflow-anchor|},
      match x with
      | #OverflowAnchor.t as oa -> OverflowAnchor.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnWidth x =
  D
    ( {|column-width|},
      match x with
      | #ColumnWidth.t as cw -> ColumnWidth.toString cw
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let caretColor x =
  D
    ( {|caret-color|},
      match x with
      | #CaretColor.t as ct -> CaretColor.toString ct
      | #Color.t as c -> Color.toString c
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let width x =
  D
    ( {|width|},
      match x with
      | #Width.t as w -> Width.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let whiteSpace x =
  D
    ( {|white-space|},
      match x with
      | #WhiteSpace.t as w -> WhiteSpace.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordBreak x =
  D
    ( {|word-break|},
      match x with
      | #WordBreak.t as w -> WordBreak.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordSpacing x =
  D
    ( {|word-spacing|},
      match x with
      | #WordSpacing.t as w -> WordSpacing.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordWrap = overflowWrap
let zIndex x = D ({|z-index|}, ZIndex.toString x)
let media = fun [@u] query rules -> S ({|@media |} ^ query, rules)
let selector = fun [@u] selector rules -> S (selector, rules)
let pseudoClass selector rules = PseudoClass (selector, rules)
let active rules = pseudoClass {|active|} rules
let checked rules = pseudoClass {|checked|} rules
let default rules = pseudoClass {|default|} rules
let defined rules = pseudoClass {|defined|} rules
let disabled rules = pseudoClass {|disabled|} rules
let empty rules = pseudoClass {|empty|} rules
let enabled rules = pseudoClass {|enabled|} rules
let first rules = pseudoClass {|first|} rules
let firstChild rules = pseudoClass {|first-child|} rules
let firstOfType rules = pseudoClass {|first-of-type|} rules
let focus rules = pseudoClass {|focus|} rules
let focusVisible rules = pseudoClass {|focus-visible|} rules
let focusWithin rules = pseudoClass {|focus-within|} rules

let host ?selector rules =
  match selector with
  | None -> PseudoClass ({|host|}, rules)
  | Some s -> PseudoClassParam ({|host|}, s, rules)

let hover rules = pseudoClass {|hover|} rules
let indeterminate rules = pseudoClass {|indeterminate|} rules
let inRange rules = pseudoClass {|in-range|} rules
let invalid rules = pseudoClass {|invalid|} rules
let lang code rules = PseudoClassParam ({|lang|}, code, rules)
let lastChild rules = pseudoClass {|last-child|} rules
let lastOfType rules = pseudoClass {|last-of-type|} rules
let link rules = pseudoClass {|link|} rules
let not_ selector rules = PseudoClassParam ({|not|}, selector, rules)

module Nth = struct
  type t =
    [ `odd
    | `even
    | `n of int
    | `add of int * int
    ]

  let toString x =
    match x with
    | `odd -> {|odd|}
    | `even -> {|even|}
    | `n x -> Std.Int.toString x ^ {|n|}
    | `add (x, y) -> Std.Int.toString x ^ {|n+|} ^ Std.Int.toString y
end

let nthChild x rules = PseudoClassParam ({|nth-child|}, Nth.toString x, rules)

let nthLastChild x rules =
  PseudoClassParam ({|nth-last-child|}, Nth.toString x, rules)

let nthLastOfType x rules =
  PseudoClassParam ({|nth-last-of-type|}, Nth.toString x, rules)

let nthOfType x rules = PseudoClassParam ({|nth-of-type|}, Nth.toString x, rules)
let onlyChild rules = pseudoClass {|only-child|} rules
let onlyOfType rules = pseudoClass {|only-of-type|} rules
let optional rules = pseudoClass {|optional|} rules
let outOfRange rules = pseudoClass {|out-of-range|} rules
let readOnly rules = pseudoClass {|read-only|} rules
let readWrite rules = pseudoClass {|read-write|} rules
let required rules = pseudoClass {|required|} rules
let root rules = pseudoClass {|root|} rules
let scope rules = pseudoClass {|scope|} rules
let target rules = pseudoClass {|target|} rules
let valid rules = pseudoClass {|valid|} rules
let visited rules = pseudoClass {|visited|} rules
let after rules = (selector {|::after|} rules [@u])
let before rules = (selector {|::before|} rules [@u])
let firstLetter rules = (selector {|::first-letter|} rules [@u])
let firstLine rules = (selector {|::first-line|} rules [@u])
let selection rules = (selector {|::selection|} rules [@u])
let child x rules = (selector ({|> |} ^ x) rules [@u])
let children rules = (selector {|> *|} rules [@u])
let directSibling rules = (selector {|+ |} rules [@u])
let placeholder rules = (selector {|::placeholder|} rules [@u])
let siblings rules = (selector {|~ |} rules [@u])
let anyLink rules = (selector {|:any-link|} rules [@u])

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
    ( {|flex|},
      Std.Float.toString grow
      ^ {| |}
      ^ Std.Float.toString shrink
      ^ {| |}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flexBasis x =
  D
    ( {|flex-basis|},
      match x with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let order x = D ({|order|}, Std.Int.toString x)

let string_of_minmax x =
  match x with
  | `auto -> {|auto|}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {|fr|}
  | `minContent -> {|min-content|}
  | `maxContent -> {|max-content|}

let string_of_dimension x =
  match x with
  | `auto -> {|auto|}
  | `none -> {|none|}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {|fr|}
  | `fitContent -> {|fit-content|}
  | `minContent -> {|min-content|}
  | `maxContent -> {|max-content|}
  | `minmax (a, b) ->
    {|minmax(|} ^ string_of_minmax a ^ {|,|} ^ string_of_minmax b ^ {|)|}

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
  | `none -> {|none|}
  | `auto -> {|auto|}
  | `subgrid -> {|subgrid|}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {|fr|}
  | `minContent -> {|min-content|}
  | `fitContent x -> {|fit-content|} ^ {|(|} ^ Length.toString x ^ {|)|}
  | `maxContent -> {|max-content|}
  | `repeat (n, x) ->
    {|repeat(|}
    ^ RepeatValue.toString n
    ^ {|, |}
    ^ string_of_dimensions x
    ^ {|)|}
  | `minmax (a, b) ->
    {|minmax(|} ^ string_of_minmax a ^ {|,|} ^ string_of_minmax b ^ {|)|}

and string_of_dimensions dimensions =
  dimensions |. Std.Array.map gridLengthToJs |. Std.Array.joinWith ~sep:{| |}

let gridTemplateColumns dimensions =
  D ({|grid-template-columns|}, string_of_dimensions dimensions)

let gridTemplateRows dimensions =
  D ({|grid-template-rows|}, string_of_dimensions dimensions)

let gridAutoColumns dimensions =
  D ({|grid-auto-columns|}, string_of_dimension dimensions)

let gridAutoRows dimensions =
  D ({|grid-auto-rows|}, string_of_dimension dimensions)

let gridArea s =
  D
    ( {|grid-area|},
      match s with
      | #GridArea.t as t -> GridArea.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridArea2 s s2 =
  D ({|grid-area|}, (GridArea.toString s ^ {|- |}) ^ GridArea.toString s2)

let gridArea3 s s2 s3 =
  D
    ( {|grid-area|},
      GridArea.toString s
      ^ {|- |}
      ^ GridArea.toString s2
      ^ {|- |}
      ^ GridArea.toString s3 )

let gridArea4 s s2 s3 s4 =
  D
    ( {|grid-area|},
      GridArea.toString s
      ^ {|- |}
      ^ GridArea.toString s2
      ^ {|- |}
      ^ GridArea.toString s3
      ^ {|- |}
      ^ GridArea.toString s4 )

let gridTemplateAreas l =
  D
    ( {|grid-template-areas|},
      match l with
      | #GridTemplateAreas.t as t -> GridTemplateAreas.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

type filter =
  [ `blur of Length.t
  | `brightness of float
  | `contrast of [ `percent of float | `num of float ]
  | `dropShadow of Length.t * Length.t * Length.t * [ Color.t | Var.t ]
  | `grayscale of float
  | `hueRotate of angle
  | `invert of float
  | `opacity of float
  | `saturate of float
  | `sepia of float
  | `url of string
  | `none
  | Var.t
  | Cascading.t
  ]

let string_of_amount x =
  match x with
  | `percent v -> Std.Float.toString v ^ {|%|}
  | `num v -> Std.Float.toString v

let string_of_filter x =
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

let filter x =
  D
    ( {|filter|},
      x |. Std.Array.map string_of_filter |. Std.Array.joinWith ~sep:{| |} )

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
      ^ {| |}
      ^ Length.toString y
      ^ {| |}
      ^ Length.toString blur
      ^ {| |}
      ^ Length.toString spread
      ^ {| |}
      ^ string_of_color color
      ^ if inset then {|inset|} else {||})

  let text ?(x = zero) ?(y = zero) ?(blur = zero) color =
    `shadow
      (Length.toString x
      ^ {| |}
      ^ Length.toString y
      ^ {| |}
      ^ Length.toString blur
      ^ {| |}
      ^ string_of_color color)

  let (toString : 'a t -> string) =
   fun x -> match x with `shadow x -> x | `none -> {|none|}
end

let boxShadow x =
  D
    ( {|box-shadow|},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let boxShadows x =
  D
    ( {|box-shadow|},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{|, |} )

let string_of_borderstyle x =
  match x with
  | #BorderStyle.t as b -> BorderStyle.toString b
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let border px style color =
  D
    ( {|border|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderStyle x = D ({|border-style|}, string_of_borderstyle x)

let borderLeft px style color =
  D
    ( {|border-left|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderLeftStyle x = D ({|border-left-style|}, string_of_borderstyle x)

let borderRight px style color =
  D
    ( {|border-right|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderRightStyle x = D ({|border-right-style|}, string_of_borderstyle x)

let borderTop px style color =
  D
    ( {|border-top|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderTopStyle x = D ({|border-top-style|}, string_of_borderstyle x)

let borderBottom px style color =
  D
    ( {|border-bottom|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderBottomStyle x = D ({|border-bottom-style|}, string_of_borderstyle x)

let background x =
  D
    ( {|background|},
      match x with
      | #Color.t as c -> Color.toString c
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g
      | `none -> {|none|} )

let backgrounds x =
  D
    ( {|background|},
      x
      |. Std.Array.map (fun item ->
             match item with
             | #Color.t as c -> Color.toString c
             | #Url.t as u -> Url.toString u
             | #Gradient.t as g -> Gradient.toString g
             | `none -> {|none|})
      |. Std.Array.joinWith ~sep:{|, |} )

let backgroundSize x =
  D
    ( {|background-size|},
      match x with
      | `size (x, y) -> (Length.toString x ^ {| |}) ^ Length.toString y
      | `auto -> {|auto|}
      | `cover -> {|cover|}
      | `contain -> {|contain|} )

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let src =
    src
    |. Std.Array.map (fun x ->
           match x with
           | `localUrl value -> {|local("|} ^ value ^ {|")|}
           | `url value -> {|url("|} ^ value ^ {|")|})
    |. Std.Array.joinWith ~sep:{|, |}
  in
  let fontStyle =
    Belt.Option.mapWithDefault fontStyle {||} (fun s ->
        {|font-style: |} ^ FontStyle.toString s ^ {|;|})
  in
  let fontWeight =
    Belt.Option.mapWithDefault fontWeight {||} (fun w ->
        ({|font-weight: |}
        ^
        match w with
        | #FontWeight.t as f -> FontWeight.toString f
        | #Var.t as va -> Var.toString va
        | #Cascading.t as c -> Cascading.toString c)
        ^ {|;|})
  in
  let fontDisplay =
    Belt.Option.mapWithDefault fontDisplay {||} (fun f ->
        ({|font-display: |} ^ FontDisplay.toString f) ^ {|;|})
  in
  let sizeAdjust =
    Belt.Option.mapWithDefault sizeAdjust {||} (fun s ->
        ({|size-adjust: |} ^ Percentage.toString s) ^ {|;|})
  in
  {|@font-face {|}
  ^ ({|font-family: |} ^ fontFamily)
  ^ ({|; src: |} ^ src ^ {|;|})
  ^ fontStyle
  ^ fontWeight
  ^ fontDisplay
  ^ sizeAdjust
  ^ {|}|}

let textDecoration x =
  D
    ( {|text-decoration|},
      match x with
      | `none -> {|none|}
      | `underline -> {|underline|}
      | `overline -> {|overline|}
      | `lineThrough -> {|line-through|}
      | `initial -> {|initial|}
      | `inherit_ -> {|inherit|}
      | `unset -> {|unset|}
      | #Var.t as va -> Var.toString va )

let textShadow x =
  D
    ( {|text-shadow|},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textShadows x =
  D
    ( {|text-shadow|},
      x |. Std.Array.map Shadow.toString |. Std.Array.joinWith ~sep:{|, |} )

let transformStyle x =
  D
    ( {|transform-style|},
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
      ^ {| |}
      ^ TimingFunction.toString timingFunction
      ^ {| |}
      ^ Time.toString delay
      ^ {| |}
      ^ property)

  let toString (x : t) = match x with `value v -> v
end
[@@ns.doc "\n * Transition\n "]

let transitionValue x = D ({|transition|}, Transition.toString x)

let transitionList x =
  D
    ( {|transition|},
      x |. Std.Array.map Transition.toString |. Std.Array.joinWith ~sep:{|, |}
    )

let transitions = transitionList

let transition ?duration ?delay ?timingFunction property =
  transitionValue
    (Transition.shorthand ?duration ?delay ?timingFunction property)

let transitionDelay i = D ({|transition-delay|}, Time.toString i)
let transitionDuration i = D ({|transition-duration|}, Time.toString i)

let transitionTimingFunction x =
  D ({|transition-timing-function|}, TimingFunction.toString x)

let transitionProperty x = D ({|transition-property|}, x)

module Animation = struct
  type t = [ `value of string ]

  let shorthand ?(duration = `ms 0) ?(delay = `ms 0) ?(direction = `normal)
    ?(timingFunction = `ease) ?(fillMode = `none) ?(playState = `running)
    ?(iterationCount = `count 1.) name =
    `value
      (name
      ^ {| |}
      ^ Time.toString duration
      ^ {| |}
      ^ TimingFunction.toString timingFunction
      ^ {| |}
      ^ Time.toString delay
      ^ {| |}
      ^ AnimationIterationCount.toString iterationCount
      ^ {| |}
      ^ AnimationDirection.toString direction
      ^ {| |}
      ^ AnimationFillMode.toString fillMode
      ^ {| |}
      ^ AnimationPlayState.toString playState)

  let toString x = match x with `value v -> v
end
[@@ns.doc "\n * Animation\n "]

let animationValue x = D ({|animation|}, Animation.toString x)

let animation ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
  ?iterationCount name =
  animationValue
    (Animation.shorthand ?duration ?delay ?direction ?timingFunction ?fillMode
       ?playState ?iterationCount name)

let animations x =
  D
    ( {|animation|},
      x |. Std.Array.map Animation.toString |. Std.Array.joinWith ~sep:{|, |} )

let animationName x = D ({|animation-name|}, x)

module SVG = struct
  let fill x =
    D
      ( {|fill|},
        match x with
        | #SVG.Fill.t as f -> SVG.Fill.toString f
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v
        | #Url.t as u -> Url.toString u )

  let fillOpacity opacity = D ({|fill-opacity|}, Std.Float.toString opacity)

  let fillRule x =
    D
      ( {|fill-rule|},
        match x with `evenodd -> {|evenodd|} | `nonzero -> {|nonzero|} )

  let stroke x = D ({|stroke|}, string_of_color x)

  let strokeDasharray x =
    D
      ( {|stroke-dasharray|},
        match x with
        | `none -> {|none|}
        | `dasharray a ->
          a |. Std.Array.map string_of_dasharray |. Std.Array.joinWith ~sep:{||}
      )

  let strokeWidth x = D ({|stroke-width|}, Length.toString x)
  let strokeOpacity opacity = D ({|stroke-opacity|}, AlphaValue.toString opacity)
  let strokeMiterlimit x = D ({|stroke-miterlimit|}, Std.Float.toString x)

  let strokeLinecap x =
    D
      ( {|stroke-linecap|},
        match x with
        | `butt -> {|butt|}
        | `round -> {|round|}
        | `square -> {|square|} )

  let strokeLinejoin x =
    D
      ( {|stroke-linejoin|},
        match x with
        | `miter -> {|miter|}
        | `round -> {|round|}
        | `bevel -> {|bevel|} )

  let stopColor x = D ({|stop-color|}, string_of_color x)
  let stopOpacity x = D ({|stop-opacity|}, Std.Float.toString x)
end
[@@ns.doc "\n * SVG\n "]

let touchAction x = D ({|touch-action|}, x |. TouchAction.toString)
let textEmphasisColor x = D ({|textEmphasisColor|}, string_of_color x)

let lineBreak x =
  D
    ( {|line-break|},
      match x with
      | #LineBreak.t as lb -> LineBreak.toString lb
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let hyphens x =
  D
    ( {|hyphens|},
      match x with
      | #Hyphens.t as h -> Hyphens.toString h
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let textJustify x =
  D
    ( {|text-justify|},
      match x with
      | #TextJustify.t as tj -> TextJustify.toString tj
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowInline x =
  D
    ( {|overflow-inline|},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowBlock x =
  D
    ( {|overflowBlock|},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisWeight x =
  D
    ( {|font-synthesis-weight|},
      match x with
      | #FontSynthesisWeight.t as fsw -> FontSynthesisWeight.toString fsw
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisStyle x =
  D
    ( {|font-synthesis-style|},
      match x with
      | #FontSynthesisStyle.t as fss -> FontSynthesisStyle.toString fss
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisSmallCaps x =
  D
    ( {|font-synthesis-small-caps|},
      match x with
      | #FontSynthesisSmallCaps.t as fssc ->
        FontSynthesisSmallCaps.toString fssc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisPosition x =
  D
    ( {|font-synthesis-weight|},
      match x with
      | #FontSynthesisPosition.t as fsp -> FontSynthesisPosition.toString fsp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontKerning x =
  D
    ( {|font-kerning|},
      match x with
      | #FontKerning.t as fk -> FontKerning.toString fk
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantPosition x =
  D
    ( {|font-variant-position|},
      match x with
      | #FontVariantPosition.t as fvp -> FontVariantPosition.toString fvp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantCaps x =
  D
    ( {|font-variant-caps|},
      match x with
      | #FontVariantCaps.t as fvc -> FontVariantCaps.toString fvc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontOpticalSizing x =
  D
    ( {|font-optical-sizing|},
      match x with
      | #FontOpticalSizing.t as fos -> FontOpticalSizing.toString fos
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantEmoji x =
  D
    ( {|font-variant-emoji|},
      match x with
      | #FontVariantEmoji.t as fve -> FontVariantEmoji.toString fve
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )
