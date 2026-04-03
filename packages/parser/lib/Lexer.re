/** CSS lexer
  * Reference:
  * https://www.w3.org/TR/css-syntax-3/ */
module Types = Ast;
module Location = Ppxlib.Location;

open Tokens;

let (let.ok) = Result.bind;

/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

/* Regexes */
let newline = [%sedlex.regexp? '\n' | "\r\n" | '\r' | '\012'];

// comment \/\*[^*]*\*+([^/*][^*]*\*+)*\/ (https://www.w3.org/TR/CSS21/grammar.html)
let comment = [%sedlex.regexp?
  (
    "/*",
    Star(Compl('*')),
    Plus('*'),
    Star((Intersect(Compl('/'), Compl('*')), Star(Compl('*')), Plus('*'))),
    "/",
  )
];

let whitespace = [%sedlex.regexp? " " | '\t' | newline];
let whitespace_or_comment = [%sedlex.regexp? whitespace | comment];
let whitespaces = [%sedlex.regexp? Star(whitespace)];

let digit = [%sedlex.regexp? '0' .. '9'];

let hex_digit = [%sedlex.regexp? digit | 'A' .. 'F' | 'a' .. 'f'];

let up_to_6_hex_digits = [%sedlex.regexp? Rep(hex_digit, 1 .. 6)];

let unicode_range = [%sedlex.regexp?
  Rep(hex_digit | '?', 1 .. 6) |
  (up_to_6_hex_digits, '-', up_to_6_hex_digits)
];

let escape = [%sedlex.regexp? '\\'];

let alpha = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z'];

// https://drafts.csswg.org/css-syntax-3/#non-ascii-ident-code-point
let non_ascii = [%sedlex.regexp?
  0x00B7 | 0x00C0 .. 0x00D6 | 0x00D8 .. 0x00F6 | 0x00F8 .. 0x037D |
  0x037F .. 0x1FFF |
  0x200C |
  0x200D |
  0x203F |
  0x2040 |
  0x2070 .. 0x218F |
  0x2C00 .. 0x2FEF |
  0x3001 .. 0xD7FF |
  0xF900 .. 0xFDCF |
  0xFDF0 .. 0xFFFD |
  Compl(0x0000 .. 0x10000)
];

let ident_start = [%sedlex.regexp? '_' | alpha | '$' | non_ascii | escape];

let ident_char = [%sedlex.regexp?
  '_' | alpha | digit | '-' | non_ascii | escape
];

let ident = [%sedlex.regexp?
  (Opt('-'), Opt('-'), ident_start, Star(ident_char))
];

/* Interpolation start sequence \$( - the rest is handled by consume_interpolation */
let interpolation_start = [%sedlex.regexp? ('$', '(')];

let string_quote = [%sedlex.regexp?
  (
    '"',
    Star(Compl('\n' | '\r' | '\012' | '"') | ('\\', newline) | escape),
    '"',
  )
];

let string_apos = [%sedlex.regexp?
  (
    '\'',
    Star(Compl('\n' | '\r' | '\012' | '\'') | ('\\', newline) | escape),
    '\'',
  )
];

let number = [%sedlex.regexp?
  (
    Opt('-'),
    Plus(digit),
    Opt('.', Plus(digit)),
    Opt('e' | 'E', '+' | '-', Plus(digit)),
  ) |
  (Opt('-'), '.', Plus(digit), Opt('e' | 'E', '+' | '-', Plus(digit)))
];

let identifier_start_code_point = [%sedlex.regexp? alpha | non_ascii | '_'];
let starts_with_a_valid_escape = [%sedlex.regexp? ('\\', Sub(any, '\n'))];

let starts_an_identifier = [%sedlex.regexp?
  ('-', '-' | identifier_start_code_point | starts_with_a_valid_escape) |
  identifier_start_code_point
];
/* Added "'" to identifier to enable Language Variables */
let identifier_code_point = [%sedlex.regexp?
  identifier_start_code_point | digit | '-' | "'"
];
let non_printable_code_point = [%sedlex.regexp?
  '\000' .. '\b' | '\011' | '\014' .. '\031' | '\127'
];

