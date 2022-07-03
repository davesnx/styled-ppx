open Setup;
open Ppxlib;
let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let selectors_css_tests = [
  (
    ">",
    [%expr [%cx "& > a { }; & > b { };"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||]), CssJs.selector(. {js|& > b|js}, [||])|])],
  ),
  (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(even)|js}, [||])|])],
  ),
  (
    "nth-child(3n+1)",
    [%expr [%cx "& > div:nth-child(3n+1) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > div:nth-child|js} ++
                   ({js|(|js} ++ {js|3n + 1|js} ++ {js|)|js}), [||])|])],
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
    [%expr CssJs.style(. [|CssJs.selector(. {js|& p:not|js} ++ {js|(|js} ++ {js|.active|js} ++ {js|)|js}, [||])|])],
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
  )
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
