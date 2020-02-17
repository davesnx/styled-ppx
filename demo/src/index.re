let styledComponentMultiline = Emotion.(css([display(`inline)]));

module Demo = {
  [@react.component]
  let make = () =>
    <div className=styledComponentMultiline>
      {React.string("Hello world")}
    </div>;
}

ReactDOMRe.renderToElementWithId(<Demo />, "app");
