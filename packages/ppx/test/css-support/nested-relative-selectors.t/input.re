/* CSS Nesting's relative-selector shorthand: a nested rule's prelude may
   start with a combinator (`> .child`, `+ .sib`, `~ .sib`), meaning
   `& > .child` etc. Each pair below is the shorthand spelling followed by
   its explicit `&`-prefixed equivalent; both members of a pair must render
   and hash identically. */

[%css {| .parent { > .child { color: red; } } |}];
[%css {| .parent { & > .child { color: red; } } |}];

[%css {| .parent { + .sibling { color: red; } } |}];
[%css {| .parent { & + .sibling { color: red; } } |}];

[%css {| .parent { ~ .sibling { color: red; } } |}];
[%css {| .parent { & ~ .sibling { color: red; } } |}];

/* Compound selector after the combinator. */
[%css {| .parent { > .a.b:hover { color: red; } } |}];
[%css {| .parent { & > .a.b:hover { color: red; } } |}];

/* Selector list mixing two combinators. */
[%css {| .parent { > .a, + .b { color: red; } } |}];
[%css {| .parent { & > .a, & + .b { color: red; } } |}];

/* Nested inside an at-rule. */
[%css {| @media (min-width: 1px) { .parent { > .child { color: red; } } } |}];
[%css {| @media (min-width: 1px) { .parent { & > .child { color: red; } } } |}];
