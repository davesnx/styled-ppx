open Sedlexing;
open Sedlexing.Utf8;
open Token;

let escape = [%sedlex.regexp? '\\'];
let digit = [%sedlex.regexp? '0' .. '9'];
let hex_digit = [%sedlex.regexp? digit | 'A' .. 'F' | 'a' .. 'f'];
let non_ascii_code_point = [%sedlex.regexp? Sub(any, '\000' .. '\128')]; // greater than \u0080
let identifier_start_code_point = [%sedlex.regexp?
  'a' .. 'z' | 'A' .. 'Z' | non_ascii_code_point | '_'
];
/* Added "'" to identifier to enable Language Variables */
let identifier_code_point = [%sedlex.regexp?
  identifier_start_code_point | digit | '-' | "'"
];
let non_printable_code_point = [%sedlex.regexp?
  '\000' .. '\b' | '\011' | '\014' .. '\031' | '\127'
];
let newline = [%sedlex.regexp? '\n'];
let whitespace = [%sedlex.regexp? Plus('\n' | '\t' | ' ')];
let ident_char = [%sedlex.regexp?
  '_' | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' | non_ascii_code_point |
  escape
];

let (let.ok) = Result.bind;

let string_of_uchar = char => {
  let buf = Buffer.create(0);
  Buffer.add_utf_8_uchar(buf, char);
  Buffer.contents(buf);
};

let check = (f, buf) => {
  // TODO: why this second int?
  Sedlexing.mark(buf, 0);
  let value = f(buf);
  let _ = Sedlexing.backtrack(buf);
  value;
};

// https://drafts.csswg.org/css-syntax-3/#starts-with-a-valid-escape
let check_if_two_code_points_are_a_valid_escape = buf =>
  switch%sedlex (buf) {
  | ("\\", '\n') => false
  | ("\\", any) => true
  | _ => false
  };
let starts_with_a_valid_escape = [%sedlex.regexp? ('\\', Sub(any, '\n'))];

// https://drafts.csswg.org/css-syntax-3/#would-start-an-identifier
let check_if_three_codepoints_would_start_an_identifier = buf =>
  switch%sedlex (buf) {
  | ('-', identifier_start_code_point | '-') => true
  // TODO: test the code_points case
  | '-' => check_if_two_code_points_are_a_valid_escape(buf)
  | identifier_start_code_point => true
  | _ => check_if_two_code_points_are_a_valid_escape(buf)
  };
let starts_an_identifier = [%sedlex.regexp?
  ('-', '-' | identifier_start_code_point | starts_with_a_valid_escape) |
  identifier_start_code_point
];
// https://drafts.csswg.org/css-syntax-3/#starts-with-a-number
let check_if_three_code_points_would_start_a_number = buf =>
  switch%sedlex (buf) {
  | ("+" | "-", digit)
  | ("+" | "-", ".", digit) => true
  | ('.', digit) => true
  | _ => false
  };
let starts_a_number = [%sedlex.regexp?
  ("+" | "-", digit) | ("+" | "-", ".", digit) | ('.', digit)
];
let check_if_three_codepoints_would_start_an_identifier =
  check(check_if_three_codepoints_would_start_an_identifier);
let check_if_three_code_points_would_start_a_number =
  check(check_if_three_code_points_would_start_a_number);

let offset = buf => lexeme_end(buf) - lexeme_start(buf);

let uchar_of_int = n => Uchar.of_int(n) |> string_of_uchar;

let fffd = uchar_of_int(0xFFFD);
let is_surrogate = char_code => char_code >= 0xD800 && char_code <= 0xDFFF;

// TODO: floats in OCaml are compatible with numbers in CSS?
let convert_string_to_number = str => float_of_string(str);

let consume_whitespace = buf =>
  switch%sedlex (buf) {
  | Star(whitespace) => WHITESPACE
  | _ => WHITESPACE
  };

// https://drafts.csswg.org/css-syntax-3/#consume-an-escaped-code-point
let consume_escaped = buf => {
  switch%sedlex (buf) {
  // TODO: spec typo? No more than 5?
  | Rep(hex_digit, 1 .. 6) =>
    let hex_string = "0x" ++ lexeme(buf);
    let char_code = int_of_string(hex_string);
    let char = uchar_of_int(char_code);
    let _ = consume_whitespace(buf);
    char_code == 0 || is_surrogate(char_code)
      ? Error((fffd, Invalid_code_point)) : Ok(char);
  | eof => Error((fffd, Eof))
  | any => Ok(lexeme(buf))
  | _ => failwith("unrecheable")
  };
};

