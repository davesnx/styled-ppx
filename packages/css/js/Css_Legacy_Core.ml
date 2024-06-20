open Css_AtomicTypes
module Std = Kloth

type rule =
  | D of string * string
  | S of string * rule list
  | PseudoClass of string * rule list
  | PseudoClassParam of string * string * rule list

let rec ruleToDict dict rule =
  (match rule with
  | D (name, value) -> Js.Dict.set dict name (Js.Json.string value)
  | S (name, ruleset) -> Js.Dict.set dict name (toJson ruleset)
  | PseudoClass (name, ruleset) ->
    Js.Dict.set dict ({|:|} ^ name) (toJson ruleset)
  | PseudoClassParam (name, param, ruleset) ->
    Js.Dict.set dict ({|:|} ^ name ^ {|(|} ^ param ^ {|)|}) (toJson ruleset));
  dict

and toJson rules =
  Std.List.reduce rules (Js.Dict.empty ()) ruleToDict |. Js.Json.object_

let addStop dict (stop, rules) =
  Js.Dict.set dict (Std.Int.toString stop ^ {|%|}) (toJson rules);
  dict

type animationName = string

module type MakeResult = sig
  type styleEncoding
  type renderer

  val insertRule : string -> unit
  val renderRule : renderer -> string -> unit
  val global : rule list -> unit
  val renderGlobal : renderer -> string -> rule list -> unit
  val style : rule list -> styleEncoding
  val merge : styleEncoding list -> styleEncoding
  val merge2 : styleEncoding -> styleEncoding -> styleEncoding
  val merge3 : styleEncoding -> styleEncoding -> styleEncoding -> styleEncoding

  val merge4 :
    styleEncoding ->
    styleEncoding ->
    styleEncoding ->
    styleEncoding ->
    styleEncoding

  val keyframes : (int * rule list) list -> animationName
  val renderKeyframes : renderer -> (int * rule list) list -> animationName
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

  let style rules = CssImpl.make (rules |. toJson)
  let merge styles = CssImpl.mergeStyles (styles |. Std.List.toArray)
  let merge2 s s2 = merge [ s; s2 ]
  let merge3 s s2 s3 = merge [ s; s2; s3 ]
  let merge4 s s2 s3 s4 = merge [ s; s2; s3; s4 ]

  let keyframes frames =
    CssImpl.makeKeyframes (List.fold_left addStop (Js.Dict.empty ()) frames)

  let renderKeyframes renderer frames =
    CssImpl.renderKeyframes renderer
      (List.fold_left addStop (Js.Dict.empty ()) frames)
end

