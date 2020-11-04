open Jest;
open Expect;
open ReactTestingLibrary;
Emotion.loadSerializer();

module MediaQueryComponent = [%styled.div {|
  color: red;

  @media (min-width: 30em) and (min-height: 20em) {
    color: brown;
  }
|}];

test("MediaQueryComponent renders", () => {
  <MediaQueryComponent />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
