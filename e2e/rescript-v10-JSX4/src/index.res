%styled.global(`
  body {
    font-size: 1em;
    -webkit-font-smoothing: antialiased;
    font-family:
      -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
    background-color: hsla(165, 80%, 15%, 0.03);
  }
`)

%styled.global(`
  html, body, #root, .class {
    box-sizing: border-box;
  }
`)

let a = [
  %css(`border-width: thin`),
  %css(`outline-width: medium`),
  %css(`outline: medium solid red`),
]

module DynamicComponent = %styled.div(
  (~var) => {
    `
      color: $(var);
      display: flex
    `
  }
)

module Wat = %styled.div(`
  display: flex;
`)

module Link = %styled.a(`
  font-size: 36px;
  margin-top: 16px;
`)

module Input = %styled.input(
  "padding: 4px; border-color: green; border-radius: 4px; margin-right: 16px; margin-top: 16px; border-width: 3px;"
)

@send external focus: Dom.element => unit = "focus"

module TextInput = {
  @react.component
  let make = () => {
    let textInput = React.useRef(Js.Nullable.null)
    let buttonInput = React.useRef(Js.Nullable.null)

    let focusInput = () =>
      switch textInput.current->Js.Nullable.toOption {
      | Some(dom) => dom->focus
      | None => ()
      }

    let onClick = _ => {
      Js.log(textInput)
      Js.log(buttonInput)
      focusInput()
    }

    <div>
      <Input type_="text" innerRef={ReactDOM.Ref.domRef(textInput)} />
      <input
        type_="button" ref={ReactDOM.Ref.domRef(buttonInput)} value="Focus the text input" onClick
      />
    </div>
  }
}

module Component = %styled.div(`
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;

  @media (min-width: 600px) {
    background: blue;
  }

  &:hover {
    background: green;
  }

  & > p { color: pink; font-size: 24px; }
`)

let stilos = %cx("box-shadow: inset 10px 10px 0 0 #ff0000, 10px 10px 0 0 #ff0000")

let styles = CSS.style([
  CSS.label("ComponentName"),
  CSS.display(#block),
  %css("flex-direction: row"),
])

module Theme = {
  type kind =
    | Main
    | Ghost

  let button = variant => {
    switch variant {
    | Main => #hex("333")
    | Ghost => #hex("000")
    }
  }
}

module Button = %styled.button(
  (~color) => {
    let buttonColor = Theme.button(color)

    [%css("margin-left: 16px"), %css("display: block;"), %css("color: $(buttonColor)")]
  }
)

let fonts = [#quoted("Inter")]

let title = CSS.style([
  CSS.label("title"),
  %css("font-family: $(fonts)"),
  CSS.fontSize(#px(24)),
  CSS.fontWeight(#bold),
  CSS.color(#hex("333")),
])

module App = {
  @react.component
  let make = () => {
    <>
      <h1 className=title> {React.string("Demo of styled-ppx in ReScript v10")} </h1>
      <ul>
        <li> {React.string("ReScript + @rescript/react")} </li>
        <li> {React.string("vite")} </li>
        <li> {React.string("styled-ppx")} </li>
        <li> {React.string("emotion/css")} </li>
      </ul>
      <Wat \"as"="section" className="more-classes">
        <DynamicComponent var={CSS.hex("516CF0")}> {React.string("Halo :)")} </DynamicComponent>
        <Button color={Theme.Main}> {React.string("CLICK ME!")} </Button>
      </Wat>
      <TextInput />
    </>
  }
}

switch ReactDOM.querySelector("#app") {
| Some(el) =>
  let root = ReactDOM.Client.createRoot(el)
  ReactDOM.Client.Root.render(
    root,
    <React.StrictMode>
      <App />
    </React.StrictMode>,
  )
| None => ()
}
