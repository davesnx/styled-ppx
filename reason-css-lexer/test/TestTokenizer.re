open TestFramework;
open Reason_css_lexer;

let single_token_tests = [
  (" \n\t ", WHITESPACE),
  ({|"something"|}, STRING("something")),
  // TODO: is that right?
  ("#2", HASH("2", `UNRESTRICTED)),
  ("#abc", HASH("abc", `ID)),
  ("#", DELIM("#")),
  ({|'tuturu'|}, STRING("tuturu")),
  ("(", LEFT_PARENS),
  (")", RIGHT_PARENS),
  ("+12.3", NUMBER(12.3)),
  ("+", DELIM("+")),
  (",", COMMA),
  ("-45.6", NUMBER(-45.6)),
  ("-->", CDC),
  ("--potato", IDENT("--potato")),
  ("-", DELIM("-")),
  (".7", NUMBER(0.7)),
  (".", DELIM(".")),
  (":", COLON),
  (";", SEMICOLON),
  ("<!--", CDO),
  ("<", DELIM("<")),
  ("@mayushii", AT_KEYWORD("mayushii")),
  ("@", DELIM("@")),
  ("[", LEFT_SQUARE),
  ("\\@desu", IDENT("@desu")),
  ("]", RIGHT_SQUARE),
  ("12345678.9", NUMBER(12345678.9)),
  ("bar", IDENT("bar")),
  ("", EOF),
  ("!", DELIM("!")),
];

describe("single token tests", ({test, _}) => {
  let test = ((input, output)) =>
    test(
      input,
      _ => {
        let values =
          switch (from_string(input)) {
          | Ok(values) => values
          | Error(`Frozen) => failwith("frozen somehow")
          };
        let values = values |> List.map(({Location.txt, _}) => txt);
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
      },
    );
  List.iter(test, single_token_tests);
});
