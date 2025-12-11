/** CSS lexer
  * Reference:
  * https://www.w3.org/TR/css-syntax-3/ */

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

let whitespace = [%sedlex.regexp? " " | '\t' | newline | comment];

let whitespaces = [%sedlex.regexp? Star(whitespace)];

let digit = [%sedlex.regexp? '0' .. '9'];

let hex_digit = [%sedlex.regexp? digit | 'A' .. 'F' | 'a' .. 'f'];

let up_to_6_hex_digits = [%sedlex.regexp? Rep(hex_digit, 1 .. 6)];

let unicode = [%sedlex.regexp? ('\\', up_to_6_hex_digits, Opt(whitespace))];

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

let variable_ident_char = [%sedlex.regexp?
  '_' | alpha | digit | non_ascii | escape | '\''
];
let variable_name = [%sedlex.regexp? Star(variable_ident_char)];
let module_variable = [%sedlex.regexp? (variable_name, '.')];
let variable = [%sedlex.regexp?
  ('$', '(', whitespaces, Opt(Star(module_variable)), variable_name, whitespaces, ')')
];

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

let operator = [%sedlex.regexp? "~=" | "|=" | "^=" | "$=" | "*=" | "="];

let combinator = [%sedlex.regexp? '+' | '~' | '>'];

let at_rule_without_body = [%sedlex.regexp?
  ("@", "charset" | "import" | "namespace")
];

let at_rule = [%sedlex.regexp? ("@", ident)];
let at_keyframes = [%sedlex.regexp? ("@", "keyframes")];

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

let is_tag =
  fun
  | "a"
  | "abbr"
  | "address"
  | "animate"
  | "animateMotion"
  | "animateTransform"
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
  | "circle"
  | "cite"
  | "clipPath"
  | "code"
  | "col"
  | "colgroup"
  | "data"
  | "datalist"
  | "dd"
  | "defs"
  | "del"
  | "desc"
  | "details"
  | "dfn"
  | "dialog"
  | "div"
  | "dl"
  | "dt"
  | "ellipse"
  | "em"
  | "embed"
  | "feBlend"
  | "feColorMatrix"
  | "feComponentTransfer"
  | "feComposite"
  | "feConvolveMatrix"
  | "feDiffuseLighting"
  | "feDisplacementMap"
  | "feDistantLight"
  | "feDropShadow"
  | "feFlood"
  | "feFuncA"
  | "feFuncB"
  | "feFuncG"
  | "feFuncR"
  | "feGaussianBlur"
  | "feImage"
  | "feMerge"
  | "feMergeNode"
  | "feMorphology"
  | "feOffset"
  | "fePointLight"
  | "feSpecularLighting"
  | "feSpotLight"
  | "feTile"
  | "feTurbulence"
  | "fieldset"
  | "figcaption"
  | "figure"
  | "footer"
  | "foreignObject"
  | "form"
  | "g"
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
  | "image"
  | "img"
  | "input"
  | "ins"
  | "kbd"
  | "label"
  | "legend"
  | "li"
  | "line"
  | "linearGradient"
  | "link"
  | "main"
  | "map"
  | "mark"
  | "marker"
  | "math"
  | "menu"
  | "menuitem"
  | "meta"
  | "metadata"
  | "meter"
  | "mpath"
  | "nav"
  | "noscript"
  | "object"
  | "ol"
  | "optgroup"
  | "option"
  | "output"
  | "p"
  | "param"
  | "path"
  | "pattern"
  | "picture"
  | "polygon"
  | "polyline"
  | "pre"
  | "progress"
  | "q"
  | "radialGradient"
  | "rb"
  | "rect"
  | "rp"
  | "rt"
  | "rtc"
  | "ruby"
  | "s"
  | "samp"
  | "script"
  | "section"
  | "select"
  | "set"
  | "slot"
  | "small"
  | "source"
  | "span"
  | "stop"
  | "strong"
  | "style"
  | "sub"
  | "summary"
  | "sup"
  | "svg"
  | "switch"
  | "symbol"
  | "table"
  | "tbody"
  | "td"
  | "template"
  | "text"
  | "textarea"
  | "textPath"
  | "tfoot"
  | "th"
  | "thead"
  | "time"
  | "title"
  | "tr"
  | "track"
  | "tspan"
  | "u"
  | "ul"
  | "use"
  | "var"
  | "video"
  | "view"
  | "wbr" => true
  | _ => false;

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
  // relative length units based on font
  (_c, _a, _p) | (_c, _h) | (_e, _m) | (_e, _x) | (_i, _c) | (_l, _h) |
  // relative length units based on root element's font
  (_r, _c, _a, _p) |
  (_r, _c, _h) |
  (_r, _e, _m) |
  (_r, _e, _x) |
  (_r, _i, _c) |
  (_r, _l, _h) |
  // relative length units based on viewport
  (_v, _h) |
  (_v, _w) |
  (_v, _m, _a, _x) |
  (_v, _m, _i, _n) |
  (_v, _b) |
  (_v, _i) |
  // container query length units
  (_c, _q, _w) |
  (_c, _q, _h) |
  (_c, _q, _i) |
  (_c, _q, _b) |
  (_c, _q, _m, _i, _n) |
  (_c, _q, _m, _a, _x) |
  // absolute length units
  (_p, _x) |
  (_c, _m) |
  (_m, _m) |
  _q |
  (_i, _n) |
  (_p, _c) |
  (_p, _t)
];

