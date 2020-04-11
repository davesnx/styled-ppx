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
  color: currentColor;
  z-index: 100;
|}];

let space = "10px";
let b = "flex";

let bshadow = Emotion.(css([
  color(black)
]))

Js.log(bshadow);

module Component = [%styled (~c) => {j|
  color: $c;
  display: $b;
  margin: $space;
|j}];

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
