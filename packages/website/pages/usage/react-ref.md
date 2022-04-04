# React's Ref

All styled components expose a prop `innerRef` that will be forwarded to its internal element.

```rescript
module Input = %styled.input("")

@react.component
let make = () => {
  let input = React.useRef(Js.Nullable.null)

  let focusInput = () =>
    input.current
    ->Js.Nullable.toOption
    ->Belt.Option.forEach(input => input->focus)

  let onClick = _ => focusInput()

  <div>
    <Input innerRef={ReactDOM.Ref.domRef(input)} />
    <button onClick> {React.string("Click to focus")} </button>
  </div>
}
```

All information related with React's Ref is explained in [rescript's docs](https://rescript-lang.org/docs/react/latest/forwarding-refs).
