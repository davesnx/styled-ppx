Selector native PPX transformations are checked as a cram snapshot.

  $ ../Runner.exe selector
  ## Selector/simple
  - :before { display: none; }
    "[%cx \":before { display: none; }\"]"
  - .a
    "[%cx \".a {}\"]"
  - .bar
    "[%cx \".bar {}\"]"
  - #bar
    "[%cx \"#bar {}\"]"
  - div
    "[%cx \"div {}\"]"
  - [id=baz]
    "[%cx {js|[id=baz] {}|js}]"
  - [id="baz"]
    "[%cx {js|[id=\"baz\"] {}|js}]"
  - [title=baz]
    "[%cx {js|[title=baz] {}|js}]"
  - [title="baz"]
    "[%cx {js|[title=\"baz\"] {}|js}]"
  - nth-child(even)
    "[%cx \"&:nth-child(even) {}\"]"
  - nth-child(odd)
    "[%cx \"&:nth-child(odd) {}\"]"
  - nth-child(3n+1)
    "[%cx \"&:nth-child(3n+1) {}\"]"
  - :nth-child(2n)
    "[%cx \"&:nth-child(2n) {}\"]"
  - :nth-child(n)
    "[%cx \"&:nth-child(n) {}\"]"
  - :nth-child(10n-1)
    "[%cx \"&:nth-child(10n-1) {}\"]"
  - :nth-child(-n+3)
    "[%cx \"&:nth-child(-n+3) {}\"]"
  - :nth-child( 10n -1 )
    "[%cx \"&:nth-child(10n-1) {}\"]"
  - .a, .b {}
    "[%cx \".a, .b {}\"]"
  - :nth-child(-n+2)
    "[%cx \"&:nth-child(-n+2) {}\"]"
  ## Selector/compound
  - &.bar
    "[%cx {js|&.bar {}|js}]"
  - &.bar,&.foo
    "[%cx {js|&.bar,&.foo {}|js}]"
  - &.bar , &.foo
    "[%cx {js|&.bar , &.foo {}|js}]"
  - & p:first-child
    "[%cx {js|& p:first-child {}|js}]"
  - .p.p.p.p {}
    "[%cx {js|&.p.p.p.p {}|js}]"
  - &.$(canvasWithTwoColumns):first-child
    "[%cx {js|&.$(canvasWithTwoColumns):first-child {}|js}]"
  - p#first-child
    "[%cx {js|& p#first-child {}|js}]"
  - #first-child
    "[%cx {js|& #first-child {}|js}]"
  - :active
    "[%cx \"&:active {}\"]"
  - :hover
    "[%cx \"&:hover {}\"]"
  - #first-child
    "[%cx {js|#first-child {}|js}]"
  - #first-child::before
    "[%cx {js|#first-child::before {}|js}]"
  - #first-child::before:hover
    "[%cx {js|#first-child::before:hover {}|js}]"
  ## Selector/complex
  - &>a
    "[%cx \"&>a { }\"]"
  - & > a
    "[%cx \"& > a  {}\"]"
  - & > a > b
    "[%cx \"& > a > b {}\"]"
  - & a b
    "[%cx \"& a b {}\"]"
  - & #first-child
    "[%cx {js|& #first-child {}|js}]"
  - & .bar
    "[%cx {js|& .bar {}|js}]"
  - & div
    "[%cx {js|& div {}|js}]"
  - & :first-child
    "[%cx {js|& :first-child {}|js}]"
  - & > div > div > div > div
    "[%cx \"& > div > div > div > div { }\"]"
  - & div > .class
    "[%cx \"& div > .class {}\"]"
  - & + &
    "[%cx \"& + & {}\"]"
  - & span
    "[%cx \"& span {}\"]"
  - & span, & + &
    "[%cx \"& span, & + & {}\"]"
  - & p:not(.active)
    "[%cx \"& p:not(.active) {}\"]"
  - & #first-child
    "[%cx {js|& #first-child {}|js}]"
  - & #first-child #second
    "[%cx {js|& #first-child #second {}|js}]"
  - & #first-child::before
    "[%cx {js|& #first-child::before {}|js}]"
  - & #first-child::before:hover
    "[%cx {js|& #first-child::before:hover {}|js}]"
  - .foo:is(.bar, #baz)
    "[%cx \".foo:is(.bar, #baz) {}\"]"
  - & input[type="password"]
    "[%cx \"& input[type=\\\"password\\\"]{} \"]"
  - & div[id$="thumbnail"] { }
    "[%cx {|& div[id$=\"thumbnail\"] {}|}]"
  - & button:hover
    "[%cx \"& button:hover{} \"]"
  - & $(Variables.selector_query)
    "[%cx \"& $(Variables.selector_query) {}\"]"
  - & .$(Variables.selector_query)
    "[%cx \"& .$(Variables.selector_query) {}\"]"
  - &.$(Variables.selector_query)
    "[%cx \"&.$(Variables.selector_query) {}\"]"
  - & a[target="_blank"]
    "[%cx {|& a[target=\"_blank\"] {}|}]"
  - & a[target="_blank"]
    "[%cx {|& a[ target = \"_blank\" ] {}|}]"
  - $(pseudo)
    "[%cx \"$(pseudo) {}\"]"
  - div > $(Variables.element)
    "[%cx \"& div > $(Variables.element) {}\"]"
  - *:not(:last-child)
    "[%cx \"& > *:not(:last-child) {}\"]"
  - &:has(.$(gap))
    "[%cx {| &:has(.$(gap)) {} |}]"
  - &:has(+ .$(gap))
    "[%cx {| &:has(+ .$(gap)) {} |}]"
  - :is(h1, $(gap), h3):has(+ :is(h2, h3, h4))
    "[%cx {| :is(h1, $(gap), h3):has(+ :is(h2, h3, h4)) {} |}]"
  ## Selector/stylesheet
  - html, body
    "[%styled.global {js|html, body {}|js}]"
  - html body
    "[%styled.global {js|html body {}|js}]"
  - html, body, #root, .class
    "[%styled.global {js|html, body, #root, .class {}|js}]"
  - div > span
    "[%styled.global {js|div > span {}|js}]"
  - html div > span
    "[%styled.global {js|html div > span {}|js}]"
  - multiple rules
    "[%styled.global {js|html div > span {} html, body {}|js}]"
  ## Selector/nested
  - .a
    "[%cx \".a { .b {} }\"]"
  - .a .b
    "[%cx \"display: block; .a .b {}\"]"
  - & .a .b
    "[%cx \"display: block; & .a .b {}\"]"
  - .$(aaa) { .$(bbb) { } }
    "[%cx \".$(aaa) { .$(bbb) {} }\"]"
  - &.$(button_active):hover { top: 50px; }
    "[%cx \"&.$(button_active):hover { top: 50px; }\"]"
  - &.$(button_active)::before { top: 50px; }
    "[%cx \"&.$(button_active)::before { top: 50px; }\"]"
  - .a .b { .a .b {} .a.b {} .a .b {} }
    "[%cx \".a .b { .a .b {} .a.b {} .a .b {} }\"]"
  ## Selector/comments
  - .a
    "[%cx\n  {|/*c*/\n    /*c*/\n\n    .a { /* c*/\n    /*c*/\n    /*c*/\n    /*c*/\n    .b {} }\n\n    |}]"
  - .a .b
    "[%cx {|\n    /*c*/\n    /*c*/\n    display: block; .a/*c*/ /*c*//*c*/.b {}|}]"
  - & .a .b
    "[%cx \"display: block; /*c*/& /*c*/.a /*c*//*c*/.b /*c*/{}\"]"
  - .$(aaa) { .$(bbb) { } }
    "[%cx\n  {|/*c*/\n    /*c*/\n    /*c*/\n    /*c*/\n    /*c*/.$(aaa) { /*c*/.$(bbb) {} }|}]"
