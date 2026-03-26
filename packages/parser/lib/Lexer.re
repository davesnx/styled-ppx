/** CSS lexer
  * Reference:
  * https://www.w3.org/TR/css-syntax-3/ */
module Types = Ast;
module Location = Ppxlib.Location;

open Tokens;
open Lexer_context;

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

// https://drafts.csswg.org/css-syntax-3/#consume-ident-like-token
let function_token: string => Tokens.token =
  fun
  | ("nth-last-child" | "nth-child" | "nth-of-type" | "nth-last-of-type") as name =>
    NTH_FUNCTION(name)
  | name => FUNCTION(name);

let scan_unclassified_ident_like = lexbuf => {
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
      Ok(Unclassified_token(function_token(string)));
    } else {
      switch (consume_url(lexbuf)) {
      | Ok(token) => Ok(Unclassified_token(token))
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
    | _ => Ok(Unclassified_token(function_token(string)))
    };
  } else {
    Ok(Unclassified_ident(string));
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

let consume_interpolation = lexbuf => {
  let (_, content_start) = Sedlexing.lexing_positions(lexbuf);
  let buffer = Buffer.create(64);
  let depth = ref(1);
  let brace_depth = ref(0);
  let result_str = ref(None);
  let content_end = ref(content_start);
  let error_opt: ref(option(Tokens.error)) = ref(None);

  let set_error = err => {
    error_opt := Some(err);
  };

  let consume_ocaml_comment = () => {
    let cdepth = ref(1);
    while (cdepth^ > 0 && error_opt^ == None) {
      switch (Sedlexing.next(lexbuf)) {
      | None => set_error(Tokens.Unclosed_comment_in_interpolation)
      | Some(cc) =>
        Buffer.add_utf_8_uchar(buffer, cc);
        let c = Uchar.to_int(cc);
        if (c == 0x0028) {
          Sedlexing.mark(lexbuf, 0);
          switch (Sedlexing.next(lexbuf)) {
          | None => set_error(Tokens.Unclosed_comment_in_interpolation)
          | Some(mc) =>
            let mc_code = Uchar.to_int(mc);
            if (mc_code == 0x002A) {
              Buffer.add_utf_8_uchar(buffer, mc);
              cdepth := cdepth^ + 1;
            } else {
              let _ = Sedlexing.backtrack(lexbuf);
              ();
            };
          };
        } else if (c == 0x002A) {
          Sedlexing.mark(lexbuf, 0);
          switch (Sedlexing.next(lexbuf)) {
          | None => set_error(Tokens.Unclosed_comment_in_interpolation)
          | Some(mc) =>
            let mc_code = Uchar.to_int(mc);
            if (mc_code == 0x0029) {
              Buffer.add_utf_8_uchar(buffer, mc);
              cdepth := cdepth^ - 1;
            } else {
              let _ = Sedlexing.backtrack(lexbuf);
              ();
            };
          };
        };
      };
    };
  };

  let consume_c_style_comment = () => {
    let rec read = prev_star =>
      switch (Sedlexing.next(lexbuf)) {
      | None => set_error(Tokens.Unclosed_comment_in_interpolation)
      | Some(cc) =>
        Buffer.add_utf_8_uchar(buffer, cc);
        let c = Uchar.to_int(cc);
        if (prev_star && c == 0x002F) {
          ();
        } else {
          read(c == 0x002A);
        };
      };
    read(false);
  };

  while (result_str^ == None && error_opt^ == None) {
    switch (Sedlexing.next(lexbuf)) {
    | None =>
      set_error(
        brace_depth^ > 0
          ? Tokens.Unclosed_brace_in_interpolation
          : Tokens.Unclosed_interpolation,
      )
    | Some(ch) =>
      let code = Uchar.to_int(ch);
      switch (code) {
      | 0x0028 =>
        Sedlexing.mark(lexbuf, 0);
        switch (Sedlexing.next(lexbuf)) {
        | None => set_error(Tokens.Unclosed_interpolation)
        | Some(next_ch) =>
          let nc = Uchar.to_int(next_ch);
          if (nc == 0x002A) {
            Buffer.add_utf_8_uchar(buffer, ch);
            Buffer.add_utf_8_uchar(buffer, next_ch);
            consume_ocaml_comment();
          } else {
            let _ = Sedlexing.backtrack(lexbuf);
            Buffer.add_utf_8_uchar(buffer, ch);
            depth := depth^ + 1;
          };
        };
      | 0x0029 =>
        depth := depth^ - 1;
        if (depth^ == 0 && brace_depth^ == 0) {
          let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
          content_end :=
            {
              ...end_pos,
              pos_cnum: end_pos.pos_cnum - 1,
            };
          result_str := Some(Buffer.contents(buffer));
        } else {
          Buffer.add_utf_8_uchar(buffer, ch);
        };
      | 0x007B =>
        brace_depth := brace_depth^ + 1;
        Buffer.add_utf_8_uchar(buffer, ch);
      | 0x007D =>
        if (brace_depth^ > 0) {
          brace_depth := brace_depth^ - 1;
        };
        Buffer.add_utf_8_uchar(buffer, ch);
      | 0x002F =>
        Sedlexing.mark(lexbuf, 0);
        switch (Sedlexing.next(lexbuf)) {
        | None => set_error(Tokens.Unclosed_interpolation)
        | Some(next_ch) =>
          let nc = Uchar.to_int(next_ch);
          if (nc == 0x002A) {
            Buffer.add_utf_8_uchar(buffer, ch);
            Buffer.add_utf_8_uchar(buffer, next_ch);
            consume_c_style_comment();
          } else {
            let _ = Sedlexing.backtrack(lexbuf);
            Buffer.add_utf_8_uchar(buffer, ch);
          };
        };
      | 0x0022 =>
        Buffer.add_utf_8_uchar(buffer, ch);
        let in_str = ref(true);
        while (in_str^ && error_opt^ == None) {
          switch (Sedlexing.next(lexbuf)) {
          | None => set_error(Tokens.Unclosed_string_in_interpolation)
          | Some(sc) =>
            Buffer.add_utf_8_uchar(buffer, sc);
            let s = Uchar.to_int(sc);
            if (s == 0x0022) {
              in_str := false;
            } else if (s == 0x005C) {
              switch (Sedlexing.next(lexbuf)) {
              | None => set_error(Tokens.Unclosed_string_in_interpolation)
              | Some(ec) => Buffer.add_utf_8_uchar(buffer, ec)
              };
            };
          };
        };
      | 0x0027 =>
        Buffer.add_utf_8_uchar(buffer, ch);
        switch (Sedlexing.next(lexbuf)) {
        | None => set_error(Tokens.Unclosed_interpolation)
        | Some(next_ch) =>
          let nc = Uchar.to_int(next_ch);
          if (nc == 0x005C) {
            Buffer.add_utf_8_uchar(buffer, next_ch);
            let in_esc = ref(true);
            while (in_esc^ && error_opt^ == None) {
              switch (Sedlexing.next(lexbuf)) {
              | None => set_error(Tokens.Unclosed_char_in_interpolation)
              | Some(ec) =>
                Buffer.add_utf_8_uchar(buffer, ec);
                if (Uchar.to_int(ec) == 0x0027) {
                  in_esc := false;
                };
              };
            };
          } else if (nc == 0x0027) {
            Buffer.add_utf_8_uchar(buffer, next_ch);
          } else {
            Sedlexing.mark(lexbuf, 0);
            switch (Sedlexing.next(lexbuf)) {
            | None =>
              if (nc == 0x0029 && depth^ == 1 && brace_depth^ == 0) {
                let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
                content_end :=
                  {
                    ...end_pos,
                    pos_cnum: end_pos.pos_cnum - 1,
                  };
                result_str := Some(Buffer.contents(buffer));
              } else {
                Buffer.add_utf_8_uchar(buffer, next_ch);
                if (nc == 0x0028) {
                  depth := depth^ + 1;
                } else if (nc == 0x0029) {
                  depth := depth^ - 1;
                } else if (nc == 0x007B) {
                  brace_depth := brace_depth^ + 1;
                } else if (nc == 0x007D && brace_depth^ > 0) {
                  brace_depth := brace_depth^ - 1;
                };
                if (result_str^ == None && error_opt^ == None) {
                  set_error(
                    brace_depth^ > 0
                      ? Tokens.Unclosed_brace_in_interpolation
                      : Tokens.Unclosed_interpolation,
                  );
                };
              }
            | Some(third) =>
              let tc = Uchar.to_int(third);
              if (tc == 0x0027) {
                Buffer.add_utf_8_uchar(buffer, next_ch);
                Buffer.add_utf_8_uchar(buffer, third);
              } else if (nc == 0x0029 && depth^ == 1 && brace_depth^ == 0) {
                let _ = Sedlexing.backtrack(lexbuf);
                let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
                content_end := end_pos;
                result_str := Some(Buffer.contents(buffer));
              } else {
                Buffer.add_utf_8_uchar(buffer, next_ch);
                if (nc == 0x0028) {
                  depth := depth^ + 1;
                } else if (nc == 0x0029) {
                  depth := depth^ - 1;
                } else if (nc == 0x007B) {
                  brace_depth := brace_depth^ + 1;
                } else if (nc == 0x007D && brace_depth^ > 0) {
                  brace_depth := brace_depth^ - 1;
                };
                Buffer.add_utf_8_uchar(buffer, third);
                if (tc == 0x0028) {
                  depth := depth^ + 1;
                } else if (tc == 0x0029) {
                  depth := depth^ - 1;
                  if (depth^ == 0 && brace_depth^ == 0) {
                    let (_, end_pos) = Sedlexing.lexing_positions(lexbuf);
                    content_end :=
                      {
                        ...end_pos,
                        pos_cnum: end_pos.pos_cnum - 1,
                      };
                    result_str := Some(Buffer.contents(buffer));
                  };
                } else if (tc == 0x007B) {
                  brace_depth := brace_depth^ + 1;
                } else if (tc == 0x007D && brace_depth^ > 0) {
                  brace_depth := brace_depth^ - 1;
                };
              };
            };
          };
        };
      | _ => Buffer.add_utf_8_uchar(buffer, ch)
      };
    };
  };

  switch (error_opt^) {
  | Some(err) => Error(err)
  | None =>
    switch (result_str^) {
    | Some(expr) =>
      let content_loc = {
        Ppxlib.Location.loc_start: content_start,
        loc_end: content_end^,
        loc_ghost: false,
      };
      Ok(Tokens.INTERPOLATION((expr, content_loc)));
    | None => Error(Tokens.Unclosed_interpolation)
    }
  };
};

let rec consume_unclassified = lexbuf => {
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
    | _ => Ok(DELIM('#'))
    };

  let wrap_unclassified_token =
    fun
    | Ok(token) => Ok(Unclassified_token(token))
    | Error(msg) => Error(msg);

  let consume_minus = () =>
    switch%sedlex (lexbuf) {
    | starts_a_number =>
      Sedlexing.rollback(lexbuf);
      consume_numeric(lexbuf) |> wrap_unclassified_token;
    | starts_an_identifier =>
      Sedlexing.rollback(lexbuf);
      scan_unclassified_ident_like(lexbuf);
    | _ =>
      let _ = Sedlexing.next(lexbuf);
      Ok(Unclassified_token(MINUS));
    };

  let rec discard_comments = lexbuf => {
    let (start_pos, curr_pos) = Sedlexing.lexing_positions(lexbuf);
    switch%sedlex (lexbuf) {
    | "*/" => consume_unclassified(lexbuf)
    | any => discard_comments(lexbuf)
    | eof =>
      raise(
        LexingError((
          start_pos,
          curr_pos,
          "Unterminated comment at the end of the string",
        )),
      )
    | _ => consume_unclassified(lexbuf)
    };
  };

  let emit_delim = char_string => {
    switch (Tokens.token_of_delimiter_string(char_string)) {
    | Some(token) => Ok(Unclassified_token(token))
    | None => Error(Tokens.Invalid_delim)
    };
  };

  switch%sedlex (lexbuf) {
  | whitespace =>
    let _ = skip_whitespace_and_comments(lexbuf);
    Ok(Unclassified_whitespace)
  | important => Ok(Unclassified_token(IMPORTANT))
  | interpolation_start => consume_interpolation(lexbuf) |> wrap_unclassified_token
  | "/*" => discard_comments(lexbuf)
  | "\"" => consume_string("\"", lexbuf) |> wrap_unclassified_token
  | "#" =>
    let.ok token = consume_hash();
    Ok(Unclassified_token(token))
  | "'" => consume_string("'", lexbuf) |> wrap_unclassified_token
  | "(" => Ok(Unclassified_token(LEFT_PAREN))
  | ")" => Ok(Unclassified_token(RIGHT_PAREN))
  | "+" =>
    let _ = Sedlexing.backtrack(lexbuf);
    if (check_if_three_code_points_would_start_a_number(lexbuf)) {
      consume_numeric(lexbuf) |> wrap_unclassified_token;
    } else {
      let _ = Sedlexing.next(lexbuf);
      emit_delim("+");
    }
  | "," => Ok(Unclassified_token(COMMA))
  | "-" =>
    Sedlexing.rollback(lexbuf);
    consume_minus()
  | "." =>
    let _ = Sedlexing.backtrack(lexbuf);
    if (check_if_three_code_points_would_start_a_number(lexbuf)) {
      consume_numeric(lexbuf) |> wrap_unclassified_token;
    } else {
      let _ = Sedlexing.next(lexbuf);
      Ok(Unclassified_token(DOT));
    }
  | "::" => Ok(Unclassified_token(DOUBLE_COLON))
  | ":" => Ok(Unclassified_token(COLON))
  | ";" => Ok(Unclassified_token(SEMI_COLON))
  | "&" => Ok(Unclassified_token(AMPERSAND))
  | "*" => Ok(Unclassified_token(ASTERISK))
  | "<=" => Ok(Unclassified_token(LTE))
  | ">=" => Ok(Unclassified_token(GTE))
  | "<" => Ok(Unclassified_token(LESS_THAN))
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
      Ok(Unclassified_token(token));
    } else {
      Ok(Unclassified_token(DELIM('@')));
    }
  | "[" => Ok(Unclassified_token(LEFT_BRACKET))
  | "]" => Ok(Unclassified_token(RIGHT_BRACKET))
  | "{" => Ok(Unclassified_token(LEFT_BRACE))
  | "}" => Ok(Unclassified_token(RIGHT_BRACE))
  | "\\" =>
    Sedlexing.rollback(lexbuf);
    switch%sedlex (lexbuf) {
    | starts_with_a_valid_escape =>
      Sedlexing.rollback(lexbuf);
      scan_unclassified_ident_like(lexbuf)
    | ('\\', any)
    | '\\' => Error(Invalid_code_point)
    | _ => unreachable(lexbuf)
    }
  | (_u, '+', unicode_range) => Ok(Unclassified_token(UNICODE_RANGE(lexeme(lexbuf))))
  | digit =>
    let _ = Sedlexing.backtrack(lexbuf);
    consume_numeric(lexbuf) |> wrap_unclassified_token
  | identifier_start_code_point =>
    let _ = Sedlexing.backtrack(lexbuf);
    scan_unclassified_ident_like(lexbuf)
  | eof => Ok(Unclassified_token(EOF))
  | any => emit_delim(lexeme(lexbuf))
  | _ => unreachable(lexbuf)
  };
};

