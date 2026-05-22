/* Test complete interpolation support in cx2 for various properties */

/* Box Alignment properties */
let justifyContent = `center;
let _ = [%css {|justify-content: $(justifyContent)|}];

let alignItems = `stretch;
let _ = [%css {|align-items: $(alignItems)|}];

let alignSelf = `flexEnd;
let _ = [%css {|align-self: $(alignSelf)|}];

let alignContent = `spaceBetween;
let _ = [%css {|align-content: $(alignContent)|}];

let justifyItems = `start;
let _ = [%css {|justify-items: $(justifyItems)|}];

let justifySelf = `end_;
let _ = [%css {|justify-self: $(justifySelf)|}];

/* Flexbox properties */
let flexDirection = `row;
let _ = [%css {|flex-direction: $(flexDirection)|}];

let flexWrap = `wrap;
let _ = [%css {|flex-wrap: $(flexWrap)|}];

let flexGrow = 1.0;
let _ = [%css {|flex-grow: $(flexGrow)|}];

let flexShrink = 0.5;
let _ = [%css {|flex-shrink: $(flexShrink)|}];

let flexBasis = `px(100);
let _ = [%css {|flex-basis: $(flexBasis)|}];

/* Display and visibility */
let display = `flex;
let _ = [%css {|display: $(display)|}];

let visibility = `hidden;
let _ = [%css {|visibility: $(visibility)|}];

let overflow = `scroll;
let _ = [%css {|overflow: $(overflow)|}];

let overflowX = `auto;
let _ = [%css {|overflow-x: $(overflowX)|}];

let overflowY = `hidden;
let _ = [%css {|overflow-y: $(overflowY)|}];

/* Positioning */
let position = `relative;
let _ = [%css {|position: $(position)|}];

let top = `px(10);
let _ = [%css {|top: $(top)|}];

let right = `px(20);
let _ = [%css {|right: $(right)|}];

let bottom = `px(30);
let _ = [%css {|bottom: $(bottom)|}];

let left = `px(40);
let _ = [%css {|left: $(left)|}];

let zIndex = 100;
let _ = [%css {|z-index: $(zIndex)|}];

/* Box Model */
let width = `px(200);
let _ = [%css {|width: $(width)|}];

let height = `px(150);
let _ = [%css {|height: $(height)|}];

let minWidth = `px(100);
let _ = [%css {|min-width: $(minWidth)|}];

let maxWidth = `px(500);
let _ = [%css {|max-width: $(maxWidth)|}];

let minHeight = `px(50);
let _ = [%css {|min-height: $(minHeight)|}];

let maxHeight = `px(300);
let _ = [%css {|max-height: $(maxHeight)|}];

let margin = `px(10);
let _ = [%css {|margin: $(margin)|}];

let marginTop = `px(5);
let _ = [%css {|margin-top: $(marginTop)|}];

let marginRight = `px(10);
let _ = [%css {|margin-right: $(marginRight)|}];

let marginBottom = `px(15);
let _ = [%css {|margin-bottom: $(marginBottom)|}];

let marginLeft = `px(20);
let _ = [%css {|margin-left: $(marginLeft)|}];

let padding = `px(8);
let _ = [%css {|padding: $(padding)|}];

let paddingTop = `px(4);
let _ = [%css {|padding-top: $(paddingTop)|}];

let paddingRight = `px(8);
let _ = [%css {|padding-right: $(paddingRight)|}];

let paddingBottom = `px(12);
let _ = [%css {|padding-bottom: $(paddingBottom)|}];

let paddingLeft = `px(16);
let _ = [%css {|padding-left: $(paddingLeft)|}];

/* Colors */
let color = CSS.hex("ff0000");
let _ = [%css {|color: $(color)|}];

let backgroundColor = CSS.rgb(255, 255, 255);
let _ = [%css {|background-color: $(backgroundColor)|}];

/* Typography */
let fontSize = `px(16);
let _ = [%css {|font-size: $(fontSize)|}];

let fontWeight = `bold;
let _ = [%css {|font-weight: $(fontWeight)|}];

let fontStyle = `italic;
let _ = [%css {|font-style: $(fontStyle)|}];

let textAlign = `center;
let _ = [%css {|text-align: $(textAlign)|}];

let textDecoration = `underline;
let _ = [%css {|text-decoration: $(textDecoration)|}];

let textTransform = `uppercase;
let _ = [%css {|text-transform: $(textTransform)|}];

let lineHeight = `abs(1.5);
let _ = [%css {|line-height: $(lineHeight)|}];

let letterSpacing = `px(1);
let _ = [%css {|letter-spacing: $(letterSpacing)|}];

let wordSpacing = `px(2);
let _ = [%css {|word-spacing: $(wordSpacing)|}];

let whiteSpace = `nowrap;
let _ = [%css {|white-space: $(whiteSpace)|}];

/* Borders */
let borderStyle = `solid;
let _ = [%css {|border-style: $(borderStyle)|}];

let borderWidth = `px(1);
let _ = [%css {|border-width: $(borderWidth)|}];

let borderColor = CSS.hex("000000");
let _ = [%css {|border-color: $(borderColor)|}];

let borderRadius = `px(4);
let _ = [%css {|border-radius: $(borderRadius)|}];

/* Background */
let backgroundRepeat = `noRepeat;
let _ = [%css {|background-repeat: $(backgroundRepeat)|}];

let backgroundPosition = `center;
let _ = [%css {|background-position: $(backgroundPosition)|}];

