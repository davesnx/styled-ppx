module Component = [%styled "color: #333"];
module App = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;

  height: 100vh;
|}];
module Link = [%styled.a "color: #454545"];

ReactDOMRe.renderToElementWithId(
  <App key="1">
    <Component key="http://sancho.dev">
      {React.string("- styled-ppx -")}
    </Component>
    <Link href="http://sancho.dev" />
  </App>,
  "app"
);
