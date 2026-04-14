# Missing Css_types TODOs

- Status (2026-04-06): fallback `Css_types` modules were added in
  `packages/runtime/native/shared/Css_types.ml` for all entries below.
  Keep this list as a follow-up backlog to replace permissive fallbacks
  with dedicated typed runtime modules.

- Total missing property entries: 362
- Source: `packages/css-grammar/lib/Properties/*` vs `packages/runtime/native/shared/Css_types.ml`

## `packages/css-grammar/lib/Properties/AlignmentBaseline.ml`

- [ ] `alignment-baseline` -> missing `Css_types.AlignmentBaseline` (packages/css-grammar/lib/Properties/AlignmentBaseline.ml:16)

## `packages/css-grammar/lib/Properties/AnchorName.ml`

- [ ] `anchor-name` -> missing `Css_types.AnchorName` (packages/css-grammar/lib/Properties/AnchorName.ml:12)

## `packages/css-grammar/lib/Properties/AnchorScope.ml`

- [ ] `anchor-scope` -> missing `Css_types.AnchorScope` (packages/css-grammar/lib/Properties/AnchorScope.ml:12)

## `packages/css-grammar/lib/Properties/Animation.ml`

- [ ] `animation-composition` -> missing `Css_types.AnimationComposition` (packages/css-grammar/lib/Properties/Animation.ml:139)
- [ ] `animation-delay-end` -> missing `Css_types.AnimationDelayEnd` (packages/css-grammar/lib/Properties/Animation.ml:142)
- [ ] `animation-delay-start` -> missing `Css_types.AnimationDelayStart` (packages/css-grammar/lib/Properties/Animation.ml:144)
- [ ] `animation-name` -> missing `Css_types.AnimationName` (packages/css-grammar/lib/Properties/Animation.ml:154)
- [ ] `animation-range` -> missing `Css_types.AnimationRange` (packages/css-grammar/lib/Properties/Animation.ml:157)
- [ ] `animation-range-end` -> missing `Css_types.AnimationRangeEnd` (packages/css-grammar/lib/Properties/Animation.ml:158)
- [ ] `animation-range-start` -> missing `Css_types.AnimationRangeStart` (packages/css-grammar/lib/Properties/Animation.ml:160)
- [ ] `animation-timeline` -> missing `Css_types.AnimationTimeline` (packages/css-grammar/lib/Properties/Animation.ml:162)

## `packages/css-grammar/lib/Properties/BaselineShift.ml`

- [ ] `baseline-shift` -> missing `Css_types.BaselineShift` (packages/css-grammar/lib/Properties/BaselineShift.ml:13)

## `packages/css-grammar/lib/Properties/BlockOverflow.ml`

- [ ] `block-overflow` -> missing `Css_types.BlockOverflow` (packages/css-grammar/lib/Properties/BlockOverflow.ml:12)

## `packages/css-grammar/lib/Properties/Border.ml`

- [ ] `border-block` -> missing `Css_types.BorderBlock` (packages/css-grammar/lib/Properties/Border.ml:476)
- [ ] `border-block-end` -> missing `Css_types.BorderBlockEnd` (packages/css-grammar/lib/Properties/Border.ml:477)
- [ ] `border-block-end-style` -> missing `Css_types.BorderBlockEndStyle` (packages/css-grammar/lib/Properties/Border.ml:478)
- [ ] `border-block-start` -> missing `Css_types.BorderBlockStart` (packages/css-grammar/lib/Properties/Border.ml:482)
- [ ] `border-block-start-style` -> missing `Css_types.BorderBlockStartStyle` (packages/css-grammar/lib/Properties/Border.ml:484)
- [ ] `border-block-style` -> missing `Css_types.BorderBlockStyle` (packages/css-grammar/lib/Properties/Border.ml:488)
- [ ] `border-inline` -> missing `Css_types.BorderInline` (packages/css-grammar/lib/Properties/Border.ml:505)
- [ ] `border-inline-end` -> missing `Css_types.BorderInlineEnd` (packages/css-grammar/lib/Properties/Border.ml:506)
- [ ] `border-inline-end-style` -> missing `Css_types.BorderInlineEndStyle` (packages/css-grammar/lib/Properties/Border.ml:508)
- [ ] `border-inline-start` -> missing `Css_types.BorderInlineStart` (packages/css-grammar/lib/Properties/Border.ml:512)
- [ ] `border-inline-start-style` -> missing `Css_types.BorderInlineStartStyle` (packages/css-grammar/lib/Properties/Border.ml:514)
- [ ] `border-inline-style` -> missing `Css_types.BorderInlineStyle` (packages/css-grammar/lib/Properties/Border.ml:518)
- [ ] `border-spacing` -> missing `Css_types.BorderSpacing` (packages/css-grammar/lib/Properties/Border.ml:533)
- [ ] `border-block-color` -> missing `Css_types.BorderBlockColor` (packages/css-grammar/lib/Properties/Border.ml:548)
- [ ] `border-inline-color` -> missing `Css_types.BorderInlineColor` (packages/css-grammar/lib/Properties/Border.ml:557)
- [ ] `border-image` -> missing `Css_types.BorderImage` (packages/css-grammar/lib/Properties/Border.ml:570)

## `packages/css-grammar/lib/Properties/Box.ml`

- [ ] `box-decoration-break` -> missing `Css_types.BoxDecorationBreak` (packages/css-grammar/lib/Properties/Box.ml:80)
- [ ] `box-align` -> missing `Css_types.BoxAlign` (packages/css-grammar/lib/Properties/Box.ml:82)
- [ ] `box-direction` -> missing `Css_types.BoxDirection` (packages/css-grammar/lib/Properties/Box.ml:83)
- [ ] `box-flex` -> missing `Css_types.BoxFlex` (packages/css-grammar/lib/Properties/Box.ml:84)
- [ ] `box-flex-group` -> missing `Css_types.BoxFlexGroup` (packages/css-grammar/lib/Properties/Box.ml:85)
- [ ] `box-lines` -> missing `Css_types.BoxLines` (packages/css-grammar/lib/Properties/Box.ml:86)
- [ ] `box-ordinal-group` -> missing `Css_types.BoxOrdinalGroup` (packages/css-grammar/lib/Properties/Box.ml:87)
- [ ] `box-pack` -> missing `Css_types.BoxPack` (packages/css-grammar/lib/Properties/Box.ml:90)

## `packages/css-grammar/lib/Properties/CaptionSide.ml`

- [ ] `caption-side` -> missing `Css_types.CaptionSide` (packages/css-grammar/lib/Properties/CaptionSide.ml:14)

## `packages/css-grammar/lib/Properties/Clip.ml`

- [ ] `clip-rule` -> missing `Css_types.ClipRule` (packages/css-grammar/lib/Properties/Clip.ml:19)

## `packages/css-grammar/lib/Properties/Color.ml`

- [ ] `color-scheme` -> missing `Css_types.ColorScheme` (packages/css-grammar/lib/Properties/Color.ml:47)
- [ ] `color-adjust` -> missing `Css_types.ColorAdjust` (packages/css-grammar/lib/Properties/Color.ml:48)
- [ ] `color-interpolation` -> missing `Css_types.ColorInterpolation` (packages/css-grammar/lib/Properties/Color.ml:50)
- [ ] `color-interpolation-filters` -> missing `Css_types.ColorInterpolationFilters` (packages/css-grammar/lib/Properties/Color.ml:52)
- [ ] `color-rendering` -> missing `Css_types.ColorRendering` (packages/css-grammar/lib/Properties/Color.ml:54)

