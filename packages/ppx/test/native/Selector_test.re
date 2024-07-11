open Alcotest;
open Ppxlib;

let loc = Location.none;

let simple_tests = [
  (
    ":before { display: none; }",
    [%expr [%cx ":before { display: none; }"]],
    [%expr
      CSS.style([|CSS.selector({js|:before|js}, [|CSS.display(`none)|])|])
    ],
  ),
  (
    ".a",
    [%expr [%cx ".a {}"]],
    [%expr CSS.style([|CSS.selector({js|.a|js}, [||])|])],
  ),
  (
    ".bar",
    [%expr [%cx ".bar {}"]],
    [%expr CSS.style([|CSS.selector({js|.bar|js}, [||])|])],
  ),
  (
    "#bar",
    [%expr [%cx "#bar {}"]],
    [%expr CSS.style([|CSS.selector({js|#bar|js}, [||])|])],
  ),
  (
    "div",
    [%expr [%cx "div {}"]],
    [%expr CSS.style([|CSS.selector({js|div|js}, [||])|])],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id=baz] {}|js}]],
    [%expr CSS.style([|CSS.selector({js|[id=baz]|js}, [||])|])],
  ),
  (
    "[id=\"baz\"]",
    [%expr [%cx {js|[id="baz"] {}|js}]],
    [%expr CSS.style([|CSS.selector({js|[id="baz"]|js}, [||])|])],
  ),
  (
    "[title=baz]",
    [%expr [%cx {js|[title=baz] {}|js}]],
    [%expr CSS.style([|CSS.selector({js|[title=baz]|js}, [||])|])],
  ),
  (
    "[title=\"baz\"]",
    [%expr [%cx {js|[title="baz"] {}|js}]],
    [%expr CSS.style([|CSS.selector({js|[title="baz"]|js}, [||])|])],
  ),
  (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(even)|js}, [||])|])],
  ),
  (
    "nth-child(odd)",
    [%expr [%cx "&:nth-child(odd) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(odd)|js}, [||])|])],
  ),
  (
    "nth-child(3n+1)",
    [%expr [%cx "&:nth-child(3n+1) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(3n+1)|js}, [||])|])],
  ),
  (
    ":nth-child(2n)",
    [%expr [%cx "&:nth-child(2n) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(2n)|js}, [||])|])],
  ),
  (
    ":nth-child(n)",
    [%expr [%cx "&:nth-child(n) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(n)|js}, [||])|])],
  ),
  (
    ":nth-child(10n-1)",
    [%expr [%cx "&:nth-child(10n-1) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(10n-1)|js}, [||])|])],
  ),
  (
    ":nth-child(-n+3)",
    [%expr [%cx "&:nth-child(-n+3) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(-n+3)|js}, [||])|])],
  ),
  (
    ":nth-child( 10n -1 )",
    [%expr [%cx "&:nth-child(10n-1) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(10n-1)|js}, [||])|])],
  ),
  (
    ".a, .b {}",
    [%expr [%cx ".a, .b {}"]],
    [%expr CSS.style([|CSS.selector({js|.a, .b|js}, [||])|])],
  ),
  (
    ":nth-child(-n+2)",
    [%expr [%cx "&:nth-child(-n+2) {}"]],
    [%expr CSS.style([|CSS.selector({js|&:nth-child(-n+2)|js}, [||])|])],
  ),
];

let compound_tests = [
  (
    "&.bar",
    [%expr [%cx {js|&.bar {}|js}]],
    [%expr CSS.style([|CSS.selector({js|&.bar|js}, [||])|])],
  ),
  (
    "&.bar,&.foo",
    [%expr [%cx {js|&.bar,&.foo {}|js}]],
    [%expr CSS.style([|CSS.selector({js|&.bar, &.foo|js}, [||])|])],
  ),
  (
    "&.bar , &.foo",
    [%expr [%cx {js|&.bar , &.foo {}|js}]],
    [%expr CSS.style([|CSS.selector({js|&.bar, &.foo|js}, [||])|])],
  ),
  (
    "p:first-child",
    [%expr [%cx {js|p:first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|p:first-child|js}, [||])|])],
  ),
  (
    ".p.p.p.p {}",
    [%expr [%cx {js|&.p.p.p.p {}|js}]],
    [%expr CSS.style([|CSS.selector({js|&.p.p.p.p|js}, [||])|])],
  ),
  (
    "&.$(canvasWithTwoColumns):first-child",
    [%expr [%cx {js|&.$(canvasWithTwoColumns):first-child {}|js}]],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|&.|js} ++ canvasWithTwoColumns ++ {js|:first-child|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "p#first-child",
    [%expr [%cx {js|& p#first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& p#first-child|js}, [||])|])],
  ),
  (
    "#first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& #first-child|js}, [||])|])],
  ),
  (
    ":active",
    [%expr [%cx "&:active {}"]],
    [%expr CSS.style([|CSS.selector({js|&:active|js}, [||])|])],
  ),
  (
    ":hover",
    [%expr [%cx "&:hover {}"]],
    [%expr CSS.style([|CSS.selector({js|&:hover|js}, [||])|])],
  ),
  (
    "#first-child",
    [%expr [%cx {js|#first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|#first-child|js}, [||])|])],
  ),
  (
    "#first-child::before",
    [%expr [%cx {js|#first-child::before {}|js}]],
    [%expr CSS.style([|CSS.selector({js|#first-child::before|js}, [||])|])],
  ),
  (
    "#first-child::before:hover",
    [%expr [%cx {js|#first-child::before:hover {}|js}]],
    [%expr
      CSS.style([|CSS.selector({js|#first-child::before:hover|js}, [||])|])
    ],
  ),
];

let complex_tests = [
  (
    "&>a",
    [%expr [%cx "&>a { }"]],
    [%expr CSS.style([|CSS.selector({js|& > a|js}, [||])|])],
  ),
  (
    "& > a",
    [%expr [%cx "& > a  {}"]],
    [%expr CSS.style([|CSS.selector({js|& > a|js}, [||])|])],
  ),
  (
    "& > a > b",
    [%expr [%cx "& > a > b {}"]],
    [%expr CSS.style([|CSS.selector({js|& > a > b|js}, [||])|])],
  ),
  (
    "& a b",
    [%expr [%cx "& a b {}"]],
    [%expr CSS.style([|CSS.selector({js|& a b|js}, [||])|])],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& #first-child|js}, [||])|])],
  ),
  (
    "& .bar",
    [%expr [%cx {js|& .bar {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& .bar|js}, [||])|])],
  ),
  (
    "& div",
    [%expr [%cx {js|& div {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& div|js}, [||])|])],
  ),
  (
    "& :first-child",
    [%expr [%cx {js|& :first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& :first-child|js}, [||])|])],
  ),
  (
    "& > div > div > div > div",
    [%expr [%cx "& > div > div > div > div { }"]],
    [%expr
      CSS.style([|CSS.selector({js|& > div > div > div > div|js}, [||])|])
    ],
  ),
  (
    "& div > .class",
    [%expr [%cx "& div > .class {}"]],
    [%expr CSS.style([|CSS.selector({js|& div > .class|js}, [||])|])],
  ),
  /* #foo > .bar + div.k1.k2 [id='baz']:hello(2):not(:where(#yolo))::before */
  (
    "& + &",
    [%expr [%cx "& + & {}"]],
    [%expr CSS.style([|CSS.selector({js|& + &|js}, [||])|])],
  ),
  (
    "& span",
    [%expr [%cx "& span {}"]],
    [%expr CSS.style([|CSS.selector({js|& span|js}, [||])|])],
  ),
  (
    "& span, & + &",
    [%expr [%cx "& span, & + & {}"]],
    [%expr CSS.style([|CSS.selector({js|& span, & + &|js}, [||])|])],
  ),
  (
    "& p:not(.active)",
    [%expr [%cx "& p:not(.active) {}"]],
    [%expr CSS.style([|CSS.selector({js|& p:not(.active)|js}, [||])|])],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr CSS.style([|CSS.selector({js|& #first-child|js}, [||])|])],
  ),
  (
    "& #first-child #second",
    [%expr [%cx {js|& #first-child #second {}|js}]],
    [%expr
      CSS.style([|CSS.selector({js|& #first-child #second|js}, [||])|])
    ],
  ),
  (
    "& #first-child::before",
    [%expr [%cx {js|& #first-child::before {}|js}]],
    [%expr
      CSS.style([|CSS.selector({js|& #first-child::before|js}, [||])|])
    ],
  ),
  (
    "& #first-child::before:hover",
    [%expr [%cx {js|& #first-child::before:hover {}|js}]],
    [%expr
      CSS.style([|CSS.selector({js|& #first-child::before:hover|js}, [||])|])
    ],
  ),
  (
    ".foo:is(.bar, #baz)",
    [%expr [%cx ".foo:is(.bar, #baz) {}"]],
    [%expr CSS.style([|CSS.selector({js|.foo:is(.bar, #baz)|js}, [||])|])],
  ),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"]{} "]],
    [%expr
      CSS.style([|CSS.selector({js|& input[type="password"]|js}, [||])|])
    ],
  ),
  (
    {|& div[id$="thumbnail"] { }|},
    [%expr [%cx {|& div[id$="thumbnail"] {}|}]],
    [%expr
      CSS.style([|CSS.selector({js|& div[id$="thumbnail"]|js}, [||])|])
    ],
  ),
  (
    "& button:hover",
    [%expr [%cx "& button:hover{} "]],
    [%expr CSS.style([|CSS.selector({js|& button:hover|js}, [||])|])],
  ),
  (
    "& $(Variables.selector_query)",
    [%expr [%cx "& $(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selector({js|& |js} ++ Variables.selector_query, [||]),
      |])
    ],
  ),
  (
    "& .$(Variables.selector_query)",
    [%expr [%cx "& .$(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selector({js|& .|js} ++ Variables.selector_query, [||]),
      |])
    ],
  ),
  (
    "&.$(Variables.selector_query)",
    [%expr [%cx "&.$(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selector({js|&.|js} ++ Variables.selector_query, [||]),
      |])
    ],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr CSS.style([|CSS.selector({js|& a[target="_blank"]|js}, [||])|])],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[ target = "_blank" ] {}|}]],
    [%expr CSS.style([|CSS.selector({js|& a[target="_blank"]|js}, [||])|])],
  ),
  (
    "$(pseudo)",
    [%expr [%cx "$(pseudo) {}"]],
    [%expr CSS.style([|CSS.selector(pseudo, [||])|])],
  ),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
    [%expr
      CSS.style([|
        CSS.selector({js|& div > |js} ++ Variables.element, [||]),
      |])
    ],
  ),
  (
    "*:not(:last-child)",
    [%expr [%cx "& > *:not(:last-child) {}"]],
    [%expr
      CSS.style([|CSS.selector({js|& > *:not(:last-child)|js}, [||])|])
    ],
  ),
  (
    "&:has(.$(gap))",
    [%expr [%cx {| &:has(.$(gap)) {} |}]],
    [%expr
      CSS.style([|CSS.selector({js|&:has(.|js} ++ gap ++ {js|)|js}, [||])|])
    ],
  ),
  (
    "&:has(+ .$(gap))",
    [%expr [%cx {| &:has(+ .$(gap)) {} |}]],
    [%expr
      CSS.style([|
        CSS.selector({js|&:has(+ .|js} ++ gap ++ {js|)|js}, [||]),
      |])
    ],
  ),
  (
    ":is(h1, $(gap), h3):has(+ :is(h2, h3, h4))",
    [%expr [%cx {| :is(h1, $(gap), h3):has(+ :is(h2, h3, h4)) {} |}]],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|:is(h1, |js} ++ gap ++ {js|, h3):has(+ :is(h2, h3, h4))|js},
          [||],
        ),
      |])
    ],
  ),
];

let stylesheet_tests = [
  (
    "html, body",
    [%expr [%styled.global {js|html, body {}|js}]],
    [%expr ignore(CSS.global([|CSS.selector({js|html, body|js}, [||])|]))],
  ),
  (
    "html body",
    [%expr [%styled.global {js|html body {}|js}]],
    [%expr ignore(CSS.global([|CSS.selector({js|html body|js}, [||])|]))],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {js|html, body, #root, .class {}|js}]],
    [%expr
      ignore(
        CSS.global([|
          CSS.selector({js|html, body, #root, .class|js}, [||]),
        |]),
      )
    ],
  ),
  (
    "div > span",
    [%expr [%styled.global {js|div > span {}|js}]],
    [%expr ignore(CSS.global([|CSS.selector({js|div > span|js}, [||])|]))],
  ),
  (
    "html div > span",
    [%expr [%styled.global {js|html div > span {}|js}]],
    [%expr
      ignore(CSS.global([|CSS.selector({js|html div > span|js}, [||])|]))
    ],
  ),
  (
    "multiple rules",
    [%expr [%styled.global {js|html div > span {} html, body {}|js}]],
    [%expr
      ignore(
        CSS.global([|
          CSS.selector({js|html div > span|js}, [||]),
          CSS.selector({js|html, body|js}, [||]),
        |]),
      )
    ],
  ),
];

let nested_tests = [
  (
    ".a",
    [%expr [%cx ".a { .b {} }"]],
    [%expr
      CSS.style([|
        CSS.selector({js|.a|js}, [|CSS.selector({js|.b|js}, [||])|]),
      |])
    ],
  ),
  (
    ".a .b",
    [%expr [%cx "display: block; .a .b {}"]],
    [%expr
      CSS.style([|CSS.display(`block), CSS.selector({js|.a .b|js}, [||])|])
    ],
  ),
  (
    "& .a .b",
    [%expr [%cx "display: block; & .a .b {}"]],
    [%expr
      CSS.style([|
        CSS.display(`block),
        CSS.selector({js|& .a .b|js}, [||]),
      |])
    ],
  ),
  (
    ".$(aaa) { .$(bbb) { } }",
    [%expr [%cx ".$(aaa) { .$(bbb) {} }"]],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|.|js} ++ aaa,
          [|CSS.selector({js|.|js} ++ bbb, [||])|],
        ),
      |])
    ],
  ),
  (
    "&.$(button_active):hover { top: 50px; }",
    [%expr [%cx "&.$(button_active):hover { top: 50px; }"]],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|&.|js} ++ button_active ++ {js|:hover|js},
          [|CSS.top(`pxFloat(50.))|],
        ),
      |])
    ],
  ),
  (
    "&.$(button_active)::before { top: 50px; }",
    [%expr [%cx "&.$(button_active)::before { top: 50px; }"]],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|&.|js} ++ button_active ++ {js|::before|js},
          [|CSS.top(`pxFloat(50.))|],
        ),
      |])
    ],
  ),
];

let comments_tests = [
  (
    ".a",
    [%expr
      [%cx
        {|/*c*/
    /*c*/

    .a { /* c*/
    /*c*/
    /*c*/
    /*c*/
    .b {} }

    |}
      ]
    ],
    [%expr
      CSS.style([|
        CSS.selector({js|.a|js}, [|CSS.selector({js|.b|js}, [||])|]),
      |])
    ],
  ),
  (
    ".a .b",
    [%expr
      [%cx
        {|
    /*c*/
    /*c*/
    display: block; .a/*c*/ /*c*//*c*/.b {}|}
      ]
    ],
    [%expr
      CSS.style([|CSS.display(`block), CSS.selector({js|.a .b|js}, [||])|])
    ],
  ),
  (
    "& .a .b",
    [%expr [%cx "display: block; /*c*/& /*c*/.a /*c*//*c*/.b /*c*/{}"]],
    [%expr
      CSS.style([|
        CSS.display(`block),
        CSS.selector({js|& .a .b|js}, [||]),
      |])
    ],
  ),
  (
    ".$(aaa) { .$(bbb) { } }",
    [%expr
      [%cx
        {|/*c*/
    /*c*/
    /*c*/
    /*c*/
    /*c*/.$(aaa) { /*c*/.$(bbb) {} }|}
      ]
    ],
    [%expr
      CSS.style([|
        CSS.selector(
          {js|.|js} ++ aaa,
          [|CSS.selector({js|.|js} ++ bbb, [||])|],
        ),
      |])
    ],
  ),
];

let runner = tests =>
  List.map(
    item => {
      let (title, input, expected) = item;
      test_case(
        title,
        `Quick,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Pprintast.string_of_expression(x));
          let check_expr = testable(pp_expr, (==));
          check(check_expr, "", expected, input);
        },
      );
    },
    tests,
  );

let tests =
  List.flatten([
    runner(simple_tests),
    runner(compound_tests),
    runner(complex_tests),
    runner(stylesheet_tests),
    runner(nested_tests),
    runner(comments_tests),
  ]);
