  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module SelectorsMediaQueries = {
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
        CssJs.label("SelectorsMediaQueries"),
        CssJs.media(.
          {js|(min-width: 600px)|js},
          [|CssJs.backgroundColor(CssJs.blue)|],
        ),
        CssJs.selector(.
          {js|&:hover|js},
          [|CssJs.backgroundColor(CssJs.green)|],
        ),
        CssJs.selector(.
          {js|& > p|js},
          [|CssJs.color(CssJs.pink), CssJs.fontSize(`pxFloat(24.))|],
        ),
      |]);
    let make = (props: props) => {
      let className = styles ++ getOrEmpty(props.className);
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      createVariadicElement("div", newProps);
    };
  };
