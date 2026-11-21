[@deriving show({ with_path: false })]
type token =
  | EOF
  | IDENT(string)
  | FUNCTION(string)
  | NTH_FUNCTION(string)
  | AT_KEYFRAMES(string)
  | AT_RULE(string)
  | UNICODE_RANGE(string)
  | HASH(
      (
        string,
        [
          | `ID
          | `UNRESTRICTED
        ],
      ),
    )
  | STRING(string)
  | URL(string)
  | INTERPOLATION((string, [@opaque] Ppxlib.Location.t))
  | DELIM(string)
  | NUMBER(float)
  | PERCENTAGE(float)
  | DIMENSION((float, string))
  | WS
  | COLON
  | DOUBLE_COLON
  | IMPORTANT
  | SEMI_COLON
  | COMMA
  | LEFT_BRACKET
  | RIGHT_BRACKET
  | LEFT_PAREN
  | RIGHT_PAREN
  | LEFT_BRACE
  | RIGHT_BRACE;

let string_of_char = c => String.make(1, c);

let needs_string_escape = c =>
  c == '"'
  || c == '\\'
  || Char.code(c) < 0x20
  || Char.code(c) == 0x7F
  || Char.code(c) == 0x00;

let add_escaped_char = (buf, c) =>
  switch (c) {
  | '"' => Buffer.add_string(buf, "\\\"")
  | '\\' => Buffer.add_string(buf, "\\\\")
  | '\000' => Buffer.add_string(buf, "\xEF\xBF\xBD")
  | c => Buffer.add_string(buf, Printf.sprintf("\\%X ", Char.code(c)))
  };

let add_escaped_string = (buf, s) =>
  for (i in 0 to String.length(s) - 1) {
    let c = String.unsafe_get(s, i);
    if (needs_string_escape(c)) {
      add_escaped_char(buf, c);
    } else {
      Buffer.add_char(buf, c);
    };
  };

let needs_string_serialization = s => {
  let len = String.length(s);
  let rec scan = i =>
    if (i >= len) {
      false;
    } else if (needs_string_escape(String.unsafe_get(s, i))) {
      true;
    } else {
      scan(i + 1);
    };
  scan(0);
};

let serialize_string = s =>
  if (!needs_string_serialization(s)) {
    "\"" ++ s ++ "\"";
  } else {
    let buf = Buffer.create(String.length(s) + 4);
    Buffer.add_char(buf, '"');
    add_escaped_string(buf, s);
    Buffer.add_char(buf, '"');
    Buffer.contents(buf);
  };

let serialize_uri = s =>
  if (!needs_string_serialization(s)) {
    "url(\"" ++ s ++ "\")";
  } else {
    let buf = Buffer.create(String.length(s) + 8);
    Buffer.add_string(buf, "url(\"");
    add_escaped_string(buf, s);
    Buffer.add_string(buf, "\")");
    Buffer.contents(buf);
  };

let serialize_identifier = ident => {
  let len = String.length(ident);
  let buf = Buffer.create(len);
  let is_digit = c => c >= '0' && c <= '9';
  let is_name_char = c =>
    is_digit(c)
    || c >= 'a'
    && c <= 'z'
    || c >= 'A'
    && c <= 'Z'
    || c == '-'
    || c == '_'
    || Char.code(c) >= 0x80;
  let escape_as_code_point = c =>
    Buffer.add_string(buf, Printf.sprintf("\\%x ", Char.code(c)));
  for (i in 0 to len - 1) {
    let c = ident.[i];
    let code = Char.code(c);
    if (code <= 0x1f || code == 0x7f) {
      escape_as_code_point(c);
    } else if (is_digit(c) && (i == 0 || i == 1 && ident.[0] == '-')) {
      escape_as_code_point(c);
    } else if (c == '-' && len == 1) {
      Buffer.add_string(buf, "\\-");
    } else if (is_name_char(c)) {
      Buffer.add_char(buf, c);
    } else {
      Buffer.add_char(buf, '\\');
      Buffer.add_char(buf, c);
    };
  };
  Buffer.contents(buf);
};

let float_to_string = value => {
  let raw = string_of_float(value);
  let has_dot = String.contains(raw, '.');
  if (!has_dot) {
    raw;
  } else {
    let len = String.length(raw);
    let rec drop_zeros = idx =>
      idx > 0 && raw.[idx - 1] == '0' ? drop_zeros(idx - 1) : idx;
    let trimmed_len = drop_zeros(len);
    let trimmed_len =
      trimmed_len > 0 && raw.[trimmed_len - 1] == '.'
        ? trimmed_len - 1 : trimmed_len;
    trimmed_len == len ? raw : String.sub(raw, 0, trimmed_len);
  };
};

type error =
  | Invalid_code_point
  | Eof
  | New_line
  | Bad_url
  | Bad_ident
  | Invalid_delim
  | Unclosed_interpolation
  | Unclosed_string_in_interpolation
  | Unclosed_char_in_interpolation
  | Unclosed_comment_in_interpolation
  | Unclosed_brace_in_interpolation;

