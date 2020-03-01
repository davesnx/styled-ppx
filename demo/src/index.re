let emotion = Emotion.(css([display(`inline), color(hex("000000")), padding(px(10))]));

module Style = [%styled "display: flex;"];

module Style = {
  let styled = Emotion.(css([display(`flex)]));
  [%react.component]
  let make = (~children) => {
    <div className=styled>
      children
    </div>
  }
};

module Demo = {
  [@react.component]
  let make = () =>
    <div>
      <div>
        {React.string("React API")}
      </div>
    </div>
};

ReactDOMRe.renderToElementWithId(<Demo />, "app");
