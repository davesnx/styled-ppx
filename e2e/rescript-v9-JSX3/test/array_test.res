/* open Vitest
 open ReactTestingLibrary */

/* module ArrayStatic = %styled.section([%css("display: flex;"), %css("justify-content: center;")])

module ArrayDynamicComponent = %styled.div(
  (~var) => [
    switch var {
    | #Black => %css("color: #999999")
    | #White => %css("color: #FAFAFA")
    },
    %css("display: block;"),
  ]
)

module SequenceDynamicComponent = %styled.div(
  (~var) => {
    Js.log("Logging when render")

    [
      switch var {
      | #Black => %css("color: #999999")
      | #White => %css("color: #FAFAFA")
      },
      %css("display: block;"),
    ]
  }
)

describe("Array", () => {
  test("ArrayStatic renders", _t =>
    <ArrayStatic /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )

  test("ArrayDynamicComponent renders", _t =>
    <ArrayDynamicComponent var=#Black /> |> render |> container |> expect |> Expect.toMatchSnapshot
  )

  test("SequenceDynamicComponent renders", _t =>
    <SequenceDynamicComponent var=#White />
    |> render
    |> container
    |> expect
    |> Expect.toMatchSnapshot
  )
})
 */
