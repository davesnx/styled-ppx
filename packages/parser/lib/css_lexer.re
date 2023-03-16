/** CSS lexer
  * Reference:
  * https://www.w3.org/TR/css-syntax-3/ */

module Sedlexing = Lex_buffer;
module Parser = Css_parser;
module Types = Css_types;

/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, string));

/** Signals a parsing error at the provided token and its start and end
 * locations. */
exception ParseError((Parser.token, Lexing.position, Lexing.position));

/** Signals a grammar error at the provided location. */
exception GrammarError((string, Location.t));

let grammar_error = (loc: Location.t, message) => {
  raise(GrammarError((message, loc)));
}

let unreachable = () =>
  failwith("This match case is unreachable. sedlex needs a last case as wildcard _. If this error appears, means that there's a bug in the lexer.");

let token_to_string =
  fun
  | Parser.EOF => ""
  | Parser.LEFT_BRACE => "{"
  | Parser.RIGHT_BRACE => "}"
  | Parser.LEFT_PAREN => "("
  | Parser.RIGHT_PAREN => ")"
  | Parser.LEFT_BRACKET => "["
  | Parser.RIGHT_BRACKET => "]"
  | Parser.COLON => ":"
  | Parser.DOUBLE_COLON => "::"
  | Parser.SEMI_COLON => ";"
  | Parser.PERCENTAGE => "%"
  | Parser.AMPERSAND => "&"
  | Parser.IMPORTANT => "!important"
  | Parser.IDENT(s) => s
  | Parser.TAG(s) => s
  | Parser.STRING(s) => "'" ++ s ++ "'"
  | Parser.OPERATOR(s) => s
  | Parser.COMBINATOR(s)
  | Parser.DELIM(s) => s
  | Parser.AT_MEDIA(s)
  | Parser.AT_KEYFRAMES(s)
  | Parser.AT_RULE_STATEMENT(s)
  | Parser.AT_RULE(s) => "@" ++ s
  | Parser.HASH(s) => "#" ++ s
  | Parser.NUMBER(s) => s
  | Parser.UNICODE_RANGE(s) => s
  | Parser.FLOAT_DIMENSION((n, s)) => n ++ s
  | Parser.DIMENSION((n, d)) => n ++ d
  | Parser.VARIABLE(v) => String.concat(".", v)
  | Parser.WS => " "
  | Parser.DOT => "."
  | Parser.COMMA => ","
  | Parser.ASTERISK => "*"
  | Parser.FUNCTION(fn) => fn ++ "("
  | Parser.NTH_FUNCTION(fn) => fn ++ "("
  | Parser.URL(url) => url ++ "("
  | Parser.BAD_URL => "bar url"
;

let token_to_debug =
  fun
  | Parser.EOF => "EOF"
  | Parser.LEFT_BRACE => "LEFT_BRACE"
  | Parser.RIGHT_BRACE => "RIGHT_BRACE"
  | Parser.LEFT_PAREN => "LEFT_PAREN"
  | Parser.RIGHT_PAREN => "RIGHT_PAREN"
  | Parser.LEFT_BRACKET => "LEFT_BRACKET"
  | Parser.RIGHT_BRACKET => "RIGHT_BRACKET"
  | Parser.COLON => "COLON"
  | Parser.DOUBLE_COLON => "DOUBLE_COLON"
  | Parser.SEMI_COLON => "SEMI_COLON"
  | Parser.PERCENTAGE => "PERCENTAGE"
  | Parser.AMPERSAND => "AMPERSAND"
  | Parser.IMPORTANT => "IMPORTANT"
  | Parser.IDENT(s) => "IDENT('" ++ s ++ "')"
  | Parser.TAG(s) => "TAG('" ++ s ++ "')"
  | Parser.STRING(s) => "STRING('" ++ s ++ "')"
  | Parser.OPERATOR(s) => "OPERATOR('" ++ s ++ "')"
  | Parser.DELIM(s) => "DELIM('" ++ s ++ "')"
  | Parser.AT_RULE(s) => "AT_RULE('" ++ s ++ "')"
  | Parser.AT_RULE_STATEMENT(s) => "AT_RULE_STATEMENT('" ++ s ++ "')"
  | Parser.AT_MEDIA(s) => "AT_MEDIA('" ++ s ++ "')"
  | Parser.AT_KEYFRAMES(s) => "AT_KEYFRAMES('" ++ s ++ "')"
  | Parser.HASH(s) => "HASH('" ++ s ++ "')"
  | Parser.NUMBER(s) => "NUMBER('" ++ s ++ "')"
  | Parser.UNICODE_RANGE(s) => "UNICODE_RANGE('" ++ s ++ "')"
  | Parser.FLOAT_DIMENSION((n, s)) => "FLOAT_DIMENSION('" ++ n ++ ", " ++ s ++ "')"
  | Parser.DIMENSION((n, d)) => "DIMENSION('" ++ n ++ ", " ++ d ++ "')"
  | Parser.VARIABLE(v) => "VARIABLE('" ++ (String.concat(".", v)) ++ "')"
  | Parser.COMBINATOR(s) => "COMBINATOR(" ++ s ++ ")"
  | Parser.DOT => "DOT"
  | Parser.COMMA => "COMMA"
  | Parser.WS => "WS"
  | Parser.ASTERISK => "ASTERISK"
  | Parser.FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | Parser.NTH_FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | Parser.URL(u) => "URL(" ++ u ++ ")"
  | Parser.BAD_URL => "BAD_URL"
