# Unsupported Runtime Audit

Scope: `%css` runtime lowering and `CSS.unsafe` fallbacks. This audit does not treat `%cx2` extraction failures as unsupported unless the generated snapshots still prove an unsafe fallback or runtime gap.

## Method

1. Scan checked-in `run.t` snapshots under `packages/ppx/test/css-support` and `packages/ppx/test/cx2-support` for `CSS.unsafe(...)` to capture properties already proven unsupported in current tests.
2. Scan checked-in `input.re` fixtures under those same directories and diff the covered declaration names against `packages/css-grammar/lib/Properties/*.ml`, excluding `Media.ml`, `Descriptors.ml`, and `CustomProperty.ml`, to find properties with no current cram coverage.
3. For uncovered standard properties with a simple auto-generated sample value, run a temporary `%css` probe under `packages/tmp_unsupported_audit` and classify the result as typed, `CSS.unsafe`, missing runtime binding, compile failure, or no sample.

## Summary

- Properties in scope: `720`
- Covered by `%css` cram inputs: `438`
- Covered by `%cx2` cram inputs: `447`
- Covered by either `%css` or `%cx2`: `450`
- Uncovered by current cram inputs: `270`
- Distinct properties currently proven `CSS.unsafe` in checked-in snapshots: `108`
- Supplemental standard-property probes: `159`
- Supplemental probes lowering cleanly: `13`
- Supplemental probes lowering to `CSS.unsafe`: `133`
- Supplemental probes hitting missing runtime bindings: `1`
- Supplemental probes failing with an inconclusive sample: `2`
- Supplemental probes skipped because no simple sample was generated: `10`

## Proven Unsupported In Current Cram Snapshots

- In both `%css` and `%cx2`: `3`
- In `%css` only: `105`
- In `%cx2` only: `0`

### In Both `%css` And `%cx2`

- `container`: `packages/ppx/test/css-support/container-queries-module.t/run.t`, `packages/ppx/test/css-support/containment-module.t/run.t`, `packages/ppx/test/cx2-support/containment-module.t/run.t`
- `container-name`: `packages/ppx/test/css-support/container-queries-module.t/run.t`, `packages/ppx/test/css-support/containment-module.t/run.t`, `packages/ppx/test/cx2-support/containment-module.t/run.t`
- `container-type`: `packages/ppx/test/css-support/container-queries-module.t/run.t`, `packages/ppx/test/css-support/containment-module.t/run.t`, `packages/ppx/test/cx2-support/containment-module.t/run.t`

### In `%css` Only

