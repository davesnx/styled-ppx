module Location = Ppxlib.Location;
module Builder = Ppxlib.Ast_builder.Default;

/**
 * Maps CSS property names to their corresponding Css_types module toString functions.
 * This is used by cx2 to generate correct toString calls for interpolated values.
 *
 * Example: "color" -> Some("Color")
 * Then generates: CSS.Types.Color.toString(value)
 */

/* Helper to build the toString expression */
let make_to_string_call = (~loc, module_name, value_expr) => {
  let to_string_ident =
    Builder.pexp_ident(
      ~loc,
      {
        txt:
          Ldot(
            Ldot(Ldot(Lident("CSS"), "Types"), module_name),
            "toString",
          ),
        loc,
      },
    );
  Builder.pexp_apply(~loc, to_string_ident, [(Nolabel, value_expr)]);
};

/**
 * Maps CSS property names (kebab-case) to Css_types module names (PascalCase).
 *
 * Note: Many properties share the same underlying type module.
 * For example, margin-top, margin-bottom, margin-left, margin-right all use Margin.
 */
let property_to_module = property_name => {
  switch (property_name) {
  /* Margin family */
  | "margin"
  | "margin-top"
  | "margin-bottom"
  | "margin-left"
  | "margin-right"
  | "margin-block-end"
  | "margin-block-start"
  | "margin-inline-end"
  | "margin-inline-start" => Some("Margin")

  /* Padding family - uses same type as Margin (Length | Percentage | Auto) */
  | "padding"
  | "padding-top"
  | "padding-bottom"
  | "padding-left"
  | "padding-right"
  | "padding-block-end"
  | "padding-block-start"
  | "padding-inline-end"
  | "padding-inline-start" => Some("Margin")

  /* Gap family - row-gap, column-gap, and gap all use Gap module */
  | "gap"
  | "row-gap"
  | "column-gap"
  | "grid-gap"
  | "grid-row-gap"
  | "grid-column-gap" => Some("Gap")

  /* Width family */
  | "width"
  | "block-size"
  | "inline-size" => Some("Width")

  | "min-width"
  | "min-block-size"
  | "min-inline-size" => Some("MinWidth")

  | "max-width"
  | "max-block-size"
  | "max-inline-size" => Some("MaxWidth")

  /* Height family */
  | "height" => Some("Height")
  | "min-height" => Some("MinHeight")
  | "max-height" => Some("MaxHeight")

  /* Flex properties */
  | "flex" => Some("Flex")
  | "flex-basis" => Some("FlexBasis")
  | "flex-direction" => Some("FlexDirection")
  | "flex-wrap" => Some("FlexWrap")

  /* Color */
  | "color"
  | "background-color"
  | "border-color"
  | "border-top-color"
  | "border-bottom-color"
  | "border-left-color"
  | "border-right-color"
  | "outline-color"
  | "text-decoration-color"
  | "text-emphasis-color"
  | "column-rule-color"
  | "scrollbar-color" => Some("Color")

  /* Display */
  | "display" => Some("Display")

  /* Position */
  | "position" => Some("PropertyPosition")

  /* Box positioning */
  | "top" => Some("Top")
  | "bottom" => Some("Bottom")
  | "left" => Some("Left")
  | "right" => Some("Right")

  /* Background properties */
  | "background" => Some("Background")
  | "background-image" => Some("BackgroundImage")
  | "background-position" => Some("BackgroundPosition")
  | "background-size" => Some("BackgroundSize")
  | "background-repeat" => Some("BackgroundRepeat")
  | "background-clip" => Some("BackgroundClip")
  | "background-origin" => Some("BackgroundOrigin")
  | "background-attachment" => Some("BackgroundAttachment")

  /* Border properties */
  | "border-style"
  | "border-top-style"
  | "border-bottom-style"
  | "border-left-style"
  | "border-right-style" => Some("BorderStyle")

  | "border-width"
  | "border-top-width"
  | "border-bottom-width"
  | "border-left-width"
  | "border-right-width" => Some("LineWidth")

  | "border-collapse" => Some("BorderCollapse")

  /* Text properties */
  | "text-align" => Some("TextAlign")
  | "text-align-all" => Some("TextAlignAll")
  | "text-align-last" => Some("TextAlignLast")
  | "text-transform" => Some("TextTransform")
  | "text-overflow" => Some("TextOverflow")
  | "text-decoration" => Some("TextDecoration")
  | "text-decoration-line" => Some("TextDecorationLine")
  | "text-decoration-style" => Some("TextDecorationStyle")
  | "text-decoration-thickness" => Some("TextDecorationThickness")
  | "text-decoration-skip-ink" => Some("TextDecorationSkipInk")
  | "text-decoration-skip-box" => Some("TextDecorationSkipBox")
  | "text-decoration-skip-inset" => Some("TextDecorationSkipInset")
  | "text-emphasis-style" => Some("TextEmphasisStyle")
  | "text-emphasis-position" => Some("TextEmphasisPosition")
  | "text-justify" => Some("TextJustify")

  /* Font properties */
  | "font-weight" => Some("FontWeight")
  | "font-style" => Some("FontStyle")
  | "font-variant" => Some("FontVariant")
  | "font-variant-caps" => Some("FontVariantCaps")
  | "font-variant-position" => Some("FontVariantPosition")
  | "font-variant-emoji" => Some("FontVariantEmoji")
  | "font-synthesis-weight" => Some("FontSynthesisWeight")
  | "font-synthesis-style" => Some("FontSynthesisStyle")
  | "font-synthesis-small-caps" => Some("FontSynthesisSmallCaps")
  | "font-synthesis-position" => Some("FontSynthesisPosition")
  | "font-kerning" => Some("FontKerning")
  | "font-optical-sizing" => Some("FontOpticalSizing")
  | "font-display" => Some("FontDisplay")

  /* Line properties */
  | "line-height" => Some("LineHeight")
  | "line-break" => Some("LineBreak")

  /* Spacing */
  | "letter-spacing" => Some("LetterSpacing")
  | "word-spacing" => Some("WordSpacing")

  /* White space */
  | "white-space" => Some("WhiteSpace")
  | "word-break" => Some("WordBreak")
  | "overflow-wrap" => Some("OverflowWrap")
  | "hyphens" => Some("Hyphens")

  /* Overflow */
  | "overflow-x"
  | "overflow-y" => Some("Overflow")
  | "overflow-inline" => Some("OverflowInline")
  | "overflow-block" => Some("OverflowBlock")
  | "overflow-clip-margin" => Some("OverflowClipMargin")
  | "overflow-anchor" => Some("OverflowAnchor")
  | "overscroll-behavior" => Some("OverscrollBehavior")

  /* Alignment */
  | "align-items" => Some("AlignItems")
  | "align-self" => Some("AlignSelf")
  | "align-content" => Some("AlignContent")
  | "justify-content" => Some("JustifyContent")
  | "justify-items" => Some("JustifyItems")
  | "justify-self" => Some("JustifySelf")

  /* Grid properties */
  | "grid" => Some("Grid")
  | "grid-template" => Some("GridTemplate")
  | "grid-template-rows" => Some("GridTemplateRows")
  | "grid-template-columns" => Some("GridTemplateColumns")
  | "grid-template-areas" => Some("GridTemplateAreas")
  | "grid-auto-rows" => Some("GridAutoRows")
  | "grid-auto-columns" => Some("GridAutoColumns")
  | "grid-auto-flow" => Some("GridAutoFlow")
  | "grid-area" => Some("GridArea")
  | "grid-row" => Some("GridRow")
  | "grid-row-start" => Some("GridRowStart")
  | "grid-row-end" => Some("GridRowEnd")
  | "grid-column" => Some("GridColumn")
  | "grid-column-start" => Some("GridColumnStart")
  | "grid-column-end" => Some("GridColumnEnd")

  /* Transform properties */
  | "transform" => Some("Transform")
  | "transform-origin" => Some("TransformOrigin")
  | "transform-style" => Some("TransformStyle")
  | "transform-box" => Some("TransformBox")
  | "translate" => Some("Translate")
  | "rotate" => Some("Rotate")
  | "scale" => Some("Scale")

  /* Transition properties */
  | "transition" => Some("Transition")
  | "transition-property" => Some("TransitionProperty")
  | "transition-duration" => Some("TransitionDuration")
  | "transition-delay" => Some("TransitionDelay")
  | "transition-timing-function" => Some("TransitionTimingFunction")
  | "transition-behavior" => Some("TransitionBehavior")

  /* Animation properties */
  | "animation" => Some("Animation")
  | "animation-duration" => Some("AnimationDuration")
  | "animation-delay" => Some("AnimationDelay")
  | "animation-timing-function" => Some("AnimationTimingFunction")
  | "animation-iteration-count" => Some("AnimationIterationCount")
  | "animation-direction" => Some("AnimationDirection")
  | "animation-fill-mode" => Some("AnimationFillMode")
  | "animation-play-state" => Some("AnimationPlayState")

  /* Other layout properties */
  | "z-index" => Some("ZIndex")
  | "opacity" => Some("AlphaValue")
  | "visibility" => Some("Visibility")
  | "cursor" => Some("Cursor")
  | "pointer-events" => Some("PointerEvents")
  | "resize" => Some("Resize")
  | "box-sizing" => Some("BoxSizing")
  | "aspect-ratio" => Some("AspectRatio")
  | "object-fit" => Some("ObjectFit")
  | "object-position" => Some("ObjectPosition")
  | "vertical-align" => Some("VerticalAlign")
  | "direction" => Some("Direction")
  | "isolation" => Some("Isolation")
  | "clear" => Some("Clear")
  | "float" => Some("Float")

  /* Table */
  | "table-layout" => Some("TableLayout")

  /* List style */
  | "list-style-type" => Some("ListStyleType")
  | "list-style-position" => Some("ListStylePosition")
  | "list-style-image" => Some("ListStyleImage")

  /* Filter */
  | "filter" => Some("Filter")
  | "backdrop-filter" => Some("Filter")

  /* Perspective */
  | "perspective" => Some("Perspective")
  | "perspective-origin" => Some("PerspectiveOrigin")
  | "backface-visibility" => Some("BackfaceVisibility")

  /* Mask */
  | "mask-image" => Some("MaskImage")
  | "mask-position" => Some("MaskPosition")

  /* Offset */
  | "offset-anchor" => Some("OffsetAnchor")

  /* Clip */
  | "clip-path" => Some("ClipPath")

  /* Content */
  | "content" => Some("Content")
  | "counter-increment" => Some("CounterIncrement")
  | "counter-reset" => Some("CounterReset")
  | "counter-set" => Some("CounterSet")

  /* Scroll */
  | "scroll-behavior" => Some("ScrollBehavior")
  | "scrollbar-width" => Some("ScrollbarWidth")
  | "scrollbar-gutter" => Some("ScrollbarGutter")

  /* Touch */
  | "touch-action" => Some("TouchAction")

  /* User interaction */
  | "user-select" => Some("UserSelect")

  /* Tab size */
  | "tab-size" => Some("TabSize")

  /* Border radius */
  | "border-radius"
  | "border-top-left-radius"
  | "border-top-right-radius"
  | "border-bottom-left-radius"
  | "border-bottom-right-radius"
  | "border-start-start-radius"
  | "border-start-end-radius"
  | "border-end-start-radius"
  | "border-end-end-radius" => Some("BorderRadius")

  | "border-spacing" => Some("BorderSpacing")

  /* Flex grow/shrink */
  | "flex-grow" => Some("FlexGrow")
  | "flex-shrink" => Some("FlexShrink")

  /* Order */
  | "order" => Some("Order")

  /* Orphans/Widows */
  | "orphans" => Some("Orphans")
  | "widows" => Some("Widows")

  /* Inset properties */
  | "inset"
  | "inset-block-end"
  | "inset-block-start"
  | "inset-inline-end"
  | "inset-inline-start" => Some("Inset")

  | "inset-block" => Some("InsetBlock")
  | "inset-inline" => Some("InsetInline")

  /* Margin/Padding logical */
  | "margin-block" => Some("MarginBlock")
  | "margin-inline" => Some("MarginInline")
  | "padding-block" => Some("PaddingBlock")
  | "padding-inline" => Some("PaddingInline")

  /* Scroll margin/padding */
  | "scroll-margin"
  | "scroll-margin-top"
  | "scroll-margin-bottom"
  | "scroll-margin-left"
  | "scroll-margin-right"
  | "scroll-margin-block"
  | "scroll-margin-block-end"
  | "scroll-margin-block-start"
  | "scroll-margin-inline"
  | "scroll-margin-inline-end"
  | "scroll-margin-inline-start" => Some("ScrollMargin")

  | "scroll-padding"
  | "scroll-padding-top"
  | "scroll-padding-bottom"
  | "scroll-padding-left"
  | "scroll-padding-right"
  | "scroll-padding-block"
  | "scroll-padding-block-end"
  | "scroll-padding-block-start"
  | "scroll-padding-inline"
  | "scroll-padding-inline-end"
  | "scroll-padding-inline-start" => Some("ScrollPadding")

  /* Scroll snap */
  | "scroll-snap-align" => Some("ScrollSnapAlign")
  | "scroll-snap-stop" => Some("ScrollSnapStop")
  | "scroll-snap-type"
  | "scroll-snap-type-x"
  | "scroll-snap-type-y" => Some("ScrollSnapType")

  /* Font */
  | "font-size" => Some("FontSize")
  | "font-stretch" => Some("FontStretch")

  /* Appearance and layout */
  | "appearance" => Some("Appearance")
  | "contain" => Some("Contain")
  | "content-visibility" => Some("ContentVisibility")
  | "will-change" => Some("WillChange")
  | "writing-mode" => Some("WritingMode")
  | "unicode-bidi" => Some("UnicodeBidi")

  /* Blend modes */
  | "mix-blend-mode" => Some("MixBlendMode")
  | "background-blend-mode" => Some("BackgroundBlendMode")

  /* Break properties */
  | "break-after" => Some("BreakAfter")
  | "break-before" => Some("BreakBefore")
  | "break-inside" => Some("BreakInside")
  | "page-break-after" => Some("PageBreakAfter")
  | "page-break-before" => Some("PageBreakBefore")
  | "page-break-inside" => Some("PageBreakInside")

  /* Container */
  | "container-name" => Some("ContainerName")
  | "container-type" => Some("ContainerType")

  /* Table */
  | "caption-side" => Some("CaptionSide")
  | "empty-cells" => Some("EmptyCells")
  | "quotes" => Some("Quotes")

  /* Caret */
  | "caret-color" => Some("CaretColor")

  /* Outline */
  | "outline-style" => Some("OutlineStyle")
  | "outline-width" => Some("LineWidth")
  | "outline-offset" => Some("Length")

  /* Text advanced */
  | "text-indent" => Some("TextIndent")
  | "text-underline-offset" => Some("TextUnderlineOffset")
  | "text-underline-position" => Some("TextUnderlinePosition")
  | "text-rendering" => Some("TextRendering")

  /* Offset/motion path */
  | "offset-distance" => Some("OffsetDistance")
  | "offset-rotate" => Some("OffsetRotate")

  /* Color */
  | "color-interpolation" => Some("ColorInterpolation")
  | "color-interpolation-filters" => Some("ColorInterpolationFilters")
  | "color-adjust" => Some("ColorAdjust")
  | "color-scheme" => Some("ColorScheme")
  | "clip" => Some("Clip")
  | "clip-rule" => Some("ClipRule")

  /* Zoom */
  | "zoom" => Some("Zoom")

  /* Column */
  | "column-width" => Some("ColumnWidth")
  | "column-count" => Some("ColumnCount")
  | "columns" => Some("Columns")
  | "column-fill" => Some("ColumnFill")
  | "column-span" => Some("ColumnSpan")
  | "column-rule" => Some("ColumnRule")
  | "column-rule-style" => Some("ColumnRuleStyle")
  | "column-rule-width" => Some("ColumnRuleWidth")

  /* Font advanced */
  | "font-size-adjust" => Some("FontSizeAdjust")

  /* Text advanced */
  | "text-anchor" => Some("TextAnchor")
  | "text-size-adjust" => Some("TextSizeAdjust")
  | "text-orientation" => Some("TextOrientation")
  | "text-combine-upright" => Some("TextCombineUpright")

  /* Hanging punctuation */
  | "hanging-punctuation" => Some("HangingPunctuation")

  /* Hyphenate */
  | "hyphenate-character" => Some("HyphenateCharacter")
  | "hyphenate-limit-chars" => Some("HyphenateLimitChars")
  | "hyphenate-limit-lines" => Some("HyphenateLimitLines")
  | "hyphenate-limit-zone" => Some("HyphenateLimitZone")

  /* Initial letter */
  | "initial-letter" => Some("InitialLetter")
  | "initial-letter-align" => Some("InitialLetterAlign")

  /* Line clamp */
  | "line-clamp" => Some("LineClamp")
  | "max-lines" => Some("MaxLines")

  /* Box decoration */
  | "box-decoration-break" => Some("BoxDecorationBreak")

  /* Ruby */
  | "ruby-align" => Some("RubyAlign")
  | "ruby-merge" => Some("RubyMerge")
  | "ruby-position" => Some("RubyPosition")

  /* Place */
  | "place-content" => Some("PlaceContent")
  | "place-items" => Some("PlaceItems")
  | "place-self" => Some("PlaceSelf")

  /* Margin trim */
  | "margin-trim" => Some("MarginTrim")

  /* Scroll snap additional */
  | "scroll-snap-coordinate" => Some("ScrollSnapCoordinate")
  | "scroll-snap-destination" => Some("ScrollSnapDestination")

  /* Image */
  | "image-resolution" => Some("ImageResolution")

  /* Shape */
  | "shape-margin" => Some("ShapeMargin")
  | "shape-image-threshold" => Some("ShapeImageThreshold")

  /* Baseline */
  | "baseline-shift" => Some("BaselineShift")
  | "dominant-baseline" => Some("DominantBaseline")
  | "alignment-baseline" => Some("AlignmentBaseline")

  /* All */
  | "all" => Some("All")

  /* Border image */
  | "border-image-source" => Some("BorderImageSource")
  | "border-image-slice" => Some("BorderImageSlice")
  | "border-image-width" => Some("BorderImageWidth")
  | "border-image-outset" => Some("BorderImageOutset")
  | "border-image-repeat" => Some("BorderImageRepeat")

  /* Image rendering */
  | "image-rendering" => Some("ImageRendering")
  | "image-orientation" => Some("ImageOrientation")

  /* SVG stroke */
  | "stroke-dasharray" => Some("StrokeDashArray")

  /* Font family and advanced font */
  | "font-family" => Some("FontFamily")
  | "font-palette" => Some("FontPalette")
  | "font-variant-alternates" => Some("FontVariantAlternates")
  | "font-variant-east-asian" => Some("FontVariantEastAsian")
  | "font-variant-ligatures" => Some("FontVariantLigatures")
  | "font-variant-numeric" => Some("FontVariantNumeric")
  | "font-feature-settings" => Some("FontFeatureSettings")
  | "font-variation-settings" => Some("FontVariationSettings")
  | "font-language-override" => Some("FontLanguageOverride")

  /* Text decoration skip */
  | "text-decoration-skip" => Some("TextDecorationSkip")
  | "text-decoration-skip-self" => Some("TextDecorationSkipSelf")
  | "text-decoration-skip-spaces" => Some("TextDecorationSkipSpaces")

  /* Advanced text */
  | "text-autospace" => Some("TextAutospace")
  | "text-blink" => Some("TextBlink")
  | "text-justify-trim" => Some("TextJustifyTrim")
  | "text-kashida" => Some("TextKashida")
  | "text-kashida-space" => Some("TextKashidaSpace")

  /* Line height step */
  | "line-height-step" => Some("LineHeightStep")

  /* Shape */
  | "shape-outside" => Some("ShapeOutside")
  | "shape-rendering" => Some("ShapeRendering")

  /* Offset */
  | "offset" => Some("Offset")
  | "offset-path" => Some("OffsetPath")
  | "offset-position" => Some("OffsetPosition")

  /* SVG fill/stroke */
  | "fill-opacity" => Some("FillOpacity")
  | "fill-rule" => Some("FillRule")
  | "stroke-width" => Some("StrokeWidth")
  | "stroke-linecap" => Some("StrokeLinecap")
  | "stroke-linejoin" => Some("StrokeLinejoin")
  | "stroke-miterlimit" => Some("StrokeMiterlimit")
  | "stroke-dashoffset" => Some("StrokeDashoffset")

  /* Marker */
  | "marker" => Some("Marker")
  | "marker-start" => Some("MarkerStart")
  | "marker-mid" => Some("MarkerMid")
  | "marker-end" => Some("MarkerEnd")

  /* Paint order */
  | "paint-order" => Some("PaintOrder")

  /* Kerning and glyph */
  | "kerning" => Some("Kerning")
  | "glyph-orientation-horizontal" => Some("GlyphOrientationHorizontal")
  | "glyph-orientation-vertical" => Some("GlyphOrientationVertical")

  /* Navigation (obsolete) */
  | "nav-down" => Some("NavDown")
  | "nav-left" => Some("NavLeft")
  | "nav-right" => Some("NavRight")
  | "nav-up" => Some("NavUp")

  /* Container */
  | "container" => Some("Container")

  /* Scroll snap points (legacy) */
  | "scroll-snap-points-x" => Some("ScrollSnapPointsX")
  | "scroll-snap-points-y" => Some("ScrollSnapPointsY")

  /* Legacy box */
  | "box-align" => Some("BoxAlign")
  | "box-direction" => Some("BoxDirection")
  | "box-flex" => Some("BoxFlex")
  | "box-flex-group" => Some("BoxFlexGroup")
  | "box-lines" => Some("BoxLines")
  | "box-ordinal-group" => Some("BoxOrdinalGroup")
  | "box-orient" => Some("BoxOrient")
  | "box-pack" => Some("BoxPack")

  /* Layout grid (legacy IE) */
  | "layout-grid" => Some("LayoutGrid")
  | "layout-grid-char" => Some("LayoutGridChar")
  | "layout-grid-line" => Some("LayoutGridLine")
  | "layout-grid-mode" => Some("LayoutGridMode")
  | "layout-grid-type" => Some("LayoutGridType")

  /* Font smooth */
  | "font-smooth" => Some("FontSmooth")

  /* Src */
  | "src" => Some("Src")

  /* Unicode range - will need special handling */

  /* Misc */
  | "ime-mode" => Some("ImeMode")
  | "azimuth" => Some("Azimuth")
  | "behavior" => Some("Behavior")
  | "masonry-auto-flow" => Some("MasonryAutoFlow")
  | "forced-color-adjust" => Some("ForcedColorAdjust")
  | "block-overflow" => Some("BlockOverflow")

  /* Voice/Speech */
  | "voice-volume" => Some("VoiceVolume")
  | "voice-balance" => Some("VoiceBalance")
  | "voice-duration" => Some("VoiceDuration")
  | "voice-rate" => Some("VoiceRate")
  | "voice-stress" => Some("VoiceStress")
  | "speak" => Some("Speak")
  | "speak-as" => Some("SpeakAs")
  | "pause-before" => Some("PauseBefore")
  | "pause-after" => Some("PauseAfter")
  | "rest-before" => Some("RestBefore")
  | "rest-after" => Some("RestAfter")
  | "cue-before" => Some("CueBefore")
  | "cue-after" => Some("CueAfter")

  /* Vendor-prefixed - Mozilla */
  | "-moz-appearance" => Some("MozAppearance")
  | "-moz-background-clip" => Some("MozBackgroundClip")
  | "-moz-binding" => Some("MozBinding")
  | "-moz-border-bottom-colors" => Some("MozBorderBottomColors")
  | "-moz-border-left-colors" => Some("MozBorderLeftColors")
  | "-moz-border-right-colors" => Some("MozBorderRightColors")
  | "-moz-border-top-colors" => Some("MozBorderTopColors")

  /* Vendor-prefixed - WebKit */
  | "-webkit-appearance" => Some("WebkitAppearance")
  | "-webkit-background-clip" => Some("WebkitBackgroundClip")
  | "-webkit-mask" => Some("WebkitMask")
  | "-webkit-box-reflect" => Some("WebkitBoxReflect")

  /* Font synthesis */
  | "font-synthesis" => Some("FontSynthesis")

  /* Text emphasis */
  | "text-emphasis" => Some("TextEmphasis")

  /* Border/outline shorthands */
  | "border-image" => Some("BorderImage")
  | "outline" => Some("Outline")
  | "border-top" => Some("BorderTop")
  | "border-bottom" => Some("BorderBottom")
  | "border-left" => Some("BorderLeft")
  | "border-right" => Some("BorderRight")
  | "border" => Some("BorderShorthand")

  /* Shadow values */
  | "box-shadow" => Some("BoxShadowValue")
  | "text-shadow" => Some("TextShadowValue")

  /* Voice/Speech shorthands */
  | "voice-family" => Some("VoiceFamily")
  | "voice-pitch" => Some("VoicePitch")
  | "voice-range" => Some("VoiceRange")
  | "pause" => Some("Pause")
  | "rest" => Some("Rest")
  | "cue" => Some("Cue")

  /* Font shorthand */
  | "font" => Some("Font")

  /* Moz vendor - radius */
  | "-moz-border-radius-bottomleft" => Some("MozBorderRadiusBottomleft")
  | "-moz-border-radius-bottomright" => Some("MozBorderRadiusBottomright")
  | "-moz-border-radius-topleft" => Some("MozBorderRadiusTopleft")
  | "-moz-border-radius-topright" => Some("MozBorderRadiusTopright")
  | "-moz-context-properties" => Some("MozContextProperties")
  | "-moz-control-character-visibility" =>
    Some("MozControlCharacterVisibility")
  | "-moz-float-edge" => Some("MozFloatEdge")
  | "-moz-force-broken-image-icon" => Some("MozForceBrokenImageIcon")
  | "-moz-image-region" => Some("MozImageRegion")
  | "-moz-orient" => Some("MozOrient")
  | "-moz-osx-font-smoothing" => Some("MozOsxFontSmoothing")
  | "-moz-outline-radius" => Some("MozOutlineRadius")
  | "-moz-outline-radius-bottomleft" => Some("MozOutlineRadiusBottomleft")
  | "-moz-outline-radius-bottomright" => Some("MozOutlineRadiusBottomright")
  | "-moz-outline-radius-topleft" => Some("MozOutlineRadiusTopleft")
  | "-moz-outline-radius-topright" => Some("MozOutlineRadiusTopright")
  | "-moz-stack-sizing" => Some("MozStackSizing")
  | "-moz-text-blink" => Some("MozTextBlink")
  | "-moz-user-focus" => Some("MozUserFocus")
  | "-moz-user-input" => Some("MozUserInput")
  | "-moz-user-modify" => Some("MozUserModify")
  | "-moz-user-select" => Some("MozUserSelect")
  | "-moz-window-dragging" => Some("MozWindowDragging")
  | "-moz-window-shadow" => Some("MozWindowShadow")

  /* Webkit vendor - extended */
  | "-webkit-border-before" => Some("WebkitBorderBefore")
  | "-webkit-border-before-color" => Some("WebkitBorderBeforeColor")
  | "-webkit-border-before-style" => Some("WebkitBorderBeforeStyle")
  | "-webkit-border-before-width" => Some("WebkitBorderBeforeWidth")
  | "-webkit-column-break-after" => Some("WebkitColumnBreakAfter")
  | "-webkit-column-break-before" => Some("WebkitColumnBreakBefore")
  | "-webkit-column-break-inside" => Some("WebkitColumnBreakInside")
  | "-webkit-font-smoothing" => Some("WebkitFontSmoothing")
  | "-webkit-line-clamp" => Some("WebkitLineClamp")
  | "-webkit-mask-attachment" => Some("WebkitMaskAttachment")
  | "-webkit-mask-box-image" => Some("WebkitMaskBoxImage")
  | "-webkit-mask-clip" => Some("WebkitMaskClip")
  | "-webkit-mask-composite" => Some("WebkitMaskComposite")
  | "-webkit-mask-image" => Some("WebkitMaskImage")
  | "-webkit-mask-origin" => Some("WebkitMaskOrigin")
  | "-webkit-mask-position" => Some("WebkitMaskPosition")
  | "-webkit-mask-position-x" => Some("WebkitMaskPositionX")
  | "-webkit-mask-position-y" => Some("WebkitMaskPositionY")
  | "-webkit-mask-repeat" => Some("WebkitMaskRepeat")
  | "-webkit-mask-repeat-x" => Some("WebkitMaskRepeatX")
  | "-webkit-mask-repeat-y" => Some("WebkitMaskRepeatY")
  | "-webkit-mask-size" => Some("WebkitMaskSize")
  | "-webkit-overflow-scrolling" => Some("WebkitOverflowScrolling")
  | "-webkit-print-color-adjust" => Some("WebkitPrintColorAdjust")
  | "-webkit-tap-highlight-color" => Some("WebkitTapHighlightColor")
  | "-webkit-text-fill-color" => Some("WebkitTextFillColor")
  | "-webkit-text-security" => Some("WebkitTextSecurity")
  | "-webkit-text-stroke" => Some("WebkitTextStroke")
  | "-webkit-text-stroke-color" => Some("WebkitTextStrokeColor")
  | "-webkit-text-stroke-width" => Some("WebkitTextStrokeWidth")
  | "-webkit-touch-callout" => Some("WebkitTouchCallout")
  | "-webkit-user-drag" => Some("WebkitUserDrag")
  | "-webkit-user-modify" => Some("WebkitUserModify")
  | "-webkit-user-select" => Some("WebkitUserSelect")

  /* Scrollbar color variants */
  | "scrollbar-3dlight-color" => Some("Scrollbar3dlightColor")
  | "scrollbar-arrow-color" => Some("ScrollbarArrowColor")
  | "scrollbar-base-color" => Some("ScrollbarBaseColor")
  | "scrollbar-darkshadow-color" => Some("ScrollbarDarkshadowColor")
  | "scrollbar-face-color" => Some("ScrollbarFaceColor")
  | "scrollbar-highlight-color" => Some("ScrollbarHighlightColor")
  | "scrollbar-shadow-color" => Some("ScrollbarShadowColor")
  | "scrollbar-track-color" => Some("ScrollbarTrackColor")

  /* Unicode range */
  | "unicode-range" => Some("UnicodeRange")

  /* Mask properties */
  | "mask" => Some("Mask")
  | "mask-border" => Some("MaskBorder")
  | "mask-border-mode" => Some("MaskBorderMode")
  | "mask-border-outset" => Some("MaskBorderOutset")
  | "mask-border-repeat" => Some("MaskBorderRepeat")
  | "mask-border-slice" => Some("MaskBorderSlice")
  | "mask-border-source" => Some("MaskBorderSource")
  | "mask-border-width" => Some("MaskBorderWidth")
  | "mask-clip" => Some("MaskClip")
  | "mask-composite" => Some("MaskComposite")
  | "mask-mode" => Some("MaskMode")
  | "mask-origin" => Some("MaskOrigin")
  | "mask-repeat" => Some("MaskRepeat")
  | "mask-size" => Some("MaskSize")
  | "mask-type" => Some("MaskType")

  /* Properties without specific modules - these properties exist in Parser.ml
     but either don't have Css_types modules or need special handling */
  | _ => None
  };
};

/**
 * Get the toString expression for a property with an interpolated value.
 *
 * Returns an expression like: CSS.Types.Color.toString(value)
 */
let get_to_string_for_property = (~loc, property_name, value_expr) => {
  switch (property_to_module(property_name)) {
  | Some(module_name) => make_to_string_call(~loc, module_name, value_expr)
  | None =>
    /* For now, just pass through the value - this will likely cause a type error
       which is better than silently generating incorrect code */
    value_expr
  };
};
