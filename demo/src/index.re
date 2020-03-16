module App = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;
|}];
module Link = [%styled.a {| color: #454545 |}];

/* module Component = [%styled () => {| margin-left: 10px |}]; */
module Component = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    ref: ReactDOMRe.domRef,
    [@bs.optional]
    children: React.element,
  };

  [@bs.val] [@bs.module "react"]
  external createElement:
    (string, Js.t({..}), array(React.element)) => React.element =
    "createElement";

  let styles = () => Emotion.(css([display(`block)]));

  let make = (props: makeProps) =>
    [@reason.preserve_braces]
    {
      let stylesObject = {"className": styles() };
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
    <Component>
      {React.string("- styled-ppx -")}
    </Component>
    <Link href="http://sancho.dev">
      {React.string("sancho.dev")}
    </Link>
  </App>,
  "app"
);
