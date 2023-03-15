open Alcotest;

module Lexer = Css_lexer;
module Parser = Lexer.Parser;
module Types = Css_types;

open Types;

let parse = input => {
  let container_lnum = 0;
  let pos = Lexing.dummy_pos;
  try(Lexer.parse_stylesheet(~container_lnum, ~pos, input) |> Result.ok) {
  | Lexer.LexingError((_, str)) => Error(str)
  | Lexer.ParseError((token, _, _)) =>
    Error(
      "Parse error while reading token '"
      ++ Lexer.token_to_string(token)
      ++ "'",
    )
  | Lexer.GrammarError((str, _)) => Error(str)
  | _exn => Error("Unknown exception")
  };
};

let loc = Location.none;

let success_tests_data =
  [
    (
      "div { color: red }",
      (
        [
          Style_rule({
            loc,
            prelude: (
              [
                (
                  CompoundSelector({
                    type_selector: Some(Type("div")),
                    subclass_selectors: [],
                    pseudo_selectors: [],
                  }),
                  loc,
                ),
              ],
              loc,
            ),
            block: (
              [
                Declaration({
                  loc,
                  name: ("color", loc),
                  value: ([(Ident("red"), loc)], loc),
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
  ]
  |> List.mapi((_index, (input, output)) => {
       let stylesheet: stylesheet = parse(input) |> Result.get_ok;
       let inputTokens = Types.show_stylesheet(stylesheet);
       let outputTokens = Types.show_stylesheet(output);

       let assertion = () =>
         check(string, "should match" ++ input, inputTokens, outputTokens);

       test_case(input, `Quick, assertion);
     });

let error_tests_data =
  [
    ("{}", "Parse error while reading token '{'"),
    ("div { color: red; _ }", "Parse error while reading token '}'"),
  ]
  |> List.mapi((_index, (input, output)) => {
       let assertion = () =>
         check(
           string,
           "should error" ++ input,
           parse(input) |> Result.get_error,
           output,
         );

       test_case(input, `Quick, assertion);
     });

let tests = List.append(success_tests_data, error_tests_data);
