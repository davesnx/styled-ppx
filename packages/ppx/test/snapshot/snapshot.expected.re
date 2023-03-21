ignore(
  CssJs.global(.
    {js|html, body, #root, .class|js},
    [|CssJs.margin(`zero)|],
  ),
);
module ShoudNotBreakOtherModulesPpxsWithStringAsPayload = [%ppx ""];
module ShoudNotBreakOtherModulesPpxsWithMultiStringAsPayload = [%ppx
  {| stuff |}
];
module OneSingleProperty = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
      CssJs.label("OneSingleProperty"),
      CssJs.display(`block),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SingleQuoteStrings = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
      CssJs.label("SingleQuoteStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("section", newProps);
  };
};
module MultiLineStrings = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
      CssJs.label("MultiLineStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("section", newProps);
  };
};
module SelfClosingElement = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
  let styles = CssJs.style(. [|CssJs.label("SelfClosingElement")|]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("input", newProps);
  };
};
module ArrayStatic = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
      CssJs.label("ArrayStatic"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("section", newProps);
  };
};
module Theme = {
  let var = "#333333";
  module Border = {
    let black = "#222222";
  };
};
let black = "#000";
module StringInterpolation = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
let className =
  CssJs.style(. [|CssJs.label("className"), CssJs.display(`block)|]);
let classNameWithMultiLine =
  CssJs.style(. [|
    CssJs.label("classNameWithMultiLine"),
    CssJs.display(`block),
  |]);
let classNameWithArray =
  CssJs.style(. [|CssJs.label("classNameWithArray"), cssProperty|]);
let cssRule = CssJs.color(CssJs.blue);
let classNameWithCss =
  CssJs.style(. [|
    CssJs.label("classNameWithCss"),
    cssRule,
    CssJs.backgroundColor(CssJs.green),
  |]);
module DynamicComponent = {
  type props('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    var: 'var,
  };
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
  let styles = (~var, _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponent"),
      (CssJs.color(var): CssJs.rule),
      CssJs.display(`block),
    |]);
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SelectorsMediaQueries = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
let keyframe =
  CssJs.keyframes(. [|
    (0, [|CssJs.opacity(0.)|]),
    (100, [|CssJs.opacity(1.)|]),
  |]);
module ArrayDynamicComponent = {
  type props('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    var: 'var,
  };
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
  let styles = (~var, _) =>
    CssJs.style(. [|
      CssJs.label("ArrayDynamicComponent"),
      CssJs.display(`block),
      switch (var) {
      | `Black => CssJs.color(`hex({js|999999|js}))
      | `White => CssJs.color(`hex({js|FAFAFA|js}))
      },
    |]);
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SequenceDynamicComponent = {
  type props('size) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    size: 'size,
  };
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
  let styles = (~size, _) => {
    Js.log("Logging when render");
    CssJs.style(. [|
      (CssJs.width(size): CssJs.rule),
      CssJs.display(`block),
    |]);
  };
  let make = (props: makeProps('size)) => {
    let className =
      styles(~size=sizeGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "size"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithDefaultValue = {
  type props('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    var: 'var,
  };
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
  let styles = (~var=CssJs.hex("333"), _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponentWithDefaultValue"),
      CssJs.display(`block),
      (CssJs.color(var): CssJs.rule),
    |]);
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=?varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
let width = "120px";
let orientation = "landscape";
module SelectorWithInterpolation = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
      CssJs.label("SelectorWithInterpolation"),
      CssJs.media(.
        {js|only screen and (min-width: |js} ++ width ++ {js|)|js},
        [|CssJs.color(CssJs.blue)|],
      ),
      CssJs.media(.
        {js|(min-width: 700px) and (orientation: |js}
        ++ orientation
        ++ {js|)|js},
        [|CssJs.display(`none)|],
      ),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module MediaQueryCalc = {
  type props = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
  };
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithSequence = {
  type props('variant) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    variant: 'variant,
  };
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
  let styles = (~variant, _) => {
    let color = Theme.button(variant);
    CssJs.style(. [|
      CssJs.display(`inlineFlex),
      (CssJs.color(color): CssJs.rule),
      CssJs.width(`percent(100.)),
    |]);
  };
  let make = (props: makeProps('variant)) => {
    let className =
      styles(~variant=variantGet(props), ())
      ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "variant"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("button", newProps);
  };
};
module DynamicComponentWithArray = {
  type props('color, 'size) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    color: 'color,
    size: 'size,
  };
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
  let styles = (~size, ~color, _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponentWithArray"),
      CssJs.width(`percent(100.)),
      CssJs.display(`block),
      (CssJs.color(color): CssJs.rule),
      (CssJs.width(size): CssJs.rule),
    |]);
  let make = (props: makeProps('color, 'size)) => {
    let className =
      styles(~color=colorGet(props), ~size=sizeGet(props), ())
      ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    ignore(deleteProp(newProps, "size"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("button", newProps);
  };
};
let sharedStylesBetweenDynamicComponents = (color): CssJs.rule =>
  CssJs.color(color);
module DynamicCompnentWithLetIn = {
  type props('color) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    color: 'color,
  };
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
  let styles = (~color, _) => {
    let styles = sharedStylesBetweenDynamicComponents(color);
    CssJs.style(. styles);
  };
  let make = (props: makeProps('color)) => {
    let className =
      styles(~color=colorGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicCompnentWithIdent = {
  type props('a) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    a: 'a,
  };
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
  let styles = (~a as _, _) => CssJs.style(. cssRule);
  let make = (props: makeProps('a)) => {
    let className =
      styles(~a=aGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "a"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
