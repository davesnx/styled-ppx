open Setup;
open Ast_helper;
let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let typ = Str.type_(~loc, Recursive, [input]);
  let result = Pprintast.string_of_structure([typ]);
  let expected = Pprintast.string_of_structure([expected]);
  expect.string(result).toEqual(expected);
};

let gen_type = (name, expr) => {
  let value_binding = Vb.mk(~loc, ~attrs=[], Pat.var(~loc, {txt: name, loc}), expr);
  module Ast_builder = Ppxlib.Ast_builder.Make({ let loc = loc });
  module Emit = Generate.Make(Ast_builder);
  let (name, core_type) = Emit.make_type(value_binding);
  Emit.make_type_declaration(name, core_type);
};

let types = [
  // Keyword
  (
    gen_type("terminal", [%expr [%value "terminal"]]),
    [%stri type terminal = unit],
  ),
  // Data_type
  (
    gen_type("ident", [%expr [%value "<string>"]]),
    [%stri type ident = string],
  ),
  // Property_type
  (
    gen_type("color", [%expr [%value "<'color'>"]]),
    [%stri type color = property_color],
  ),
  // Delim
  (
    gen_type("calc_sum", [%expr [%value "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]]),
    [%stri type calc_sum = (calc_product, list(([ `Cross(unit) | `Dash(unit) ], calc_product)))],
  ),
  // Xor
  (
    gen_type("size", [%expr [%value "relative | static | absolute"]]),
    [%stri type size = [ | `Relative | `Static | `Absolute]],
  ),
  // And
  (
    gen_type(
      "text_emphasis_position",
      [%expr [%value "[ 'over' | 'under' ] && [ 'right' | 'left' ]"]],
    ),
    [%stri
      type text_emphasis_position = ([ | `Over | `Under], [ | `Right | `Left])
    ],
  ),
  // Or
  (
    gen_type(
      "property_clip_path",
      [%expr
        [%value "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]
      ],
    ),
    [%stri
      type property_clip_path = [
        | `Clip_source(clip_source)
        | `Or(option(basic_shape), option(geometry_box))
        | `None
      ]
    ],
  ),
  // Static
  (
    gen_type("contradiction", [%expr [%value "'not' <string>"]]),
    [%stri type contradiction = (unit, string)],
  ),
  // Group
  (
    gen_type("supported", [%expr [%value "supported | [not 'supported']"]]),
    [%stri type supported = [ | `Supported | `Static(unit, unit)]],
  ),
  // Function_call
  (
    gen_type("calc", [%expr [%value "calc( <calc-sum> )"]]),
    [%stri type calc = calc_sum],
  ),

  // Polymorphism
  (
    gen_type(
      "function_color",
      [%expr
        [%value "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
          | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )
          | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
          | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"
        ]
      ],
    ),
    [%stri
      type function_color = [
        | `Rgb_0(list(extended_percentage), option((unit, alpha_value)))
        | `Rgb_1(list(number), option((unit, alpha_value)))
        | `Rgb_2(list(extended_percentage), option((unit, alpha_value)))
        | `Rgb_3(list(number), option((unit, alpha_value)))
      ]
    ],
  ),
];

describe("Should generate valid types based on CSS spec", ({test, _}) => {
  types
  |> List.iteri((_index, ((result), expected)) =>
       test(
         "Type: " ++ Pprintast.string_of_structure([expected]),
         compare(result, expected),
       )
     )
});
