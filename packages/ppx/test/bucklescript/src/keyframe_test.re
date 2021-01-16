open Jest;
open Expect;
open ReactTestingLibrary;
Emotion.loadSerializer();

let fadeIn = [%styled.keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module Animate = [%styled.div {|
  background-color: black;
  height: 100vh;
  width: 100vw;
  animation-name: $(fadeIn);
  /* animation: $(fadeIn) ease-in 200ms; */
|}];

test("Animate should render keyframes", () => {
  <Animate />
  |> render
  |> container
  |> expect
  |> toMatchSnapshot
});
