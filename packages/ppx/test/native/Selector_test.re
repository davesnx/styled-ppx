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
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|.bar|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "#bar",
    [%expr [%cx "#bar {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|#bar|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "div",
    [%expr [%cx "div { } "]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|div|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id=baz] {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|[id=baz]|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id="baz"] {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|[id="baz"]|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  /* (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&:nth-child(even)|js}, [||]) : CssJs.rule)|]) : string)],
  ), */
  /* (
    "nth-child(3n+1)",
    [%expr [%cx "&:nth-child(3n+1) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&:nth-child(3n+1)|js}, [||]) : CssJs.rule)|]) : string)],
  ), */

  /* Compound */
  (
    "&.bar",
    [%expr [%cx {js|&.bar {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&.bar|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "&.bar, &.foo",
    [%expr [%cx {js|&.bar, &.foo {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&.bar, &.foo|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "p:first-child",
    [%expr [%cx {js|p:first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|p:first-child|js}, [||]) : CssJs.rule)|]) : string)]
  ),
  (
    "p#first-child",
    [%expr [%cx {js|p#first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|p#first-child|js}, [||]) : CssJs.rule)|]) : string)]
  ),
  (
    ":active",
    [%expr [%cx "&:active {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&:active|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    ":hover",
    [%expr [%cx "&:hover {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|&:hover|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  /* (
    "p #first-child::before",
    [%expr [%cx {js|p #first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|p #first-child|js}, [||]) : CssJs.rule)|]) : string)]
  ), */
  /* (
    "p #first-child::before:hover",
    [%expr [%cx {js|p #first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|p #first-child::before:hover|js}, [||]) : CssJs.rule)|]) : string)]
  ), */

  /* Complex */
  (
    "& > a",
    [%expr [%cx "& > a { }"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& > a|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "&>a",
    [%expr [%cx "&>a { }"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& > a|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& #first-child|js}, [||]) : CssJs.rule)|]) : string)]
  ),(
    "& .bar",
    [%expr [%cx {js|& .bar {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& .bar|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& div",
    [%expr [%cx {js|& div {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& div|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& :first-child",
    [%expr [%cx {js|& :first-child {}|js}]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& :first-child|js}, [||]) : CssJs.rule)|]) : string)]
  ),
  (
    "& > div > div > div > div",
    [%expr [%cx "& > div > div > div > div { }"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& > div > div > div > div|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& div > .class",
    [%expr [%cx "& div > .class {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& div > .class|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  /* #foo > .bar + div.k1.k2 [id='baz']:hello(2):not(:where(#yolo))::before */
  (
    "& + &",
    [%expr [%cx "& + & {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& + &|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& span",
    [%expr [%cx "& span {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& span|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& span, & + &",
    [%expr [%cx "& span, & + & {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& span, & + &|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& p:not(.active)",
    [%expr [%cx "& p:not(.active) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& p:not(.active)|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    ".foo:is(.bar, #baz)",
    [%expr [%cx ".foo:is(.bar, #baz) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|.foo:is(.bar, #baz)|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"] {} "]],
    [%expr (CssJs.style(. [|
      (CssJs.selector(.
        {js|& input[type="password"]|js},
        [||],
      ) : CssJs.rule),
    |]) : string)],
  ),
  (
    "& button:hover",
    [%expr [%cx "& button:hover {} "]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& button:hover|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& $(Variables.selector_query)",
    [%expr [%cx "& $(Variables.selector_query) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& |js} ++ Variables.selector_query, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr (CssJs.style(. [| (CssJs.selector(. {js|& a[target="_blank"]|js}, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "$(pseudo)",
    [%expr [%cx "$(pseudo) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. pseudo, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
    [%expr (CssJs.style(. [|(CssJs.selector(. {js|& div > |js} ++ Variables.element, [||]) : CssJs.rule)|]) : string)],
  ),
  (
    "*:not(:last-child)",
    [%expr [%cx "& > *:not(:last-child) {}"]],
    [%expr (CssJs.style(. [|
      (CssJs.selector(.
        {js|& > *:not(:last-child)|js},
        [||]
      ) : CssJs.rule)
    |]) : string)],
  ),

  /* Stylesheets */
  (
    "html, body",
    [%expr [%styled.global {js|html, body {}|js}]],
    [%expr ignore((CssJs.global(. {js|html, body|js}, [||]) : unit))],
  ),
  (
    "html body",
    [%expr [%styled.global {js|html body {}|js}]],
    [%expr ignore((CssJs.global(. {js|html body|js}, [||]) : unit))],
  ),
  (
    "div > span",
    [%expr [%styled.global {js|div > span {}|js}]],
    [%expr ignore((CssJs.global(. {js|div > span|js}, [||]) : unit))],
  ),
  (
    "html div > span",
    [%expr [%styled.global {js|html div > span {}|js}]],
    [%expr ignore((CssJs.global(. {js|html div > span|js}, [||]) : unit))],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {js|html, body, #root, .class {}|js}]],
    [%expr ignore((CssJs.global(. {js|html, body, #root, .class|js}, [||]) : unit))],
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