;

let render_error = fun
  | LexingError((pos, msg)) => {
    let loc = Sedlexing.make_loc(pos, pos);
    Location.error(~loc, msg);
  }
  | ParseError((token, start_pos, end_pos)) => {
    let loc = Sedlexing.make_loc(start_pos, end_pos);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        token_to_string(token),
      );
    Location.error(~loc, msg);
  }
  | GrammarError((msg, loc)) => Location.error(~loc, msg)
  | exn => Location.error("Unexpected error " ++ Printexc.to_string(exn));

let () = Location.register_error_of_exn(exn => Some(render_error(exn)));

/* Regexes */
let newline = [%sedlex.regexp? '\n' | "\r\n" | '\r' | '\012'];

let whitespace = [%sedlex.regexp? " " | '\t' | newline];

let whitespaces = [%sedlex.regexp? Star(whitespace)];

let digit = [%sedlex.regexp? '0' .. '9'];

let non_ascii = [%sedlex.regexp? '\160' .. '\255'];

let up_to_6_hex_digits = [%sedlex.regexp? Rep(hex_digit, 1 .. 6)];

let unicode = [%sedlex.regexp? ('\\', up_to_6_hex_digits, Opt(whitespace))];

let unicode_range = [%sedlex.regexp?
  Rep(hex_digit | '?', 1 .. 6) |
  (up_to_6_hex_digits, '-', up_to_6_hex_digits)
];

let escape = [%sedlex.regexp?
  unicode | ('\\', Compl('\r' | '\n' | '\012' | hex_digit))
];

let ident_start = [%sedlex.regexp?
  '_' | 'a' .. 'z' | 'A' .. 'Z' | '$' | non_ascii | escape
];

let ident_char = [%sedlex.regexp?
  '_' | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' | non_ascii | escape
];

let ident = [%sedlex.regexp? (Opt('-'), Opt('-'), ident_start, Star(ident_char))];

let variable_ident_char = [%sedlex.regexp?
  '_' | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | non_ascii | escape | '\''
];
let variable_name = [%sedlex.regexp? (Star(variable_ident_char))];
let module_variable = [%sedlex.regexp? (variable_name, '.')];
let variable = [%sedlex.regexp? ('$', '(', Opt(Star(module_variable)), variable_name, ')')];

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

let string = [%sedlex.regexp? string_quote | string_apos];

let name = [%sedlex.regexp? Plus(ident_char)];

let number = [%sedlex.regexp?
  (
    Opt('-'),
    Plus(digit),
    Opt('.', Plus(digit)),
    Opt('e' | 'E', '+' | '-', Plus(digit)),
  ) |
  (Opt('-'), '.', Plus(digit), Opt('e' | 'E', '+' | '-', Plus(digit)))
];

let non_printable = [%sedlex.regexp?
  '\000' .. '\b' | '\011' | '\014' .. '\031' | '\127'
];

let operator = [%sedlex.regexp? "~=" | "|=" | "^=" | "$=" | "*="| "="];

let combinator = [%sedlex.regexp? '>' | '+' | '~' | "||"];

let at_rule_without_body = [%sedlex.regexp? ("@", "charset" | "import" | "namespace")];
let at_rule = [%sedlex.regexp? ("@", ident)];
let at_media = [%sedlex.regexp? ("@", "media")];
let at_keyframes = [%sedlex.regexp? ("@", "keyframes")];

