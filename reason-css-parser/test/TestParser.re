open TestFramework;
open Reason_css_parser;
open Parser;

let test = (parser, input, output) => (
  input,
  ({expect, _}) => {
    let parse = parse(parser);
    expect.result(parse(input)).toBe(Ok(output));
  },
);

let tests = [
  test(
    [%value "<rgb()>"],
    "rgb(.5 .3 10 / 1)",
    `Rgb(
      `Number(`Static_0(([0.5, 0.3, 10.0], Some(((), `Number(1.0)))))),
    ),
  ),
  test(
    [%value "<rgb()>"],
    "rgb(.6, .4, 5, 50%)",
    `Rgb(
      `Number(
        `Static_1(([0.6, 0.4, 5.0], Some(((), `Percentage(50.0))))),
      ),
    ),
  ),
  test(
    [%value "<rgb()>"],
    "rgba(25% 33% 44% / 0.6)",
    `Rgb(
      `Percentage(
        `Static_0(([25.0, 33.0, 44.0], Some(((), `Number(0.6))))),
      ),
    ),
  ),
  test(
    [%value "<rgb()>"],
    "rgba(2.5, 3.3, 4.4, 60%)",
    `Rgb(
      `Percentage(
        `Static_1(([2.5, 3.3, 4.4], Some(((), `Percentage(60.0))))),
      ),
    ),
  ),
];

describe("parser tests", ({test, _}) => {
  tests |> List.iter(((input, test_fn)) => test(input, test_fn))
});
