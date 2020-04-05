module App = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;
|}];

module Link = [%styled.a {|
  color: #333;
|}];

let space = "10px";
let b = "flex";

module Component = [%styled {j|
  margin: $(space);
  display: $b;
|j}]

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log}>
    <Component c="#443434">
      {React.string("- styled-ppx -")}
    </Component>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
