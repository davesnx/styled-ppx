open Vitest
open ReactTestingLibrary

module Component = %styled.a("color: #454545")

describe("styled", () => {
  test("Component renders", _t => {
    <Component /> |> render |> container |> expect |> Expect.toMatchSnapshot
  })
})
