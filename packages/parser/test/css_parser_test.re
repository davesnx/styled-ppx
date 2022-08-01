open Setup;

module Lexer = Css_lexer;
module Parser = Css_lexer.Parser;
module Types = Css_types;
module Debug = Css_types.Debug;

let parse = (input): Types.Stylesheet.t => {
  let container_lnum = 0;
  let pos = Lexing.dummy_pos;
  Lexer.parse_stylesheet(~container_lnum, ~pos, input);
};

describe("CSS Parser", ({test, _}) => {
  open Types;

  let loc = Location.none;

  let success_tests_data = [
    (
      "div { color: red }",
      (
        [
          Rule.Style_rule({
            Style_rule.loc,
            prelude: (
              CompoundSelector([
                {
                  type_selector: Some(Type("div")),
                  subclass_selectors: [],
                  pseudo_selectors: [],
                },
              ]),
              loc,
            ),
            block: (
              [
                Declaration_list.Declaration({
                  loc,
                  name: ("color", loc),
                  value: ([(Component_value.Ident("red"), loc)], loc),
                  important: (false, loc),
                }),
              ],
              loc,
            ),
          }),
        ],
        loc,
      ),
    ),
  ];

  List.iter(
    ((input, output)) =>
      test(
        "should succeed lexing: " ++ input,
        ({expect, _}) => {
          let stylesheet = parse(input);
          let inputTokens = Debug.render_stylesheet(stylesheet);
          let outputTokens = Debug.render_stylesheet(output);
          expect.string(inputTokens).toEqual(outputTokens);
        },
      ),
    success_tests_data,
  );
});

/*
 test("should error", ({expect, _}) => {
   let errorInput = parse("/*") |> Result.get_error;
   expect.string(errorInput).toEqual();
 });
 */
