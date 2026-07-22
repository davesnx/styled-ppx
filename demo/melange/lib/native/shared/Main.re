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

/* --- Atomic ordering experiments ------------------------------------- */

/* The same `color` declaration under @media, @container and @supports
   produces three independent atoms. All of them have the same specificity
   (single class), so stylesheet order decides the winner when several
   queries match at once. The aggregator emits deterministic buckets
   (@supports < @media < @container — see
   documents/atomic-css-ordering.md), so the declaration order below does
   not affect the output. */
let queryOrder = [%css
  {|
  color: black;

  @media (min-width: 400px) {
    color: red;
  }

  @container (width > 400px) {
    color: green;
  }

  @supports (display: flex) {
    color: blue;
  }
|}
];

/* Exactly the same atoms, declared in the opposite order. Both bindings
   dedup to the same classes and converge on the same bucket order: when
   all three conditions match, @container wins for both elements. Atomic
   CSS cannot express per-binding at-rule precedence — predictability over
   expressiveness. */
let queryOrderReversed = [%css
  {|
  color: black;

  @supports (display: flex) {
    color: blue;
  }

  @container (width > 400px) {
    color: green;
  }

  @media (min-width: 400px) {
    color: red;
  }
|}
];

/* `a:link` vs `a:nth-child(odd)`: both selectors have specificity (0,2,1)
   once prefixed with the atomic class, so for the first <a> (an odd child
   that is also an unvisited link) stylesheet order is the tie-breaker.
   Buckets rank structural pseudos before LVFHA, so :link wins — in both
   declaration orders. */
let linkFirst = [%css
  {|
  & a:link {
    color: orange;
  }

  & a:nth-child(odd) {
    color: teal;
  }
|}
];

/* Same two selector atoms, reversed. Both bindings share the same classes
   and the same bucket order, so both lists render identically. */
let nthFirst = [%css
  {|
  & a:nth-child(odd) {
    color: teal;
  }

  & a:link {
    color: orange;
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
    <section styles=post>
      <h2> {React.string("Atomic ordering: at-rules")} </h2>
      <p styles=queryOrder>
        {React.string("media -> container -> supports (source order)")}
      </p>
      <p styles=queryOrderReversed>
        {React.string("supports -> container -> media (reversed source)")}
      </p>
    </section>
    <section>
      <h2> {React.string("Atomic ordering: selectors")} </h2>
      <ul styles=linkFirst>
        <li> <a href="#"> {React.string("a:link then a:nth-child")} </a> </li>
      </ul>
      <ul styles=nthFirst>
        <li> <a href="#"> {React.string("a:nth-child then a:link")} </a> </li>
      </ul>
    </section>
  </main>;
