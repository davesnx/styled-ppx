module Style = [%styled {|display: flex; color: #333;|}];

module Component2 = {
  let styled = Emotion.(css([display(`flex)]));
  [@react.component]
  let make = (~children) =>
    [@JSX] div(~className=styled, ~children=[children], ());
};

module Demo = {
  [@react.component]
  let make = () =>
    <Style>
      {React.string("React API")}
    </Style>
};

ReactDOMRe.renderToElementWithId(<Demo />, "app");
