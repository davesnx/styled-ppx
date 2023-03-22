  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module Theme = {
    let var = CssJs.hex("333333");
    module Border = {
      let black = CssJs.hex("222222");
    };
  };
  let black = CssJs.hex("000");
  module StringInterpolation = {
    type props = JsxDOM.domProps;
    [@bs.val] [@bs.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
    [@bs.val]
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let getOrEmpty = str => {
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    };
    let styles =
      CssJs.style(. [|
        CssJs.label("StringInterpolation"),
        (CssJs.color(Theme.var): CssJs.rule),
        (CssJs.backgroundColor(black): CssJs.rule),
        (CssJs.borderColor(Theme.Border.black): CssJs.rule),
        CssJs.display(`block),
      |]);
    let make = (props: props) => {
      let className = styles;
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      createVariadicElement("div", newProps);
    };
  };
