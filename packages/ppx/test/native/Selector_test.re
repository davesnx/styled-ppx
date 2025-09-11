let loc = Ppxlib.Location.none;

let simple_tests = [
  (
    ":before { display: none; }",
    [%expr [%cx ":before { display: none; }"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|:before|js}|], [|CSS.display(`none)|]),
      |])
    ],
  ),
  (
    ".a",
    [%expr [%cx ".a {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|.a|js}|], [||])|])],
  ),
  (
    ".bar",
    [%expr [%cx ".bar {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|.bar|js}|], [||])|])],
  ),
  (
    "#bar",
    [%expr [%cx "#bar {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|#bar|js}|], [||])|])],
  ),
  (
    "div",
    [%expr [%cx "div {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|div|js}|], [||])|])],
  ),
  (
    "[id=baz]",
    [%expr [%cx {js|[id=baz] {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|[id=baz]|js}|], [||])|])],
  ),
  (
    "[id=\"baz\"]",
    [%expr [%cx {js|[id="baz"] {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|[id="baz"]|js}|], [||])|])],
  ),
  (
    "[title=baz]",
    [%expr [%cx {js|[title=baz] {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|[title=baz]|js}|], [||])|])],
  ),
  (
    "[title=\"baz\"]",
    [%expr [%cx {js|[title="baz"] {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|[title="baz"]|js}|], [||])|])
    ],
  ),
  (
    "nth-child(even)",
    [%expr [%cx "&:nth-child(even) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(even)|js}|], [||])|])
    ],
  ),
  (
    "nth-child(odd)",
    [%expr [%cx "&:nth-child(odd) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(odd)|js}|], [||])|])
    ],
  ),
  (
    "nth-child(3n+1)",
    [%expr [%cx "&:nth-child(3n+1) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(3n+1)|js}|], [||])|])
    ],
  ),
  (
    ":nth-child(2n)",
    [%expr [%cx "&:nth-child(2n) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(2n)|js}|], [||])|])
    ],
  ),
  (
    ":nth-child(n)",
    [%expr [%cx "&:nth-child(n) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(n)|js}|], [||])|])
    ],
  ),
  (
    ":nth-child(10n-1)",
    [%expr [%cx "&:nth-child(10n-1) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(10n-1)|js}|], [||])|])
    ],
  ),
  (
    ":nth-child(-n+3)",
    [%expr [%cx "&:nth-child(-n+3) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(-n+3)|js}|], [||])|])
    ],
  ),
  (
    ":nth-child( 10n -1 )",
    [%expr [%cx "&:nth-child(10n-1) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(10n-1)|js}|], [||])|])
    ],
  ),
  (
    ".a, .b {}",
    [%expr [%cx ".a, .b {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|.a|js}, {js|.b|js}|], [||])|])
    ],
  ),
  (
    ":nth-child(-n+2)",
    [%expr [%cx "&:nth-child(-n+2) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|&:nth-child(-n+2)|js}|], [||])|])
    ],
  ),
];

let compound_tests = [
  (
    "&.bar",
    [%expr [%cx {js|&.bar {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|&.bar|js}|], [||])|])],
  ),
  (
    "&.bar,&.foo",
    [%expr [%cx {js|&.bar,&.foo {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|&.bar|js}, {js|&.foo|js}|], [||]),
      |])
    ],
  ),
  (
    "&.bar , &.foo",
    [%expr [%cx {js|&.bar , &.foo {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|&.bar|js}, {js|&.foo|js}|], [||]),
      |])
    ],
  ),
  (
    "p:first-child",
    [%expr [%cx {js|p:first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|p:first-child|js}|], [||])|])
    ],
  ),
  (
    ".p.p.p.p {}",
    [%expr [%cx {js|&.p.p.p.p {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|&.p.p.p.p|js}|], [||])|])],
  ),
  (
    "&.$(canvasWithTwoColumns):first-child",
    [%expr [%cx {js|&.$(canvasWithTwoColumns):first-child {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|&.|js} ++ canvasWithTwoColumns ++ {js|:first-child|js}|],
          [||],
        ),
      |])
    ],
  ),
  (
    "p#first-child",
    [%expr [%cx {js|& p#first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& p#first-child|js}|], [||])|])
    ],
  ),
  (
    "#first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& #first-child|js}|], [||])|])
    ],
  ),
  (
    ":active",
    [%expr [%cx "&:active {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|&:active|js}|], [||])|])],
  ),
  (
    ":hover",
    [%expr [%cx "&:hover {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|&:hover|js}|], [||])|])],
  ),
  (
    "#first-child",
    [%expr [%cx {js|#first-child {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|#first-child|js}|], [||])|])],
  ),
  (
    "#first-child::before",
    [%expr [%cx {js|#first-child::before {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|#first-child::before|js}|], [||]),
      |])
    ],
  ),
  (
    "#first-child::before:hover",
    [%expr [%cx {js|#first-child::before:hover {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|#first-child::before:hover|js}|], [||]),
      |])
    ],
  ),
];

let complex_tests = [
  (
    "&>a",
    [%expr [%cx "&>a { }"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& > a|js}|], [||])|])],
  ),
  (
    "& > a",
    [%expr [%cx "& > a  {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& > a|js}|], [||])|])],
  ),
  (
    "& > a > b",
    [%expr [%cx "& > a > b {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& > a > b|js}|], [||])|])],
  ),
  (
    "& a b",
    [%expr [%cx "& a b {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& a b|js}|], [||])|])],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& #first-child|js}|], [||])|])
    ],
  ),
  (
    "& .bar",
    [%expr [%cx {js|& .bar {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& .bar|js}|], [||])|])],
  ),
  (
    "& div",
    [%expr [%cx {js|& div {}|js}]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& div|js}|], [||])|])],
  ),
  (
    "& :first-child",
    [%expr [%cx {js|& :first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& :first-child|js}|], [||])|])
    ],
  ),
  (
    "& > div > div > div > div",
    [%expr [%cx "& > div > div > div > div { }"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& > div > div > div > div|js}|], [||]),
      |])
    ],
  ),
  (
    "& div > .class",
    [%expr [%cx "& div > .class {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& div > .class|js}|], [||])|])
    ],
  ),
  /* #foo > .bar + div.k1.k2 [id='baz']:hello(2):not(:where(#yolo))::before */
  (
    "& + &",
    [%expr [%cx "& + & {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& + &|js}|], [||])|])],
  ),
  (
    "& span",
    [%expr [%cx "& span {}"]],
    [%expr CSS.style([|CSS.selectorMany([|{js|& span|js}|], [||])|])],
  ),
  (
    "& span, & + &",
    [%expr [%cx "& span, & + & {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& span|js}, {js|& + &|js}|], [||]),
      |])
    ],
  ),
  (
    "& p:not(.active)",
    [%expr [%cx "& p:not(.active) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& p:not(.active)|js}|], [||])|])
    ],
  ),
  (
    "& #first-child",
    [%expr [%cx {js|& #first-child {}|js}]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& #first-child|js}|], [||])|])
    ],
  ),
  (
    "& #first-child #second",
    [%expr [%cx {js|& #first-child #second {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& #first-child #second|js}|], [||]),
      |])
    ],
  ),
  (
    "& #first-child::before",
    [%expr [%cx {js|& #first-child::before {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& #first-child::before|js}|], [||]),
      |])
    ],
  ),
  (
    "& #first-child::before:hover",
    [%expr [%cx {js|& #first-child::before:hover {}|js}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& #first-child::before:hover|js}|], [||]),
      |])
    ],
  ),
  (
    ".foo:is(.bar, #baz)",
    [%expr [%cx ".foo:is(.bar, #baz) {}"]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|.foo:is(.bar, #baz)|js}|], [||])|])
    ],
  ),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"]{} "]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& input[type="password"]|js}|], [||]),
      |])
    ],
  ),
  (
    {|& div[id$="thumbnail"] { }|},
    [%expr [%cx {|& div[id$="thumbnail"] {}|}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& div[id$="thumbnail"]|js}|], [||]),
      |])
    ],
  ),
  (
    "& button:hover",
    [%expr [%cx "& button:hover{} "]],
    [%expr
      CSS.style([|CSS.selectorMany([|{js|& button:hover|js}|], [||])|])
    ],
  ),
  (
    "& $(Variables.selector_query)",
    [%expr [%cx "& $(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& |js} ++ Variables.selector_query|], [||]),
      |])
    ],
  ),
  (
    "& .$(Variables.selector_query)",
    [%expr [%cx "& .$(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& .|js} ++ Variables.selector_query|], [||]),
      |])
    ],
  ),
  (
    "&.$(Variables.selector_query)",
    [%expr [%cx "&.$(Variables.selector_query) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|&.|js} ++ Variables.selector_query|], [||]),
      |])
    ],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[target="_blank"] {}|}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& a[target="_blank"]|js}|], [||]),
      |])
    ],
  ),
  (
    "& a[target=\"_blank\"]",
    [%expr [%cx {|& a[ target = "_blank" ] {}|}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& a[target="_blank"]|js}|], [||]),
      |])
    ],
  ),
  (
    "$(pseudo)",
    [%expr [%cx "$(pseudo) {}"]],
    [%expr CSS.style([|CSS.selectorMany([|pseudo|], [||])|])],
  ),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& div > |js} ++ Variables.element|], [||]),
      |])
    ],
  ),
  (
    "*:not(:last-child)",
    [%expr [%cx "& > *:not(:last-child) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|& > *:not(:last-child)|js}|], [||]),
      |])
    ],
  ),
  (
    "&:has(.$(gap))",
    [%expr [%cx {| &:has(.$(gap)) {} |}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|&:has(.|js} ++ gap ++ {js|)|js}|], [||]),
      |])
    ],
  ),
  (
    "&:has(+ .$(gap))",
    [%expr [%cx {| &:has(+ .$(gap)) {} |}]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|&:has(+ .|js} ++ gap ++ {js|)|js}|], [||]),
      |])
    ],
  ),
  (
    ":is(h1, $(gap), h3):has(+ :is(h2, h3, h4))",
    [%expr [%cx {| :is(h1, $(gap), h3):has(+ :is(h2, h3, h4)) {} |}]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|:is(h1, |js} ++ gap ++ {js|, h3):has(+ :is(h2, h3, h4))|js}|],
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
    [%expr
      ignore(
        CSS.global([|
          CSS.selectorMany([|{js|html|js}, {js|body|js}|], [||]),
        |]),
      )
    ],
  ),
  (
    "html body",
    [%expr [%styled.global {js|html body {}|js}]],
    [%expr
      ignore(CSS.global([|CSS.selectorMany([|{js|html body|js}|], [||])|]))
    ],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {js|html, body, #root, .class {}|js}]],
    [%expr
      ignore(
        CSS.global([|
          CSS.selectorMany(
            [|{js|html|js}, {js|body|js}, {js|#root|js}, {js|.class|js}|],
            [||],
          ),
        |]),
      )
    ],
  ),
  (
    "div > span",
    [%expr [%styled.global {js|div > span {}|js}]],
    [%expr
      ignore(
        CSS.global([|CSS.selectorMany([|{js|div > span|js}|], [||])|]),
      )
    ],
  ),
  (
    "html div > span",
    [%expr [%styled.global {js|html div > span {}|js}]],
    [%expr
      ignore(
        CSS.global([|CSS.selectorMany([|{js|html div > span|js}|], [||])|]),
      )
    ],
  ),
  (
    "multiple rules",
    [%expr [%styled.global {js|html div > span {} html, body {}|js}]],
    [%expr
      ignore(
        CSS.global([|
          CSS.selectorMany([|{js|html div > span|js}|], [||]),
          CSS.selectorMany([|{js|html|js}, {js|body|js}|], [||]),
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
        CSS.selectorMany(
          [|{js|.a|js}|],
          [|CSS.selectorMany([|{js|.b|js}|], [||])|],
        ),
      |])
    ],
  ),
  (
    ".a .b",
    [%expr [%cx "display: block; .a .b {}"]],
    [%expr
      CSS.style([|
        CSS.display(`block),
        CSS.selectorMany([|{js|.a .b|js}|], [||]),
      |])
    ],
  ),
  (
    "& .a .b",
    [%expr [%cx "display: block; & .a .b {}"]],
    [%expr
      CSS.style([|
        CSS.display(`block),
        CSS.selectorMany([|{js|& .a .b|js}|], [||]),
      |])
    ],
  ),
  (
    ".$(aaa) { .$(bbb) { } }",
    [%expr [%cx ".$(aaa) { .$(bbb) {} }"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|.|js} ++ aaa|],
          [|CSS.selectorMany([|{js|.|js} ++ bbb|], [||])|],
        ),
      |])
    ],
  ),
  (
    "&.$(button_active):hover { top: 50px; }",
    [%expr [%cx "&.$(button_active):hover { top: 50px; }"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|&.|js} ++ button_active ++ {js|:hover|js}|],
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
        CSS.selectorMany(
          [|{js|&.|js} ++ button_active ++ {js|::before|js}|],
          [|CSS.top(`pxFloat(50.))|],
        ),
      |])
    ],
  ),
  (
    ".a .b { .a .b {} .a.b {} .a .b {} }",
    [%expr [%cx ".a .b { .a .b {} .a.b {} .a .b {} }"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|.a .b|js}|],
          [|
            CSS.selectorMany([|{js|.a .b|js}|], [||]),
            CSS.selectorMany([|{js|.a.b|js}|], [||]),
            CSS.selectorMany([|{js|.a .b|js}|], [||]),
          |],
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
        CSS.selectorMany(
          [|{js|.a|js}|],
          [|CSS.selectorMany([|{js|.b|js}|], [||])|],
        ),
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
      CSS.style([|
        CSS.display(`block),
        CSS.selectorMany([|{js|.a .b|js}|], [||]),
      |])
    ],
  ),
  (
    "& .a .b",
    [%expr [%cx "display: block; /*c*/& /*c*/.a /*c*//*c*/.b /*c*/{}"]],
    [%expr
      CSS.style([|
        CSS.display(`block),
        CSS.selectorMany([|{js|& .a .b|js}|], [||]),
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
        CSS.selectorMany(
          [|{js|.|js} ++ aaa|],
          [|CSS.selectorMany([|{js|.|js} ++ bbb|], [||])|],
        ),
      |])
    ],
  ),
];

let runner = tests =>
  List.map(
    item => {
      let (title, input, expected) = item;
      test(
        title,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_expression(x));
          let check_expr = Alcotest.testable(pp_expr, (==));
          check(~__POS__, check_expr, expected, input);
        },
      );
    },
    tests,
  );

let tests: tests =
  List.flatten([
    runner(simple_tests),
    runner(compound_tests),
    runner(complex_tests),
    runner(stylesheet_tests),
    runner(nested_tests),
    runner(comments_tests),
  ]);
