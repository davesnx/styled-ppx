open Vitest
open ReactTestingLibrary

module Nested = %styled.div(`
  align-items: center;
  display: flex;
  color: red;

  height: 100vh;
  justify-content: center;
  width: 100vw;

  & > p {
    color: purple;
  }
`)

describe("Nested", () => {
  test("Nested component renders", _t =>
    <Nested /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )
})
