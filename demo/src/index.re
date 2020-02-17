let ppx = [%styled "display: flex; color: #000000; padding: 10px"];
let emotion = Emotion.(css([display(`inline), color(hex("000000")), padding(px(10))]));

module Demo = {
  [@react.component]
  let make = () =>
    <div>
      <div className=emotion>
        {React.string("Hello world")}
      </div>
      <div className=ppx>
        {React.string("from ppx")}
      </div>
    </div>
}

ReactDOMRe.renderToElementWithId(<Demo />, "app");