let starts_a_number = [%sedlex.regexp?
  ("+" | "-", digit) | ("+" | "-", ".", digit) | ('.', digit)
];

let _a = [%sedlex.regexp? 'A' | 'a'];
let _i = [%sedlex.regexp? 'I' | 'i'];
let _m = [%sedlex.regexp? 'M' | 'm'];
let _n = [%sedlex.regexp? 'N' | 'n'];
let _o = [%sedlex.regexp? 'O' | 'o'];
let _p = [%sedlex.regexp? 'P' | 'p'];
let _r = [%sedlex.regexp? 'R' | 'r'];
let _t = [%sedlex.regexp? 'T' | 't'];
let _u = [%sedlex.regexp? 'U' | 'u'];

let important = [%sedlex.regexp?
  ("!", whitespaces, _i, _m, _p, _o, _r, _t, _a, _n, _t)
];

// https://drafts.csswg.org/css-syntax-3/#starts-with-a-valid-escape
let check_if_two_code_points_are_a_valid_escape = lexbuf =>
  switch%sedlex (lexbuf) {
  | ("\\", '\n') => false
  | ("\\", any) => true
  | _ => false
  };

// https://drafts.csswg.org/css-syntax-3/#would-start-an-identifier
let check_if_three_codepoints_would_start_an_identifier = lexbuf => {
  switch%sedlex (lexbuf) {
  | ('-', identifier_start_code_point | '-') => true
  // TODO: test the code_points case
  | '-' => check_if_two_code_points_are_a_valid_escape(lexbuf)
  | identifier_start_code_point => true
  | _ => check_if_two_code_points_are_a_valid_escape(lexbuf)
  };
};

// https://drafts.csswg.org/css-syntax-3/#starts-with-a-number
let check_if_three_code_points_would_start_a_number = lexbuf =>
  switch%sedlex (lexbuf) {
  | ("+" | "-", digit)
  | ("+" | "-", ".", digit) => true
  | ('.', digit) => true
  | _ => false
  };

let check = (f, lexbuf) => {
  // TODO: why this second int?
  Sedlexing.mark(lexbuf, 0);
  let value = f(lexbuf);
  let _ = Sedlexing.backtrack(lexbuf);
  value;
};

let string_of_uchar = char => {
  let lexbuf = Buffer.create(0);
  Buffer.add_utf_8_uchar(lexbuf, char);
  Buffer.contents(lexbuf);
};

let uchar_of_int = n => Uchar.of_int(n) |> string_of_uchar;

let is_surrogate = char_code => char_code >= 0xD800 && char_code <= 0xDFFF;

/* sedlex needs a last case as wildcard _. If this error appears, means that
   there's a bug in the lexer and there cases that aren't matched */
let unreachable = lexbuf => {
  let (start_pos, curr_pos) = Sedlexing.lexing_positions(lexbuf);
  raise(
    LexingError((
      start_pos,
      curr_pos,
      "Unknown failure while lexing. This case should be unreachable",
    )),
  );
};

let lexeme = (~skip=0, ~drop=0, lexbuf) => {
  switch (skip, drop) {
  | (0, 0) => Sedlexing.Utf8.lexeme(lexbuf)
  | (_, _) =>
    let len = Sedlexing.lexeme_length(lexbuf) - skip - drop;
    Sedlexing.Utf8.sub_lexeme(lexbuf, skip, len);
  };
};

let skip_whitespace_after_escape = lexbuf =>
  switch%sedlex (lexbuf) {
  | Star(whitespace) => ()
  | _ => ()
  };

