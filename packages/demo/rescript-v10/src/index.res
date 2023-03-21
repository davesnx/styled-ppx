module Component = {
  type props = JsxDOM.domProps

  @val @module("react")
  external createVariadicElement: (string, Js.t<{..}>) => React.element = "createElement"
  let deleteProp = %raw("(newProps, key) => delete newProps[key]")
  @val
  external assign2: (Js.t<{..}>, Js.t<{..}>, Js.t<{..}>) => Js.t<{..}> = "Object.assign"
  let getOrEmpty = str => {
    switch str {
    | Some(str) => " " ++ str
    | None => ""
    }
  }
  let styles = CssJs.style(. [CssJs.label("OneSingleProperty"), CssJs.display(#block)])

  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className)
    let stylesObject = {"className": className, "ref": props.ref}
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject)
    createVariadicElement("div", newProps)
  }
}

module App = {
  @react.component
  let make = () => {
    <Component onClick=Js.log> {React.string("Demo of...")} </Component>
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
