open Jest;
open Expect;
open ReactTestingLibrary;
Emotion.loadSerializer();

module ArrayStatic = [%styled.section [|
  [%css "display: flex;"],
  [%css "justify-content: center;"]
|]];

module ArrayDynamicComponent = [%styled.div (~var) =>
  [|
    switch (var) {
      | `Black => [%css "color: #999999"]
      | `White => [%css "color: #FAFAFA"]
    },
    [%css "display: block;"]
  |]
];

module SequenceDynamicComponent = [%styled.div
  (~var) => {
    Js.log("Logging when render");

    [|
      switch (var) {
        | `Black => [%css "color: #999999"]
        | `White => [%css "color: #FAFAFA"]
      },
      [%css "display: block;"]
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