## `packages/css-grammar/lib/Properties/Column.ml`

- [ ] `column-fill` -> missing `Css_types.ColumnFill` (packages/css-grammar/lib/Properties/Column.ml:82)
- [ ] `column-span` -> missing `Css_types.ColumnSpan` (packages/css-grammar/lib/Properties/Column.ml:84)
- [ ] `column-rule` -> missing `Css_types.ColumnRule` (packages/css-grammar/lib/Properties/Column.ml:88)
- [ ] `column-rule-style` -> missing `Css_types.ColumnRuleStyle` (packages/css-grammar/lib/Properties/Column.ml:91)
- [ ] `column-rule-width` -> missing `Css_types.ColumnRuleWidth` (packages/css-grammar/lib/Properties/Column.ml:93)

## `packages/css-grammar/lib/Properties/Columns.ml`

- [ ] `columns` -> missing `Css_types.Columns` (packages/css-grammar/lib/Properties/Columns.ml:11)

## `packages/css-grammar/lib/Properties/Contain.ml`

- [ ] `contain-intrinsic-size` -> missing `Css_types.ContainIntrinsicSize` (packages/css-grammar/lib/Properties/Contain.ml:60)
- [ ] `contain` -> missing `Css_types.Contain` (packages/css-grammar/lib/Properties/Contain.ml:62)
- [ ] `contain-intrinsic-block-size` -> missing `Css_types.ContainIntrinsicBlockSize` (packages/css-grammar/lib/Properties/Contain.ml:63)
- [ ] `contain-intrinsic-height` -> missing `Css_types.ContainIntrinsicHeight` (packages/css-grammar/lib/Properties/Contain.ml:65)
- [ ] `contain-intrinsic-inline-size` -> missing `Css_types.ContainIntrinsicInlineSize` (packages/css-grammar/lib/Properties/Contain.ml:67)
- [ ] `contain-intrinsic-width` -> missing `Css_types.ContainIntrinsicWidth` (packages/css-grammar/lib/Properties/Contain.ml:69)

## `packages/css-grammar/lib/Properties/Container.ml`

- [ ] `container-type` -> missing `Css_types.ContainerType` (packages/css-grammar/lib/Properties/Container.ml:26)
- [ ] `container` -> missing `Css_types.Container` (packages/css-grammar/lib/Properties/Container.ml:27)
- [ ] `container-name` -> missing `Css_types.ContainerName` (packages/css-grammar/lib/Properties/Container.ml:28)

## `packages/css-grammar/lib/Properties/ContentVisibility.ml`

- [ ] `content-visibility` -> missing `Css_types.ContentVisibility` (packages/css-grammar/lib/Properties/ContentVisibility.ml:13)

## `packages/css-grammar/lib/Properties/Descriptors.ml`

- [ ] `inherits` -> missing `Css_types.Inherits` (packages/css-grammar/lib/Properties/Descriptors.ml:53)
- [ ] `initial-value` -> missing `Css_types.InitialValue` (packages/css-grammar/lib/Properties/Descriptors.ml:54)
- [ ] `page` -> missing `Css_types.Page` (packages/css-grammar/lib/Properties/Descriptors.ml:55)
- [ ] `src` -> missing `Css_types.Src` (packages/css-grammar/lib/Properties/Descriptors.ml:56)
- [ ] `unicode-range` -> missing `Css_types.UnicodeRange` (packages/css-grammar/lib/Properties/Descriptors.ml:57)
- [ ] `bleed` -> missing `Css_types.Bleed` (packages/css-grammar/lib/Properties/Descriptors.ml:58)
- [ ] `marks` -> missing `Css_types.Marks` (packages/css-grammar/lib/Properties/Descriptors.ml:59)

## `packages/css-grammar/lib/Properties/DominantBaseline.ml`

- [ ] `dominant-baseline` -> missing `Css_types.DominantBaseline` (packages/css-grammar/lib/Properties/DominantBaseline.ml:16)

## `packages/css-grammar/lib/Properties/EmptyCells.ml`

- [ ] `empty-cells` -> missing `Css_types.EmptyCells` (packages/css-grammar/lib/Properties/EmptyCells.ml:12)

## `packages/css-grammar/lib/Properties/FieldSizing.ml`

- [ ] `field-sizing` -> missing `Css_types.FieldSizing` (packages/css-grammar/lib/Properties/FieldSizing.ml:12)

## `packages/css-grammar/lib/Properties/Fill.ml`

- [ ] `fill-opacity` -> missing `Css_types.FillOpacity` (packages/css-grammar/lib/Properties/Fill.ml:23)
- [ ] `fill-rule` -> missing `Css_types.FillRule` (packages/css-grammar/lib/Properties/Fill.ml:24)

## `packages/css-grammar/lib/Properties/Flex.ml`

- [ ] `flex-flow` -> missing `Css_types.FlexFlow` (packages/css-grammar/lib/Properties/Flex.ml:60)

## `packages/css-grammar/lib/Properties/Font.ml`

- [ ] `font-stretch` -> missing `Css_types.FontStretch` (packages/css-grammar/lib/Properties/Font.ml:252)
- [ ] `font-width` -> missing `Css_types.FontStretch` (packages/css-grammar/lib/Properties/Font.ml:253)
- [ ] `font-palette` -> missing `Css_types.FontPalette` (packages/css-grammar/lib/Properties/Font.ml:259)
- [ ] `font` -> missing `Css_types.Font` (packages/css-grammar/lib/Properties/Font.ml:269)
- [ ] `font-feature-settings` -> missing `Css_types.FontFeatureSettings` (packages/css-grammar/lib/Properties/Font.ml:271)
- [ ] `font-language-override` -> missing `Css_types.FontLanguageOverride` (packages/css-grammar/lib/Properties/Font.ml:273)
- [ ] `font-size-adjust` -> missing `Css_types.FontSizeAdjust` (packages/css-grammar/lib/Properties/Font.ml:276)
- [ ] `font-smooth` -> missing `Css_types.FontSmooth` (packages/css-grammar/lib/Properties/Font.ml:277)
- [ ] `font-synthesis` -> missing `Css_types.FontSynthesis` (packages/css-grammar/lib/Properties/Font.ml:278)
- [ ] `font-variant-alternates` -> missing `Css_types.FontVariantAlternates` (packages/css-grammar/lib/Properties/Font.ml:280)
- [ ] `font-variant-east-asian` -> missing `Css_types.FontVariantEastAsian` (packages/css-grammar/lib/Properties/Font.ml:282)
- [ ] `font-variant-ligatures` -> missing `Css_types.FontVariantLigatures` (packages/css-grammar/lib/Properties/Font.ml:286)
- [ ] `font-variant-numeric` -> missing `Css_types.FontVariantNumeric` (packages/css-grammar/lib/Properties/Font.ml:288)
- [ ] `font-variation-settings` -> missing `Css_types.FontVariationSettings` (packages/css-grammar/lib/Properties/Font.ml:290)

## `packages/css-grammar/lib/Properties/ForcedColorAdjust.ml`

- [ ] `-ms-high-contrast-adjust` -> missing `Css_types.ForcedColorAdjust` (packages/css-grammar/lib/Properties/ForcedColorAdjust.ml:20)
- [ ] `forced-color-adjust` -> missing `Css_types.ForcedColorAdjust` (packages/css-grammar/lib/Properties/ForcedColorAdjust.ml:22)

## `packages/css-grammar/lib/Properties/HangingPunctuation.ml`