let next_unclassified_token_with_location = lexbuf => {
  let (_, position_start) = Sedlexing.lexing_positions(lexbuf);
  let value = consume_unclassified(lexbuf);
  let (_, position_end) = Sedlexing.lexing_positions(lexbuf);
  {txt: value, start_pos: position_start, end_pos: position_end};
};

let ensure_unclassified_buffer = (~state, lexbuf) => {
  if (Queue.is_empty(state.unclassified_buffer)) {
    Queue.add(next_unclassified_token_with_location(lexbuf), state.unclassified_buffer);
  };
};

let take_unclassified_token = (~state, lexbuf) => {
  ensure_unclassified_buffer(~state, lexbuf);
  Queue.take(state.unclassified_buffer);
};

let peek_unclassified_token = (~state, lexbuf) => {
  ensure_unclassified_buffer(~state, lexbuf);
  Queue.peek(state.unclassified_buffer);
};

let copy_queue = queue => {
  let copy = Queue.create();
  Queue.iter(item => Queue.add(item, copy), queue);
  copy;
};

/* Lookahead should not mutate lexer state, so probe from a copy and mirror
   newly lexed items back into the shared buffer. */
let make_unclassified_reader = (~state, lexbuf) => {
  let buffered_probe = copy_queue(state.unclassified_buffer);
  () => {
    if (Queue.is_empty(buffered_probe)) {
      let next = next_unclassified_token_with_location(lexbuf);
      Queue.add(next, state.unclassified_buffer);
      Queue.add(next, buffered_probe);
    };
    Queue.take(buffered_probe);
  };
};