let is_tag = fun
  | "a"
  | "abbr"
  | "address"
  | "area"
  | "article"
  | "aside"
  | "audio"
  | "b"
  | "base"
  | "bdi"
  | "bdo"
  | "blockquote"
  | "body"
  | "br"
  | "button"
  | "canvas"
  | "caption"
  | "cite"
  | "code"
  | "col"
  | "colgroup"
  | "data"
  | "datalist"
  | "dd"
  | "del"
  | "details"
  | "dfn"
  | "dialog"
  | "div"
  | "dl"
  | "dt"
  | "em"
  | "embed"
  | "fieldset"
  | "figcaption"
  | "figure"
  | "footer"
  | "form"
  | "h1"
  | "h2"
  | "h3"
  | "h4"
  | "h5"
  | "h6"
  | "head"
  | "header"
  | "hgroup"
  | "hr"
  | "html"
  | "i"
  | "iframe"
  | "img"
  | "input"
  | "ins"
  | "kbd"
  | "label"
  | "legend"
  | "li"
  | "link"
  | "main"
  | "map"
  | "mark"
  | "math"
  | "menu"
  | "menuitem"
  | "meta"
  | "meter"
  | "nav"
  | "noscript"
  | "object"
  | "ol"
  | "optgroup"
  | "option"
  | "output"
  | "p"
  | "param"
  | "picture"
  | "pre"
  | "progress"
  | "q"
  | "rb"
  | "rp"
  | "rt"
  | "rtc"
  | "ruby"
  | "s"
  | "samp"
  | "script"
  | "section"
  | "select"
  | "slot"
  | "small"
  | "source"
  | "span"
  | "strong"
  | "style"
  | "sub"
  | "summary"
  | "sup"
  | "svg"
  | "table"
  | "tbody"
  | "td"
  | "template"
  | "textarea"
  | "tfoot"
  | "th"
  | "thead"
  | "time"
  | "title"
  | "tr"
  | "track"
  | "u"
  | "ul"
  | "var"
  | "video"
  | "wbr" => true
  | _ => false
;

let _a = [%sedlex.regexp? 'A' | 'a'];
let _b = [%sedlex.regexp? 'B' | 'b'];
let _c = [%sedlex.regexp? 'C' | 'c'];
let _d = [%sedlex.regexp? 'D' | 'd'];
let _e = [%sedlex.regexp? 'E' | 'e'];
let _f = [%sedlex.regexp? 'F' | 'f'];
let _g = [%sedlex.regexp? 'G' | 'g'];
let _h = [%sedlex.regexp? 'H' | 'h'];
let _i = [%sedlex.regexp? 'I' | 'i'];
let _j = [%sedlex.regexp? 'J' | 'j'];
let _k = [%sedlex.regexp? 'K' | 'k'];
let _l = [%sedlex.regexp? 'L' | 'l'];
let _m = [%sedlex.regexp? 'M' | 'm'];
let _n = [%sedlex.regexp? 'N' | 'n'];
let _o = [%sedlex.regexp? 'O' | 'o'];
let _p = [%sedlex.regexp? 'P' | 'p'];
let _q = [%sedlex.regexp? 'Q' | 'q'];
let _r = [%sedlex.regexp? 'R' | 'r'];
let _s = [%sedlex.regexp? 'S' | 's'];
let _t = [%sedlex.regexp? 'T' | 't'];
let _u = [%sedlex.regexp? 'U' | 'u'];
let _v = [%sedlex.regexp? 'V' | 'v'];
let _w = [%sedlex.regexp? 'W' | 'w'];
let _x = [%sedlex.regexp? 'X' | 'x'];
let _y = [%sedlex.regexp? 'Y' | 'y'];
let _z = [%sedlex.regexp? 'Z' | 'z'];

let important = [%sedlex.regexp?
  ("!", whitespaces, _i, _m, _p, _o, _r, _t, _a, _n, _t)
];

let length = [%sedlex.regexp?
  (_c, _a, _p) |
  (_c, _h) |
  (_e, _m) |
  (_e, _x) |
  (_i, _c) |
  (_l, _h) |
  (_r, _e, _m) |
  (_r, _l, _h) |
  (_v, _h) |
  (_v, _w) |
  (_v, _i) |
  (_v, _b) |
  (_v, _m, _i, _n) |
  (_v, _m, _a, _x) |
  (_c, _m) |
  (_m, _m) |
  _q |
  (_i, _n) |
  (_p, _c) |
  (_p, _t) |
  (_p, _x) |
  (_f, _r)
];

let angle = [%sedlex.regexp?
  (_d, _e, _g) | (_g, _r, _a, _d) | (_r, _a, _d) | (_t, _u, _r, _n)
];

let time = [%sedlex.regexp? _s | (_m, _s)];

