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

module Component = [%styled (~c) => {j|
  color: $(c);
  display: block;
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
