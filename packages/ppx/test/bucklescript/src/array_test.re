open Jest;
open Expect;
open ReactTestingLibrary;

EmotionSerializer.load();

module ArrayStatic = [%styled.section [|
  [%css_ "display: flex;"],
  [%css_ "justify-content: center;"]
|]];

module ArrayDynamicComponent = [%styled.div (~var) =>
  [|
    switch (var) {
      | `Black => [%css_ "color: #999999"]
      | `White => [%css_ "color: #FAFAFA"]
    },
    [%css_ "display: block;"]
  |]
];

module SequenceDynamicComponent = [%styled.div
  (~var) => {
    Js.log("Logging when render");

    [|
      switch (var) {
        | `Black => [%css_ "color: #999999"]
        | `White => [%css_ "color: #FAFAFA"]
      },
      [%css_ "display: block;"]
    |]
  }
];

test("ArrayStatic renders", () => {
  <ArrayStatic />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});

test("ArrayDynamicComponent renders", () => {
  <ArrayDynamicComponent var=`Black />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});

test("SequenceDynamicComponent renders", () => {
  <SequenceDynamicComponent var=`White />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
