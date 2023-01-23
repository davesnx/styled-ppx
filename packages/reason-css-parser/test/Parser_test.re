open Setup;
open Reason_css_parser;
open Parser;
open Standard;
open Combinator;
open Modifier;
open Rule.Match;

let test = (parser, input, output) => (
  input,
  ({expect, _}) => {
    let parse = parse(parser);
    let received = parse(input);
    switch (received) {
    | Error(message) => failwith(message)
    | _ => expect.result(received).toBe(Ok(output))
    };
  },
);

let ext_pct = x => `Extended_percentage(`Percentage(x));
let pct = x => `Percentage(x);
let len = x => `Extended_length(`Length(x));

let tests = [
  test(
    [%value "<rgb()>"],
    "rgb(.5 .3 10 / 1)",
    `Rgb_1(([0.5, 0.3, 10.0], Some(((), `Number(1.0))))),
  ),
  test(
    [%value "<rgb()>"],
    "rgb(.6, .4, 5)",
    `Rgb_3(([0.6, 0.4, 5.0], None)),
  ),
  test(
    [%value "<rgb()>"],
    "rgb(25% 33% 44% / 0.6)",
    `Rgb_0(([pct(25.0), pct(33.0), pct(44.0)], Some(((), `Number(0.6))))),
  ),
  test(
    [%value "<rgb()>"],
    "rgb(2.5, 3.3, 4.4, 60%)",
    `Rgb_3(([2.5, 3.3, 4.4], Some(((), ext_pct(60.0))))),
  ),
  test(
    [%value "<rgb()>"],
    "rgb(2.5, 3.3, 4.4, 0.5)",
    `Rgb_3(([2.5, 3.3, 4.4], Some(((), `Number(0.5))))),
  ),
  test(
    [%value "<track-size>"],
    "fit-content(50%)",
    `Fit_content_1(ext_pct(50.)),
  ),
  test([%value "<calc-product>"], "4", (`Number(4.), [])),
  test([%value "<calc-sum>"], "4", ((`Number(4.), []), [])),
  test([%value "<calc-value>"], "4", `Number(4.)),
  test(
    [%value "<calc-sum>"],
    "4 + 5",
    ((`Number(4.), []), [(`Cross(), (`Number(5.), []))]),
  ),
  test(
    [%value "<calc()>"],
    "calc(4 + 5)",
    ((`Number(4.), []), [(`Cross(), (`Number(5.), []))]),
  ),
  test(
    [%value "<calc()>"],
    "calc(100%)",
    ((ext_pct(100.), []), []),
  ),
  test(
    [%value "<calc()>"],
    "calc(100% - 25px)",
    ((ext_pct(100.), []), [(`Dash(), (len(`Px(25.)), []))]),
  ),
  test(
    [%value "rare-function( [ <angle> ] ? ',' <color-stop-list> )"],
    "rare-function(90deg, blue 10%, red 20%)",
    (
      Some(`Deg(90.)),
      (),
      (Some((`Named_color(`Blue), Some(ext_pct(10.)))), [
        ((),
          (`Named_color(`Blue), Some(ext_pct(10.))),
        ),
      ], (), (`Named_color(`Red), Some(ext_pct(20.))))
    ),
  ),
  test(
    [%value "rare-function( [ <angle> ] ? ',' <color-stop-list> )"],
    "rare-function(blue 10%, red 20%)",
    (
      None,
      (),
      (Some((`Named_color(`Blue), Some(ext_pct(10.)))), [
        ((),
          (`Named_color(`Blue), Some(ext_pct(10.))),
        ),
      ], (), (`Named_color(`Red), Some(ext_pct(20.))))
    ),
  ),
  test(
    [%value "rare-function( [ <angle> ] ? ',' <color-stop-list> )"],
    "rare-function(blue, red 20%)",
    (
      None,
      (),
      (Some((`Named_color(`Blue), Some(ext_pct(10.)))), [
        ((),
          (`Named_color(`Blue), Some(ext_pct(10.))),
        ),
      ], (), (`Named_color(`Red), Some(ext_pct(20.))))
    ),
  ),
];

describe("Parser", ({test, _}) =>
  tests |> List.iter(((input, test_fn)) => test(input, test_fn))
);
