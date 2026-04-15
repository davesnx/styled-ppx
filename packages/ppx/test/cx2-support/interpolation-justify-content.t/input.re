/* Test complete interpolation support in cx2 for various properties */

/* Box Alignment properties */
let justifyContent = `center;
let _ = [%cx2 {|justify-content: $(justifyContent)|}];

let alignItems = `stretch;
let _ = [%cx2 {|align-items: $(alignItems)|}];

let alignSelf = `flexEnd;
let _ = [%cx2 {|align-self: $(alignSelf)|}];

let alignContent = `spaceBetween;
let _ = [%cx2 {|align-content: $(alignContent)|}];

let justifyItems = `start;
let _ = [%cx2 {|justify-items: $(justifyItems)|}];

let justifySelf = `end_;
let _ = [%cx2 {|justify-self: $(justifySelf)|}];

/* Flexbox properties */
let flexDirection = `row;
let _ = [%cx2 {|flex-direction: $(flexDirection)|}];

let flexWrap = `wrap;
let _ = [%cx2 {|flex-wrap: $(flexWrap)|}];

let flexGrow = 1.0;
let _ = [%cx2 {|flex-grow: $(flexGrow)|}];

let flexShrink = 0.5;
let _ = [%cx2 {|flex-shrink: $(flexShrink)|}];

let flexBasis = `px(100);
let _ = [%cx2 {|flex-basis: $(flexBasis)|}];

/* Display and visibility */
let display = `flex;
let _ = [%cx2 {|display: $(display)|}];

let visibility = `hidden;
let _ = [%cx2 {|visibility: $(visibility)|}];

let overflow = `scroll;
let _ = [%cx2 {|overflow: $(overflow)|}];

let overflowX = `auto;
let _ = [%cx2 {|overflow-x: $(overflowX)|}];

let overflowY = `hidden;
let _ = [%cx2 {|overflow-y: $(overflowY)|}];

/* Positioning */
let position = `relative;
let _ = [%cx2 {|position: $(position)|}];

let top = `px(10);
let _ = [%cx2 {|top: $(top)|}];

let right = `px(20);
let _ = [%cx2 {|right: $(right)|}];

let bottom = `px(30);
let _ = [%cx2 {|bottom: $(bottom)|}];

let left = `px(40);
let _ = [%cx2 {|left: $(left)|}];

let zIndex = 100;
let _ = [%cx2 {|z-index: $(zIndex)|}];

/* Box Model */
let width = `px(200);
let _ = [%cx2 {|width: $(width)|}];

let height = `px(150);
let _ = [%cx2 {|height: $(height)|}];

let minWidth = `px(100);
let _ = [%cx2 {|min-width: $(minWidth)|}];

let maxWidth = `px(500);
let _ = [%cx2 {|max-width: $(maxWidth)|}];

let minHeight = `px(50);
let _ = [%cx2 {|min-height: $(minHeight)|}];

let maxHeight = `px(300);
let _ = [%cx2 {|max-height: $(maxHeight)|}];

let margin = `px(10);
let _ = [%cx2 {|margin: $(margin)|}];

let marginTop = `px(5);
let _ = [%cx2 {|margin-top: $(marginTop)|}];

let marginRight = `px(10);
let _ = [%cx2 {|margin-right: $(marginRight)|}];

let marginBottom = `px(15);
let _ = [%cx2 {|margin-bottom: $(marginBottom)|}];

let marginLeft = `px(20);
let _ = [%cx2 {|margin-left: $(marginLeft)|}];

let padding = `px(8);
let _ = [%cx2 {|padding: $(padding)|}];

let paddingTop = `px(4);
let _ = [%cx2 {|padding-top: $(paddingTop)|}];

let paddingRight = `px(8);
let _ = [%cx2 {|padding-right: $(paddingRight)|}];

let paddingBottom = `px(12);
let _ = [%cx2 {|padding-bottom: $(paddingBottom)|}];

