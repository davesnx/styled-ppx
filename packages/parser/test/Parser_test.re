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
    ("{}", "Parse error while reading token '{' on line 0 at position 0"),
    (
      {|div
        { color: red; _ }
      |},
      "Parse error while reading token '}' on line 2 at position 23",
    ),
    (
      "@media $",
      "Parse error while reading token '' on line 1 at position 7",
    ),
    //(
    //  /* whitespace must follow `not` */
    //  "@media (not(color)){}",
    //  "Parse error while reading token ')' on line 1 at position 17",
    //),
    //(
    //  /* whitespace must follow `or` */
    //  "@media (not (color)) or(hover) {}",
    //  "Parse error while reading token 'or(' on line 1 at position 20",
    //),
    //(
    //  /* whitespace must follow `and` */
    //  "@media (not (color)) and(hover) {}",
    //  "Parse error while reading token 'and(' on line 1 at position 20",
    //),
    // We handle this via the property parser
    //(
    //  /* space between < and = is invalid */
    //  "@media (width < = 33px) {}",
    //  "Parse error while reading token '=' on line 1 at position 15",
    //),
  ]
  |> List.mapi((_index, (input, output)) => {
       let assertion = () =>
         check(
           ~__POS__,
           Alcotest.string,
           output,
           parse(input) |> Result.get_error,
         );

       test(input, assertion);
     });

let tests = error_tests_data;
