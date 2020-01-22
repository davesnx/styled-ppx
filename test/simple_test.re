open Test_framework;
open Re_styled_ppx;

module Result = {
  module Styles = {
    open Emotion;
    let className = [%css display(`block)];
  };
  [@react.component]
  let make = (~children) => {
    <div className> children </div>;
  };
};

module ResultWithProps = {
  module Styles = {
    open Emotion;
    let className = (~color) => [%css [display(`block), color(color)]];
  };
  [@react.component]
  let make = (~children, ~color) => {
    <div className={className(color)}> children </div>;
  };
};

describe("Test", ({test, _describe, _}) => {
  test("inline", ({expect}) => {
    let StyledComponentInline = [%re_styled_ppx "display: block;"];

    expect(StyledComponentInline).toEqual(Result);
  });

  test("multiline", ({expect}) => {
    let StyledComponentMultiline = [%re_styled_ppx
      {|
        display: block;
      |}
    ];

    expect(StyledComponentInline).toEqual(Result);
  });

  test("with props", ({expect}) => {
    let StyledComponentWithProps = [%re_styled_ppx
      (~color) => {
        {j|
          display: block;
          color: $color;
        |j};
      }
    ];

    expect(StyledComponentInline).toEqual(ResultWithProps);
  });
});