// https://drafts.csswg.org/css-syntax-3/#consume-an-escaped-code-point
let consume_escaped = lexbuf => {
  switch%sedlex (lexbuf) {
  // TODO: spec typo? No more than 5?
  | Rep(hex_digit, 1 .. 6) =>
    let hex_string = "0x" ++ lexeme(lexbuf);
    let char_code = int_of_string(hex_string);
    let char = uchar_of_int(char_code);
    let _ = skip_whitespace_after_escape(lexbuf);
    char_code == 0 || is_surrogate(char_code)
      // U+FFFD is a character used as a substitute for an uninterpretable character from another encoding
      ? Error(("U+FFFD", Tokens.Invalid_code_point)) : Ok(char);
  | eof => Error(("U+FFFD", Tokens.Eof))
  | any => Ok(lexeme(lexbuf))
  | _ => unreachable(lexbuf)
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-name
let consume_identifier = lexbuf => {
  let rec read = acc =>
    switch%sedlex (lexbuf) {
    | identifier_code_point => read(acc ++ lexeme(lexbuf))
    | escape =>
      // TODO: spec, what should happen when fails?
      let.ok char = consume_escaped(lexbuf);
      read(acc ++ char);
    | _ => Ok(acc)
    };
  read(lexeme(lexbuf));
};

// https://drafts.csswg.org/css-syntax-3/#consume-remnants-of-bad-url
let rec consume_remnants_bad_url = lexbuf =>
  switch%sedlex (lexbuf) {
  | ")"
  | eof => ()
  | escape =>
    let _ = consume_escaped(lexbuf);
    consume_remnants_bad_url(lexbuf);
  | any => consume_remnants_bad_url(lexbuf)
  | _ => unreachable(lexbuf)
  };

let check_if_three_codepoints_would_start_an_identifier =
  check(check_if_three_codepoints_would_start_an_identifier);
let check_if_three_code_points_would_start_a_number =
  check(check_if_three_code_points_would_start_a_number);

// TODO: floats in OCaml are compatible with numbers in CSS?
let convert_string_to_number = str => float_of_string(str);

let skip_whitespace_and_comments = lexbuf =>
  switch%sedlex (lexbuf) {
  | Star(whitespace_or_comment) => ()
  | _ => ()
  };

// TODO: check 5. without the 0 or .5 without the 0
let consume_number = lexbuf => {
  let append = repr => repr ++ lexeme(lexbuf);

  let kind = `Integer; // 1
  let repr = "";
  let repr =
    switch%sedlex (lexbuf) {
    | (Opt("+" | "-"), Plus(digit)) => append(repr)
    | _ => repr
    }; // 2 - 3
  let (kind, repr) =
    switch%sedlex (lexbuf) {
    | (".", Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 4
  let (kind, repr) =
    switch%sedlex (lexbuf) {
    | ('E' | 'e', Opt('+' | '-'), Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 5
  let value = convert_string_to_number(repr); // 6
  (value, kind); // 7
};

// https://drafts.csswg.org/css-syntax-3/#consume-url-token
let consume_url = lexbuf => {
  let _ = skip_whitespace_and_comments(lexbuf);
  let rec read = acc => {
    let when_whitespace = () => {
      let _ = skip_whitespace_and_comments(lexbuf);
      switch%sedlex (lexbuf) {
      | ')' => Ok(Tokens.URL(acc))
      | eof => Error(Tokens.Eof)
      | _ =>
        consume_remnants_bad_url(lexbuf);
        Error(Tokens.Bad_url);
      };
    };
    switch%sedlex (lexbuf) {
    | ')' => Ok(Tokens.URL(acc))
    | eof => Error(Tokens.Eof)
    | whitespace => when_whitespace()
    | '"'
    | '\''
    | '('
    | non_printable_code_point =>
      consume_remnants_bad_url(lexbuf);
      Error(Tokens.Bad_url);
    | escape =>
      switch (consume_escaped(lexbuf)) {
      | Ok(char) => read(acc ++ char)
      | Error((_, _)) =>
        consume_remnants_bad_url(lexbuf);
        Error(Tokens.Bad_url);
      }
    | any => read(acc ++ lexeme(lexbuf))
    | _ => unreachable(lexbuf)
    };
  };
  read(lexeme(lexbuf));
};

// https://drafts.csswg.org/css-syntax-3/#consume-string-token
// TODO: when EOF is bad-string-token or string-token
// TODO: currently it is a little bit different than the specification
let consume_string = (ending_code_point, lexbuf) => {
  let rec read = acc => {
    // TODO: fix sedlex nested problem
    let read_escaped = () =>
      switch%sedlex (lexbuf) {
      | eof => Error((acc, Tokens.Eof))
      | '\n' => read(acc)
      | _ =>
        // TODO: is that tail call recursive? I'm not sure
        let.ok char = consume_escaped(lexbuf);
        read(acc ++ char);
      };
    switch%sedlex (lexbuf) {
    | '\''
    | '"' =>
      let code_point = lexeme(lexbuf);
      code_point == ending_code_point
        ? Ok(acc) : read(acc ++ lexeme(lexbuf));
    | eof => Error((acc, Eof))
    | newline => Error((acc, New_line))
    | escape => read_escaped()
    | any => read(acc ++ lexeme(lexbuf))
    | _ => unreachable(lexbuf)
    };
  };

  switch (read("")) {
  | Ok(string) => Ok(Tokens.STRING(string))
  | Error((_, error)) => Error(error)
  };
};

let handle_consume_identifier =
  fun
  | Error((_, _)) => Error(Tokens.Bad_ident)
  | Ok(string) => Ok(string);

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  start_pos: Lexing.position,
  end_pos: Lexing.position,
};

// https://drafts.csswg.org/css-syntax-3/#consume-ident-like-token
let function_token: string => Tokens.token =
  fun
  | ("nth-last-child" | "nth-child" | "nth-of-type" | "nth-last-of-type") as name =>
    NTH_FUNCTION(name)
  | name => FUNCTION(name);

let scan_ident_like = lexbuf => {
  let read_url = string => {
    let _ = skip_whitespace_and_comments(lexbuf);
    let is_function =
      check(lexbuf =>
        switch%sedlex (lexbuf) {
        | '\''
        | '"'
        | interpolation_start => true
        | _ => false
        }
      );
    if (is_function(lexbuf)) {
      Ok(function_token(string));
    } else {
      switch (consume_url(lexbuf)) {
      | Ok(token) => Ok(token)
      | Error(error) => Error(error)
      };
    };
  };

  let.ok string = consume_identifier(lexbuf) |> handle_consume_identifier;

  let next_is_open_paren =
    check(lexbuf =>
      switch%sedlex (lexbuf) {
      | '(' => true
      | _ => false
      }
    );
  if (next_is_open_paren(lexbuf)) {
    let _ =
      switch%sedlex (lexbuf) {
      | '(' => ()
      | _ => ()
      };
    switch (string) {
    | "url" => read_url(string)
    | _ => Ok(function_token(string))
    };
  } else {
    Ok(Tokens.IDENT(string));
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-numeric-token
let consume_numeric = lexbuf => {
  // TODO: kind matters?
  let (number, _kind) = consume_number(lexbuf);
  if (check_if_three_codepoints_would_start_an_identifier(lexbuf)) {
    // TODO: should it be BAD_IDENT?
    let.ok string = consume_identifier(lexbuf) |> handle_consume_identifier;
    Ok(Tokens.DIMENSION((number, string)));
  } else {
    switch%sedlex (lexbuf) {
    | '%' => Ok(PERCENTAGE(number))
    | _ => Ok(NUMBER(number))
    };
  };
};

type interpolation_state = {
  buffer: Buffer.t,
  depth: ref(int),
  brace_depth: ref(int),
  result_str: ref(option(string)),
  content_end: ref(Lexing.position),
  error_opt: ref(option(Tokens.error)),
};

let interpolation_add_char = (state, ch) => {
  Buffer.add_utf_8_uchar(state.buffer, ch);
};

let interpolation_set_error = (state, err) => {
  state.error_opt := Some(err);
};

let interpolation_terminal_error = state =>
  state.brace_depth^ > 0
    ? Tokens.Unclosed_brace_in_interpolation
    : Tokens.Unclosed_interpolation;

let interpolation_store_result = (state, end_pos) => {
  state.content_end := end_pos;
  state.result_str := Some(Buffer.contents(state.buffer));
};

let interpolation_finish = (state, lexbuf) => {
  let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
  interpolation_store_result(
    state,
    {
      ...end_pos,
      pos_cnum: end_pos.pos_cnum - 1,
    },
  );
};

let interpolation_track_nested_code = (state, code) => {
  if (code == 0x0028) {
    state.depth := state.depth^ + 1;
  } else if (code == 0x0029) {
    state.depth := state.depth^ - 1;
  } else if (code == 0x007B) {
    state.brace_depth := state.brace_depth^ + 1;
  } else if (code == 0x007D && state.brace_depth^ > 0) {
    state.brace_depth := state.brace_depth^ - 1;
  };
};

let consume_interpolation_ocaml_comment = (state, lexbuf) => {
  let cdepth = ref(1);
  while (cdepth^ > 0 && state.error_opt^ == None) {
    switch (Sedlexing.next(lexbuf)) {
    | None => interpolation_set_error(state, Tokens.Unclosed_comment_in_interpolation)
    | Some(cc) =>
      interpolation_add_char(state, cc);
      let c = Uchar.to_int(cc);
      if (c == 0x0028) {
        Sedlexing.mark(lexbuf, 0);
        switch (Sedlexing.next(lexbuf)) {
        | None => interpolation_set_error(state, Tokens.Unclosed_comment_in_interpolation)
        | Some(mc) =>
          if (Uchar.to_int(mc) == 0x002A) {
            interpolation_add_char(state, mc);
            cdepth := cdepth^ + 1;
          } else {
            let _ = Sedlexing.backtrack(lexbuf);
            ();
          }
        };
      } else if (c == 0x002A) {
        Sedlexing.mark(lexbuf, 0);
        switch (Sedlexing.next(lexbuf)) {
        | None => interpolation_set_error(state, Tokens.Unclosed_comment_in_interpolation)
        | Some(mc) =>
          if (Uchar.to_int(mc) == 0x0029) {
            interpolation_add_char(state, mc);
            cdepth := cdepth^ - 1;
          } else {
            let _ = Sedlexing.backtrack(lexbuf);
            ();
          }
        };
      };
    };
  };
};

let consume_interpolation_c_style_comment = (state, lexbuf) => {
  let rec read = prev_star =>
    switch (Sedlexing.next(lexbuf)) {
    | None => interpolation_set_error(state, Tokens.Unclosed_comment_in_interpolation)
    | Some(cc) =>
      interpolation_add_char(state, cc);
      if (prev_star && Uchar.to_int(cc) == 0x002F) {
        ();
      } else {
        read(Uchar.to_int(cc) == 0x002A);
      }
    };
  read(false);
};

let consume_interpolation_double_quoted_string = (state, lexbuf) => {
  let in_str = ref(true);
  while (in_str^ && state.error_opt^ == None) {
    switch (Sedlexing.next(lexbuf)) {
    | None => interpolation_set_error(state, Tokens.Unclosed_string_in_interpolation)
    | Some(sc) =>
      interpolation_add_char(state, sc);
      let s = Uchar.to_int(sc);
      if (s == 0x0022) {
        in_str := false;
      } else if (s == 0x005C) {
        switch (Sedlexing.next(lexbuf)) {
        | None => interpolation_set_error(state, Tokens.Unclosed_string_in_interpolation)
        | Some(ec) => interpolation_add_char(state, ec)
        };
      };
    };
  };
};

let consume_interpolation_single_quoted = (state, lexbuf) => {
  switch (Sedlexing.next(lexbuf)) {
  | None => interpolation_set_error(state, Tokens.Unclosed_interpolation)
  | Some(next_ch) =>
    let nc = Uchar.to_int(next_ch);
    if (nc == 0x005C) {
      interpolation_add_char(state, next_ch);
      let in_esc = ref(true);
      while (in_esc^ && state.error_opt^ == None) {
        switch (Sedlexing.next(lexbuf)) {
        | None => interpolation_set_error(state, Tokens.Unclosed_char_in_interpolation)
        | Some(ec) =>
          interpolation_add_char(state, ec);
          if (Uchar.to_int(ec) == 0x0027) {
            in_esc := false;
          };
        };
      };
    } else if (nc == 0x0027) {
      interpolation_add_char(state, next_ch);
    } else {
      Sedlexing.mark(lexbuf, 0);
      switch (Sedlexing.next(lexbuf)) {
      | None =>
        if (nc == 0x0029 && state.depth^ == 1 && state.brace_depth^ == 0) {
          interpolation_finish(state, lexbuf);
        } else {
          interpolation_add_char(state, next_ch);
          interpolation_track_nested_code(state, nc);
          if (state.result_str^ == None && state.error_opt^ == None) {
            interpolation_set_error(state, interpolation_terminal_error(state));
          };
        }
      | Some(third) =>
        let tc = Uchar.to_int(third);
        if (tc == 0x0027) {
          interpolation_add_char(state, next_ch);
          interpolation_add_char(state, third);
        } else if (nc == 0x0029 && state.depth^ == 1 && state.brace_depth^ == 0) {
          let _ = Sedlexing.backtrack(lexbuf);
          let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
          interpolation_store_result(state, end_pos);
        } else {
          interpolation_add_char(state, next_ch);
          interpolation_track_nested_code(state, nc);
          interpolation_add_char(state, third);
          interpolation_track_nested_code(state, tc);
          if (tc == 0x0029 && state.depth^ == 0 && state.brace_depth^ == 0) {
            interpolation_finish(state, lexbuf);
          };
        }
      };
    }
  };
};

let consume_interpolation_open_paren = (state, lexbuf, ch) => {
  Sedlexing.mark(lexbuf, 0);
  switch (Sedlexing.next(lexbuf)) {
  | None => interpolation_set_error(state, Tokens.Unclosed_interpolation)
  | Some(next_ch) =>
    if (Uchar.to_int(next_ch) == 0x002A) {
      interpolation_add_char(state, ch);
      interpolation_add_char(state, next_ch);
      consume_interpolation_ocaml_comment(state, lexbuf);
    } else {
      let _ = Sedlexing.backtrack(lexbuf);
      interpolation_add_char(state, ch);
      state.depth := state.depth^ + 1;
    }
  };
};

let consume_interpolation_close_paren = (state, lexbuf, ch) => {
  state.depth := state.depth^ - 1;
  if (state.depth^ == 0 && state.brace_depth^ == 0) {
    interpolation_finish(state, lexbuf);
  } else {
    interpolation_add_char(state, ch);
  };
};

let consume_interpolation_slash = (state, lexbuf, ch) => {
  Sedlexing.mark(lexbuf, 0);
  switch (Sedlexing.next(lexbuf)) {
  | None => interpolation_set_error(state, Tokens.Unclosed_interpolation)
  | Some(next_ch) =>
    if (Uchar.to_int(next_ch) == 0x002A) {
      interpolation_add_char(state, ch);
      interpolation_add_char(state, next_ch);
      consume_interpolation_c_style_comment(state, lexbuf);
    } else {
      let _ = Sedlexing.backtrack(lexbuf);
      interpolation_add_char(state, ch);
    }
  };
};

let consume_interpolation = lexbuf => {
  let (_, content_start) = Sedlexing.lexing_positions(lexbuf);
  let state: interpolation_state = {
    buffer: Buffer.create(64),
    depth: ref(1),
    brace_depth: ref(0),
    result_str: ref(None),
    content_end: ref(content_start),
    error_opt: ref(None),
  };

  while (state.result_str^ == None && state.error_opt^ == None) {
    switch (Sedlexing.next(lexbuf)) {
    | None => interpolation_set_error(state, interpolation_terminal_error(state))
    | Some(ch) =>
      switch (Uchar.to_int(ch)) {
      | 0x0028 => consume_interpolation_open_paren(state, lexbuf, ch)
      | 0x0029 => consume_interpolation_close_paren(state, lexbuf, ch)
      | 0x007B =>
        state.brace_depth := state.brace_depth^ + 1;
        interpolation_add_char(state, ch)
      | 0x007D =>
        if (state.brace_depth^ > 0) {
          state.brace_depth := state.brace_depth^ - 1;
        };
        interpolation_add_char(state, ch)
      | 0x002F => consume_interpolation_slash(state, lexbuf, ch)
      | 0x0022 =>
        interpolation_add_char(state, ch);
        consume_interpolation_double_quoted_string(state, lexbuf)
      | 0x0027 =>
        interpolation_add_char(state, ch);
        consume_interpolation_single_quoted(state, lexbuf)
      | _ => interpolation_add_char(state, ch)
      }
    };
  };

  switch (state.error_opt^) {
  | Some(err) => Error(err)
  | None =>
    switch (state.result_str^) {
    | Some(expr) =>
      let content_loc = {
        Ppxlib.Location.loc_start: content_start,
        loc_end: state.content_end^,
        loc_ghost: false,
      };
      Ok(Tokens.INTERPOLATION((expr, content_loc)));
    | None => Error(Tokens.Unclosed_interpolation)
    }
  };
};

let rec consume_token = lexbuf => {
  let consume_hash = () =>
    switch%sedlex (lexbuf) {
    | identifier_code_point
    | starts_with_a_valid_escape =>
      Sedlexing.rollback(lexbuf);
      switch%sedlex (lexbuf) {
      | identifier_start_code_point =>
        Sedlexing.rollback(lexbuf);
        let.ok string =
          consume_identifier(lexbuf) |> handle_consume_identifier;
        Ok(Tokens.HASH((string, `ID)));
      | _ =>
        let.ok string =
          consume_identifier(lexbuf) |> handle_consume_identifier;
        Ok(Tokens.HASH((string, `UNRESTRICTED)));
      };
    | _ => Ok(DELIM("#"))
    };

  let consume_minus = () =>
    switch%sedlex (lexbuf) {
    | starts_a_number =>
      Sedlexing.rollback(lexbuf);
      consume_numeric(lexbuf);
    | starts_an_identifier =>
      Sedlexing.rollback(lexbuf);
      scan_ident_like(lexbuf);
    | _ =>
      let _ = Sedlexing.next(lexbuf);
      Ok(DELIM("-"));
    };

  let rec discard_comments = lexbuf => {
    let (start_pos, curr_pos) = Sedlexing.lexing_positions(lexbuf);
    switch%sedlex (lexbuf) {
    | "*/" => consume_token(lexbuf)
    | any => discard_comments(lexbuf)
    | eof =>
      raise(
        LexingError((
          start_pos,
          curr_pos,
          "Unterminated comment at the end of the string",
        )),
      )
    | _ => consume_token(lexbuf)
    };
  };

  let emit_delim = s => Ok(Tokens.DELIM(s));

  switch%sedlex (lexbuf) {
  | whitespace =>
    let _ = skip_whitespace_and_comments(lexbuf);
    Ok(Tokens.WS);
  | important => Ok(IMPORTANT)
  | interpolation_start => consume_interpolation(lexbuf)
  | "/*" => discard_comments(lexbuf)
  | "\"" => consume_string("\"", lexbuf)
  | "#" =>
    let.ok token = consume_hash();
    Ok(token);
  | "'" => consume_string("'", lexbuf)
  | "(" => Ok(LEFT_PAREN)
  | ")" => Ok(RIGHT_PAREN)
  | "+" =>
    let _ = Sedlexing.backtrack(lexbuf);
    if (check_if_three_code_points_would_start_a_number(lexbuf)) {
      consume_numeric(lexbuf);
    } else {
      let _ = Sedlexing.next(lexbuf);
      emit_delim("+");
    };
  | "," => Ok(COMMA)
  | "-" =>
    Sedlexing.rollback(lexbuf);
    consume_minus();
  | "." =>
    let _ = Sedlexing.backtrack(lexbuf);
    if (check_if_three_code_points_would_start_a_number(lexbuf)) {
      consume_numeric(lexbuf);
    } else {
      let _ = Sedlexing.next(lexbuf);
      Ok(DELIM("."));
    };
  | "::" => Ok(DOUBLE_COLON)
  | ":" => Ok(COLON)
  | ";" => Ok(SEMI_COLON)
  | "&" => Ok(DELIM("&"))
  | "*" => Ok(DELIM("*"))
  | "<=" => Ok(DELIM("<="))
  | ">=" => Ok(DELIM(">="))
  | "<" => Ok(DELIM("<"))
  | "@" =>
    if (check_if_three_codepoints_would_start_an_identifier(lexbuf)) {
      let.ok string = consume_identifier(lexbuf) |> handle_consume_identifier;
      let token =
        switch (string) {
        | "keyframes" => Tokens.AT_KEYFRAMES(string)
        | "charset"
        | "import"
        | "namespace" => Tokens.AT_RULE_STATEMENT(string)
        | _ => Tokens.AT_RULE(string)
        };
      Ok(token);
    } else {
      Ok(DELIM("@"));
    }
  | "[" => Ok(LEFT_BRACKET)
  | "]" => Ok(RIGHT_BRACKET)
  | "{" => Ok(LEFT_BRACE)
  | "}" => Ok(RIGHT_BRACE)
  | "\\" =>
    Sedlexing.rollback(lexbuf);
    switch%sedlex (lexbuf) {
    | starts_with_a_valid_escape =>
      Sedlexing.rollback(lexbuf);
      scan_ident_like(lexbuf);
    | ('\\', any)
    | '\\' => Error(Invalid_code_point)
    | _ => unreachable(lexbuf)
    };
  | (_u, '+', unicode_range) => Ok(UNICODE_RANGE(lexeme(lexbuf)))
  | digit =>
    let _ = Sedlexing.backtrack(lexbuf);
    consume_numeric(lexbuf);
  | identifier_start_code_point =>
    let _ = Sedlexing.backtrack(lexbuf);
    scan_ident_like(lexbuf);
  | eof => Ok(EOF)
  | any => emit_delim(lexeme(lexbuf))
  | _ => unreachable(lexbuf)
  };
};

let next_token_with_location = lexbuf => {
  let (_, position_start) = Sedlexing.lexing_positions(lexbuf);
  let value = consume_token(lexbuf);
  let (_, position_end) = Sedlexing.lexing_positions(lexbuf);
  {
    txt: value,
    start_pos: position_start,
    end_pos: position_end,
  };
};
let from_string = string => {
  let lexbuf = Sedlexing.Utf8.from_string(string);
  let rec read = acc => {
    let token_with_loc = next_token_with_location(lexbuf);
    let acc = [token_with_loc, ...acc];
    switch (token_with_loc.txt) {
    | Ok(Tokens.EOF) => List.rev(acc)
    | _ => read(acc)
    };
  };

  read([]);
};

let format_position = pos =>
  Printf.sprintf(
    "[%d,%d+%d]",
    pos.Lexing.pos_lnum,
    pos.Lexing.pos_bol,
    pos.Lexing.pos_cnum - pos.Lexing.pos_bol,
  );

let format_token_with_location = ((token, loc_start, loc_end)) =>
  Printf.sprintf(
    "%s %s..%s",
    Tokens.to_debug(token),
    format_position(loc_start),
    format_position(loc_end),
  );

let debug = tokens =>
  tokens
  |> List.map(format_token_with_location)
  |> String.concat("\n")
  |> String.trim;
