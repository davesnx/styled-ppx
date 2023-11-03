open Alcotest;

module Lexer = Css_lexer;

let parse = input => {
  let container_lnum = 0;
  let pos = Lexing.dummy_pos;
  switch (Driver_.parse_stylesheet(~container_lnum, ~pos, input)) {
  | Ok(ast) => Ok(ast)
  | Error((_loc, msg)) => Error(msg)
  };
};

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

let tests = error_tests_data;
