let red = CssJs.red

module Component = %styled.div(`
  background-color: red;
  display: $(red);
`)

switch ReactDOM.querySelector("#app") {
| Some(el) =>
  ReactDOM.render(
    <div onClick=Js.log>
      <Component> {React.string("test..")} </Component>
    </div>,
    el,
  )
| None => ()
}