- `-moz-appearance`: `packages/ppx/test/css-support/random.t/run.t`
- `-webkit-appearance`: `packages/ppx/test/css-support/random.t/run.t`
- `-webkit-box-orient`: `packages/ppx/test/css-support/random.t/run.t`
- `-webkit-line-clamp`: `packages/ppx/test/css-support/random.t/run.t`
- `-webkit-overflow-scrolling`: `packages/ppx/test/css-support/random.t/run.t`
- `-webkit-text-fill-color`: `packages/ppx/test/css-support/random.t/run.t`
- `accent-color`: `packages/ppx/test/css-support/modern-layout-properties.t/run.t`
- `background-color`: `packages/ppx/test/css-support/color-module.t/run.t`
- `background-image`: `packages/ppx/test/css-support/cascading-and-inheritance.t/run.t`, `packages/ppx/test/css-support/frequency-resolution-units.t/run.t`
- `background-position-x`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `background-position-y`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `border`: `packages/ppx/test/css-support/random.t/run.t`
- `border-block`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-block-end`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-block-start`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-bottom-left-radius`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `border-bottom-right-radius`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `border-color`: `packages/ppx/test/css-support/color-module.t/run.t`
- `border-end-end-radius`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-end-start-radius`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-image`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `border-inline`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-inline-end`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-inline-start`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-start-end-radius`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-start-start-radius`: `packages/ppx/test/css-support/logical-propertiesand-values.t/run.t`
- `border-top-left-radius`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `border-top-right-radius`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `bottom`: `packages/ppx/test/css-support/random.t/run.t`
- `clip-path`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `clip-rule`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `color`: `packages/ppx/test/css-support/cascading-and-inheritance.t/run.t`, `packages/ppx/test/css-support/color-module.t/run.t`, `packages/ppx/test/css-support/random.t/run.t`
- `column-rule`: `packages/ppx/test/css-support/multi-column-layout-module.t/run.t`
- `column-rule-color`: `packages/ppx/test/css-support/color-module.t/run.t`
- `columns`: `packages/ppx/test/css-support/multi-column-layout-module.t/run.t`
- `contain`: `packages/ppx/test/css-support/containment-module.t/run.t`
- `content`: `packages/ppx/test/css-support/content.t/run.t`
- `flex`: `packages/ppx/test/css-support/flex.t/run.t`
- `font-feature-settings`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-language-override`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-palette`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-size`: `packages/ppx/test/css-support/missing-length-units.t/run.t`
- `font-size-adjust`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-stretch`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-style`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-synthesis`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-variant`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-variant-alternates`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-variant-east-asian`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-variant-ligatures`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-variant-numeric`: `packages/ppx/test/css-support/fonts-module.t/run.t`
- `font-weight`: `packages/ppx/test/css-support/cascading-and-inheritance.t/run.t`
- `grid-column`: `packages/ppx/test/css-support/random.t/run.t`
- `grid-row`: `packages/ppx/test/css-support/random.t/run.t`
- `height`: `packages/ppx/test/css-support/random.t/run.t`, `packages/ppx/test/css-support/box-sizing-module.t/run.t`, `packages/ppx/test/css-support/missing-length-units.t/run.t`
- `justify-self`: `packages/ppx/test/css-support/random.t/run.t`
- `left`: `packages/ppx/test/css-support/random.t/run.t`
- `line-height`: `packages/ppx/test/css-support/missing-length-units.t/run.t`
- `margin`: `packages/ppx/test/css-support/missing-length-units.t/run.t`
- `margin-trim`: `packages/ppx/test/css-support/box-alignment-module.t/run.t`
- `mask`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border-outset`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border-repeat`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border-slice`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border-source`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-border-width`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-clip`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-composite`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-image`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-mode`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-origin`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-repeat`: `packages/ppx/test/css-support/random.t/run.t`, `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-size`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `mask-type`: `packages/ppx/test/css-support/masking-module.t/run.t`
- `max-height`: `packages/ppx/test/css-support/box-sizing-module.t/run.t`
- `max-width`: `packages/ppx/test/css-support/box-sizing-module.t/run.t`
- `min-height`: `packages/ppx/test/css-support/flexible-box-layout-module.t/run.t`, `packages/ppx/test/css-support/box-sizing-module.t/run.t`
- `min-width`: `packages/ppx/test/css-support/flexible-box-layout-module.t/run.t`, `packages/ppx/test/css-support/box-sizing-module.t/run.t`
- `object-position`: `packages/ppx/test/css-support/backgrounds-and-borders-module.t/run.t`
- `offset`: `packages/ppx/test/css-support/motion-path-module.t/run.t`
- `offset-path`: `packages/ppx/test/css-support/motion-path-module.t/run.t`
- `offset-position`: `packages/ppx/test/css-support/motion-path-module.t/run.t`
- `offset-rotate`: `packages/ppx/test/css-support/motion-path-module.t/run.t`
- `outline`: `packages/ppx/test/css-support/random.t/run.t`
- `padding`: `packages/ppx/test/css-support/missing-length-units.t/run.t`
- `place-content`: `packages/ppx/test/css-support/modern-layout-properties.t/run.t`, `packages/ppx/test/css-support/box-alignment-module.t/run.t`
- `place-items`: `packages/ppx/test/css-support/modern-layout-properties.t/run.t`, `packages/ppx/test/css-support/box-alignment-module.t/run.t`
- `place-self`: `packages/ppx/test/css-support/modern-layout-properties.t/run.t`
- `position`: `packages/ppx/test/css-support/random.t/run.t`
- `quotes`: `packages/ppx/test/css-support/content.t/run.t`
- `scroll-margin`: `packages/ppx/test/css-support/scroll-snap-module.t/run.t`
- `scroll-padding`: `packages/ppx/test/css-support/scroll-snap-module.t/run.t`
- `text-decoration-color`: `packages/ppx/test/css-support/color-module.t/run.t`
- `text-decoration-skip`: `packages/ppx/test/css-support/text-decoration.t/run.t`
- `text-decoration-thickness`: `packages/ppx/test/css-support/text-decoration.t/run.t`
- `text-emphasis`: `packages/ppx/test/css-support/text-decoration.t/run.t`
- `text-underline-offset`: `packages/ppx/test/css-support/text-decoration.t/run.t`
- `text-underline-position`: `packages/ppx/test/css-support/text-decoration.t/run.t`
- `top`: `packages/ppx/test/css-support/random.t/run.t`
- `touch-action`: `packages/ppx/test/css-support/pointer-events.t/run.t`, `packages/ppx/test/css-support/modern-layout-properties.t/run.t`, `packages/ppx/test/css-support/random.t/run.t`
- `transform`: `packages/ppx/test/css-support/transforms-module.t/run.t`
- `transition-timing-function`: `packages/ppx/test/css-support/easing-functions.t/run.t`
- `width`: `packages/ppx/test/css-support/values-and-units-module.t/run.t`, `packages/ppx/test/css-support/random.t/run.t`, `packages/ppx/test/css-support/missing-length-units.t/run.t`, `packages/ppx/test/css-support/cascading-and-inheritance.t/run.t`, `packages/ppx/test/css-support/box-sizing-module.t/run.t`
- `will-change`: `packages/ppx/test/css-support/will-change-module.t/run.t`

## Supplemental Probe: Additional Unsupported Standard Properties

These properties were not covered by the current checked-in cram fixtures, but a simple `%css` probe still lowered them to `CSS.unsafe` in this pass.

### `packages/css-grammar/lib/Properties/AlignmentBaseline.ml`

- `alignment-baseline` with sample `auto`

### `packages/css-grammar/lib/Properties/AnchorName.ml`

- `anchor-name` with sample `none`

### `packages/css-grammar/lib/Properties/AnchorScope.ml`

- `anchor-scope` with sample `none`

### `packages/css-grammar/lib/Properties/Animation.ml`

- `animation-composition` with sample `replace`
- `animation-range` with sample `10px`
- `animation-range-end` with sample `10px`
- `animation-range-start` with sample `10px`
- `animation-timeline` with sample `foo`

### `packages/css-grammar/lib/Properties/BaselineShift.ml`

- `baseline-shift` with sample `baseline`

### `packages/css-grammar/lib/Properties/BaselineSource.ml`

- `baseline-source` with sample `auto`

### `packages/css-grammar/lib/Properties/BlockOverflow.ml`

- `block-overflow` with sample `"x"`

### `packages/css-grammar/lib/Properties/Border.ml`

- `border-spacing` with sample `10px`

### `packages/css-grammar/lib/Properties/Box.ml`

- `box-align` with sample `start`
- `box-direction` with sample `normal`
- `box-flex` with sample `1`
- `box-flex-group` with sample `1`
- `box-lines` with sample `single`
- `box-ordinal-group` with sample `1`
- `box-orient` with sample `horizontal`
- `box-pack` with sample `start`

### `packages/css-grammar/lib/Properties/Caret.ml`

- `caret-animation` with sample `auto`

### `packages/css-grammar/lib/Properties/Column.ml`

- `column-height` with sample `10px`
- `column-wrap` with sample `auto`

### `packages/css-grammar/lib/Properties/DominantBaseline.ml`

- `dominant-baseline` with sample `auto`

### `packages/css-grammar/lib/Properties/Font.ml`

- `font-display` with sample `auto`
- `font-smooth` with sample `10px`
- `font-width` with sample `10%`

### `packages/css-grammar/lib/Properties/Glyph.ml`

- `glyph-orientation-horizontal` with sample `45deg`
- `glyph-orientation-vertical` with sample `45deg`

### `packages/css-grammar/lib/Properties/Image.ml`

- `image-orientation` with sample `45deg`

### `packages/css-grammar/lib/Properties/Ime.ml`

- `ime-mode` with sample `auto`

### `packages/css-grammar/lib/Properties/Inset.ml`

- `inset-area` with sample `none`

### `packages/css-grammar/lib/Properties/Interactivity.ml`

- `interactivity` with sample `auto`

### `packages/css-grammar/lib/Properties/Interest.ml`

- `interest-delay` with sample `normal`
- `interest-delay-end` with sample `normal`
- `interest-delay-start` with sample `normal`

### `packages/css-grammar/lib/Properties/Layout.ml`

- `layout-grid` with sample `1`
- `layout-grid-char` with sample `"x"`
- `layout-grid-line` with sample `"x"`
- `layout-grid-mode` with sample `"x"`
- `layout-grid-type` with sample `"x"`

### `packages/css-grammar/lib/Properties/Legacy.ml`

- `azimuth` with sample `45deg`
- `behavior` with sample `url("a.png")`
- `clip` with sample `auto`
- `container-name-computed` with sample `foo`
- `cue` with sample `cue-before`
- `cue-after` with sample `url("a.png")`
- `cue-before` with sample `url("a.png")`
- `kerning` with sample `auto`
- `speak` with sample `auto`
- `word-space-transform` with sample `none`

### `packages/css-grammar/lib/Properties/ListProperties.ml`

- `list-style` with sample `list-style-type`

### `packages/css-grammar/lib/Properties/Mask.ml`

- `mask-border-mode` with sample `luminance`

### `packages/css-grammar/lib/Properties/Overflow.ml`

- `overflow-clip-box` with sample `padding-box`

### `packages/css-grammar/lib/Properties/Overlay.ml`

- `overlay` with sample `none`

### `packages/css-grammar/lib/Properties/Page.ml`

- `page-break-after` with sample `auto`
- `page-break-before` with sample `auto`
- `page-break-inside` with sample `auto`

### `packages/css-grammar/lib/Properties/Pause.ml`

- `pause` with sample `pause-before`
- `pause-after` with sample `none`
- `pause-before` with sample `none`

### `packages/css-grammar/lib/Properties/Position.ml`

- `position-anchor` with sample `auto`
- `position-area` with sample `none`
- `position-try` with sample `none`
- `position-try-fallbacks` with sample `none`
- `position-try-options` with sample `none`
- `position-try-order` with sample `normal`
- `position-visibility` with sample `always`

### `packages/css-grammar/lib/Properties/PrintColorAdjust.ml`

- `print-color-adjust` with sample `economy`

### `packages/css-grammar/lib/Properties/ReadingFlow.ml`

- `reading-flow` with sample `normal`

### `packages/css-grammar/lib/Properties/ReadingOrder.ml`

- `reading-order` with sample `1`

### `packages/css-grammar/lib/Properties/Rest.ml`

- `rest` with sample `rest-before`
- `rest-after` with sample `none`
- `rest-before` with sample `none`

### `packages/css-grammar/lib/Properties/Ruby.ml`

- `ruby-overhang` with sample `none`

### `packages/css-grammar/lib/Properties/Scroll.ml`

- `scroll-initial-target` with sample `none`
- `scroll-marker-group` with sample `none`
- `scroll-snap-coordinate` with sample `center`
- `scroll-snap-destination` with sample `center`
- `scroll-snap-points-x` with sample `10px`
- `scroll-snap-points-y` with sample `10px`
- `scroll-snap-type-x` with sample `none`
- `scroll-snap-type-y` with sample `none`
- `scroll-start` with sample `10px`
- `scroll-start-block` with sample `10px`
- `scroll-start-inline` with sample `10px`
- `scroll-start-target` with sample `auto`
- `scroll-start-target-block` with sample `auto`
- `scroll-start-target-inline` with sample `auto`
- `scroll-start-target-x` with sample `auto`
- `scroll-start-target-y` with sample `auto`
- `scroll-start-x` with sample `10px`
- `scroll-start-y` with sample `10px`
- `scroll-target-group` with sample `none`
- `scroll-timeline` with sample `foo`
- `scroll-timeline-axis` with sample `block`
- `scroll-timeline-name` with sample `foo`
- `scrollbar-color-legacy` with sample `red`

### `packages/css-grammar/lib/Properties/Size.ml`

- `size` with sample `10px`

### `packages/css-grammar/lib/Properties/SpeakAs.ml`

- `speak-as` with sample `normal`

### `packages/css-grammar/lib/Properties/Syntax.ml`

- `syntax` with sample `"x"`

### `packages/css-grammar/lib/Properties/Text.ml`

- `text-autospace` with sample `none`
- `text-blink` with sample `none`
- `text-box` with sample `normal`
- `text-box-edge` with sample `leading`
- `text-box-trim` with sample `none`
- `text-decoration-inset` with sample `10px`
- `text-decoration-skip-self` with sample `none`
- `text-decoration-skip-spaces` with sample `none`
- `text-edge` with sample `leading`
- `text-justify-trim` with sample `none`
- `text-kashida` with sample `none`
- `text-kashida-space` with sample `normal`
- `text-size-adjust` with sample `10%`
- `text-spacing-trim` with sample `normal`

### `packages/css-grammar/lib/Properties/TimelineScope.ml`

- `timeline-scope` with sample `foo`
- `timeline-trigger-name` with sample `none`
- `trigger-scope` with sample `none`

### `packages/css-grammar/lib/Properties/View.ml`

- `view-timeline` with sample `foo`
- `view-timeline-axis` with sample `block`
- `view-timeline-inset` with sample `auto`
- `view-timeline-name` with sample `none`
- `view-transition-class` with sample `foo`
- `view-transition-name` with sample `none`

### `packages/css-grammar/lib/Properties/Voice.ml`

- `voice-balance` with sample `1`
- `voice-duration` with sample `auto`
- `voice-family` with sample `,`
- `voice-pitch` with sample `10%`
- `voice-range` with sample `10%`
- `voice-rate` with sample `10%`
- `voice-stress` with sample `normal`
- `voice-volume` with sample `silent`

### `packages/css-grammar/lib/Properties/WhiteSpaceCollapse.ml`

- `white-space-collapse` with sample `collapse`

## Supplemental Probe: Newly Proved Typed

These properties were uncovered by current cram inputs but lowered without `CSS.unsafe` in the supplemental probe, so they are good candidates for adding targeted cram coverage.

- `border-bottom-color` with sample `red` from `packages/css-grammar/lib/Properties/Border.ml`
- `border-left-color` with sample `red` from `packages/css-grammar/lib/Properties/Border.ml`
- `border-right-color` with sample `red` from `packages/css-grammar/lib/Properties/Border.ml`
- `border-top-color` with sample `red` from `packages/css-grammar/lib/Properties/Border.ml`
- `backdrop-blur` with sample `10px` from `packages/css-grammar/lib/Properties/Legacy.ml`
- `scrollbar-3dlight-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-arrow-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-base-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-darkshadow-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-face-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-highlight-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-shadow-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`
- `scrollbar-track-color` with sample `red` from `packages/css-grammar/lib/Properties/Scroll.ml`

## Supplemental Probe: Compile-Time Runtime Gaps

- `zoom` with sample `1`: `Error: Unbound value CSS.zoom`
- `font` with sample `font-style`: `       'caption', 'icon', etc.`
- `font-variation-settings` with sample `1`: `       Expected 'string', 'value', or 'normal'.`

## Still Uncovered And Not Probed Cleanly

Two groups remain after the supplemental pass:

- Vendor-prefixed or wildcard properties still uncovered and not probed in this pass: `111`
- Standard uncovered properties with no simple generated sample: `10`

### Remaining Vendor/Wildcard Coverage Gaps

- `packages/css-grammar/lib/Properties/Moz.ml`: `-moz-background-clip`, `-moz-binding`, `-moz-border-bottom-colors`, `-moz-border-left-colors`, `-moz-border-radius-bottomleft`, `-moz-border-radius-bottomright`, `-moz-border-radius-topleft`, `-moz-border-radius-topright`, `-moz-border-right-colors`, `-moz-border-top-colors`, `-moz-context-properties`, `-moz-control-character-visibility`, `-moz-float-edge`, `-moz-force-broken-image-icon`, `-moz-image-region`, `-moz-orient`, `-moz-osx-font-smoothing`, `-moz-outline-radius`, `-moz-outline-radius-bottomleft`, `-moz-outline-radius-bottomright`, `-moz-outline-radius-topleft`, `-moz-outline-radius-topright`, `-moz-stack-sizing`, `-moz-text-blink`, `-moz-user-focus`, `-moz-user-input`, `-moz-user-modify`, `-moz-user-select`, `-moz-window-dragging`, `-moz-window-shadow`
- `packages/css-grammar/lib/Properties/Interactivity.ml`: `-ms-accelerator`
- `packages/css-grammar/lib/Properties/WritingMode.ml`: `-ms-block-progression`
- `packages/css-grammar/lib/Properties/Scroll.ml`: `-ms-content-zoom-chaining`, `-ms-content-zoom-limit`, `-ms-content-zoom-limit-max`, `-ms-content-zoom-limit-min`, `-ms-content-zoom-snap`, `-ms-content-zoom-snap-points`, `-ms-content-zoom-snap-type`, `-ms-content-zooming`, `-ms-scroll-chaining`, `-ms-scroll-limit`, `-ms-scroll-limit-x-max`, `-ms-scroll-limit-x-min`, `-ms-scroll-limit-y-max`, `-ms-scroll-limit-y-min`, `-ms-scroll-rails`, `-ms-scroll-snap-points-x`, `-ms-scroll-snap-points-y`, `-ms-scroll-snap-type`, `-ms-scroll-snap-x`, `-ms-scroll-snap-y`, `-ms-scroll-translation`, `-ms-scrollbar-3dlight-color`, `-ms-scrollbar-arrow-color`, `-ms-scrollbar-base-color`, `-ms-scrollbar-darkshadow-color`, `-ms-scrollbar-face-color`, `-ms-scrollbar-highlight-color`, `-ms-scrollbar-shadow-color`, `-ms-scrollbar-track-color`
- `packages/css-grammar/lib/Properties/Filter.ml`: `-ms-filter`
- `packages/css-grammar/lib/Properties/Flow.ml`: `-ms-flow-from`, `-ms-flow-into`
- `packages/css-grammar/lib/Properties/Grid.ml`: `-ms-grid-columns`, `-ms-grid-rows`
- `packages/css-grammar/lib/Properties/ForcedColorAdjust.ml`: `-ms-high-contrast-adjust`
- `packages/css-grammar/lib/Properties/HyphenateLimitChars.ml`: `-ms-hyphenate-limit-chars`
- `packages/css-grammar/lib/Properties/HyphenateLimit.ml`: `-ms-hyphenate-limit-lines`, `-ms-hyphenate-limit-zone`
- `packages/css-grammar/lib/Properties/Ime.ml`: `-ms-ime-align`
- `packages/css-grammar/lib/Properties/Overflow.ml`: `-ms-overflow-style`
- `packages/css-grammar/lib/Properties/Text.ml`: `-ms-text-autospace`
- `packages/css-grammar/lib/Properties/UserSelect.ml`: `-ms-touch-select`, `-ms-user-select`
- `packages/css-grammar/lib/Properties/Wrap.ml`: `-ms-wrap-flow`, `-ms-wrap-margin`, `-ms-wrap-through`
- `packages/css-grammar/lib/Properties/Webkit.ml`: `-webkit-background-clip`, `-webkit-border-before`, `-webkit-border-before-color`, `-webkit-border-before-style`, `-webkit-border-before-width`, `-webkit-box-reflect`, `-webkit-column-break-after`, `-webkit-column-break-before`, `-webkit-column-break-inside`, `-webkit-font-smoothing`, `-webkit-mask`, `-webkit-mask-attachment`, `-webkit-mask-box-image`, `-webkit-mask-clip`, `-webkit-mask-composite`, `-webkit-mask-image`, `-webkit-mask-origin`, `-webkit-mask-position`, `-webkit-mask-position-x`, `-webkit-mask-position-y`, `-webkit-mask-repeat`, `-webkit-mask-repeat-x`, `-webkit-mask-repeat-y`, `-webkit-mask-size`, `-webkit-print-color-adjust`, `-webkit-text-security`, `-webkit-text-stroke`, `-webkit-text-stroke-color`, `-webkit-text-stroke-width`, `-webkit-touch-callout`, `-webkit-user-drag`, `-webkit-user-modify`, `-webkit-user-select`

### Standard Properties With No Simple Auto-Sample

- `packages/css-grammar/lib/Properties/Animation.ml`: `animation-delay-end`, `animation-delay-start`, `animation-trigger`
- `packages/css-grammar/lib/Properties/Border.ml`: `border-bottom-style`, `border-left-style`, `border-left-width`, `border-right-style`, `border-right-width`, `border-top-style`, `border-top-width`

## Notes

- `CSS.unsafe` in `%css` usually means the grammar accepts the property, but `packages/ppx/src/Property_to_runtime.re` still falls back to string emission instead of a typed runtime declaration.
- A missing runtime binding means the PPX tried to emit a typed `CSS.*` call, but the corresponding declaration helper is absent from the runtime surface.
- The supplemental probe uses a heuristic sample generator. Its `typed` and `unsafe` results are useful, but `compile_failed` and `no_sample` rows should be treated as inconclusive rather than final property judgements.

