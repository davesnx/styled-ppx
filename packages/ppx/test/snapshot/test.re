/* This tests ensure the transformation goes right and doesn't need to type-check.
If you are looking to add some tests for CSS support, check packages/ppx/test/native folder. */

[%styled.global {|
  html, body, #root, .class {
    margin: 0;
  }
|}];

module ShoudNotBreakOtherModulesPpxsWithStringAsPayload = [%ppx ""];
module ShoudNotBreakOtherModulesPpxsWithMultiStringAsPayload = [%ppx {| stuff |}];

module OneSingleProperty = [%styled.div "display: block"];
module SingleQuoteStrings = [%styled.section "
  display: flex;
  justify-content: center;
"];

module MultiLineStrings = [%styled.section {|
  display: flex;
  justify-content: center;
|}];

module SelfClosingElement = [%styled.input ""];

module ArrayStatic = [%styled.section [|
  [%css "display: flex;"],
  [%css "justify-content: center;"]
|]];

module Theme = {
  let var = "#333333";
  module Border = {
    let black = "#222222";
  }
};
let black = "#000";

module StringInterpolation = [%styled.div {j|
  color: $(Theme.var);
  background-color: $(black);
  border-color: $(Theme.Border.black);
  display: block;
|j}];

let className = [%cx "display: block;"];
let classNameWithMultiLine = [%cx {| display: block; |}];
let classNameWithArray = [%cx [| cssProperty |]];
let cssRule = [%css "color: blue;"];
let classNameWithCss = [%cx [| cssRule, [%css "background-color: green;"] |]];

module DynamicComponent = [%styled.div
  (~var) => {j|
    color: $(var);
    display: block;
  |j}
];

module SelectorsMediaQueries = [%styled.div {j|
  @media (min-width: 600px) {
    background: blue;
  }

  &:hover {
    background: green;
  }

  & > p { color: pink; font-size: 24px; }
|j}
];

let keyframe = [%keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module ArrayDynamicComponent = [%styled.div (~var) =>
  [|
    switch (var) {
      | `Black => [%css "color: #999999"]
      | `White => [%css "color: #FAFAFA"]
    },
    [%css "display: block;"]
  |]
];

module SequenceDynamicComponent = [%styled.div (~size) => {
  Js.log("Logging when render");
  [|
    [%css "width: $(size)"],
    [%css "display: block;"]
  |]
  }
];

module DynamicComponentWithDefaultValue = [%styled.div (~var=CssJs.hex("333")) => [|
  [%css "color: $(var);"],
  [%css "display: block;"]
|]];

let width = "120px";
let orientation = "landscape"

module SelectorWithInterpolation = [%styled.div {|
  @media only screen and (min-width: $(width)) {
    color: blue;
  }

  @media (min-width: 700px) and (orientation: $(orientation)) {
    display: none;
  }
|}];

module MediaQueryCalc = [%styled.div {|
  @media (min-width: calc(2px + 1px)) {
    color: red;
  }

  @media (min-width: calc(1000px - 2%)) {
    color: red;
  }
|}];

/* This test ensures that the warning is being triggered */
/* module T = [%styled.span () => [|
  [%css "font-size: 16px"]
|]];
*/

module DynamicComponentWithSequence = [%styled.button (~variant) => {
  let color = Theme.button(variant);
  [|
      [%css "display: inline-flex"],
      [%css "color: $(color)"],
      [%css "width: 100%;"],
  |];
}];

module DynamicComponentWithArray = [%styled.button (~size, ~color) => {
  [|
    [%css "width: $(size)"],
    [%css "color: $(color)"],
    [%css "display: block;"],
    [%css "width: 100%;"],
  |]
}];

let sharedStylesBetweenDynamicComponents = (color) => [%css "color: $(color)"];

module DynamicCompnentWithLetIn = [%styled.div
  (~color) => {
    let styles = sharedStylesBetweenDynamicComponents(color);
    styles;
  }
];

module DynamicCompnentWithIdent = [%styled.div
  (~a as _) => {
    cssRule;
  }
];
