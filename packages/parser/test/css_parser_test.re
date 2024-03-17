open Alcotest;

let parse = input => {
  let pos = Lexing.dummy_pos;
  switch (Driver.parse_stylesheet(~lnum=0, ~pos, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum;
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
      "Parse error while reading token '}' on line 2 at position 23",
    ),
    (
      "@media $",
      "Parse error while reading token '$' on line 1 at position 7",
    ),
    (
      /* whitespace must follow `not` */
      "@media (not(color)){}",
      "Parse error while reading token ')' on line 1 at position 18",
    ),
    (
      /* whitespace must follow `or` */
      "@media (not (color)) or(hover) {}",
      "Parse error while reading token 'or(' on line 1 at position 21",
    ),
    (
      /* whitespace must follow `and` */
      "@media (not (color)) and(hover) {}",
      "Parse error while reading token 'and(' on line 1 at position 21",
    ),
    (
      /* space between < and = is invalid */
      "@media (width < = 33px) {}",
      "Parse error while reading token '=' on line 1 at position 16",
    ),
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
