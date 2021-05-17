/* [%styled.global {|
  html, body, #app {
    margin: 0;
    height: 100%;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
|}]; */

module App = [%styled.div {j|
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

module Dynamic = [%styled.input (~a as _) => "
  display: inline;
"];

module Component = [%styled.div {j|
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;

  @media (min-width: 600px) {
    background: blue;
  }

  &:hover {
    background: green;
  }

  & > p { color: pink; font-size: 24px; }
|j}
];

let stilos = [%cx "box-shadow: 1px 2px 0 0 #ff0000 inset, 1px 2px 0 0 #ff0000"];

switch (ReactDOM.querySelector("#app")) {
  | Some(el) =>
    ReactDOM.render(
      <div className=stilos>
        <App onClick=Js.log>
          <Dynamic a="23"/>
          <Component>
            {React.string("test..")}
          </Component>
          <App2>
            <Component>
              <p>
                {React.string("Demo of...")}
              </p>
            </Component>
          </App2>
          <Link href="https://github.com/davesnx/styled-ppx">
            {React.string("styled-ppx")}
          </Link>
        </App>
      </div>,
      el
    )
  | None => ()
};