let paddingLeft = `px(16);
let _ = [%cx2 {|padding-left: $(paddingLeft)|}];

/* Colors */
let color = CSS.hex("ff0000");
let _ = [%cx2 {|color: $(color)|}];

let backgroundColor = CSS.rgb(255, 255, 255);
let _ = [%cx2 {|background-color: $(backgroundColor)|}];

/* Typography */
let fontSize = `px(16);
let _ = [%cx2 {|font-size: $(fontSize)|}];

let fontWeight = `bold;
let _ = [%cx2 {|font-weight: $(fontWeight)|}];

let fontStyle = `italic;
let _ = [%cx2 {|font-style: $(fontStyle)|}];

let textAlign = `center;
let _ = [%cx2 {|text-align: $(textAlign)|}];

let textDecoration = `underline;
let _ = [%cx2 {|text-decoration: $(textDecoration)|}];

let textTransform = `uppercase;
let _ = [%cx2 {|text-transform: $(textTransform)|}];

let lineHeight = `abs(1.5);
let _ = [%cx2 {|line-height: $(lineHeight)|}];

let letterSpacing = `px(1);
let _ = [%cx2 {|letter-spacing: $(letterSpacing)|}];

let wordSpacing = `px(2);
let _ = [%cx2 {|word-spacing: $(wordSpacing)|}];

let whiteSpace = `nowrap;
let _ = [%cx2 {|white-space: $(whiteSpace)|}];

/* Borders */
let borderStyle = `solid;
let _ = [%cx2 {|border-style: $(borderStyle)|}];

let borderWidth = `px(1);
let _ = [%cx2 {|border-width: $(borderWidth)|}];

let borderColor = CSS.hex("000000");
let _ = [%cx2 {|border-color: $(borderColor)|}];

let borderRadius = `px(4);
let _ = [%cx2 {|border-radius: $(borderRadius)|}];

/* Background */
let backgroundRepeat = `noRepeat;
let _ = [%cx2 {|background-repeat: $(backgroundRepeat)|}];

let backgroundPosition = `center;
let _ = [%cx2 {|background-position: $(backgroundPosition)|}];

let backgroundSize = `cover;
let _ = [%cx2 {|background-size: $(backgroundSize)|}];

/* Outline */
let outlineStyle = `dashed;
let _ = [%cx2 {|outline-style: $(outlineStyle)|}];

let outlineWidth = `px(2);
let _ = [%cx2 {|outline-width: $(outlineWidth)|}];

let outlineColor = CSS.hex("0000ff");
let _ = [%cx2 {|outline-color: $(outlineColor)|}];

/* Cursor and pointer */
let cursor = `pointer;
let _ = [%cx2 {|cursor: $(cursor)|}];

let pointerEvents = `none;
let _ = [%cx2 {|pointer-events: $(pointerEvents)|}];

/* Opacity */
let opacity = 0.8;
let _ = [%cx2 {|opacity: $(opacity)|}];

/* Grid */
let gridAutoFlow = `row;
let _ = [%cx2 {|grid-auto-flow: $(gridAutoFlow)|}];

/* Gap */
let gap = `px(10);
let _ = [%cx2 {|gap: $(gap)|}];

let rowGap = `px(8);
let _ = [%cx2 {|row-gap: $(rowGap)|}];

let columnGap = `px(12);
let _ = [%cx2 {|column-gap: $(columnGap)|}];

/* Logical properties */
let marginBlock = `px(10);
let _ = [%cx2 {|margin-block: $(marginBlock)|}];

let marginInline = `px(20);
let _ = [%cx2 {|margin-inline: $(marginInline)|}];

let paddingBlock = `px(5);
let _ = [%cx2 {|padding-block: $(paddingBlock)|}];

let paddingInline = `px(15);
let _ = [%cx2 {|padding-inline: $(paddingInline)|}];

let insetBlock = `px(0);
let _ = [%cx2 {|inset-block: $(insetBlock)|}];

