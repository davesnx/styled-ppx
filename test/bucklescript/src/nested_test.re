open Jest;
open Expect;
open ReactTestingLibrary;
Emotion.loadSerializer();

module Nested = [%styled.div
  {|
    align-items: center;
    display: flex;
    color: red;

    height: 100vh;
    justify-content: center;
    width: 100vw;

    > p {
      color: purple;
    }
  |}
];

test("Nested component renders", () => {
  <Nested />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
