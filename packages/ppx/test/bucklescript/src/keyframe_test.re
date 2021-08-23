open Jest;
open ReactTestingLibrary;

EmotionSerializer.load();
let fadeIn = [%keyframe {|
  0% { opacity: 0 }
  100% { opacity: 1 }
|}];

module Animate = [%styled.div {|
  background-color: black;
  height: 100vh;
  width: 100vw;
  animation-name: $(fadeIn);
|}];

/* let keyframe_static_css_tests = [%expr
  [|
    (
      [%keyframe
        "
          from { opacity: 0 }
          to { opacity: 1 }
        "
      ],
      [|
        (0, [|CssJs.opacity(0.)|]),
        (100, [|CssJs.opacity(1.)|]),
      |],
    ),
    (
      [%keyframe "
        0% { opacity: 0 }
        100% { opacity: 1 }
      "],
      [|(0, [|CssJs.opacity(0.)|]), (100, [|CssJs.opacity(1.)|])|],
    ),
  |]
];
 */

let testData = [
  (
    "keyframe",
    [%keyframe
      "
        from { opacity: 0 }
        to { opacity: 1 }
      "
    ],
    CssJs.keyframes(. [|
      (0, [|CssJs.opacity(0.)|]),
      (100, [|CssJs.opacity(1.)|]),
    |])
  )
];

/* Since animationName is a string under the hood, casting it to string
to match it as a string */
external toString: CssJs.animationName => string = "%identity";

describe("Keyframes", _ => {
  open Expect;

  test("should render into a animation-name", () => {
    <Animate />
    |> render
    |> container
    |> expect
    |> toMatchSnapshot
  });

  Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
    test(string_of_int(index) ++ ". Supports " ++ name, () => {

      Expect.expect(toString(cssIn)) |> Expect.toMatch(toString(emotionOut));
    });
  });
});
