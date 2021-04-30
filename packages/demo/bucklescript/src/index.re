[%styled.global {|
  html, body, #app {
    margin: 0;
    height: 100%;
    width: 100%;
  }
|}];

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

module Line = [%styled.span "display: inline;"];
module Wrapper = [%styled.div "display: inline;"];

module Dynamic = [%styled.input (~a as _) => "
  display: inline;
"];

module Component = [%styled.div {j|
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;
|j}
];

let cssRule = Css.style([Css.color(Css.blue)]);

switch (ReactDOM.querySelector("#app")) {
  | Some(el) =>
    ReactDOM.render(
      <App onClick=Js.log>
        <Dynamic a="23"/>
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
    el)
  | None => ()
};