let backgroundSize = `cover;
let _ = [%css {|background-size: $(backgroundSize)|}];

/* Outline */
let outlineStyle = `dashed;
let _ = [%css {|outline-style: $(outlineStyle)|}];

let outlineWidth = `px(2);
let _ = [%css {|outline-width: $(outlineWidth)|}];

let outlineColor = CSS.hex("0000ff");
let _ = [%css {|outline-color: $(outlineColor)|}];

/* Cursor and pointer */
let cursor = `pointer;
let _ = [%css {|cursor: $(cursor)|}];

let pointerEvents = `none;
let _ = [%css {|pointer-events: $(pointerEvents)|}];

/* Opacity */
let opacity = 0.8;
let _ = [%css {|opacity: $(opacity)|}];

/* Grid */
let gridAutoFlow = `row;
let _ = [%css {|grid-auto-flow: $(gridAutoFlow)|}];

/* Gap */
let gap = `px(10);
let _ = [%css {|gap: $(gap)|}];

let rowGap = `px(8);
let _ = [%css {|row-gap: $(rowGap)|}];

let columnGap = `px(12);
let _ = [%css {|column-gap: $(columnGap)|}];

/* Logical properties */
let marginBlock = `px(10);
let _ = [%css {|margin-block: $(marginBlock)|}];

let marginInline = `px(20);
let _ = [%css {|margin-inline: $(marginInline)|}];

let paddingBlock = `px(5);
let _ = [%css {|padding-block: $(paddingBlock)|}];

let paddingInline = `px(15);
let _ = [%css {|padding-inline: $(paddingInline)|}];

let insetBlock = `px(0);
let _ = [%css {|inset-block: $(insetBlock)|}];

let insetInline = `px(0);
let _ = [%css {|inset-inline: $(insetInline)|}];

/* Box sizing */
let boxSizing = `borderBox;
let _ = [%css {|box-sizing: $(boxSizing)|}];

/* Order */
let order = 1;
let _ = [%css {|order: $(order)|}];

/* Float and clear */
let float = `left;
let _ = [%css {|float: $(float)|}];

let clear = `both;
let _ = [%css {|clear: $(clear)|}];

/* Table */
let tableLayout = `fixed;
let _ = [%css {|table-layout: $(tableLayout)|}];

let borderCollapse = `collapse;
let _ = [%css {|border-collapse: $(borderCollapse)|}];

/* Vertical align */
let verticalAlign = `middle;
let _ = [%css {|vertical-align: $(verticalAlign)|}];

/* Object fit */
let objectFit = `contain;
let _ = [%css {|object-fit: $(objectFit)|}];

/* Resize */
let resize = `both;
let _ = [%css {|resize: $(resize)|}];

/* User select */
let userSelect = `none;
let _ = [%css {|user-select: $(userSelect)|}];

/* Transform origin */
let transformOrigin = `center;
let _ = [%css {|transform-origin: $(transformOrigin)|}];

/* Backface visibility */
let backfaceVisibility = `hidden;
let _ = [%css {|backface-visibility: $(backfaceVisibility)|}];

/* Perspective */
let perspective = `px(1000);
let _ = [%css {|perspective: $(perspective)|}];

/* Word break */
let wordBreak = `breakAll;
let _ = [%css {|word-break: $(wordBreak)|}];

/* Overflow wrap */
let overflowWrap = `breakWord;
let _ = [%css {|overflow-wrap: $(overflowWrap)|}];

/* Hyphens */
let hyphens = `auto;
let _ = [%css {|hyphens: $(hyphens)|}];

/* List style */
let listStyleType = `disc;
let _ = [%css {|list-style-type: $(listStyleType)|}];

let listStylePosition = `inside;
let _ = [%css {|list-style-position: $(listStylePosition)|}];

/* Content */
let content = `none;
let _ = [%css {|content: $(content)|}];

/* Isolation */
let isolation = `isolate;
let _ = [%css {|isolation: $(isolation)|}];

/* Mix blend mode */
let mixBlendMode = `multiply;
let _ = [%css {|mix-blend-mode: $(mixBlendMode)|}];

/* Background blend mode */
let backgroundBlendMode = `overlay;
let _ = [%css {|background-blend-mode: $(backgroundBlendMode)|}];

/* Column count */
let columnCount = `count(3);
let _ = [%css {|column-count: $(columnCount)|}];

/* Break properties */
let breakBefore = `page;
let _ = [%css {|break-before: $(breakBefore)|}];

let breakAfter = `avoid;
let _ = [%css {|break-after: $(breakAfter)|}];

let breakInside = `avoidPage;
let _ = [%css {|break-inside: $(breakInside)|}];

/* Appearance */
let appearance = `none;
let _ = [%css {|appearance: $(appearance)|}];

/* Touch action */
let touchAction = `manipulation;
let _ = [%css {|touch-action: $(touchAction)|}];

/* Scroll behavior */
let scrollBehavior = `smooth;
let _ = [%css {|scroll-behavior: $(scrollBehavior)|}];

/* Overscroll behavior */
let overscrollBehavior = `contain;
let _ = [%css {|overscroll-behavior: $(overscrollBehavior)|}];

/* Accent color */
let accentColor = CSS.hex("0066cc");
let _ = [%css {|accent-color: $(accentColor)|}];

/* Caret color */
let caretColor = CSS.hex("333333");
let _ = [%css {|caret-color: $(caretColor)|}];
