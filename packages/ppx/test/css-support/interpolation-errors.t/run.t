Selector references and interpolation positions that blocks reject or
treat specially.

A function binding (here with two blocks, one per branch arm) cannot be
named in a selector: it is not a class name. A value with two blocks is
covered in `selector-ref-function.t`.

  $ refmt --parse re --print ml local.re > local.ml
  $ ../../standalone.exe --impl local.ml -o local.ml
  File "local.ml", line 3, characters 23-27:
  3 | let user = [%css "& .$(pick) { color: red; }"]
                             ^^^^
  Error: Selector interpolation `$(pick)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let pick = [%css "..."]`) or a string, and reference that.
  [1]

The same through a cross-module reference: the compiler rejects the typed
use `let _: CSS.styles = A.pick` (see `selector-ref-function.t`), and
`generate` rejects it too, since a function is exported with an empty class
string.

  $ refmt --parse re --print ml a.re > a.ml
  $ ../../standalone.exe --impl a.ml -o a.ml
  $ refmt --parse re --print ml b.re > b.ml
  $ ../../standalone.exe --impl b.ml -o b.ml
  $ refmt --parse ml --print re a.ml
  [@css ".css-2wfilcg{width:1px;}"];
  [@css ".css-2wfi17o{width:2px;}"];
  [@css.classes
    [
      ("css-2wfilcg", 0, "A.pick", "a.ml", 2, 34, 2, 44),
      ("css-2wfi17o", 1, "A.pick", "a.ml", 2, 65, 2, 75),
    ]
  ];
  [@css.bindings [("A.pick", "")]];
  let pick = big =>
    big ? CSS.make("css-2wfilcg", []) : CSS.make("css-2wfi17o", []);
  $ styled-ppx.generate a.ml b.ml
  styled-ppx: File "b.ml", line 1, characters 23-29:
  Error: Selector interpolation `$(A.pick)` refers to a function or to a binding with several [%css] blocks, so it has no single class. Bind the block you mean to its own name and reference that.
  [1]

The reference in `b.re` yields two rules (`&:hover` is nested), and the error
is reported once.

A value binding with two blocks (a conditional) in another module: the ppx
cannot see `Value.pick`, so it accepts the reference, and `generate` rejects
it at the reference (in one module the ppx rejects it, see
`selector-ref-function.t`, case c).

  $ refmt --parse re --print ml value.re > value.ml
  $ ../../standalone.exe --impl value.ml -o value.ml
  $ refmt --parse ml --print re value.ml
  [@css ".css-q9gxj30{width:1px;}"];
  [@css ".css-q9gxxqn{width:2px;}"];
  [@css.classes
    [
      ("css-q9gxj30", 0, "Value.pick", "value.ml", 4, 19, 4, 29),
      ("css-q9gxxqn", 1, "Value.pick", "value.ml", 5, 20, 5, 30),
    ]
  ];
  [@css.bindings [("Value.pick", "")]];
  let wide = true;
  let pick = wide ? CSS.make("css-q9gxj30", []) : CSS.make("css-q9gxxqn", []);
  $ refmt --parse re --print ml user.re > user.ml
  $ ../../standalone.exe --impl user.ml -o user.ml
  $ refmt --parse ml --print re user.ml
  [@css ".css-3h6qw2s .\000Value.pick\000{color:red;}"];
  [@css.classes [("css-3h6qw2s", 0, "User.user", "user.ml", 1, 18, 1, 50)]];
  [@css.bindings [("User.user", "css-3h6qw2s")]];
  [@css.refs [("Value.pick", "user.ml", 1, 23, 33)]];
  let _: CSS.styles = Value.pick;
  let user = CSS.make("css-3h6qw2s", []);
  $ styled-ppx.generate value.ml user.ml
  styled-ppx: File "user.ml", line 1, characters 23-33:
  Error: Selector interpolation `$(Value.pick)` refers to a function or to a binding with several [%css] blocks, so it has no single class. Bind the block you mean to its own name and reference that.
  [1]

A value binding whose one block interpolates is referenced by its one class. A
string binding in a selector is used as a class name, never as a type
selector.

  $ refmt --parse re --print ml refs.re > refs.ml
  $ ../../standalone.exe --impl refs.ml -o refs.ml
  $ refmt --parse ml --print re refs.ml
  [@css "@property --38x8r6w{syntax:\"*\";inherits:false;}"];
  [@css ".css-38x8kp9{color:var(--38x8r6w);}"];
  [@css ".css-38x86mh.css-38x8kp9{padding:1px;}"];
  [@css ".css-38x83ey .span{color:red;}"];
  [@css.classes
    [
      ("css-38x8kp9", 1, "Refs.tone", "refs.ml", 2, 18, 2, 32),
      ("css-38x86mh", 2, "Refs.host", "refs.ml", 3, 18, 3, 45),
      ("css-38x83ey", 3, "Refs.tagged", "refs.ml", 5, 20, 5, 44),
    ]
  ];
  [@css.bindings
    [
      ("Refs.tone", "css-38x8kp9"),
      ("Refs.host", "css-38x86mh"),
      ("Refs.tagged", "css-38x83ey"),
    ]
  ];
  let blue = CSS.blue;
  let tone =
    CSS.make("css-38x8kp9", [("--38x8r6w", CSS.Types.Color.toString(blue))]);
  let host = CSS.make("css-38x86mh", []);
  let tag = "span";
  let tagged = CSS.make("css-38x83ey", []);

Interpolation in an at-rule prelude and in a pseudo-class argument:

  $ refmt --parse re --print ml media.re > media.ml
  $ ../../standalone.exe --impl media.ml -o media.ml
  File "media.ml", line 2, characters 21-41:
  2 | let a = [%css "@media (min-width: $(bp)) { color: red; }"]
                           ^^^^^^^^^^^^^^^^^^^^
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]

  $ refmt --parse re --print ml nth.re > nth.ml
  $ ../../standalone.exe --impl nth.ml -o nth.ml
  $ refmt --parse ml --print re nth.ml
  let n = 2;
  let a = [%ocaml.error "Parse error while reading token '$(n)'"];

A styled component cannot choose between declaration sets; only values
come from props.

  $ refmt --parse re --print ml styled.re > styled.ml
  $ ../../standalone.exe --impl styled.ml -o styled.ml
  File "styled.ml", line 4, characters 6-70:
  4 |       match big with | true -> "width: 500px" | false -> "width: 100%"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/styled-components#derive-styles-from-props
  [1]