- [ ] `hanging-punctuation` -> missing `Css_types.HangingPunctuation` (packages/css-grammar/lib/Properties/HangingPunctuation.ml:14)

## `packages/css-grammar/lib/Properties/HyphenateCharacter.ml`

- [ ] `hyphenate-character` -> missing `Css_types.HyphenateCharacter` (packages/css-grammar/lib/Properties/HyphenateCharacter.ml:13)

## `packages/css-grammar/lib/Properties/HyphenateLimit.ml`

- [ ] `-ms-hyphenate-limit-lines` -> missing `Css_types.HyphenateLimitLines` (packages/css-grammar/lib/Properties/HyphenateLimit.ml:42)
- [ ] `-ms-hyphenate-limit-zone` -> missing `Css_types.HyphenateLimitZone` (packages/css-grammar/lib/Properties/HyphenateLimit.ml:44)
- [ ] `hyphenate-limit-last` -> missing `Css_types.HyphenateLimitLast` (packages/css-grammar/lib/Properties/HyphenateLimit.ml:46)
- [ ] `hyphenate-limit-lines` -> missing `Css_types.HyphenateLimitLines` (packages/css-grammar/lib/Properties/HyphenateLimit.ml:48)
- [ ] `hyphenate-limit-zone` -> missing `Css_types.HyphenateLimitZone` (packages/css-grammar/lib/Properties/HyphenateLimit.ml:50)

## `packages/css-grammar/lib/Properties/HyphenateLimitChars.ml`

- [ ] `-ms-hyphenate-limit-chars` -> missing `Css_types.HyphenateLimitChars` (packages/css-grammar/lib/Properties/HyphenateLimitChars.ml:19)
- [ ] `hyphenate-limit-chars` -> missing `Css_types.HyphenateLimitChars` (packages/css-grammar/lib/Properties/HyphenateLimitChars.ml:21)

## `packages/css-grammar/lib/Properties/Image.ml`

- [ ] `image-resolution` -> missing `Css_types.ImageResolution` (packages/css-grammar/lib/Properties/Image.ml:32)

## `packages/css-grammar/lib/Properties/Ime.ml`

- [ ] `ime-mode` -> missing `Css_types.ImeMode` (packages/css-grammar/lib/Properties/Ime.ml:20)

## `packages/css-grammar/lib/Properties/InitialLetter.ml`

- [ ] `initial-letter` -> missing `Css_types.InitialLetter` (packages/css-grammar/lib/Properties/InitialLetter.ml:12)

## `packages/css-grammar/lib/Properties/InitialLetterAlign.ml`

- [ ] `initial-letter-align` -> missing `Css_types.InitialLetterAlign` (packages/css-grammar/lib/Properties/InitialLetterAlign.ml:14)

## `packages/css-grammar/lib/Properties/Inset.ml`

- [ ] `inset` -> missing `Css_types.Inset` (packages/css-grammar/lib/Properties/Inset.ml:63)
- [ ] `inset-area` -> missing `Css_types.InsetArea` (packages/css-grammar/lib/Properties/Inset.ml:64)

## `packages/css-grammar/lib/Properties/InterpolateSize.ml`

- [ ] `interpolate-size` -> missing `Css_types.InterpolateSize` (packages/css-grammar/lib/Properties/InterpolateSize.ml:13)

## `packages/css-grammar/lib/Properties/Layout.ml`

- [ ] `layout-grid` -> missing `Css_types.LayoutGrid` (packages/css-grammar/lib/Properties/Layout.ml:42)
- [ ] `layout-grid-char` -> missing `Css_types.LayoutGridChar` (packages/css-grammar/lib/Properties/Layout.ml:43)
- [ ] `layout-grid-line` -> missing `Css_types.LayoutGridLine` (packages/css-grammar/lib/Properties/Layout.ml:44)
- [ ] `layout-grid-mode` -> missing `Css_types.LayoutGridMode` (packages/css-grammar/lib/Properties/Layout.ml:45)
- [ ] `layout-grid-type` -> missing `Css_types.LayoutGridType` (packages/css-grammar/lib/Properties/Layout.ml:46)

## `packages/css-grammar/lib/Properties/Legacy.ml`

- [ ] `kerning` -> missing `Css_types.Kerning` (packages/css-grammar/lib/Properties/Legacy.ml:81)
- [ ] `behavior` -> missing `Css_types.Behavior` (packages/css-grammar/lib/Properties/Legacy.ml:82)
- [ ] `clip` -> missing `Css_types.Clip` (packages/css-grammar/lib/Properties/Legacy.ml:84)
- [ ] `container-name-computed` -> missing `Css_types.ContainerNameComputed` (packages/css-grammar/lib/Properties/Legacy.ml:85)
- [ ] `azimuth` -> missing `Css_types.Azimuth` (packages/css-grammar/lib/Properties/Legacy.ml:87)
- [ ] `cue` -> missing `Css_types.Cue` (packages/css-grammar/lib/Properties/Legacy.ml:88)
- [ ] `cue-after` -> missing `Css_types.CueAfter` (packages/css-grammar/lib/Properties/Legacy.ml:89)
- [ ] `cue-before` -> missing `Css_types.CueBefore` (packages/css-grammar/lib/Properties/Legacy.ml:90)
- [ ] `speak` -> missing `Css_types.Speak` (packages/css-grammar/lib/Properties/Legacy.ml:91)
- [ ] `word-space-transform` -> missing `Css_types.WordSpaceTransform` (packages/css-grammar/lib/Properties/Legacy.ml:92)

## `packages/css-grammar/lib/Properties/Line.ml`

- [ ] `line-clamp` -> missing `Css_types.LineClamp` (packages/css-grammar/lib/Properties/Line.ml:36)

## `packages/css-grammar/lib/Properties/ListProperties.ml`

- [ ] `list-style` -> missing `Css_types.ListStyle` (packages/css-grammar/lib/Properties/ListProperties.ml:38)

## `packages/css-grammar/lib/Properties/Margin.ml`

- [ ] `margin-trim` -> missing `Css_types.MarginTrim` (packages/css-grammar/lib/Properties/Margin.ml:109)

## `packages/css-grammar/lib/Properties/Marker.ml`

- [ ] `marker-end` -> missing `Css_types.MarkerEnd` (packages/css-grammar/lib/Properties/Marker.ml:27)
- [ ] `marker-mid` -> missing `Css_types.MarkerMid` (packages/css-grammar/lib/Properties/Marker.ml:28)
- [ ] `marker-start` -> missing `Css_types.MarkerStart` (packages/css-grammar/lib/Properties/Marker.ml:29)

## `packages/css-grammar/lib/Properties/MarkerProperty.ml`

- [ ] `marker` -> missing `Css_types.Marker` (packages/css-grammar/lib/Properties/MarkerProperty.ml:11)

## `packages/css-grammar/lib/Properties/Mask.ml`