let insetInline = `px(0);
let _ = [%cx2 {|inset-inline: $(insetInline)|}];

/* Box sizing */
let boxSizing = `borderBox;
let _ = [%cx2 {|box-sizing: $(boxSizing)|}];

/* Order */
let order = 1;
let _ = [%cx2 {|order: $(order)|}];

/* Float and clear */
let float = `left;
let _ = [%cx2 {|float: $(float)|}];

let clear = `both;
let _ = [%cx2 {|clear: $(clear)|}];

/* Table */
let tableLayout = `fixed;
let _ = [%cx2 {|table-layout: $(tableLayout)|}];

let borderCollapse = `collapse;
let _ = [%cx2 {|border-collapse: $(borderCollapse)|}];

/* Vertical align */
let verticalAlign = `middle;
let _ = [%cx2 {|vertical-align: $(verticalAlign)|}];

/* Object fit */
let objectFit = `contain;
let _ = [%cx2 {|object-fit: $(objectFit)|}];

/* Resize */
let resize = `both;
let _ = [%cx2 {|resize: $(resize)|}];

/* User select */
let userSelect = `none;
let _ = [%cx2 {|user-select: $(userSelect)|}];

/* Transform origin */
let transformOrigin = `center;
let _ = [%cx2 {|transform-origin: $(transformOrigin)|}];

/* Backface visibility */
let backfaceVisibility = `hidden;
let _ = [%cx2 {|backface-visibility: $(backfaceVisibility)|}];

/* Perspective */
let perspective = `px(1000);
let _ = [%cx2 {|perspective: $(perspective)|}];

/* Word break */
let wordBreak = `breakAll;
let _ = [%cx2 {|word-break: $(wordBreak)|}];

/* Overflow wrap */
let overflowWrap = `breakWord;
let _ = [%cx2 {|overflow-wrap: $(overflowWrap)|}];

/* Hyphens */
let hyphens = `auto;
let _ = [%cx2 {|hyphens: $(hyphens)|}];

/* List style */
let listStyleType = `disc;
let _ = [%cx2 {|list-style-type: $(listStyleType)|}];

let listStylePosition = `inside;
let _ = [%cx2 {|list-style-position: $(listStylePosition)|}];

/* Content */
let content = `none;
let _ = [%cx2 {|content: $(content)|}];

/* Isolation */
let isolation = `isolate;
let _ = [%cx2 {|isolation: $(isolation)|}];

/* Mix blend mode */
let mixBlendMode = `multiply;
let _ = [%cx2 {|mix-blend-mode: $(mixBlendMode)|}];

/* Background blend mode */
let backgroundBlendMode = `overlay;
let _ = [%cx2 {|background-blend-mode: $(backgroundBlendMode)|}];

/* Column count */
let columnCount = `count(3);
let _ = [%cx2 {|column-count: $(columnCount)|}];

/* Break properties */
let breakBefore = `page;
let _ = [%cx2 {|break-before: $(breakBefore)|}];

let breakAfter = `avoid;
let _ = [%cx2 {|break-after: $(breakAfter)|}];

let breakInside = `avoidPage;
let _ = [%cx2 {|break-inside: $(breakInside)|}];

/* Appearance */
let appearance = `none;
let _ = [%cx2 {|appearance: $(appearance)|}];

/* Touch action */
let touchAction = `manipulation;
let _ = [%cx2 {|touch-action: $(touchAction)|}];

/* Scroll behavior */
let scrollBehavior = `smooth;
let _ = [%cx2 {|scroll-behavior: $(scrollBehavior)|}];

/* Overscroll behavior */
let overscrollBehavior = `contain;
let _ = [%cx2 {|overscroll-behavior: $(overscrollBehavior)|}];

/* Accent color */
let accentColor = CSS.hex("0066cc");
let _ = [%cx2 {|accent-color: $(accentColor)|}];

/* Caret color */
let caretColor = CSS.hex("333333");
let _ = [%cx2 {|caret-color: $(caretColor)|}];
