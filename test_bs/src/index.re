open Jest;
open Expect;

module Result = {
  module Styles = {
    open Emotion;
    let className = css([display(`block)]);
  };
  [@react.component]
  let make = (~children) => {
    <div className={Styles.className}> children </div>;
  };
};

module ResultWithProps = {
  module Styles = {
    open Emotion;
    let className = (~color: Emotion.Css.Color.t) => css([display(`block), backgroundColor(color)]);
  };
  [@react.component]
  let make = (~children, ~color) => {
    <div className={Styles.className(color)}> children </div>;
  };
};

describe("Test", () => {
  test("inline", () => {
    let styledComponentInline = [%styled "display: block;"];

    expect(styledComponentInline).toEqual(Result);
  });

  test("multiline", () => {
    let styledComponentMultiline = [%styled
      {|
        display: block;
      |}
    ];

    expect(styledComponentInline).toEqual(Result);
  });

  test("with props", ({expect}) => {
    let StyledComponentWithProps = [%styled
      (~color) => {|
        display: block;
        color: $color;
      |};
    ];

    expect(StyledComponentInline).toEqual(ResultWithProps);
  });
});
