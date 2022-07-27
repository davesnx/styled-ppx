open Setup;
open Ppxlib;

let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

/* https://www.w3.org/TR/mediaqueries-5 */
let media_query_cases = [
  (
    "(min-width: 33px)",
    [%expr [%cx "@media (min-width: 33px) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(min-width: 33px)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "screen and (min-width: 33px) or (max-height: 15rem)",
    [%expr [%cx "@media screen and (min-width: 33px) or (max-height: 15rem) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|screen and (min-width: 33px) or (max-height: 15rem)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "(hover: hover)",
    [%expr [%cx "@media (hover: hover) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(hover: hover)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "(hover: hover) and (color)",
    [%expr [%cx "@media (hover: hover) and (color) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(hover: hover) and (color)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "not all and (monochrome)",
    [%expr [%cx "@media not all and (monochrome) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|not all and (monochrome)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "print and (color)",
    [%expr [%cx "@media print and (color) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|print and (color)|js}, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "(max-height: $(wat)",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(max-height: |js} ++ (wat ++ {js|)|js}), [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "($(wat))",
    [%expr [%cx "@media ($(wat)) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(|js} ++ (wat ++ {js|)|js}), [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "$(wat)",
    [%expr [%cx "@media $(wat) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. wat, [||]) : CssJs.rule )|]) : string)]
  ),
  (
    "(max-height: $(wat))",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|(max-height: |js} ++ (wat ++ {js|)|js}), [||]) : CssJs.rule )|]) : string)]
  ),
 /* Nested is not supported in code-gen
    https://www.w3.org/TR/mediaqueries-5/#media-conditions */
  /* (
    "(not (color)) and (not (hover))",
    [%expr [%cx "@media (not (color)) and (not (hover)) {}"]],
    [%expr (CssJs.style(. [|(CssJs.media(. {js|((not (color)) and (not (hover))|js}, [||]) : CssJs.rule )|]) : string)]
  ), */
 /* "@media screen, print and (color) {}" */
];

describe("Should transform @media", ({test, _}) => {
  media_query_cases |>
    List.iteri((_index, (title, result, expected)) =>
      test(
        title,
        compare(result, expected),
      )
    );
});

let keyframe_cases = [
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0% { color: red } 100% { color: green }"]],
    [%expr CssJs.keyframes(. [|(0, [|(CssJs.color(CssJs.red) : CssJs.rule )|]), (100, [|(CssJs.color(CssJs.green) : CssJs.rule)|]) |])]
  ),
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "{ 0% { color: red } 100% { color: green }}"]],
    [%expr CssJs.keyframes(. [|(0, [|(CssJs.color(CssJs.red) : CssJs.rule)|]), (100, [|(CssJs.color(CssJs.green) : CssJs.rule)|]) |])]
  ),
  (
    {|%keyframe "from { color: red } to { color: green }"|},
    [%expr [%keyframe "{ from { color: red } to { color: green }}"]],
    [%expr CssJs.keyframes(. [|(0, [|(CssJs.color(CssJs.red) : CssJs.rule)|]), (100, [|(CssJs.color(CssJs.green) : CssJs.rule)|]) |])]
  ),
];

describe("Should transform @keyframes", ({test, _}) => {
  keyframe_cases |>
    List.iteri((_index, (title, result, expected)) =>
      test(
        title,
        compare(result, expected),
      )
    );
});
