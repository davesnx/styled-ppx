open Alcotest;

let parse = input => {
  let pos = Lexing.dummy_pos;
  let loc =
    Styled_ppx_css_parser.Parser_location.to_ppxlib_location(pos, pos);
  switch (Styled_ppx_css_parser.Driver.parse_stylesheet(~loc, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    open Styled_ppx_css_parser.Ast;
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum + 1;
    let pos_bol = pos.pos_bol;
    let err =
      Printf.sprintf(
        "%s on line %i at position %i",
        msg,
        lnum,
        curr_pos - pos_bol,
      );
    Error(err);
  };
};

let error_tests_data =
  [
    ("{}", "Parse error while reading token '{' on line 1 at position 0"),
    (
      {|div
        { color: red; _ }
      |},
      "Parse error while reading token '}' on line 2 at position 24",
    ),
    (
      "@media $",
      "Parse error while reading token 'the end' on line 1 at position 8",
    ),
  ]
  |> List.mapi((_index, (input, output)) => {
       let assertion = () =>
         check(
           string,
           "should error" ++ input,
           output,
           parse(input) |> Result.get_error,
         );

       test_case(input, `Quick, assertion);
     });

let tests = error_tests_data;
