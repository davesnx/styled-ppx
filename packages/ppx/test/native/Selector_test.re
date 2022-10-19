open Setup;
open Ppxlib;

let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let simple_tests = [
  (
    ".a",
    [%expr [%cx ".a { }"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|.a|js}, [||])|])],
  ),
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
  (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(even)|js}, [||])|])],
  ),
  (
    "nth-child(odd)",
    [%expr [%cx "&:nth-child(odd) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(odd)|js}, [||])|])],
  ),
  (
    "nth-child(3n+1)",
    [%expr [%cx "&:nth-child(3n+1) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(3n+1)|js}, [||])|])],
  ),
  (
    ":nth-child(2n)",
    [%expr [%cx "&:nth-child(2n) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(2n)|js}, [||])|])],
  ),
  (
    ":nth-child(n)",
    [%expr [%cx "&:nth-child(n) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(n)|js}, [||])|])],
  ),
  (
    ":nth-child(10n-1)",
    [%expr [%cx "&:nth-child(10n-1) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(10n-1)|js}, [||])|])],
  ),
  (
    ":nth-child( 10n -1 )",
    [%expr [%cx "&:nth-child( 10n -1 ) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(10n-1)|js}, [||])|])],
  ),
  /* TODO: Support all cases */
  /* (
    ":nth-child( 10n - 1 )",
    [%expr [%cx "&:nth-child( 10n - 1 ) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(10n-1)|js}, [||])|])],
  ), */
  /* (
    ":nth-child(-n+2)",
    [%expr [%cx "&:nth-child(-n+2) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&:nth-child(-n+2)|js}, [||])|])],
  ), */
];

describe("Should transform simple selectors", ({ test, _ }) => {
  List.iteri((_index, (title, result, expected)) =>
    test(
      title,
      compare(result, expected),
    ),
    simple_tests
  );
});

let compound_test = [
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
];

describe("Should transform compound selectors", ({ test, _ }) => {
  List.iteri((_index, (title, result, expected)) =>
    test(
      title,
      compare(result, expected),
    ),
    compound_test
  );
});

let complex_tests = [
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
    "& .$(Variables.selector_query)",
    [%expr [%cx "& .$(Variables.selector_query) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& .|js} ++ Variables.selector_query, [||])|])],
  ),
  (
    "&.$(Variables.selector_query)",
    [%expr [%cx "&.$(Variables.selector_query) {}"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|&.|js} ++ Variables.selector_query, [||])|])],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr CssJs.style(. [| CssJs.selector(. {js|& a[target="_blank"]|js}, [||])|])],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[ target = "_blank" ] {}|}]],
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

describe("Should transform complex selectors", ({ test, _ }) => {
  List.iteri((_index, (title, result, expected)) =>
    test(
      title,
      compare(result, expected),
    ),
    complex_tests
  );
});

let stylesheet_tests = [
  (
    "html, body",
    [%expr [%styled.global {js|html, body {}|js}]],
    [%expr ignore(CssJs.global(. {js|html, body|js}, [||]))],
  ),
  (
    "html body",
    [%expr [%styled.global {js|html body {}|js}]],
    [%expr ignore(CssJs.global(. {js|html body|js}, [||]))],
  ),
  (
    "div > span",
    [%expr [%styled.global {js|div > span {}|js}]],
    [%expr ignore(CssJs.global(. {js|div > span|js}, [||]))],
  ),
  (
    "html div > span",
    [%expr [%styled.global {js|html div > span {}|js}]],
    [%expr ignore(CssJs.global(. {js|html div > span|js}, [||]))],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {js|html, body, #root, .class {}|js}]],
    [%expr ignore(CssJs.global(. {js|html, body, #root, .class|js}, [||]))],
  ),
];

describe("Should transform stylesheet selectors", ({ test, _ }) => {
  List.iteri((_index, (title, result, expected)) =>
    test(
      title,
      compare(result, expected),
    ),
    stylesheet_tests
  );
});

let nested_tests = [
  (
    ".a",
    [%expr [%cx ".a { .b {} }"]],
    [%expr CssJs.style(.
      [|
        CssJs.selector(. {js|.a|js}, [|
          CssJs.selector(. {js|.b|js}, [||])
        |])
      |])],
  ),
  (
    ".$(aaa) { .$(bbb) { } }",
    [%expr [%cx ".$(aaa) { .$(bbb) {} }"]],
    [%expr CssJs.style(.
      [|
        CssJs.selector(. {js|.|js} ++ aaa, [|
          CssJs.selector(. {js|.|js} ++ bbb, [||])
        |])
      |]
    )],
  ),
];

describe("Should nested selectors", ({ test, _ }) => {
  List.iteri((_index, (title, result, expected)) =>
    test(
      title,
      compare(result, expected),
    ),
    nested_tests
  );
});
