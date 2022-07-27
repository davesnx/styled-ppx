open Jest
open Expect
open ReactTestingLibrary

EmotionSerializer.load()

external fromAnimationName: string => CssJs.animationName = "%identity"

let fadeIn = fromAnimationName("fade")

/* let fadeIn = %keyframe(`
  0% { opacity: 0 }
  100% { opacity: 1 }
`) */

module Component = %styled.div(`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;

  animation-name: $(fadeIn);

  width: unset;
`)

module ComponentInline = %styled.div("color: #454545")
module StyledInput = %styled.input("color: #454545")
module ComponentLink = %styled.a("color: #454545")

test("Component renders", () => <Component /> |> render |> container |> expect |> toMatchSnapshot)

test("ComponentInline renders and defaults to a div", () =>
  <ComponentInline /> |> render |> container |> expect |> toMatchSnapshot
)

test("StyledInput renders and self-closing element (whithout children)", () =>
  <StyledInput /> |> render |> container |> expect |> toMatchSnapshot
)

describe("ComponentLink", () => {
  test("should render an <a /> tag", () =>
    <ComponentLink /> |> render |> container |> expect |> toMatchSnapshot
  )

  test("should receive href props", () =>
    <ComponentLink href="https://sancho.dev" /> |> render |> container |> expect |> toMatchSnapshot
  )
})
