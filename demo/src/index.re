module Component = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    key: string,
    [@bs.optional]
    ref: ReactDOMRe.domRef,
  };

  [@bs.set] external setClassName: (makeProps, string) => unit = "className";
  let styles = Emotion.(css([display(`block)]));
  let make = (props: makeProps) =>
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
  </Component>,
  "app"
);
