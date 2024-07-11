open Css_types

let important v =
  match v with
  | Rule.Declaration (name, value) ->
    Rule.Declaration (name, value ^ {js| !important|js})
  | Rule.Selector (_, _) -> v

let label label = Rule.declaration ({js|label|js}, label)

let aspectRatio x =
  Rule.declaration
    ( {js|aspectRatio|js},
      match x with #AspectRatio.t as ar -> AspectRatio.toString ar )

let alignContent x =
  Rule.declaration
    ( {js|alignContent|js},
      match x with #AlignContent.t as ac -> AlignContent.toString ac )

let alignItems x =
  Rule.declaration
    ( {js|alignItems|js},
      match x with #AlignItems.t as ai -> AlignItems.toString ai )

let alignSelf x =
  Rule.declaration
    ({js|alignSelf|js}, match x with #AlignSelf.t as a -> AlignSelf.toString a)

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
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv )

let backdropFilter x =
  Rule.declaration
    ( {js|backdropFilter|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} x ~f:Filter.toString )

let backgroundAttachment x =
  Rule.declaration
    ({js|backgroundAttachment|js}, BackgroundAttachment.toString x)

let backgroundColor x =
  Rule.declaration ({js|backgroundColor|js}, Color.toString x)

let backgroundClip x =
  Rule.declaration
    ( {js|backgroundClip|js},
      match x with #BackgroundClip.t as bc -> BackgroundClip.toString bc )

let backgroundImage x =
  Rule.declaration ({js|backgroundImage|js}, BackgroundImage.toString x)

let backgroundImages imgs =
  Rule.declaration
    ( {js|backgroundImage|js},
      Kloth.Array.map_and_join imgs ~sep:{js|, |js} ~f:BackgroundImage.toString
    )

(* https://developer.mozilla.org/en-US/docs/Web/CSS/mask-image *)
let maskImage x = Rule.declaration ({js|maskImage|js}, MaskImage.toString x)

(* https://developer.mozilla.org/en-US/docs/Web/CSS/image-rendering *)
let imageRendering x =
  Rule.declaration ({js|imageRendering|js}, ImageRendering.toString x)

let backgroundOrigin x =
  Rule.declaration ({js|backgroundOrigin|js}, BackgroundOrigin.toString x)

let backgroundPosition x =
  Rule.declaration ({js|backgroundPosition|js}, Position.toString x)

let backgroundPosition2 x y =
  Rule.declaration
    ( {js|backgroundPosition|js},
      Position.toString x ^ {js| |js} ^ Position.toString y )

let backgroundPosition4 ~x ~offsetX ~y ~offsetY =
  Rule.declaration
    ( {js|backgroundPosition|js},
      Position.toString x
      ^ {js| |js}
      ^ Length.toString offsetX
      ^ {js| |js}
      ^ Position.toString y
      ^ {js| |js}
      ^ Length.toString offsetY )

let backgroundPositions bp =
  Rule.declaration
    ( {js|backgroundPosition|js},
      Kloth.Array.map_and_join bp ~sep:{js|, |js} ~f:(fun (x, y) ->
          Position.toString x ^ {js| |js} ^ Position.toString y) )

let backgroundRepeat x =
  Rule.declaration ({js|backgroundRepeat|js}, BackgroundRepeat.toString x)

let maskPosition x =
  Rule.declaration ({js|maskPosition|js}, MaskPosition.toString x)

let maskPositions mp =
  Rule.declaration
    ( {js|maskPosition|js},
      Kloth.Array.map_and_join mp ~sep:{js|, |js} ~f:MaskPosition.toString )

(* https://developer.mozilla.org/en-US/docs/Web/CSS/border-image-source *)
let borderImageSource x =
  Rule.declaration ({js|borderImageSource|js}, BorderImageSource.toString x)

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
      match x with #BorderCollapse.t as bc -> BorderCollapse.toString bc )

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
let bottom x = Rule.declaration ({js|bottom|js}, Position.toString x)
let boxSizing x = Rule.declaration ({js|boxSizing|js}, BoxSizing.toString x)
let clear x = Rule.declaration ({js|clear|js}, Clear.toString x)
let clipPath x = Rule.declaration ({js|clipPath|js}, ClipPath.toString x)
let color x = Rule.declaration ({js|color|js}, Color.toString x)

let columnCount x =
  Rule.declaration ({js|columnCount|js}, ColumnCount.toString x)

let rowGap x = Rule.declaration ({js|rowGap|js}, Gap.toString x)
let columnGap x = Rule.declaration ({js|columnGap|js}, Gap.toString x)
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
  Rule.declaration ({js|counterIncrement|js}, CounterIncrement.toString x)

let countersIncrement xs =
  Rule.declaration
    ( {js|counterIncrement|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:CounterIncrement.toString )

let counterReset x =
  Rule.declaration ({js|counterReset|js}, CounterReset.toString x)

let countersReset xs =
  Rule.declaration
    ( {js|counterReset|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:CounterReset.toString )

let counterSet x = Rule.declaration ({js|counterSet|js}, CounterSet.toString x)

let countersSet xs =
  Rule.declaration
    ( {js|counterSet|js},
      Kloth.Array.map_and_join ~sep:{js| |js} xs ~f:CounterSet.toString )

let cursor x = Rule.declaration ({js|cursor|js}, Cursor.toString x)
let direction x = Rule.declaration ({js|direction|js}, Direction.toString x)

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
  Rule.declaration ({js|flexDirection|js}, FlexDirection.toString x)

let flexGrow x = Rule.declaration ({js|flexGrow|js}, Kloth.Float.to_string x)
let flexShrink x = Rule.declaration ({js|flexShrink|js}, Kloth.Float.to_string x)
let flexWrap x = Rule.declaration ({js|flexWrap|js}, FlexWrap.toString x)
let float x = Rule.declaration ({js|float|js}, Float.toString x)

let fontFamily x =
  Rule.declaration ({js|fontFamily|js}, FontFamilyName.toString x)

let fontFamilies xs =
  Rule.declaration
    ( {js|fontFamily|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:FontFamilyName.toString xs )

let fontSize x = Rule.declaration ({js|fontSize|js}, Length.toString x)
let fontStyle x = Rule.declaration ({js|fontStyle|js}, FontStyle.toString x)

let fontVariant x =
  Rule.declaration ({js|fontVariant|js}, FontVariant.toString x)

let fontWeight x = Rule.declaration ({js|fontWeight|js}, FontWeight.toString x)

let fontDisplay x =
  Rule.declaration ({js|fontDisplay|js}, FontDisplay.toString x)

let sizeAdjust x = Rule.declaration ({js|sizeAdjust|js}, Percentage.toString x)

let gridAutoFlow x =
  Rule.declaration ({js|gridAutoFlow|js}, GridAutoFlow.toString x)

let gridColumn start end' =
  Rule.declaration
    ( {js|gridColumn|js},
      Kloth.Int.to_string start ^ {js| / |js} ^ Kloth.Int.to_string end' )

let gridColumnGap x = Rule.declaration ({js|gridColumnGap|js}, Gap.toString x)

let gridColumnStart n =
  Rule.declaration ({js|gridColumnStart|js}, Kloth.Int.to_string n)

let gridColumnEnd n =
  Rule.declaration ({js|gridColumnEnd|js}, Kloth.Int.to_string n)

let gridRow start end' =
  Rule.declaration
    ( {js|gridRow|js},
      Kloth.Int.to_string start ^ {js| / |js} ^ Kloth.Int.to_string end' )

let gap x = Rule.declaration ({js|gap|js}, Gap.toString x)
let gridGap x = Rule.declaration ({js|gridGap|js}, Gap.toString x)

let gap2 ~rowGap ~columnGap =
  Rule.declaration
    ({js|gap|js}, Gap.toString rowGap ^ {js| |js} ^ Gap.toString columnGap)

let gridRowGap x = Rule.declaration ({js|gridRowGap|js}, Gap.toString x)
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
  Rule.declaration ({js|justifyContent|js}, JustifyContent.toString x)

let justifyItems x =
  Rule.declaration ({js|justifyItems|js}, JustifyItems.toString x)

let left x = Rule.declaration ({js|left|js}, Position.toString x)

let letterSpacing x =
  Rule.declaration ({js|letterSpacing|js}, LetterSpacing.toString x)

let lineHeight x = Rule.declaration ({js|lineHeight|js}, LineHeight.toString x)

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
      match x with #ListStyleImage.t as lsi -> ListStyleImage.toString lsi )

let listStyleType x =
  Rule.declaration
    ( {js|listStyleType|js},
      match x with #ListStyleType.t as lsp -> ListStyleType.toString lsp )

let listStylePosition x =
  Rule.declaration ({js|listStylePosition|js}, ListStylePosition.toString x)

let tabSize x = Rule.declaration ({|tabSize|}, TabSize.toString x)
let margin x = Rule.declaration ({js|margin|js}, Margin.toString x)

let margin2 ~v ~h =
  Rule.declaration
    ({js|margin|js}, Margin.toString v ^ {js| |js} ^ Margin.toString h)

let margin3 ~top ~h ~bottom =
  Rule.declaration
    ( {js|margin|js},
      Margin.toString top
      ^ {js| |js}
      ^ Margin.toString h
      ^ {js| |js}
      ^ Margin.toString bottom )

let margin4 ~top ~right ~bottom ~left =
  Rule.declaration
    ( {js|margin|js},
      Margin.toString top
      ^ {js| |js}
      ^ Margin.toString right
      ^ {js| |js}
      ^ Margin.toString bottom
      ^ {js| |js}
      ^ Margin.toString left )

let marginLeft x = Rule.declaration ({js|marginLeft|js}, Margin.toString x)
let marginRight x = Rule.declaration ({js|marginRight|js}, Margin.toString x)
let marginTop x = Rule.declaration ({js|marginTop|js}, Margin.toString x)
let marginBottom x = Rule.declaration ({js|marginBottom|js}, Margin.toString x)

let maxHeight x =
  Rule.declaration
    ( {js|maxHeight|js},
      match x with #MaxHeight.t as mh -> MaxHeight.toString mh )

let maxWidth x =
  Rule.declaration
    ({js|maxWidth|js}, match x with #MaxWidth.t as mw -> MaxWidth.toString mw)

let minHeight x =
  Rule.declaration
    ( {js|minHeight|js},
      match x with #MinHeight.t as mh -> MinHeight.toString mh )

let minWidth x =
  Rule.declaration
    ({js|minWidth|js}, match x with #MinWidth.t as w -> MinWidth.toString w)

let objectFit x =
  Rule.declaration
    ({js|objectFit|js}, match x with #ObjectFit.t as o -> ObjectFit.toString o)

let objectPosition x =
  Rule.declaration ({js|objectPosition|js}, Position.toString x)

let objectPosition2 x y =
  Rule.declaration
    ( {js|objectPosition|js},
      Position.toString x ^ {js| |js} ^ Position.toString y )

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

let right x = Rule.declaration ({js|right|js}, Position.toString x)

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

let top x = Rule.declaration ({js|top|js}, Position.toString x)

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

let boxShadow x =
  Rule.declaration
    ({js|boxShadow|js}, match x with #Shadow.t as s -> Shadow.toString s)

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
  Rule.declaration ({js|backgroundSize|js}, BackgroundSize.toString x)

let textDecoration x =
  Rule.declaration ({js|textDecoration|js}, TextDecoration.toString x)

let textShadow x =
  Rule.declaration
    ({js|textShadow|js}, match x with #Shadow.t as s -> Shadow.toString s)

let textShadows x =
  Rule.declaration
    ( {js|textShadow|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} x ~f:Shadow.toString )

let transformStyle x =
  Rule.declaration
    ( {js|transformStyle|js},
      match x with #TransformStyle.t as ts -> TransformStyle.toString ts )

let transitionList x =
  Rule.declaration
    ( {js|transition|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:Transition.toString x )

let transition ?duration ?delay ?timingFunction property =
  Rule.declaration
    ( {js|transition|js},
      Transition.toString
        (Transition.make ?duration ?delay ?timingFunction property) )

let transitionDelay i =
  Rule.declaration ({js|transitionDelay|js}, Time.toString i)

let transitionDuration i =
  Rule.declaration ({js|transitionDuration|js}, Time.toString i)

let transitionTimingFunction x =
  Rule.declaration ({js|transitionTimingFunction|js}, TimingFunction.toString x)

let transitionProperty x = Rule.declaration ({js|transitionProperty|js}, x)

let animation ?duration ?delay ?direction ?timingFunction ?fillMode ?playState
  ?iterationCount name =
  Rule.declaration
    ( {js|animation|js},
      Animation.toString
      @@ Animation.make ?duration ?delay ?direction ?timingFunction ?fillMode
           ?playState ?iterationCount name )

let animations x =
  Rule.declaration
    ( {js|animation|js},
      Kloth.Array.map_and_join ~sep:{js|, |js} ~f:Animation.toString x )

let animationName x = Rule.declaration ({js|animationName|js}, x)

module SVG = struct
  let fill x = Rule.declaration ({js|fill|js}, SVG.Fill.toString x)

  let fillOpacity opacity =
    Rule.declaration ({js|fillOpacity|js}, Kloth.Float.to_string opacity)

  (* ??? *)
  let fillRule x =
    Rule.declaration
      ( {js|fillRule|js},
        match x with `evenodd -> {js|evenodd|js} | `nonzero -> {js|nonzero|js}
      )

  (* ??? *)
  let stroke x = Rule.declaration ({js|stroke|js}, Color.toString x)

  let strokeDasharray x =
    Rule.declaration
      ( {js|strokeDasharray|js},
        match x with
        | `none -> {js|none|js}
        | `dasharray a ->
          Kloth.Array.map_and_join a ~f:StrokeDashArray.toString ~sep:{js| |js}
      )

  (* ??? *)
  let strokeWidth x = Rule.declaration ({js|strokeWidth|js}, Length.toString x)

  (* ??? *)
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

  (* ??? *)
  let stopColor x = Rule.declaration ({js|stopColor|js}, Color.toString x)

  let stopOpacity x =
    (* ??? *)
    Rule.declaration ({js|stopOpacity|js}, Kloth.Float.to_string x)
end

let touchAction x =
  Rule.declaration ({js|touchAction|js}, TouchAction.toString x)

let textEmphasisColor x =
  Rule.declaration ({js|textEmphasisColor|js}, Color.toString x)

let lineBreak x = Rule.declaration ({js|lineBreak|js}, LineBreak.toString x)
let hyphens x = Rule.declaration ({js|hyphens|js}, Hyphens.toString x)

let textJustify x =
  Rule.declaration ({js|textJustify|js}, TextJustify.toString x)

let overflowInline x =
  Rule.declaration ({js|overflowInline|js}, OverflowInline.toString x)

let overflowBlock x =
  (* overflowBlock and overflowInline have the same values *)
  Rule.declaration ({js|overflowBlock|js}, OverflowInline.toString x)

let fontSynthesisWeight x =
  Rule.declaration
    ( {js|fontSynthesisWeight|js},
      match x with
      | #FontSynthesisWeight.t as fsw -> FontSynthesisWeight.toString fsw )

let fontSynthesisStyle x =
  Rule.declaration
    ( {js|fontSynthesisStyle|js},
      match x with
      | #FontSynthesisStyle.t as fss -> FontSynthesisStyle.toString fss )

let fontSynthesisSmallCaps x =
  Rule.declaration
    ({js|fontSynthesisSmallCaps|js}, FontSynthesisSmallCaps.toString x)

let fontSynthesisPosition x =
  Rule.declaration
    ({js|fontSynthesisWeight|js}, FontSynthesisPosition.toString x)

let fontKerning x =
  Rule.declaration ({js|fontKerning|js}, FontKerning.toString x)

let fontVariantPosition x =
  Rule.declaration ({js|fontVariantPosition|js}, FontVariantPosition.toString x)

let fontVariantCaps x =
  Rule.declaration ({js|fontVariantCaps|js}, FontVariantCaps.toString x)

let fontOpticalSizing x =
  Rule.declaration ({js|fontOpticalSizing|js}, FontOpticalSizing.toString x)

let fontVariantEmoji x =
  Rule.declaration ({js|fontVariantEmoji|js}, FontVariantEmoji.toString x)
