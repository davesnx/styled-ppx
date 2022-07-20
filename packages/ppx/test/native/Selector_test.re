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
    [%expr [%cx ".bar {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|.bar|js}, [||])|])],
  ),
  (
    "#bar",
    [%expr [%cx "#bar {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|#bar|js}, [||])|])],
  ),
  (
    "div",
    [%expr [%cx "div {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|div|js}, [||])|])],
  ),
  (
    "[id=baz]",
    [%expr [%cx {j|[id=baz] {}|j}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|[id=baz]|js}, [||])|])],
  ),
  /* (
    "[id=baz]",
    [%expr [%cx {j|[id=baz] {}|j}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|[id=baz]|js}, [||])|])],
  ), */
  /* (
    "html, body",
    [%expr [%cx {j|html, body {}|j}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|html, body|js}, [||])|])],
  ), */
  /* (
    "*",
    [%expr [%cx {j|* {}|j}]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|*|js}, [||])|])],
  ), */

  /* Complex */
  /* (
    ">",
    [%expr [%cx "& > a { };"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||])|])],
  ),
  (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(even)|js}, [||])|])],
  ),
  (
    "nth-child(3n+1)",
    [%expr [%cx "& > div:nth-child(3n+1) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > div:nth-child(3n+1)|js}, [||])|])],
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
    "& p:not(.active)",
    [%expr [%cx "& p:not(.active) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& p:not(.active)|js}, [||])|])],
  ),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"] {} "]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        {js|& input|js} ++ {js|[|js} ++ {js|type = "password"|js} ++ {js|]|js},
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
    [%expr CssJs.style(. [|CssJs.selector(. {js|& |js} ++ Variables.selector_query ++ {js||js}, [||])|])],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        {js|& a|js}
          ++ {js|[|js}
          ++ {js|target = "_blank"|js}
          ++ {js|]|js},
        [||]
      )|]
    )],
  ),
  (
    "& a[$(Variabels.target)]",
    [%expr [%cx "& a[$(Variables.target)] {}"]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        ({js|& a|js}
          ++ ({js|[|js}
          ++ (({js||js}
          ++ (Variables.target
          ++ {js||js}))
          ++ {js|]|js}))),
        [||]
      )|]
    )],
  ),
  (
    "a[href^=$(Variables.href_target)]",
    [%expr [%cx "& a[href^=$(Variables.href_target)] {}"]],
    [%expr CssJs.style(. [|
      CssJs.selector(.
        ({js|& a|js}
          ++ ({js|[|js}
          ++ (({js|href^=|js}
          ++ (Variables.href_target
          ++ {js||js}))
          ++ {js|]|js}))),
        [||]
      )|]
    )],
  ),
  (
    "$(pseudo)",
    [%expr [%cx "$(pseudo) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js||js} ++ pseudo ++ {js||js}, [||])|])],
  ),
  (
    "div > .class",
    [%expr [%cx "& div > .class {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& div > .class|js}, [||])|])],
  ),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& div > |js} ++ Variables.element ++ {js||js}, [||])|])],
  ),
  (
    "&:$(Variables.pseudoclass)",
    [%expr [%cx "&:$(Variables.pseudoclass) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:|js} ++ Variables.pseudoclass ++ {js||js}, [||])|])],
  ),
  (
    "&::$(Variables.pseudoelement)",
    [%expr [%cx "&::$(Variables.pseudoelement) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&::|js} ++ Variables.pseudoelement ++ {js||js}, [||])|])],
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
  ), */

  /* "&.bar" */
  /* "& .bar", */
  /* p :first-child */
  /* p:first-child */
  /* p#first-child */
  /* p #first-child */
  /* div:nth-child(2n+1 of #someId.someClass) */
  /* #foo > .bar + div.k1.k2 [id='baz']:hello(2):not(:where(#yolo))::before */
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
