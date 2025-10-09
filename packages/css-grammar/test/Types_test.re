let test = (name, expr: Ppxlib.expression, output) => {
  module Ast_builder =
    Ppxlib.Ast_builder.Make({
      let loc = expr.pexp_loc;
    });
  let pattern =
    Ast_builder.ppat_var({
      txt: name,
      loc: Ppxlib.Location.none,
    });
  let value_binding = Ast_builder.value_binding(~pat=pattern, ~expr);
  module Emit = Generate.Make(Ast_builder);
  let (name, core_type) = Emit.make_type(value_binding);
  let type_declaration = Emit.make_type_declaration(name, core_type);
  let expected = Ast_builder.pstr_type(Nonrecursive, [type_declaration]);
  test(name, _ =>
    Alcotest.check(
      Alcotest.string,
      "",
      Ppxlib.Pprintast.string_of_structure([expected]),
      Ppxlib.Pprintast.string_of_structure([output]),
    )
  );
};

let loc = Ppxlib.Location.none;

let tests: tests = [
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
    [%stri type nonrec ident = String_value.t],
  ),
  // Property_type
  test(
    "color",
    [%expr [%value "<'color'>"]],
    [%stri type nonrec color = Property_color.t],
  ),
  // Delim
  test(
    "calc_sum",
    [%expr [%value "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]],
    [%stri
      type nonrec calc_sum = (
        Calc_product.t,
        list(
          (
            [
              | `Cross
              | `Dash
            ],
            Calc_product.t,
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
        | `Clip_source(Clip_source.t)
        | `Or(option(Basic_shape.t), option(Geometry_box.t))
        | `None
      ]
    ],
  ),
  // Static
  test(
    "contradiction",
    [%expr [%value "'not' <string>"]],
    [%stri type nonrec contradiction = (unit, String_value.t)],
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
    [%stri type nonrec calc = Calc_sum.t],
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
        | `Rgb_0(
            list(Extended_percentage.t),
            option((unit, Alpha_value.t)),
          )
        | `Rgb_1(list(Number.t), option((unit, Alpha_value.t)))
        | `Rgb_2(
            list(Extended_percentage.t),
            option((unit, Alpha_value.t)),
          )
        | `Rgb_3(list(Number.t), option((unit, Alpha_value.t)))
      ]
    ],
  ),
];