let unclassified_token_starts_selector =
  fun
  | Unclassified_ident(_) => true
  | Unclassified_token(
      DOT
      | HASH(_)
      | AMPERSAND
      | ASTERISK
      | COLON
      | DOUBLE_COLON
      | LEFT_BRACKET
      | INTERPOLATION(_)
    ) => true
  | Unclassified_token(_)
  | Unclassified_whitespace => false;

let unclassified_token_starts_nested_block =
  fun
  | Unclassified_token(
      AT_RULE(_)
      | AT_KEYFRAMES(_)
    ) => true
  | Unclassified_ident(_)
  | Unclassified_token(_)
  | Unclassified_whitespace => false;

let unclassified_token_starts_selector_prelude =
  fun
  | Unclassified_ident(_) => true
  | Unclassified_token(
      AMPERSAND
      | DOT
      | HASH(_)
      | ASTERISK
      | LEFT_BRACKET
      | INTERPOLATION(_)
    ) => true
  | Unclassified_token(_)
  | Unclassified_whitespace => false;

let known_pseudo_ident =
  fun
  | "active"
  | "any-link"
  | "autofill"
  | "checked"
  | "defined"
  | "disabled"
  | "empty"
  | "enabled"
  | "first-child"
  | "first-of-type"
  | "focus"
  | "focus-visible"
  | "focus-within"
  | "fullscreen"
  | "future"
  | "hover"
  | "in-range"
  | "indeterminate"
  | "invalid"
  | "last-child"
  | "last-of-type"
  | "link"
  | "modal"
  | "only-child"
  | "only-of-type"
  | "optional"
  | "out-of-range"
  | "past"
  | "paused"
  | "picture-in-picture"
  | "placeholder-shown"
  | "playing"
  | "popover-open"
  | "read-only"
  | "read-write"
  | "required"
  | "root"
  | "scope"
  | "target"
  | "user-invalid"
  | "valid"
  | "visited" => true
  | _ => false;

