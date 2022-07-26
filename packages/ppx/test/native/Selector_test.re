open Setup;
open Ppxlib;

let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let selectors_css_tests = [
  /* Simple */
  (
    ".bar",
    [%expr [%cx ".bar      { } "]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|.bar|js}, [||])|])],
  ),
  (
    "#bar",
    [%expr [%cx "#bar {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|#bar|js}, [||])|])],
  ),
  (
    "div",
    [%expr [%cx "div { } "]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|div|js}, [||])|])],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id=baz] {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|[id=baz]|js}, [||])|])],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id="baz"] {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|[id="baz"]|js}, [||])|])],
  ),
  /* (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(even)|js}, [||])|])],
  ), */
  /* (
    "nth-child(3n+1)",
    [%expr [%cx "&:nth-child(3n+1) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(3n+1)|js}, [||])|])],
  ), */

  /* This two might be valid, but it shoudn't. Declarations can't have selectors without starting with &. Or maybe they should?
  TODO: Make sure it make sense first, and then fix. */
  /* (
    "html, body",
    [%expr [%cx {js|html, body {}|js}]],
     [%expr CssJs.style(. [|CssJs.selector(. {js|html, body|js}, [||])|])],
  ), */
  /* (
    "html body",
    [%expr [%cx {js|html body {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|html body|js}, [||])|])],
  ), */

  /* Compound */

  /* "&.bar" */
  (
    "&.bar",
    [%expr [%cx {js|&.bar {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&.bar|js}, [||])|])],
  ),
  (
    "&.bar, &.foo",
    [%expr [%cx {js|&.bar, &.foo {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&.bar, &.foo|js}, [||])|])],
  ),
  (
    "p:first-child",
    [%expr [%cx {js|p:first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|p:first-child|js}, [||])|])]
  ),
  (
    "p#first-child",
    [%expr [%cx {js|p#first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|p#first-child|js}, [||])|])]
  ),
  (
    ":active",
    [%expr [%cx "&:active {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:active|js}, [||])|])],
  ),
  (
    ":hover",
    [%expr [%cx "&:hover {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:hover|js}, [||])|])],
  ),
  /* (
    "p #first-child::before",
    [%expr [%cx {js|p #first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|p #first-child|js}, [||])|])]
  ), */
  /* (
    "p #first-child::before:hover",
    [%expr [%cx {js|p #first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|p #first-child::before:hover|js}, [||])|])]
  ), */

  /* Complex */
  (
    "& > a",
    [%expr [%cx "& > a { }"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||])|])],
  ),
  (
    "&>a",
    [%expr [%cx "&>a { }"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||])|])],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& #first-child|js}, [||])|])]
  ),(
    "& .bar",
    [%expr [%cx {js|& .bar {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& .bar|js}, [||])|])],
  ),
  (
    "& div",
    [%expr [%cx {js|& div {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& div|js}, [||])|])],
  ),
  (
    "& :first-child",
    [%expr [%cx {js|& :first-child {}|js}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& :first-child|js}, [||])|])]
  ),
  (
    "& > div > div > div > div",
    [%expr [%cx "& > div > div > div > div { }"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > div > div > div > div|js}, [||])|])],
  ),
  (
    "& div > .class",
    [%expr [%cx "& div > .class {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& div > .class|js}, [||])|])],
  ),
  /* #foo > .bar + div.k1.k2 [id='baz']:hello(2):not(:where(#yolo))::before */
  (
    "& + &",
    [%expr [%cx "& + & {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& + &|js}, [||])|])],
  ),
  (
    "& span",
    [%expr [%cx "& span {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& span|js}, [||])|])],
  ),
  (
    "& span, & + &",
    [%expr [%cx "& span, & + & {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& span, & + &|js}, [||])|])],
  ),
  (
    "& p:not(.active)",
    [%expr [%cx "& p:not(.active) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& p:not(.active)|js}, [||])|])],
  ),
  (
    ".foo:is(.bar, #baz)",
    [%expr [%cx ".foo:is(.bar, #baz) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|.foo:is(.bar, #baz)|js}, [||])|])],
  ),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"] {} "]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        {js|& input[type="password"]|js},
        [||],
      ),
    |])],
  ),
  (
    "& button:hover",
    [%expr [%cx "& button:hover {} "]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& button:hover|js}, [||])|])],
  ),
  (
    "& $(Variables.selector_query)",
    [%expr [%cx "& $(Variables.selector_query) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& |js} ++ Variables.selector_query, [||])|])],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr CssJs.style(. [| CssJs.selector(. {js|& a[target="_blank"]|js}, [||])|])],
  ),
  (
    "$(pseudo)",
    [%expr [%cx "$(pseudo) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. pseudo, [||])|])],
  ),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& div > |js} ++ Variables.element, [||])|])],
  ),
  (
    "*:not(:last-child)",
    [%expr [%cx "& > *:not(:last-child) {}"]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        {js|& > *:not(:last-child)|js},
        [||]
      )
    |])],
  ),
];

describe("Should transform selectors", ({test, _}) => {
  selectors_css_tests |>
    List.iteri((_index, (title, result, expected)) =>
      test(
        title,
        compare(result, expected),
      )
    );
});
