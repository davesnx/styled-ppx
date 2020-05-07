[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }
|}];

module App = [%styled.div (~background) => {j|
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  background-color: $background;

  cursor: pointer;
|j}];

module Link = [%styled.div {|
  color: #FFFFFF;
  font-size: 36px;
  margin-top: 16px;
|}];

module Line = [%styled.span]
module Wrapper = [%styled ""]

let space = "10px";

module Component = [%styled (~background: string, ~space: int) => {j|
  background-color: $background;
  padding: $space;
  border-radius: 20px;
  box-sizing: border-box;
|j}];

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log} background="#443434">
    <Component background="#FFFFFF" space=30>
      {React.string("Demo of...")}
    </Component>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
    <Wrapper>
      <Line />
    <Wrapper>
  </App>,
  "app"
);
