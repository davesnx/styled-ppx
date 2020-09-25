open Jest;
open Expect;
open ReactTestingLibrary;

let fadeIn = [%styled.keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module Component = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;

  animation-name: $(fadeIn);
  /* animation: $(fadeIn) ease-in 200ms; */

  width: unset;
  @media (min-width: 30em) and (min-height: 20em) {
    color: brown;
  }
|}];
module ComponentInline = [%styled "color: #454545"];
module ComponentLink = [%styled.a {| color: #454545 |}];

module ComponentWithParameter = [%styled.div
  (~color: Css.Types.Color.t, ~theme: [`Light | `Dark]) => {
    "background: blue";
    switch (theme) {
    | `Light => "background-color: #F0F0F0"
    | `Dark => "background-color: #202020"
    };
    "color: $(color)";
  }
];

test("Component renders", () => {
  <Component />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});

test("ComponentWithParameter renders", () => {
  <ComponentWithParameter color=Css.red theme=`Light/>
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});

test("ComponentInline renders and defaults to a div", () => {
  <ComponentInline />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});

describe("ComponentLink", () => {
  test("should render an <a /> tag", () => {
    <ComponentLink />
    |> render
    |> container
    |> expect
    |> toMatchSnapshot
  });

  test("should receive href props", () => {
    <ComponentLink href="https://sancho.dev"/>
    |> render
    |> container
    |> expect
    |> toMatchSnapshot
  });
})