- [ ] `mask-border-mode` -> missing `Css_types.MaskBorderMode` (packages/css-grammar/lib/Properties/Mask.ml:125)
- [ ] `mask-type` -> missing `Css_types.MaskType` (packages/css-grammar/lib/Properties/Mask.ml:126)
- [ ] `mask` -> missing `Css_types.Mask` (packages/css-grammar/lib/Properties/Mask.ml:127)
- [ ] `mask-border` -> missing `Css_types.MaskBorder` (packages/css-grammar/lib/Properties/Mask.ml:128)
- [ ] `mask-border-outset` -> missing `Css_types.MaskBorderOutset` (packages/css-grammar/lib/Properties/Mask.ml:129)
- [ ] `mask-border-repeat` -> missing `Css_types.MaskBorderRepeat` (packages/css-grammar/lib/Properties/Mask.ml:131)
- [ ] `mask-border-slice` -> missing `Css_types.MaskBorderSlice` (packages/css-grammar/lib/Properties/Mask.ml:133)
- [ ] `mask-border-source` -> missing `Css_types.MaskBorderSource` (packages/css-grammar/lib/Properties/Mask.ml:135)
- [ ] `mask-border-width` -> missing `Css_types.MaskBorderWidth` (packages/css-grammar/lib/Properties/Mask.ml:137)
- [ ] `mask-clip` -> missing `Css_types.MaskClip` (packages/css-grammar/lib/Properties/Mask.ml:139)
- [ ] `mask-composite` -> missing `Css_types.MaskComposite` (packages/css-grammar/lib/Properties/Mask.ml:140)
- [ ] `mask-mode` -> missing `Css_types.MaskMode` (packages/css-grammar/lib/Properties/Mask.ml:142)
- [ ] `mask-origin` -> missing `Css_types.MaskOrigin` (packages/css-grammar/lib/Properties/Mask.ml:143)
- [ ] `mask-size` -> missing `Css_types.MaskSize` (packages/css-grammar/lib/Properties/Mask.ml:146)

## `packages/css-grammar/lib/Properties/MasonryAutoFlow.ml`

- [ ] `masonry-auto-flow` -> missing `Css_types.MasonryAutoFlow` (packages/css-grammar/lib/Properties/MasonryAutoFlow.ml:14)

## `packages/css-grammar/lib/Properties/Math.ml`

- [ ] `math-depth` -> missing `Css_types.MathDepth` (packages/css-grammar/lib/Properties/Math.ml:27)
- [ ] `math-shift` -> missing `Css_types.MathShift` (packages/css-grammar/lib/Properties/Math.ml:28)
- [ ] `math-style` -> missing `Css_types.MathStyle` (packages/css-grammar/lib/Properties/Math.ml:29)

## `packages/css-grammar/lib/Properties/Max.ml`

- [ ] `max-lines` -> missing `Css_types.MaxLines` (packages/css-grammar/lib/Properties/Max.ml:48)

## `packages/css-grammar/lib/Properties/Media.ml`

- [ ] `media-type` -> missing `Css_types.MediaType` (packages/css-grammar/lib/Properties/Media.ml:187)
- [ ] `media-any-hover` -> missing `Css_types.MediaAnyHover` (packages/css-grammar/lib/Properties/Media.ml:188)
- [ ] `media-any-pointer` -> missing `Css_types.MediaAnyPointer` (packages/css-grammar/lib/Properties/Media.ml:189)
- [ ] `media-color-gamut` -> missing `Css_types.MediaColorGamut` (packages/css-grammar/lib/Properties/Media.ml:191)
- [ ] `media-color-index` -> missing `Css_types.MediaColorIndex` (packages/css-grammar/lib/Properties/Media.ml:193)
- [ ] `media-display-mode` -> missing `Css_types.MediaDisplayMode` (packages/css-grammar/lib/Properties/Media.ml:195)
- [ ] `media-forced-colors` -> missing `Css_types.MediaForcedColors` (packages/css-grammar/lib/Properties/Media.ml:197)
- [ ] `media-grid` -> missing `Css_types.MediaGrid` (packages/css-grammar/lib/Properties/Media.ml:199)
- [ ] `media-hover` -> missing `Css_types.MediaHover` (packages/css-grammar/lib/Properties/Media.ml:200)
- [ ] `media-inverted-colors` -> missing `Css_types.MediaInvertedColors` (packages/css-grammar/lib/Properties/Media.ml:201)
- [ ] `media-max-aspect-ratio` -> missing `Css_types.MediaMaxAspectRatio` (packages/css-grammar/lib/Properties/Media.ml:203)
- [ ] `media-max-resolution` -> missing `Css_types.MediaMaxResolution` (packages/css-grammar/lib/Properties/Media.ml:205)
- [ ] `media-min-aspect-ratio` -> missing `Css_types.MediaMinAspectRatio` (packages/css-grammar/lib/Properties/Media.ml:207)
- [ ] `media-min-color-index` -> missing `Css_types.MediaMinColorIndex` (packages/css-grammar/lib/Properties/Media.ml:209)
- [ ] `media-min-resolution` -> missing `Css_types.MediaMinResolution` (packages/css-grammar/lib/Properties/Media.ml:211)
- [ ] `media-monochrome` -> missing `Css_types.MediaMonochrome` (packages/css-grammar/lib/Properties/Media.ml:213)
- [ ] `media-orientation` -> missing `Css_types.MediaOrientation` (packages/css-grammar/lib/Properties/Media.ml:214)
- [ ] `media-pointer` -> missing `Css_types.MediaPointer` (packages/css-grammar/lib/Properties/Media.ml:216)
- [ ] `media-prefers-color-scheme` -> missing `Css_types.MediaPrefersColorScheme` (packages/css-grammar/lib/Properties/Media.ml:217)
- [ ] `media-prefers-contrast` -> missing `Css_types.MediaPrefersContrast` (packages/css-grammar/lib/Properties/Media.ml:219)
- [ ] `media-prefers-reduced-motion` -> missing `Css_types.MediaPrefersReducedMotion` (packages/css-grammar/lib/Properties/Media.ml:221)
- [ ] `media-resolution` -> missing `Css_types.MediaResolution` (packages/css-grammar/lib/Properties/Media.ml:223)
- [ ] `media-scripting` -> missing `Css_types.MediaScripting` (packages/css-grammar/lib/Properties/Media.ml:224)
- [ ] `media-update` -> missing `Css_types.MediaUpdate` (packages/css-grammar/lib/Properties/Media.ml:225)
- [ ] `media-min-color` -> missing `Css_types.MediaMinColor` (packages/css-grammar/lib/Properties/Media.ml:226)

## `packages/css-grammar/lib/Properties/Moz.ml`

