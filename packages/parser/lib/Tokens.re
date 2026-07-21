[@deriving show({ with_path: false })]
type token =
  | EOF
  | IDENT(string) // <ident-token>
  | TYPE_SELECTOR(string) // <type-selector-token>
  | FUNCTION(string) // <function-token>
  | NTH_FUNCTION(string) // <function-token> (nth-*)
  | AT_KEYWORD(string) // <at-keyword-token>
  | AT_KEYFRAMES(string) // <at-keyframes-token> (non-standard)
  | AT_RULE(string) // <at-rule-token> (non-standard)
  | AT_RULE_STATEMENT(string) // <at-rule-statement-token> (non-standard)
  | UNICODE_RANGE(string) // <unicode-range-token>
  | HASH(
      (
        string,
        [
          | `ID
          | `UNRESTRICTED
        ],
      ),
    ) // <hash-token>
  | STRING(string) // <string-token>
  | URL(string) // <url-token>
  | INTERPOLATION((string, [@opaque] Ppxlib.Location.t)) // <interpolation-token> (non-standard)
  | DELIM(string) // <delim-token> for all delimiter characters
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION((float, string)) // <dimension-token>
  | DESCENDANT_COMBINATOR // whitespace as selector combinator
  | CDO // <CDO-token> "<!--"
  | CDC // <CDC-token> "-->"
  | WS // <whitespace-token>
  | COLON // <colon-token>
  | DOUBLE_COLON // <double-colon-token>
  | IMPORTANT // <important-token>
  | SEMI_COLON // <semicolon-token>
  | COMMA // <comma-token>
  | LEFT_BRACKET // <[-token>
  | RIGHT_BRACKET // <]-token>
  | LEFT_PAREN // <(-token>
  | RIGHT_PAREN // <)-token>
  | LEFT_BRACE // <{-token>
  | RIGHT_BRACE; // <}-token>;

let string_of_char = c => String.make(1, c);

// Re-encode lexer-decoded byte strings into the canonical CSS
// double-quoted form. The lexer (consume_string) decodes source
// escapes and stores raw bytes; the renderer must re-encode them or
// the emitted CSS will be malformed.
//
// CSS Syntax serialization rules require the following bytes to be
// escaped inside a <string-token>:
//   - U+0000 NUL          -> replaced with U+FFFD REPLACEMENT CHARACTER
//   - U+0001..U+001F      -> hex escape (e.g. \A for LF, \D for CR)
//   - U+007F DEL          -> hex escape \7F
//   - U+0022 double-quote -> \"
//   - U+005C backslash    -> \\
//
// Hex escapes are emitted with a trailing space so the next character
// is not consumed as another hex digit (CSS hex escapes are 1-6 hex
// digits and consume an optional trailing whitespace as terminator).
//
// String.iter walks bytes, not codepoints, which is correct here: the
// only escapable bytes are ASCII, and UTF-8 continuation/lead bytes
// (>= 0x80) fall through the catch-all and pass through verbatim,
// preserving multi-byte sequences.
//
// We always emit double quotes -- CSS treats single- and double-quoted
// strings as equivalent, so this is observably identical for any
// conforming consumer.

// Whether [c] requires escaping in a CSS <string-token>'s output.
let needs_string_escape = c =>
  c == '"'
  || c == '\\'
  || Char.code(c) < 0x20
  || Char.code(c) == 0x7F
  || Char.code(c) == 0x00;

// Append the escaped form of [c] (which must satisfy [needs_string_escape])
// to [buf]. The two-digit hex form is enough for U+007F and below.
let add_escaped_char = (buf, c) =>
  switch (c) {
  | '"' => Buffer.add_string(buf, "\\\"")
  | '\\' => Buffer.add_string(buf, "\\\\")
  | '\000' => Buffer.add_string(buf, "\xEF\xBF\xBD") // U+FFFD
  | c => Buffer.add_string(buf, Printf.sprintf("\\%X ", Char.code(c)))
  };