module Converter = struct
  let string_of_stops stops =
    stops
    |. Std.List.map (fun (c, l) -> Color.toString c ^ {| |} ^ Length.toString l)
    |. Std.List.joinWith ~sep:{|, |}

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
    ( {|alignContent|},
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
    ( {|alignItems|},
      match x with
      | #AlignItems.t as ai -> AlignItems.toString ai
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let alignSelf x =
  D
    ( {|alignSelf|},
      match x with
      | #AlignSelf.t as a -> AlignSelf.toString a
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #OverflowAlignment.t as pa -> OverflowAlignment.toString pa
      | #BaselineAlignment.t as ba -> BaselineAlignment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let animationDelay x = D ({|animationDelay|}, Time.toString x)

let animationDirection x =
  D ({|animationDirection|}, AnimationDirection.toString x)

let animationDuration x = D ({|animationDuration|}, Time.toString x)
let animationFillMode x = D ({|animationFillMode|}, AnimationFillMode.toString x)

let animationIterationCount x =
  D ({|animationIterationCount|}, AnimationIterationCount.toString x)

let animationPlayState x =
  D ({|animationPlayState|}, AnimationPlayState.toString x)

let animationTimingFunction x =
  D ({|animationTimingFunction|}, TimingFunction.toString x)

let backfaceVisibility x =
  D
    ( {|backfaceVisibility|},
      match x with
      | #BackfaceVisibility.t as bv -> BackfaceVisibility.toString bv
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backdropFilter x =
  D
    ( {|backdropFilter|},
      x |. Std.List.map Filter.toString |. Std.List.joinWith ~sep:{|, |} )

let backgroundAttachment x =
  D
    ( {|backgroundAttachment|},
      match x with
      | #BackgroundAttachment.t as ba -> BackgroundAttachment.toString ba
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundColor x = D ({|backgroundColor|}, string_of_color x)

let backgroundClip x =
  D
    ( {|backgroundClip|},
      match x with
      | #BackgroundClip.t as bc -> BackgroundClip.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let string_of_backgroundImage x =
  match x with
  | #BackgroundImage.t as bi -> BackgroundImage.toString bi
  | #Url.t as u -> Url.toString u
  | #Gradient.t as g -> Gradient.toString g

let backgroundImage x = D ({|backgroundImage|}, string_of_backgroundImage x)

let backgroundImages imgs =
  D
    ( {|backgroundImage|},
      imgs
      |. Std.List.map string_of_backgroundImage
      |. Std.List.joinWith ~sep:{|, |} )

let maskImage x =
  D
    ( {|maskImage|},
      match x with
      | #MaskImage.t as mi -> MaskImage.toString mi
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let imageRendering x =
  D
    ( {|imageRendering|},
      match x with
      | #ImageRendering.t as ir -> ImageRendering.toString ir
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let backgroundOrigin x =
  D
    ( {|backgroundOrigin|},
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

let backgroundPositions bp =
  D
    ( {|backgroundPosition|},
      bp
      |. Std.Array.map (fun (x, y) ->
             string_of_backgroundPosition x
             ^ {| |}
             ^ string_of_backgroundPosition y)
      |. Std.Array.joinWith ~sep:{|, |} )

let backgroundRepeat x =
  D
    ( {|backgroundRepeat|},
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

let maskPosition x = D ({|maskPosition|}, string_of_maskposition x)

let maskPositions mp =
  D
    ( {|maskPosition|},
      mp |. Std.List.map string_of_maskposition |. Std.List.joinWith ~sep:{|, |}
    )

let borderImageSource x =
  D
    ( {|borderImageSource|},
      match x with
      | #BorderImageSource.t as b -> BorderImageSource.toString b
      | #Url.t as u -> Url.toString u
      | #Gradient.t as g -> Gradient.toString g )

let borderBottomColor x = D ({|borderBottomColor|}, string_of_color x)
let borderBottomLeftRadius x = D ({|borderBottomLeftRadius|}, Length.toString x)

let borderBottomRightRadius x =
  D ({|borderBottomRightRadius|}, Length.toString x)

let borderBottomWidth x = D ({|borderBottomWidth|}, LineWidth.toString x)

let borderCollapse x =
  D
    ( {|borderCollapse|},
      match x with
      | #BorderCollapse.t as bc -> BorderCollapse.toString bc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let borderColor x = D ({|borderColor|}, string_of_color x)
let borderLeftColor x = D ({|borderLeftColor|}, string_of_color x)
let borderLeftWidth x = D ({|borderLeftWidth|}, LineWidth.toString x)
let borderSpacing x = D ({|borderSpacing|}, Length.toString x)
let borderRadius x = D ({|borderRadius|}, Length.toString x)
let borderRightColor x = D ({|borderRightColor|}, string_of_color x)
let borderRightWidth x = D ({|borderRightWidth|}, LineWidth.toString x)
let borderTopColor x = D ({|borderTopColor|}, string_of_color x)
let borderTopLeftRadius x = D ({|borderTopLeftRadius|}, Length.toString x)
let borderTopRightRadius x = D ({|borderTopRightRadius|}, Length.toString x)
let borderTopWidth x = D ({|borderTopWidth|}, LineWidth.toString x)
let borderWidth x = D ({|borderWidth|}, LineWidth.toString x)
let bottom x = D ({|bottom|}, string_of_position x)

let boxSizing x =
  D
    ( {|boxSizing|},
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
    ( {|clipPath|},
      match x with
      | #ClipPath.t as cp -> ClipPath.toString cp
      | #Url.t as u -> Url.toString u
      | #GeometryBox.t as gb -> GeometryBox.toString gb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let color x = D ({|color|}, string_of_color x)

let columnCount x =
  D
    ( {|columnCount|},
      match x with
      | #ColumnCount.t as cc -> ColumnCount.toString cc
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnGap x = D ({|columnGap|}, string_of_column_gap x)
let rowGap x = D ({|rowGap|}, string_of_row_gap x)
let contentRule x = D ({|content|}, string_of_content x)

let contentRules xs =
  D
    ( {|content|},
      xs |. Std.List.map string_of_content |. Std.List.joinWith ~sep:{| |} )

let counterIncrement x = D ({|counterIncrement|}, string_of_counter_increment x)

let countersIncrement xs =
  D
    ( {|counterIncrement|},
      xs
      |. Std.List.map string_of_counter_increment
      |. Std.List.joinWith ~sep:{| |} )

let counterReset x = D ({|counterReset|}, string_of_counter_reset x)

let countersReset xs =
  D
    ( {|counterReset|},
      xs |. Std.List.map string_of_counter_reset |. Std.List.joinWith ~sep:{| |}
    )

let counterSet x = D ({|counterSet|}, string_of_counter_set x)

let countersSet xs =
  D
    ( {|counterSet|},
      xs |. Std.List.map string_of_counter_set |. Std.List.joinWith ~sep:{| |}
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
    ( {|flexDirection|},
      match x with
      | #FlexDirection.t as fd -> FlexDirection.toString fd
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let flexGrow x = D ({|flexGrow|}, Std.Float.toString x)
let flexShrink x = D ({|flexShrink|}, Std.Float.toString x)

let flexWrap x =
  D
    ( {|flexWrap|},
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
    ( {|fontFamily|},
      match x with
      | #FontFamilyName.t as n -> FontFamilyName.toString n
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontFamilies xs =
  D
    ( {|fontFamily|},
      xs
      |. Std.List.map FontFamilyName.toString
      |. Std.List.joinWith ~sep:{|, |} )

let fontSize x =
  D
    ( {|fontSize|},
      match x with
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontStyle x =
  D
    ( {|fontStyle|},
      match x with
      | #FontStyle.t as f -> FontStyle.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontVariant x =
  D
    ( {|fontVariant|},
      match x with
      | #FontVariant.t as f -> FontVariant.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let fontWeight x =
  D
    ( {|fontWeight|},
      match x with
      | #FontWeight.t as f -> FontWeight.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridAutoFlow x =
  D
    ( {|gridAutoFlow|},
      match x with
      | #GridAutoFlow.t as f -> GridAutoFlow.toString f
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridColumn start end' =
  D ({|gridColumn|}, Std.Int.toString start ^ {| / |} ^ Std.Int.toString end')

let gridColumnGap x = D ({|gridColumnGap|}, string_of_column_gap x)
let gridColumnStart n = D ({|gridColumnStart|}, Std.Int.toString n)
let gridColumnEnd n = D ({|gridColumnEnd|}, Std.Int.toString n)

let gridRow start end' =
  D ({|gridRow|}, Std.Int.toString start ^ {| / |} ^ Std.Int.toString end')

let gap x = D ({|gap|}, string_of_gap x)
let gridGap x = D ({|gridGap|}, string_of_gap x)

let gap2 ~rowGap ~columnGap =
  D ({|gap|}, string_of_gap rowGap ^ {| |} ^ string_of_gap columnGap)

let gridRowGap x =
  D
    ( {|gridRowGap|},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridRowEnd n = D ({|gridRowEnd|}, Std.Int.toString n)
let gridRowStart n = D ({|gridRowStart|}, Std.Int.toString n)

let height x =
  D
    ( {|height|},
      match x with
      | #Height.t as h -> Height.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyContent x =
  D
    ( {|justifyContent|},
      match x with
      | #PositionalAlignment.t as pa -> PositionalAlignment.toString pa
      | #NormalAlignment.t as na -> NormalAlignment.toString na
      | #DistributedAlignment.t as da -> DistributedAlignment.toString da
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let justifyItems x =
  D
    ( {|justifyItems|},
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
    ( {|letterSpacing|},
      match x with
      | #LetterSpacing.t as s -> LetterSpacing.toString s
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let lineHeight x =
  D
    ( {|lineHeight|},
      match x with
      | #LineHeight.t as h -> LineHeight.toString h
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStyle style position image =
  D
    ( {|listStyle|},
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
    ( {|listStyleImage|},
      match x with
      | #ListStyleImage.t as lsi -> ListStyleImage.toString lsi
      | #Url.t as u -> Url.toString u
      | #Var.t as va -> Var.toString va
      | #Gradient.t as g -> Gradient.toString g
      | #Cascading.t as c -> Cascading.toString c )

let listStyleType x =
  D
    ( {|listStyleType|},
      match x with
      | #ListStyleType.t as lsp -> ListStyleType.toString lsp
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let listStylePosition x =
  D
    ( {|listStylePosition|},
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

let marginLeft x = D ({|marginLeft|}, marginToString x)
let marginRight x = D ({|marginRight|}, marginToString x)
let marginTop x = D ({|marginTop|}, marginToString x)
let marginBottom x = D ({|marginBottom|}, marginToString x)

let maxHeight x =
  D
    ( {|maxHeight|},
      match x with
      | #Height.t as mh -> Height.toString mh
      | #MaxHeight.t as mh -> MaxHeight.toString mh
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let maxWidth x =
  D
    ( {|maxWidth|},
      match x with
      | #Width.t as mw -> Width.toString mw
      | #MaxWidth.t as mw -> MaxWidth.toString mw
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minHeight x =
  D
    ( {|minHeight|},
      match x with
      | #Height.t as h -> Height.toString h
      | #MinHeight.t as h -> MinHeight.toString h
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let minWidth x =
  D
    ( {|minWidth|},
      match x with
      | #Width.t as w -> Width.toString w
      | #MinWidth.t as w -> MinWidth.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectFit x =
  D
    ( {|objectFit|},
      match x with
      | #ObjectFit.t as o -> ObjectFit.toString o
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let objectPosition x = D ({|objectPosition|}, string_of_backgroundPosition x)
let opacity x = D ({|opacity|}, Std.Float.toString x)

let outline size style color =
  D
    ( {|outline|},
      LineWidth.toString size
      ^ {| |}
      ^ OutlineStyle.toString style
      ^ {| |}
      ^ string_of_color color )

let outlineColor x = D ({|outlineColor|}, string_of_color x)
let outlineOffset x = D ({|outlineOffset|}, Length.toString x)
let outlineStyle x = D ({|outlineStyle|}, OutlineStyle.toString x)
let outlineWidth x = D ({|outlineWidth|}, LineWidth.toString x)
let overflow x = D ({|overflow|}, Overflow.toString x)
let overflowX x = D ({|overflowX|}, Overflow.toString x)
let overflowY x = D ({|overflowY|}, Overflow.toString x)

let overflowWrap x =
  D
    ( {|overflowWrap|},
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

let paddingBottom x = D ({|paddingBottom|}, Length.toString x)
let paddingLeft x = D ({|paddingLeft|}, Length.toString x)
let paddingRight x = D ({|paddingRight|}, Length.toString x)
let paddingTop x = D ({|paddingTop|}, Length.toString x)

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
    ( {|perspectiveOrigin|},
      match x with
      | #Perspective.t as p -> Perspective.toString p
      | #TransformOrigin.t as t -> TransformOrigin.toString t )

let perspectiveOrigin2 x y =
  D
    ( {|perspectiveOrigin|},
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
    ( {|pointerEvents|},
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
    ( {|justifySelf|},
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
    ( {|tableLayout|},
      match x with
      | #TableLayout.t as tl -> TableLayout.toString tl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textAlign x =
  D
    ( {|textAlign|},
      match x with
      | #TextAlign.t as ta -> TextAlign.toString ta
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationColor x =
  D
    ( {|textDecorationColor|},
      match x with
      | #Color.t as co -> Color.toString co
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationLine x =
  D
    ( {|textDecorationLine|},
      match x with
      | #TextDecorationLine.t as tdl -> TextDecorationLine.toString tdl
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationStyle x =
  D
    ( {|textDecorationStyle|},
      match x with
      | #TextDecorationStyle.t as tds -> TextDecorationStyle.toString tds
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textDecorationThickness x =
  D
    ( {|textDecorationThickness|},
      match x with
      | #TextDecorationThickness.t as t -> TextDecorationThickness.toString t
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textIndent x =
  D
    ( {|textIndent|},
      match x with
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textOverflow x =
  D
    ( {|textOverflow|},
      match x with
      | #TextOverflow.t as txo -> TextOverflow.toString txo
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textTransform x =
  D
    ( {|textTransform|},
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
      x |. Std.List.map Transform.toString |. Std.List.joinWith ~sep:{| |} )

let transformOrigin x = D ({|transformOrigin|}, TransformOrigin.toString x)

let transformOrigin2 x y =
  D
    ( {|transformOrigin|},
      TransformOrigin.toString x ^ {| |} ^ TransformOrigin.toString y )

let transformOrigin3d x y z =
  D
    ( {|transformOrigin|},
      Length.toString x
      ^ {| |}
      ^ Length.toString y
      ^ {| |}
      ^ Length.toString z
      ^ {| |} )

let transformBox x = D ({|transformBox|}, TransformBox.toString x)
let unsafe property value = D (property, value)

let userSelect x =
  D
    ( {|userSelect|},
      match x with
      | #UserSelect.t as us -> UserSelect.toString us
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let verticalAlign x =
  D
    ( {|verticalAlign|},
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
    ( {|scrollBehavior|},
      match x with
      | #ScrollBehavior.t as sb -> ScrollBehavior.toString sb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overscrollBehavior x =
  D
    ( {|overscrollBehavior|},
      match x with
      | #OverscrollBehavior.t as osb -> OverscrollBehavior.toString osb
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let overflowAnchor x =
  D
    ( {|overflowAnchor|},
      match x with
      | #OverflowAnchor.t as oa -> OverflowAnchor.toString oa
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let columnWidth x =
  D
    ( {|columnWidth|},
      match x with
      | #ColumnWidth.t as cw -> ColumnWidth.toString cw
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let caretColor x =
  D
    ( {|caretColor|},
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
    ( {|whiteSpace|},
      match x with
      | #WhiteSpace.t as w -> WhiteSpace.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordBreak x =
  D
    ( {|wordBreak|},
      match x with
      | #WordBreak.t as w -> WordBreak.toString w
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordSpacing x =
  D
    ( {|wordSpacing|},
      match x with
      | #WordSpacing.t as w -> WordSpacing.toString w
      | #Percentage.t as p -> Percentage.toString p
      | #Length.t as l -> Length.toString l
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let wordWrap = overflowWrap
let zIndex x = D ({|zIndex|}, ZIndex.toString x)
let media query rules = S ({|@media |} ^ query, rules)
let selector selector rules = S (selector, rules)
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
let after rules = selector {|::after|} rules
let before rules = selector {|::before|} rules
let firstLetter rules = selector {|::first-letter|} rules
let firstLine rules = selector {|::first-line|} rules
let selection rules = selector {|::selection|} rules
let child x rules = selector ({| > |} ^ x) rules
let children rules = selector {| > *|} rules
let directSibling rules = selector {| + |} rules
let placeholder rules = selector {|::placeholder|} rules
let siblings rules = selector {| ~ |} rules
let anyLink rules = selector {|:any-link|} rules

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
let areas items = GridTemplateAreas.areas (Std.List.toArray items)
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
    ( {|flexBasis|},
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
  | `subgrid -> {|subgrid|}
  | `auto -> {|auto|}
  | #Length.t as l -> Length.toString l
  | `fr x -> Std.Float.toString x ^ {|fr|}
  | `minContent -> {|min-content|}
  | `maxContent -> {|max-content|}
  | `fitContent x -> {|fit-content|} ^ {|(|} ^ Length.toString x ^ {|)|}
  | `repeat (n, x) ->
    {|repeat(|}
    ^ RepeatValue.toString n
    ^ {|, |}
    ^ string_of_dimensions x
    ^ {|)|}
  | `minmax (a, b) ->
    {|minmax(|} ^ string_of_minmax a ^ {|,|} ^ string_of_minmax b ^ {|)|}

and string_of_dimensions dimensions =
  dimensions |> List.map gridLengthToJs |> String.concat {| |}

let gridTemplateColumns dimensions =
  D ({|gridTemplateColumns|}, string_of_dimensions dimensions)

let gridTemplateRows dimensions =
  D ({|gridTemplateRows|}, string_of_dimensions dimensions)

let gridAutoColumns dimensions =
  D ({|gridAutoColumns|}, string_of_dimension dimensions)

let gridAutoRows dimensions =
  D ({|gridAutoRows|}, string_of_dimension dimensions)

let gridArea s =
  D
    ( {|gridArea|},
      match s with
      | #GridArea.t as t -> GridArea.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let gridArea2 s s2 =
  D ({|gridArea|}, GridArea.toString s ^ {| / |} ^ GridArea.toString s2)

let gridArea3 s s2 s3 =
  D
    ( {|gridArea|},
      GridArea.toString s
      ^ {| / |}
      ^ GridArea.toString s2
      ^ {| / |}
      ^ GridArea.toString s3 )

let gridArea4 s s2 s3 s4 =
  D
    ( {|gridArea|},
      GridArea.toString s
      ^ {| / |}
      ^ GridArea.toString s2
      ^ {| / |}
      ^ GridArea.toString s3
      ^ {| / |}
      ^ GridArea.toString s4 )

let gridTemplateAreas l =
  D
    ( {|gridTemplateAreas|},
      match l with
      | #GridTemplateAreas.t as t -> GridTemplateAreas.toString t
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let filter x =
  D
    ( {|filter|},
      x |. Std.List.map Filter.toString |. Std.List.joinWith ~sep:{| |} )

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
      ^ if [@ns.ternary] inset then {| inset|} else {||})

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
    ( {|boxShadow|},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let boxShadows x =
  D
    ( {|boxShadow|},
      x |. Std.List.map Shadow.toString |. Std.List.joinWith ~sep:{|, |} )

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

let borderStyle x = D ({|borderStyle|}, string_of_borderstyle x)

let borderLeft px style color =
  D
    ( {|borderLeft|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderLeftStyle x = D ({|borderLeftStyle|}, string_of_borderstyle x)

let borderRight px style color =
  D
    ( {|borderRight|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderRightStyle x = D ({|borderRightStyle|}, string_of_borderstyle x)

let borderTop px style color =
  D
    ( {|borderTop|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderTopStyle x = D ({| |}, string_of_borderstyle x)

let borderBottom px style color =
  D
    ( {|borderBottom|},
      LineWidth.toString px
      ^ {| |}
      ^ string_of_borderstyle style
      ^ {| |}
      ^ string_of_color color )

let borderBottomStyle x = D ({|borderBottomStyle|}, string_of_borderstyle x)

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
      |. Std.List.map (fun item ->
             match item with
             | #Color.t as c -> Color.toString c
             | #Url.t as u -> Url.toString u
             | #Gradient.t as g -> Gradient.toString g
             | `none -> {|none|})
      |. Std.List.joinWith ~sep:{|, |} )

let backgroundSize x =
  D
    ( {|backgroundSize|},
      match x with
      | `size (x, y) -> Length.toString x ^ {| |} ^ Length.toString y
      | `auto -> {|auto|}
      | `cover -> {|cover|}
      | `contain -> {|contain|} )

let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
    =
  let fontStyle =
    match fontStyle with
    | Some value -> {|font-style: |} ^ FontStyle.toString value ^ {|;|}
    | _ -> ""
  in
  let src =
    src
    |> List.map (fun x ->
           match x with
           | `localUrl value -> ({|local("|} ^ value) ^ {|")|}
           | `url value -> ({|url("|} ^ value) ^ {|")|})
    |> String.concat {|, |}
  in
  let fontWeight =
    Belt.Option.mapWithDefault fontWeight {||} (fun w ->
        {|font-weight: |}
        ^ (match w with
          | #FontWeight.t as f -> FontWeight.toString f
          | #Var.t as va -> Var.toString va
          | #Cascading.t as c -> Cascading.toString c)
        ^ {|;|})
  in
  let fontDisplay =
    Belt.Option.mapWithDefault fontDisplay {||} (fun f ->
        {|font-display: |} ^ FontDisplay.toString f ^ {|;|})
  in
  let sizeAdjust =
    Belt.Option.mapWithDefault sizeAdjust {||} (fun s ->
        {|size-adjust: |} ^ Percentage.toString s ^ {|;|})
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
    ( {|textDecoration|},
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
    ( {|textShadow|},
      match x with
      | #Shadow.t as s -> Shadow.toString s
      | #Var.t as va -> Var.toString va
      | #Cascading.t as c -> Cascading.toString c )

let textShadows x =
  D
    ( {|textShadow|},
      x |. Std.List.map Shadow.toString |. Std.List.joinWith ~sep:{|, |} )

let transformStyle x =
  D
    ( {|transformStyle|},
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
      x |. Std.List.map Transition.toString |. Std.List.joinWith ~sep:{|, |} )

let transitions = transitionList

let transition ?duration ?delay ?timingFunction property =
  transitionValue
    (Transition.shorthand ?duration ?delay ?timingFunction property)

let transitionDelay i = D ({|transitionDelay|}, Time.toString i)
let transitionDuration i = D ({|transitionDuration|}, Time.toString i)

let transitionTimingFunction x =
  D ({|transitionTimingFunction|}, TimingFunction.toString x)

let transitionProperty x = D ({|transitionProperty|}, x)

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
      x |. Std.List.map Animation.toString |. Std.List.joinWith ~sep:{|, |} )

let animationName x = D ({|animationName|}, x)

module SVG = struct
  let fill x =
    D
      ( {|fill|},
        match x with
        | #SVG.Fill.t as f -> SVG.Fill.toString f
        | #Color.t as c -> Color.toString c
        | #Var.t as v -> Var.toString v
        | #Url.t as u -> Url.toString u )

  let fillOpacity opacity = D ({|fillOpacity|}, Std.Float.toString opacity)

  let fillRule x =
    D
      ( {|fillRule|},
        match x with `evenodd -> {|evenodd|} | `nonzero -> {|nonzero|} )

  let stroke x = D ({|stroke|}, string_of_color x)

  let strokeDasharray x =
    D
      ( {|strokeDasharray|},
        match x with
        | `none -> {|none|}
        | `dasharray a ->
          a |. Std.List.map string_of_dasharray |. Std.List.joinWith ~sep:{| |}
      )

  let strokeWidth x = D ({|strokeWidth|}, Length.toString x)
  let strokeOpacity opacity = D ({|strokeOpacity|}, AlphaValue.toString opacity)
  let strokeMiterlimit x = D ({|strokeMiterlimit|}, Std.Float.toString x)

  let strokeLinecap x =
    D
      ( {|strokeLinecap|},
        match x with
        | `butt -> {|butt|}
        | `round -> {|round|}
        | `square -> {|square|} )

  let strokeLinejoin x =
    D
      ( {|strokeLinejoin|},
        match x with
        | `miter -> {|miter|}
        | `round -> {|round|}
        | `bevel -> {|bevel|} )

  let stopColor x = D ({|stopColor|}, string_of_color x)
  let stopOpacity x = D ({|stopOpacity|}, Std.Float.toString x)
end
[@@ns.doc "\n * SVG\n "]

let touchAction x = D ({|touchAction|}, x |. TouchAction.toString)
