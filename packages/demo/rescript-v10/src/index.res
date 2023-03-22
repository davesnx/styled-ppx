module OneSingleProperty = %styled.div("display: block")

module App = {
  @react.component
  let make = () => {
    <>
      <OneSingleProperty> {React.string("Demo of...")} </OneSingleProperty>
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