// Append the escaped contents of [s] (without surrounding quotes) to [buf].
let add_escaped_string = (buf, s) =>
  for (i in 0 to String.length(s) - 1) {
    let c = String.unsafe_get(s, i);
    if (needs_string_escape(c)) {
      add_escaped_char(buf, c);
    } else {
      Buffer.add_char(buf, c);
    };
  };

// Whether [s] contains any byte that needs escaping. Fast-path for the
// common case (no escaping needed) avoids the buffer allocation.
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

// CSSOM "serialize an identifier"
// (https://drafts.csswg.org/cssom/#serialize-an-identifier).
//
// The lexer decodes escape sequences while consuming identifiers
// (consume_escaped), so identifiers are stored "cooked": an input of
// `.w-1\/2` stores the class name `w-1/2`. On the way out we must
// re-escape any code point that would not survive re-tokenization,
// otherwise rendered CSS with such identifiers is invalid.
//
// This walks code points, not bytes: the lexer's ident set excludes some
// non-ASCII code points (e.g. U+0080-U+00B6), which must render as hex
// escapes or our own re-parse rejects them.

let is_ascii_ident_char = c =>
  c == '-'
  || c == '_'
  || c >= '0'
  && c <= '9'
  || c >= 'a'
  && c <= 'z'
  || c >= 'A'
  && c <= 'Z';

let is_digit = c => c >= '0' && c <= '9';

// Mirrors the lexer's `non_ascii` ident set (Lexer.re); keep in sync.
let is_non_ascii_ident_code_point = cp =>
  cp == 0xB7
  || cp >= 0xC0
  && cp <= 0xD6
  || cp >= 0xD8
  && cp <= 0xF6
  || cp >= 0xF8
  && cp <= 0x37D
  || cp >= 0x37F
  && cp <= 0x1FFF
  || cp == 0x200C
  || cp == 0x200D
  || cp == 0x203F
  || cp == 0x2040
  || cp >= 0x2070
  && cp <= 0x218F
  || cp >= 0x2C00
  && cp <= 0x2FEF
  || cp >= 0x3001
  && cp <= 0xD7FF
  || cp >= 0xF900
  && cp <= 0xFDCF
  || cp >= 0xFDF0
  && cp <= 0xFFFD
  || cp > 0x10000;

// Decode the UTF-8 code point at byte [i]; (-1, 1) on malformed input,
// which is passed through raw (identifiers come from Sedlexing.Utf8 and
// are well-formed in practice).
let utf8_decode = (s, i) => {
  let n = String.length(s);
  let byte = k => Char.code(String.unsafe_get(s, k));
  let b0 = byte(i);
  if (b0 < 0x80) {
    (b0, 1);
  } else if (b0 < 0xC2) {
    ((-1), 1);
  } else if (b0 < 0xE0 && i + 1 < n) {
    ((b0 land 0x1F) lsl 6 lor (byte(i + 1) land 0x3F), 2);
  } else if (b0 < 0xF0 && i + 2 < n) {
    (
      (b0 land 0x0F)
      lsl 12
      lor (byte(i + 1) land 0x3F)
      lsl 6
      lor (byte(i + 2) land 0x3F),
      3,
    );
  } else if (b0 < 0xF5 && i + 3 < n) {
    (
      (b0 land 0x07)
      lsl 18
      lor (byte(i + 1) land 0x3F)
      lsl 12
      lor (byte(i + 2) land 0x3F)
      lsl 6
      lor (byte(i + 3) land 0x3F),
      4,
    );
  } else {
    ((-1), 1);
  };
};

// Fast path: pure-ASCII identifiers needing no escaping. Anything with a
// non-ASCII byte takes the code-point path.
let needs_ident_serialization = s => {
  let len = String.length(s);
  if (len == 0) {
    false;
  } else if (len == 1 && String.unsafe_get(s, 0) == '-') {
    true;
  } else {
    let rec scan = i =>
      if (i >= len) {
        false;
      } else {
        let c = String.unsafe_get(s, i);
        let plain =
          is_ascii_ident_char(c)
          && !(i == 0 && is_digit(c))
          && !(i == 1 && is_digit(c) && String.unsafe_get(s, 0) == '-');
        plain ? scan(i + 1) : true;
      };
    scan(0);
  };
};