let show_error =
  fun
  | Invalid_code_point => "Invalid escape sequence"
  | Eof => "Unexpected end of input"
  | New_line => "Unexpected newline in string"
  | Bad_url => "Invalid URL"
  | Bad_ident => "Invalid identifier"
  | Invalid_delim => "Invalid delimiter"
  | Unclosed_interpolation => "Unclosed interpolation: expected ')' to close"
  | Unclosed_string_in_interpolation => "Unclosed string literal inside interpolation"
  | Unclosed_char_in_interpolation => "Unclosed char literal inside interpolation"
  | Unclosed_comment_in_interpolation => "Unclosed comment inside interpolation"
  | Unclosed_brace_in_interpolation => "Unclosed brace inside interpolation";

let token_of_delimiter_string =
  fun
  | "(" => Some(LEFT_PAREN)
  | ")" => Some(RIGHT_PAREN)
  | "[" => Some(LEFT_BRACKET)
  | "]" => Some(RIGHT_BRACKET)
  | "{" => Some(LEFT_BRACE)
  | "}" => Some(RIGHT_BRACE)
  | ":" => Some(COLON)
  | ";" => Some(SEMI_COLON)
  | "," => Some(COMMA)
  | s when String.length(s) == 1 => Some(DELIM(s))
  | _ => None;

let humanize =
  fun
  | EOF => "the end"
  | IDENT(s) => s
  | FUNCTION(fn) => Printf.sprintf("%s(", fn)
  | NTH_FUNCTION(fn) => Printf.sprintf("%s(", fn)
  | AT_KEYFRAMES(s) => Printf.sprintf("@%s", s)
  | AT_RULE(s) => Printf.sprintf("@%s", s)
  | UNICODE_RANGE(s) => s
  | HASH((s, _)) => Printf.sprintf("#%s", s)
  | STRING(s) => Printf.sprintf("'%s'", s)
  | URL(url) => Printf.sprintf("url(%s)", url)
  | INTERPOLATION((v, _)) => Printf.sprintf("$(%s)", v)
  | DELIM(s) => s
  | NUMBER(n) => float_to_string(n)
  | PERCENTAGE(n) => Printf.sprintf("%s%%", float_to_string(n))
  | DIMENSION((n, d)) => Printf.sprintf("%s%s", float_to_string(n), d)
  | WS => " "
  | COLON => ":"
  | DOUBLE_COLON => "::"
  | IMPORTANT => "!important"
  | SEMI_COLON => ";"
  | COMMA => ","
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}";

let to_debug =
  fun
  | EOF => "EOF"
  | LEFT_BRACE => "LEFT_BRACE"
  | RIGHT_BRACE => "RIGHT_BRACE"
  | LEFT_PAREN => "LEFT_PAREN"
  | RIGHT_PAREN => "RIGHT_PAREN"
  | LEFT_BRACKET => "LEFT_BRACKET"
  | RIGHT_BRACKET => "RIGHT_BRACKET"
  | COLON => "COLON"
  | DOUBLE_COLON => "DOUBLE_COLON"
  | SEMI_COLON => "SEMI_COLON"
  | COMMA => "COMMA"
  | IMPORTANT => "IMPORTANT"
  | IDENT(s) => Printf.sprintf("IDENT('%s')", s)
  | STRING(s) => Printf.sprintf("STRING('%s')", s)
  | FUNCTION(fn) => Printf.sprintf("FUNCTION(%s)", fn)
  | NTH_FUNCTION(fn) => Printf.sprintf("NTH_FUNCTION(%s)", fn)
  | URL(u) => Printf.sprintf("URL(%s)", u)
  | AT_KEYFRAMES(s) => Printf.sprintf("AT_KEYFRAMES('%s')", s)
  | AT_RULE(s) => Printf.sprintf("AT_RULE('%s')", s)
  | HASH((s, kind)) => {
      let kind =
        switch (kind) {
        | `ID => "ID"
        | `UNRESTRICTED => "UNRESTRICTED"
        };
      Printf.sprintf("HASH('%s', %s)", s, kind);
    }
  | NUMBER(n) => Printf.sprintf("NUMBER(%s)", float_to_string(n))
  | PERCENTAGE(n) => Printf.sprintf("PERCENTAGE(%s)", float_to_string(n))
  | DIMENSION((n, d)) =>
    Printf.sprintf("DIMENSION(%s, %s)", float_to_string(n), d)
  | UNICODE_RANGE(s) => Printf.sprintf("UNICODE_RANGE('%s')", s)
  | INTERPOLATION((v, _)) => Printf.sprintf("INTERPOLATION('%s')", v)
  | DELIM(s) => Printf.sprintf("DELIM('%s')", s)
  | WS => "WS";