let known_pseudo_function =
  fun
  | "current"
  | "dir"
  | "has"
  | "host"
  | "host-context"
  | "is"
  | "lang"
  | "not"
  | "nth-col"
  | "nth-last-col"
  | "part"
  | "slotted"
  | "state"
  | "where" => true
  | _ => false;

let unclassified_token_starts_selector_pseudo =
  fun
  | Unclassified_ident(name) => known_pseudo_ident(name)
  | Unclassified_token(FUNCTION(name)) => known_pseudo_function(name)
  | Unclassified_token(NTH_FUNCTION(_))
  | Unclassified_token(COLON)
  | Unclassified_token(DOUBLE_COLON) => true
  | Unclassified_token(_)
  | Unclassified_whitespace => false;

let nested_block_follows = (~state, lexbuf, ~initial_paren_depth, ~initial_bracket_depth) => {
  let read_unclassified = make_unclassified_reader(~state, lexbuf);

  let rec scan = (~paren_depth, ~bracket_depth) => {
    let unclassified = read_unclassified();
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace)
    | Ok(Unclassified_ident(_)) => scan(~paren_depth, ~bracket_depth)
    | Ok(Unclassified_token(token)) =>
      switch (token) {
      | FUNCTION(_)
      | NTH_FUNCTION(_) =>
        scan(~paren_depth=paren_depth + 1, ~bracket_depth)
      | LEFT_PAREN => scan(~paren_depth=paren_depth + 1, ~bracket_depth)
      | RIGHT_PAREN =>
        let next_paren_depth = paren_depth > 0 ? paren_depth - 1 : 0;
        scan(~paren_depth=next_paren_depth, ~bracket_depth)
      | LEFT_BRACKET => scan(~paren_depth, ~bracket_depth=bracket_depth + 1)
      | RIGHT_BRACKET =>
        let next_bracket_depth = bracket_depth > 0 ? bracket_depth - 1 : 0;
        scan(~paren_depth, ~bracket_depth=next_bracket_depth)
      | LEFT_BRACE => paren_depth == 0 && bracket_depth == 0
      | SEMI_COLON
      | RIGHT_BRACE
      | EOF => false
      | _ => scan(~paren_depth, ~bracket_depth)
      }
    | Error(_) => false
    };
  };

  scan(~paren_depth=initial_paren_depth, ~bracket_depth=initial_bracket_depth);
};

