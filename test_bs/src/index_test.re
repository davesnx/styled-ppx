open Jest;
open Expect;
open ReactTestingLibrary;
module Opacity = [%styled "opacity: 0.9"]

module Overflow = [%styled {|
  /* overflow-y: visible; */   /* overflow-x: visible; */
  overflow: visible;
|}]



let componentsList = [Opacity, Overflow]

test("Component renders", () => {
  let wrapper =
    render(
      <StyledComponent>
        <h1> {ReasonReact.string("Heading")} </h1>
      </StyledComponent>,
    ) |> container

  expect(wrapper) |> toMatchSnapshot;
});
