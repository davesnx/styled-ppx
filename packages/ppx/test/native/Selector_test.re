open Ppxlib;

let loc = Location.none;

let simple_tests = [
  (":before { display: none; }", [%expr [%cx ":before { display: none; }"]]),
  (".a", [%expr [%cx ".a {}"]]),
  (".bar", [%expr [%cx ".bar {}"]]),
  ("#bar", [%expr [%cx "#bar {}"]]),
  ("div", [%expr [%cx "div {}"]]),
  ("[id=baz]", [%expr [%cx {js|[id=baz] {}|js}]]),
  ("[id=\"baz\"]", [%expr [%cx {js|[id="baz"] {}|js}]]),
  ("[title=baz]", [%expr [%cx {js|[title=baz] {}|js}]]),
  ("[title=\"baz\"]", [%expr [%cx {js|[title="baz"] {}|js}]]),
  ("nth-child(even)", [%expr [%cx "&:nth-child(even) {}"]]),
  ("nth-child(odd)", [%expr [%cx "&:nth-child(odd) {}"]]),
  ("nth-child(3n+1)", [%expr [%cx "&:nth-child(3n+1) {}"]]),
  (":nth-child(2n)", [%expr [%cx "&:nth-child(2n) {}"]]),
  (":nth-child(n)", [%expr [%cx "&:nth-child(n) {}"]]),
  (":nth-child(10n-1)", [%expr [%cx "&:nth-child(10n-1) {}"]]),
  (":nth-child(-n+3)", [%expr [%cx "&:nth-child(-n+3) {}"]]),
  (":nth-child( 10n -1 )", [%expr [%cx "&:nth-child(10n-1) {}"]]),
  (".a, .b {}", [%expr [%cx ".a, .b {}"]]),
  (":nth-child(-n+2)", [%expr [%cx "&:nth-child(-n+2) {}"]]),
];

