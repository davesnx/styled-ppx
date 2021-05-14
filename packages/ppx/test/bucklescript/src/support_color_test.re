open Jest;

let testData = [
  ("hex", [%cx "color: #012"], CssJs.style(. [|CssJs.color(`hex("012"))|])),
  ("hex", [%cx "color: #0123"], CssJs.style(. [|CssJs.color(`hex("0123"))|])),
  ("hex", [%cx "color: #012345"], CssJs.style(. [|CssJs.color(`hex("012345"))|])),
  ("hex", [%cx "color: #01234567"], CssJs.style(. [|CssJs.color(`hex("01234567"))|])),
  ("rgb", [%cx "color: rgb(1 2 3)"], CssJs.style(. [|CssJs.color(`rgb((1, 2, 3)))|])),
  ("rgb", [%cx "color: rgb(1 2 3 / .4)"], CssJs.style(. [|CssJs.color(`rgba((1, 2, 3, `num(0.4))))|])),
  ("rgb", [%cx "color: rgba(1, 2, 3)"], CssJs.style(. [|CssJs.color(`rgb((1, 2, 3)))|])),
  ("rgb", [%cx "color: rgba(1, 2, 3, .4)"], CssJs.style(. [|CssJs.color(`rgba((1, 2, 3, `num(0.4))))|])),
  ("red", [%cx "color: red"], CssJs.style(. [|CssJs.color(CssJs.red)|])),
  ("blue", [%cx "color: blue"], CssJs.style(. [|CssJs.color(CssJs.blue)|])),
  ("background", [%cx "background-color: red"], CssJs.style(. [|CssJs.backgroundColor(CssJs.red)|])),
  ("currentColor", [%cx "color: currentcolor"], CssJs.style(. [|CssJs.color(`currentColor)|])),
  ("transparent", [%cx "color: transparent"], CssJs.style(. [|CssJs.color(`transparent)|])),
];

describe("color", _ => {
  Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
    test(string_of_int(index) ++ ". Supports " ++ name, () => {
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
    });
  });
});
