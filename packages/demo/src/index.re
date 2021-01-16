module App = [%styled.div {j|
  position: absolute;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  cursor: pointer;
|j}
];

module App2 = {
  [@react.component]
  let make = (~children) => {
    <div>
      children
    </div>
  }
}

module Link = [%styled.a
  {|
  font-size: 36px;
  margin-top: 16px;
|}
];

module Line = [%styled.span];
module Wrapper = [%styled ""];

module Component = [%styled {j|
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;
|j}
];

ReactDOMRe.renderToElementWithId(
  <App onClick=Js.log>
    <Component>
      {React.string("test..")}
    </Component>
    <App2>
      <Component>
        {React.string("Demo of...")}
      </Component>
    </App2>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
    <Wrapper> <Line /> </Wrapper>
  </App>,
  "app",
);
