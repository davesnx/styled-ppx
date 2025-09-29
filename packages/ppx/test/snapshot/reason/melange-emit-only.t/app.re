let appContainerStyles = [%cx2
  {|
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
|}
];

let footerStyles = [%cx2
  {|
  background-color: #f5f5f5;
  padding: 25px;
  border-top: 1px solid #ddd;
|}
];

[@react.component]
let make = () => {
  let (containerStyles, titleStyles) =
    Mylib.makeThemeStyles(~primary=CSS.blue, ~secondary=CSS.white);

  <div styles=appContainerStyles>
    <header />
    <div styles=containerStyles>
      <h1 styles=titleStyles> {React.string("Main Content")} </h1>
      <card
        title="Feature 1"
        content="This is a feature card using library styles"
      />
      <card title="Feature 2" content="Another card with shared styling" />
      <button />
    </div>
    <footer styles=footerStyles> {React.string("© 2025 My App")} </footer>
  </div>;
};
