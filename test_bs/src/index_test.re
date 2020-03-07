open Jest;
open Expect;
open ReactTestingLibrary;
module StyledComponent = [%styled "opacity: 0.9"]

test("Component renders", () => {
  let wrapper =
    render(
      <StyledComponent>
        <h1> {ReasonReact.string("Heading")} </h1>
      </StyledComponent>,
    ) |> container

  expect(wrapper) |> toMatchSnapshot;
});
