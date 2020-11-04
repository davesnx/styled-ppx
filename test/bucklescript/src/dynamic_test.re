open Jest;
open Expect;
open ReactTestingLibrary;
Emotion.loadSerializer();

module ComponentWithParameter = [%styled.div
  (~color, ~theme: [`Light | `Dark]) => {
    "background: blue";
    switch (theme) {
    | `Light => "background-color: #F0F0F0"
    | `Dark => "background-color: #202020"
    };
    "color: $(color)";
  }
];

test("ComponentWithParameter renders", () => {
  <ComponentWithParameter color=Css.red theme=`Light/>
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
