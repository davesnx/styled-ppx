[%styled.global
  {|
  div {
    background-color: green;
  }

  @media (min-width: 400px) {
    div {
      background-color: red;
    }
  }
|}
];

let stack = [%cx "display: flex; flex-direction: column"];
let stackGap = gap => [%cx "gap: $(gap)"];
module Cositas = [%styled.div
  (~lola=CssJs.px(0), ~id) => {|
  display: flex;
  flex-direction: column;
  gap: $(lola);
  background-color: $(id);
|}
];

let selectors = [%cx {|
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

let code = [|`custom("Menlo"), `monospace|];
let lola = `auto;

let clx = [%cx
  {|
  animation-name: $(bounce);
  font-family: $(code);
  cursor: $(lola);
|}
];

module App = {
  [@react.component]
  let make = () =>
    <Cositas as_="section" lola={CssJs.px(10)} id=CssJs.red>
      <div className=clx> {React.string("code everywhere!")} </div>
      <div className=selectors> {React.string("Red text")} </div>
    </Cositas>;
};

let getStaticMarkup = () => {
  ReactDOM.renderToStaticMarkup(<App />);
};
