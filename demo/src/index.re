module Style = [%styled {|display: flex; color: #333;|}];

ReactDOMRe.renderToElementWithId(
  <Style>
    {React.string("React API")}
  </Style>,
  "app"
);
