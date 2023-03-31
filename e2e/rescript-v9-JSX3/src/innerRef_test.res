open Vitest
open ReactTestingLibrary

let hasFocus: Dom.element => bool = %raw("(el) => document.activeElement === el")

module Input = %styled.input([%css("display: flex;")])

@send external focus: Dom.element => unit = "focus"

module TextInput = {
  @react.component
  let make = () => {
    let textInput = React.useRef(Js.Nullable.null)

    let focusInput = () =>
      switch textInput.current->Js.Nullable.toOption {
      | Some(dom) => dom->focus
      | None => ()
      }

    let onClick = _ => focusInput()

    <div>
      <Input type_="text" role="input" innerRef={ReactDOM.Ref.domRef(textInput)} />
      <input type_="button" role="button" value="Click to discover the truth" onClick />
    </div>
  }
}

describe("innerRef", () => {
  test("TextInput renders and passes innerRef", _t => {
    let component = render(<TextInput />)

    component |> getByRole(~matcher=#Str("button")) |> FireEvent.click |> ignore
    let inputHasFocus = component |> getByRole(~matcher=#Str("input")) |> hasFocus
    expect(inputHasFocus)->Expect.toBe(true)
  })
})