let angle = [%sedlex.regexp?
  (_d, _e, _g) | (_g, _r, _a, _d) | (_r, _a, _d) | (_t, _u, _r, _n)
];

let time = [%sedlex.regexp? _s | (_m, _s)];

let frequency = [%sedlex.regexp? (_h, _z) | (_k, _h, _z)];

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

let consume_whitespace = lexbuf =>
  switch%sedlex (lexbuf) {
  | Star(whitespace) => Parser.WS
  | _ => Parser.WS
  };

// https://drafts.csswg.org/css-syntax-3/#consume-an-escaped-code-point
let consume_escaped = lexbuf => {
  switch%sedlex (lexbuf) {
  // TODO: spec typo? No more than 5?
  | Rep(hex_digit, 1 .. 6) =>
    let hex_string = "0x" ++ lexeme(lexbuf);
    let char_code = int_of_string(hex_string);
    let char = uchar_of_int(char_code);
    let _ = consume_whitespace(lexbuf);
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
  // Start reading from current position (after backtrack, lexeme is empty)
  read("");
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

// https://drafts.csswg.org/css-syntax-3/#consume-url-token
let consume_url = lexbuf => {
  let _ = consume_whitespace(lexbuf);
  let rec read = acc => {
    let when_whitespace = () => {
      let _ = consume_whitespace(lexbuf);
      switch%sedlex (lexbuf) {
      | ')' => Ok(Parser.URL(acc))
      | eof => Error((Parser.URL(acc), Tokens.Eof))
      | _ =>
        consume_remnants_bad_url(lexbuf);
        Ok(BAD_URL);
      };
    };
    switch%sedlex (lexbuf) {
    | ')' => Ok(Parser.URL(acc))
    | eof => Error((Parser.URL(acc), Tokens.Eof))
    | whitespace => when_whitespace()
    | '"'
    | '\''
    | '('
    | non_printable_code_point =>
      consume_remnants_bad_url(lexbuf);
      // TODO: location on error
      Error((BAD_URL, Tokens.Invalid_code_point));
    | escape =>
      switch (consume_escaped(lexbuf)) {
      | Ok(char) => read(acc ++ char)
      | Error((_, error)) => Error((BAD_URL, error))
      }
    | any => read(acc ++ lexeme(lexbuf))
    | _ => unreachable(lexbuf)
    };
  };
  read(lexeme(lexbuf));
};

let handle_consume_identifier =
  fun
  | Error((_, error)) => Error((Parser.BAD_IDENT, error))
  | Ok(string) => Ok(string);

let consume_function = string => {
  switch (string) {
  | "nth-last-child"
  | "nth-child"
  | "nth-of-type"
  | "nth-last-of-type" => Parser.NTH_FUNCTION(string)
  | _ => Parser.FUNCTION(string)
  };
};

// https://drafts.csswg.org/css-syntax-3/#consume-ident-like-token
let consume_ident_like = lexbuf => {
  let read_url = string => {
    // TODO: the whitespace trickery here?
    let _ = consume_whitespace(lexbuf);
    let is_function =
      check(_ =>
        switch%sedlex (lexbuf) {
        | '\''
        | '"'
        | variable => true
        | _ => false
        }
      );
    is_function(lexbuf)
      ? Ok(consume_function(string)) : consume_url(lexbuf);
  };

  let.ok string = consume_identifier(lexbuf) |> handle_consume_identifier;
  switch%sedlex (lexbuf) {
  | "(" =>
    switch (string) {
    | "url" => read_url(string)
    | _ => Ok(consume_function(string))
    }
  | _ => is_tag(string) ? Ok(TAG(string)) : Ok(IDENT(string))
  };
};

let check_if_three_codepoints_would_start_an_identifier =
  check(check_if_three_codepoints_would_start_an_identifier);
let check_if_three_code_points_would_start_a_number =
  check(check_if_three_code_points_would_start_a_number);

// TODO: check 5. without the 0 or .5 without the 0
let consume_number = lexbuf => {
  let append = repr => repr ++ lexeme(lexbuf);

  let kind = `Integer; // 1
  let repr = "";

  // Try to match integer part (including optional +/- sign)
  let (kind, repr) =
    switch%sedlex (lexbuf) {
    | (Opt("+" | "-"), Plus(digit)) => (`Integer, append(repr))
    | _ => (kind, repr)
    }; // 2 - 3

  // Try to match decimal part
  let (kind, repr) =
    switch%sedlex (lexbuf) {
    | (".", Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 4

  // If we haven't matched anything yet, try to match just decimal part (e.g., ".5")
  let (kind, repr) =
    if (repr == "") {
      switch%sedlex (lexbuf) {
      | (Opt("+" | "-"), ".", Plus(digit)) => (`Number, append(repr))
      | _ => (kind, repr)
      };
    } else {
      (kind, repr);
    };

  // Try to match exponent part
  let (kind, repr) =
    switch%sedlex (lexbuf) {
    | ('E' | 'e', Opt('+' | '-'), Plus(digit)) => (`Number, append(repr))
    | _ => (kind, repr)
    }; // 5
  // Return the original representation string instead of converting back from float
  (repr, kind); // 6
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
  | Ok(string) => Ok(Parser.STRING(string))
  | Error((string, error)) => Error((Parser.STRING(string), error))
  };
};

let handle_consume_identifier =
  fun
  | Error((_, error)) => Error((Parser.BAD_IDENT, error))
  | Ok(string) => Ok(string);

// Check if a unit is a length/angle/time/frequency unit (should use FLOAT_DIMENSION)
let is_float_unit = unit => {
  let lower = String.lowercase_ascii(unit);
  switch (lower) {
  // Length units
  | "px"
  | "cm"
  | "mm"
  | "in"
  | "pt"
  | "pc"
  | "em"
  | "ex"
  | "ch"
  | "rem"
  | "vw"
  | "vh"
  | "vmin"
  | "vmax"
  | "vb"
  | "vi"
  | "cqw"
  | "cqh"
  | "cqi"
  | "cqb"
  | "cqmin"
  | "cqmax"
  | "cap"
  | "ic"
  | "lh"
  | "rlh"
  | "rcap"
  | "rch"
  | "rex"
  | "ric"
  // Angle units
  | "deg"
  | "grad"
  | "rad"
  | "turn"
  // Time units
  | "s"
  | "ms"
  // Frequency units
  | "hz"
  | "khz"
  // Resolution units
  | "dpi"
  | "dpcm"
  | "dppx"
  // Percentage
  | "%" => true
  | _ => false
  };
};

// Consume identifier for dimension units, but stop at +/- if followed by digit
// This handles nth-child cases like "10n-1" -> dimension("10", "n") not dimension("10", "n-1")
let consume_identifier_for_dimension = lexbuf => {
  let should_stop_at_nth_pattern = acc =>
    // Check if current acc ends with 'n' and next is '-' or '+' followed by digit
    if (String.length(acc) > 0 && acc.[String.length(acc) - 1] == 'n') {
      Sedlexing.mark(lexbuf, 0);
      let result =
        switch%sedlex (lexbuf) {
        | ('+' | '-', digit) => true
        | _ => false
        };
      let _ = Sedlexing.backtrack(lexbuf);
      result;
    } else {
      false;
    };

  let rec read = acc =>
    if (should_stop_at_nth_pattern(acc)) {
      Ok(acc);
    } else {
      switch%sedlex (lexbuf) {
      | identifier_code_point => read(acc ++ lexeme(lexbuf))
      | escape =>
        let.ok char = consume_escaped(lexbuf);
        read(acc ++ char);
      | _ => Ok(acc)
      };
    };
  read("");
};

// https://drafts.csswg.org/css-syntax-3/#consume-numeric-token
let consume_numeric = lexbuf => {
  // consume_number now returns (repr_string, kind) instead of (float_value, kind)
  let (number_str, _kind) = consume_number(lexbuf);

  if (check_if_three_codepoints_would_start_an_identifier(lexbuf)) {
    // Use dimension-aware identifier consumer to handle nth patterns correctly
    let.ok string =
      consume_identifier_for_dimension(lexbuf) |> handle_consume_identifier;
    // Determine if it's a float dimension or regular dimension based on unit type
    // TODO: is there any difference between float and regular dimension?
    is_float_unit(string)
      ? Ok(Parser.FLOAT_DIMENSION((number_str, string)))
      : Ok(Parser.DIMENSION((number_str, string)));
  } else {
    Ok(Parser.NUMBER(number_str));
  };
};

let consume = lexbuf => {
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
        /* TODO: Support id hash Ok(Tokens.HASH(string, `ID)); */
        Ok(Parser.HASH(string));
      | _ =>
        let.ok string =
          consume_identifier(lexbuf) |> handle_consume_identifier;
        Ok(Parser.HASH(string));
      /* TODO: Support unrestricted hash Ok(Tokens.HASH(string, `UNRESTRICTED)); */
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
      consume_ident_like(lexbuf);
    | _ =>
      let _ = Sedlexing.next(lexbuf);
      Ok(Parser.DELIM("-"));
    };
  switch%sedlex (lexbuf) {
  | variable =>
    Ok(
      Parser.INTERPOLATION(
        lexeme(~skip=2, ~drop=1, lexbuf) |> String.trim |> String.split_on_char('.'),
      ),
    )
  | whitespace => Ok(consume_whitespace(lexbuf))
  | "\"" => consume_string("\"", lexbuf)
  | "#" => consume_hash()
  | "'" => consume_string("'", lexbuf)
  | "(" => Ok(Parser.LEFT_PAREN)
  | ")" => Ok(Parser.RIGHT_PAREN)
  | "{" => Ok(Parser.LEFT_BRACE)
  | "}" => Ok(Parser.RIGHT_BRACE)
  | "+" =>
    Sedlexing.rollback(lexbuf);
    switch%sedlex (lexbuf) {
    | starts_a_number =>
      Sedlexing.rollback(lexbuf);
      consume_numeric(lexbuf);
    | _ =>
      let _ = Sedlexing.next(lexbuf);
      Ok(Parser.COMBINATOR("+"));
    };
  | "," => Ok(Parser.COMMA)
  | combinator => Ok(Parser.COMBINATOR(lexeme(lexbuf)))
  | "-" =>
    Sedlexing.rollback(lexbuf);
    consume_minus();
  | "." =>
    let _ = Sedlexing.backtrack(lexbuf);
    if (check_if_three_code_points_would_start_a_number(lexbuf)) {
      consume_numeric(lexbuf);
    } else {
      let _ = Sedlexing.next(lexbuf);
      Ok(Parser.DOT);
    };
  | ":" => Ok(Parser.COLON)
  | "::" => Ok(Parser.DOUBLE_COLON)
  | "*" => Ok(Parser.ASTERISK)
  | "&" => Ok(Parser.AMPERSAND)
  | "%" => Ok(Parser.PERCENT)
  | ";" => Ok(Parser.SEMI_COLON)
  | operator => Ok(Parser.OPERATOR(lexeme(lexbuf)))
  | "<=" => Ok(Parser.DELIM("<="))
  | ">=" => Ok(Parser.DELIM(">="))
  | "<" => Ok(Parser.DELIM("<"))
  | at_keyframes => Ok(Parser.AT_KEYFRAMES(lexeme(~skip=1, lexbuf)))
  | at_rule_without_body =>
    Ok(Parser.AT_RULE_STATEMENT(lexeme(~skip=1, lexbuf)))
  | at_rule => Ok(Parser.AT_RULE(lexeme(~skip=1, lexbuf)))
  | "@" => Ok(Parser.DELIM("@"))
  | "[" => Ok(Parser.LEFT_BRACKET)
  | "]" => Ok(Parser.RIGHT_BRACKET)
  | "\\" =>
    Sedlexing.rollback(lexbuf);
    switch%sedlex (lexbuf) {
    | starts_with_a_valid_escape =>
      Sedlexing.rollback(lexbuf);
      consume_ident_like(lexbuf);
    // TODO: this error should be different
    | _ => Error((Parser.DELIM("/"), Invalid_code_point))
    };
  | important => Ok(Parser.IMPORTANT)
  | digit =>
    let _ = Sedlexing.backtrack(lexbuf);
    consume_numeric(lexbuf);
  | identifier_start_code_point =>
    let _ = Sedlexing.backtrack(lexbuf);
    consume_ident_like(lexbuf);
  | eof => Ok(Parser.EOF)
  | any => Ok(Parser.DELIM(lexeme(lexbuf)))
  | _ => unreachable(lexbuf)
  };
};

type token_with_location = {
  txt: result(Parser.token, (Parser.token, Tokens.error)),
  loc: Ppxlib.Location.t,
};

let from_string = string => {
  let lexbuf = Sedlexing.Utf8.from_string(string);
  let rec read = acc => {
    let (loc_start, _) = Sedlexing.lexing_positions(lexbuf);
    let value = consume(lexbuf);
    let (_, loc_end) = Sedlexing.lexing_positions(lexbuf);

    let token_with_loc: token_with_location = {
      txt: value,
      loc: {
        loc_start,
        loc_end,
        loc_ghost: false,
      },
    };

    switch (value) {
    | Ok(EOF) => List.rev([token_with_loc, ...acc])
    | Ok(_) => read([token_with_loc, ...acc])
    | Error(_) => List.rev([token_with_loc, ...acc]) // Stop on error
    };
  };

  read([]);
};

let tokenize = input => {
  let buffer = Sedlexing.Utf8.from_string(input);
  let rec loop = acc => {
    let value = consume(buffer);
    let (loc_start, loc_end) = Sedlexing.lexing_positions(buffer);
    switch (value) {
    | Ok(Parser.EOF) => Ok(List.rev(acc))
    | Ok(token) => loop([(token, loc_start, loc_end), ...acc])
    | Error((_token, err)) =>
      let error_msg = Tokens.show_error(err);
      Error(error_msg);
    };
  };

  try(loop([])) {
  | LexingError((_start_pos, _end_pos, msg)) => Error(msg)
  };
};

let get_next_tokens_with_location = lexbuf => {
  let (position_start, _) = Sedlexing.lexing_positions(lexbuf);
  let result = consume(lexbuf);
  let (_, position_end) = Sedlexing.lexing_positions(lexbuf);

  // Handle Result type - return token regardless of Ok/Error
  let token =
    switch (result) {
    | Ok(tok) => tok
    | Error((tok, _err)) => tok // Return error token, store error in token_with_location
    };

  (token, position_start, position_end);
};

let render_token =
  fun
  | Parser.EOF => ""
  | t => Tokens.token_to_debug(t);

let position_to_string = pos =>
  Printf.sprintf(
    "[%d,%d+%d]",
    pos.Lexing.pos_lnum,
    pos.Lexing.pos_bol,
    pos.Lexing.pos_cnum - pos.Lexing.pos_bol,
  );

let debug_token = ((token, loc_start, loc_end)) => {
  let pos_start = position_to_string(loc_start);
  let pos_end = position_to_string(loc_end);
  Printf.sprintf(
    "%s %s..%s",
    Tokens.token_to_debug(token),
    pos_start,
    pos_end,
  );
};

let to_string = tokens =>
  tokens
  |> List.map(((t, _, _)) => render_token(t))
  |> String.concat(" ")
  |> String.trim;

let to_debug = tokens =>
  tokens |> List.map(debug_token) |> String.concat("\n") |> String.trim;
