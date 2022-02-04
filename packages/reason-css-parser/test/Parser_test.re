open Setup;
open Reason_css_parser;
open Parser;

let test = (parser, input, output) => (
  input,
  ({expect, _}) => {
    let parse = parse(parser);
    let received = parse(input);
    switch (received) {
    | Error(message) => failwith(message)
    | _ => expect.result(received).toBe(Ok(output));
    };
  },
);

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
    [%value "<rgba()>"],
    "rgba(25% 33% 44% / 0.6)",
    `Rgba_0(([25.0, 33.0, 44.0], Some(((), `Number(0.6))))),
  ),
  test(
    [%value "<rgba()>"],
    "rgba(2.5, 3.3, 4.4, 60%)",
    `Rgba_3(([2.5, 3.3, 4.4], Some(((), `Percentage(60.0))))),
  ),
  test(
    [%value "<rgba()>"],
    "rgba(2.5, 3.3, 4.4, 0.5)",
    `Rgba_3(([2.5, 3.3, 4.4], Some(((), `Number(0.5))))),
  ),
  test(
    [%value "<track-size>"],
    "fit-content(50%)",
    `Fit_content(`Percentage(50.)),
  ),
  test(
    [%value "<calc-product>"],
    "4",
    (`Number(4.), [])
  ),
  test(
    [%value "<calc-sum>"],
    "4",
    ((`Number(4.), []), [])
  ),
  test(
    [%value "<calc-value>"],
    "4",
    `Number(4.)
  ),
  test(
    [%value "<calc-sum>"],
    "4 + 5",
    ((`Number(4.), []), [(`Cross(()), (`Number(5.), []))])
  ),
  test(
    [%value "<calc()>"],
    "calc(4 + 5)",
    (((`Number(4.), []), [(`Cross(()), (`Number(5.), []))]))
  ),
];

type product_op = [ `Static_0(unit, calc_value) | `Static_1(unit, float) ]
and calc_product = (calc_value, list(product_op))
and sum_op = [ `minus | `cross ]
and calc_sum = (calc_product, list((sum_op, calc_product)))
and calc_value = [ `Number(float) | `Dimension(float) | `Percentatge(float) | `Static(unit, calc_sum, unit) ];

describe("Parser", ({test, _}) => {
  tests |> List.iter(((input, test_fn)) => test(input, test_fn))
});
