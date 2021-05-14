open Jest;
open Expect;
open ReactTestingLibrary;

EmotionSerializer.load();

let fadeIn = [%styled.keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module Animate = [%styled.div {|
  background-color: black;
  height: 100vh;
  width: 100vw;
  animation-name: $(fadeIn);
|}];

test("Animate should render keyframes", () => {
  <Animate />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
