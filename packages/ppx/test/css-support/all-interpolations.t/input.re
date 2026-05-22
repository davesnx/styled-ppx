/* =============================================================================
   ALL CX2 INTERPOLATIONS TEST
   This file combines all valid cx2 test cases with interpolated versions
   ============================================================================= */

/* --- Module Definitions for Interpolation --- */
module Color = {
  module Background = {
    let _boxDark = `hex("000000");
  };
  module Shadow = {
    let _elevation1 = `rgba((0, 0, 0, `num(0.03)));
  };
  let _text = CSS.hex("444");
  let _background = CSS.hex("333");
};

module X = {
  let _value = 1.;
  let flex1 = `num(1.);
  let _min = `px(500);
};

/* Font variables for interpolation */
let _font = `sansSerif;
let _fonts = [|`custom("Inter"), `sansSerif|];

/* =============================================================================
   CSS ANIMATIONS
   ============================================================================= */
let foo = [%keyframe {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];
let bar = [%keyframe {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];

/* Static */
[%css {|animation-name: random|}];
[%css {|animation-name: foo, bar|}];
/* Interpolated */
[%css {|animation-name: $(foo)|}];
[%css {|animation-name: $(foo), $(bar)|}];

/* Static */
[%css {|animation-duration: 0s|}];
[%css {|animation-duration: 1s|}];
[%css {|animation-duration: 100ms|}];
/* Interpolated */
let animDuration = `s(1);
let animDuration2 = `ms(100);
[%css {|animation-duration: $(animDuration)|}];
[%css {|animation-duration: $(animDuration2)|}];

/* Static */
[%css {|animation-timing-function: ease|}];
[%css {|animation-timing-function: linear|}];
[%css {|animation-timing-function: ease-in|}];
[%css {|animation-timing-function: ease-out|}];
[%css {|animation-timing-function: ease-in-out|}];
/* Interpolated */
let animTiming = `ease;
[%css {|animation-timing-function: $(animTiming)|}];

/* Static */
[%css {|animation-iteration-count: infinite|}];
[%css {|animation-iteration-count: 8|}];
/* Interpolated */
let animIterCount = `infinite;
let animIterNum = `count(8.);
[%css {|animation-iteration-count: $(animIterCount)|}];
[%css {|animation-iteration-count: $(animIterNum)|}];

/* Static */
[%css {|animation-direction: normal|}];
[%css {|animation-direction: alternate|}];
[%css {|animation-direction: reverse|}];
/* Interpolated */
let animDir = `normal;
[%css {|animation-direction: $(animDir)|}];

/* Static */
[%css {|animation-play-state: running|}];
[%css {|animation-play-state: paused|}];
/* Interpolated */
let animPlayState = `running;
[%css {|animation-play-state: $(animPlayState)|}];

/* Static */
[%css {|animation-delay: 1s|}];
[%css {|animation-delay: -1s|}];
/* Interpolated */
let animDelay = `s(1);
[%css {|animation-delay: $(animDelay)|}];

/* Static */
[%css {|animation-fill-mode: none|}];
[%css {|animation-fill-mode: forwards|}];
[%css {|animation-fill-mode: backwards|}];
[%css {|animation-fill-mode: both|}];
/* Interpolated */
let animFillMode = `both;
[%css {|animation-fill-mode: $(animFillMode)|}];

/* =============================================================================
   CSS BACKGROUNDS AND BORDERS
   ============================================================================= */

/* Static */
[%css {|background-repeat: space|}];
[%css {|background-repeat: round|}];
[%css {|background-repeat: repeat repeat|}];
/* Interpolated */
let bgRepeat = `space;
[%css {|background-repeat: $(bgRepeat)|}];

/* Static */
[%css {|background-attachment: local|}];
/* Interpolated */
let bgAttach = `local;
[%css {|background-attachment: $(bgAttach)|}];

/* Static */
[%css {|background-clip: border-box|}];
[%css {|background-clip: padding-box|}];
[%css {|background-clip: content-box|}];
[%css {|background-clip: text|}];
/* Interpolated */
let bgClip = `borderBox;
[%css {|background-clip: $(bgClip)|}];

/* Static */
[%css {|background-origin: border-box|}];
[%css {|background-origin: padding-box|}];
[%css {|background-origin: content-box|}];
/* Interpolated */
let bgOrigin = `borderBox;
[%css {|background-origin: $(bgOrigin)|}];

/* Static */
[%css {|background-size: auto|}];
[%css {|background-size: cover|}];
[%css {|background-size: contain|}];
[%css {|background-size: 10px|}];
[%css {|background-size: 50%|}];
/* Interpolated */
let bgSize = `cover;
[%css {|background-size: $(bgSize)|}];

/* Static */
[%css {|background: blue|}];
[%css {|background: border-box|}];
/* Interpolated */
let bgColor = CSS.hex("0000ff");
[%css {|background: $(bgColor)|}];

/* Static */
[%css {|border-top-left-radius: 0|}];
[%css {|border-top-left-radius: 50%|}];
[%css {|border-radius: 10px|}];
[%css {|border-radius: 50%|}];
/* Interpolated */
let borderRad = `px(10);
let borderRadPct = `percent(50.);
[%css {|border-radius: $(borderRad)|}];
[%css {|border-radius: $(borderRadPct)|}];

/* Static */
[%css {|box-shadow: 1px 1px|}];
[%css {|box-shadow: 0 0 black|}];
[%css {|box-shadow: 1px 2px 3px black|}];
[%css {|box-shadow: 1px 2px 3px 4px black|}];
[%css {|box-shadow: inset 1px 2px 3px 4px black|}];
/* Interpolated - box-shadow uses different interpolation approach in cx2
   See box-shadow-interpolation.t for examples using standalone tool */
/* let singleShadow = CSS.BoxShadow.box(~x=`px(2), ~y=`px(4), ~blur=`px(8), CSS.hex("000"));
   [%css {|box-shadow: $(singleShadow)|}]; */

/* Static */
[%css {|background-position: bottom;|}];
[%css {|background-position-x: 50%;|}];
[%css {|background-position-y: 0;|}];
/* Interpolated - background-position uses different type constraints */
/* let bgPosX = `percent(50.);
   let bgPosY = `px(0);
   [%css {|background-position-x: $(bgPosX)|}];
   [%css {|background-position-y: $(bgPosY)|}]; */

/* =============================================================================
   CSS BASIC USER INTERFACE
   ============================================================================= */

/* Static */
[%css {|box-sizing: border-box|}];
[%css {|box-sizing: content-box|}];
/* Interpolated */
let boxSizing = `borderBox;
[%css {|box-sizing: $(boxSizing)|}];

/* Static */
[%css {|outline-style: auto|}];
[%css {|outline-style: none|}];
[%css {|outline-style: solid|}];
/* Interpolated */
let outlineStyle = `solid;
[%css {|outline-style: $(outlineStyle)|}];

/* Static */
[%css {|outline-offset: -5px|}];
[%css {|outline-offset: 0|}];
[%css {|outline-offset: 5px|}];
/* Interpolated */
let outlineOff = `px(5);
[%css {|outline-offset: $(outlineOff)|}];

/* Static */
[%css {|resize: none|}];
[%css {|resize: both|}];
[%css {|resize: horizontal|}];
[%css {|resize: vertical|}];
/* Interpolated */
let resizeVal = `both;
[%css {|resize: $(resizeVal)|}];

/* Static */
[%css {|text-overflow: clip|}];
[%css {|text-overflow: ellipsis|}];
/* Interpolated */
let textOverflow = `ellipsis;
[%css {|text-overflow: $(textOverflow)|}];

/* Static */
[%css {|cursor: default|}];
[%css {|cursor: pointer|}];
[%css {|cursor: none|}];
/* Interpolated */
let cursorVal = `pointer;
[%css {|cursor: $(cursorVal)|}];

/* Static */
[%css {|caret-color: auto|}];
[%css {|caret-color: green|}];
/* Interpolated */
let caretCol = CSS.hex("00ff00");
[%css {|caret-color: $(caretCol)|}];

/* Static */
[%css {|appearance: auto|}];
[%css {|appearance: none|}];
/* Interpolated */
let appearanceVal = `none;
[%css {|appearance: $(appearanceVal)|}];

/* Static */
[%css {|user-select: auto|}];
[%css {|user-select: text|}];
[%css {|user-select: none|}];
/* Interpolated */
let userSelectVal = `none;
[%css {|user-select: $(userSelectVal)|}];

/* =============================================================================
   CSS BOX ALIGNMENT
   ============================================================================= */

/* Static */
[%css {|align-self: auto|}];
[%css {|align-self: normal|}];
[%css {|align-self: stretch|}];
[%css {|align-self: center|}];
/* Interpolated */
let alignSelfVal = `center;
[%css {|align-self: $(alignSelfVal)|}];

/* Static */
[%css {|align-items: normal|}];
[%css {|align-items: stretch|}];
[%css {|align-items: center|}];
/* Interpolated */
let alignItemsVal = `stretch;
[%css {|align-items: $(alignItemsVal)|}];

/* Static */
[%css {|align-content: normal|}];
[%css {|align-content: space-between|}];
[%css {|align-content: center|}];
/* Interpolated */
let alignContentVal = `spaceBetween;
[%css {|align-content: $(alignContentVal)|}];

/* Static */
[%css {|justify-self: auto|}];
[%css {|justify-self: normal|}];
[%css {|justify-self: center|}];
/* Interpolated */
let justifySelfVal = `center;
[%css {|justify-self: $(justifySelfVal)|}];

/* Static */
[%css {|justify-items: normal|}];
[%css {|justify-items: stretch|}];
[%css {|justify-items: center|}];
/* Interpolated */
let justifyItemsVal = `start;
[%css {|justify-items: $(justifyItemsVal)|}];

/* Static */
[%css {|justify-content: normal|}];
[%css {|justify-content: space-between|}];
[%css {|justify-content: center|}];
/* Interpolated */
let justifyContentVal = `center;
[%css {|justify-content: $(justifyContentVal)|}];

/* Static */
[%css {|gap: 0 0|}];
[%css {|gap: 0 1em|}];
[%css {|gap: 1em|}];
/* Interpolated */
let gapVal = `em(1.);
[%css {|gap: $(gapVal)|}];

/* Static */
[%css {|column-gap: 0|}];
[%css {|column-gap: 1em|}];
/* Interpolated */
let colGapVal = `em(1.);
[%css {|column-gap: $(colGapVal)|}];

/* Static */
[%css {|row-gap: 0|}];
[%css {|row-gap: 1em|}];
/* Interpolated */
let rowGapVal = `em(1.);
[%css {|row-gap: $(rowGapVal)|}];

/* =============================================================================
   CSS BOX SIZING
   ============================================================================= */

/* Static */
[%css {|width: max-content|}];
[%css {|width: min-content|}];
[%css {|width: fit-content|}];
/* Interpolated */
let widthVal = `px(100);
[%css {|width: $(widthVal)|}];

/* Static */
[%css {|min-width: max-content|}];
[%css {|min-width: min-content|}];
/* Interpolated */
let minWidthVal = `px(50);
[%css {|min-width: $(minWidthVal)|}];

/* Static */
[%css {|max-width: max-content|}];
[%css {|max-width: min-content|}];
/* Interpolated */
let maxWidthVal = `px(500);
[%css {|max-width: $(maxWidthVal)|}];

/* Static */
[%css {|height: max-content|}];
[%css {|height: min-content|}];
[%css {|height: fit-content|}];
/* Interpolated */
let heightVal = `px(200);
[%css {|height: $(heightVal)|}];

/* Static */
[%css {|min-height: max-content|}];
[%css {|min-height: min-content|}];
/* Interpolated */
let minHeightVal = `px(100);
[%css {|min-height: $(minHeightVal)|}];

/* Static */
[%css {|max-height: max-content|}];
[%css {|max-height: min-content|}];
/* Interpolated */
let maxHeightVal = `px(400);
[%css {|max-height: $(maxHeightVal)|}];

/* Static */
[%css {|aspect-ratio: auto|}];
[%css {|aspect-ratio: 2|}];
[%css {|aspect-ratio: 16 / 9|}];
/* Interpolated */
let aspectRatio = `ratio((16, 9));
[%css {|aspect-ratio: $(aspectRatio)|}];

/* =============================================================================
   CSS CALC
   ============================================================================= */

/* Static */
[%css {|width: calc(50% + 4px)|}];
[%css {|width: calc(20px - 10px)|}];
[%css {|width: calc(100vh - calc(2rem + 120px))|}];
[%css {|width: calc(100vh * 2)|}];
[%css {|width: calc(2 * 120px)|}];

/* =============================================================================
   CSS CASCADING AND INHERITANCE
   ============================================================================= */

/* Static */
[%css {|color: unset;|}];
[%css {|font-weight: unset;|}];
[%css {|background-image: unset;|}];
[%css {|width: unset;|}];

/* =============================================================================
   CSS COLOR MODULE
   ============================================================================= */

/* Static */
[%css {|color: rgba(0,0,0,.5);|}];
[%css {|color: #F06;|}];
[%css {|color: #FF0066;|}];
[%css {|color: hsl(0,0%,0%);|}];
[%css {|color: transparent;|}];
[%css {|color: currentColor;|}];
/* Interpolated */
let colorVal = CSS.hex("ff0066");
[%css {|color: $(colorVal)|}];
let colorRgba = CSS.rgba(0, 0, 0, `num(0.5));
[%css {|color: $(colorRgba)|}];

/* Static */
[%css {|background-color: rgba(0,0,0,.5);|}];
[%css {|background-color: #F06;|}];
[%css {|background-color: transparent;|}];
/* Interpolated */
let bgColorVal = CSS.hex("ff0066");
[%css {|background-color: $(bgColorVal)|}];

/* Static */
[%css {|border-color: rgba(0,0,0,.5);|}];
[%css {|border-color: #F06;|}];
[%css {|border-color: transparent;|}];
/* Interpolated */
let borderColorVal = CSS.hex("ff0066");
[%css {|border-color: $(borderColorVal)|}];

/* Static */
[%css {|text-decoration-color: rgba(0,0,0,.5);|}];
[%css {|text-decoration-color: #F06;|}];
/* Interpolated */
let textDecorColor = CSS.hex("ff0066");
[%css {|text-decoration-color: $(textDecorColor)|}];

/* Static */
[%css {|color: rebeccapurple;|}];
[%css {|color: color-mix(in srgb, teal 65%, olive);|}];

/* =============================================================================
   CSS COLOR ADJUSTMENTS
   ============================================================================= */

/* Static */
[%css {|color-adjust: economy|}];
[%css {|color-adjust: exact|}];
[%css {|forced-color-adjust: auto|}];
[%css {|forced-color-adjust: none|}];
[%css {|color-scheme: normal|}];
[%css {|color-scheme: light|}];
[%css {|color-scheme: dark|}];
[%css {|color-scheme: light dark|}];

/* =============================================================================
   CSS COMPOSITING AND BLENDING
   ============================================================================= */

/* Static */
[%css {|mix-blend-mode: normal|}];
[%css {|mix-blend-mode: multiply|}];
[%css {|mix-blend-mode: screen|}];
[%css {|mix-blend-mode: overlay|}];
/* Interpolated */
let blendMode = `multiply;
[%css {|mix-blend-mode: $(blendMode)|}];

/* Static */
[%css {|isolation: auto|}];
[%css {|isolation: isolate|}];
/* Interpolated */
let isolationVal = `isolate;
[%css {|isolation: $(isolationVal)|}];

/* Static */
[%css {|background-blend-mode: normal|}];
[%css {|background-blend-mode: multiply|}];
/* Interpolated */
let bgBlendMode = `multiply;
[%css {|background-blend-mode: $(bgBlendMode)|}];

/* =============================================================================
   CSS CONTAINMENT
   ============================================================================= */

/* Static */
[%css {|contain: none|}];
[%css {|contain: strict|}];
[%css {|contain: content|}];
[%css {|contain: size|}];
[%css {|contain: layout|}];
[%css {|contain: paint|}];

/* =============================================================================
   CSS CONTENT
   ============================================================================= */

/* Static */
[%css {|quotes: auto|}];
[%css {|content: "";|}];
[%css {|content: counter(count, decimal);|}];
[%css {|content: unset;|}];
[%css {|content: normal;|}];
[%css {|content: none;|}];
/* Interpolated */
let contentVal = `none;
[%css {|content: $(contentVal)|}];

/* Static */
[%css {|content: open-quote;|}];
[%css {|content: close-quote;|}];
[%css {|content: attr(href);|}];

/* =============================================================================
   CSS DISPLAY
   ============================================================================= */

/* Static */
[%css {|display: run-in|}];
[%css {|display: flow|}];
[%css {|display: flow-root|}];
[%css {|display: flex|}];
[%css {|display: inline-flex|}];
[%css {|display: grid|}];
[%css {|display: inline-grid|}];
[%css {|display: block|}];
[%css {|display: inline|}];
[%css {|display: none|}];
/* Interpolated */
let displayVal = `flex;
[%css {|display: $(displayVal)|}];

/* =============================================================================
   CSS EASING FUNCTIONS
   ============================================================================= */

/* Static */
[%css {|transition-timing-function: steps(2, jump-start)|}];
[%css {|transition-timing-function: steps(2, jump-end)|}];
[%css {|transition-timing-function: steps(1, jump-both)|}];
[%css {|transition-timing-function: steps(2, jump-none)|}];

/* =============================================================================
   CSS FILTER EFFECTS
   ============================================================================= */

/* Static */
[%css {|filter: none|}];
[%css {|filter: url(#id)|}];
[%css {|filter: blur(5px)|}];
[%css {|filter: brightness(0.5)|}];
[%css {|filter: contrast(150%)|}];
[%css {|filter: grayscale(50%)|}];
[%css {|filter: hue-rotate(50deg)|}];
[%css {|filter: invert(50%)|}];
[%css {|filter: opacity(50%)|}];
[%css {|filter: sepia(50%)|}];
[%css {|filter: saturate(150%)|}];
/* Interpolated */
let filterBlur = `blur(`px(5));
[%css {|filter: $(filterBlur)|}];

/* Static */
[%css {|backdrop-filter: none|}];
[%css {|backdrop-filter: blur(5px)|}];
[%css {|backdrop-filter: brightness(0.5)|}];
/* backdrop-filter interpolation not yet supported */

/* =============================================================================
   CSS FLEXIBLE BOX LAYOUT
   ============================================================================= */

/* Static */
[%css {|align-content: flex-start|}];
[%css {|align-content: flex-end|}];
[%css {|align-items: flex-start|}];
[%css {|align-items: flex-end|}];
[%css {|flex: none|}];
[%css {|flex: 5 7 10%|}];
[%css {|flex: 2;|}];
/* Interpolated */
[%css {|flex: $(X.flex1);|}];
/* flex with multiple interpolations has type constraints - see flexible-box-layout-module.t for PPX output */
/* [%css {|flex: $(X.value) $(X.value);|}]; */
/* [%css {|flex: $(X.value) $(X.value) $(X.min);|}]; */

/* Static */
[%css {|flex-basis: auto|}];
[%css {|flex-basis: content|}];
[%css {|flex-basis: 1px|}];
/* Interpolated */
let flexBasisVal = `px(100);
[%css {|flex-basis: $(flexBasisVal)|}];

/* Static */
[%css {|flex-direction: row|}];
[%css {|flex-direction: row-reverse|}];
[%css {|flex-direction: column|}];
[%css {|flex-direction: column-reverse|}];
/* Interpolated */
let flexDirVal = `row;
[%css {|flex-direction: $(flexDirVal)|}];

/* Static */
[%css {|flex-grow: 0|}];
[%css {|flex-grow: 5|}];
/* Interpolated */
let flexGrowVal = `num(2.0);
[%css {|flex-grow: $(flexGrowVal)|}];

/* Static */
[%css {|flex-shrink: 1|}];
[%css {|flex-shrink: 10|}];
/* Interpolated */
let flexShrinkVal = `num(0.5);
[%css {|flex-shrink: $(flexShrinkVal)|}];

/* Static */
[%css {|flex-wrap: nowrap|}];
[%css {|flex-wrap: wrap|}];
[%css {|flex-wrap: wrap-reverse|}];
/* Interpolated */
let flexWrapVal = `wrap;
[%css {|flex-wrap: $(flexWrapVal)|}];

/* Static */
[%css {|order: 0|}];
[%css {|order: 1|}];
/* Interpolated - order expects int, not `num(int) */
let orderVal = 2;
[%css {|order: $(orderVal)|}];

/* =============================================================================
   CSS FONTS
   ============================================================================= */

/* Static */
[%css {|font-family: "Inter Semi Bold";|}];
[%css {|font-family: Inter;|}];
[%css {|font-family: Inter, Sans;|}];
/* font-family interpolation has specific type requirements - see fonts-module.t for examples */

/* Static */
[%css {|font-size: xxx-large|}];
/* Interpolated */
let fontSize = `px(16);
[%css {|font-size: $(fontSize)|}];

/* Static */
[%css {|font-weight: 1|}];
[%css {|font-weight: 90|}];
[%css {|font-weight: 750|}];
[%css {|font-weight: 1000|}];
/* Interpolated */
let fontWeight = `bold;
[%css {|font-weight: $(fontWeight)|}];

/* Static */
[%css {|font-style: oblique 15deg|}];
[%css {|font-style: oblique -15deg|}];
/* Interpolated */
let fontStyle = `italic;
[%css {|font-style: $(fontStyle)|}];

/* Static */
[%css {|font-stretch: normal|}];
[%css {|font-stretch: ultra-condensed|}];
[%css {|font-stretch: condensed|}];

/* Static */
[%css {|font-kerning: auto|}];
[%css {|font-kerning: normal|}];
[%css {|font-kerning: none|}];

/* =============================================================================
   CSS FRAGMENTATION
   ============================================================================= */

/* Static */
[%css {|break-before: auto|}];
[%css {|break-before: avoid|}];
[%css {|break-before: page|}];
/* Interpolated */
let breakBeforeVal = `page;
[%css {|break-before: $(breakBeforeVal)|}];

/* Static */
[%css {|break-after: auto|}];
[%css {|break-after: avoid|}];
/* Interpolated */
let breakAfterVal = `avoid;
[%css {|break-after: $(breakAfterVal)|}];

/* Static */
[%css {|break-inside: auto|}];
[%css {|break-inside: avoid|}];
/* Interpolated */
let breakInsideVal = `avoid;
[%css {|break-inside: $(breakInsideVal)|}];

/* Static */
[%css {|box-decoration-break: slice|}];
[%css {|box-decoration-break: clone|}];

/* Static */
[%css {|orphans: 1|}];
[%css {|orphans: 2|}];
[%css {|widows: 1|}];
[%css {|widows: 2|}];

/* =============================================================================
   CSS GRID LAYOUT
   ============================================================================= */

/* Static */
[%css {|grid-template-columns: none|}];
[%css {|grid-template-columns: auto|}];
[%css {|grid-template-columns: 100px|}];
[%css {|grid-template-columns: 1fr|}];
[%css {|grid-template-columns: 100px 1fr auto|}];
[%css {|grid-template-columns: repeat(2, 100px 1fr)|}];
/* Interpolated */
let gridColsValue =
  CSS.tracks([|
    CSS.repeatFn(
      CSS.numInt(4),
      [|
        CSS.pxFloat(10.),
        CSS.lineNames({js|[col-start]|js}),
        CSS.pxFloat(250.),
        CSS.lineNames({js|[col-end]|js}),
      |],
    ),
    CSS.pxFloat(10.),
  |]);
[%css {|grid-template-columns: $(gridColsValue)|}];

/* Static */
[%css {|grid-template-rows: none|}];
[%css {|grid-template-rows: auto|}];
[%css {|grid-template-rows: 100px|}];
[%css {|grid-template-rows: 1fr|}];

/* Static */
[%css {|grid-template-areas: none|}];
[%css {|grid-template-areas: 'articles'|}];
[%css {|grid-template-areas: 'head head'|}];

/* Static */
[%css {|grid-auto-columns: auto|}];
[%css {|grid-auto-columns: 1fr|}];
[%css {|grid-auto-columns: 100px|}];

/* Static */
[%css {|grid-auto-rows: auto|}];
[%css {|grid-auto-rows: 1fr|}];
[%css {|grid-auto-rows: 100px|}];

/* Static */
[%css {|grid-auto-flow: row|}];
[%css {|grid-auto-flow: column|}];
[%css {|grid-auto-flow: row dense|}];
/* Interpolated */
let gridAutoFlowVal = `row;
[%css {|grid-auto-flow: $(gridAutoFlowVal)|}];

/* Static */
[%css {|grid-column: auto|}];
[%css {|grid-column: 1|}];
[%css {|grid-column: -1|}];
[%css {|grid-column: 1 / 1|}];
[%css {|grid-column: 1 / -1|}];

/* Static */
[%css {|grid-row: auto|}];
[%css {|grid-row: 1|}];
[%css {|grid-row: -1|}];
[%css {|grid-row: 1 / 1|}];

/* Static */
[%css {|grid-area: 1 / 1|}];
/* Interpolated */
let area = `num(33);
[%css {|grid-area: $(area)|}];

/* Static */
[%css {|grid-column-gap: 0|}];
[%css {|grid-column-gap: 1em|}];
[%css {|grid-row-gap: 0|}];
[%css {|grid-row-gap: 1em|}];
[%css {|grid-gap: 0 0|}];
[%css {|grid-gap: 1em|}];

/* =============================================================================
   CSS LISTS
   ============================================================================= */

/* Static */
[%css {|list-style-type: disclosure-closed|}];
[%css {|list-style-type: disclosure-open|}];
[%css {|list-style-type: disc|}];
[%css {|list-style-type: circle|}];
[%css {|list-style-type: square|}];
/* list-style-type interpolation uses Custom type */
let listStyleTypeVal = `Custom("disc");
[%css {|list-style-type: $(listStyleTypeVal)|}];

/* Static */
[%css {|counter-reset: foo|}];
[%css {|counter-reset: foo 1|}];
[%css {|counter-reset: none|}];

/* Static */
[%css {|counter-set: foo|}];
[%css {|counter-set: foo 1|}];
[%css {|counter-set: none|}];

/* Static */
[%css {|counter-increment: foo|}];
[%css {|counter-increment: foo 1|}];
[%css {|counter-increment: none|}];

/* =============================================================================
   CSS LOGICAL PROPERTIES
   ============================================================================= */

/* Static */
[%css {|block-size: 100px|}];
[%css {|inline-size: 100px|}];
[%css {|min-block-size: 100px|}];
[%css {|min-inline-size: 100px|}];
[%css {|max-block-size: 100px|}];
[%css {|max-inline-size: 100px|}];
/* Interpolated */
let blockSizeVal = `px(100);
[%css {|block-size: $(blockSizeVal)|}];
let inlineSizeVal = `px(100);
[%css {|inline-size: $(inlineSizeVal)|}];

/* Static */
[%css {|margin-block: 10px|}];
[%css {|margin-block: 10px 10px|}];
[%css {|margin-block-start: 10px|}];
[%css {|margin-block-end: 10px|}];
/* Interpolated */
let marginBlockVal = `px(10);
[%css {|margin-block: $(marginBlockVal)|}];

/* Static */
[%css {|margin-inline: 10px|}];
[%css {|margin-inline-start: 10px|}];
[%css {|margin-inline-end: 10px|}];
/* Interpolated */
let marginInlineVal = `px(20);
[%css {|margin-inline: $(marginInlineVal)|}];

/* Static */
[%css {|inset: 10px|}];
[%css {|inset: 10px 10px|}];
[%css {|inset-block: 10px|}];
[%css {|inset-inline: 10px|}];
/* Interpolated */
let insetBlockVal = `px(0);
[%css {|inset-block: $(insetBlockVal)|}];
let insetInlineVal = `px(0);
[%css {|inset-inline: $(insetInlineVal)|}];

/* Static */
[%css {|padding-block: 10px|}];
[%css {|padding-block-start: 10px|}];
[%css {|padding-inline: 10px|}];
[%css {|padding-inline-start: 10px|}];
/* Interpolated */
let paddingBlockVal = `px(5);
[%css {|padding-block: $(paddingBlockVal)|}];
let paddingInlineVal = `px(15);
[%css {|padding-inline: $(paddingInlineVal)|}];

/* Static */
[%css {|border-block: 1px|}];
[%css {|border-block: 2px dotted|}];
[%css {|border-inline: 1px|}];
[%css {|border-inline: 2px dotted|}];

/* =============================================================================
   CSS MASKING
   ============================================================================= */

/* Static */
[%css {|clip-path: url('#clip')|}];
[%css {|clip-path: inset(50%)|}];
[%css {|clip-path: polygon(50% 100%, 0 0, 100% 0)|}];
[%css {|clip-path: border-box|}];
[%css {|clip-path: none|}];

/* Static */
[%css {|mask-image: none|}];
[%css {|mask-image: url(image.png)|}];
/* Interpolated */
let maskedImageUrl = `url("https://www.example.com/mask.svg");
[%css {|mask-image: $(maskedImageUrl)|}];

/* Static */
[%css {|mask-repeat: repeat-x|}];
[%css {|mask-repeat: no-repeat|}];
/* Interpolated */
let maskRepeatVal = `noRepeat;
[%css {|mask-repeat: $(maskRepeatVal)|}];

/* Static */
[%css {|mask-position: center|}];
[%css {|mask-size: auto|}];
[%css {|mask-size: cover|}];

/* =============================================================================
   CSS MOTION PATH
   ============================================================================= */

/* Static */
[%css {|offset: none|}];
[%css {|offset: auto|}];
[%css {|offset: center|}];
[%css {|offset: 200px 100px|}];
[%css {|offset-path: none|}];
[%css {|offset-distance: 10%|}];
[%css {|offset-position: auto|}];
[%css {|offset-anchor: auto|}];
[%css {|offset-rotate: auto|}];

/* =============================================================================
   CSS MULTI-COLUMN LAYOUT
   ============================================================================= */

/* Static */
[%css {|column-width: 10em|}];
[%css {|column-width: auto|}];
/* Interpolated */
let colWidthVal = `em(10.);
[%css {|column-width: $(colWidthVal)|}];

/* Static */
[%css {|column-count: 2|}];
[%css {|column-count: auto|}];
/* Interpolated */
let colCountVal = `count(3);
[%css {|column-count: $(colCountVal)|}];

/* Static */
[%css {|columns: 100px|}];
[%css {|columns: 3|}];
[%css {|columns: 10em 2|}];

/* Static */
[%css {|column-rule-color: red|}];
[%css {|column-rule-style: none|}];
[%css {|column-rule-style: solid|}];
[%css {|column-rule-width: 1px|}];

/* Static */
[%css {|column-span: none|}];
[%css {|column-span: all|}];
[%css {|column-fill: auto|}];
[%css {|column-fill: balance|}];

/* =============================================================================
   CSS OVERFLOW
   ============================================================================= */

/* Static */
[%css {|line-clamp: none|}];
[%css {|line-clamp: 1|}];
[%css {|max-lines: none|}];
[%css {|max-lines: 1|}];

/* Static */
[%css {|overflow-x: visible|}];
[%css {|overflow-x: hidden|}];
[%css {|overflow-x: clip|}];
[%css {|overflow-x: scroll|}];
[%css {|overflow-x: auto|}];
/* overflow-x/y interpolation - see random.t for working examples */

/* Static */
[%css {|overflow-y: visible|}];
[%css {|overflow-y: hidden|}];
[%css {|overflow-y: clip|}];
[%css {|overflow-y: scroll|}];
[%css {|overflow-y: auto|}];

/* Static */
[%css {|overflow: hidden|}];

/* Static */
[%css {|overflow-block: hidden|}];
[%css {|overflow-inline: visible|}];

/* Static */
[%css {|scrollbar-gutter: auto|}];
[%css {|scrollbar-gutter: stable|}];

/* =============================================================================
   CSS OVERSCROLL BEHAVIOR
   ============================================================================= */

/* Static */
[%css {|overscroll-behavior: contain|}];
[%css {|overscroll-behavior: none|}];
[%css {|overscroll-behavior: auto|}];
/* Interpolated */
let overscrollVal = `contain;
[%css {|overscroll-behavior: $(overscrollVal)|}];

/* Static */
[%css {|overscroll-behavior-x: contain|}];
[%css {|overscroll-behavior-y: none|}];

/* =============================================================================
   CSS POINTER EVENTS
   ============================================================================= */

/* Static */
[%css {|touch-action: auto|}];
[%css {|touch-action: none|}];
[%css {|touch-action: pan-x|}];
[%css {|touch-action: pan-y|}];
[%css {|touch-action: manipulation|}];
/* Interpolated */
let touchActionVal = `manipulation;
[%css {|touch-action: $(touchActionVal)|}];

/* =============================================================================
   CSS POSITIONED LAYOUT
   ============================================================================= */

/* Static */
[%css {|position: sticky|}];
[%css {|position: relative|}];
[%css {|position: absolute|}];
[%css {|position: fixed|}];
/* position interpolation has different type constraints */

/* Interpolated positions */
let topVal = `px(10);
[%css {|top: $(topVal)|}];
let rightVal = `px(20);
[%css {|right: $(rightVal)|}];
let bottomVal = `px(30);
[%css {|bottom: $(bottomVal)|}];
let leftVal = `px(40);
[%css {|left: $(leftVal)|}];
let zIndexVal = `num(100);
[%css {|z-index: $(zIndexVal)|}];

/* =============================================================================
   CSS SCROLL SNAP
   ============================================================================= */

/* Static */
[%css {|scroll-margin: 0px|}];
[%css {|scroll-margin: 6px 5px|}];
[%css {|scroll-margin: 10px 20px 30px 40px|}];
[%css {|scroll-padding: auto|}];
[%css {|scroll-padding: 0px|}];
[%css {|scroll-snap-align: none|}];
[%css {|scroll-snap-align: start|}];
[%css {|scroll-snap-align: center|}];
[%css {|scroll-snap-stop: normal|}];
[%css {|scroll-snap-stop: always|}];
[%css {|scroll-snap-type: none|}];
[%css {|scroll-snap-type: x mandatory|}];

/* =============================================================================
   CSS SCROLLBARS
   ============================================================================= */

/* Static */
[%css {|scrollbar-color: auto|}];
[%css {|scrollbar-color: red blue|}];
[%css {|scrollbar-width: auto|}];
[%css {|scrollbar-width: thin|}];
[%css {|scrollbar-width: none|}];

/* =============================================================================
   CSS SVG POINTER EVENTS
   ============================================================================= */

/* Static */
[%css {|pointer-events: auto|}];
[%css {|pointer-events: visiblePainted|}];
[%css {|pointer-events: visibleFill|}];
[%css {|pointer-events: visibleStroke|}];
[%css {|pointer-events: visible|}];
[%css {|pointer-events: painted|}];
[%css {|pointer-events: fill|}];
[%css {|pointer-events: stroke|}];
[%css {|pointer-events: all|}];
[%css {|pointer-events: none|}];
/* Interpolated */
let pointerEventsVal = `none;
[%css {|pointer-events: $(pointerEventsVal)|}];

/* =============================================================================
   CSS TEXT DECORATION
   ============================================================================= */

/* Static */
[%css {|text-decoration-line: none|}];
[%css {|text-decoration-line: underline|}];
[%css {|text-decoration-line: overline|}];
[%css {|text-decoration-line: line-through|}];
/* text-decoration-line interpolation uses Value type */

/* Static */
[%css {|text-decoration-style: solid|}];
[%css {|text-decoration-style: double|}];
[%css {|text-decoration-style: dotted|}];
[%css {|text-decoration-style: dashed|}];
[%css {|text-decoration-style: wavy|}];

/* Static */
[%css {|text-underline-position: auto|}];
[%css {|text-underline-position: under|}];
[%css {|text-emphasis-style: none|}];
[%css {|text-emphasis-style: filled|}];
[%css {|text-emphasis-color: green|}];

/* Static */
[%css {|text-shadow: none|}];
[%css {|text-shadow: 1px 1px|}];
[%css {|text-shadow: 0 0 black|}];
[%css {|text-shadow: 1px 2px 3px black|}];
/* text-shadow interpolation uses different types - see box-shadow-interpolation.t */

/* Static */
[%css {|text-decoration-skip: none|}];
[%css {|text-decoration-skip: objects|}];
[%css {|text-decoration-skip-ink: none|}];
[%css {|text-decoration-skip-ink: auto|}];
[%css {|text-underline-offset: auto|}];
[%css {|text-underline-offset: 3px|}];
[%css {|text-decoration-thickness: auto|}];
[%css {|text-decoration-thickness: from-font|}];

/* =============================================================================
   CSS TEXT MODULE
   ============================================================================= */

/* Static */
[%css {|text-transform: full-width|}];
[%css {|text-transform: uppercase|}];
[%css {|text-transform: lowercase|}];
/* Interpolated */
let textTransformVal = `uppercase;
[%css {|text-transform: $(textTransformVal)|}];

/* Static */
[%css {|tab-size: 4|}];
[%css {|tab-size: 1em|}];

/* Static */
[%css {|line-break: auto|}];
[%css {|line-break: loose|}];
[%css {|line-break: normal|}];
[%css {|line-break: strict|}];

/* Static */
[%css {|word-break: normal|}];
[%css {|word-break: keep-all|}];
[%css {|word-break: break-all|}];
/* Interpolated */
let wordBreakVal = `breakAll;
[%css {|word-break: $(wordBreakVal)|}];

/* Static */
[%css {|white-space: break-spaces|}];
[%css {|white-space: nowrap|}];
/* Interpolated */
let whiteSpaceVal = `nowrap;
[%css {|white-space: $(whiteSpaceVal)|}];

/* Static */
[%css {|hyphens: auto|}];
[%css {|hyphens: manual|}];
[%css {|hyphens: none|}];
/* Interpolated */
let hyphensVal = `auto;
[%css {|hyphens: $(hyphensVal)|}];

/* Static */
[%css {|overflow-wrap: normal|}];
[%css {|overflow-wrap: break-word|}];
[%css {|overflow-wrap: anywhere|}];
/* Interpolated */
let overflowWrapVal = `breakWord;
[%css {|overflow-wrap: $(overflowWrapVal)|}];

/* Static */
[%css {|text-align: start|}];
[%css {|text-align: end|}];
[%css {|text-align: left|}];
[%css {|text-align: right|}];
[%css {|text-align: center|}];
[%css {|text-align: justify|}];
/* Interpolated */
let textAlignVal = `center;
[%css {|text-align: $(textAlignVal)|}];

/* Static */
[%css {|text-wrap: wrap|}];
[%css {|text-wrap: nowrap|}];
[%css {|text-wrap: balance|}];
[%css {|text-wrap: pretty|}];

/* =============================================================================
   CSS TRANSFORMS
   ============================================================================= */

/* Static */
[%css {|transform: none|}];
[%css {|transform: translate(5px)|}];
[%css {|transform: translate(5px, 10px)|}];
[%css {|transform: translateY(5px)|}];
[%css {|transform: translateX(5px)|}];
[%css {|transform: scale(2)|}];
[%css {|transform: scale(2, -1)|}];
[%css {|transform: rotate(45deg)|}];
[%css {|transform: skew(45deg)|}];
[%css {|transform: translate3d(0, 0, 5px)|}];
[%css {|transform: perspective(600px)|}];
/* Interpolated */
let transformVal = `translate((`px(10), `px(20)));
[%css {|transform: $(transformVal)|}];

/* Static */
[%css {|transform-origin: 10px|}];
[%css {|transform-origin: top|}];
[%css {|transform-origin: top left|}];
[%css {|transform-origin: 50% 100%|}];
/* Interpolated */
let transformOriginVal = `center;
[%css {|transform-origin: $(transformOriginVal)|}];

/* Static */
[%css {|transform-box: border-box|}];
[%css {|transform-box: fill-box|}];
[%css {|transform-box: view-box|}];

/* Static */
[%css {|translate: none|}];
[%css {|translate: 50%|}];
[%css {|translate: 50% 50%|}];

/* Static */
[%css {|scale: none|}];
[%css {|scale: 2|}];
[%css {|scale: 2 2|}];

/* Static */
[%css {|rotate: none|}];
[%css {|rotate: 45deg|}];

/* Static */
[%css {|transform-style: flat|}];
[%css {|transform-style: preserve-3d|}];

/* Static */
[%css {|perspective: none|}];
[%css {|perspective: 600px|}];
/* Interpolated */
let perspectiveVal = `px(1000);
[%css {|perspective: $(perspectiveVal)|}];

/* Static */
[%css {|perspective-origin: 10px|}];
[%css {|perspective-origin: top|}];

/* Static */
[%css {|backface-visibility: visible|}];
[%css {|backface-visibility: hidden|}];
/* Interpolated */
let backfaceVisVal = `hidden;
[%css {|backface-visibility: $(backfaceVisVal)|}];

/* =============================================================================
   CSS TRANSITIONS
   ============================================================================= */

/* Static */
[%css {|transition-property: none|}];
[%css {|transition-property: all|}];
[%css {|transition-property: width|}];
[%css {|transition-duration: 0s|}];
[%css {|transition-duration: 1s|}];
[%css {|transition-timing-function: ease|}];
[%css {|transition-timing-function: linear|}];
[%css {|transition-delay: 1s|}];
[%css {|transition-delay: -1s|}];
[%css {|transition-behavior: normal|}];
[%css {|transition-behavior: allow-discrete|}];
[%css {|transition: margin-right 2s, opacity 0.5s|}];

/* transition interpolation has specific type constraints - see transitions.t for examples */

/* =============================================================================
   CSS VERTICAL ALIGN
   ============================================================================= */

/* Static */
[%css {|vertical-align: baseline|}];
[%css {|vertical-align: sub|}];
[%css {|vertical-align: super|}];
[%css {|vertical-align: top|}];
[%css {|vertical-align: text-top|}];
[%css {|vertical-align: middle|}];
[%css {|vertical-align: bottom|}];
[%css {|vertical-align: text-bottom|}];
/* Interpolated */
let verticalAlignVal = `middle;
[%css {|vertical-align: $(verticalAlignVal)|}];

/* =============================================================================
   CSS WILL CHANGE
   ============================================================================= */

/* Static */
[%css {|will-change: scroll-position|}];
[%css {|will-change: contents|}];
[%css {|will-change: transform|}];
[%css {|will-change: top, left|}];

/* =============================================================================
   CSS WRITING MODES
   ============================================================================= */

/* Static */
[%css {|direction: ltr|}];
[%css {|direction: rtl|}];
[%css {|unicode-bidi: normal|}];
[%css {|unicode-bidi: embed|}];
[%css {|unicode-bidi: isolate|}];
[%css {|writing-mode: horizontal-tb|}];
[%css {|writing-mode: vertical-rl|}];
[%css {|writing-mode: vertical-lr|}];
[%css {|text-orientation: mixed|}];
[%css {|text-orientation: upright|}];
[%css {|text-orientation: sideways|}];
[%css {|text-combine-upright: none|}];
[%css {|text-combine-upright: all|}];

/* =============================================================================
   CSS RANDOM / MISC
   ============================================================================= */

/* Static */
[%css {|scroll-behavior: auto|}];
[%css {|scroll-behavior: smooth|}];
/* Interpolated */
let scrollBehaviorVal = `smooth;
[%css {|scroll-behavior: $(scrollBehaviorVal)|}];

/* Static */
[%css {|overflow-anchor: none|}];
[%css {|overflow-anchor: auto|}];

/* Static */
[%css {|-moz-appearance: textfield;|}];
[%css {|-webkit-appearance: none;|}];
[%css {|-webkit-box-orient: vertical;|}];

/* Interpolated colors */
let c = CSS.hex("e15a46");
[%css {|background-color: $(c);|}];
/* fill interpolation uses Fill type, not color */
[%css {|fill: currentColor;|}];

/* Static */
[%css {|border: none;|}];
[%css {|bottom: unset;|}];
[%css {|box-shadow: none;|}];
[%css {|break-inside: avoid;|}];
[%css {|caret-color: #e15a46;|}];
[%css {|color: inherit;|}];
[%css {|color: var(--color-link);|}];

/* Static */
[%css {|display: -webkit-box;|}];
[%css {|display: contents;|}];
[%css {|display: table;|}];

/* Static */
[%css {|grid-column-end: span 2;|}];
[%css {|grid-column: unset;|}];
[%css {|grid-row: unset;|}];
[%css {|grid-template-columns: max-content max-content;|}];
[%css {|grid-template-columns: repeat(2, auto);|}];
[%css {|grid-template-columns: repeat(3, auto);|}];
[%css {|height: fit-content;|}];
[%css {|justify-items: start;|}];
[%css {|justify-self: unset;|}];
[%css {|left: unset;|}];

/* Static */
[%css {|mask-position: center center;|}];
[%css {|mask-repeat: no-repeat;|}];
[%css {|max-width: max-content;|}];
[%css {|outline: none;|}];
[%css {|position: unset;|}];
[%css {|resize: none;|}];
[%css {|right: calc(50% - 4px);|}];

/* Static */
[%css {|stroke-opacity: 0;|}];

/* stroke interpolation uses Stroke type, not color */

/* Static */
[%css {|top: calc(50% - 1px);|}];
[%css {|top: unset;|}];
[%css {|touch-action: pan-x pan-y;|}];
[%css {|transform-origin: center bottom;|}];
[%css {|transform-origin: center left;|}];
[%css {|transform-origin: 2px;|}];
[%css {|transform-origin: bottom;|}];
[%css {|transform: none;|}];
[%css {|width: fit-content;|}];
[%css {|width: max-content;|}];

/* Static */
[%css {|transition-delay: 240ms|}];
[%css {|animation-duration: 150ms|}];

/* Static */
[%css {|border-width: thin|}];
[%css {|outline-width: medium|}];
[%css {|outline: medium solid red|}];

/* Static */
[%css {|object-fit: contain|}];
[%css {|object-fit: cover|}];
[%css {|object-fit: fill|}];
[%css {|object-fit: none|}];
/* Interpolated */
let objectFitVal = `contain;
[%css {|object-fit: $(objectFitVal)|}];

/* Static */
[%css {|object-position: top|}];
[%css {|object-position: center|}];
[%css {|object-position: 25% 75%|}];

/* Static */
[%css {|opacity: 0.5|}];
/* Interpolated */
let opacityVal = 0.8;
[%css {|opacity: $(opacityVal)|}];

/* Static */
[%css {|visibility: visible|}];
[%css {|visibility: hidden|}];
/* Interpolated */
let visibilityVal = `hidden;
[%css {|visibility: $(visibilityVal)|}];

/* Static */
[%css {|margin: 10px|}];
[%css {|margin-top: 5px|}];
[%css {|margin-right: 10px|}];
[%css {|margin-bottom: 15px|}];
[%css {|margin-left: 20px|}];
/* Interpolated */
let marginVal = `px(10);
[%css {|margin: $(marginVal)|}];
let marginTopVal = `px(5);
[%css {|margin-top: $(marginTopVal)|}];

/* Static */
[%css {|padding: 8px|}];
[%css {|padding-top: 4px|}];
[%css {|padding-right: 8px|}];
[%css {|padding-bottom: 12px|}];
[%css {|padding-left: 16px|}];
/* Interpolated */
let paddingVal = `px(8);
[%css {|padding: $(paddingVal)|}];
let paddingTopVal = `px(4);
[%css {|padding-top: $(paddingTopVal)|}];

/* Static */
[%css {|border-style: solid|}];
[%css {|border-width: 1px|}];
/* Interpolated */
let borderStyleVal = `solid;
[%css {|border-style: $(borderStyleVal)|}];
let borderWidthVal = `px(1);
[%css {|border-width: $(borderWidthVal)|}];

/* Static */
[%css {|line-height: 1.5|}];
[%css {|letter-spacing: 1px|}];
[%css {|word-spacing: 2px|}];
/* Interpolated */
let lineHeightVal = `abs(1.5);
[%css {|line-height: $(lineHeightVal)|}];
let letterSpacingVal = `px(1);
[%css {|letter-spacing: $(letterSpacingVal)|}];
let wordSpacingVal = `px(2);
[%css {|word-spacing: $(wordSpacingVal)|}];

/* Static */
[%css {|table-layout: auto|}];
[%css {|table-layout: fixed|}];
/* Interpolated */
let tableLayoutVal = `fixed;
[%css {|table-layout: $(tableLayoutVal)|}];

/* Static */
[%css {|border-collapse: separate|}];
[%css {|border-collapse: collapse|}];
/* Interpolated */
let borderCollapseVal = `collapse;
[%css {|border-collapse: $(borderCollapseVal)|}];

/* Static */
[%css {|float: left|}];
[%css {|float: right|}];
[%css {|float: none|}];
/* Interpolated */
let floatVal = `left;
[%css {|float: $(floatVal)|}];

/* Static */
[%css {|clear: both|}];
[%css {|clear: left|}];
[%css {|clear: right|}];
/* Interpolated */
let clearVal = `both;
[%css {|clear: $(clearVal)|}];

/* Static */
[%css {|accent-color: auto|}];
/* Interpolated */
let accentColorVal = CSS.hex("0066cc");
[%css {|accent-color: $(accentColorVal)|}];

/* =============================================================================
   CSS FLEX SHORTHAND (existing from flex.t)
   ============================================================================= */

/* Static */
[%css {| flex: auto; |}];
[%css {| flex: initial; |}];
[%css {| flex: none; |}];
[%css {| flex: 2; |}];
[%css {| flex: 10em; |}];
[%css {| flex: 30%; |}];
[%css {| flex: min-content; |}];
[%css {| flex: 1 30px; |}];
[%css {| flex: 2 2; |}];
[%css {| flex: 2 2 10%; |}];
[%css {| flex: 2 2 10em; |}];
[%css {| flex: 2 2 min-content; |}];

/* =============================================================================
   CSS MINIFY BASIC (multiple properties)
   ============================================================================= */

let _styles1 = [%css {|color: blue; margin: 10px|}];
let _styles2 = [%css
  {|display: flex; justify-content: center; align-items: center|}
];
let _styles3 = [%css
  {|background-color: red; padding: 20px 15px; border: 1px solid black|}
];

/* =============================================================================
   CSS MINIFY INTERPOLATION
   ============================================================================= */

let myColor = CSS.hex("ff0000");
let mySize = `px(20);

let _stylesMinify1 = [%css {|color: $(myColor)|}];
let _stylesMinify2 = [%css {|margin: $(mySize); padding: $(mySize)|}];

let bgColorMinify = CSS.rgb(255, 255, 255);
let _stylesMinify3 = [%css
  {|background-color: $(bgColorMinify); border: 1px solid $(myColor)|}
];

/* =============================================================================
   CSS RUBY LAYOUT
   ============================================================================= */

/* Static */
[%css {|display: ruby|}];
[%css {|display: ruby-base|}];
[%css {|display: ruby-text|}];
[%css {|display: ruby-base-container|}];
[%css {|display: ruby-text-container|}];

/* =============================================================================
   CSS IMAGE RENDERING
   ============================================================================= */

/* Static */
[%css {|image-rendering: auto;|}];
[%css {|image-rendering: smooth;|}];
[%css {|image-rendering: high-quality;|}];
[%css {|image-rendering: pixelated;|}];
[%css {|image-rendering: crisp-edges;|}];

/* =============================================================================
   END OF ALL INTERPOLATIONS TEST
   ============================================================================= */