- [ ] `-moz-appearance` -> missing `Css_types.MozAppearance` (packages/css-grammar/lib/Properties/Moz.ml:280)
- [ ] `-moz-background-clip` -> missing `Css_types.MozBackgroundClip` (packages/css-grammar/lib/Properties/Moz.ml:281)
- [ ] `-moz-binding` -> missing `Css_types.MozBinding` (packages/css-grammar/lib/Properties/Moz.ml:283)
- [ ] `-moz-border-bottom-colors` -> missing `Css_types.MozBorderBottomColors` (packages/css-grammar/lib/Properties/Moz.ml:284)
- [ ] `-moz-border-left-colors` -> missing `Css_types.MozBorderLeftColors` (packages/css-grammar/lib/Properties/Moz.ml:286)
- [ ] `-moz-border-radius-bottomleft` -> missing `Css_types.MozBorderRadiusBottomleft` (packages/css-grammar/lib/Properties/Moz.ml:288)
- [ ] `-moz-border-radius-bottomright` -> missing `Css_types.MozBorderRadiusBottomright` (packages/css-grammar/lib/Properties/Moz.ml:290)
- [ ] `-moz-border-radius-topleft` -> missing `Css_types.MozBorderRadiusTopleft` (packages/css-grammar/lib/Properties/Moz.ml:292)
- [ ] `-moz-border-radius-topright` -> missing `Css_types.MozBorderRadiusTopright` (packages/css-grammar/lib/Properties/Moz.ml:294)
- [ ] `-moz-border-right-colors` -> missing `Css_types.MozBorderRightColors` (packages/css-grammar/lib/Properties/Moz.ml:296)
- [ ] `-moz-border-top-colors` -> missing `Css_types.MozBorderTopColors` (packages/css-grammar/lib/Properties/Moz.ml:298)
- [ ] `-moz-context-properties` -> missing `Css_types.MozContextProperties` (packages/css-grammar/lib/Properties/Moz.ml:300)
- [ ] `-moz-float-edge` -> missing `Css_types.MozFloatEdge` (packages/css-grammar/lib/Properties/Moz.ml:304)
- [ ] `-moz-force-broken-image-icon` -> missing `Css_types.MozForceBrokenImageIcon` (packages/css-grammar/lib/Properties/Moz.ml:305)
- [ ] `-moz-image-region` -> missing `Css_types.MozImageRegion` (packages/css-grammar/lib/Properties/Moz.ml:307)
- [ ] `-moz-orient` -> missing `Css_types.MozOrient` (packages/css-grammar/lib/Properties/Moz.ml:309)
- [ ] `-moz-outline-radius` -> missing `Css_types.MozOutlineRadius` (packages/css-grammar/lib/Properties/Moz.ml:310)
- [ ] `-moz-outline-radius-bottomleft` -> missing `Css_types.MozOutlineRadiusBottomleft` (packages/css-grammar/lib/Properties/Moz.ml:312)
- [ ] `-moz-outline-radius-topleft` -> missing `Css_types.MozOutlineRadiusTopleft` (packages/css-grammar/lib/Properties/Moz.ml:316)
- [ ] `-moz-outline-radius-topright` -> missing `Css_types.MozOutlineRadiusTopright` (packages/css-grammar/lib/Properties/Moz.ml:318)
- [ ] `-moz-stack-sizing` -> missing `Css_types.MozStackSizing` (packages/css-grammar/lib/Properties/Moz.ml:320)
- [ ] `-moz-text-blink` -> missing `Css_types.MozTextBlink` (packages/css-grammar/lib/Properties/Moz.ml:322)
- [ ] `-moz-user-focus` -> missing `Css_types.MozUserFocus` (packages/css-grammar/lib/Properties/Moz.ml:323)
- [ ] `-moz-user-input` -> missing `Css_types.MozUserInput` (packages/css-grammar/lib/Properties/Moz.ml:324)
- [ ] `-moz-user-modify` -> missing `Css_types.MozUserModify` (packages/css-grammar/lib/Properties/Moz.ml:325)
- [ ] `-moz-user-select` -> missing `Css_types.MozUserSelect` (packages/css-grammar/lib/Properties/Moz.ml:326)
- [ ] `-moz-window-dragging` -> missing `Css_types.MozWindowDragging` (packages/css-grammar/lib/Properties/Moz.ml:327)
- [ ] `-moz-window-shadow` -> missing `Css_types.MozWindowShadow` (packages/css-grammar/lib/Properties/Moz.ml:329)
- [ ] `-moz-osx-font-smoothing` -> missing `Css_types.MozOsxFontSmoothing` (packages/css-grammar/lib/Properties/Moz.ml:331)

## `packages/css-grammar/lib/Properties/Nav.ml`

- [ ] `nav-down` -> missing `Css_types.NavDown` (packages/css-grammar/lib/Properties/Nav.ml:30)
- [ ] `nav-left` -> missing `Css_types.NavLeft` (packages/css-grammar/lib/Properties/Nav.ml:31)
- [ ] `nav-right` -> missing `Css_types.NavRight` (packages/css-grammar/lib/Properties/Nav.ml:32)
- [ ] `nav-up` -> missing `Css_types.NavUp` (packages/css-grammar/lib/Properties/Nav.ml:33)

## `packages/css-grammar/lib/Properties/Offset.ml`

- [ ] `offset` -> missing `Css_types.Offset` (packages/css-grammar/lib/Properties/Offset.ml:51)
- [ ] `offset-path` -> missing `Css_types.OffsetPath` (packages/css-grammar/lib/Properties/Offset.ml:54)
- [ ] `offset-position` -> missing `Css_types.OffsetPosition` (packages/css-grammar/lib/Properties/Offset.ml:55)
- [ ] `offset-rotate` -> missing `Css_types.OffsetRotate` (packages/css-grammar/lib/Properties/Offset.ml:56)

## `packages/css-grammar/lib/Properties/Orphans.ml`

- [ ] `orphans` -> missing `Css_types.Orphans` (packages/css-grammar/lib/Properties/Orphans.ml:8)

## `packages/css-grammar/lib/Properties/Outline.ml`

- [ ] `outline` -> missing `Css_types.Outline` (packages/css-grammar/lib/Properties/Outline.ml:44)

## `packages/css-grammar/lib/Properties/Overlay.ml`

- [ ] `overlay` -> missing `Css_types.Overlay` (packages/css-grammar/lib/Properties/Overlay.ml:11)

## `packages/css-grammar/lib/Properties/Overscroll.ml`

- [ ] `overscroll-behavior-block` -> missing `Css_types.OverscrollBehaviorBlock` (packages/css-grammar/lib/Properties/Overscroll.ml:45)
- [ ] `overscroll-behavior-inline` -> missing `Css_types.OverscrollBehaviorInline` (packages/css-grammar/lib/Properties/Overscroll.ml:47)
- [ ] `overscroll-behavior-x` -> missing `Css_types.OverscrollBehaviorX` (packages/css-grammar/lib/Properties/Overscroll.ml:49)
- [ ] `overscroll-behavior-y` -> missing `Css_types.OverscrollBehaviorY` (packages/css-grammar/lib/Properties/Overscroll.ml:51)

## `packages/css-grammar/lib/Properties/Page.ml`

- [ ] `page-break-after` -> missing `Css_types.PageBreakAfter` (packages/css-grammar/lib/Properties/Page.ml:29)
- [ ] `page-break-before` -> missing `Css_types.PageBreakBefore` (packages/css-grammar/lib/Properties/Page.ml:30)
- [ ] `page-break-inside` -> missing `Css_types.PageBreakInside` (packages/css-grammar/lib/Properties/Page.ml:32)

## `packages/css-grammar/lib/Properties/PaintOrder.ml`

- [ ] `paint-order` -> missing `Css_types.PaintOrder` (packages/css-grammar/lib/Properties/PaintOrder.ml:12)

## `packages/css-grammar/lib/Properties/Pause.ml`

- [ ] `pause` -> missing `Css_types.Pause` (packages/css-grammar/lib/Properties/Pause.ml:30)
- [ ] `pause-after` -> missing `Css_types.PauseAfter` (packages/css-grammar/lib/Properties/Pause.ml:31)
- [ ] `pause-before` -> missing `Css_types.PauseBefore` (packages/css-grammar/lib/Properties/Pause.ml:32)

## `packages/css-grammar/lib/Properties/Place.ml`

- [ ] `place-content` -> missing `Css_types.PlaceContent` (packages/css-grammar/lib/Properties/Place.ml:27)
- [ ] `place-items` -> missing `Css_types.PlaceItems` (packages/css-grammar/lib/Properties/Place.ml:28)
- [ ] `place-self` -> missing `Css_types.PlaceSelf` (packages/css-grammar/lib/Properties/Place.ml:29)

## `packages/css-grammar/lib/Properties/Position.ml`

