open Alcotest;

let parse = input => {
  let pos = Some(Lexing.dummy_pos);
  switch (Driver.parse_stylesheet(~pos, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    let pos = loc.Css_types.loc_start;
    let curr_pos = pos.pos_cnum;
    let err = Printf.sprintf("%s at position %i", msg, curr_pos);
    Error(err);
  };
};

let error_tests_data =
  [
    ("{}", "Parse error while reading token '{' at position 0"),
    (
      "div { color: red; _ }",
      "Parse error while reading token '}' at position 19",
    ),
    ("@media $", "Parse error while reading token '$' at position 7"),
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
