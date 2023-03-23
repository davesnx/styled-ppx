  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module OneSingleProperty = {
    type props = JsxDOM.domProps;
    [@bs.val] [@bs.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
    [@bs.val]
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let styles =
      CssJs.style(. [|
        CssJs.label("OneSingleProperty"),
        CssJs.display(`block),
      |]);
    let make = (props: props) => {
      let className = styles;
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      createVariadicElement("div", newProps);
    };
  };
