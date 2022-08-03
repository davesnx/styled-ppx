module App = %styled.div(`
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  cursor: pointer;
`)

module App2 = {
  @react.component
  let make = (~children) => <div> children </div>
}

let cosas = "external-selector"

let c = %css(`content: ""`)
let unsafe = CssJs.unsafe(`content`, ``)

let className = %cx([c, unsafe])

module Size = {
  let small = CssJs.px(10)
}

module Link = %styled.a(`
  margin: $(Size.small);

  & $(cosas) {
    font-size: 36px;
    margin-top: 16px;
  }

  &:hover {
    font-size: 44px;
  }
`)

module Line = %styled.span("display: inline;")
module Wrapper = %styled.div("display: inline;")

module Dynamic = %styled.input((~a as _) => "display: inline;")

module Component = %styled.div(`
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;
`)

switch ReactDOM.querySelector("#app") {
| Some(el) =>
  ReactDOM.render(
    <App onClick=Js.log>
      <div className />
      <Dynamic a="23" />
      <Component> {React.string("test..")} </Component>
      <App2> <Component> {React.string("Demo of...")} </Component> </App2>
      <Link href="https://github.com/davesnx/styled-ppx"> {React.string("styled-ppx")} </Link>
      <Link href="https://github.com/davesnx/styled-ppx"> {React.string("styled-ppx")} </Link>
      <Link href="https://github.com/davesnx/styled-ppx"> {React.string("styled-ppx")} </Link>
    </App>,
    el,
  )
| None => ()
}