- [ ] `position-anchor` -> missing `Css_types.PositionAnchor` (packages/css-grammar/lib/Properties/Position.ml:67)
- [ ] `position-area` -> missing `Css_types.PositionArea` (packages/css-grammar/lib/Properties/Position.ml:68)
- [ ] `position-try` -> missing `Css_types.PositionTry` (packages/css-grammar/lib/Properties/Position.ml:69)
- [ ] `position-try-fallbacks` -> missing `Css_types.PositionTryFallbacks` (packages/css-grammar/lib/Properties/Position.ml:70)
- [ ] `position-try-options` -> missing `Css_types.PositionTryOptions` (packages/css-grammar/lib/Properties/Position.ml:74)
- [ ] `position-visibility` -> missing `Css_types.PositionVisibility` (packages/css-grammar/lib/Properties/Position.ml:76)

## `packages/css-grammar/lib/Properties/PrintColorAdjust.ml`

- [ ] `print-color-adjust` -> missing `Css_types.PrintColorAdjust` (packages/css-grammar/lib/Properties/PrintColorAdjust.ml:15)

## `packages/css-grammar/lib/Properties/Quotes.ml`

- [ ] `quotes` -> missing `Css_types.Quotes` (packages/css-grammar/lib/Properties/Quotes.ml:11)

## `packages/css-grammar/lib/Properties/ReadingFlow.ml`

- [ ] `reading-flow` -> missing `Css_types.ReadingFlow` (packages/css-grammar/lib/Properties/ReadingFlow.ml:14)

## `packages/css-grammar/lib/Properties/Rest.ml`

- [ ] `rest` -> missing `Css_types.Rest` (packages/css-grammar/lib/Properties/Rest.ml:30)
- [ ] `rest-after` -> missing `Css_types.RestAfter` (packages/css-grammar/lib/Properties/Rest.ml:31)
- [ ] `rest-before` -> missing `Css_types.RestBefore` (packages/css-grammar/lib/Properties/Rest.ml:32)

## `packages/css-grammar/lib/Properties/Ruby.ml`

- [ ] `ruby-merge` -> missing `Css_types.RubyMerge` (packages/css-grammar/lib/Properties/Ruby.ml:37)
- [ ] `ruby-position` -> missing `Css_types.RubyPosition` (packages/css-grammar/lib/Properties/Ruby.ml:38)
- [ ] `ruby-align` -> missing `Css_types.RubyAlign` (packages/css-grammar/lib/Properties/Ruby.ml:39)
- [ ] `ruby-overhang` -> missing `Css_types.RubyOverhang` (packages/css-grammar/lib/Properties/Ruby.ml:40)

## `packages/css-grammar/lib/Properties/Scroll.ml`

- [ ] `-ms-scroll-snap-points-x` -> missing `Css_types.ScrollSnapPointsX` (packages/css-grammar/lib/Properties/Scroll.ml:690)
- [ ] `-ms-scroll-snap-points-y` -> missing `Css_types.ScrollSnapPointsY` (packages/css-grammar/lib/Properties/Scroll.ml:692)
- [ ] `scroll-snap-stop` -> missing `Css_types.ScrollSnapStop` (packages/css-grammar/lib/Properties/Scroll.ml:721)
- [ ] `scroll-margin` -> missing `Css_types.ScrollMargin` (packages/css-grammar/lib/Properties/Scroll.ml:722)
- [ ] `scroll-marker-group` -> missing `Css_types.ScrollMarkerGroup` (packages/css-grammar/lib/Properties/Scroll.ml:743)
- [ ] `scroll-padding` -> missing `Css_types.ScrollPadding` (packages/css-grammar/lib/Properties/Scroll.ml:745)
- [ ] `scroll-snap-align` -> missing `Css_types.ScrollSnapAlign` (packages/css-grammar/lib/Properties/Scroll.ml:766)
- [ ] `scroll-snap-coordinate` -> missing `Css_types.ScrollSnapCoordinate` (packages/css-grammar/lib/Properties/Scroll.ml:768)
- [ ] `scroll-snap-destination` -> missing `Css_types.ScrollSnapDestination` (packages/css-grammar/lib/Properties/Scroll.ml:770)
- [ ] `scroll-snap-points-x` -> missing `Css_types.ScrollSnapPointsX` (packages/css-grammar/lib/Properties/Scroll.ml:772)
- [ ] `scroll-snap-points-y` -> missing `Css_types.ScrollSnapPointsY` (packages/css-grammar/lib/Properties/Scroll.ml:774)
- [ ] `scroll-snap-type` -> missing `Css_types.ScrollSnapType` (packages/css-grammar/lib/Properties/Scroll.ml:776)
- [ ] `scroll-start` -> missing `Css_types.ScrollStart` (packages/css-grammar/lib/Properties/Scroll.ml:781)
- [ ] `scroll-start-block` -> missing `Css_types.ScrollStartBlock` (packages/css-grammar/lib/Properties/Scroll.ml:782)
- [ ] `scroll-start-inline` -> missing `Css_types.ScrollStartInline` (packages/css-grammar/lib/Properties/Scroll.ml:784)
- [ ] `scroll-start-target` -> missing `Css_types.ScrollStartTarget` (packages/css-grammar/lib/Properties/Scroll.ml:786)
- [ ] `scroll-start-target-block` -> missing `Css_types.ScrollStartTargetBlock` (packages/css-grammar/lib/Properties/Scroll.ml:788)
- [ ] `scroll-start-target-inline` -> missing `Css_types.ScrollStartTargetInline` (packages/css-grammar/lib/Properties/Scroll.ml:790)
- [ ] `scroll-start-target-x` -> missing `Css_types.ScrollStartTargetX` (packages/css-grammar/lib/Properties/Scroll.ml:792)
- [ ] `scroll-start-target-y` -> missing `Css_types.ScrollStartTargetY` (packages/css-grammar/lib/Properties/Scroll.ml:794)
- [ ] `scroll-start-x` -> missing `Css_types.ScrollStartX` (packages/css-grammar/lib/Properties/Scroll.ml:796)
- [ ] `scroll-start-y` -> missing `Css_types.ScrollStartY` (packages/css-grammar/lib/Properties/Scroll.ml:797)
- [ ] `scroll-timeline` -> missing `Css_types.ScrollTimeline` (packages/css-grammar/lib/Properties/Scroll.ml:800)
- [ ] `scroll-timeline-axis` -> missing `Css_types.ScrollTimelineAxis` (packages/css-grammar/lib/Properties/Scroll.ml:801)
- [ ] `scroll-timeline-name` -> missing `Css_types.ScrollTimelineName` (packages/css-grammar/lib/Properties/Scroll.ml:803)
- [ ] `scrollbar-color-legacy` -> missing `Css_types.ScrollbarColorLegacy` (packages/css-grammar/lib/Properties/Scroll.ml:806)

## `packages/css-grammar/lib/Properties/Shape.ml`

- [ ] `shape-image-threshold` -> missing `Css_types.ShapeImageThreshold` (packages/css-grammar/lib/Properties/Shape.ml:36)
- [ ] `shape-outside` -> missing `Css_types.ShapeOutside` (packages/css-grammar/lib/Properties/Shape.ml:39)
- [ ] `shape-rendering` -> missing `Css_types.ShapeRendering` (packages/css-grammar/lib/Properties/Shape.ml:40)

## `packages/css-grammar/lib/Properties/Size.ml`

- [ ] `size` -> missing `Css_types.Size` (packages/css-grammar/lib/Properties/Size.ml:14)

## `packages/css-grammar/lib/Properties/SpeakAs.ml`

