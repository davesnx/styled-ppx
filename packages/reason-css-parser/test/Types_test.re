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
  let vb = Vb.mk(~loc, ~attrs=[], Pat.var(~loc, {txt: name, loc}), expr);
  EmitType.gen_type(vb);
};

let types = [
  // Keyword
  (
    gen_type("terminal", [%expr [%value "terminal"]]),
    [%stri type terminal = [ | `Terminal]],
  ),
  // Data_type
  (
    gen_type("ident", [%expr [%value "<string>"]]),
    [%stri type ident = [ | `String(string)]],
  ),
  // Property_type
  (
    gen_type("color", [%expr [%value "<'color'>"]]),
    [%stri type color = [ | `Property_color(property_color)]],
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
    [%stri type text_emphasis_position],
  ),
  // Or
  (
    gen_type(
      "property_clip_path",
      [%expr
        [%value "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]
      ],
    ),
    [%stri type property_clip_path],
  ),
  // Static
  (
    gen_type("contradiction", [%expr [%value "'not' <string>"]]),
    [%stri type contradiction],
  ),
  // Group
  (
    gen_type("unsupported", [%expr [%value "test | [not 'supported']"]]),
    [%stri type unsupported],
  ),
  // Function_call
  (
    gen_type("calc", [%expr [%value "calc( <calc-sum> )"]]),
    [%stri type calc],
  ),
];

describe("Should generate valid types based on CSS spec", ({test, _}) => {
  types
  |> List.iteri((_index, (result, expected)) =>
       test(
         "Type: " ++ Pprintast.string_of_structure([expected]),
         compare(result, expected),
       )
     )
});