module App = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;
|}];

module Link = [%styled.a {|
  color: #333;
|}];


module Component2 = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    ref: ReactDOMRe.domRef,
    [@bs.optional]
    children: React.element,

    mierda: string
  };

  [@bs.val] [@bs.module "react"]
  external createElement:
    (string, Js.t({..}), array(React.element)) => React.element =
    "createElement";

  let styled = (~mierda) => Emotion.(css([display(`block), color(hex(mierda))]));

  let make = (props: makeProps) =>
    [@reason.preserve_braces]
    {
      let stylesObject = {"className": styled(~mierda=mierdaGet(props)) };
      let newProps = Js.Obj.assign(Js.Obj.empty(), Obj.magic(props));
      createElement(
        "section",
        Js.Obj.assign(newProps, stylesObject),
        [|
          switch (childrenGet(props)) {
          | Some(chil) => chil
          | None => React.null
          },
        |],
      );
    };
};

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log}>
    <Component2 mierda="dd6c0f">
      {React.string("- styled-ppx -")}
    </Component2>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
