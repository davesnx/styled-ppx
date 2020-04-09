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

module Link = [%styled.a {|
  color: #FFFFFF;
  font-size: 36px;
  margin-top: 16px;
|}];

let space = "10px";
let b = "flex";

module Component = [%styled (~c) => {j|
  color: $c;
  font-size: 42px;
|j}];

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log} background="#443434">
    <Component c="#FFFFFF">
      {React.string("Demo of...")}
    </Component>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
  </App>,
  "app"
);
