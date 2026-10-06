let pageBackground = CSS.hex("faf7f2");
let textColor = CSS.hex("141414");

module AppGlobalStyles = [%styled.global
  {|
  html {
    box-sizing: border-box;
  }

  *, *::before, *::after {
    box-sizing: inherit;
  }

  body, html, #root {
    margin: 0; padding:0;
  }

  body {
    background-color: $(pageBackground);
    color: $(textColor);
    font-family: "Menlo", "monospace";
    line-height: 1.5;
  }
|}
];

let stack = [%css "display: flex; flex-direction: column"];

module Cositas = [%styled.div
  (~lola=CSS.px(0)) => {|
    display: flex;
  flex-direction: column;
  gap: $(lola);
|}
];

let selectors = [%css {|
  color: red;

  &:hover {
    color: blue;
  }
|}];

let bounce = [%keyframe
  {|
  40% {
    transform: translate3d(0, -30px, 0);
  }

  70% {
    transform: translate3d(0, -15px, 0);
  }

  90% {
    transform: translate3d(0,-4px,0);
  }
|}
];

let clx = [%css
  {|
  font-family: "Menlo", "monospace";
  cursor: auto;
  grid-template-columns: auto 40%;
|}
];

let post = [%css {|
  border: 2px solid;
  container-type: inline-size;
|}];

let card = [%css
  {|
  margin: 10px;
  border: 2px dotted;
  font-size: 1.5em;
  |}
];

let container = [%css
  {|
  @container (width < 650px) {
    width: 50%;
    background-color: gray;
    font-size: 1em;

    .my-content {
      font-weight: bold;
    }
  }
|}
];

