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
  let resize = [%keyframe {|
    0% { height: $(previous); }
    100% { height: $(current); }
  |}];

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
  </main>;
