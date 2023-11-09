open Vitest
open ReactTestingLibrary

module Component = %styled.div(`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;

  width: unset;
`)

module ComponentInline = %styled.div("color: #454545")
module StyledInput = %styled.input("color: #454545")
module ComponentLink = %styled.a("color: #454545")

describe("styled", () => {
  test("Component renders", _t =>
    <Component /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )

  test("ComponentInline renders and defaults to a div", _t =>
    <ComponentInline /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )

  test("StyledInput renders and self-closing element (whithout children)", _t =>
    <StyledInput /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )

  describe("ComponentLink", _t => {
    test(
      "should render an <a /> tag",
      _t => <ComponentLink /> |> render |> container |> expect |> Expect.toMatchSnapshot,
    )

    test(
      "should receive href props",
      _t =>
        <ComponentLink href="https://sancho.dev" />
        |> render
        |> container
        |> expect
        |> Expect.toMatchSnapshot,
    )
  })
})