let gradiend = [%css
  {|
    padding: 36px;
    background-image:
      repeating-linear-gradient(45deg, #333 0px, #333 4px, #f60808)
    |}
];

/* Selector references: `.$(binding)` inside a [%css] rule targets another
   binding's identity class (works across modules too), and `&.$(binding)`
   does the same compounded onto the current selector. */

module Labels = {
  let tag = [%css
    {|
    display: inline-block;
    padding: 2px 8px;
    margin-left: 8px;
    border: 2px solid #141414;
    border-radius: 4px;
  |}
  ];
};

let childLabel = [%css "font-weight: bold;"];

let parentWithChildSelector = [%css
  {|
  border: 3px solid #2f9e44;
  padding: 16px;
  margin-bottom: 16px;

  .$(childLabel) {
    color: #2f9e44;
  }

  .$(Labels.tag) {
    background: #d3f9d8;
  }
|}
];

let modifierActive = [%css "font-weight: bold;"];

let toggle = [%css
  {|
  display: inline-block;
  padding: 6px 14px;
  margin-right: 8px;
  border: 2px solid #495057;
  border-radius: 999px;

  &.$(modifierActive) {
    background: #ffd43b;
    border-color: #f08c00;
  }
|}
];

/* ===== CSS.merge demo =====
   CSS.merge(a, b) drops a's class when a class of b covers the same
   (context, family, mask) slot, so the merge call's own argument order
   decides the winner - see Merge_key.ml and documents/css-extraction.md's
   "CSS.merge" section. Each row below states the expected result as text;
   getComputedStyle/className are checked live in the browser. */

/* 1. same property, right wins. */
let mergeLeftRed = [%css "color: red;"];
let mergeRightBlue = [%css "color: blue;"];

/* Faq shape (see merge-order-flip-under-dedup.md / test_merge_key.ml's
   faq_repro): FaqDecoy.heightAutoDecoy, in another module, sets the exact
   same `height: auto` declaration as faqOpenContent below and is rendered
   first, so its atom claims that class's stylesheet slot before
   faqOpenContent/faqCollapsed ever run. CSS.merge must still decide by
   key, not by which one reached the stylesheet first. */
module FaqDecoy = {
  let heightAutoDecoy = [%css "height: auto;"];
};
let faqOpenContent = [%css "height: auto; overflow: hidden;"];
let faqCollapsed = [%css "height: 0;"];

/* 2. longhand then shorthand: the shorthand's full mask always wins. */
let marginTopZero = [%css "margin-top: 0;"];
let marginAll10 = [%css "margin: 10px;"];

/* 3. shorthand then longhand: accepted limit (a lone longhand's mask is
   never a superset of a shorthand's full mask, so the shorthand survives
   too - see documents/css-extraction.md's "Accepted limit"). */
let marginAll10Reversed = [%css "margin: 10px;"];
let marginTopZeroReversed = [%css "margin-top: 0;"];

/* 4. different properties: no conflict, both apply. */
let differentColor = [%css "color: seagreen;"];
let differentBackground = [%css "background: #d3f9d8;"];

/* 5. contexts: !important aside, only a matching context (same at-rules +
   selector) is eligible to merge at all. */
let hoverBaseColor = [%css "color: green;"];
let hoverOverride = [%css "&:hover { color: purple; }"];

let hoverFirst = [%css "&:hover { color: red; }"];
let hoverSecond = [%css "&:hover { color: teal; }"];

let mediaFirst = [%css "@media (max-width: 700px) { color: orange; }"];
let mediaSecond = [%css "@media (max-width: 700px) { color: brown; }"];

/* 6. !important: folded into the context, so a plain declaration and its
   !important twin are never in the same context and never remove each
   other - the browser's own cascade decides between them, which is why
   !important always wins regardless of which merge side it's on. */
let importantRed = [%css "color: red !important;"];
let plainBlueForImportant = [%css "color: blue;"];
let plainRedForImportant = [%css "color: red;"];
let importantBlue = [%css "color: blue !important;"];
let importantRedVsImportantBlue = [%css "color: red !important;"];

/* 7. custom property: --x is its own family bucket, keyed by the custom
   property's own name, so the second --x removes the first. */
let customXRed = [%css "--x: red;"];
let customXBlue = [%css "--x: blue;"];
let useCustomX = [%css "color: var(--x);"];

/* 8. interpolation bundle ($(...)) on each side: an `in-` class is never
   dropped and never drops another atom - both survive the merge, and
   whichever rule lands later in the generated stylesheet wins visually. */
let dynColorA = color => [%css {|color: $(color);|}];
let dynColorB = color => [%css {|color: $(color);|}];

/* 9. merge of merges: both associations should collapse to the same
   winner (navy) and the same final class list. */
let assocA = [%css "color: crimson;"];
let assocB = [%css "color: darkorange;"];
let assocC = [%css "color: navy;"];

/* 10. family atom: padding-left/padding-right stay two atoms (disjoint
   leaves) even though they share the "padding" family, so merge can drop
   just the overlapping side and leave the other alone. */
let paddingBothZero = [%css "padding-left: 0; padding-right: 0;"];
let paddingLeft4 = [%css "padding-left: 4px;"];

/* 11. alias: word-wrap and overflow-wrap resolve to the same canonical
   property before family lookup (see Slot_key.resolve_alias), so they
   behave like the same property under merge. */
let wordWrapBreak = [%css "word-wrap: break-word;"];
let overflowWrapNormal = [%css "overflow-wrap: normal;"];

/* 12. [%styled.<tag>] components only expose a plain string `className`
   prop, concatenated with `++` (see Generate.className) - there is no
   "merged styles prop" path to demonstrate. What does carry over: a
   binding's id- identity is never dropped by CSS.merge, so a $(binding)
   selector reference targeting it still matches even when that binding's
   class list reached the DOM through a merge call. */
let identityKeptColor = [%css "color: teal;"];
let identityKeptOverride = [%css "color: crimson;"];
let identityKeptHighlight = [%css
  {|
  .$(identityKeptColor) {
    text-decoration: underline;
  }
|}
];

let primary = CSS.hex("141414");

let keyframeDemoShell = color => [%css
  {|
    padding: 24px;
    margin-bottom: 24px;
    border: 2px solid #141414;
    border-radius: 18px;
    background: #f6f1e8;
    color: $(color);
    font-family: "Menlo", "monospace";
  |}
];

let keyframeDemoCard = {
  let previousHeight = 72;
  let currentHeight = 172;
  let previous = `px(previousHeight);
  let current = `px(currentHeight);
  let resize = [%keyframe
    {|
    0% { height: $(previous); }
    100% { height: $(current); }
  |}
  ];

  [%css
   {|
    animation-name: $(resize);
    animation-duration: 1200ms;
    animation-timing-function: ease-in-out;
    animation-fill-mode: both;
    width: 280px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 14px;
    background: linear-gradient(135deg, #101828 0%, #364152 100%);
    color: white;
    box-shadow: 0 20px 40px rgba(16, 24, 40, 0.22);
  |}
  ];
};

[@react.component]
let make = () =>
  <main styles=gradiend>
    <AppGlobalStyles />
    <section styles={keyframeDemoShell(primary)}>
      <h2> {React.string("Interpolated keyframe demo")} </h2>
      <p>
        {React.string(
           "The keyframe is extracted globally, while previous/current heights are applied as element-scoped CSS variables.",
         )}
      </p>
      <div styles=keyframeDemoCard>
        {React.string("height: 72px -> 172px")}
      </div>
    </section>
    <div styles=post>
      <div styles={CSS.merge(card, container)}>
        <h2> {React.string("Card title")} </h2>
        <p> {React.string("Card content")} </p>
      </div>
    </div>
    <section styles=stack>
      <div styles=clx> {React.string("code everywhere!")} </div>
      <div styles=selectors> {React.string("Red text")} </div>
    </section>
    <section styles=parentWithChildSelector>
      <h2> {React.string("Selector references")} </h2>
      <p styles=childLabel>
        {React.string("Green text via the parent's .$(childLabel) selector")}
      </p>
      <span styles=Labels.tag>
        {React.string(
           "Bordered via a submodule .$(Labels.tag) selector reference",
         )}
      </span>
    </section>
    <section>
      <span styles=toggle> {React.string("toggle: off")} </span>
      <span styles={CSS.merge(toggle, modifierActive)}>
        {React.string("toggle: on via &.$(modifierActive)")}
      </span>
    </section>
    <section>
      <h2> {React.string("CSS.merge")} </h2>
      <h3> {React.string("1. same property: right wins")} </h3>
      <p styles={CSS.merge(mergeLeftRed, mergeRightBlue)}>
        {React.string("merge(red, blue) -> expect blue")}
      </p>
      <p styles={CSS.merge(faqOpenContent, faqCollapsed)}>
        {React.string(
           "Faq: merge(content{height:auto}, collapsed{height:0}) -> expect height 0 (this text hidden)",
         )}
      </p>
      <p styles=FaqDecoy.heightAutoDecoy>
        {React.string(
           "Decoy: unrelated height:auto, rendered first, same class as faqOpenContent's",
         )}
      </p>
      <h3> {React.string("2. longhand then shorthand")} </h3>
      <p styles={CSS.merge(marginTopZero, marginAll10)}>
        {React.string(
           "merge(margin-top:0, margin:10px) -> expect 10px all sides",
         )}
      </p>
      <h3> {React.string("3. shorthand then longhand (accepted limit)")} </h3>
      <p styles={CSS.merge(marginAll10Reversed, marginTopZeroReversed)}>
        {React.string(
           "merge(margin:10px, margin-top:0) -> both classes kept, see report for what rendered",
         )}
      </p>
      <h3> {React.string("4. different properties")} </h3>
      <p styles={CSS.merge(differentColor, differentBackground)}>
        {React.string("merge(color, background) -> expect both applied")}
      </p>
      <h3> {React.string("5. contexts")} </h3>
      <p styles={CSS.merge(hoverBaseColor, hoverOverride)}>
        {React.string("base + :hover -> green at rest, purple on hover")}
      </p>
      <p styles={CSS.merge(hoverFirst, hoverSecond)}>
        {React.string(":hover + :hover -> teal on hover (right wins)")}
      </p>
      <p styles={CSS.merge(hoverBaseColor, mediaFirst)}>
        {React.string(
           "base + @media(<=700px) -> green normally, orange under 700px (both kept)",
         )}
      </p>
      <p styles={CSS.merge(mediaFirst, mediaSecond)}>
        {React.string(
           "@media + same @media -> brown under 700px (right wins)",
         )}
      </p>
      <h3> {React.string("6. !important")} </h3>
      <p styles={CSS.merge(importantRed, plainBlueForImportant)}>
        {React.string("merge(red !important, blue) -> expect red")}
      </p>
      <p styles={CSS.merge(plainRedForImportant, importantBlue)}>
        {React.string("merge(red, blue !important) -> expect blue")}
      </p>
      <p styles={CSS.merge(importantRedVsImportantBlue, importantBlue)}>
        {React.string("merge(red !important, blue !important) -> expect blue")}
      </p>
      <h3> {React.string("7. custom property")} </h3>
      <p styles={CSS.merge(CSS.merge(customXRed, customXBlue), useCustomX)}>
        {React.string(
           "merge(--x:red, --x:blue) then color:var(--x) -> expect blue",
         )}
      </p>
      <h3> {React.string("8. interpolation bundle on each side")} </h3>
      <p
        styles={CSS.merge(
          dynColorA(CSS.hex("e8590c")),
          dynColorB(CSS.hex("1971c2")),
        )}>
        {React.string(
           "merge($(orange), $(blue)) -> both in- classes kept, see report for winner",
         )}
      </p>
      <h3> {React.string("9. merge of merges")} </h3>
      <p styles={CSS.merge(CSS.merge(assocA, assocB), assocC)}>
        {React.string("merge(merge(a,b), c) -> expect navy")}
      </p>
      <p styles={CSS.merge(assocA, CSS.merge(assocB, assocC))}>
        {React.string(
           "merge(a, merge(b,c)) -> expect navy, same as the other order",
         )}
      </p>
      <h3> {React.string("10. family atom")} </h3>
      <p styles={CSS.merge(paddingBothZero, paddingLeft4)}>
        {React.string(
           "merge(padding-left:0;padding-right:0, padding-left:4px) -> expect left 4px, right 0",
         )}
      </p>
      <h3> {React.string("11. alias")} </h3>
      <p styles={CSS.merge(wordWrapBreak, overflowWrapNormal)}>
        {React.string(
           "merge(word-wrap:break-word, overflow-wrap:normal) -> see report for what applies",
         )}
      </p>
      <h3> {React.string("12. identity survives a merge")} </h3>
      <div styles=identityKeptHighlight>
        <p styles={CSS.merge(identityKeptColor, identityKeptOverride)}>
          {React.string(
             "crimson + underlined: .$(identityKeptColor) still matches after merge",
           )}
        </p>
      </div>
    </section>
  </main>;
