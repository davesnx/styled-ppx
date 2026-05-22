module GlobalStyles = [%styled.global
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

let stack = [%css "display: flex; flex-direction: column"];

/* TODO: styled.div doesn't generate makeProps, so when used as <Cositas as_="section" lola={CSS.px(10)}> it doesn't compile */
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
    background-image:
      repeating-linear-gradient(
        45deg,
        #333 0px,
        #333 4px,
        #333 5px,
        #333 9px
      )
    |}
];

[@react.component]
let make = () =>
  <main styles=gradiend>
    <div styles=Universal.classname>
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
    </div>
  </main>;