let frequency = [%sedlex.regexp? (_h, _z) | (_k, _h, _z)];

/* let escape = [%sedlex.regexp? '\\']; */
let hex_digit = [%sedlex.regexp? digit | 'A' .. 'F' | 'a' .. 'f'];
/* let non_ascii_code_point = [%sedlex.regexp? Sub(any, '\000' .. '\128')]; */ // greater than \u0080
let identifier_start_code_point = [%sedlex.regexp?
  'a' .. 'z' | 'A' .. 'Z' | non_ascii | '_'
];
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

/* This module is a copy/paste of Reason_css_lexer in favor of moving everything into css_lexer */
module Tokenizer = {
  open Reason_css_lexer;
  let lexeme = Sedlexing.utf8;

  let (let.ok) = Result.bind;

  let consume_whitespace = buf =>
    switch%sedlex (buf) {
    | Star(whitespace) => Parser.WS
    | _ => Parser.WS
  };

  let string_of_uchar = char => {
    let buf = Buffer.create(0);
    Buffer.add_utf_8_uchar(buf, char);
    Buffer.contents(buf);
  };

  let uchar_of_int = n => Uchar.of_int(n) |> string_of_uchar;
  let is_surrogate = char_code => char_code >= 0xD800 && char_code <= 0xDFFF;

  let check = (f, buf) => {
    // TODO: why this second int?
    Sedlexing.mark(buf, 0);
    let value = f(buf);
    let _ = Sedlexing.backtrack(buf);
    value;
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
        ? Error((Uchar.rep, Invalid_code_point)) : Ok(char);
    | eof => Error((Uchar.rep, Eof))
    | any => Ok(lexeme(buf))
    | _ => unreachable()
    };
  };

  // https://drafts.csswg.org/css-syntax-3/#consume-remnants-of-bad-url
  let rec consume_remnants_bad_url = buf =>
    switch%sedlex (buf) {
    | ")"
    | eof => ()
    | escape =>
      let _ = consume_escaped(buf);
      consume_remnants_bad_url(buf);
    | any => consume_remnants_bad_url(buf)
    | _ => unreachable()
  };

  // https://drafts.csswg.org/css-syntax-3/#consume-url-token
  let consume_url = buf => {
    let _ = consume_whitespace(buf);
    let rec read = acc => {
      let when_whitespace = () => {
        let _ = consume_whitespace(buf);
        switch%sedlex (buf) {
        | ')' => Ok(Parser.URL(acc))
        | eof => Error((URL(acc), Eof))
        | _ =>
          consume_remnants_bad_url(buf);
          Ok(Parser.BAD_URL);
        };
      };
      switch%sedlex (buf) {
      | ')' => Ok(Parser.URL(acc))
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
      | _ => unreachable()
      };
    };
    read(lexeme(buf));
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
    read(lexeme(buf));
  };

  let handle_consume_identifier =
  fun
  | Error((_, error)) => Error((BAD_IDENT, error))
  | Ok(string) => Ok(string);

  let consume_function = string => {
    switch (string) {
      | "nth-last-child" | "nth-child" | "nth-of-type" | "nth-last-of-type" => Parser.NTH_FUNCTION(string)
      | _ => Parser.FUNCTION(string)
    }
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
      is_function(buf) ? Ok(consume_function(string)) : consume_url(buf);
    };

  let.ok string = consume_identifier(buf) |> handle_consume_identifier;
  switch%sedlex (buf) {
    | "(" =>
      switch (string) {
        | "url" => read_url(string)
        | _ => Ok(consume_function(string))
      }
    | _ => is_tag(string) ? Ok(Parser.TAG(string)) : Ok(Parser.IDENT(string))
    };
  };
};

let handle_tokenizer_error = (buf: Sedlexing.t) =>
  fun
  | Ok(value) => value
  | Error((_, msg)) => {
    let error: string = Reason_css_lexer.show_error(msg);
    let position = buf.pos;
    raise @@ LexingError((position, error));
  }
;

let skip_whitespace = ref(false);

