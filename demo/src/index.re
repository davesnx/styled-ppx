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

module M2 = [%styled.div (~otraProp) => {j|
  color: $otraProp;
  margin-left: -10px;
  display: block;
|j}];

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log}>
    <M2 otraProp="#dd6c0f">
      {React.string("- styled-ppx -")}
    </M2>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
