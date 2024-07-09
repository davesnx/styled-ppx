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
  (~lola=CSS.px(0)) => {|
  display: flex;
  flex-direction: column;
  gap: $(lola);
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

let code = [|"Menlo", "monospace"|];
let lola = `auto;

let clx = [%cx
  {|
  animation-name: $(bounce);
  font-family: $(code);
  cursor: $(lola);
  grid-template-columns: auto 40%;
|}
];

let post = [%cx {|
  border: 2px solid;
  container-type: inline-size;
|}];

let card = [%cx
  {|
  margin: 10px;
  border: 2px dotted;
  font-size: 1.5em;
  |}
];

let container = [%cx
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

module App = {
  [@react.component]
  let make = () =>
    <>
      <div className=post>
        <div className={card ++ " " ++ container}>
          <h2> {React.string("Card title")} </h2>
          <p> {React.string("Card content")} </p>
        </div>
      </div>
      <Cositas as_="section" lola={CSS.px(10)}>
        <div className=clx> {React.string("code everywhere!")} </div>
        <div className=selectors> {React.string("Red text")} </div>
      </Cositas>
    </>;
};

let color = `hex("333");

let _ = [%css
  {|
    background-image:
      repeating-linear-gradient(
        45deg,
        $(color) 0px,
        $(color) 4px,
        $(color) 5px,
        $(color) 9px
      )
    |}
];

let getStaticMarkup = () => {
  ReactDOM.renderToStaticMarkup(<App />);
};
