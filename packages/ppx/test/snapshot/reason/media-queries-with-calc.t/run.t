  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module MediaQueryCalc = {
    type props = JsxDOM.domProps;
    [@bs.val] [@bs.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let getOrEmpty = str => {
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    };
    let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
    [@bs.val]
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let styles =
      CssJs.style(. [|
        CssJs.label("MediaQueryCalc"),
        CssJs.media(.
          {js|(min-width: calc(2px + 1px))|js},
          [|CssJs.color(CssJs.red)|],
        ),
        CssJs.media(.
          {js|(min-width: calc(1000px - 2%))|js},
          [|CssJs.color(CssJs.red)|],
        ),
      |]);
    let make = (props: props) => {
      let className = styles ++ getOrEmpty(props.className);
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      createVariadicElement("div", newProps);
    };
  };
