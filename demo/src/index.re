module App = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;
|}];
module Component = [%styled {| margin-left: -10px |}];
module Link = [%styled.a {| color: #454545 |}];

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log}>
    <Component>
      {React.string("- styled-ppx -")}
    </Component>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
