open Jest;
open Expect;
open ReactTestingLibrary;

EmotionSerializer.load();
module Svg = [%styled.svg "width: 16px; height: 16px;"];

test("Svg renders", () => {
  <Svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" ariaHidden=true />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