let compound_tests = [
  ("&.bar", [%expr [%cx {js|&.bar {}|js}]]),
  ("&.bar,&.foo", [%expr [%cx {js|&.bar,&.foo {}|js}]]),
  ("&.bar , &.foo", [%expr [%cx {js|&.bar , &.foo {}|js}]]),
  ("& p:first-child", [%expr [%cx {js|& p:first-child {}|js}]]),
  (".p.p.p.p {}", [%expr [%cx {js|&.p.p.p.p {}|js}]]),
  (
    "&.$(canvasWithTwoColumns):first-child",
    [%expr [%cx {js|&.$(canvasWithTwoColumns):first-child {}|js}]],
  ),
  ("p#first-child", [%expr [%cx {js|& p#first-child {}|js}]]),
  ("#first-child", [%expr [%cx {js|& #first-child {}|js}]]),
  (":active", [%expr [%cx "&:active {}"]]),
  (":hover", [%expr [%cx "&:hover {}"]]),
  ("#first-child", [%expr [%cx {js|#first-child {}|js}]]),
  ("#first-child::before", [%expr [%cx {js|#first-child::before {}|js}]]),
  (
    "#first-child::before:hover",
    [%expr [%cx {js|#first-child::before:hover {}|js}]],
  ),
];

let complex_tests = [
  ("&>a", [%expr [%cx "&>a { }"]]),
  ("& > a", [%expr [%cx "& > a  {}"]]),
  ("& > a > b", [%expr [%cx "& > a > b {}"]]),
  ("& a b", [%expr [%cx "& a b {}"]]),
  ("& #first-child", [%expr [%cx {js|& #first-child {}|js}]]),
  ("& .bar", [%expr [%cx {js|& .bar {}|js}]]),
  ("& div", [%expr [%cx {js|& div {}|js}]]),
  ("& :first-child", [%expr [%cx {js|& :first-child {}|js}]]),
  (
    "& > div > div > div > div",
    [%expr [%cx "& > div > div > div > div { }"]],
  ),
  ("& div > .class", [%expr [%cx "& div > .class {}"]]),
  ("& + &", [%expr [%cx "& + & {}"]]),
  ("& span", [%expr [%cx "& span {}"]]),
  ("& span, & + &", [%expr [%cx "& span, & + & {}"]]),
  ("& p:not(.active)", [%expr [%cx "& p:not(.active) {}"]]),
  ("& #first-child", [%expr [%cx {js|& #first-child {}|js}]]),
  ("& #first-child #second", [%expr [%cx {js|& #first-child #second {}|js}]]),
  ("& #first-child::before", [%expr [%cx {js|& #first-child::before {}|js}]]),
  (
    "& #first-child::before:hover",
    [%expr [%cx {js|& #first-child::before:hover {}|js}]],
  ),
  (".foo:is(.bar, #baz)", [%expr [%cx ".foo:is(.bar, #baz) {}"]]),
  (
    "& input[type=\"password\"]",
    [%expr [%cx "& input[type=\"password\"]{} "]],
  ),
  (
    {|& div[id$="thumbnail"] { }|},
    [%expr [%cx {|& div[id$="thumbnail"] {}|}]],
  ),
  ("& button:hover", [%expr [%cx "& button:hover{} "]]),
  (
    "& $(Variables.selector_query)",
    [%expr [%cx "& $(Variables.selector_query) {}"]],
  ),
  (
    "& .$(Variables.selector_query)",
    [%expr [%cx "& .$(Variables.selector_query) {}"]],
  ),
  (
    "&.$(Variables.selector_query)",
    [%expr [%cx "&.$(Variables.selector_query) {}"]],
  ),
  ("& a[target=\"_blank\"]", [%expr [%cx {|& a[target="_blank"] {}|}]]),
  ("& a[target=\"_blank\"]", [%expr [%cx {|& a[ target = "_blank" ] {}|}]]),
  ("$(pseudo)", [%expr [%cx "$(pseudo) {}"]]),
  (
    "div > $(Variables.element)",
    [%expr [%cx "& div > $(Variables.element) {}"]],
  ),
  ("*:not(:last-child)", [%expr [%cx "& > *:not(:last-child) {}"]]),
  ("&:has(.$(gap))", [%expr [%cx {| &:has(.$(gap)) {} |}]]),
  ("&:has(+ .$(gap))", [%expr [%cx {| &:has(+ .$(gap)) {} |}]]),
  (
    ":is(h1, $(gap), h3):has(+ :is(h2, h3, h4))",
    [%expr [%cx {| :is(h1, $(gap), h3):has(+ :is(h2, h3, h4)) {} |}]],
  ),
];

let stylesheet_tests = [
  ("html, body", [%expr [%styled.global {js|html, body {}|js}]]),
  ("html body", [%expr [%styled.global {js|html body {}|js}]]),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {js|html, body, #root, .class {}|js}]],
  ),
  ("div > span", [%expr [%styled.global {js|div > span {}|js}]]),
  ("html div > span", [%expr [%styled.global {js|html div > span {}|js}]]),
  (
    "multiple rules",
    [%expr [%styled.global {js|html div > span {} html, body {}|js}]],
  ),
];

let nested_tests = [
  (".a", [%expr [%cx ".a { .b {} }"]]),
  (".a .b", [%expr [%cx "display: block; .a .b {}"]]),
  ("& .a .b", [%expr [%cx "display: block; & .a .b {}"]]),
  (".$(aaa) { .$(bbb) { } }", [%expr [%cx ".$(aaa) { .$(bbb) {} }"]]),
  (
    "&.$(button_active):hover { top: 50px; }",
    [%expr [%cx "&.$(button_active):hover { top: 50px; }"]],
  ),
  (
    "&.$(button_active)::before { top: 50px; }",
    [%expr [%cx "&.$(button_active)::before { top: 50px; }"]],
  ),
  (
    ".a .b { .a .b {} .a.b {} .a .b {} }",
    [%expr [%cx ".a .b { .a .b {} .a.b {} .a .b {} }"]],
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
  ),
  (
    "& .a .b",
    [%expr [%cx "display: block; /*c*/& /*c*/.a /*c*//*c*/.b /*c*/{}"]],
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
  ),
];
