open Jest;
open Expect;
open ReactTestingLibrary;

module Component = [%styled.div {|
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  height: 100vh;
  width: 100vw;

  font-size: 30px;

  width: unset;
|}];
module ComponentInline = [%styled "color: #454545"];
module ComponentLink = [%styled.a {| color: #454545 |}];

test("Component renders", () => {
  <Component />
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
