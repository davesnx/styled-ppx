open Ppxlib;
open Alcotest;

let loc = Location.none;

let test = (name, expr, output) => {
  module Ast_builder =
    Ppxlib.Ast_builder.Make({
      let loc = expr.pexp_loc;
    });
  let pattern =
    Ast_builder.ppat_var({
      txt: name,
      loc,
    });
  let value_binding = Ast_builder.value_binding(~pat=pattern, ~expr);
  module Emit = Generate.Make(Ast_builder);
  let (name, core_type) = Emit.make_type(value_binding);
  let type_declaration = Emit.make_type_declaration(name, core_type);
  let expected = Ast_builder.pstr_type(Nonrecursive, [type_declaration]);
  test_case(name, `Quick, _ =>
    check(
      Alcotest.string,
      "",
      Pprintast.string_of_structure([expected]),
      Pprintast.string_of_structure([output]),
    )
  );
};

let tests: list(Alcotest.test_case(unit)) = [
  // Keyword
  test(
    "terminal",
    [%expr [%value "terminal"]],
    [%stri type nonrec terminal = unit],
  ),
  // Data_type
  test(
    "ident",
    [%expr [%value "<string>"]],
    [%stri type nonrec ident = string],
  ),
  // Property_type
  test(
    "color",
    [%expr [%value "<'color'>"]],
    [%stri type nonrec color = property_color],
  ),
  // Delim
  test(
    "calc_sum",
    [%expr [%value "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]],
    [%stri
      type nonrec calc_sum = (
        calc_product,
        list(
          (
            [
              | `Cross(unit)
              | `Dash(unit)
            ],
            calc_product,
          ),
        ),
      )
    ],
  ),
  // Xor
  test(
    "size",
    [%expr [%value "relative | static | absolute"]],
    [%stri
      type nonrec size = [
        | `Relative
        | `Static
        | `Absolute
      ]
    ],
  ),
  // And
  test(
    "text_emphasis_position",
    [%expr [%value "[ 'over' | 'under' ] && [ 'right' | 'left' ]"]],
    [%stri
      type nonrec text_emphasis_position = (
        [
          | `Over
          | `Under
        ],
        [
          | `Right
          | `Left
        ],
      )
    ],
  ),
  // Or
  test(
    "property_clip_path",
    [%expr
      [%value "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]
    ],
    [%stri
      type nonrec property_clip_path = [
        | `Clip_source(clip_source)
        | `Or(option(basic_shape), option(geometry_box))
        | `None
      ]
    ],
  ),
  // Static
  test(
    "contradiction",
    [%expr [%value "'not' <string>"]],
    [%stri type nonrec contradiction = (unit, string)],
  ),
  // Group
  test(
    "supported",
    [%expr [%value "supported | [not 'supported']"]],
    [%stri
      type nonrec supported = [
        | `Supported
        | `Static(unit, unit)
      ]
    ],
  ),
  // Function_call
  test(
    "calc",
    [%expr [%value "calc( <calc-sum> )"]],
    [%stri type nonrec calc = calc_sum],
  ),
  // Polymorphism
  test(
    "function_color",
    [%expr
      [%value
        "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
          | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )
          | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
          | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"
      ]
    ],
    [%stri
      type nonrec function_color = [
        | `Rgb_0(list(extended_percentage), option((unit, alpha_value)))
        | `Rgb_1(list(number), option((unit, alpha_value)))
        | `Rgb_2(list(extended_percentage), option((unit, alpha_value)))
        | `Rgb_3(list(number), option((unit, alpha_value)))
      ]
    ],
  ),
];
