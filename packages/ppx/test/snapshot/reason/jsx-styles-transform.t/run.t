  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let styles = CSS.make("css-fj6mo5", []);
  let component1 = () =>
    div(
      ~className=?CSS.make("css-18jadct", []).className,
      ~style=?ReactDOM.Style.make(),
      ~children=["Hello World"],
      (),
    );
  let component2 = () =>
    button(
      ~className=?styles.className,
      ~style=?ReactDOM.Style.make(),
      ~children=["Click me"],
      (),
    );
  let dynamicStyles = color =>
    CSS.make(
      "css-1xlcfko",
      [("--color", CSS.get_value_from_rule(CSS.color(color)))],
    );
  let component3 = color =>
    span(
      ~className=?dynamicStyles(color).className,
      ~style=?ReactDOM.Style.make(),
      ~children=["Dynamic color"],
      (),
    );
