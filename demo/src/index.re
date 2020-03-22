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

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log}>
    <Link key="asdf">
      {React.string("- styled-ppx -")}
    </Link>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