let selector_prelude_follows = (~state, lexbuf) => {
  let read_unclassified = make_unclassified_reader(~state, lexbuf);

  let rec scan = (~paren_depth, ~bracket_depth, ~saw_selector_token) => {
    let unclassified = read_unclassified();
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace) =>
      scan(~paren_depth, ~bracket_depth, ~saw_selector_token)
    | Ok(Unclassified_ident(_)) =>
      scan(~paren_depth, ~bracket_depth, ~saw_selector_token=true)
    | Ok(Unclassified_token(token)) =>
      if (paren_depth > 0 || bracket_depth > 0) {
        switch (token) {
        | FUNCTION(_)
        | NTH_FUNCTION(_)
        | LEFT_PAREN =>
          scan(~paren_depth=paren_depth + 1, ~bracket_depth, ~saw_selector_token)
        | RIGHT_PAREN =>
          let next_paren_depth = paren_depth > 0 ? paren_depth - 1 : 0;
          scan(~paren_depth=next_paren_depth, ~bracket_depth, ~saw_selector_token)
        | LEFT_BRACKET =>
          scan(~paren_depth, ~bracket_depth=bracket_depth + 1, ~saw_selector_token)
        | RIGHT_BRACKET =>
          let next_bracket_depth = bracket_depth > 0 ? bracket_depth - 1 : 0;
          scan(~paren_depth, ~bracket_depth=next_bracket_depth, ~saw_selector_token)
        | LEFT_BRACE
        | RIGHT_BRACE
        | SEMI_COLON
        | EOF => false
        | _ => scan(~paren_depth, ~bracket_depth, ~saw_selector_token)
        }
      } else {
        switch (token) {
        | LEFT_BRACE => saw_selector_token
        | FUNCTION(_)
        | NTH_FUNCTION(_) when saw_selector_token =>
          scan(~paren_depth=paren_depth + 1, ~bracket_depth, ~saw_selector_token=true)
        | LEFT_BRACKET =>
          scan(~paren_depth, ~bracket_depth=bracket_depth + 1, ~saw_selector_token=true)
        | DOT
        | HASH(_)
        | AMPERSAND
        | ASTERISK
        | COLON
        | DOUBLE_COLON
        | INTERPOLATION(_)
        | GREATER_THAN
        | PLUS
        | TILDE
        | COMMA =>
          scan(~paren_depth, ~bracket_depth, ~saw_selector_token=true)
        | SEMI_COLON
        | RIGHT_BRACE
        | EOF => false
        | _ => false
        }
      }
    | Error(_) => false
    };
  };

  scan(~paren_depth=0, ~bracket_depth=0, ~saw_selector_token=false);
};

let declaration_value_starts_nested_block = (~state, lexbuf) => {
  if (
    state.paren_depth > 0
    || state.bracket_depth > 0
    || !state.declaration_value_allows_implicit_nested_terminator
    || !state.declaration_value_has_content
  ) {
    false;
  } else {
    let read_unclassified = make_unclassified_reader(~state, lexbuf);
    let rec read_next_significant = () => {
      let unclassified = read_unclassified();
      switch (unclassified.txt) {
      | Ok(Unclassified_whitespace) => read_next_significant()
      | _ => unclassified
      };
    };
    let next_unclassified = read_next_significant();
    switch (next_unclassified.txt) {
    | Ok(Unclassified_token(INTERPOLATION(_))) => false
    | Ok(unclassified_token)
        when unclassified_token_starts_nested_block(unclassified_token) =>
      let (initial_paren_depth, initial_bracket_depth) =
        switch (unclassified_token) {
        | Unclassified_token(LEFT_BRACKET) => (0, 1)
        | _ => (0, 0)
        };
      nested_block_follows(
        ~state,
        lexbuf,
        ~initial_paren_depth,
        ~initial_bracket_depth,
      )
    | Ok(unclassified_token)
        when unclassified_token_starts_selector_prelude(unclassified_token)
             && (
               switch (unclassified_token) {
               | Unclassified_ident(_) =>
                 state.declaration_value_top_level_items == 1
                 && state.declaration_value_ident_like_prefix
               | _ => true
               }
             ) =>
      selector_prelude_follows(~state, lexbuf)
    | _ => false
    };
  };
};

