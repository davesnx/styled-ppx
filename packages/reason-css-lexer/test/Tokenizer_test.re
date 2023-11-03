open Reason_css_lexer;
open Alcotest;

let parse = input => {
  let values =
    switch (from_string(input)) {
    | Ok(values) => values
    | Error(`Frozen) => failwith("Parser got frozen")
    };
  let {loc, _} = List.hd(values);
  let values = values |> List.map(({txt, _}) => txt);
  (loc, values);
};

let render_token =
  fun
  | EOF => ""
  | t => show_token(t);

let list_parse_tokens_to_string = tokens =>
  tokens
  |> List.rev
  |> List.map(
       fun
       | Ok(token) => render_token(token)
       | Error((token, err)) =>
         "Error(" ++ show_error(err) ++ ") " ++ show_token(token),
     )
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(render_token) |> String.concat(" ") |> String.trim;

let tests =
  [
    (" \n\t ", [WHITESPACE], 4),
    ({|"something"|}, [STRING("something")], 11),
    // TODO: is that right?
    ({|#2|}, [HASH("2", `UNRESTRICTED)], 2),
    ({|#abc|}, [HASH("abc", `ID)], 4),
    ({|#|}, [DELIM("#")], 1),
    ({|'tuturu'|}, [STRING("tuturu")], 8),
    ({|(|}, [LEFT_PARENS], 1),
    ({|)|}, [RIGHT_PARENS], 1),
    ({|+12.3|}, [NUMBER(12.3)], 5),
    ({|+|}, [DELIM("+")], 1),
    ({|,|}, [COMMA], 1),
    ({|-45.6|}, [NUMBER(-45.6)], 5),
    ({|--potato|}, [IDENT("--potato")], 8),
    ({|-|}, [DELIM("-")], 1),
    ({|.7|}, [NUMBER(0.7)], 2),
    ({|.|}, [DELIM(".")], 1),
    ({|:|}, [COLON], 1),
    ({|;|}, [SEMICOLON], 1),
    ({|<|}, [DELIM("<")], 1),
    ({|@mayushii|}, [AT_KEYWORD("mayushii")], 9),
    ({|@|}, [DELIM("@")], 1),
    ({|[|}, [LEFT_SQUARE], 1),
    ("\\@desu", [IDENT("@desu")], 6),
    ({|]|}, [RIGHT_SQUARE], 1),
    ({|12345678.9|}, [NUMBER(12345678.9)], 10),
    ({|bar|}, [IDENT("bar")], 3),
    ({||}, [EOF], 0),
    ({|!|}, [DELIM("!")], 1),
    (
      "1 / 1",
      [NUMBER(1.), WHITESPACE, DELIM("/"), WHITESPACE, NUMBER(1.)],
      5,
    ),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION(10., "px"),
        WHITESPACE,
        DELIM("+"),
        WHITESPACE,
        DIMENSION(10., "px"),
        RIGHT_PARENS,
      ],
      17,
    ),
    (
      {|background-image:url('img_tree.gif' )|},
      [
        IDENT("background-image"),
        COLON,
        FUNCTION("url"),
        STRING("img_tree.gif"),
        WHITESPACE,
        RIGHT_PARENS,
      ],
      37,
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION(10., "px"),
        DELIM("+"),
        WHITESPACE,
        DIMENSION(10., "px"),
        RIGHT_PARENS,
      ],
      16,
    ),
    ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE(10.), RIGHT_PARENS], 9),
    (
      {|$(Module.variable)|},
      [
        DELIM("$"),
        LEFT_PARENS,
        IDENT("Module"),
        DELIM("."),
        IDENT("variable"),
        RIGHT_PARENS,
      ],
      18,
    ),
    (
      {|$(Module.variable')|},
      [
        DELIM("$"),
        LEFT_PARENS,
        IDENT("Module"),
        DELIM("."),
        IDENT("variable'"),
        RIGHT_PARENS,
      ],
      19,
    ),
    /* ({|\32|}, [IDENT("--color-main")], 3), */
    /* ({|\25BA|}, [IDENT("--color-main")], 4), */
  ]
  |> List.mapi((_index, (input, output, last_position)) => {
       let (loc, values) = parse(input);

       loc.loc_end.pos_cnum == last_position
         ? ()
         : fail(
             "position should be "
             ++ string_of_int(last_position)
             ++ " received "
             ++ string_of_int(loc.loc_end.pos_cnum),
           );

       let assertion = () =>
         check(
           string,
           "should succed lexing: " ++ input,
           list_parse_tokens_to_string(values),
           list_tokens_to_string(output),
         );

       test_case(input, `Quick, assertion);
     });

Alcotest.run("CSS Lexer", [("Tokenizer", tests)]);
