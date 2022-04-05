open Setup;
open Ppxlib;

let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

module Variables = {
  let element = "p";
  let pseudoclass = "active";
  let pseudoelement = "before";
  let selector = "button:hover";
  let selector_query = "button > p";
  let target = "target";
  let href_target = "\"https\"";
  let pseudo = "& + &";
};

let selector_css_tests = [
  (
    [%expr [%cx "& > a {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||])|])],
  ),
  (
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&:nth-child(|js} ++ {js|even|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "&:active {}"]],
    [%expr CssJs.style(. [|CssJs.active([||])|])],
  ),
  ([%expr [%cx "&:hover {}"]], [%expr CssJs.style(. [|CssJs.hover([||])|])]),
  (
    [%expr [%cx "& + & {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& + &|js}, [||])|])],
  ),
  (
    [%expr [%cx "& span {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& span|js}, [||])|])],
  ),
  (
    [%expr [%cx "& button:hover {} "]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|& button:hover|js}, [||])|])
    ],
  ),
  (
    [%expr [%cx "& > div:nth-child(3n+1) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|& > div:nth-child(|js} ++ {js|3n + 1|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "& p:not(.active) { display: none; }"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|& p:not(|js} ++ {js|.active|js} ++ {js|)|js},
          [|CssJs.display(`none)|],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "& $(Variables.selector_query) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|& |js} ++ Variables.selector_query ++ {js||js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "a[$(Variables.target)] {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|a|js}
          ++ {js|[|js}
          ++ ({js||js} ++ Variables.target ++ {js||js})
          ++ {js|]|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "a[href^=$(Variables.href_target)] {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|a|js}
          ++ {js|[|js}
          ++ ({js|href^=|js} ++ Variables.href_target ++ {js||js})
          ++ {js|]|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "$(Variables.pseudo) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(. {js||js} ++ Variables.pseudo ++ {js||js}, [||]),
      |])
    ],
  ),
  (
    [%expr [%cx "div > $(Variables.element) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|div > |js} ++ Variables.element ++ {js||js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "&:$(Variables.pseudoclass) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&:|js} ++ Variables.pseudoclass ++ {js||js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "&::$(Variables.pseudoelement) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&::|js} ++ Variables.pseudoelement ++ {js||js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "&:is(em, #foo) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&:is(|js} ++ {js|em, #foo|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "&:not(em, strong#foo) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&:not(|js} ++ {js|em, strong#foo|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "h1 ~ pre {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|h1 ~ pre|js}, [||])|])],
  ),
  (
    [%expr [%cx ".qux:where(em, #foo#bar#baz) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|.qux:where(|js}
          ++ {js|em, #foo#bar#baz|js}
          ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "ol > li:last-child {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|ol > li:last-child|js}, [||])|])
    ],
  ),
  (
    [%expr [%cx "&:nth-last-child(-n + 2) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|&:nth-last-child(|js} ++ {js|-n + 2|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    [%expr [%cx "& input[type=\"password\"] {} "]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|& input[|js}
          ++ {js|type = "password"|js}
          ++ {js|]|js},
          [||],
        ),
      |])
    ],
  ),
  /* BUG evenofli */
  (
    [%expr [%cx "&:nth-child(even of li, .item) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(. {js|&:nth-child(|js} ++ {js|evenofli, .item|js} ++ {js|)|js}, [||]),
      |])
    ],
  ),
  (
    [%expr [%cx "&:nth-last-child(-n+2) {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|&:nth-last-child(|js} ++ {js|-n + 2|js} ++ {js|)|js}, [||])|])
    ],
  ),
  /* BUG F||E */
  (
    [%expr [%cx "F || E {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|F||E|js}, [||])|])],
  ),
  (
    [%expr [%cx "& > *:not(:last-child) {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|& > *:not(|js} ++ {js|:last-child|js} ++ {js|)|js}, [||])|])
    ],
  ),
  (
    [%expr [%cx "* + * {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|* + *|js}, [||])|])
    ],
  ),
  (
    [%expr [%cx "*.warning {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|*.warning|js}, [||])|])
    ],
  ),
  /* BUG dl dt */
  (
    [%expr [%cx "dl dt:not(:last-child) {}"]],
    [%expr
      CssJs.style(. [|CssJs.selector(. {js|dldt:not(|js} ++ {js|:last-child|js} ++ {js|)|js}, [||])|])
    ],
  ),
  /* BUG `.foo:is` === `.foo :is` */
  (
    [%expr [%cx ".foo :is(.bar, #baz) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.selector(.
          {js|.foo:is(|js} ++ {js|.bar, #baz|js} ++ {js|)|js},
          [||],
        ),
      |])
    ],
  ),
];

describe(
  "Should bind to bs-css with selectors/pseudoselectors/pseudoclass",
  ({test, _}) => {
  selector_css_tests
  |> List.iteri((index, (result, expected)) =>
       test(
         string_of_int(index),
         compare(result, expected),
       )
     )
});
