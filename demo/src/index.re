module Component = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    color: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    cols: int,
  };
  [@bs.set] external setClassName: (makeProps, string) => unit = "className";
  let styles = Emotion.(css([display(`block)]));
  let make = (~children=?, props: makeProps) =>
    [@reason.preserve_braces]
    {
      setClassName(props, styles);

      React.createElement(
        "div",
        ~props,
        [|
          switch (children) {
          | Some(chil) => chil
          | None => React.null
          },
          [],
        |],
      );
    };
};

ReactDOMRe.renderToElementWithId(
    <Component>
      {React.string("- styled-ppx -")}
    </Component>
  "app"
);




















module Component = {
  [@react.component]
  let make = (~visible) => {
    <div />
  }
}





















