open Alcotest;
open Ppxlib;

let loc = Location.none;

let tests =
  [
    ("ignore in empty", [%expr [%cx " "]], [%expr [%cx ""]]),
    ("ignore in style_rule", [%expr [%cx ".bar{}"]], [%expr [%cx ".bar {}"]]),
    (
      "ignore in style_rule",
      [%expr [%cx ".bar { } "]],
      [%expr [%cx ".bar {}"]],
    ),
    (
      "ignore in declaration list",
      [%expr [%cx "display: block; box-sizing: border-box          ; "]],
      [%expr [%cx "display: block; box-sizing: border-box;"]],
    ),
    (
      "ignore in declaration",
      [%expr [%cx " display : block; "]],
      [%expr [%cx "display: block;"]],
    ),
    (
      "ignore in declaration",
      [%expr [%cx " display : block ; "]],
      [%expr [%cx "display: block;"]],
    ),
    (
      "ignore in declaration",
      [%expr [%cx "display:block;"]],
      [%expr [%cx "display: block;"]],
    ),
    (
      "ignore in at_rule inside declarations",
      [%expr [%cx "@media all {  }"]],
      [%expr [%cx "@media all {}"]],
    ),
    (
      "ignore in at_rule inside declarations",
      [%expr [%cx "@media all  {  } "]],
      [%expr [%cx "@media all {}"]],
    ),
    (
      "ignore in at_rule inside declarations",
      [%expr [%cx "@media(min-width: 30px) {}"]],
      [%expr [%cx "@media     (min-width: 30px) {}"]],
    ),
    (
      "ignore in at_rule inside declarations",
      [%expr [%cx "@media screen    and    (min-width: 30px) {}"]],
      [%expr [%cx "@media screen and (min-width: 30px) {}"]],
    ),
    (
      "media with declarations",
      [%expr [%cx "@media    screen and (min-width: 30px  ) { color: red; }"]],
      [%expr [%cx "@media screen and (min-width: 30px  ) { color: red; } "]],
    ),
    (
      "media with multiple preludes",
      [%expr
        [%cx
          "@media screen and (min-width: 30px) and (max-height: 16rem) { color: red; }"
        ]
      ],
      [%expr
        [%cx
          "@media screen and (min-width: 30px) and (max-height: 16rem) { color: red; } "
        ]
      ],
    ),
    (
      "media with declarations",
      [%expr [%cx ".clar {  background-image : url( 'img_tree.gif') ; }"]],
      [%expr [%cx ".clar { background-image: url( 'img_tree.gif') }"]],
    ),
    (
      "ignore space on declaration url",
      [%expr [%css " background-image: url('img_tree.gif' )"]],
      [%expr [%css "background-image: url('img_tree.gif' )"]],
    ),
    (
      "ignore space on values, such as box-shadow",
      [%expr [%cx "box-shadow:    12px 12px 2px 1px rgba(0, 0, 255, 0.2)"]],
      [%expr [%cx "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"]],
    ),
    (
      "ignore space on values, such as box-shadow",
      [%expr
        [%cx
          {|
  /* standard width 240px - standard padding 8px * 2 */
  width: 214px;
|}
        ]
      ],
      [%expr [%cx {| width: 214px;|}]],
    ),
    (
      "html, body, #root, .class",
      [%expr
        [%styled.global
          {|
    html, body, #root, .class {
      margin: 0;
    } |}
        ]
      ],
      [%expr
        ignore(
          CssJs.global(.
            {js|html, body, #root, .class|js},
            [|CssJs.margin(`zero)|],
          ),
        )
      ],
    ),
    (
      "html, body, #root, .class",
      [%expr
        [%styled.global
          {|
    html,             body, #root, .class   {     margin: 0    } |}
        ]
      ],
      [%expr
        ignore(
          CssJs.global(.
            {js|html, body, #root, .class|js},
            [|CssJs.margin(`zero)|],
          ),
        )
      ],
    ),
  ]
  |> List.map(item => {
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
     });