- [ ] `speak-as` -> missing `Css_types.SpeakAs` (packages/css-grammar/lib/Properties/SpeakAs.ml:13)

## `packages/css-grammar/lib/Properties/Stroke.ml`

- [ ] `stroke-linecap` -> missing `Css_types.StrokeLinecap` (packages/css-grammar/lib/Properties/Stroke.ml:64)
- [ ] `stroke-linejoin` -> missing `Css_types.StrokeLinejoin` (packages/css-grammar/lib/Properties/Stroke.ml:65)
- [ ] `stroke-dashoffset` -> missing `Css_types.StrokeDashoffset` (packages/css-grammar/lib/Properties/Stroke.ml:69)
- [ ] `stroke-miterlimit` -> missing `Css_types.StrokeMiterlimit` (packages/css-grammar/lib/Properties/Stroke.ml:71)
- [ ] `stroke-opacity` -> missing `Css_types.StrokeOpacity` (packages/css-grammar/lib/Properties/Stroke.ml:73)
- [ ] `stroke-width` -> missing `Css_types.StrokeWidth` (packages/css-grammar/lib/Properties/Stroke.ml:74)

## `packages/css-grammar/lib/Properties/Syntax.ml`

- [ ] `syntax` -> missing `Css_types.Syntax` (packages/css-grammar/lib/Properties/Syntax.ml:8)

## `packages/css-grammar/lib/Properties/Text.ml`

- [ ] `-ms-text-autospace` -> missing `Css_types.TextAutospace` (packages/css-grammar/lib/Properties/Text.ml:372)
- [ ] `text-rendering` -> missing `Css_types.TextRendering` (packages/css-grammar/lib/Properties/Text.ml:374)
- [ ] `text-orientation` -> missing `Css_types.TextOrientation` (packages/css-grammar/lib/Properties/Text.ml:375)
- [ ] `text-underline-position` -> missing `Css_types.TextUnderlinePosition` (packages/css-grammar/lib/Properties/Text.ml:388)
- [ ] `text-anchor` -> missing `Css_types.TextAnchor` (packages/css-grammar/lib/Properties/Text.ml:391)
- [ ] `text-autospace` -> missing `Css_types.TextAutospace` (packages/css-grammar/lib/Properties/Text.ml:392)
- [ ] `text-blink` -> missing `Css_types.TextBlink` (packages/css-grammar/lib/Properties/Text.ml:393)
- [ ] `text-box-edge` -> missing `Css_types.TextBoxEdge` (packages/css-grammar/lib/Properties/Text.ml:395)
- [ ] `text-box-trim` -> missing `Css_types.TextBoxTrim` (packages/css-grammar/lib/Properties/Text.ml:396)
- [ ] `text-combine-upright` -> missing `Css_types.TextCombineUpright` (packages/css-grammar/lib/Properties/Text.ml:397)
- [ ] `text-decoration-skip` -> missing `Css_types.TextDecorationSkip` (packages/css-grammar/lib/Properties/Text.ml:404)
- [ ] `text-decoration-skip-self` -> missing `Css_types.TextDecorationSkipSelf` (packages/css-grammar/lib/Properties/Text.ml:410)
- [ ] `text-decoration-skip-spaces` -> missing `Css_types.TextDecorationSkipSpaces` (packages/css-grammar/lib/Properties/Text.ml:412)
- [ ] `text-edge` -> missing `Css_types.TextEdge` (packages/css-grammar/lib/Properties/Text.ml:414)
- [ ] `text-emphasis` -> missing `Css_types.TextEmphasis` (packages/css-grammar/lib/Properties/Text.ml:415)
- [ ] `text-indent` -> missing `Css_types.TextIndent` (packages/css-grammar/lib/Properties/Text.ml:422)
- [ ] `text-justify-trim` -> missing `Css_types.TextJustifyTrim` (packages/css-grammar/lib/Properties/Text.ml:423)
- [ ] `text-kashida` -> missing `Css_types.TextKashida` (packages/css-grammar/lib/Properties/Text.ml:425)
- [ ] `text-kashida-space` -> missing `Css_types.TextKashidaSpace` (packages/css-grammar/lib/Properties/Text.ml:426)
- [ ] `text-size-adjust` -> missing `Css_types.TextSizeAdjust` (packages/css-grammar/lib/Properties/Text.ml:430)
- [ ] `text-spacing-trim` -> missing `Css_types.TextSpacingTrim` (packages/css-grammar/lib/Properties/Text.ml:431)
- [ ] `text-underline-offset` -> missing `Css_types.TextUnderlineOffset` (packages/css-grammar/lib/Properties/Text.ml:433)
- [ ] `text-wrap` -> missing `Css_types.TextWrap` (packages/css-grammar/lib/Properties/Text.ml:435)
- [ ] `text-wrap-mode` -> missing `Css_types.TextWrapMode` (packages/css-grammar/lib/Properties/Text.ml:436)
- [ ] `text-wrap-style` -> missing `Css_types.TextWrapStyle` (packages/css-grammar/lib/Properties/Text.ml:437)

## `packages/css-grammar/lib/Properties/TimelineScope.ml`

- [ ] `timeline-scope` -> missing `Css_types.TimelineScope` (packages/css-grammar/lib/Properties/TimelineScope.ml:34)

## `packages/css-grammar/lib/Properties/Transition.ml`

- [ ] `transition-property` -> missing `Css_types.TransitionProperty` (packages/css-grammar/lib/Properties/Transition.ml:57)

## `packages/css-grammar/lib/Properties/UnicodeBidi.ml`

- [ ] `unicode-bidi` -> missing `Css_types.UnicodeBidi` (packages/css-grammar/lib/Properties/UnicodeBidi.ml:15)

## `packages/css-grammar/lib/Properties/VectorEffect.ml`

- [ ] `vector-effect` -> missing `Css_types.VectorEffect` (packages/css-grammar/lib/Properties/VectorEffect.ml:14)

## `packages/css-grammar/lib/Properties/View.ml`

- [ ] `view-transition-name` -> missing `Css_types.ViewTransitionName` (packages/css-grammar/lib/Properties/View.ml:51)
- [ ] `view-timeline` -> missing `Css_types.ViewTimeline` (packages/css-grammar/lib/Properties/View.ml:53)
- [ ] `view-timeline-axis` -> missing `Css_types.ViewTimelineAxis` (packages/css-grammar/lib/Properties/View.ml:54)
- [ ] `view-timeline-inset` -> missing `Css_types.ViewTimelineInset` (packages/css-grammar/lib/Properties/View.ml:56)
- [ ] `view-timeline-name` -> missing `Css_types.ViewTimelineName` (packages/css-grammar/lib/Properties/View.ml:58)

## `packages/css-grammar/lib/Properties/Voice.ml`

- [ ] `voice-balance` -> missing `Css_types.VoiceBalance` (packages/css-grammar/lib/Properties/Voice.ml:75)
- [ ] `voice-duration` -> missing `Css_types.VoiceDuration` (packages/css-grammar/lib/Properties/Voice.ml:76)
- [ ] `voice-family` -> missing `Css_types.VoiceFamily` (packages/css-grammar/lib/Properties/Voice.ml:77)
- [ ] `voice-pitch` -> missing `Css_types.VoicePitch` (packages/css-grammar/lib/Properties/Voice.ml:78)
- [ ] `voice-range` -> missing `Css_types.VoiceRange` (packages/css-grammar/lib/Properties/Voice.ml:79)
- [ ] `voice-rate` -> missing `Css_types.VoiceRate` (packages/css-grammar/lib/Properties/Voice.ml:80)
- [ ] `voice-stress` -> missing `Css_types.VoiceStress` (packages/css-grammar/lib/Properties/Voice.ml:81)
- [ ] `voice-volume` -> missing `Css_types.VoiceVolume` (packages/css-grammar/lib/Properties/Voice.ml:82)