let serialize_identifier = s =>
  if (!needs_ident_serialization(s)) {
    s;
  } else if (s == "-") {
    "\\-";
  } else {
    let len = String.length(s);
    let buf = Buffer.create(len + 4);
    let hex_escape = cp =>
      Buffer.add_string(buf, Printf.sprintf("\\%x ", cp));
    let rec go = (i, index) =>
      if (i < len) {
        let (cp, width) = utf8_decode(s, i);
        if (cp == 0x00) {
          Buffer.add_string(
            buf,
            "\xEF\xBF\xBD" // U+FFFD
          );
        } else if (cp > 0x00 && cp < 0x20 || cp == 0x7F) {
          hex_escape(cp);
        } else if (cp >= Char.code('0')
                   && cp <= Char.code('9')
                   && (index == 0 || index == 1 && s.[0] == '-')) {
          hex_escape(cp);
        } else if (cp < 0x80) {
          if (is_ascii_ident_char(Char.chr(cp))) {
            Buffer.add_char(buf, Char.chr(cp));
          } else {
            Buffer.add_char(buf, '\\');
            Buffer.add_char(buf, Char.chr(cp));
          };
        } else if (cp == (-1) || is_non_ascii_ident_code_point(cp)) {
          Buffer.add_substring(buf, s, i, width);
        } else {
          hex_escape(cp);
        };
        go(i + width, index + 1);
      };
    go(0, 0);
    Buffer.contents(buf);
  };

// Serialize a URI value as url("..."). CSS allows unquoted url()
// tokens, but the renderer never emits them, and the quoted form is
// safe for arbitrary bytes once the inner string is properly escaped.
// Single-pass into one buffer to avoid the intermediate allocations of
// "url(" ++ serialize_string(s) ++ ")".
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
  /* Structural tokens */
  | "(" => Some(LEFT_PAREN)
  | ")" => Some(RIGHT_PAREN)
  | "[" => Some(LEFT_BRACKET)
  | "]" => Some(RIGHT_BRACKET)
  | "{" => Some(LEFT_BRACE)
  | "}" => Some(RIGHT_BRACE)
  | ":" => Some(COLON)
  | ";" => Some(SEMI_COLON)
  | "," => Some(COMMA)
  /* Single-character delimiters */
  | s when String.length(s) == 1 => Some(DELIM(s))
  | _ => None;

let humanize =
  fun
  | EOF => "the end"
  | IDENT(s) => s
  | TYPE_SELECTOR(s) => s
  | FUNCTION(fn) => Printf.sprintf("%s(", fn)
  | NTH_FUNCTION(fn) => Printf.sprintf("%s(", fn)
  | AT_KEYWORD(s) => Printf.sprintf("@%s", s)
  | AT_KEYFRAMES(s) => Printf.sprintf("@%s", s)
  | AT_RULE_STATEMENT(s) => Printf.sprintf("@%s", s)
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
  | DESCENDANT_COMBINATOR => " "
  | CDO => "<!--"
  | CDC => "-->"
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
  | TYPE_SELECTOR(s) => Printf.sprintf("TYPE_SELECTOR('%s')", s)
  | STRING(s) => Printf.sprintf("STRING('%s')", s)
  | FUNCTION(fn) => Printf.sprintf("FUNCTION(%s)", fn)
  | NTH_FUNCTION(fn) => Printf.sprintf("NTH_FUNCTION(%s)", fn)
  | URL(u) => Printf.sprintf("URL(%s)", u)
  | AT_KEYWORD(s) => Printf.sprintf("AT_KEYWORD('%s')", s)
  | AT_KEYFRAMES(s) => Printf.sprintf("AT_KEYFRAMES('%s')", s)
  | AT_RULE_STATEMENT(s) => Printf.sprintf("AT_RULE_STATEMENT('%s')", s)
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
  | DESCENDANT_COMBINATOR => "DESCENDANT_COMBINATOR"
  | CDO => "CDO"
  | CDC => "CDC"
  | WS => "WS";
