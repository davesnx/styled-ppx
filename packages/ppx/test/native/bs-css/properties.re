open Rule;
open Values;
open Converter;

let concatArr = (f, separator, arr) =>
  arr |> Array.map(f) |> Array.to_list |> String.concat(separator);

let alignContent = x =>
  Declaration(
    "align-content",
    switch (x) {
    | #AlignContent.t as ac => AlignContent.toString(ac)
    | #NormalAlignment.t as na => NormalAlignment.toString(na)
    | #BaselineAlignment.t as ba => BaselineAlignment.toString(ba)
    | #DistributedAlignment.t as da => DistributedAlignment.toString(da)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let alignItems = x =>
  Declaration(
    "align-items",
    switch (x) {
    | #AlignItems.t as ai => AlignItems.toString(ai)
    | #PositionalAlignment.t as pa => PositionalAlignment.toString(pa)
    | #BaselineAlignment.t as ba => BaselineAlignment.toString(ba)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let alignSelf = x =>
  Declaration(
    "align-self",
    switch (x) {
    | #AlignSelf.t as a => AlignSelf.toString(a)
    | #PositionalAlignment.t as pa => PositionalAlignment.toString(pa)
    | #BaselineAlignment.t as ba => BaselineAlignment.toString(ba)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let animationDelay = x => Declaration("animation-delay", string_of_time(x));

let animationDirection = x =>
  Declaration("animation-direction", AnimationDirection.toString(x));

let animationDuration = x =>
  Declaration("animation-duration", string_of_time(x));

let animationFillMode = x =>
  Declaration("animation-fill-mode", AnimationFillMode.toString(x));

let animationIterationCount = x =>
  Declaration(
    "animation-iteration-count",
    AnimationIterationCount.toString(x),
  );

let animationPlayState = x =>
  Declaration("animation-play-state", AnimationPlayState.toString(x));

let animationTimingFunction = x =>
  Declaration("animation-timing-function", TimingFunction.toString(x));

let backfaceVisibility = x =>
  Declaration(
    "backface-visibility",
    switch (x) {
    | #BackfaceVisibility.t as bv => BackfaceVisibility.toString(bv)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let backdropFilter = x =>
  Declaration(
    "backdrop-filter",
    x |> concatArr(BackdropFilter.toString, ", "),
  );

let backgroundAttachment = x =>
  Declaration(
    "background-attachment",
    switch (x) {
    | #BackgroundAttachment.t as ba => BackgroundAttachment.toString(ba)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let backgroundColor = x =>
  Declaration("background-color", string_of_color(x));

let backgroundClip = x =>
  Declaration(
    "background-clip",
    switch (x) {
    | #BackgroundClip.t as bc => BackgroundClip.toString(bc)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let backgroundImage = x =>
  Declaration(
    "background-image",
    switch (x) {
    | #BackgroundImage.t as bi => BackgroundImage.toString(bi)
    | #Url.t as u => Url.toString(u)
    | #Gradient.t as g => Gradient.toString(g)
    },
  );

let backgroundOrigin = x =>
  Declaration(
    "background-origin",
    switch (x) {
    | #BackgroundOrigin.t as bo => BackgroundOrigin.toString(bo)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let string_of_backgroundposition =
  fun
  | #BackgroundPosition.t as bp => BackgroundPosition.toString(bp)
  | `hv(h, v) =>
    (
      switch (h) {
      | #BackgroundPosition.X.t as h => BackgroundPosition.X.toString(h)
      | #Length.t as l => Length.toString(l)
      }
    )
    ++ " "
    ++ (
      switch (v) {
      | #BackgroundPosition.Y.t as v => BackgroundPosition.Y.toString(v)
      | #Length.t as l => Length.toString(l)
      }
    )
  | #Length.t as l => Length.toString(l)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c);

let backgroundPosition = x =>
  Declaration("background-position", string_of_backgroundposition(x));

let backgroundPositions = bp =>
  Declaration(
    "background-position",
    bp |> concatArr(string_of_backgroundposition, ", "),
  );

let backgroundPosition4 = (~x, ~offsetX, ~y, ~offsetY) =>
  Declaration(
    "background-position",
    BackgroundPosition.X.toString(x)
    ++ " "
    ++ Length.toString(offsetX)
    ++ " "
    ++ BackgroundPosition.Y.toString(y)
    ++ " "
    ++ Length.toString(offsetY),
  );

let backgroundRepeat = x =>
  Declaration(
    "background-repeat",
    switch (x) {
    | #BackgroundRepeat.t as br => BackgroundRepeat.toString(br)
    | `hv(#BackgroundRepeat.horizontal as h, #BackgroundRepeat.vertical as v) =>
      BackgroundRepeat.toString(h) ++ ", " ++ BackgroundRepeat.toString(v)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let borderBottomColor = x =>
  Declaration("border-bottom-color", string_of_color(x));

let borderBottomLeftRadius = x =>
  Declaration("border-bottom-left-radius", Length.toString(x));

let borderBottomRightRadius = x =>
  Declaration("border-bottom-right-radius", Length.toString(x));

let borderBottomWidth = x =>
  Declaration("border-bottom-width", Length.toString(x));

let borderCollapse = x =>
  Declaration(
    "border-collapse",
    switch (x) {
    | #BorderCollapse.t as bc => BorderCollapse.toString(bc)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let borderColor = x => Declaration("border-color", string_of_color(x));

let borderLeftColor = x =>
  Declaration("border-left-color", string_of_color(x));

let borderLeftWidth = x =>
  Declaration("border-left-width", Length.toString(x));

let borderSpacing = x => Declaration("border-spacing", Length.toString(x));

let borderRadius = x => Declaration("border-radius", Length.toString(x));

let borderRightColor = x =>
  Declaration("border-right-color", string_of_color(x));

let borderRightWidth = x =>
  Declaration("border-right-width", Length.toString(x));

let borderTopColor = x =>
  Declaration("border-top-color", string_of_color(x));

let borderTopLeftRadius = x =>
  Declaration("border-top-left-radius", Length.toString(x));

let borderTopRightRadius = x =>
  Declaration("border-top-right-radius", Length.toString(x));

let borderTopWidth = x =>
  Declaration("border-top-width", Length.toString(x));

let borderWidth = x => Declaration("border-width", Length.toString(x));

let bottom = x => Declaration("bottom", string_of_position(x));

let boxSizing = x =>
  Declaration(
    "box-sizing",
    switch (x) {
    | #BoxSizing.t as bs => BoxSizing.toString(bs)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let clear = x =>
  Declaration(
    "clear",
    switch (x) {
    | #Clear.t as cl => Clear.toString(cl)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let clipPath = x =>
  Declaration(
    "clip-path",
    switch (x) {
    | #ClipPath.t as cp => ClipPath.toString(cp)
    | #Url.t as u => Url.toString(u)
    | #GeometyBox.t as gb => GeometyBox.toString(gb)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let color = x => Declaration("color", string_of_color(x));

let columnCount = x =>
  Declaration(
    "column-count",
    switch (x) {
    | #ColumnCount.t as cc => ColumnCount.toString(cc)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let columnGap = x => Declaration("column-gap", string_of_column_gap(x));

let contentRule = x => Declaration("content", string_of_content(x));
let contentRules = xs =>
  Declaration("content", xs |> concatArr(string_of_content, " "));

let counterIncrement = x =>
  Declaration("counter-increment", string_of_counter_increment(x));
let countersIncrement = xs =>
  Declaration(
    "counter-increment",
    xs |> concatArr(string_of_counter_increment, " "),
  );

let counterReset = x =>
  Declaration("counter-reset", string_of_counter_reset(x));
let countersReset = xs =>
  Declaration(
    "counter-reset",
    xs |> concatArr(string_of_counter_reset, " "),
  );

let counterSet = x => Declaration("counter-set", string_of_counter_set(x));
let countersSet = xs =>
  Declaration("counter-set", xs |> concatArr(string_of_counter_set, " "));

let cursor = x => Declaration("cursor", Cursor.toString(x));

let direction = x =>
  Declaration(
    "direction",
    switch (x) {
    | #Direction.t as d => Direction.toString(d)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let display = x =>
  Declaration(
    "display",
    switch (x) {
    | #DisplayOutside.t as o => DisplayOutside.toString(o)
    | #DisplayInside.t as i => DisplayInside.toString(i)
    | #DisplayListItem.t as l => DisplayListItem.toString(l)
    | #DisplayInternal.t as i' => DisplayInternal.toString(i')
    | #DisplayBox.t as b => DisplayBox.toString(b)
    | #DisplayLegacy.t as l' => DisplayLegacy.toString(l')
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let flex = x =>
  Declaration(
    "flex",
    switch (x) {
    | #Flex.t as f => Flex.toString(f)
    | `num(n) => Js.Float.toString(n)
    },
  );

let flexDirection = x =>
  Declaration(
    "flex-direction",
    switch (x) {
    | #FlexDirection.t as fd => FlexDirection.toString(fd)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let flexGrow = x => Declaration("flex-grow", Js.Float.toString(x));

let flexShrink = x => Declaration("flex-shrink", Js.Float.toString(x));

let flexWrap = x =>
  Declaration(
    "flex-wrap",
    switch (x) {
    | #FlexWrap.t as fw => FlexWrap.toString(fw)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let float = x =>
  Declaration(
    "float",
    switch (x) {
    | #Float.t as f => Float.toString(f)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let fontFamily = x =>
  Declaration(
    "font-family",
    switch (x) {
    | #FontFamilyName.t as n => FontFamilyName.toString(n)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let fontFamilies = xs =>
  Declaration("font-family", xs |> concatArr(FontFamilyName.toString, ", "));

let fontSize = x =>
  Declaration(
    "font-size",
    switch (x) {
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let fontStyle = x =>
  Declaration(
    "font-style",
    switch (x) {
    | #FontStyle.t as f => FontStyle.toString(f)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let fontVariant = x =>
  Declaration(
    "font-variant",
    switch (x) {
    | #FontVariant.t as f => FontVariant.toString(f)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let fontWeight = x =>
  Declaration(
    "font-weight",
    switch (x) {
    | #FontWeight.t as f => FontWeight.toString(f)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let gridAutoFlow = x =>
  Declaration(
    "grid-auto-flow",
    switch (x) {
    | #GridAutoFlow.t as f => GridAutoFlow.toString(f)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let gridColumn = (start, end') =>
  Declaration(
    "grid-column",
    Int.to_string(start) ++ " / " ++ Int.to_string(end'),
  );

let gridColumnGap = x =>
  Declaration("grid-column-gap", string_of_column_gap(x));

let gridColumnStart = n =>
  Declaration("grid-column-start", Int.to_string(n));

let gridColumnEnd = n => Declaration("grid-column-end", Int.to_string(n));

let gridRow = (start, end') =>
  Declaration(
    "grid-row",
    Int.to_string(start) ++ " / " ++ Int.to_string(end'),
  );

let gridGap = x =>
  Declaration(
    "grid-gap",
    switch (x) {
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let gridRowGap = x =>
  Declaration(
    "grid-row-gap",
    switch (x) {
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let gridRowEnd = n => Declaration("grid-row-end", Int.to_string(n));

let gridRowStart = n => Declaration("grid-row-start", Int.to_string(n));

let height = x =>
  Declaration(
    "height",
    switch (x) {
    | #Height.t as h => Height.toString(h)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let justifyContent = x =>
  Declaration(
    "justify-content",
    switch (x) {
    | #PositionalAlignment.t as pa => PositionalAlignment.toString(pa)
    | #NormalAlignment.t as na => NormalAlignment.toString(na)
    | #DistributedAlignment.t as da => DistributedAlignment.toString(da)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let justifyItems = x =>
  Declaration(
    "justify-items",
    switch (x) {
    | #PositionalAlignment.t as pa => PositionalAlignment.toString(pa)
    | #NormalAlignment.t as na => NormalAlignment.toString(na)
    | #BaselineAlignment.t as ba => BaselineAlignment.toString(ba)
    | #OverflowAlignment.t as oa => OverflowAlignment.toString(oa)
    | #LegacyAlignment.t as la => LegacyAlignment.toString(la)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let left = x => Declaration("left", string_of_position(x));

let letterSpacing = x =>
  Declaration(
    "letter-spacing",
    switch (x) {
    | #LetterSpacing.t as s => LetterSpacing.toString(s)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let lineHeight = x =>
  Declaration(
    "line-height",
    switch (x) {
    | #LineHeight.t as h => LineHeight.toString(h)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let listStyle = (style, position, image) =>
  Declaration(
    "list-style",
    ListStyleType.toString(style)
    ++ " "
    ++ ListStylePosition.toString(position)
    ++ " "
    ++ (
      switch (image) {
      | #ListStyleImage.t as lsi => ListStyleImage.toString(lsi)
      | #Url.t as u => Url.toString(u)
      }
    ),
  );

let listStyleImage = x =>
  Declaration(
    "list-style-image",
    switch (x) {
    | #ListStyleImage.t as lsi => ListStyleImage.toString(lsi)
    | #Url.t as u => Url.toString(u)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let listStyleType = x =>
  Declaration(
    "list-style-type",
    switch (x) {
    | #ListStyleType.t as lsp => ListStyleType.toString(lsp)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let listStylePosition = x =>
  Declaration(
    "list-style-position",
    switch (x) {
    | #ListStylePosition.t as lsp => ListStylePosition.toString(lsp)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let marginToString = x =>
  switch (x) {
  | #Length.t as l => Length.toString(l)
  | #Margin.t as m => Margin.toString(m)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let margin = x => Declaration("margin", marginToString(x));
let margin2 = (~v, ~h) =>
  Declaration("margin", marginToString(v) ++ " " ++ marginToString(h));
let margin3 = (~top, ~h, ~bottom) =>
  Declaration(
    "margin",
    marginToString(top)
    ++ " "
    ++ marginToString(h)
    ++ " "
    ++ marginToString(bottom),
  );
let margin4 = (~top, ~right, ~bottom, ~left) =>
  Declaration(
    "margin",
    marginToString(top)
    ++ " "
    ++ marginToString(right)
    ++ " "
    ++ marginToString(bottom)
    ++ " "
    ++ marginToString(left),
  );
let marginLeft = x => Declaration("margin-left", marginToString(x));
let marginRight = x => Declaration("margin-right", marginToString(x));
let marginTop = x => Declaration("margin-top", marginToString(x));
let marginBottom = x => Declaration("margin-bottom", marginToString(x));

let maxHeight = x =>
  Declaration(
    "max-height",
    switch (x) {
    | #MaxHeight.t as mh => MaxHeight.toString(mh)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let maxWidth = x =>
  Declaration(
    "max-width",
    switch (x) {
    | #MaxWidth.t as mw => MaxWidth.toString(mw)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let minHeight = x =>
  Declaration(
    "min-height",
    switch (x) {
    | #Height.t as h => Height.toString(h)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let minWidth = x =>
  Declaration(
    "min-width",
    switch (x) {
    | #Width.t as w => Width.toString(w)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let objectFit = x =>
  Declaration(
    "object-fit",
    switch (x) {
    | #ObjectFit.t as o => ObjectFit.toString(o)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let objectPosition = x =>
  Declaration("object-position", string_of_backgroundposition(x));

let opacity = x => Declaration("opacity", Js.Float.toString(x));

let outline = (size, style, color) =>
  Declaration(
    "outline",
    Length.toString(size)
    ++ " "
    ++ OutlineStyle.toString(style)
    ++ " "
    ++ string_of_color(color),
  );
let outlineColor = x => Declaration("outline-color", string_of_color(x));
let outlineOffset = x => Declaration("outline-offset", Length.toString(x));
let outlineStyle = x =>
  Declaration("outline-style", OutlineStyle.toString(x));
let outlineWidth = x => Declaration("outline-width", Length.toString(x));

let overflow = x => Declaration("overflow", Overflow.toString(x));
let overflowX = x => Declaration("overflow-x", Overflow.toString(x));
let overflowY = x => Declaration("overflow-y", Overflow.toString(x));

let overflowWrap = x =>
  Declaration(
    "overflow-wrap",
    switch (x) {
    | #OverflowWrap.t as ow => OverflowWrap.toString(ow)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let padding = x => Declaration("padding", Length.toString(x));
let padding2 = (~v, ~h) =>
  Declaration("padding", Length.toString(v) ++ " " ++ Length.toString(h));
let padding3 = (~top, ~h, ~bottom) =>
  Declaration(
    "padding",
    Length.toString(top)
    ++ " "
    ++ Length.toString(h)
    ++ " "
    ++ Length.toString(bottom),
  );
let padding4 = (~top, ~right, ~bottom, ~left) =>
  Declaration(
    "padding",
    Length.toString(top)
    ++ " "
    ++ Length.toString(right)
    ++ " "
    ++ Length.toString(bottom)
    ++ " "
    ++ Length.toString(left),
  );

let paddingBottom = x => Declaration("padding-bottom", Length.toString(x));

let paddingLeft = x => Declaration("padding-left", Length.toString(x));

let paddingRight = x => Declaration("padding-right", Length.toString(x));

let paddingTop = x => Declaration("padding-top", Length.toString(x));

let perspective = x =>
  Declaration(
    "perspective",
    switch (x) {
    | #Perspective.t as p => Perspective.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let perspectiveOrigin = (x, y) =>
  Declaration(
    "perspective-origin",
    (
      switch (x) {
      | #Perspective.t as p => Perspective.toString(p)
      | #Length.t as l => Length.toString(l)
      }
    )
    ++ " "
    ++ (
      switch (y) {
      | #Perspective.t as p => Perspective.toString(p)
      | #Length.t as l => Length.toString(l)
      }
    ),
  );

let pointerEvents = x =>
  Declaration(
    "pointer-events",
    switch (x) {
    | #PointerEvents.t as p => PointerEvents.toString(p)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let position = x =>
  Declaration(
    "position",
    switch (x) {
    | #Position.t as p => Position.toString(p)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let justifySelf = x =>
  Declaration(
    "justify-self",
    switch (x) {
    | #JustifySelf.t as j => JustifySelf.toString(j)
    | #PositionalAlignment.t as pa => PositionalAlignment.toString(pa)
    | #BaselineAlignment.t as ba => BaselineAlignment.toString(ba)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let resize = x =>
  Declaration(
    "resize",
    switch (x) {
    | #Resize.t as r => Resize.toString(r)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let right = x => Declaration("right", string_of_position(x));

let tableLayout = x =>
  Declaration(
    "table-layout",
    switch (x) {
    | #TableLayout.t as tl => TableLayout.toString(tl)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textAlign = x =>
  Declaration(
    "text-align",
    switch (x) {
    | #TextAlign.t as ta => TextAlign.toString(ta)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textDecorationColor = x =>
  Declaration(
    "text-decoration-color",
    switch (x) {
    | #Color.t as co => Color.toString(co)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textDecorationLine = x =>
  Declaration(
    "text-decoration-line",
    switch (x) {
    | #TextDecorationLine.t as tdl => TextDecorationLine.toString(tdl)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textDecorationStyle = x =>
  Declaration(
    "text-decoration-style",
    switch (x) {
    | #TextDecorationStyle.t as tds => TextDecorationStyle.toString(tds)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textIndent = x =>
  Declaration(
    "text-indent",
    switch (x) {
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textOverflow = x =>
  Declaration(
    "text-overflow",
    switch (x) {
    | #TextOverflow.t as txo => TextOverflow.toString(txo)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textTransform = x =>
  Declaration(
    "text-transform",
    switch (x) {
    | #TextTransform.t as tt => TextTransform.toString(tt)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let top = x => Declaration("top", string_of_position(x));

let transform = x =>
  Declaration(
    "transform",
    switch (x) {
    | `none => "none"
    | #Transform.t as t => Transform.toString(t)
    },
  );

let transforms = x =>
  Declaration("transform", x |> concatArr(Transform.toString, " "));

let transformOrigin = (x, y) =>
  Declaration(
    "transform-origin",
    Length.toString(x) ++ " " ++ Length.toString(y),
  );

let transformOrigin3d = (x, y, z) =>
  Declaration(
    "transform-origin",
    Length.toString(x)
    ++ " "
    ++ Length.toString(y)
    ++ " "
    ++ Length.toString(z)
    ++ " ",
  );

let unsafe = (property, value) => Declaration(property, value);

let userSelect = x =>
  Declaration(
    "user-select",
    switch (x) {
    | #UserSelect.t as us => UserSelect.toString(us)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let verticalAlign = x =>
  Declaration(
    "vertical-align",
    switch (x) {
    | #VerticalAlign.t as v => VerticalAlign.toString(v)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let visibility = x =>
  Declaration(
    "visibility",
    switch (x) {
    | #Visibility.t as v => Visibility.toString(v)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let width = x =>
  Declaration(
    "width",
    switch (x) {
    | #Width.t as w => Width.toString(w)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let whiteSpace = x =>
  Declaration(
    "white-space",
    switch (x) {
    | #WhiteSpace.t as w => WhiteSpace.toString(w)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let wordBreak = x =>
  Declaration(
    "word-break",
    switch (x) {
    | #WordBreak.t as w => WordBreak.toString(w)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let wordSpacing = x =>
  Declaration(
    "word-spacing",
    switch (x) {
    | #WordSpacing.t as w => WordSpacing.toString(w)
    | #Percentage.t as p => Percentage.toString(p)
    | #Length.t as l => Length.toString(l)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let wordWrap = overflowWrap;

let zIndex = x => Declaration("z-index", Int.to_string(x));

/* Selectors */

let media = (query, rules) => Selector("@media " ++ query, rules);
let selector = (selector, rules) => Selector(selector, rules);
let pseudoclass = (selector, rules) => Pseudoclass(selector, rules);

let active = pseudoclass("active");
let checked = pseudoclass("checked");
let default = pseudoclass("default");
let defined = pseudoclass("defined");
let disabled = pseudoclass("disabled");
let empty = pseudoclass("empty");
let enabled = pseudoclass("enabled");
let first = pseudoclass("first");
let firstChild = pseudoclass("first-child");
let firstOfType = pseudoclass("first-of-type");
let focus = pseudoclass("focus");
let focusVisible = pseudoclass("focus-visible");
let focusWithin = pseudoclass("focus-within");
let host = (~selector=?, rules) =>
  switch (selector) {
  | None => Pseudoclass("host", rules)
  | Some(s) => PseudoclassParam("host", s, rules)
  };
let hover = pseudoclass("hover");
let indeterminate = pseudoclass("indeterminate");
let inRange = pseudoclass("in-range");
let invalid = pseudoclass("invalid");
let lang = (code, rules) => PseudoclassParam("lang", code, rules);
let lastChild = pseudoclass("last-child");
let lastOfType = pseudoclass("last-of-type");
//let left = selector(":left");
let link = pseudoclass("link");
let not_ = (selector, rules) => PseudoclassParam("not", selector, rules);

module Nth = {
  type t = [ | `odd | `even | `n(int) | `adDeclaration(int, int)];
  let toString =
    fun
    | `odd => "odd"
    | `even => "even"
    | `n(x) => Int.to_string(x) ++ "n"
    | `adDeclaration(x, y) => Int.to_string(x) ++ "n+" ++ Int.to_string(y);
};
let nthChild = (x, rules) =>
  PseudoclassParam("nth-child", Nth.toString(x), rules);
let nthLastChild = (x, rules) =>
  PseudoclassParam("nth-last-child", Nth.toString(x), rules);
let nthLastOfType = (x, rules) =>
  PseudoclassParam("nth-last-of-type", Nth.toString(x), rules);
let nthOfType = (x, rules) =>
  PseudoclassParam("nth-of-type", Nth.toString(x), rules);
let onlyChild = pseudoclass("only-child");
let onlyOfType = pseudoclass("only-of-type");
let optional = pseudoclass("optional");
let outOfRange = pseudoclass("out-of-range");
let readOnly = pseudoclass("read-only");
let readWrite = pseudoclass("read-write");
let required = pseudoclass("required");
//let right = selector(":right");
let root = pseudoclass("root");
let scope = pseudoclass("scope");
let target = pseudoclass("target");
let valid = pseudoclass("valid");
let visited = pseudoclass("visited");

let after = selector("::after");
let before = selector("::before");
let firstLetter = selector("::first-letter");
let firstLine = selector("::first-line");
let selection = selector("::selection");

let child = x => selector(" > " ++ x);
let children = selector(" > *");
let directSibling = selector(" + ");
let placeholder = selector("::placeholder");
let siblings = selector(" ~ ");

let anyLink = selector(":any-link");

/* Type aliasing */

type angle = Angle.t;
type animationDirection = AnimationDirection.t;
type animationFillMode = AnimationFillMode.t;
type animationIterationCount = AnimationIterationCount.t;
type animationPlayState = AnimationPlayState.t;
type cascading = Cascading.t;
type color = Color.t;
type fontStyle = FontStyle.t;
type fontWeight = FontWeight.t;
type length = Length.t;
type listStyleType = ListStyleType.t;
type repeatValue = RepeatValue.t;
type outlineStyle = OutlineStyle.t;
type transform = Transform.t;
type gradient('colorOrVar) = Gradient.t('colorOrVar);

/* Constructor aliases */

let initial = Cascading.initial;
let inherit_ = Cascading.inherit_;
let unset = Cascading.unset;

let var = Var.var;
let varDefault = Var.varDefault;

// shared
let auto = `auto;
let none = `none;
let text = `text;

let pct = Percentage.pct;

let ch = Length.ch;
let cm = Length.cm;
let em = Length.em;
let ex = Length.ex;
let mm = Length.mm;
let pt = Length.pt;
let px = Length.px;
let pxFloat = Length.pxFloat;
let rem = Length.rem;
let vh = Length.vh;
let vmin = Length.vmin;
let vmax = Length.vmax;
let zero = Length.zero;

let deg = Angle.deg;
let rad = Angle.rad;
let grad = Angle.grad;
let turn = Angle.turn;

let ltr = Direction.ltr;
let rtl = Direction.rtl;

let absolute = Position.absolute;
let relative = Position.relative;
let static = Position.static;
let fixed = `fixed;
let sticky = Position.sticky;

//let none = Resize.none;
//let both = Resize.both;
let horizontal = Resize.horizontal;
let vertical = Resize.vertical;
//let block = Resize.block;
//let inline = Resize.inline;

let smallCaps = FontVariant.smallCaps;

//let normal = `normal;
let italic = FontStyle.italic;
let oblique = FontStyle.oblique;

let hidden = `hidden;
let visible = `visible;
let scroll = `scroll;

let rgb = Color.rgb;
let rgba = Color.rgba;
let hsl = Color.hsl;
let hsla = Color.hsla;
let hex = Color.hex;
let currentColor = Color.currentColor;
let transparent = Color.transparent;

let linear = TimingFunction.linear;
let ease = TimingFunction.ease;
let easeIn = TimingFunction.easeIn;
let easeInOut = TimingFunction.easeInOut;
let easeOut = TimingFunction.easeOut;
let stepStart = TimingFunction.stepStart;
let stepEnd = TimingFunction.stepEnd;
let steps = TimingFunction.steps;
let cubicBezier = TimingFunction.cubicBezier;

let marginBox = GeometyBox.marginBox;
//let borderBox = GeometyBox.borderBox;
//let paddingBox = GeometyBox.paddingBox;
//let contentBox = GeometyBox.contentBox;
let fillBox = GeometyBox.fillBox;
let strokeBox = GeometyBox.strokeBox;
let viewBox = GeometyBox.viewBox;

let translate = Transform.translate;
let translate3d = Transform.translate3d;
let translateX = Transform.translateX;
let translateY = Transform.translateY;
let translateZ = Transform.translateZ;
let scaleX = Transform.scaleX;
let scaleY = Transform.scaleY;
let scaleZ = Transform.scaleZ;
let rotateX = Transform.rotateX;
let rotateY = Transform.rotateY;
let rotateZ = Transform.rotateZ;
let scale = Transform.scale;
let scale3d = Transform.scale3d;
let skew = Transform.skew;
let skewX = Transform.skewX;
let skewY = Transform.skewY;

let thin = FontWeight.thin;
let extraLight = FontWeight.extraLight;
let light = FontWeight.light;
let medium = FontWeight.medium;
let semiBold = FontWeight.semiBold;
let bold = FontWeight.bold;
let extraBold = FontWeight.extraBold;
let lighter = FontWeight.lighter;
let bolder = FontWeight.bolder;

let linearGradient = Gradient.linearGradient;
let repeatingLinearGradient = Gradient.repeatingLinearGradient;
let radialGradient = Gradient.radialGradient;
let repeatingRadialGradient = Gradient.repeatingRadialGradient;

let areas = GridTemplateAreas.areas;
let ident = GridArea.ident;
let numIdent = GridArea.numIdent;

// cursor aliases
//let auto = Cursor.auto;
//let default = Cursor.default;
//let none = Cursor.none;
let contextMenu = Cursor.contextMenu;
let help = Cursor.help;
let pointer = Cursor.pointer;
let progress = Cursor.progress;
let wait = Cursor.wait;
let cell = Cursor.cell;
let crosshair = Cursor.crosshair;
//let text = Cursor.text;
let verticalText = Cursor.verticalText;
let alias = Cursor.alias;
let copy = Cursor.copy;
let move = Cursor.move;
let noDrop = Cursor.noDrop;
let notAllowed = Cursor.notAllowed;
let grab = Cursor.grab;
let grabbing = Cursor.grabbing;
let allScroll = Cursor.allScroll;
let colResize = Cursor.colResize;
let rowResize = Cursor.rowResize;
let nResize = Cursor.nResize;
let eResize = Cursor.eResize;
let sResize = Cursor.sResize;
let wResize = Cursor.wResize;
let neResize = Cursor.neResize;
let nwResize = Cursor.nwResize;
let seResize = Cursor.seResize;
let swResize = Cursor.swResize;
let ewResize = Cursor.ewResize;
let nsResize = Cursor.nsResize;
let neswResize = Cursor.neswResize;
let nwseResize = Cursor.nwseResize;
let zoomIn = Cursor.zoomIn;
let zoomOut = Cursor.zoomOut;

let vw = x => `vw(x);
let fr = x => `fr(x);

module Calc = {
  /* https://www.w3.org/TR/css3-values/#calc-notation */
  let (-) = (a, b) => `calc((`sub, a, b));
  let (+) = (a, b) => `calc((`add, a, b));
  /* let ( * ) = (a, b) => `multiply((a, b));
     let (/) = (a, b) => `divide((a, b)); */
};
let size = (x, y) => `size((x, y));

let all = `all;
let backwards = `backwards;
let baseline = `baseline;
let block = `block;
let borderBox = `borderBox;
let both = `both;
let center = `center;
let column = `column;
let columnReverse = `columnReverse;
let contain = `contain;
let contentBox = `contentBox;
let count = x => `count(x);
let cover = `cover;
let dashed = `dashed;
let dotted = `dotted;
let flexBox = `flex;
let grid = `grid;
let inlineGrid = `inlineGrid;
let flexEnd = `flexEnd;
let flexStart = `flexStart;
let forwards = `forwards;
let infinite = `infinite;

let inline = `inline;
let contents = `contents;
let inlineBlock = `inlineBlock;
let inlineFlex = `inlineFlex;
let inlineTable = `inlineTable;
let listItem = `listItem;
let runIn = `runIn;
let table = `table;
let tableCaption = `tableCaption;
let tableColumnGroup = `tableColumnGroup;
let tableHeaderGroup = `tableHeaderGroup;
let tableFooterGroup = `tableFooterGroup;
let tableRowGroup = `tableRowGroup;
let tableCell = `tableCell;
let tableColumn = `tableColumn;
let tableRow = `tableRow;

let local = `local;
let localURL = x => `localURL(x);
let noRepeat = `noRepeat;
let space = `space;
let nowrap = `nowrap;
let paddingBox = `paddingBox;
let paused = `paused;
let repeat = `repeat;
let minmax = `minmax;
let repeatX = `repeatX;
let repeatY = `repeatY;
let rotate = a => `rotate(a);
let rotate3d = (x, y, z, a) => `rotate3Declaration((x, y, z, a));
let row = `row;
let rowReverse = `rowReverse;
let running = `running;
let solid = `solid;
let spaceAround = `spaceAround;
let spaceBetween = `spaceBetween;
let spaceEvenly = `spaceEvenly;
let stretch = `stretch;
let url = x => `Url(x);
let wrap = `wrap;
let wrapReverse = `wrapReverse;

let inside = `inside;
let outside = `outside;

let underline = `underline;
let overline = `overline;
let lineThrough = `lineThrough;
let clip = `clip;
let ellipsis = `ellipsis;

let wavy = `wavy;
let double = `double;

let uppercase = `uppercase;
let lowercase = `lowercase;
let capitalize = `capitalize;

let sub = `sub;
let super = `super;
let textTop = `textTop;
let textBottom = `textBottom;
let middle = `middle;

let normal = `normal;

let breakAll = `breakAll;
let keepAll = `keepAll;
let breakWord = `breakWord;

let reverse = `reverse;
let alternate = `alternate;
let alternateReverse = `alternateReverse;

let fill = `fill;
let content = `content;
let maxContent = `maxContent;
let minContent = `minContent;
let fitContent = `fitContent;

let round = `round;
let miter = `miter;
let bevel = `bevel;
let butt = `butt;
let square = `square;

let flex3 = (~grow, ~shrink, ~basis) =>
  Declaration(
    "flex",
    Js.Float.toString(grow)
    ++ " "
    ++ Js.Float.toString(shrink)
    ++ " "
    ++ (
      switch (basis) {
      | #FlexBasis.t as b => FlexBasis.toString(b)
      | #Length.t as l => Length.toString(l)
      }
    ),
  );
let flexBasis = x =>
  Declaration(
    "flex-basis",
    switch (x) {
    | #FlexBasis.t as b => FlexBasis.toString(b)
    | #Length.t as l => Length.toString(l)
    },
  );

let order = x => Declaration("order", Int.to_string(x));

let string_of_minmax =
  fun
  | `auto => "auto"
  | `calc(`add, a, b) =>
    "calc(" ++ Length.toString(a) ++ " + " ++ Length.toString(b) ++ ")"
  | `calc(`sub, a, b) =>
    "calc(" ++ Length.toString(a) ++ " - " ++ Length.toString(b) ++ ")"
  | `ch(x) => Js.Float.toString(x) ++ "ch"
  | `cm(x) => Js.Float.toString(x) ++ "cm"
  | `em(x) => Js.Float.toString(x) ++ "em"
  | `ex(x) => Js.Float.toString(x) ++ "ex"
  | `mm(x) => Js.Float.toString(x) ++ "mm"
  | `percent(x) => Js.Float.toString(x) ++ "%"
  | `pt(x) => Int.to_string(x) ++ "pt"
  | `px(x) => Int.to_string(x) ++ "px"
  | `pxFloat(x) => Js.Float.toString(x) ++ "px"
  | `rem(x) => Js.Float.toString(x) ++ "rem"
  | `vh(x) => Js.Float.toString(x) ++ "vh"
  | `vmax(x) => Js.Float.toString(x) ++ "vmax"
  | `vmin(x) => Js.Float.toString(x) ++ "vmin"
  | `vw(x) => Js.Float.toString(x) ++ "vw"
  | `fr(x) => Js.Float.toString(x) ++ "fr"
  | `inch(x) => Js.Float.toString(x) ++ "in"
  | `pc(x) => Js.Float.toString(x) ++ "pc"
  | `zero => "0"
  | `minContent => "min-content"
  | `maxContent => "max-content";

let string_of_dimension =
  fun
  | `auto => "auto"
  | `none => "none"
  | `calc(`add, a, b) =>
    "calc(" ++ Length.toString(a) ++ " + " ++ Length.toString(b) ++ ")"
  | `calc(`sub, a, b) =>
    "calc(" ++ Length.toString(a) ++ " - " ++ Length.toString(b) ++ ")"
  | `ch(x) => Js.Float.toString(x) ++ "ch"
  | `cm(x) => Js.Float.toString(x) ++ "cm"
  | `em(x) => Js.Float.toString(x) ++ "em"
  | `ex(x) => Js.Float.toString(x) ++ "ex"
  | `mm(x) => Js.Float.toString(x) ++ "mm"
  | `percent(x) => Js.Float.toString(x) ++ "%"
  | `pt(x) => Int.to_string(x) ++ "pt"
  | `px(x) => Int.to_string(x) ++ "px"
  | `pxFloat(x) => Js.Float.toString(x) ++ "px"
  | `rem(x) => Js.Float.toString(x) ++ "rem"
  | `vh(x) => Js.Float.toString(x) ++ "vh"
  | `vmax(x) => Js.Float.toString(x) ++ "vmax"
  | `vmin(x) => Js.Float.toString(x) ++ "vmin"
  | `vw(x) => Js.Float.toString(x) ++ "vw"
  | `fr(x) => Js.Float.toString(x) ++ "fr"
  | `inch(x) => Js.Float.toString(x) ++ "in"
  | `pc(x) => Js.Float.toString(x) ++ "pc"
  | `zero => "0"
  | `fitContent => "fit-content"
  | `minContent => "min-content"
  | `maxContent => "max-content"
  | `minmax(a, b) =>
    "minmax(" ++ string_of_minmax(a) ++ "," ++ string_of_minmax(b) ++ ")";

type minmax = [ | `fr(float) | `minContent | `maxContent | `auto | Length.t];

type trackLength = [
  Length.t
  | `auto
  | `fr(float)
  | `minContent
  | `maxContent
  | `minmax(minmax, minmax)
];
type gridLength = [ trackLength | `repeat(RepeatValue.t, trackLength)];

let gridLengthToJs =
  fun
  | `auto => "auto"
  | `calc(`add, a, b) =>
    "calc(" ++ Length.toString(a) ++ " + " ++ Length.toString(b) ++ ")"
  | `calc(`sub, a, b) =>
    "calc(" ++ Length.toString(a) ++ " - " ++ Length.toString(b) ++ ")"
  | `ch(x) => Js.Float.toString(x) ++ "ch"
  | `cm(x) => Js.Float.toString(x) ++ "cm"
  | `em(x) => Js.Float.toString(x) ++ "em"
  | `ex(x) => Js.Float.toString(x) ++ "ex"
  | `mm(x) => Js.Float.toString(x) ++ "mm"
  | `percent(x) => Js.Float.toString(x) ++ "%"
  | `pt(x) => Int.to_string(x) ++ "pt"
  | `px(x) => Int.to_string(x) ++ "px"
  | `pxFloat(x) => Js.Float.toString(x) ++ "px"
  | `rem(x) => Js.Float.toString(x) ++ "rem"
  | `vh(x) => Js.Float.toString(x) ++ "vh"
  | `inch(x) => Js.Float.toString(x) ++ "in"
  | `pc(x) => Js.Float.toString(x) ++ "pc"
  | `vmax(x) => Js.Float.toString(x) ++ "vmax"
  | `vmin(x) => Js.Float.toString(x) ++ "vmin"
  | `vw(x) => Js.Float.toString(x) ++ "vw"
  | `fr(x) => Js.Float.toString(x) ++ "fr"
  | `zero => "0"
  | `minContent => "min-content"
  | `maxContent => "max-content"
  | `repeat(n, x) =>
    "repeat("
    ++ RepeatValue.toString(n)
    ++ ", "
    ++ string_of_dimension(x)
    ++ ")"
  | `minmax(a, b) =>
    "minmax(" ++ string_of_minmax(a) ++ "," ++ string_of_minmax(b) ++ ")";

let string_of_dimensions = dimensions =>
  dimensions |> concatArr(gridLengthToJs, " ");

let gridTemplateColumns = dimensions =>
  Declaration("grid-template-columns", string_of_dimensions(dimensions));

let gridTemplateRows = dimensions =>
  Declaration("grid-template-rows", string_of_dimensions(dimensions));

let gridAutoColumns = dimensions =>
  Declaration("grid-auto-columns", string_of_dimension(dimensions));

let gridAutoRows = dimensions =>
  Declaration("grid-auto-rows", string_of_dimension(dimensions));

let gridArea = s =>
  Declaration(
    "grid-area",
    switch (s) {
    | #GridArea.t as t => GridArea.toString(t)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let gridArea2 = (s, s2) =>
  Declaration(
    "grid-area",
    GridArea.toString(s) ++ " / " ++ GridArea.toString(s2),
  );

let gridArea3 = (s, s2, s3) =>
  Declaration(
    "grid-area",
    GridArea.toString(s)
    ++ " / "
    ++ GridArea.toString(s2)
    ++ " / "
    ++ GridArea.toString(s3),
  );

let gridArea4 = (s, s2, s3, s4) =>
  Declaration(
    "grid-area",
    GridArea.toString(s)
    ++ " / "
    ++ GridArea.toString(s2)
    ++ " / "
    ++ GridArea.toString(s3)
    ++ " / "
    ++ GridArea.toString(s4),
  );

let gridTemplateAreas = l =>
  Declaration(
    "grid-template-areas",
    switch (l) {
    | #GridTemplateAreas.t as t => GridTemplateAreas.toString(t)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

type filter = [
  | `blur(Length.t)
  | `brightness(float)
  | `contrast(float)
  | `dropShadow(Length.t, Length.t, Length.t, Color.t)
  | `grayscale(float)
  | `hueRotate(angle)
  | `invert(float)
  | `opacity(float)
  | `saturate(float)
  | `sepia(float)
  | `URL(string)
  | `none
  | Var.t
  | Cascading.t
];

let string_of_filter =
  fun
  | `blur(v) => "blur(" ++ Length.toString(v) ++ ")"
  | `brightness(v) => "brightness(" ++ Js.Float.toString(v) ++ "%)"
  | `contrast(v) => "contrast(" ++ Js.Float.toString(v) ++ "%)"
  | `dropShadow(a, b, c, d) =>
    "drop-shadow("
    ++ Length.toString(a)
    ++ " "
    ++ Length.toString(b)
    ++ " "
    ++ Length.toString(c)
    ++ " "
    ++ Color.toString(d)
    ++ ")"
  | `grayscale(v) => "grayscale(" ++ Js.Float.toString(v) ++ "%)"
  | `hueRotate(v) => "hue-rotate(" ++ Angle.toString(v) ++ ")"
  | `invert(v) => "invert(" ++ Js.Float.toString(v) ++ "%)"
  | `opacity(v) => "opacity(" ++ Js.Float.toString(v) ++ "%)"
  | `saturate(v) => "saturate(" ++ Js.Float.toString(v) ++ "%)"
  | `sepia(v) => "sepia(" ++ Js.Float.toString(v) ++ "%)"
  | `none => "none"
  | #Url.t as u => Url.toString(u)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c);

let filter = x =>
  Declaration("filter", x |> concatArr(string_of_filter, " "));

module Shadow = {
  type value('a) = string;
  type box;
  type text;
  type t('a) = [ | `shadow(value('a)) | `none];

  let box = (~x=zero, ~y=zero, ~blur=zero, ~spread=zero, ~inset=false, color) =>
    `shadow(
      Length.toString(x)
      ++ " "
      ++ Length.toString(y)
      ++ " "
      ++ Length.toString(blur)
      ++ " "
      ++ Length.toString(spread)
      ++ " "
      ++ string_of_color(color)
      ++ (inset ? " inset" : ""),
    );

  let text = (~x=zero, ~y=zero, ~blur=zero, color) =>
    `shadow(
      Length.toString(x)
      ++ " "
      ++ Length.toString(y)
      ++ " "
      ++ Length.toString(blur)
      ++ " "
      ++ string_of_color(color),
    );

  let toString: t('a) => string =
    fun
    | `shadow(x) => x
    | `none => "none";
};

let boxShadow = x =>
  Declaration(
    "box-shadow",
    switch (x) {
    | #Shadow.t as s => Shadow.toString(s)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let boxShadows = x =>
  Declaration("box-shadow", x |> concatArr(Shadow.toString, ", "));

let string_of_borderstyle =
  fun
  | #BorderStyle.t as b => BorderStyle.toString(b)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c);

let border = (px, style, color) =>
  Declaration(
    "border",
    Length.toString(px)
    ++ " "
    ++ string_of_borderstyle(style)
    ++ " "
    ++ string_of_color(color),
  );
let borderStyle = x => Declaration("border-style", string_of_borderstyle(x));

let borderLeft = (px, style, color) =>
  Declaration(
    "border-left",
    Length.toString(px)
    ++ " "
    ++ string_of_borderstyle(style)
    ++ " "
    ++ string_of_color(color),
  );
let borderLeftStyle = x =>
  Declaration("border-left-style", string_of_borderstyle(x));

let borderRight = (px, style, color) =>
  Declaration(
    "border-right",
    Length.toString(px)
    ++ " "
    ++ string_of_borderstyle(style)
    ++ " "
    ++ string_of_color(color),
  );

let borderRightStyle = x =>
  Declaration("border-right-style", string_of_borderstyle(x));
let borderTop = (px, style, color) =>
  Declaration(
    "border-top",
    Length.toString(px)
    ++ " "
    ++ string_of_borderstyle(style)
    ++ " "
    ++ string_of_color(color),
  );

let borderTopStyle = x =>
  Declaration("border-top-style", string_of_borderstyle(x));

let borderBottom = (px, style, color) =>
  Declaration(
    "border-bottom",
    Length.toString(px)
    ++ " "
    ++ string_of_borderstyle(style)
    ++ " "
    ++ string_of_color(color),
  );

let borderBottomStyle = x =>
  Declaration("border-bottom-style", string_of_borderstyle(x));

let background = x =>
  Declaration(
    "background",
    switch (x) {
    | #Color.t as c => Color.toString(c)
    | #Url.t as u => Url.toString(u)
    | #Gradient.t as g => Gradient.toString(g)
    | `none => "none"
    },
  );

let backgrounds = x =>
  Declaration(
    "background",
    x
    |> concatArr(
         item =>
           switch (item) {
           | #Color.t as c => Color.toString(c)
           | #Url.t as u => Url.toString(u)
           | #Gradient.t as g => Gradient.toString(g)
           | `none => "none"
           },
         ", ",
       ),
  );

let backgroundSize = x =>
  Declaration(
    "background-size",
    switch (x) {
    | `size(x, y) => Length.toString(x) ++ " " ++ Length.toString(y)
    | `auto => "auto"
    | `cover => "cover"
    | `contain => "contain"
    },
  );

let fontFace =
    (
      ~fontFamily as _,
      ~src,
      ~fontStyle as _=?,
      ~fontWeight=?,
      ~fontDisplay=?,
      (),
    ) => {
  let _fontStyle = "font-style: " ++ "normal" ++ ";";
  /* let fontStyle =
     fontStyle
     |> Option.map(FontStyle.toString)
     |> Option.get("", s => "font-style: " ++ s ++ ";"); */

  let _src =
    src
    |> concatArr(
         fun
         | `localURL(value) => "local(" ++ value ++ ")"
         | `URL(value) => "URL(" ++ value ++ ")",
         ", ",
       );

  let _fontWeight =
    Option.get(fontWeight, "", w =>
      "font-weight: "
      ++ (
        switch (w) {
        | #FontWeight.t as f => FontWeight.toString(f)
        | #Var.t as va => Var.toString(va)
        | #Cascading.t as c => Cascading.toString(c)
        }
      )
      ++ ";"
    );
  let _fontDisplay =
    Option.get(fontDisplay, "", f =>
      "font-display: " ++ FontDisplay.toString(f) ++ ";"
    );

  {j|@font-face {
    font-family: $fontFamily;
    src: $src;
    $(fontStyle)
    $(fontWeight)
    $(fontDisplay)
  }|j};
};

let textDecoration = x =>
  Declaration(
    "text-decoration",
    switch (x) {
    | `none => "none"
    | `underline => "underline"
    | `overline => "overline"
    | `lineThrough => "line-through"
    | `initial => "initial"
    | `inherit_ => "inherit"
    | `unset => "unset"
    | #Var.t as va => Var.toString(va)
    },
  );

let textShadow = x =>
  Declaration(
    "text-shadow",
    switch (x) {
    | #Shadow.t as s => Shadow.toString(s)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

let textShadows = x =>
  Declaration("text-shadow", x |> concatArr(Shadow.toString, ", "));

let transformStyle = x =>
  Declaration(
    "transform-style",
    switch (x) {
    | #TransformStyle.t as ts => TransformStyle.toString(ts)
    | #Var.t as va => Var.toString(va)
    | #Cascading.t as c => Cascading.toString(c)
    },
  );

/**
* Transition
*/
module Transition = {
  type t = [ | `value(string)];

  let shorthand = (~duration=0, ~delay=0, ~timingFunction=`ease, property) =>
    `value(
      string_of_time(duration)
      ++ " "
      ++ TimingFunction.toString(timingFunction)
      ++ " "
      ++ string_of_time(delay)
      ++ " "
      ++ property,
    );

  let toString =
    fun
    | `value(v) => v;
};

let transitionValue = x => Declaration("transition", Transition.toString(x));

let transitions = x =>
  Declaration("transition", x |> concatArr(Transition.toString, ", "));

let transition = (~duration=?, ~delay=?, ~timingFunction=?, property) =>
  transitionValue(
    Transition.shorthand(~duration?, ~delay?, ~timingFunction?, property),
  );

let transitionDelay = i =>
  Declaration("transition-delay", string_of_time(i));

let transitionDuration = i =>
  Declaration("transition-duration", string_of_time(i));

let transitionTimingFunction = x =>
  Declaration("transition-timing-function", TimingFunction.toString(x));

let transitionProperty = x => Declaration("transition-property", x);

/**
* Animation
*/
module Animation = {
  type t = [ | `value(string)];

  let shorthand =
      (
        ~duration=0,
        ~delay=0,
        ~direction=`normal,
        ~timingFunction=`ease,
        ~fillMode=`none,
        ~playState=`running,
        ~iterationCount=`count(1),
        name,
      ) =>
    `value(
      name
      ++ " "
      ++ string_of_time(duration)
      ++ " "
      ++ TimingFunction.toString(timingFunction)
      ++ " "
      ++ string_of_time(delay)
      ++ " "
      ++ AnimationIterationCount.toString(iterationCount)
      ++ " "
      ++ AnimationDirection.toString(direction)
      ++ " "
      ++ AnimationFillMode.toString(fillMode)
      ++ " "
      ++ AnimationPlayState.toString(playState),
    );

  let toString =
    fun
    | `value(v) => v;
};

let animationValue = x => Declaration("animation", Animation.toString(x));

let animation =
    (
      ~duration=?,
      ~delay=?,
      ~direction=?,
      ~timingFunction=?,
      ~fillMode=?,
      ~playState=?,
      ~iterationCount=?,
      name,
    ) =>
  animationValue(
    Animation.shorthand(
      ~duration?,
      ~delay?,
      ~direction?,
      ~timingFunction?,
      ~fillMode?,
      ~playState?,
      ~iterationCount?,
      name,
    ),
  );

let animations = x =>
  Declaration("animation", x |> concatArr(Animation.toString, ", "));

let animationName = x => Declaration("animation-name", x);

/**
* SVG
*/
module SVG = {
  let fill = x =>
    Declaration(
      "fill",
      switch (x) {
      | #SVG.Fill.t as f => SVG.Fill.toString(f)
      | #Color.t as c => Color.toString(c)
      | #Var.t as v => Var.toString(v)
      | #Url.t as u => Url.toString(u)
      },
    );
  let fillOpacity = opacity =>
    Declaration("fill-opacity", Js.Float.toString(opacity));
  let fillRule = x =>
    Declaration(
      "fill-rule",
      switch (x) {
      | `evenodd => "evenodd"
      | `nonzero => "nonzero"
      },
    );
  let stroke = x => Declaration("stroke", string_of_color(x));
  let strokeDasharray = x =>
    Declaration(
      "stroke-dasharray",
      switch (x) {
      | `none => "none"
      | `dasharray(a) => a |> concatArr(string_of_dasharray, " ")
      },
    );
  let strokeWidth = x => Declaration("stroke-width", Length.toString(x));
  let strokeOpacity = opacity =>
    Declaration("stroke-opacity", Js.Float.toString(opacity));
  let strokeMiterlimit = x =>
    Declaration("stroke-miterlimit", Js.Float.toString(x));
  let strokeLinecap = x =>
    Declaration(
      "stroke-linecap",
      switch (x) {
      | `butt => "butt"
      | `round => "round"
      | `square => "square"
      },
    );

  let strokeLinejoin = x =>
    Declaration(
      "stroke-linejoin",
      switch (x) {
      | `miter => "miter"
      | `round => "round"
      | `bevel => "bevel"
      },
    );
  let stopColor = x => Declaration("stop-color", string_of_color(x));
  let stopOpacity = x => Declaration("stop-opacity", Js.Float.toString(x));
};

let important = v =>
  switch (v) {
  | Declaration(name, value) => Declaration(name, value ++ " !important")
  | Selector(_, _)
  | Pseudoclass(_, _)
  | PseudoclassParam(_, _, _) => v
  };

let label = label => Declaration("label", label);
