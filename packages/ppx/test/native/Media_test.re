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
  /* (
    "(min-width: 33px)",
    [%expr "@media (min-width: 33px) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "(min-width: 33px)", [||])|])]
  ),
  (
    "screen and (min-width: 33px) or (max-height: 15rem)",
    [%expr "@media screen and (min-width: 33px) or (max-height: 15rem) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "screen and (min-width: 33px) or (max-height: 15rem)", [||])|])]
  ),
  (
    "(hover: hover)",
    [%expr "@media (hover: hover) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "(hover: hover)", [||])|])]
  ),
  (
    "(hover: hover) and (color)",
    [%expr "@media (hover: hover) and (color)"],
    [%expr CssJs.style(. [|CssJs.media(. "screen and (min-width: 33px) or (max-height: 15rem) and (hover: hover) and (color)", [||])|])]
  ),
  (
    "not all and (monochrome)",
    [%expr "@media not all and (monochrome) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "not all and (monochrome)", [||])|])]
  ),
  (
    "print and (color)",
    [%expr "@media print and (color) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "print and (color)", [||])|])]
  ),
  (
    "(max-height: $(wat)",
    [%expr "(max-height: $(wat) {}"],
    [%expr CssJs.style(. [|CssJs.media(. "screen and (min-width: 33px) or (max-height: $(wat)", [||])|])]
  ), */
 /* Nested is not supported
    https://www.w3.org/TR/mediaqueries-5/#media-conditions */
 /* "@media (not (screen and (color))), print and (color) {}" */
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
