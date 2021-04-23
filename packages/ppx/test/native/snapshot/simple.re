/* [%styled.global {|
  html, body {
    margin: 0;
  }
|}]; */

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

let var = "#333333";
module StringInterpolation = [%styled.div {j|
  color: $var;
  display: block;
|j}];

let classNameHash = [%css "display: block"];

module DynamicComponent = [%styled.div
  (~var) => {j|
     color: $var;
     display: block;
   |j}
];
