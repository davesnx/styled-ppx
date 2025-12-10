/* =============================================================================
   ALL CX2 INTERPOLATIONS TEST
   This file combines all valid cx2 test cases with interpolated versions
   ============================================================================= */

/* --- Module Definitions for Interpolation --- */
module Color = {
  module Background = {
    let boxDark = `hex("000000");
  };
  module Shadow = {
    let elevation1 = `rgba((0, 0, 0, `num(0.03)));
  };
  let text = CSS.hex("444");
  let background = CSS.hex("333");
};

module X = {
  let value = 1.;
  let flex1 = `num(1.);
  let min = `px(500);
};

/* Font variables for interpolation */
let font = `sansSerif;
let fonts = [|`custom("Inter"), `sansSerif|];

/* =============================================================================
   CSS ANIMATIONS
   ============================================================================= */
let foo = [%keyframe2 {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];
let bar = [%keyframe2 {|0% { opacity: 0.0 } 100% { opacity: 1.0 }|}];

/* Static */
[%cx2 {|animation-name: random|}];
[%cx2 {|animation-name: foo, bar|}];
/* Interpolated - Note: keyframe interpolation with animation-name has type constraints */
/* [%cx2 {|animation-name: $(foo)|}]; */
/* [%cx2 {|animation-name: $(foo), $(bar)|}]; */

/* Static */
[%cx2 {|animation-duration: 0s|}];
[%cx2 {|animation-duration: 1s|}];
[%cx2 {|animation-duration: 100ms|}];
/* Interpolated */
let animDuration = `s(1);
let animDuration2 = `ms(100);
[%cx2 {|animation-duration: $(animDuration)|}];
[%cx2 {|animation-duration: $(animDuration2)|}];

/* Static */
[%cx2 {|animation-timing-function: ease|}];
[%cx2 {|animation-timing-function: linear|}];
[%cx2 {|animation-timing-function: ease-in|}];
[%cx2 {|animation-timing-function: ease-out|}];
[%cx2 {|animation-timing-function: ease-in-out|}];
/* Interpolated */
let animTiming = `ease;
[%cx2 {|animation-timing-function: $(animTiming)|}];

/* Static */
[%cx2 {|animation-iteration-count: infinite|}];
[%cx2 {|animation-iteration-count: 8|}];
/* Interpolated */
let animIterCount = `infinite;
let animIterNum = `count(8.);
[%cx2 {|animation-iteration-count: $(animIterCount)|}];
[%cx2 {|animation-iteration-count: $(animIterNum)|}];

/* Static */
[%cx2 {|animation-direction: normal|}];
[%cx2 {|animation-direction: alternate|}];
[%cx2 {|animation-direction: reverse|}];
/* Interpolated */
let animDir = `normal;
[%cx2 {|animation-direction: $(animDir)|}];

/* Static */
[%cx2 {|animation-play-state: running|}];
[%cx2 {|animation-play-state: paused|}];
/* Interpolated */
let animPlayState = `running;
[%cx2 {|animation-play-state: $(animPlayState)|}];

/* Static */
[%cx2 {|animation-delay: 1s|}];
[%cx2 {|animation-delay: -1s|}];
/* Interpolated */
let animDelay = `s(1);
[%cx2 {|animation-delay: $(animDelay)|}];

/* Static */
[%cx2 {|animation-fill-mode: none|}];
[%cx2 {|animation-fill-mode: forwards|}];
[%cx2 {|animation-fill-mode: backwards|}];
[%cx2 {|animation-fill-mode: both|}];
/* Interpolated */
let animFillMode = `both;
[%cx2 {|animation-fill-mode: $(animFillMode)|}];

/* =============================================================================
   CSS BACKGROUNDS AND BORDERS
   ============================================================================= */

/* Static */
[%cx2 {|background-repeat: space|}];
[%cx2 {|background-repeat: round|}];
[%cx2 {|background-repeat: repeat repeat|}];
/* Interpolated */
let bgRepeat = `space;
[%cx2 {|background-repeat: $(bgRepeat)|}];

/* Static */
[%cx2 {|background-attachment: local|}];
/* Interpolated */
let bgAttach = `local;
[%cx2 {|background-attachment: $(bgAttach)|}];

/* Static */
[%cx2 {|background-clip: border-box|}];
[%cx2 {|background-clip: padding-box|}];
[%cx2 {|background-clip: content-box|}];
[%cx2 {|background-clip: text|}];
/* Interpolated */
let bgClip = `borderBox;
[%cx2 {|background-clip: $(bgClip)|}];

/* Static */
[%cx2 {|background-origin: border-box|}];
[%cx2 {|background-origin: padding-box|}];
[%cx2 {|background-origin: content-box|}];
/* Interpolated */
let bgOrigin = `borderBox;
[%cx2 {|background-origin: $(bgOrigin)|}];

/* Static */
[%cx2 {|background-size: auto|}];
[%cx2 {|background-size: cover|}];
[%cx2 {|background-size: contain|}];
[%cx2 {|background-size: 10px|}];
[%cx2 {|background-size: 50%|}];
/* Interpolated */
let bgSize = `cover;
[%cx2 {|background-size: $(bgSize)|}];

/* Static */
[%cx2 {|background: blue|}];
[%cx2 {|background: border-box|}];
/* Interpolated */
let bgColor = CSS.hex("0000ff");
[%cx2 {|background: $(bgColor)|}];

/* Static */
[%cx2 {|border-top-left-radius: 0|}];
[%cx2 {|border-top-left-radius: 50%|}];
[%cx2 {|border-radius: 10px|}];
[%cx2 {|border-radius: 50%|}];
/* Interpolated */
let borderRad = `px(10);
let borderRadPct = `percent(50.);
[%cx2 {|border-radius: $(borderRad)|}];
[%cx2 {|border-radius: $(borderRadPct)|}];

/* Static */
[%cx2 {|box-shadow: 1px 1px|}];
[%cx2 {|box-shadow: 0 0 black|}];
[%cx2 {|box-shadow: 1px 2px 3px black|}];
[%cx2 {|box-shadow: 1px 2px 3px 4px black|}];
[%cx2 {|box-shadow: inset 1px 2px 3px 4px black|}];
/* Interpolated - box-shadow uses different interpolation approach in cx2
   See box-shadow-interpolation.t for examples using standalone tool */
/* let singleShadow = CSS.BoxShadow.box(~x=`px(2), ~y=`px(4), ~blur=`px(8), CSS.hex("000"));
   [%cx2 {|box-shadow: $(singleShadow)|}]; */

/* Static */
[%cx2 {|background-position: bottom;|}];
[%cx2 {|background-position-x: 50%;|}];
[%cx2 {|background-position-y: 0;|}];
/* Interpolated - background-position uses different type constraints */
/* let bgPosX = `percent(50.);
   let bgPosY = `px(0);
   [%cx2 {|background-position-x: $(bgPosX)|}];
   [%cx2 {|background-position-y: $(bgPosY)|}]; */

/* =============================================================================
   CSS BASIC USER INTERFACE
   ============================================================================= */

/* Static */
[%cx2 {|box-sizing: border-box|}];
[%cx2 {|box-sizing: content-box|}];
/* Interpolated */
let boxSizing = `borderBox;
[%cx2 {|box-sizing: $(boxSizing)|}];

/* Static */
[%cx2 {|outline-style: auto|}];
[%cx2 {|outline-style: none|}];
[%cx2 {|outline-style: solid|}];
/* Interpolated */
let outlineStyle = `solid;
[%cx2 {|outline-style: $(outlineStyle)|}];

/* Static */
[%cx2 {|outline-offset: -5px|}];
[%cx2 {|outline-offset: 0|}];
[%cx2 {|outline-offset: 5px|}];
/* Interpolated */
let outlineOff = `px(5);
[%cx2 {|outline-offset: $(outlineOff)|}];

/* Static */
[%cx2 {|resize: none|}];
[%cx2 {|resize: both|}];
[%cx2 {|resize: horizontal|}];
[%cx2 {|resize: vertical|}];
/* Interpolated */
let resizeVal = `both;
[%cx2 {|resize: $(resizeVal)|}];

/* Static */
[%cx2 {|text-overflow: clip|}];
[%cx2 {|text-overflow: ellipsis|}];
/* Interpolated */
let textOverflow = `ellipsis;
[%cx2 {|text-overflow: $(textOverflow)|}];

/* Static */
[%cx2 {|cursor: default|}];
[%cx2 {|cursor: pointer|}];
[%cx2 {|cursor: none|}];
/* Interpolated */
let cursorVal = `pointer;
[%cx2 {|cursor: $(cursorVal)|}];

/* Static */
[%cx2 {|caret-color: auto|}];
[%cx2 {|caret-color: green|}];
/* Interpolated */
let caretCol = CSS.hex("00ff00");
[%cx2 {|caret-color: $(caretCol)|}];

/* Static */
[%cx2 {|appearance: auto|}];
[%cx2 {|appearance: none|}];
/* Interpolated */
let appearanceVal = `none;
[%cx2 {|appearance: $(appearanceVal)|}];

/* Static */
[%cx2 {|user-select: auto|}];
[%cx2 {|user-select: text|}];
[%cx2 {|user-select: none|}];
/* Interpolated */
let userSelectVal = `none;
[%cx2 {|user-select: $(userSelectVal)|}];

/* =============================================================================
   CSS BOX ALIGNMENT
   ============================================================================= */

/* Static */
[%cx2 {|align-self: auto|}];
[%cx2 {|align-self: normal|}];
[%cx2 {|align-self: stretch|}];
[%cx2 {|align-self: center|}];
/* Interpolated */
let alignSelfVal = `center;
[%cx2 {|align-self: $(alignSelfVal)|}];

/* Static */
[%cx2 {|align-items: normal|}];
[%cx2 {|align-items: stretch|}];
[%cx2 {|align-items: center|}];
/* Interpolated */
let alignItemsVal = `stretch;
[%cx2 {|align-items: $(alignItemsVal)|}];

/* Static */
[%cx2 {|align-content: normal|}];
[%cx2 {|align-content: space-between|}];
[%cx2 {|align-content: center|}];
/* Interpolated */
let alignContentVal = `spaceBetween;
[%cx2 {|align-content: $(alignContentVal)|}];

/* Static */
[%cx2 {|justify-self: auto|}];
[%cx2 {|justify-self: normal|}];
[%cx2 {|justify-self: center|}];
/* Interpolated */
let justifySelfVal = `center;
[%cx2 {|justify-self: $(justifySelfVal)|}];

/* Static */
[%cx2 {|justify-items: normal|}];
[%cx2 {|justify-items: stretch|}];
[%cx2 {|justify-items: center|}];
/* Interpolated */
let justifyItemsVal = `start;
[%cx2 {|justify-items: $(justifyItemsVal)|}];

/* Static */
[%cx2 {|justify-content: normal|}];
[%cx2 {|justify-content: space-between|}];
[%cx2 {|justify-content: center|}];
/* Interpolated */
let justifyContentVal = `center;
[%cx2 {|justify-content: $(justifyContentVal)|}];

/* Static */
[%cx2 {|gap: 0 0|}];
[%cx2 {|gap: 0 1em|}];
[%cx2 {|gap: 1em|}];
/* Interpolated */
let gapVal = `em(1.);
[%cx2 {|gap: $(gapVal)|}];

/* Static */
[%cx2 {|column-gap: 0|}];
[%cx2 {|column-gap: 1em|}];
/* Interpolated */
let colGapVal = `em(1.);
[%cx2 {|column-gap: $(colGapVal)|}];

/* Static */
[%cx2 {|row-gap: 0|}];
[%cx2 {|row-gap: 1em|}];
/* Interpolated */
let rowGapVal = `em(1.);
[%cx2 {|row-gap: $(rowGapVal)|}];

/* =============================================================================
   CSS BOX SIZING
   ============================================================================= */

/* Static */
[%cx2 {|width: max-content|}];
[%cx2 {|width: min-content|}];
[%cx2 {|width: fit-content|}];
/* Interpolated */
let widthVal = `px(100);
[%cx2 {|width: $(widthVal)|}];

/* Static */
[%cx2 {|min-width: max-content|}];
[%cx2 {|min-width: min-content|}];
/* Interpolated */
let minWidthVal = `px(50);
[%cx2 {|min-width: $(minWidthVal)|}];

/* Static */
[%cx2 {|max-width: max-content|}];
[%cx2 {|max-width: min-content|}];
/* Interpolated */
let maxWidthVal = `px(500);
[%cx2 {|max-width: $(maxWidthVal)|}];

/* Static */
[%cx2 {|height: max-content|}];
[%cx2 {|height: min-content|}];
[%cx2 {|height: fit-content|}];
/* Interpolated */
let heightVal = `px(200);
[%cx2 {|height: $(heightVal)|}];

/* Static */
[%cx2 {|min-height: max-content|}];
[%cx2 {|min-height: min-content|}];
/* Interpolated */
let minHeightVal = `px(100);
[%cx2 {|min-height: $(minHeightVal)|}];

/* Static */
[%cx2 {|max-height: max-content|}];
[%cx2 {|max-height: min-content|}];
/* Interpolated */
let maxHeightVal = `px(400);
[%cx2 {|max-height: $(maxHeightVal)|}];

/* Static */
[%cx2 {|aspect-ratio: auto|}];
[%cx2 {|aspect-ratio: 2|}];
[%cx2 {|aspect-ratio: 16 / 9|}];
/* Interpolated */
let aspectRatio = `ratio((16, 9));
[%cx2 {|aspect-ratio: $(aspectRatio)|}];

/* =============================================================================
   CSS CALC
   ============================================================================= */

/* Static */
[%cx2 {|width: calc(50% + 4px)|}];
[%cx2 {|width: calc(20px - 10px)|}];
[%cx2 {|width: calc(100vh - calc(2rem + 120px))|}];
[%cx2 {|width: calc(100vh * 2)|}];
[%cx2 {|width: calc(2 * 120px)|}];

/* =============================================================================
   CSS CASCADING AND INHERITANCE
   ============================================================================= */

/* Static */
[%cx2 {|color: unset;|}];
[%cx2 {|font-weight: unset;|}];
[%cx2 {|background-image: unset;|}];
[%cx2 {|width: unset;|}];

/* =============================================================================
   CSS COLOR MODULE
   ============================================================================= */

/* Static */
[%cx2 {|color: rgba(0,0,0,.5);|}];
[%cx2 {|color: #F06;|}];
[%cx2 {|color: #FF0066;|}];
[%cx2 {|color: hsl(0,0%,0%);|}];
[%cx2 {|color: transparent;|}];
[%cx2 {|color: currentColor;|}];
/* Interpolated */
let colorVal = CSS.hex("ff0066");
[%cx2 {|color: $(colorVal)|}];
let colorRgba = CSS.rgba(0, 0, 0, `num(0.5));
[%cx2 {|color: $(colorRgba)|}];

/* Static */
[%cx2 {|background-color: rgba(0,0,0,.5);|}];
[%cx2 {|background-color: #F06;|}];
[%cx2 {|background-color: transparent;|}];
/* Interpolated */
let bgColorVal = CSS.hex("ff0066");
[%cx2 {|background-color: $(bgColorVal)|}];

/* Static */
[%cx2 {|border-color: rgba(0,0,0,.5);|}];
[%cx2 {|border-color: #F06;|}];
[%cx2 {|border-color: transparent;|}];
/* Interpolated */
let borderColorVal = CSS.hex("ff0066");
[%cx2 {|border-color: $(borderColorVal)|}];

/* Static */
[%cx2 {|text-decoration-color: rgba(0,0,0,.5);|}];
[%cx2 {|text-decoration-color: #F06;|}];
/* Interpolated */
let textDecorColor = CSS.hex("ff0066");
[%cx2 {|text-decoration-color: $(textDecorColor)|}];

/* Static */
[%cx2 {|color: rebeccapurple;|}];
[%cx2 {|color: color-mix(in srgb, teal 65%, olive);|}];

/* =============================================================================
   CSS COLOR ADJUSTMENTS
   ============================================================================= */

/* Static */
[%cx2 {|color-adjust: economy|}];
[%cx2 {|color-adjust: exact|}];
[%cx2 {|forced-color-adjust: auto|}];
[%cx2 {|forced-color-adjust: none|}];
[%cx2 {|color-scheme: normal|}];
[%cx2 {|color-scheme: light|}];
[%cx2 {|color-scheme: dark|}];
[%cx2 {|color-scheme: light dark|}];

/* =============================================================================
   CSS COMPOSITING AND BLENDING
   ============================================================================= */

/* Static */
[%cx2 {|mix-blend-mode: normal|}];
[%cx2 {|mix-blend-mode: multiply|}];
[%cx2 {|mix-blend-mode: screen|}];
[%cx2 {|mix-blend-mode: overlay|}];
/* Interpolated */
let blendMode = `multiply;
[%cx2 {|mix-blend-mode: $(blendMode)|}];

/* Static */
[%cx2 {|isolation: auto|}];
[%cx2 {|isolation: isolate|}];
/* Interpolated */
let isolationVal = `isolate;
[%cx2 {|isolation: $(isolationVal)|}];

/* Static */
[%cx2 {|background-blend-mode: normal|}];
[%cx2 {|background-blend-mode: multiply|}];
/* Interpolated */
let bgBlendMode = `multiply;
[%cx2 {|background-blend-mode: $(bgBlendMode)|}];

/* =============================================================================
   CSS CONTAINMENT
   ============================================================================= */

/* Static */
[%cx2 {|contain: none|}];
[%cx2 {|contain: strict|}];
[%cx2 {|contain: content|}];
[%cx2 {|contain: size|}];
[%cx2 {|contain: layout|}];
[%cx2 {|contain: paint|}];

/* =============================================================================
   CSS CONTENT
   ============================================================================= */

/* Static */
[%cx2 {|quotes: auto|}];
[%cx2 {|content: "";|}];
[%cx2 {|content: counter(count, decimal);|}];
[%cx2 {|content: unset;|}];
[%cx2 {|content: normal;|}];
[%cx2 {|content: none;|}];
/* Interpolated */
let contentVal = `none;
[%cx2 {|content: $(contentVal)|}];

/* Static */
[%cx2 {|content: open-quote;|}];
[%cx2 {|content: close-quote;|}];
[%cx2 {|content: attr(href);|}];

/* =============================================================================
   CSS DISPLAY
   ============================================================================= */

/* Static */
[%cx2 {|display: run-in|}];
[%cx2 {|display: flow|}];
[%cx2 {|display: flow-root|}];
[%cx2 {|display: flex|}];
[%cx2 {|display: inline-flex|}];
[%cx2 {|display: grid|}];
[%cx2 {|display: inline-grid|}];
[%cx2 {|display: block|}];
[%cx2 {|display: inline|}];
[%cx2 {|display: none|}];
/* Interpolated */
let displayVal = `flex;
[%cx2 {|display: $(displayVal)|}];

/* =============================================================================
   CSS EASING FUNCTIONS
   ============================================================================= */

/* Static */
[%cx2 {|transition-timing-function: steps(2, jump-start)|}];
[%cx2 {|transition-timing-function: steps(2, jump-end)|}];
[%cx2 {|transition-timing-function: steps(1, jump-both)|}];
[%cx2 {|transition-timing-function: steps(2, jump-none)|}];

/* =============================================================================
   CSS FILTER EFFECTS
   ============================================================================= */

/* Static */
[%cx2 {|filter: none|}];
[%cx2 {|filter: url(#id)|}];
[%cx2 {|filter: blur(5px)|}];
[%cx2 {|filter: brightness(0.5)|}];
[%cx2 {|filter: contrast(150%)|}];
[%cx2 {|filter: grayscale(50%)|}];
[%cx2 {|filter: hue-rotate(50deg)|}];
[%cx2 {|filter: invert(50%)|}];
[%cx2 {|filter: opacity(50%)|}];
[%cx2 {|filter: sepia(50%)|}];
[%cx2 {|filter: saturate(150%)|}];
/* Interpolated */
let filterBlur = `blur(`px(5));
[%cx2 {|filter: $(filterBlur)|}];

/* Static */
[%cx2 {|backdrop-filter: none|}];
[%cx2 {|backdrop-filter: blur(5px)|}];
[%cx2 {|backdrop-filter: brightness(0.5)|}];
/* backdrop-filter interpolation not yet supported */

/* =============================================================================
   CSS FLEXIBLE BOX LAYOUT
   ============================================================================= */

/* Static */
[%cx2 {|align-content: flex-start|}];
[%cx2 {|align-content: flex-end|}];
[%cx2 {|align-items: flex-start|}];
[%cx2 {|align-items: flex-end|}];
[%cx2 {|flex: none|}];
[%cx2 {|flex: 5 7 10%|}];
[%cx2 {|flex: 2;|}];
/* Interpolated */
[%cx2 {|flex: $(X.flex1);|}];
/* flex with multiple interpolations has type constraints - see flexible-box-layout-module.t for PPX output */
/* [%cx2 {|flex: $(X.value) $(X.value);|}]; */
/* [%cx2 {|flex: $(X.value) $(X.value) $(X.min);|}]; */

/* Static */
[%cx2 {|flex-basis: auto|}];
[%cx2 {|flex-basis: content|}];
[%cx2 {|flex-basis: 1px|}];
/* Interpolated */
let flexBasisVal = `px(100);
[%cx2 {|flex-basis: $(flexBasisVal)|}];

/* Static */
[%cx2 {|flex-direction: row|}];
[%cx2 {|flex-direction: row-reverse|}];
[%cx2 {|flex-direction: column|}];
[%cx2 {|flex-direction: column-reverse|}];
/* Interpolated */
let flexDirVal = `row;
[%cx2 {|flex-direction: $(flexDirVal)|}];

/* Static */
[%cx2 {|flex-grow: 0|}];
[%cx2 {|flex-grow: 5|}];
/* Interpolated */
let flexGrowVal = `num(2.0);
[%cx2 {|flex-grow: $(flexGrowVal)|}];

/* Static */
[%cx2 {|flex-shrink: 1|}];
[%cx2 {|flex-shrink: 10|}];
/* Interpolated */
let flexShrinkVal = `num(0.5);
[%cx2 {|flex-shrink: $(flexShrinkVal)|}];

/* Static */
[%cx2 {|flex-wrap: nowrap|}];
[%cx2 {|flex-wrap: wrap|}];
[%cx2 {|flex-wrap: wrap-reverse|}];
/* Interpolated */
let flexWrapVal = `wrap;
[%cx2 {|flex-wrap: $(flexWrapVal)|}];

/* Static */
[%cx2 {|order: 0|}];
[%cx2 {|order: 1|}];
/* Interpolated */
let orderVal = `num(2);
[%cx2 {|order: $(orderVal)|}];

/* =============================================================================
   CSS FONTS
   ============================================================================= */

/* Static */
[%cx2 {|font-family: "Inter Semi Bold";|}];
[%cx2 {|font-family: Inter;|}];
[%cx2 {|font-family: Inter, Sans;|}];
/* font-family interpolation has specific type requirements - see fonts-module.t for examples */

/* Static */
[%cx2 {|font-size: xxx-large|}];
/* Interpolated */
let fontSize = `px(16);
[%cx2 {|font-size: $(fontSize)|}];

/* Static */
[%cx2 {|font-weight: 1|}];
[%cx2 {|font-weight: 90|}];
[%cx2 {|font-weight: 750|}];
[%cx2 {|font-weight: 1000|}];
/* Interpolated */
let fontWeight = `bold;
[%cx2 {|font-weight: $(fontWeight)|}];

/* Static */
[%cx2 {|font-style: oblique 15deg|}];
[%cx2 {|font-style: oblique -15deg|}];
/* Interpolated */
let fontStyle = `italic;
[%cx2 {|font-style: $(fontStyle)|}];

/* Static */
[%cx2 {|font-stretch: normal|}];
[%cx2 {|font-stretch: ultra-condensed|}];
[%cx2 {|font-stretch: condensed|}];

/* Static */
[%cx2 {|font-kerning: auto|}];
[%cx2 {|font-kerning: normal|}];
[%cx2 {|font-kerning: none|}];

/* =============================================================================
   CSS FRAGMENTATION
   ============================================================================= */

/* Static */
[%cx2 {|break-before: auto|}];
[%cx2 {|break-before: avoid|}];
[%cx2 {|break-before: page|}];
/* Interpolated */
let breakBeforeVal = `page;
[%cx2 {|break-before: $(breakBeforeVal)|}];

/* Static */
[%cx2 {|break-after: auto|}];
[%cx2 {|break-after: avoid|}];
/* Interpolated */
let breakAfterVal = `avoid;
[%cx2 {|break-after: $(breakAfterVal)|}];

/* Static */
[%cx2 {|break-inside: auto|}];
[%cx2 {|break-inside: avoid|}];
/* Interpolated */
let breakInsideVal = `avoid;
[%cx2 {|break-inside: $(breakInsideVal)|}];

/* Static */
[%cx2 {|box-decoration-break: slice|}];
[%cx2 {|box-decoration-break: clone|}];

/* Static */
[%cx2 {|orphans: 1|}];
[%cx2 {|orphans: 2|}];
[%cx2 {|widows: 1|}];
[%cx2 {|widows: 2|}];

/* =============================================================================
   CSS GRID LAYOUT
   ============================================================================= */

/* Static */
[%cx2 {|grid-template-columns: none|}];
[%cx2 {|grid-template-columns: auto|}];
[%cx2 {|grid-template-columns: 100px|}];
[%cx2 {|grid-template-columns: 1fr|}];
[%cx2 {|grid-template-columns: 100px 1fr auto|}];
[%cx2 {|grid-template-columns: repeat(2, 100px 1fr)|}];
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
[%cx2 {|grid-template-columns: $(gridColsValue)|}];

/* Static */
[%cx2 {|grid-template-rows: none|}];
[%cx2 {|grid-template-rows: auto|}];
[%cx2 {|grid-template-rows: 100px|}];
[%cx2 {|grid-template-rows: 1fr|}];

/* Static */
[%cx2 {|grid-template-areas: none|}];
[%cx2 {|grid-template-areas: 'articles'|}];
[%cx2 {|grid-template-areas: 'head head'|}];

/* Static */
[%cx2 {|grid-auto-columns: auto|}];
[%cx2 {|grid-auto-columns: 1fr|}];
[%cx2 {|grid-auto-columns: 100px|}];

/* Static */
[%cx2 {|grid-auto-rows: auto|}];
[%cx2 {|grid-auto-rows: 1fr|}];
[%cx2 {|grid-auto-rows: 100px|}];

/* Static */
[%cx2 {|grid-auto-flow: row|}];
[%cx2 {|grid-auto-flow: column|}];
[%cx2 {|grid-auto-flow: row dense|}];
/* Interpolated */
let gridAutoFlowVal = `row;
[%cx2 {|grid-auto-flow: $(gridAutoFlowVal)|}];

/* Static */
[%cx2 {|grid-column: auto|}];
[%cx2 {|grid-column: 1|}];
[%cx2 {|grid-column: -1|}];
[%cx2 {|grid-column: 1 / 1|}];
[%cx2 {|grid-column: 1 / -1|}];

/* Static */
[%cx2 {|grid-row: auto|}];
[%cx2 {|grid-row: 1|}];
[%cx2 {|grid-row: -1|}];
[%cx2 {|grid-row: 1 / 1|}];

/* Static */
[%cx2 {|grid-area: 1 / 1|}];
/* Interpolated */
let area = `num(33);
[%cx2 {|grid-area: $(area)|}];

/* Static */
[%cx2 {|grid-column-gap: 0|}];
[%cx2 {|grid-column-gap: 1em|}];
[%cx2 {|grid-row-gap: 0|}];
[%cx2 {|grid-row-gap: 1em|}];
[%cx2 {|grid-gap: 0 0|}];
[%cx2 {|grid-gap: 1em|}];

/* =============================================================================
   CSS LISTS
   ============================================================================= */

/* Static */
[%cx2 {|list-style-type: disclosure-closed|}];
[%cx2 {|list-style-type: disclosure-open|}];
[%cx2 {|list-style-type: disc|}];
[%cx2 {|list-style-type: circle|}];
[%cx2 {|list-style-type: square|}];
/* list-style-type interpolation uses Custom type */
let listStyleTypeVal = `Custom("disc");
[%cx2 {|list-style-type: $(listStyleTypeVal)|}];

/* Static */
[%cx2 {|counter-reset: foo|}];
[%cx2 {|counter-reset: foo 1|}];
[%cx2 {|counter-reset: none|}];

/* Static */
[%cx2 {|counter-set: foo|}];
[%cx2 {|counter-set: foo 1|}];
[%cx2 {|counter-set: none|}];

/* Static */
[%cx2 {|counter-increment: foo|}];
[%cx2 {|counter-increment: foo 1|}];
[%cx2 {|counter-increment: none|}];

/* =============================================================================
   CSS LOGICAL PROPERTIES
   ============================================================================= */

/* Static */
[%cx2 {|block-size: 100px|}];
[%cx2 {|inline-size: 100px|}];
[%cx2 {|min-block-size: 100px|}];
[%cx2 {|min-inline-size: 100px|}];
[%cx2 {|max-block-size: 100px|}];
[%cx2 {|max-inline-size: 100px|}];
/* Interpolated */
let blockSizeVal = `px(100);
[%cx2 {|block-size: $(blockSizeVal)|}];
let inlineSizeVal = `px(100);
[%cx2 {|inline-size: $(inlineSizeVal)|}];

/* Static */
[%cx2 {|margin-block: 10px|}];
[%cx2 {|margin-block: 10px 10px|}];
[%cx2 {|margin-block-start: 10px|}];
[%cx2 {|margin-block-end: 10px|}];
/* Interpolated */
let marginBlockVal = `px(10);
[%cx2 {|margin-block: $(marginBlockVal)|}];

/* Static */
[%cx2 {|margin-inline: 10px|}];
[%cx2 {|margin-inline-start: 10px|}];
[%cx2 {|margin-inline-end: 10px|}];
/* Interpolated */
let marginInlineVal = `px(20);
[%cx2 {|margin-inline: $(marginInlineVal)|}];

/* Static */
[%cx2 {|inset: 10px|}];
[%cx2 {|inset: 10px 10px|}];
[%cx2 {|inset-block: 10px|}];
[%cx2 {|inset-inline: 10px|}];
/* Interpolated */
let insetBlockVal = `px(0);
[%cx2 {|inset-block: $(insetBlockVal)|}];
let insetInlineVal = `px(0);
[%cx2 {|inset-inline: $(insetInlineVal)|}];

/* Static */
[%cx2 {|padding-block: 10px|}];
[%cx2 {|padding-block-start: 10px|}];
[%cx2 {|padding-inline: 10px|}];
[%cx2 {|padding-inline-start: 10px|}];
/* Interpolated */
let paddingBlockVal = `px(5);
[%cx2 {|padding-block: $(paddingBlockVal)|}];
let paddingInlineVal = `px(15);
[%cx2 {|padding-inline: $(paddingInlineVal)|}];

/* Static */
[%cx2 {|border-block: 1px|}];
[%cx2 {|border-block: 2px dotted|}];
[%cx2 {|border-inline: 1px|}];
[%cx2 {|border-inline: 2px dotted|}];

/* =============================================================================
   CSS MASKING
   ============================================================================= */

/* Static */
[%cx2 {|clip-path: url('#clip')|}];
[%cx2 {|clip-path: inset(50%)|}];
[%cx2 {|clip-path: polygon(50% 100%, 0 0, 100% 0)|}];
[%cx2 {|clip-path: border-box|}];
[%cx2 {|clip-path: none|}];

/* Static */
[%cx2 {|mask-image: none|}];
[%cx2 {|mask-image: url(image.png)|}];
/* Interpolated */
let maskedImageUrl = `url("https://www.example.com/mask.svg");
[%cx2 {|mask-image: $(maskedImageUrl)|}];

/* Static */
[%cx2 {|mask-repeat: repeat-x|}];
[%cx2 {|mask-repeat: no-repeat|}];
/* Interpolated */
let maskRepeatVal = `noRepeat;
[%cx2 {|mask-repeat: $(maskRepeatVal)|}];

/* Static */
[%cx2 {|mask-position: center|}];
[%cx2 {|mask-size: auto|}];
[%cx2 {|mask-size: cover|}];

/* =============================================================================
   CSS MOTION PATH
   ============================================================================= */

/* Static */
[%cx2 {|offset: none|}];
[%cx2 {|offset: auto|}];
[%cx2 {|offset: center|}];
[%cx2 {|offset: 200px 100px|}];
[%cx2 {|offset-path: none|}];
[%cx2 {|offset-distance: 10%|}];
[%cx2 {|offset-position: auto|}];
[%cx2 {|offset-anchor: auto|}];
[%cx2 {|offset-rotate: auto|}];

/* =============================================================================
   CSS MULTI-COLUMN LAYOUT
   ============================================================================= */

/* Static */
[%cx2 {|column-width: 10em|}];
[%cx2 {|column-width: auto|}];
/* Interpolated */
let colWidthVal = `em(10.);
[%cx2 {|column-width: $(colWidthVal)|}];

/* Static */
[%cx2 {|column-count: 2|}];
[%cx2 {|column-count: auto|}];
/* Interpolated */
let colCountVal = `count(3);
[%cx2 {|column-count: $(colCountVal)|}];

/* Static */
[%cx2 {|columns: 100px|}];
[%cx2 {|columns: 3|}];
[%cx2 {|columns: 10em 2|}];

/* Static */
[%cx2 {|column-rule-color: red|}];
[%cx2 {|column-rule-style: none|}];
[%cx2 {|column-rule-style: solid|}];
[%cx2 {|column-rule-width: 1px|}];

/* Static */
[%cx2 {|column-span: none|}];
[%cx2 {|column-span: all|}];
[%cx2 {|column-fill: auto|}];
[%cx2 {|column-fill: balance|}];

/* =============================================================================
   CSS OVERFLOW
   ============================================================================= */

/* Static */
[%cx2 {|line-clamp: none|}];
[%cx2 {|line-clamp: 1|}];
[%cx2 {|max-lines: none|}];
[%cx2 {|max-lines: 1|}];

/* Static */
[%cx2 {|overflow-x: visible|}];
[%cx2 {|overflow-x: hidden|}];
[%cx2 {|overflow-x: clip|}];
[%cx2 {|overflow-x: scroll|}];
[%cx2 {|overflow-x: auto|}];
/* overflow-x/y interpolation - see random.t for working examples */

/* Static */
[%cx2 {|overflow-y: visible|}];
[%cx2 {|overflow-y: hidden|}];
[%cx2 {|overflow-y: clip|}];
[%cx2 {|overflow-y: scroll|}];
[%cx2 {|overflow-y: auto|}];

/* Static */
[%cx2 {|overflow: hidden|}];

/* Static */
[%cx2 {|overflow-block: hidden|}];
[%cx2 {|overflow-inline: visible|}];

/* Static */
[%cx2 {|scrollbar-gutter: auto|}];
[%cx2 {|scrollbar-gutter: stable|}];

/* =============================================================================
   CSS OVERSCROLL BEHAVIOR
   ============================================================================= */

/* Static */
[%cx2 {|overscroll-behavior: contain|}];
[%cx2 {|overscroll-behavior: none|}];
[%cx2 {|overscroll-behavior: auto|}];
/* Interpolated */
let overscrollVal = `contain;
[%cx2 {|overscroll-behavior: $(overscrollVal)|}];

/* Static */
[%cx2 {|overscroll-behavior-x: contain|}];
[%cx2 {|overscroll-behavior-y: none|}];

/* =============================================================================
   CSS POINTER EVENTS
   ============================================================================= */

/* Static */
[%cx2 {|touch-action: auto|}];
[%cx2 {|touch-action: none|}];
[%cx2 {|touch-action: pan-x|}];
[%cx2 {|touch-action: pan-y|}];
[%cx2 {|touch-action: manipulation|}];
/* Interpolated */
let touchActionVal = `manipulation;
[%cx2 {|touch-action: $(touchActionVal)|}];

/* =============================================================================
   CSS POSITIONED LAYOUT
   ============================================================================= */

/* Static */
[%cx2 {|position: sticky|}];
[%cx2 {|position: relative|}];
[%cx2 {|position: absolute|}];
[%cx2 {|position: fixed|}];
/* position interpolation has different type constraints */

/* Interpolated positions */
let topVal = `px(10);
[%cx2 {|top: $(topVal)|}];
let rightVal = `px(20);
[%cx2 {|right: $(rightVal)|}];
let bottomVal = `px(30);
[%cx2 {|bottom: $(bottomVal)|}];
let leftVal = `px(40);
[%cx2 {|left: $(leftVal)|}];
let zIndexVal = `num(100);
[%cx2 {|z-index: $(zIndexVal)|}];

/* =============================================================================
   CSS SCROLL SNAP
   ============================================================================= */

/* Static */
[%cx2 {|scroll-margin: 0px|}];
[%cx2 {|scroll-margin: 6px 5px|}];
[%cx2 {|scroll-margin: 10px 20px 30px 40px|}];
[%cx2 {|scroll-padding: auto|}];
[%cx2 {|scroll-padding: 0px|}];
[%cx2 {|scroll-snap-align: none|}];
[%cx2 {|scroll-snap-align: start|}];
[%cx2 {|scroll-snap-align: center|}];
[%cx2 {|scroll-snap-stop: normal|}];
[%cx2 {|scroll-snap-stop: always|}];
[%cx2 {|scroll-snap-type: none|}];
[%cx2 {|scroll-snap-type: x mandatory|}];

/* =============================================================================
   CSS SCROLLBARS
   ============================================================================= */

/* Static */
[%cx2 {|scrollbar-color: auto|}];
[%cx2 {|scrollbar-color: red blue|}];
[%cx2 {|scrollbar-width: auto|}];
[%cx2 {|scrollbar-width: thin|}];
[%cx2 {|scrollbar-width: none|}];

/* =============================================================================
   CSS SVG POINTER EVENTS
   ============================================================================= */

/* Static */
[%cx2 {|pointer-events: auto|}];
[%cx2 {|pointer-events: visiblePainted|}];
[%cx2 {|pointer-events: visibleFill|}];
[%cx2 {|pointer-events: visibleStroke|}];
[%cx2 {|pointer-events: visible|}];
[%cx2 {|pointer-events: painted|}];
[%cx2 {|pointer-events: fill|}];
[%cx2 {|pointer-events: stroke|}];
[%cx2 {|pointer-events: all|}];
[%cx2 {|pointer-events: none|}];
/* Interpolated */
let pointerEventsVal = `none;
[%cx2 {|pointer-events: $(pointerEventsVal)|}];

/* =============================================================================
   CSS TEXT DECORATION
   ============================================================================= */

/* Static */
[%cx2 {|text-decoration-line: none|}];
[%cx2 {|text-decoration-line: underline|}];
[%cx2 {|text-decoration-line: overline|}];
[%cx2 {|text-decoration-line: line-through|}];
/* text-decoration-line interpolation uses Value type */

/* Static */
[%cx2 {|text-decoration-style: solid|}];
[%cx2 {|text-decoration-style: double|}];
[%cx2 {|text-decoration-style: dotted|}];
[%cx2 {|text-decoration-style: dashed|}];
[%cx2 {|text-decoration-style: wavy|}];

/* Static */
[%cx2 {|text-underline-position: auto|}];
[%cx2 {|text-underline-position: under|}];
[%cx2 {|text-emphasis-style: none|}];
[%cx2 {|text-emphasis-style: filled|}];
[%cx2 {|text-emphasis-color: green|}];

/* Static */
[%cx2 {|text-shadow: none|}];
[%cx2 {|text-shadow: 1px 1px|}];
[%cx2 {|text-shadow: 0 0 black|}];
[%cx2 {|text-shadow: 1px 2px 3px black|}];
/* text-shadow interpolation uses different types - see box-shadow-interpolation.t */

/* Static */
[%cx2 {|text-decoration-skip: none|}];
[%cx2 {|text-decoration-skip: objects|}];
[%cx2 {|text-decoration-skip-ink: none|}];
[%cx2 {|text-decoration-skip-ink: auto|}];
[%cx2 {|text-underline-offset: auto|}];
[%cx2 {|text-underline-offset: 3px|}];
[%cx2 {|text-decoration-thickness: auto|}];
[%cx2 {|text-decoration-thickness: from-font|}];

/* =============================================================================
   CSS TEXT MODULE
   ============================================================================= */

/* Static */
[%cx2 {|text-transform: full-width|}];
[%cx2 {|text-transform: uppercase|}];
[%cx2 {|text-transform: lowercase|}];
/* Interpolated */
let textTransformVal = `uppercase;
[%cx2 {|text-transform: $(textTransformVal)|}];

/* Static */
[%cx2 {|tab-size: 4|}];
[%cx2 {|tab-size: 1em|}];

/* Static */
[%cx2 {|line-break: auto|}];
[%cx2 {|line-break: loose|}];
[%cx2 {|line-break: normal|}];
[%cx2 {|line-break: strict|}];

/* Static */
[%cx2 {|word-break: normal|}];
[%cx2 {|word-break: keep-all|}];
[%cx2 {|word-break: break-all|}];
/* Interpolated */
let wordBreakVal = `breakAll;
[%cx2 {|word-break: $(wordBreakVal)|}];

/* Static */
[%cx2 {|white-space: break-spaces|}];
[%cx2 {|white-space: nowrap|}];
/* Interpolated */
let whiteSpaceVal = `nowrap;
[%cx2 {|white-space: $(whiteSpaceVal)|}];

/* Static */
[%cx2 {|hyphens: auto|}];
[%cx2 {|hyphens: manual|}];
[%cx2 {|hyphens: none|}];
/* Interpolated */
let hyphensVal = `auto;
[%cx2 {|hyphens: $(hyphensVal)|}];

/* Static */
[%cx2 {|overflow-wrap: normal|}];
[%cx2 {|overflow-wrap: break-word|}];
[%cx2 {|overflow-wrap: anywhere|}];
/* Interpolated */
let overflowWrapVal = `breakWord;
[%cx2 {|overflow-wrap: $(overflowWrapVal)|}];

/* Static */
[%cx2 {|text-align: start|}];
[%cx2 {|text-align: end|}];
[%cx2 {|text-align: left|}];
[%cx2 {|text-align: right|}];
[%cx2 {|text-align: center|}];
[%cx2 {|text-align: justify|}];
/* Interpolated */
let textAlignVal = `center;
[%cx2 {|text-align: $(textAlignVal)|}];

/* Static */
[%cx2 {|text-wrap: wrap|}];
[%cx2 {|text-wrap: nowrap|}];
[%cx2 {|text-wrap: balance|}];
[%cx2 {|text-wrap: pretty|}];

/* =============================================================================
   CSS TRANSFORMS
   ============================================================================= */

/* Static */
[%cx2 {|transform: none|}];
[%cx2 {|transform: translate(5px)|}];
[%cx2 {|transform: translate(5px, 10px)|}];
[%cx2 {|transform: translateY(5px)|}];
[%cx2 {|transform: translateX(5px)|}];
[%cx2 {|transform: scale(2)|}];
[%cx2 {|transform: scale(2, -1)|}];
[%cx2 {|transform: rotate(45deg)|}];
[%cx2 {|transform: skew(45deg)|}];
[%cx2 {|transform: translate3d(0, 0, 5px)|}];
[%cx2 {|transform: perspective(600px)|}];
/* Interpolated */
let transformVal = `translate((`px(10), `px(20)));
[%cx2 {|transform: $(transformVal)|}];

/* Static */
[%cx2 {|transform-origin: 10px|}];
[%cx2 {|transform-origin: top|}];
[%cx2 {|transform-origin: top left|}];
[%cx2 {|transform-origin: 50% 100%|}];
/* Interpolated */
let transformOriginVal = `center;
[%cx2 {|transform-origin: $(transformOriginVal)|}];

/* Static */
[%cx2 {|transform-box: border-box|}];
[%cx2 {|transform-box: fill-box|}];
[%cx2 {|transform-box: view-box|}];

/* Static */
[%cx2 {|translate: none|}];
[%cx2 {|translate: 50%|}];
[%cx2 {|translate: 50% 50%|}];

/* Static */
[%cx2 {|scale: none|}];
[%cx2 {|scale: 2|}];
[%cx2 {|scale: 2 2|}];

/* Static */
[%cx2 {|rotate: none|}];
[%cx2 {|rotate: 45deg|}];

/* Static */
[%cx2 {|transform-style: flat|}];
[%cx2 {|transform-style: preserve-3d|}];

/* Static */
[%cx2 {|perspective: none|}];
[%cx2 {|perspective: 600px|}];
/* Interpolated */
let perspectiveVal = `px(1000);
[%cx2 {|perspective: $(perspectiveVal)|}];

/* Static */
[%cx2 {|perspective-origin: 10px|}];
[%cx2 {|perspective-origin: top|}];

/* Static */
[%cx2 {|backface-visibility: visible|}];
[%cx2 {|backface-visibility: hidden|}];
/* Interpolated */
let backfaceVisVal = `hidden;
[%cx2 {|backface-visibility: $(backfaceVisVal)|}];

/* =============================================================================
   CSS TRANSITIONS
   ============================================================================= */

/* Static */
[%cx2 {|transition-property: none|}];
[%cx2 {|transition-property: all|}];
[%cx2 {|transition-property: width|}];
[%cx2 {|transition-duration: 0s|}];
[%cx2 {|transition-duration: 1s|}];
[%cx2 {|transition-timing-function: ease|}];
[%cx2 {|transition-timing-function: linear|}];
[%cx2 {|transition-delay: 1s|}];
[%cx2 {|transition-delay: -1s|}];
[%cx2 {|transition-behavior: normal|}];
[%cx2 {|transition-behavior: allow-discrete|}];
[%cx2 {|transition: margin-right 2s, opacity 0.5s|}];

/* transition interpolation has specific type constraints - see transitions.t for examples */

/* =============================================================================
   CSS VERTICAL ALIGN
   ============================================================================= */

/* Static */
[%cx2 {|vertical-align: baseline|}];
[%cx2 {|vertical-align: sub|}];
[%cx2 {|vertical-align: super|}];
[%cx2 {|vertical-align: top|}];
[%cx2 {|vertical-align: text-top|}];
[%cx2 {|vertical-align: middle|}];
[%cx2 {|vertical-align: bottom|}];
[%cx2 {|vertical-align: text-bottom|}];
/* Interpolated */
let verticalAlignVal = `middle;
[%cx2 {|vertical-align: $(verticalAlignVal)|}];

/* =============================================================================
   CSS WILL CHANGE
   ============================================================================= */

/* Static */
[%cx2 {|will-change: scroll-position|}];
[%cx2 {|will-change: contents|}];
[%cx2 {|will-change: transform|}];
[%cx2 {|will-change: top, left|}];

/* =============================================================================
   CSS WRITING MODES
   ============================================================================= */

/* Static */
[%cx2 {|direction: ltr|}];
[%cx2 {|direction: rtl|}];
[%cx2 {|unicode-bidi: normal|}];
[%cx2 {|unicode-bidi: embed|}];
[%cx2 {|unicode-bidi: isolate|}];
[%cx2 {|writing-mode: horizontal-tb|}];
[%cx2 {|writing-mode: vertical-rl|}];
[%cx2 {|writing-mode: vertical-lr|}];
[%cx2 {|text-orientation: mixed|}];
[%cx2 {|text-orientation: upright|}];
[%cx2 {|text-orientation: sideways|}];
[%cx2 {|text-combine-upright: none|}];
[%cx2 {|text-combine-upright: all|}];

/* =============================================================================
   CSS RANDOM / MISC
   ============================================================================= */

/* Static */
[%cx2 {|scroll-behavior: auto|}];
[%cx2 {|scroll-behavior: smooth|}];
/* Interpolated */
let scrollBehaviorVal = `smooth;
[%cx2 {|scroll-behavior: $(scrollBehaviorVal)|}];

/* Static */
[%cx2 {|overflow-anchor: none|}];
[%cx2 {|overflow-anchor: auto|}];

/* Static */
[%cx2 {|-moz-appearance: textfield;|}];
[%cx2 {|-webkit-appearance: none;|}];
[%cx2 {|-webkit-box-orient: vertical;|}];

/* Interpolated colors */
let c = CSS.hex("e15a46");
[%cx2 {|background-color: $(c);|}];
/* fill interpolation uses Fill type, not color */
[%cx2 {|fill: currentColor;|}];

/* Static */
[%cx2 {|border: none;|}];
[%cx2 {|bottom: unset;|}];
[%cx2 {|box-shadow: none;|}];
[%cx2 {|break-inside: avoid;|}];
[%cx2 {|caret-color: #e15a46;|}];
[%cx2 {|color: inherit;|}];
[%cx2 {|color: var(--color-link);|}];

/* Static */
[%cx2 {|display: -webkit-box;|}];
[%cx2 {|display: contents;|}];
[%cx2 {|display: table;|}];

/* Static */
[%cx2 {|grid-column-end: span 2;|}];
[%cx2 {|grid-column: unset;|}];
[%cx2 {|grid-row: unset;|}];
[%cx2 {|grid-template-columns: max-content max-content;|}];
[%cx2 {|grid-template-columns: repeat(2, auto);|}];
[%cx2 {|grid-template-columns: repeat(3, auto);|}];
[%cx2 {|height: fit-content;|}];
[%cx2 {|justify-items: start;|}];
[%cx2 {|justify-self: unset;|}];
[%cx2 {|left: unset;|}];

/* Static */
[%cx2 {|mask-position: center center;|}];
[%cx2 {|mask-repeat: no-repeat;|}];
[%cx2 {|max-width: max-content;|}];
[%cx2 {|outline: none;|}];
[%cx2 {|position: unset;|}];
[%cx2 {|resize: none;|}];
[%cx2 {|right: calc(50% - 4px);|}];

/* Static */
[%cx2 {|stroke-opacity: 0;|}];

/* stroke interpolation uses Stroke type, not color */

/* Static */
[%cx2 {|top: calc(50% - 1px);|}];
[%cx2 {|top: unset;|}];
[%cx2 {|touch-action: pan-x pan-y;|}];
[%cx2 {|transform-origin: center bottom;|}];
[%cx2 {|transform-origin: center left;|}];
[%cx2 {|transform-origin: 2px;|}];
[%cx2 {|transform-origin: bottom;|}];
[%cx2 {|transform: none;|}];
[%cx2 {|width: fit-content;|}];
[%cx2 {|width: max-content;|}];

/* Static */
[%cx2 {|transition-delay: 240ms|}];
[%cx2 {|animation-duration: 150ms|}];

/* Static */
[%cx2 {|border-width: thin|}];
[%cx2 {|outline-width: medium|}];
[%cx2 {|outline: medium solid red|}];

/* Static */
[%cx2 {|object-fit: contain|}];
[%cx2 {|object-fit: cover|}];
[%cx2 {|object-fit: fill|}];
[%cx2 {|object-fit: none|}];
/* Interpolated */
let objectFitVal = `contain;
[%cx2 {|object-fit: $(objectFitVal)|}];

/* Static */
[%cx2 {|object-position: top|}];
[%cx2 {|object-position: center|}];
[%cx2 {|object-position: 25% 75%|}];

/* Static */
[%cx2 {|opacity: 0.5|}];
/* Interpolated */
let opacityVal = 0.8;
[%cx2 {|opacity: $(opacityVal)|}];

/* Static */
[%cx2 {|visibility: visible|}];
[%cx2 {|visibility: hidden|}];
/* Interpolated */
let visibilityVal = `hidden;
[%cx2 {|visibility: $(visibilityVal)|}];

/* Static */
[%cx2 {|margin: 10px|}];
[%cx2 {|margin-top: 5px|}];
[%cx2 {|margin-right: 10px|}];
[%cx2 {|margin-bottom: 15px|}];
[%cx2 {|margin-left: 20px|}];
/* Interpolated */
let marginVal = `px(10);
[%cx2 {|margin: $(marginVal)|}];
let marginTopVal = `px(5);
[%cx2 {|margin-top: $(marginTopVal)|}];

/* Static */
[%cx2 {|padding: 8px|}];
[%cx2 {|padding-top: 4px|}];
[%cx2 {|padding-right: 8px|}];
[%cx2 {|padding-bottom: 12px|}];
[%cx2 {|padding-left: 16px|}];
/* Interpolated */
let paddingVal = `px(8);
[%cx2 {|padding: $(paddingVal)|}];
let paddingTopVal = `px(4);
[%cx2 {|padding-top: $(paddingTopVal)|}];

/* Static */
[%cx2 {|border-style: solid|}];
[%cx2 {|border-width: 1px|}];
/* Interpolated */
let borderStyleVal = `solid;
[%cx2 {|border-style: $(borderStyleVal)|}];
let borderWidthVal = `px(1);
[%cx2 {|border-width: $(borderWidthVal)|}];

/* Static */
[%cx2 {|line-height: 1.5|}];
[%cx2 {|letter-spacing: 1px|}];
[%cx2 {|word-spacing: 2px|}];
/* Interpolated */
let lineHeightVal = `abs(1.5);
[%cx2 {|line-height: $(lineHeightVal)|}];
let letterSpacingVal = `px(1);
[%cx2 {|letter-spacing: $(letterSpacingVal)|}];
let wordSpacingVal = `px(2);
[%cx2 {|word-spacing: $(wordSpacingVal)|}];

/* Static */
[%cx2 {|table-layout: auto|}];
[%cx2 {|table-layout: fixed|}];
/* Interpolated */
let tableLayoutVal = `fixed;
[%cx2 {|table-layout: $(tableLayoutVal)|}];

/* Static */
[%cx2 {|border-collapse: separate|}];
[%cx2 {|border-collapse: collapse|}];
/* Interpolated */
let borderCollapseVal = `collapse;
[%cx2 {|border-collapse: $(borderCollapseVal)|}];

/* Static */
[%cx2 {|float: left|}];
[%cx2 {|float: right|}];
[%cx2 {|float: none|}];
/* Interpolated */
let floatVal = `left;
[%cx2 {|float: $(floatVal)|}];

/* Static */
[%cx2 {|clear: both|}];
[%cx2 {|clear: left|}];
[%cx2 {|clear: right|}];
/* Interpolated */
let clearVal = `both;
[%cx2 {|clear: $(clearVal)|}];

/* Static */
[%cx2 {|accent-color: auto|}];
/* Interpolated */
let accentColorVal = CSS.hex("0066cc");
[%cx2 {|accent-color: $(accentColorVal)|}];

/* =============================================================================
   CSS FLEX SHORTHAND (existing from flex.t)
   ============================================================================= */

/* Static */
[%cx2 {| flex: auto; |}];
[%cx2 {| flex: initial; |}];
[%cx2 {| flex: none; |}];
[%cx2 {| flex: 2; |}];
[%cx2 {| flex: 10em; |}];
[%cx2 {| flex: 30%; |}];
[%cx2 {| flex: min-content; |}];
[%cx2 {| flex: 1 30px; |}];
[%cx2 {| flex: 2 2; |}];
[%cx2 {| flex: 2 2 10%; |}];
[%cx2 {| flex: 2 2 10em; |}];
[%cx2 {| flex: 2 2 min-content; |}];

/* =============================================================================
   CSS MINIFY BASIC (multiple properties)
   ============================================================================= */

let styles1 = [%cx2 {|color: blue; margin: 10px|}];
let styles2 = [%cx2
  {|display: flex; justify-content: center; align-items: center|}
];
let styles3 = [%cx2
  {|background-color: red; padding: 20px 15px; border: 1px solid black|}
];

/* =============================================================================
   CSS MINIFY INTERPOLATION
   ============================================================================= */

let myColor = CSS.hex("ff0000");
let mySize = `px(20);

let stylesMinify1 = [%cx2 {|color: $(myColor)|}];
let stylesMinify2 = [%cx2 {|margin: $(mySize); padding: $(mySize)|}];

let bgColorMinify = CSS.rgb(255, 255, 255);
let stylesMinify3 = [%cx2
  {|background-color: $(bgColorMinify); border: 1px solid $(myColor)|}
];

/* =============================================================================
   CSS RUBY LAYOUT
   ============================================================================= */

/* Static */
[%cx2 {|display: ruby|}];
[%cx2 {|display: ruby-base|}];
[%cx2 {|display: ruby-text|}];
[%cx2 {|display: ruby-base-container|}];
[%cx2 {|display: ruby-text-container|}];

/* =============================================================================
   CSS IMAGE RENDERING
   ============================================================================= */

/* Static */
[%cx2 {|image-rendering: auto;|}];
[%cx2 {|image-rendering: smooth;|}];
[%cx2 {|image-rendering: high-quality;|}];
[%cx2 {|image-rendering: pixelated;|}];
[%cx2 {|image-rendering: crisp-edges;|}];

/* =============================================================================
   END OF ALL INTERPOLATIONS TEST
   ============================================================================= */
