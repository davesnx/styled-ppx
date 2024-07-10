open Css_types

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

let string_of_dasharray x =
  match x with
  | #Percentage.t as p -> Percentage.toString p
  | #Length.t as l -> Length.toString l

let important v =
  match v with
  | Rule.Declaration (name, value) ->
    Rule.Declaration (name, value ^ {js| !important|js})
  | Rule.Selector (_, _) -> v

let label label = Rule.declaration ({js|label|js}, label)

let aspectRatio x =
  Rule.declaration
    ( {js|aspectRatio|js},
      match x with
      | #AspectRatio.t as ar -> AspectRatio.toString ar
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignContent x =
  Rule.declaration
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
  Rule.declaration
    ( {js|alignItems|js},
      match x with
      | #AlignItems.t as ai -> AlignItems.toString ai
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignSelf x =
  Rule.declaration
    ( {js|alignSelf|js},
      match x with
      | #AlignSelf.t as a -> AlignSelf.toString a
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let animationDelay x = Rule.declaration ({js|animationDelay|js}, Time.toString x)

let animationDirection x =
  Rule.declaration ({js|animationDirection|js}, AnimationDirection.toString x)

let animationDuration x =
  Rule.declaration ({js|animationDuration|js}, Time.toString x)

let animationFillMode x =
  Rule.declaration ({js|animationFillMode|js}, AnimationFillMode.toString x)

let animationIterationCount x =
  Rule.declaration
    ({js|animationIterationCount|js}, AnimationIterationCount.toString x)

let animationPlayState x =
  Rule.declaration ({js|animationPlayState|js}, AnimationPlayState.toString x)

let animationTimingFunction x =
  Rule.declaration ({js|animationTimingFunction|js}, TimingFunction.toString x)

let backfaceVisibility x =
  Rule.declaration
    ( {js|backfaceVisibility|js},
      match x with
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backdropFilter x =
  Rule.declaration
    ( {js|backdropFilter|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} x ~f:Filter.toString )

let backgroundAttachment x =
  Rule.declaration
    ( {js|backgroundAttachment|js},
      match x with
      | #BackgroundAttachment.t as ba -> BackgroundAttachment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundColor x =
  Rule.declaration ({js|backgroundColor|js}, Color.toString x)

let backgroundClip x =
  Rule.declaration
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

let backgroundImage x =
  Rule.declaration ({js|backgroundImage|js}, string_of_backgroundImage x)

let backgroundImages imgs =
  Rule.declaration
    ( {js|backgroundImage|js},
      Kloth.Array.map_and_join imgs ~sep:{js|, |js} ~f:string_of_backgroundImage
    )

let maskImage x =
  Rule.declaration
    ( {js|maskImage|js},
      match x with
      | #MaskImage.t as mi -> MaskImage.toString mi
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let imageRendering x =
  Rule.declaration
    ( {js|imageRendering|js},
      match x with
      | #ImageRendering.t as ir -> ImageRendering.toString ir
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundOrigin x =
  Rule.declaration
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
  Rule.declaration ({js|backgroundPosition|js}, string_of_backgroundPosition x)

let backgroundPosition2 x y =
  Rule.declaration
    ( {js|backgroundPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let backgroundPosition4 ~x ~offsetX ~y ~offsetY =
  Rule.declaration
    ( {js|backgroundPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ Length.toString offsetX
      ^ {js| |js}
      ^ string_of_backgroundPosition y
      ^ {js| |js}
      ^ Length.toString offsetY )

let backgroundPositions bp =
  Rule.declaration
    ( {js|backgroundPosition|js},
      Kloth.Array.map_and_join bp ~sep:{js|, |js} ~f:(fun (x, y) ->
          string_of_backgroundPosition x
          ^ {js| |js}
          ^ string_of_backgroundPosition y) )

let backgroundRepeat x =
  Rule.declaration
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

let maskPosition x =
  Rule.declaration ({js|maskPosition|js}, string_of_maskposition x)

let maskPositions mp =
  Rule.declaration
    ( {js|maskPosition|js},
      Kloth.Array.map_and_join mp ~sep:{js|, |js} ~f:string_of_maskposition )

let borderImageSource x =
  Rule.declaration
    ( {js|borderImageSource|js},
      match x with
      | #BorderImageSource.t as b -> BorderImageSource.toString b
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let borderBottomColor x =
  Rule.declaration ({js|borderBottomColor|js}, Color.toString x)

let borderBottomLeftRadius x =
  Rule.declaration ({js|borderBottomLeftRadius|js}, Length.toString x)

let borderBottomRightRadius x =
  Rule.declaration ({js|borderBottomRightRadius|js}, Length.toString x)

let borderBottomWidth x =
  Rule.declaration ({js|borderBottomWidth|js}, LineWidth.toString x)

let borderCollapse x =
  Rule.declaration
    ( {js|borderCollapse|js},
      match x with
      | #BorderCollapse.t as bc -> BorderCollapse.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let borderColor x = Rule.declaration ({js|borderColor|js}, Color.toString x)

let borderLeftColor x =
  Rule.declaration ({js|borderLeftColor|js}, Color.toString x)

let borderLeftWidth x =
  Rule.declaration ({js|borderLeftWidth|js}, LineWidth.toString x)

let borderSpacing x = Rule.declaration ({js|borderSpacing|js}, Length.toString x)
let borderRadius x = Rule.declaration ({js|borderRadius|js}, Length.toString x)

let borderRadius4 ~topLeft ~topRight ~bottomLeft ~bottomRight =
  Rule.declaration
    ( {js|borderRadius|js},
      Length.toString topLeft
      ^ {js| |js}
      ^ Length.toString topRight
      ^ {js| |js}
      ^ Length.toString bottomLeft
      ^ {js| |js}
      ^ Length.toString bottomRight )

let borderRightColor x =
  Rule.declaration ({js|borderRightColor|js}, Color.toString x)

let borderRightWidth x =
  Rule.declaration ({js|borderRightWidth|js}, LineWidth.toString x)

let borderTopColor x =
  Rule.declaration ({js|borderTopColor|js}, Color.toString x)

let borderTopLeftRadius x =
  Rule.declaration ({js|borderTopLeftRadius|js}, Length.toString x)

let borderTopRightRadius x =
  Rule.declaration ({js|borderTopRightRadius|js}, Length.toString x)

let borderTopWidth x =
  Rule.declaration ({js|borderTopWidth|js}, LineWidth.toString x)

let borderWidth x = Rule.declaration ({js|borderWidth|js}, LineWidth.toString x)
let bottom x = Rule.declaration ({js|bottom|js}, string_of_position x)

let boxSizing x =
  Rule.declaration
    ( {js|boxSizing|js},
      match x with
      | #BoxSizing.t as bs -> BoxSizing.toString bs
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clear x =
  Rule.declaration
    ( {js|clear|js},
      match x with
      | #Clear.t as cl -> Clear.toString cl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let clipPath x =
  Rule.declaration
    ( {js|clipPath|js},
      match x with
      | #ClipPath.t as cp -> ClipPath.toString cp
      | #Url.t as u -> Url.toString u
      | #GeometryBox.t as gb -> GeometryBox.toString gb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let color x = Rule.declaration ({js|color|js}, Color.toString x)

let columnCount x =
  Rule.declaration
    ( {js|columnCount|js},
      match x with
      | #ColumnCount.t as cc -> ColumnCount.toString cc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let rowGap x = Rule.declaration ({js|rowGap|js}, string_of_row_gap x)
let columnGap x = Rule.declaration ({js|columnGap|js}, string_of_column_gap x)
let contentRule x = Rule.declaration ({js|content|js}, Content.toString x)

let contentsRule xs alt =
  match alt with
  | None ->
    Rule.declaration
      ( {js|content|js},
        Kloth.Array.map_and_join xs ~f:Content.toString ~sep:{js| |js} )
  | Some alt ->
    Rule.declaration
      ( {js|content|js},
        Kloth.Array.map_and_join xs ~sep:{js| |js} ~f:Content.toString
        ^ " / "
        ^ Content.toString (`text alt) )

let counterIncrement x =
  Rule.declaration ({js|counterIncrement|js}, string_of_counter_increment x)

let countersIncrement xs =
  Rule.declaration
    ( {js|counterIncrement|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:string_of_counter_increment
    )

let counterReset x =
  Rule.declaration ({js|counterReset|js}, string_of_counter_reset x)

let countersReset xs =
  Rule.declaration
    ( {js|counterReset|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:string_of_counter_reset )

let counterSet x = Rule.declaration ({js|counterSet|js}, string_of_counter_set x)

let countersSet xs =
  Rule.declaration
    ( {js|counterSet|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:string_of_counter_set )

let cursor x = Rule.declaration ({js|cursor|js}, Cursor.toString x)

let direction x =
  Rule.declaration
    ( {js|direction|js},
      match x with
      | #Direction.t as d -> Direction.toString d
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let display x =
  Rule.declaration
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
  Rule.declaration
    ( {js|flex|js},
      Kloth.Float.to_string grow
      ^ {js| |js}
      ^ Kloth.Float.to_string shrink
      ^ {js| |js}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flex1 x =
  Rule.declaration
    ( {js|flex|js},
      match x with
      | #Flex.t as f -> Flex.toString f
      | `num n -> Kloth.Float.to_string n )

let flex2 ?basis ?shrink grow =
  Rule.declaration
    ( {js|flex|js},
      Kloth.Float.to_string grow
      ^ (match shrink with
        | Some s -> {js| |js} ^ Kloth.Float.to_string s
        | None -> {js||js})
      ^
      match basis with
      | Some (#FlexBasis.t as b) -> {js| |js} ^ FlexBasis.toString b
      | Some (#Length.t as l) -> {js| |js} ^ Length.toString l
      | None -> {js||js} )

let flexDirection x =
  Rule.declaration
    ( {js|flexDirection|js},
      match x with
      | #FlexDirection.t as fd -> FlexDirection.toString fd
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flexGrow x = Rule.declaration ({js|flexGrow|js}, Kloth.Float.to_string x)
let flexShrink x = Rule.declaration ({js|flexShrink|js}, Kloth.Float.to_string x)

let flexWrap x =
  Rule.declaration
    ( {js|flexWrap|js},
      match x with
      | #FlexWrap.t as fw -> FlexWrap.toString fw
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let float x =
  Rule.declaration
    ( {js|float|js},
      match x with
      | #Float.t as f -> Float.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamily x =
  Rule.declaration ({js|fontFamily|js}, FontFamilyName.toString x)

let fontFamilies xs =
  Rule.declaration
    ( {js|fontFamily|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:FontFamilyName.toString xs )

let fontSize x =
  Rule.declaration
    ( {js|fontSize|js},
      match x with
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontStyle x =
  Rule.declaration
    ( {js|fontStyle|js},
      match x with
      | #FontStyle.t as f -> FontStyle.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontVariant x =
  Rule.declaration
    ( {js|fontVariant|js},
      match x with
      | #FontVariant.t as f -> FontVariant.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontWeight x =
  Rule.declaration
    ( {js|fontWeight|js},
      match x with
      | #FontWeight.t as f -> FontWeight.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontDisplay x =
  Rule.declaration
    ( {js|fontDisplay|js},
      match x with
      | #FontDisplay.t as f -> FontDisplay.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let sizeAdjust x =
  Rule.declaration
    ( {js|sizeAdjust|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridAutoFlow x =
  Rule.declaration
    ( {js|gridAutoFlow|js},
      match x with
      | #GridAutoFlow.t as f -> GridAutoFlow.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridColumn start end' =
  Rule.declaration
    ( {js|gridColumn|js},
      Kloth.Int.to_string start ^ {js| / |js} ^ Kloth.Int.to_string end' )

let gridColumnGap x =
  Rule.declaration ({js|gridColumnGap|js}, string_of_column_gap x)

let gridColumnStart n =
  Rule.declaration ({js|gridColumnStart|js}, Kloth.Int.to_string n)

let gridColumnEnd n =
  Rule.declaration ({js|gridColumnEnd|js}, Kloth.Int.to_string n)

let gridRow start end' =
  Rule.declaration
    ( {js|gridRow|js},
      Kloth.Int.to_string start ^ {js| / |js} ^ Kloth.Int.to_string end' )

let gap x = Rule.declaration ({js|gap|js}, string_of_gap x)
let gridGap x = Rule.declaration ({js|gridGap|js}, string_of_gap x)

let gap2 ~rowGap ~columnGap =
  Rule.declaration
    ({js|gap|js}, string_of_gap rowGap ^ {js| |js} ^ string_of_gap columnGap)

let gridRowGap x =
  Rule.declaration
    ( {js|gridRowGap|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridRowEnd n = Rule.declaration ({js|gridRowEnd|js}, Kloth.Int.to_string n)

let gridRowStart n =
  Rule.declaration ({js|gridRowStart|js}, Kloth.Int.to_string n)

let height x =
  Rule.declaration
    ( {js|height|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyle x =
  Rule.declaration
    ( {js|textEmphasisStyle|js},
      match x with
      | #TextEmphasisStyle.t as tes -> TextEmphasisStyle.toString tes
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textEmphasisStyles x y =
  Rule.declaration
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
  Rule.declaration ({js|textEmphasisPosition|js}, textEmphasisPosition' x)

let textEmphasisPositions x y =
  Rule.declaration
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
  Rule.declaration
    ( {js|justifyContent|js},
      match x with
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyItems x =
  Rule.declaration
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

let left x = Rule.declaration ({js|left|js}, string_of_position x)

let letterSpacing x =
  Rule.declaration
    ( {js|letterSpacing|js},
      match x with
      | #LetterSpacing.t as s -> LetterSpacing.toString s
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let lineHeight x =
  Rule.declaration
    ( {js|lineHeight|js},
      match x with
      | #LineHeight.t as h -> LineHeight.toString h
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStyle style position image =
  Rule.declaration
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
  Rule.declaration
    ( {js|listStyleImage|js},
      match x with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u
      | #Var.t as va -> Var.toString va
      | #Gradient.t as g -> Gradient.toString g
      | #Cascading.t as c -> Cascading.toString c )

let listStyleType x =
  Rule.declaration
    ( {js|listStyleType|js},
      match x with
      | #ListStyleType.t as lsp -> ListStyleType.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStylePosition x =
  Rule.declaration
    ( {js|listStylePosition|js},
      match x with
      | #ListStylePosition.t as lsp -> ListStylePosition.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let tabSize x =
  Rule.declaration
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

let margin x = Rule.declaration ({js|margin|js}, marginToString x)

let margin2 ~v ~h =
  Rule.declaration
    ({js|margin|js}, marginToString v ^ {js| |js} ^ marginToString h)

let margin3 ~top ~h ~bottom =
  Rule.declaration
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString h
      ^ {js| |js}
      ^ marginToString bottom )

let margin4 ~top ~right ~bottom ~left =
  Rule.declaration
    ( {js|margin|js},
      marginToString top
      ^ {js| |js}
      ^ marginToString right
      ^ {js| |js}
      ^ marginToString bottom
      ^ {js| |js}
      ^ marginToString left )

let marginLeft x = Rule.declaration ({js|marginLeft|js}, marginToString x)
let marginRight x = Rule.declaration ({js|marginRight|js}, marginToString x)
let marginTop x = Rule.declaration ({js|marginTop|js}, marginToString x)
let marginBottom x = Rule.declaration ({js|marginBottom|js}, marginToString x)

let maxHeight x =
  Rule.declaration
    ( {js|maxHeight|js},
      match x with
      | #Height.t as mh -> Height.toString mh
      | #MaxHeight.t as mh -> MaxHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let maxWidth x =
  Rule.declaration
    ( {js|maxWidth|js},
      match x with
      | #Width.t as mw -> Width.toString mw
      | #MaxWidth.t as mw -> MaxWidth.toString mw
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minHeight x =
  Rule.declaration
    ( {js|minHeight|js},
      match x with
      | #Height.t as h -> Height.toString h
      | #MinHeight.t as mh -> MinHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minWidth x =
  Rule.declaration
    ( {js|minWidth|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #MinWidth.t as w -> MinWidth.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectFit x =
  Rule.declaration
    ( {js|objectFit|js},
      match x with
      | #ObjectFit.t as o -> ObjectFit.toString o
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectPosition x =
  Rule.declaration ({js|objectPosition|js}, string_of_backgroundPosition x)

let objectPosition2 x y =
  Rule.declaration
    ( {js|objectPosition|js},
      string_of_backgroundPosition x
      ^ {js| |js}
      ^ string_of_backgroundPosition y )

let opacity x = Rule.declaration ({js|opacity|js}, Kloth.Float.to_string x)

let outline size style color =
  Rule.declaration
    ( {js|outline|js},
      LineWidth.toString size
      ^ {js| |js}
      ^ OutlineStyle.toString style
      ^ {js| |js}
      ^ Color.toString color )

let outlineColor x = Rule.declaration ({js|outlineColor|js}, Color.toString x)
let outlineOffset x = Rule.declaration ({js|outlineOffset|js}, Length.toString x)

let outlineStyle x =
  Rule.declaration ({js|outlineStyle|js}, OutlineStyle.toString x)

let outlineWidth x =
  Rule.declaration ({js|outlineWidth|js}, LineWidth.toString x)

let overflow x = Rule.declaration ({js|overflow|js}, Overflow.toString x)

let overflows x =
  Rule.declaration
    ( {js|overflow|js},
      Kloth.Array.map_and_join ~sep:{js| |js} ~f:Overflow.toString x )

let overflowX x = Rule.declaration ({js|overflowX|js}, Overflow.toString x)
let overflowY x = Rule.declaration ({js|overflowY|js}, Overflow.toString x)

let overflowWrap x =
  Rule.declaration
    ( {js|overflowWrap|js},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let padding x = Rule.declaration ({js|padding|js}, Length.toString x)

let padding2 ~v ~h =
  Rule.declaration
    ({js|padding|js}, Length.toString v ^ {js| |js} ^ Length.toString h)

let padding3 ~top ~h ~bottom =
  Rule.declaration
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString h
      ^ {js| |js}
      ^ Length.toString bottom )

let padding4 ~top ~right ~bottom ~left =
  Rule.declaration
    ( {js|padding|js},
      Length.toString top
      ^ {js| |js}
      ^ Length.toString right
      ^ {js| |js}
      ^ Length.toString bottom
      ^ {js| |js}
      ^ Length.toString left )

let paddingBottom x = Rule.declaration ({js|paddingBottom|js}, Length.toString x)
let paddingLeft x = Rule.declaration ({js|paddingLeft|js}, Length.toString x)
let paddingRight x = Rule.declaration ({js|paddingRight|js}, Length.toString x)
let paddingTop x = Rule.declaration ({js|paddingTop|js}, Length.toString x)

let perspective x =
  Rule.declaration
    ( {js|perspective|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let perspectiveOrigin x =
  Rule.declaration
    ( {js|perspectiveOrigin|js},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let perspectiveOrigin2 x y =
  Rule.declaration
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
  Rule.declaration
    ( {js|pointerEvents|js},
      match x with
      | #PointerEvents.t as p -> PointerEvents.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let position x =
  Rule.declaration
    ( {js|position|js},
      match x with
      | #PropertyPosition.t as p -> PropertyPosition.toString p
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let isolation x =
  Rule.declaration
    ( {js|isolation|js},
      match x with
      | #Isolation.t as i -> Isolation.toString i
      | #Cascading.t as c -> Cascading.toString c )

let justifySelf x =
  Rule.declaration
    ( {js|justifySelf|js},
      match x with
      | #JustifySelf.t as j -> JustifySelf.toString j
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as oa -> OverflowAlignment.toString oa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let resize x =
  Rule.declaration
    ( {js|resize|js},
      match x with
      | #Resize.t as r -> Resize.toString r
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let right x = Rule.declaration ({js|right|js}, string_of_position x)

let tableLayout x =
  Rule.declaration
    ( {js|tableLayout|js},
      match x with
      | #TableLayout.t as tl -> TableLayout.toString tl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlign x =
  Rule.declaration
    ( {js|textAlign|js},
      match x with
      | #TextAlign.t as ta -> TextAlign.toString ta
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignAll x =
  Rule.declaration
    ( {js|textAlignAll|js},
      match x with
      | #TextAlignAll.t as taa -> TextAlignAll.toString taa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlignLast x =
  Rule.declaration
    ( {js|textAlignLast|js},
      match x with
      | #TextAlignLast.t as tal -> TextAlignLast.toString tal
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationColor x =
  Rule.declaration ({js|textDecorationColor|js}, Color.toString x)

let textDecorationLine x =
  Rule.declaration
    ( {js|textDecorationLine|js},
      match x with
      | #TextDecorationLine.t as tdl -> TextDecorationLine.toString tdl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationStyle x =
  Rule.declaration
    ( {js|textDecorationStyle|js},
      match x with
      | #TextDecorationStyle.t as tds -> TextDecorationStyle.toString tds
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationThickness x =
  Rule.declaration
    ( {js|textDecorationThickness|js},
      match x with
      | #TextDecorationThickness.t as t -> TextDecorationThickness.toString t
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInk x =
  Rule.declaration
    ( {js|textDecorationSkipInk|js},
      match x with
      | #TextDecorationSkipInk.t as tdsi -> TextDecorationSkipInk.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipBox x =
  Rule.declaration
    ( {js|textDecorationSkipBox|js},
      match x with
      | #TextDecorationSkipBox.t as tdsb -> TextDecorationSkipBox.toString tdsb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationSkipInset x =
  Rule.declaration
    ( {js|textDecorationSkipInset|js},
      match x with
      | #TextDecorationSkipInset.t as tdsi ->
        TextDecorationSkipInset.toString tdsi
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textIndent x =
  Rule.declaration
    ( {js|textIndent|js},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textOverflow x =
  Rule.declaration
    ( {js|textOverflow|js},
      match x with
      | #TextOverflow.t as txo -> TextOverflow.toString txo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textTransform x =
  Rule.declaration
    ( {js|textTransform|js},
      match x with
      | #TextTransform.t as tt -> TextTransform.toString tt
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let top x = Rule.declaration ({js|top|js}, string_of_position x)

let transform x =
  Rule.declaration
    ( {js|transform|js},
      match x with
      | `none -> {js|none|js}
      | #Transform.t as t -> Transform.toString t )

let transforms x =
  Rule.declaration
    ( {js|transform|js},
      Kloth.Array.map_and_join ~sep:{js| |js} ~f:Transform.toString x )

let transformOrigin x =
  Rule.declaration ({js|transformOrigin|js}, TransformOrigin.toString x)

let transformOrigin2 x y =
  Rule.declaration
    ( {js|transformOrigin|js},
      TransformOrigin.toString x ^ {js| |js} ^ TransformOrigin.toString y )

let transformOrigin3d x y z =
  Rule.declaration
    ( {js|transformOrigin|js},
      Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString z
      ^ {js| |js} )

let transformBox x =
  Rule.declaration
    ( {js|transformBox|js},
      match x with
      | #TransformBox.t as tb -> TransformBox.toString tb
      | #Cascading.t as c -> Cascading.toString c )

let unsafe property value = Rule.declaration (property, value)

let userSelect x =
  Rule.declaration
    ( {js|userSelect|js},
      match x with
      | #UserSelect.t as us -> UserSelect.toString us
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let verticalAlign x =
  Rule.declaration
    ( {js|verticalAlign|js},
      match x with
      | #VerticalAlign.t as v -> VerticalAlign.toString v
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let visibility x =
  Rule.declaration
    ( {js|visibility|js},
      match x with
      | #Visibility.t as v -> Visibility.toString v
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let scrollBehavior x =
  Rule.declaration
    ( {js|scrollBehavior|js},
      match x with
      | #ScrollBehavior.t as sb -> ScrollBehavior.toString sb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overscrollBehavior x =
  Rule.declaration
    ( {js|overscrollBehavior|js},
      match x with
      | #OverscrollBehavior.t as osb -> OverscrollBehavior.toString osb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overflowAnchor x =
  Rule.declaration
    ( {js|overflowAnchor|js},
      match x with
      | #OverflowAnchor.t as oa -> OverflowAnchor.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnWidth x =
  Rule.declaration
    ( {js|columnWidth|js},
      match x with
      | #ColumnWidth.t as cw -> ColumnWidth.toString cw
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let caretColor x = Rule.declaration ({js|caretColor|js}, CaretColor.toString x)

let width x =
  Rule.declaration
    ( {js|width|js},
      match x with
      | #Width.t as w -> Width.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let whiteSpace x =
  Rule.declaration
    ( {js|whiteSpace|js},
      match x with
      | #WhiteSpace.t as w -> WhiteSpace.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordBreak x =
  Rule.declaration
    ( {js|wordBreak|js},
      match x with
      | #WordBreak.t as w -> WordBreak.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordSpacing x =
  Rule.declaration
    ( {js|wordSpacing|js},
      match x with
      | #WordSpacing.t as w -> WordSpacing.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordWrap x =
  Rule.declaration
    ( {js|wordWrap|js},
      match x with
      | #OverflowWrap.t as ow -> OverflowWrap.toString ow
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let zIndex x = Rule.declaration ({js|zIndex|js}, ZIndex.toString x)

let flex3 ~grow ~shrink ~basis =
  Rule.declaration
    ( {js|flex|js},
      Kloth.Float.to_string grow
      ^ {js| |js}
      ^ Kloth.Float.to_string shrink
      ^ {js| |js}
      ^
      match basis with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let flexBasis x =
  Rule.declaration
    ( {js|flexBasis|js},
      match x with
      | #FlexBasis.t as b -> FlexBasis.toString b
      | #Length.t as l -> Length.toString l )

let order x = Rule.declaration ({js|order|js}, Kloth.Int.to_string x)

let string_of_minmax x =
  match x with
  | `auto -> {js|auto|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Kloth.Float.to_string x ^ {js|fr|js}
  | `minContent -> {js|min-content|js}
  | `maxContent -> {js|max-content|js}

let string_of_dimension x =
  match x with
  | `auto -> {js|auto|js}
  | `none -> {js|none|js}
  | `subgrid -> {js|subgrid|js}
  | #Length.t as l -> Length.toString l
  | `fr x -> Kloth.Float.to_string x ^ {js|fr|js}
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
  | `fr x -> Kloth.Float.to_string x ^ {js|fr|js}
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
  Kloth.Array.map_and_join ~f:gridLengthToJs ~sep:{js| |js} dimensions

let gridTemplateColumns dimensions =
  Rule.declaration ({js|gridTemplateColumns|js}, string_of_dimensions dimensions)

let gridTemplateRows dimensions =
  Rule.declaration ({js|gridTemplateRows|js}, string_of_dimensions dimensions)

let gridAutoColumns dimensions =
  Rule.declaration ({js|gridAutoColumns|js}, string_of_dimension dimensions)

let gridAutoRows dimensions =
  Rule.declaration ({js|gridAutoRows|js}, string_of_dimension dimensions)

let gridArea s =
  Rule.declaration
    ( {js|gridArea|js},
      match s with
      | #GridArea.t as t -> GridArea.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridArea2 s s2 =
  Rule.declaration
    ( {js|gridArea|js},
      (GridArea.toString s ^ {js| / |js}) ^ GridArea.toString s2 )

let gridArea3 s s2 s3 =
  Rule.declaration
    ( {js|gridArea|js},
      GridArea.toString s
      ^ {js| / |js}
      ^ GridArea.toString s2
      ^ {js| / |js}
      ^ GridArea.toString s3 )

let gridArea4 s s2 s3 s4 =
  Rule.declaration
    ( {js|gridArea|js},
      GridArea.toString s
      ^ {js| / |js}
      ^ GridArea.toString s2
      ^ {js| / |js}
      ^ GridArea.toString s3
      ^ {js| / |js}
      ^ GridArea.toString s4 )

let gridTemplateAreas l =
  Rule.declaration
    ( {js|gridTemplateAreas|js},
      match l with
      | #GridTemplateAreas.t as t -> GridTemplateAreas.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let filter x =
  Rule.declaration
    ( {js|filter|js},
      Kloth.Array.map_and_join ~f:Filter.toString ~sep:{js| |js} x )

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
      ^ Color.toString color
      ^ if inset then {js| inset|js} else {js||js})

  let text ?(x = `zero) ?(y = `zero) ?(blur = `zero) color =
    `shadow
      (Length.toString x
      ^ {js| |js}
      ^ Length.toString y
      ^ {js| |js}
      ^ Length.toString blur
      ^ {js| |js}
      ^ Color.toString color)

  let (toString : 'a t -> string) =
   fun x -> match x with `shadow x -> x | `none -> {js|none|js}
end

let boxShadow x =
  Rule.declaration
    ( {js|boxShadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let boxShadows x =
  Rule.declaration
    ( {js|boxShadow|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:Shadow.toString x )

let string_of_borderstyle x =
  match x with
  | #BorderStyle.t as b -> BorderStyle.toString b
  | #Var.t as va -> Var.toString va
  | #Cascading.t as c -> Cascading.toString c

let border px style color =
  Rule.declaration
    ( {js|border|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ Color.toString color )

let borderStyle x =
  Rule.declaration ({js|borderStyle|js}, string_of_borderstyle x)

let borderLeft px style color =
  Rule.declaration
    ( {js|borderLeft|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ Color.toString color )

let borderLeftStyle x =
  Rule.declaration ({js|borderLeftStyle|js}, string_of_borderstyle x)

let borderRight px style color =
  Rule.declaration
    ( {js|borderRight|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ Color.toString color )

let borderRightStyle x =
  Rule.declaration ({js|borderRightStyle|js}, string_of_borderstyle x)

let borderTop px style color =
  Rule.declaration
    ( {js|borderTop|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ Color.toString color )

let borderTopStyle x =
  Rule.declaration ({js|borderTopStyle|js}, string_of_borderstyle x)

let borderBottom px style color =
  Rule.declaration
    ( {js|borderBottom|js},
      LineWidth.toString px
      ^ {js| |js}
      ^ string_of_borderstyle style
      ^ {js| |js}
      ^ Color.toString color )

let borderBottomStyle x =
  Rule.declaration ({js|borderBottomStyle|js}, string_of_borderstyle x)

let background x =
  Rule.declaration
    ( {js|background|js},
      match x with
      | #Color.t as c -> Color.toString c
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g
      | `none -> {js|none|js} )

let backgrounds x =
  Rule.declaration
    ( {js|background|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} x ~f:(fun item ->
          match item with
          | #Color.t as c -> Color.toString c
          | #Url.t as u -> Url.toString u
          | #Gradient.t as g -> Gradient.toString g
          | `none -> {js|none|js}) )

let backgroundSize x =
  Rule.declaration
    ( {js|backgroundSize|js},
      match x with
      | `size (x, y) -> (Length.toString x ^ {js| |js}) ^ Length.toString y
      | `auto -> {js|auto|js}
      | `cover -> {js|cover|js}
      | `contain -> {js|contain|js} )

let textDecoration x =
  Rule.declaration
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
  Rule.declaration
    ( {js|textShadow|js},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textShadows x =
  Rule.declaration
    ( {js|textShadow|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} x ~f:Shadow.toString )

let transformStyle x =
  Rule.declaration
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

let transitionValue x =
  Rule.declaration ({js|transition|js}, Transition.toString x)

let transitionList x =
  Rule.declaration
    ( {js|transition|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:Transition.toString x )

let transitions = transitionList

let transition ?duration ?delay ?timingFunction property =
  transitionValue
    (Transition.shorthand ?duration ?delay ?timingFunction property)

let transitionDelay i =
  Rule.declaration ({js|transitionDelay|js}, Time.toString i)

let transitionDuration i =
  Rule.declaration ({js|transitionDuration|js}, Time.toString i)

let transitionTimingFunction x =
  Rule.declaration ({js|transitionTimingFunction|js}, TimingFunction.toString x)

let transitionProperty x = Rule.declaration ({js|transitionProperty|js}, x)

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

let animationValue x = Rule.declaration ({js|animation|js}, Animation.toString x)

let animation ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
  ?iterationCount name =
  animationValue
    (Animation.shorthand ?duration ?delay ?direction ?timingFunction ?fillMode
       ?playState ?iterationCount name)

let animations x =
  Rule.declaration
    ( {js|animation|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:Animation.toString x )

let animationName x = Rule.declaration ({js|animationName|js}, x)

module SVG = struct
  let fill x = Rule.declaration ({js|fill|js}, SVG.Fill.toString x)

  let fillOpacity opacity =
    Rule.declaration ({js|fillOpacity|js}, Kloth.Float.to_string opacity)

  let fillRule x =
    Rule.declaration
      ( {js|fillRule|js},
        match x with `evenodd -> {js|evenodd|js} | `nonzero -> {js|nonzero|js}
      )

  let stroke x = Rule.declaration ({js|stroke|js}, Color.toString x)

  let strokeDasharray x =
    Rule.declaration
      ( {js|strokeDasharray|js},
        match x with
        | `none -> {js|none|js}
        | `dasharray a ->
          Kloth.Array.map_and_join a ~f:string_of_dasharray ~sep:{js| |js} )

  let strokeWidth x = Rule.declaration ({js|strokeWidth|js}, Length.toString x)

  let strokeOpacity opacity =
    Rule.declaration ({js|strokeOpacity|js}, AlphaValue.toString opacity)

  let strokeMiterlimit x =
    Rule.declaration ({js|strokeMiterlimit|js}, Kloth.Float.to_string x)

  let strokeLinecap x =
    Rule.declaration
      ( {js|strokeLinecap|js},
        match x with
        | `butt -> {js|butt|js}
        | `round -> {js|round|js}
        | `square -> {js|square|js} )

  let strokeLinejoin x =
    Rule.declaration
      ( {js|strokeLinejoin|js},
        match x with
        | `miter -> {js|miter|js}
        | `round -> {js|round|js}
        | `bevel -> {js|bevel|js} )

  let stopColor x = Rule.declaration ({js|stopColor|js}, Color.toString x)

  let stopOpacity x =
    Rule.declaration ({js|stopOpacity|js}, Kloth.Float.to_string x)
end

let touchAction x =
  Rule.declaration ({js|touchAction|js}, TouchAction.toString x)

let textEmphasisColor x =
  Rule.declaration ({js|textEmphasisColor|js}, Color.toString x)

let lineBreak x =
  Rule.declaration
    ( {js|lineBreak|js},
      match x with
      | #LineBreak.t as lb -> LineBreak.toString lb
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let hyphens x =
  Rule.declaration
    ( {js|hyphens|js},
      match x with
      | #Hyphens.t as h -> Hyphens.toString h
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let textJustify x =
  Rule.declaration
    ( {js|textJustify|js},
      match x with
      | #TextJustify.t as tj -> TextJustify.toString tj
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowInline x =
  Rule.declaration
    ( {js|overflowInline|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let overflowBlock x =
  Rule.declaration
    ( {js|overflowBlock|js},
      match x with
      | #OverflowInline.t as ov -> OverflowInline.toString ov
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisWeight x =
  Rule.declaration
    ( {js|fontSynthesisWeight|js},
      match x with
      | #FontSynthesisWeight.t as fsw -> FontSynthesisWeight.toString fsw
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisStyle x =
  Rule.declaration
    ( {js|fontSynthesisStyle|js},
      match x with
      | #FontSynthesisStyle.t as fss -> FontSynthesisStyle.toString fss
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisSmallCaps x =
  Rule.declaration
    ( {js|fontSynthesisSmallCaps|js},
      match x with
      | #FontSynthesisSmallCaps.t as fssc ->
        FontSynthesisSmallCaps.toString fssc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontSynthesisPosition x =
  Rule.declaration
    ( {js|fontSynthesisWeight|js},
      match x with
      | #FontSynthesisPosition.t as fsp -> FontSynthesisPosition.toString fsp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontKerning x =
  Rule.declaration
    ( {js|fontKerning|js},
      match x with
      | #FontKerning.t as fk -> FontKerning.toString fk
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantPosition x =
  Rule.declaration
    ( {js|fontVariantPosition|js},
      match x with
      | #FontVariantPosition.t as fvp -> FontVariantPosition.toString fvp
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantCaps x =
  Rule.declaration
    ( {js|fontVariantCaps|js},
      match x with
      | #FontVariantCaps.t as fvc -> FontVariantCaps.toString fvc
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontOpticalSizing x =
  Rule.declaration
    ( {js|fontOpticalSizing|js},
      match x with
      | #FontOpticalSizing.t as fos -> FontOpticalSizing.toString fos
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )

let fontVariantEmoji x =
  Rule.declaration
    ( {js|fontVariantEmoji|js},
      match x with
      | #FontVariantEmoji.t as fve -> FontVariantEmoji.toString fve
      | #Var.t as var -> Var.toString var
      | #Cascading.t as c -> Cascading.toString c )
