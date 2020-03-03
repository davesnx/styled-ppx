open Jest;
open Expect;
open ReactTestingLibrary;
module StyledComponent = [%styled "opacity: 0.9"];

test("Component renders", () =>
  <StyledComponent>
    <h1> {ReasonReact.string("Heading")} </h1>
  </StyledComponent>
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
);
