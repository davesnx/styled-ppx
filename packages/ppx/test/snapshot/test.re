/* This tests ensure that the ppx transform the right extensions, to the right form.
There's one case for each of the different methods and doesn't need to type-check.

If you are looking to add some tests for CSS support,
check packages/ppx/test/native folder. */

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
  /* border-color: $(Theme.Border.black); */
  __UNSAFE__ color: trust-me;
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

let keyframe = [%styled.keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module ArrayDynamicComponent = [%styled.div (~var) =>
  [|
    [%css "color: $(var);"],
    [%css "display: block;"]
  |]
];

module SequenceDynamicComponent = [%styled.div
  (~var) => {
    Js.log("Logging when render");

  [|
    [%css "color: $(var);"],
    [%css "display: block;"]
  |]
  }
];

module DynamicComponentWithDefaultValue = [%styled.div (~var="green") => [|
  [%css "color: $(var);"],
  [%css "display: block;"]
|]];

/* This test ensures that the warning is being triggered */
/* module T = [%styled.span () => [|
  [%css "font-size: 16px"]
|]];
*/

/* let interpolationValue = "23";
[%css "font-size: $(interpolationValue)"];
 */
