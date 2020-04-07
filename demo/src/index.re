module App = [%styled.div (~background) => {j|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  background-color: $background;
|j}];

module Link = [%styled.a {|
  color: #333;
|}];

let space = "10px";
let b = "flex";

module Component = [%styled (~c) => {j|
  color: $c;
|j}];

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log} background="#443434">
    <Component c="#FFFFFF">
      {React.string("- styled-ppx -")}
    </Component>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