## `packages/css-grammar/lib/Properties/Webkit.ml`

- [ ] `-webkit-appearance` -> missing `Css_types.WebkitAppearance` (packages/css-grammar/lib/Properties/Webkit.ml:335)
- [ ] `-webkit-background-clip` -> missing `Css_types.WebkitBackgroundClip` (packages/css-grammar/lib/Properties/Webkit.ml:337)
- [ ] `-webkit-border-before` -> missing `Css_types.WebkitBorderBefore` (packages/css-grammar/lib/Properties/Webkit.ml:339)
- [ ] `-webkit-border-before-style` -> missing `Css_types.WebkitBorderBeforeStyle` (packages/css-grammar/lib/Properties/Webkit.ml:341)
- [ ] `-webkit-border-before-width` -> missing `Css_types.WebkitBorderBeforeWidth` (packages/css-grammar/lib/Properties/Webkit.ml:343)
- [ ] `-webkit-box-reflect` -> missing `Css_types.WebkitBoxReflect` (packages/css-grammar/lib/Properties/Webkit.ml:345)
- [ ] `-webkit-column-break-after` -> missing `Css_types.WebkitColumnBreakAfter` (packages/css-grammar/lib/Properties/Webkit.ml:347)
- [ ] `-webkit-column-break-before` -> missing `Css_types.WebkitColumnBreakBefore` (packages/css-grammar/lib/Properties/Webkit.ml:349)
- [ ] `-webkit-column-break-inside` -> missing `Css_types.WebkitColumnBreakInside` (packages/css-grammar/lib/Properties/Webkit.ml:351)
- [ ] `-webkit-line-clamp` -> missing `Css_types.WebkitLineClamp` (packages/css-grammar/lib/Properties/Webkit.ml:353)
- [ ] `-webkit-mask` -> missing `Css_types.WebkitMask` (packages/css-grammar/lib/Properties/Webkit.ml:355)
- [ ] `-webkit-mask-attachment` -> missing `Css_types.WebkitMaskAttachment` (packages/css-grammar/lib/Properties/Webkit.ml:356)
- [ ] `-webkit-mask-box-image` -> missing `Css_types.WebkitMaskBoxImage` (packages/css-grammar/lib/Properties/Webkit.ml:358)
- [ ] `-webkit-mask-clip` -> missing `Css_types.WebkitMaskClip` (packages/css-grammar/lib/Properties/Webkit.ml:360)
- [ ] `-webkit-mask-composite` -> missing `Css_types.WebkitMaskComposite` (packages/css-grammar/lib/Properties/Webkit.ml:362)
- [ ] `-webkit-mask-image` -> missing `Css_types.WebkitMaskImage` (packages/css-grammar/lib/Properties/Webkit.ml:364)
- [ ] `-webkit-mask-origin` -> missing `Css_types.WebkitMaskOrigin` (packages/css-grammar/lib/Properties/Webkit.ml:366)
- [ ] `-webkit-mask-position` -> missing `Css_types.WebkitMaskPosition` (packages/css-grammar/lib/Properties/Webkit.ml:368)
- [ ] `-webkit-mask-position-x` -> missing `Css_types.WebkitMaskPositionX` (packages/css-grammar/lib/Properties/Webkit.ml:370)
- [ ] `-webkit-mask-position-y` -> missing `Css_types.WebkitMaskPositionY` (packages/css-grammar/lib/Properties/Webkit.ml:372)
- [ ] `-webkit-mask-repeat` -> missing `Css_types.WebkitMaskRepeat` (packages/css-grammar/lib/Properties/Webkit.ml:374)
- [ ] `-webkit-mask-repeat-x` -> missing `Css_types.WebkitMaskRepeatX` (packages/css-grammar/lib/Properties/Webkit.ml:376)
- [ ] `-webkit-mask-repeat-y` -> missing `Css_types.WebkitMaskRepeatY` (packages/css-grammar/lib/Properties/Webkit.ml:378)
- [ ] `-webkit-mask-size` -> missing `Css_types.WebkitMaskSize` (packages/css-grammar/lib/Properties/Webkit.ml:380)
- [ ] `-webkit-overflow-scrolling` -> missing `Css_types.WebkitOverflowScrolling` (packages/css-grammar/lib/Properties/Webkit.ml:382)
- [ ] `-webkit-text-security` -> missing `Css_types.WebkitTextSecurity` (packages/css-grammar/lib/Properties/Webkit.ml:384)
- [ ] `-webkit-text-stroke` -> missing `Css_types.WebkitTextStroke` (packages/css-grammar/lib/Properties/Webkit.ml:386)
- [ ] `-webkit-touch-callout` -> missing `Css_types.WebkitTouchCallout` (packages/css-grammar/lib/Properties/Webkit.ml:390)
- [ ] `-webkit-user-drag` -> missing `Css_types.WebkitUserDrag` (packages/css-grammar/lib/Properties/Webkit.ml:392)
- [ ] `-webkit-user-modify` -> missing `Css_types.WebkitUserModify` (packages/css-grammar/lib/Properties/Webkit.ml:394)
- [ ] `-webkit-user-select` -> missing `Css_types.WebkitUserSelect` (packages/css-grammar/lib/Properties/Webkit.ml:396)
- [ ] `-webkit-font-smoothing` -> missing `Css_types.WebkitFontSmoothing` (packages/css-grammar/lib/Properties/Webkit.ml:402)
- [ ] `-webkit-border-before-color` -> missing `Css_types.WebkitBorderBeforeColor` (packages/css-grammar/lib/Properties/Webkit.ml:404)
- [ ] `-webkit-print-color-adjust` -> missing `Css_types.WebkitPrintColorAdjust` (packages/css-grammar/lib/Properties/Webkit.ml:406)

## `packages/css-grammar/lib/Properties/WhiteSpaceCollapse.ml`

- [ ] `white-space-collapse` -> missing `Css_types.WhiteSpaceCollapse` (packages/css-grammar/lib/Properties/WhiteSpaceCollapse.ml:15)

## `packages/css-grammar/lib/Properties/Widows.ml`

- [ ] `widows` -> missing `Css_types.Widows` (packages/css-grammar/lib/Properties/Widows.ml:8)

## `packages/css-grammar/lib/Properties/WillChange.ml`

- [ ] `will-change` -> missing `Css_types.WillChange` (packages/css-grammar/lib/Properties/WillChange.ml:12)

## `packages/css-grammar/lib/Properties/WordWrap.ml`

- [ ] `word-wrap` -> missing `Css_types.WordWrap` (packages/css-grammar/lib/Properties/WordWrap.ml:11)

## `packages/css-grammar/lib/Properties/Wrap.ml`

- [ ] `-ms-wrap-margin` -> missing `Css_types.ShapeMargin` (packages/css-grammar/lib/Properties/Wrap.ml:26)

## `packages/css-grammar/lib/Properties/WritingMode.ml`

- [ ] `writing-mode` -> missing `Css_types.WritingMode` (packages/css-grammar/lib/Properties/WritingMode.ml:23)

## `packages/css-grammar/lib/Properties/Zoom.ml`

- [ ] `zoom` -> missing `Css_types.Zoom` (packages/css-grammar/lib/Properties/Zoom.ml:12)
