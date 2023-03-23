module OneSingleProperty = %styled.div("display: block")
module Dynamic = %styled.div(
  (~color, ~background) => `
    color: $(color);
    background-color: $(background);
    padding: 0.8rem 1rem;
    border-radius: 10px;
    margin-top: 1rem;
  `
)

module App = {
  @react.component
  let make = () => {
    <>
      <OneSingleProperty> {React.string("Demo of...")} </OneSingleProperty>
      <Dynamic color=CssJs.hex("FFF") background=CssJs.hex("516CF0")>
        {React.string("Hello!")}
      </Dynamic>
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