let identifier_starts_property = (~state, lexbuf) => {
  let read_unclassified = make_unclassified_reader(~state, lexbuf);

  let rec read_next_significant = () => {
    let unclassified = read_unclassified();
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace) => read_next_significant()
    | _ => unclassified
    };
  };

  let rec scan_possible_nested_block = (
    ~paren_depth,
    ~bracket_depth,
    ~fallback_top_level_items,
    ~fallback_ident_like_prefix,
    ~fallback_selector_pseudo_prefix,
  ) => {
    let unclassified = read_unclassified();
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace) =>
      scan_possible_nested_block(
        ~paren_depth,
        ~bracket_depth,
        ~fallback_top_level_items,
        ~fallback_ident_like_prefix,
        ~fallback_selector_pseudo_prefix,
      )
    | Ok(Unclassified_ident(_)) =>
      scan_possible_nested_block(
        ~paren_depth,
        ~bracket_depth,
        ~fallback_top_level_items,
        ~fallback_ident_like_prefix,
        ~fallback_selector_pseudo_prefix,
      )
    | Ok(Unclassified_token(token)) =>
      if (paren_depth > 0 || bracket_depth > 0) {
        switch (token) {
        | FUNCTION(_)
        | NTH_FUNCTION(_)
        | LEFT_PAREN =>
          scan_possible_nested_block(
            ~paren_depth=paren_depth + 1,
            ~bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | RIGHT_PAREN =>
          let next_paren_depth = paren_depth > 0 ? paren_depth - 1 : 0;
          scan_possible_nested_block(
            ~paren_depth=next_paren_depth,
            ~bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | LEFT_BRACKET =>
          scan_possible_nested_block(
            ~paren_depth,
            ~bracket_depth=bracket_depth + 1,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | RIGHT_BRACKET =>
          let next_bracket_depth = bracket_depth > 0 ? bracket_depth - 1 : 0;
          scan_possible_nested_block(
            ~paren_depth,
            ~bracket_depth=next_bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | LEFT_BRACE
        | RIGHT_BRACE
        | SEMI_COLON
        | EOF => true
        | _ =>
          scan_possible_nested_block(
            ~paren_depth,
            ~bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        }
      } else {
        switch (token) {
        | LEFT_BRACE => true
        | FUNCTION(_)
        | NTH_FUNCTION(_) =>
          scan_possible_nested_block(
            ~paren_depth=paren_depth + 1,
            ~bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | LEFT_BRACKET =>
          scan_possible_nested_block(
            ~paren_depth,
            ~bracket_depth=bracket_depth + 1,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | DOT
        | HASH(_)
        | AMPERSAND
        | ASTERISK
        | COLON
        | DOUBLE_COLON
        | INTERPOLATION(_)
        | GREATER_THAN
        | PLUS
        | TILDE
        | COMMA =>
          scan_possible_nested_block(
            ~paren_depth,
            ~bracket_depth,
            ~fallback_top_level_items,
            ~fallback_ident_like_prefix,
            ~fallback_selector_pseudo_prefix,
          )
        | SEMI_COLON
        | RIGHT_BRACE
        | EOF => true
        | _ =>
          scan_property_value(
            ~paren_depth,
            ~bracket_depth,
            ~has_value=true,
            ~top_level_items=fallback_top_level_items,
            ~ident_like_prefix=fallback_ident_like_prefix,
            ~selector_pseudo_prefix=fallback_selector_pseudo_prefix,
          )
        }
      }
    | Error(_) => true
    };
  }
  and scan_property_value = (
    ~paren_depth,
    ~bracket_depth,
    ~has_value,
    ~top_level_items,
    ~ident_like_prefix,
    ~selector_pseudo_prefix,
  ) => {
    let unclassified = read_unclassified();
    let at_top_level = paren_depth == 0 && bracket_depth == 0;
    let remember_top_level_item = (~is_ident_like) =>
      if (at_top_level) {
        let next_top_level_items = top_level_items + 1;
        let next_ident_like_prefix =
          next_top_level_items == 1 ? is_ident_like : ident_like_prefix;
        (next_top_level_items, next_ident_like_prefix);
      } else {
        (top_level_items, ident_like_prefix);
      };
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace) =>
      scan_property_value(
        ~paren_depth,
        ~bracket_depth,
        ~has_value,
        ~top_level_items,
        ~ident_like_prefix,
        ~selector_pseudo_prefix,
      )
    | Ok(Unclassified_ident(name)) =>
      let next_selector_pseudo_prefix =
        !has_value && at_top_level && known_pseudo_ident(name)
          ? true
          : selector_pseudo_prefix;
      if (
        has_value
        && at_top_level
        && !next_selector_pseudo_prefix
        && top_level_items == 1
        && ident_like_prefix
      ) {
        scan_possible_nested_block(
          ~paren_depth=0,
          ~bracket_depth=0,
          ~fallback_top_level_items=top_level_items + 1,
          ~fallback_ident_like_prefix=ident_like_prefix,
          ~fallback_selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      } else {
        let (next_top_level_items, next_ident_like_prefix) =
          remember_top_level_item(~is_ident_like=true);
        scan_property_value(
          ~paren_depth,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items=next_top_level_items,
          ~ident_like_prefix=next_ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      }
    | Ok(Unclassified_token(token)) =>
      let next_selector_pseudo_prefix =
        !has_value && at_top_level
        && unclassified_token_starts_selector_pseudo(Unclassified_token(token))
          ? true
          : selector_pseudo_prefix;
      switch (token) {
      | FUNCTION(_)
      | NTH_FUNCTION(_) =>
        let (next_top_level_items, next_ident_like_prefix) =
          remember_top_level_item(~is_ident_like=false);
        scan_property_value(
          ~paren_depth=paren_depth + 1,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items=next_top_level_items,
          ~ident_like_prefix=next_ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | token when has_value && at_top_level && !selector_pseudo_prefix
          && unclassified_token_starts_selector_prelude(Unclassified_token(token)) =>
        scan_possible_nested_block(
          ~paren_depth=0,
          ~bracket_depth=0,
          ~fallback_top_level_items=top_level_items,
          ~fallback_ident_like_prefix=ident_like_prefix,
          ~fallback_selector_pseudo_prefix=selector_pseudo_prefix,
        )
      | NUMBER(_)
      | PERCENTAGE(_)
      | DIMENSION(_)
      | HASH(_)
      | STRING(_)
      | URL(_)
      | INTERPOLATION(_) =>
        let (next_top_level_items, next_ident_like_prefix) =
          remember_top_level_item(~is_ident_like=false);
        scan_property_value(
          ~paren_depth,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items=next_top_level_items,
          ~ident_like_prefix=next_ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | LEFT_PAREN =>
        scan_property_value(
          ~paren_depth=paren_depth + 1,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items,
          ~ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | RIGHT_PAREN =>
        let next_paren_depth = paren_depth > 0 ? paren_depth - 1 : 0;
        scan_property_value(
          ~paren_depth=next_paren_depth,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items,
          ~ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | LEFT_BRACKET =>
        scan_property_value(
          ~paren_depth,
          ~bracket_depth=bracket_depth + 1,
          ~has_value=true,
          ~top_level_items,
          ~ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | RIGHT_BRACKET =>
        let next_bracket_depth = bracket_depth > 0 ? bracket_depth - 1 : 0;
        scan_property_value(
          ~paren_depth,
          ~bracket_depth=next_bracket_depth,
          ~has_value=true,
          ~top_level_items,
          ~ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      | COLON
      | DOUBLE_COLON when has_value && at_top_level =>
        false
      | token when has_value && at_top_level
          && unclassified_token_starts_nested_block(Unclassified_token(token)) =>
        nested_block_follows(~state, lexbuf, ~initial_paren_depth=0, ~initial_bracket_depth=0)
          ? true
          : scan_property_value(
              ~paren_depth,
              ~bracket_depth,
              ~has_value=true,
              ~top_level_items,
              ~ident_like_prefix,
              ~selector_pseudo_prefix,
            )
      | LEFT_BRACE =>
        at_top_level
          ? false
          : scan_property_value(
              ~paren_depth,
              ~bracket_depth,
              ~has_value=true,
              ~top_level_items,
              ~ident_like_prefix,
              ~selector_pseudo_prefix=next_selector_pseudo_prefix,
            )
      | SEMI_COLON
      | RIGHT_BRACE
      | EOF =>
        at_top_level
          ? true
          : scan_property_value(
              ~paren_depth,
              ~bracket_depth,
              ~has_value=true,
              ~top_level_items,
              ~ident_like_prefix,
              ~selector_pseudo_prefix=next_selector_pseudo_prefix,
            )
      | _ =>
        scan_property_value(
          ~paren_depth,
          ~bracket_depth,
          ~has_value=true,
          ~top_level_items,
          ~ident_like_prefix,
          ~selector_pseudo_prefix=next_selector_pseudo_prefix,
        )
      }
    | Error(_) => true
    };
  };

  switch ((read_next_significant()).txt) {
  | Ok(Unclassified_token(COLON)) =>
    scan_property_value(
      ~paren_depth=0,
      ~bracket_depth=0,
      ~has_value=false,
      ~top_level_items=0,
      ~ident_like_prefix=false,
      ~selector_pseudo_prefix=false,
    )
  | _ => false
  };
};

let rec drop_buffered_unclassified_whitespace = (~state, lexbuf) => {
  let unclassified = peek_unclassified_token(~state, lexbuf);
  switch (unclassified.txt) {
  | Ok(Unclassified_whitespace) =>
    let _ = Queue.take(state.unclassified_buffer);
    drop_buffered_unclassified_whitespace(~state, lexbuf)
  | _ => ()
  };
};

let peek_next_significant_unclassified = (~state, lexbuf) => {
  let read_unclassified = make_unclassified_reader(~state, lexbuf);
  let rec loop = () => {
    let unclassified = read_unclassified();
    switch (unclassified.txt) {
    | Ok(Unclassified_whitespace) => loop()
    | _ => unclassified
    };
  };
  loop();
};

let rec consume = (~state, lexbuf) => {
  let handle_mode_transition = token => {
    let mode_before = current_mode(state);
    let is_ident =
      switch (token) {
      | IDENT(_) => true
      | _ => false
      };

    if (mode_before == Declaration_value) {
      switch (token) {
      | WS => ()
      | _ => {
          state.declaration_value_has_content = true;
          if (state.paren_depth == 0 && state.bracket_depth == 0) {
            switch (token) {
            | IDENT(_)
            | TYPE_SELECTOR(_)
            | NUMBER(_)
            | PERCENTAGE(_)
            | DIMENSION(_)
            | HASH(_)
            | STRING(_)
            | URL(_)
            | INTERPOLATION(_)
            | FUNCTION(_)
            | NTH_FUNCTION(_) =>
              state.declaration_value_top_level_items =
                state.declaration_value_top_level_items + 1;
              if (state.declaration_value_top_level_items == 1) {
                state.declaration_value_ident_like_prefix =
                  switch (token) {
                  | IDENT(_)
                  | TYPE_SELECTOR(_) => true
                  | _ => false
                  };
              };
            | _ => ()
            };
          };
        }
      };
    };

    state.last_was_combinator = false;
    state.last_was_delimiter = false;

    let enter_selector_mode = () =>
      switch (current_mode(state)) {
      | Toplevel
      | Declaration_block => push_mode(state, Selector)
      | _ => ()
      };

    let drop_transient_modes = () => {
      let rec loop = () =>
        switch (current_mode(state)) {
        | Selector
        | Declaration_value
        | At_rule_prelude =>
          pop_mode(state) ? loop() : ()
        | _ => ()
        };
      loop();
    };

    switch (token) {
    | TYPE_SELECTOR(_)
    | INTERPOLATION(_) => enter_selector_mode()
    | LEFT_BRACE =>
      state.brace_depth = state.brace_depth + 1;
      switch (current_mode(state)) {
      | Toplevel => push_mode(state, Declaration_block)
      | Selector
      | At_rule_prelude =>
        let _ = pop_mode(state);
        push_mode(state, Declaration_block)
      | _ => ()
      }
    | RIGHT_BRACE =>
      state.brace_depth = state.brace_depth - 1;
      drop_transient_modes();
      switch (current_mode(state)) {
      | Declaration_block =>
        let _ = pop_mode(state);
        ()
      | _ => ()
      }
    | COLON =>
      switch (current_mode(state)) {
      | Declaration_block when state.last_was_ident =>
        state.declaration_value_allows_implicit_nested_terminator = true;
        state.declaration_value_has_content = false;
        state.declaration_value_top_level_items = 0;
        state.declaration_value_ident_like_prefix = false;
        push_mode(state, Declaration_value)
      | Declaration_block => push_mode(state, Selector)
      | _ => ()
      }
    | SEMI_COLON
    | IMPORTANT =>
      switch (current_mode(state)) {
      | Declaration_value
      | At_rule_prelude =>
        state.declaration_value_allows_implicit_nested_terminator = false;
        state.declaration_value_has_content = false;
        state.declaration_value_top_level_items = 0;
        state.declaration_value_ident_like_prefix = false;
        let _ = pop_mode(state);
        ()
      | _ => ()
      }
    | FUNCTION(_)
    | NTH_FUNCTION(_)
    | LEFT_PAREN => state.paren_depth = state.paren_depth + 1
    | RIGHT_PAREN => state.paren_depth = state.paren_depth - 1
    | AT_KEYFRAMES(_)
    | AT_RULE(_)
    | AT_RULE_STATEMENT(_) => push_mode(state, At_rule_prelude)
    | LEFT_BRACKET =>
      state.bracket_depth = state.bracket_depth + 1;
      enter_selector_mode()
    | RIGHT_BRACKET => state.bracket_depth = state.bracket_depth - 1
    | GREATER_THAN
    | PLUS
    | TILDE =>
      if (current_mode(state) == Selector) {
        state.last_was_combinator = true;
      }
    | COMMA =>
      if (current_mode(state) == Selector) {
        state.last_was_delimiter = true;
      }
    | DOT
    | HASH(_)
    | AMPERSAND
    | ASTERISK
    | DOUBLE_COLON => enter_selector_mode()
    | _ => ()
    };

    state.last_was_ident = is_ident;
    token;
  };

  if (current_mode(state) == Declaration_value
      && declaration_value_starts_nested_block(~state, lexbuf)) {
    let nested_start = peek_next_significant_unclassified(~state, lexbuf);
    Ok((handle_mode_transition(SEMI_COLON), nested_start.start_pos, nested_start.start_pos));
  } else {

    let unclassified = take_unclassified_token(~state, lexbuf);
    switch (unclassified.txt) {
    | Error(msg) => Error((msg, unclassified.start_pos, unclassified.end_pos))
    | Ok(Unclassified_whitespace) =>
      drop_buffered_unclassified_whitespace(~state, lexbuf);
      switch (current_mode(state)) {
      | Selector =>
        if (state.last_was_combinator
            || state.last_was_delimiter
            || state.bracket_depth > 0) {
          state.last_was_combinator = false;
          state.last_was_delimiter = false;
          consume(~state, lexbuf);
        } else {
          let next_unclassified = peek_next_significant_unclassified(~state, lexbuf);
          switch (next_unclassified.txt) {
          | Ok(unclassified_token)
              when unclassified_token_starts_selector(unclassified_token) =>
            Ok((
              handle_mode_transition(DESCENDANT_COMBINATOR),
              unclassified.start_pos,
              unclassified.end_pos,
            ))
          | _ => consume(~state, lexbuf)
          };
        }
      | Declaration_value
      | At_rule_prelude =>
        Ok((handle_mode_transition(WS), unclassified.start_pos, unclassified.end_pos))
      | Toplevel
      | Declaration_block => consume(~state, lexbuf)
      }
    | Ok(Unclassified_ident(string)) =>
      let token =
        switch (current_mode(state)) {
        | Toplevel
        | Selector => TYPE_SELECTOR(string)
        | Declaration_block =>
          identifier_starts_property(~state, lexbuf)
            ? IDENT(string)
            : TYPE_SELECTOR(string)
        | Declaration_value
        | At_rule_prelude => IDENT(string)
        };
      Ok((handle_mode_transition(token), unclassified.start_pos, unclassified.end_pos))
    | Ok(Unclassified_token(token)) =>
      Ok((handle_mode_transition(token), unclassified.start_pos, unclassified.end_pos))
    };
  };
};

let get_next_tokens_with_location = (~state, lexbuf) => {
  switch (consume(~state, lexbuf)) {
  | Ok((token, position_start, position_end)) => (token, position_start, position_end)
  | Error((msg, start_pos, end_pos)) =>
    raise(LexingError((start_pos, end_pos, Tokens.show_error(msg))))
  };
};

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  loc: Location.t,
};

let from_string = (~initial_mode, string) => {
  let lexbuf = Sedlexing.Utf8.from_string(string);
  let state = {
    mode_stack: [initial_mode],
    unclassified_buffer: Queue.create(),
    paren_depth: 0,
    brace_depth: 0,
    bracket_depth: 0,
    declaration_value_allows_implicit_nested_terminator: false,
    declaration_value_has_content: false,
    declaration_value_top_level_items: 0,
    declaration_value_ident_like_prefix: false,
    last_was_ident: false,
    last_was_combinator: false,
    last_was_delimiter: false,
  };
  let rec read = acc => {
    let (value, loc_start, loc_end) =
      switch (consume(~state, lexbuf)) {
      | Ok((token, start_pos, end_pos)) => (Ok(token), start_pos, end_pos)
      | Error((msg, start_pos, end_pos)) => (Error(msg), start_pos, end_pos)
      };

    let token_with_loc: token_with_location = {
      txt: value,
      loc: {
        loc_start,
        loc_end,
        loc_ghost: false,
      },
    };

    let acc = [token_with_loc, ...acc];
    switch (value) {
    | Ok(EOF) => acc
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
