open TestFramework;
open Reason_css_lexer;
open Location;

let single_token_tests = [
  (" \n\t ", WHITESPACE, 4),
  ({|"something"|}, STRING("something"), 11),
  // TODO: is that right?
  ("#2", HASH("2", `UNRESTRICTED), 2),
  ("#abc", HASH("abc", `ID), 4),
  ("#", DELIM("#"), 1),
  ({|'tuturu'|}, STRING("tuturu"), 8),
  ("(", LEFT_PARENS, 1),
  (")", RIGHT_PARENS, 1),
  ("+12.3", NUMBER(12.3), 5),
  ("+", DELIM("+"), 1),
  (",", COMMA, 1),
  ("-45.6", NUMBER(-45.6), 5),
  ("-->", CDC, 3),
  ("--potato", IDENT("--potato"), 8),
  ("-", DELIM("-"), 1),
  (".7", NUMBER(0.7), 2),
  (".", DELIM("."), 1),
  (":", COLON, 1),
  (";", SEMICOLON, 1),
  ("<!--", CDO, 4),
  ("<", DELIM("<"), 1),
  ("@mayushii", AT_KEYWORD("mayushii"), 9),
  ("@", DELIM("@"), 1),
  ("[", LEFT_SQUARE, 1),
  ("\\@desu", IDENT("@desu"), 6),
  ("]", RIGHT_SQUARE, 1),
  ("12345678.9", NUMBER(12345678.9), 10),
  ("bar", IDENT("bar"), 3),
  ("", EOF, 0),
  ("!", DELIM("!"), 1),
];

describe("single token tests", ({test, _}) => {
  let test = ((input, output, last_position)) =>
    test(
      input,
      _ => {
        let values =
          switch (from_string(input)) {
          | Ok(values) => values
          | Error(`Frozen) => failwith("frozen somehow")
          };
        let {loc, _} = List.hd(values);
        let values = values |> List.map(({txt, _}) => txt);
        switch (values) {
        | [Ok(EOF), Ok(token)] =>
          token == output
            ? ()
            : failwith(
                "should be: "
                ++ show_token(output)
                ++ "\nreceived: "
                ++ show_token(token),
              )
        | [Ok(EOF)] when output == EOF => ()
        | xs =>
          failwith(
            "should be "
            ++ show_token(output)
            ++ " received "
            ++ (
              List.map(
                fun
                | Ok(token) => show_token(token)
                | Error((token, _)) => "Error(" ++ show_token(token) ++ ")",
                xs,
              )
              |> String.concat(" ")
            ),
          )
        };

        loc.loc_end.pos_cnum == last_position
          ? ()
          : failwith(
              "position should be "
              ++ string_of_int(last_position)
              ++ " received "
              ++ string_of_int(loc.loc_end.pos_cnum),
            );
      },
    );
  List.iter(test, single_token_tests);
});