// TODO: check 5. without the 0
let consume_number = buf => {
  let append = repr => repr ++ lexeme(buf);

  let kind = `Integer; // 1
  let repr = "";
  let repr =
    switch%sedlex (buf) {
    | (Opt("+" | "-"), Plus(digit)) => append(repr)
    | _ => repr
    }; // 2 - 3
  let (kind, repr) =
    switch%sedlex (buf) {
    | (".", Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 4
  let (kind, repr) =
    switch%sedlex (buf) {
    | ('E' | 'e', Opt('+' | '-'), Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 5
  let value = convert_string_to_number(repr); // 6
  (value, kind); // 7
};

// https://drafts.csswg.org/css-syntax-3/#consume-name
let consume_identifier = buf => {
  let rec read = acc =>
    switch%sedlex (buf) {
    | identifier_code_point => read(acc ++ lexeme(buf))
    | escape =>
      // TODO: spec, what should happen when fails?
      let.ok char = consume_escaped(buf);
      read(acc ++ char);
    | _ => Ok(acc)
    };
  read("");
};

let handle_consume_identifier =
  fun
  | Error((_, error)) => Error((BAD_IDENT, error))
  | Ok(string) => Ok(string);

// https://drafts.csswg.org/css-syntax-3/#consume-remnants-of-bad-url
let rec consume_remnants_bad_url = buf =>
  switch%sedlex (buf) {
  | ')'
  | eof => ()
  | escape =>
    let _ = consume_escaped(buf);
    consume_remnants_bad_url(buf);
  | any => consume_remnants_bad_url(buf)
  | _ => failwith("grr unreachable")
  };

// https://drafts.csswg.org/css-syntax-3/#consume-url-token
let consume_url = buf => {
  let _ = consume_whitespace(buf);
  let rec read = acc => {
    let when_whitespace = () => {
      let _ = consume_whitespace(buf);
      switch%sedlex (buf) {
      | ')' => Ok(URL(acc))
      | eof => Error((URL(acc), Eof))
      | _ =>
        consume_remnants_bad_url(buf);
        Ok(BAD_URL);
      };
    };
    switch%sedlex (buf) {
    | ')' => Ok(URL(acc))
    | eof => Error((URL(acc), Eof))
    | whitespace => when_whitespace()
    | '"'
    | '\''
    | '('
    | non_printable_code_point =>
      consume_remnants_bad_url(buf);
      // TODO: location on error
      Error((BAD_URL, Invalid_code_point));
    | escape =>
      switch (consume_escaped(buf)) {
      | Ok(char) => read(acc ++ char)
      | Error((_, error)) => Error((BAD_URL, error))
      }
    | any => read(acc ++ lexeme(buf))
    | _ => failwith("please, unreachable")
    };
  };
  read("");
};

// https://drafts.csswg.org/css-syntax-3/#consume-string-token
// TODO: when EOF is bad-string-token or string-token
// TODO: currently it is a little bit different than the specification
let consume_string = (ending_code_point, buf) => {
  let rec read = acc => {
    // TODO: fix sedlex nested problem
    let read_escaped = () =>
      switch%sedlex (buf) {
      | eof => Error((acc, Eof))
      | '\n' => read(acc)
      | _ =>
        // TODO: is that tail call recursive? I'm not sure
        let.ok char = consume_escaped(buf);
        read(acc ++ char);
      };
    switch%sedlex (buf) {
    | '\''
    | '"' =>
      let code_point = lexeme(buf);
      code_point == ending_code_point ? Ok(acc) : read(acc ++ lexeme(buf));
    | eof => Error((acc, Eof))
    | newline => Error((acc, New_line))
    | escape => read_escaped()
    | any => read(acc ++ lexeme(buf))
    | _ => failwith("should be unreachable")
    };
  };

  switch (read("")) {
  | Ok(string) => Ok(STRING(string))
  | Error((string, error)) => Error((BAD_STRING(string), error))
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-ident-like-token
let consume_ident_like = buf => {
  let read_url = string => {
    // TODO: the whitespace trickery here?
    let _ = consume_whitespace(buf);
    let is_function =
      check(buf =>
        switch%sedlex (buf) {
        | '\''
        | '"' => true
        | _ => false
        }
      );
    is_function(buf) ? Ok(FUNCTION(string)) : consume_url(buf);
  };

  // TODO: should it return IDENT() when error?
  let.ok string = consume_identifier(buf) |> handle_consume_identifier;

  switch%sedlex (buf) {
  | '(' =>
    switch (string) {
    | "url" => read_url(string)
    | _ => Ok(FUNCTION(string))
    }
  | _ => Ok(IDENT(string))
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-numeric-token
let consume_numeric = buf => {
  // TODO: kind matters?
  let (number, _kind) = consume_number(buf);
  if (check_if_three_codepoints_would_start_an_identifier(buf)) {
    // TODO: should it be BAD_IDENT?
    let.ok string = consume_identifier(buf) |> handle_consume_identifier;
    Ok(DIMENSION(number, string));
  } else {
    switch%sedlex (buf) {
    | '%' => Ok(PERCENTAGE(number))
    | _ => Ok(NUMBER(number))
    };
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-comment
let consume_comment = buf => {
  let rec read_until_closes = () =>
    switch%sedlex (buf) {
    | "*/" => Ok()
    | eof => Error(((), Eof))
    | _ => read_until_closes()
    };
  switch%sedlex (buf) {
  | "/*" => read_until_closes()
  | _ => Ok()
  };
};

let consume = buf => {
  let consume_hash = () =>
    switch%sedlex (buf) {
    | identifier_code_point
    | starts_with_a_valid_escape =>
      rollback(buf);
      switch%sedlex (buf) {
      | identifier_start_code_point =>
        rollback(buf);
        let.ok string = consume_identifier(buf) |> handle_consume_identifier;
        Ok(HASH(string, `ID));
      | _ =>
        let.ok string = consume_identifier(buf) |> handle_consume_identifier;
        Ok(HASH(string, `UNRESTRICTED));
      };
    | _ => Ok(DELIM("#"))
    };
  let consume_minus = () =>
    switch%sedlex (buf) {
    | starts_a_number =>
      Sedlexing.rollback(buf);
      consume_numeric(buf);
    | "-->" => Ok(CDC)
    | starts_an_identifier =>
      Sedlexing.rollback(buf);
      consume_ident_like(buf);
    | _ =>
      let _ = next(buf);
      Ok(DELIM("-"));
    };

  switch%sedlex (buf) {
  | whitespace => Ok(consume_whitespace(buf))
  | "\"" => consume_string("\"", buf)
  | "#" => consume_hash()
  | "'" => consume_string("'", buf)
  | "(" => Ok(LEFT_PARENS)
  | ")" => Ok(RIGHT_PARENS)
  | "+" =>
    let _ = Sedlexing.backtrack(buf);
    if (check_if_three_code_points_would_start_a_number(buf)) {
      consume_numeric(buf);
    } else {
      let _ = Sedlexing.next(buf);
      Ok(DELIM("+"));
    };
  | "," => Ok(COMMA)
  | "-" =>
    Sedlexing.rollback(buf);
    consume_minus();
  | "." =>
    let _ = Sedlexing.backtrack(buf);
    if (check_if_three_code_points_would_start_a_number(buf)) {
      consume_numeric(buf);
    } else {
      let _ = Sedlexing.next(buf);
      Ok(DELIM("."));
    };
  | ":" => Ok(COLON)
  | ";" => Ok(SEMICOLON)
  | "<!--" => Ok(CDO)
  | "<" => Ok(DELIM("<"))
  | "@" =>
    if (check_if_three_codepoints_would_start_an_identifier(buf)) {
      // TODO: grr BAD_IDENT
      let.ok string = consume_identifier(buf) |> handle_consume_identifier;
      Ok(AT_KEYWORD(string));
    } else {
      Ok(DELIM("@"));
    }
  | "[" => Ok(LEFT_SQUARE)
  | "\\" =>
    rollback(buf);
    switch%sedlex (buf) {
    | starts_with_a_valid_escape =>
      rollback(buf);
      consume_ident_like(buf);
    // TODO: this error should be different
    | _ => Error((DELIM("/"), Invalid_code_point))
    };
  | "]" => Ok(RIGHT_SQUARE)
  | digit =>
    let _ = Sedlexing.backtrack(buf);
    consume_numeric(buf);
  | identifier_start_code_point =>
    let _ = Sedlexing.backtrack(buf);
    consume_ident_like(buf);
  | eof => Ok(EOF)
  | any => Ok(DELIM(lexeme(buf)))
  | _ =>
    failwith(
      "This match case is unreachable. sedlex needs a last case as wildcard _. If this error appears, means that there's a bug in the lexer.",
    )
  };
};
