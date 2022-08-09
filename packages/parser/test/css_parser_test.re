open Setup;

module Lexer = Css_lexer;
module Parser = Lexer.Parser;
module Types = Css_types;
module Debug = Types.Debug;

let parse = (input) => {
  let container_lnum = 0;
  let pos = Lexing.dummy_pos;
  try(Lexer.parse_stylesheet(~container_lnum, ~pos, input) |> Result.ok) {
    | Lexer.LexingError((_, str)) => Error(str)
    | Lexer.ParseError((token, _, _)) => {
      Error("Parse error while reading token '" ++ Lexer.token_to_string(token) ++ "'")
    }
    | Lexer.GrammarError((str, _)) => Error(str)
    | _exn => Error("Unknown exception")
  };
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
                Rule.Declaration({
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
        "should succeed parsing: " ++ input,
        ({expect, _}) => {
          let stylesheet: Types.Stylesheet.t = parse(input) |> Result.get_ok;
          let inputTokens = Debug.render_stylesheet(stylesheet);
          let outputTokens = Debug.render_stylesheet(output);
          expect.string(inputTokens).toEqual(outputTokens);
        },
      ),
    success_tests_data,
  );

  let error_tests_data = [
    (
      "{}", "Parse error while reading token '{'",
    ),
    (
      "div { color: red; _ }", "Parse error while reading token '}'",
    ),
  ]

  List.iter(
    ((input, output)) =>
      test(
        "should error lexing: " ++ input,
        ({expect, _}) => {
          let errorInput = parse(input) |> Result.get_error;
          expect.string(errorInput).toEqual(output);
        },
      ),
    error_tests_data,
  );
});
