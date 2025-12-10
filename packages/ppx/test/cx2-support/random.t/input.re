/* CSSOM View Module */
[%cx2 {|scroll-behavior: auto|}];
[%cx2 {|scroll-behavior: smooth|}];

/* CSS Scroll Anchoring Module Level 1 */
[%cx2 {|overflow-anchor: none|}];
[%cx2 {|overflow-anchor: auto|}];

[%cx2 {|-moz-appearance: textfield;|}];
[%cx2 {|-webkit-appearance: none;|}];
[%cx2 {|-webkit-box-orient: vertical;|}];

module Color = {
  let text = CSS.hex("444");
  let background = CSS.hex("333");
};
let backgroundString = Color.background |> CSS.Types.Color.toString;
let colorTextString = Color.text |> CSS.Types.Color.toString;

[%cx2 {|-webkit-box-shadow: inset 0 0 0 1000px $(backgroundString);|}];
[%cx2 {|-webkit-line-clamp: 2;|}];
[%cx2 {|-webkit-overflow-scrolling: touch;|}];
[%cx2 {|-webkit-tap-highlight-color: transparent;|}];
[%cx2 {|-webkit-text-fill-color: $(colorTextString);|}];
[%cx2 {|animation: none;|}];
[%cx2 {|appearance: none;|}];
[%cx2 {|aspect-ratio: 21 / 8;|}];

let c = CSS.hex("e15a46");
[%cx2 {|background-color: $(c);|}];
/* border: <line-width> || <line-style> || <color>
   Note: The border shorthand has limited support - style-only or color-only don't work
   Combinatorial coverage for working patterns */
[%cx2 {|border: none|}];
/* Width only */
[%cx2 {|border: 1px|}];
[%cx2 {|border: thin|}];
/* Width + style */
[%cx2 {|border: 1px solid|}];
[%cx2 {|border: thin dashed|}];
/* Width + style + color (all parts - typed output!) */
[%cx2 {|border: 1px solid black|}];
[%cx2 {|border: thin dashed red|}];
[%cx2 {|border: 2px dotted #333|}];
[%cx2 {|border: medium double blue|}];
[%cx2 {|bottom: unset;|}];
[%cx2 {|box-shadow: none;|}];
[%cx2 {|break-inside: avoid;|}];
[%cx2 {|caret-color: #e15a46;|}];
[%cx2 {|color: inherit;|}];
[%cx2 {|color: var(--color-link);|}];
[%cx2 {|column-width: 125px;|}];
[%cx2 {|column-width: auto;|}];
[%cx2 {|counter-increment: ol;|}];
[%cx2 {|counter-reset: ol;|}];
[%cx2 {|display: -webkit-box;|}];
[%cx2 {|display: contents;|}];
[%cx2 {|display: table;|}];
[%cx2 {|fill: $(c);|}];
[%cx2 {|fill: currentColor;|}];
[%cx2 {|gap: 4px;|}];
[%cx2 {|grid-column-end: span 2;|}];
[%cx2 {|grid-column: unset;|}];
[%cx2 {|grid-row: unset;|}];
[%cx2 {|grid-template-columns: max-content max-content;|}];
[%css
  {|grid-template-columns: minmax(10px, auto) fit-content(20px) fit-content(20px);|}
];
[%css
  {|grid-template-columns: minmax(51px, auto) fit-content(20px) fit-content(20px);|}
];
[%cx2 {|grid-template-columns: repeat(2, auto);|}];
[%cx2 {|grid-template-columns: repeat(3, auto);|}];
[%cx2 {|height: fit-content;|}];
[%cx2 {|justify-items: start;|}];
[%cx2 {|justify-self: unset;|}];
[%cx2 {|left: unset;|}];
let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
[%cx2 {|mask-image: $(maskedImageUrl);|}];
[%cx2 {|mask-position: center center;|}];
[%cx2 {|mask-repeat: no-repeat;|}];
[%cx2 {|max-width: max-content;|}];
[%cx2 {|outline: none;|}];
[%cx2 {|overflow-anchor: none;|}];
[%cx2 {|position: unset;|}];
[%cx2 {|resize: none;|}];
[%cx2 {|right: calc(50% - 4px);|}];
[%cx2 {|scroll-behavior: smooth;|}];
[%cx2 {|stroke-opacity: 0;|}];
[%cx2 {|stroke: $(Color.text);|}];
[%cx2 {|top: calc(50% - 1px);|}];
[%cx2 {|top: unset;|}];
[%cx2 {|touch-action: none;|}];
[%cx2 {|touch-action: pan-x pan-y;|}];
[%cx2 {|transform-origin: center bottom;|}];
[%cx2 {|transform-origin: center left;|}];
[%cx2 {|transform-origin: center right;|}];
[%cx2 {|transform-origin: 2px;|}];
[%cx2 {|transform-origin: bottom;|}];
[%cx2 {|transform-origin: 3cm 2px;|}];
[%cx2 {|transform-origin: left 2px;|}];
[%cx2 {|transform-origin: center top;|}];
[%cx2 {|transform: none;|}];
/* [%cx2 {|width: -webkit-fill-available;|}]; */
[%cx2 {|width: fit-content;|}];
[%cx2 {|width: max-content;|}];

[%cx2 {|transition-delay: 240ms|}];
[%cx2 {|animation-duration: 150ms|}];

/* [%cx2 {|top: calc(50% + var(--value-from-var));|}]; */

[%cx2 {|border-width: thin|}];
[%cx2 {|outline-width: medium|}];
[%cx2 {|outline: medium solid red|}];

/* CSS Overflow Module Level 3 */
let lola = `hidden;
[%cx2 {|overflow: $(lola)|}];
[%cx2 {|overflow: hidden|}];
[%cx2 {|overflow-y: $(lola)|}];
[%cx2 {|overflow-x: hidden|}];

let value = `clip;
[%cx2 {|overflow-block: hidden|}];
[%cx2 {|overflow-block: $(value)|}];
[%cx2 {|overflow-inline: $(value)|}];

[%cx
  {|
    background-image: linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.80) 50%, #2A97FF 100%);
  |}
];

[%cx {|aspect-ratio: 16 / 9;|}];

[%cx2 {|color: var(--color-link);|}];

let interpolation = `px(10);
[%cx {|
    right: $(interpolation);
    bottom: $(interpolation);
  |}];