let rec get_next_token = (buf) => {
  open Parser;
  open Sedlexing;
  switch%sedlex (buf) {
  | eof => EOF
  | "/*" => discard_comments(buf)
  | '.' => DOT
  | ';' => SEMI_COLON
  | '}' => {
    skip_whitespace.contents = false;
    RIGHT_BRACE;
  }
  | '{' => {
    skip_whitespace.contents = true;
    LEFT_BRACE;
  }
  | "::" => DOUBLE_COLON
  | ':' => COLON
  | '(' => LEFT_PAREN
  | ')' => RIGHT_PAREN
  | '[' => LEFT_BRACKET
  | ']' => RIGHT_BRACKET
  | '%' => PERCENTAGE
  | '&' => {
    skip_whitespace.contents = false;
    AMPERSAND;
  }
  | '*' => ASTERISK
  | ',' => COMMA
  | variable => VARIABLE(latin1(~skip=2, ~drop=1, buf) |> String.split_on_char('.'))
  | operator => OPERATOR(latin1(buf))
  | combinator => COMBINATOR(latin1(buf))
  | string => STRING(latin1(~skip=1, ~drop=1, buf))
  | important => IMPORTANT
  | at_media => {
    skip_whitespace.contents = false;
    AT_MEDIA(latin1(~skip=1, buf))
  }
  | at_keyframes => {
    skip_whitespace.contents = false;
    AT_KEYFRAMES(latin1(~skip=1, buf))
  }
  | at_rule => {
    skip_whitespace.contents = false;
    AT_RULE(latin1(~skip=1, buf))
  }
  | at_rule_without_body => {
    skip_whitespace.contents = false;
    AT_RULE_STATEMENT(latin1(~skip=1, buf))
  }
  /* NOTE: should be placed above ident, otherwise pattern with
   * '-[0-9a-z]{1,6}' cannot be matched */
  | (_u, '+', unicode_range) => UNICODE_RANGE(latin1(buf))
  | ('#', name) => HASH(latin1(~skip=1, buf))
  | number => get_dimension(latin1(buf), buf)
  | whitespaces => {
    if (skip_whitespace^) {
      get_next_token(buf);
    } else {
      WS
    }
  }
  /* -moz-* */
  | ("-", ident) => Parser.IDENT(latin1(buf))
  /* --variable */
  | ("-", "-", ident) => Parser.IDENT(latin1(buf))
  | identifier_start_code_point => {
    let _ = Sedlexing.backtrack(buf);
    Tokenizer.consume_ident_like(buf) |> handle_tokenizer_error(buf);
  }
  | any => DELIM(latin1(buf))
  | _ => assert(false)
  };
}
and get_dimension = (n, buf) => {
  open Sedlexing;
  switch%sedlex (buf) {
    | length => FLOAT_DIMENSION((n, latin1(buf)))
    | angle => FLOAT_DIMENSION((n, latin1(buf)))
    | time => FLOAT_DIMENSION((n, latin1(buf)))
    | frequency => FLOAT_DIMENSION((n, latin1(buf)))
    | 'n' => DIMENSION((n, latin1(buf)))
    | _ => NUMBER(n)
  };
} and discard_comments = (buf) => {
  switch%sedlex(buf) {
  | "*/" => get_next_token(buf)
  | any => discard_comments(buf)
  | eof => raise(LexingError((buf.pos, "Unterminated comment at the end of the string")))
  | _ => assert false
  }
};

let get_next_tokens_with_location = (buf) => {
  let (_, position_end) = Lex_buffer.lexing_positions(buf);
  let token = get_next_token(buf);
  let (_, position_end_after) = Lex_buffer.lexing_positions(buf);

  (token, position_end, position_end_after);
}

type parser('token, 'ast) = MenhirLib.Convert.traditional('token, 'ast);

let parse = (skip_whitespaces, buf, parser) => {
  skip_whitespace.contents = skip_whitespaces;

  let last_token = ref((Parser.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := get_next_tokens_with_location(buf);
    last_token^;
  };

  try(MenhirLib.Convert.Simplified.traditional2revised(parser, next_token)) {
  | LexingError(_) as e => raise(e)
  | _ => raise(ParseError(last_token^))
  };
};

let parse_string = (~skip_whitespace, ~container_lnum=?, ~pos=?, parser, string) => {
  parse(skip_whitespace, Lex_buffer.from_string(~container_lnum?, ~pos?, string), parser);
};

let parse_declaration_list = (~container_lnum=?, ~pos=?, input: string) => {
  /* TODO: Remove this trim and fix parser */
  let trimmed = String.trim(input);
  parse_string(~skip_whitespace=false, ~container_lnum?, ~pos?, Parser.declaration_list, trimmed);
}

let parse_declaration = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(~skip_whitespace=true, ~container_lnum?, ~pos?, Parser.declaration, input);

let parse_stylesheet = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(~skip_whitespace=false, ~container_lnum?, ~pos?, Parser.stylesheet, input);

let parse_keyframes = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(~skip_whitespace=false, ~container_lnum?, ~pos?, Parser.keyframes, input);
