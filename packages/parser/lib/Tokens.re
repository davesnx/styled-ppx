[@deriving show({ with_path: false })]
type token =
  | EOF
  | IDENT(string) // <ident-token> - in value context
  | TYPE_SELECTOR(string) // <type-selector-token> - in selector context (div, span, etc.)
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
  | INTERPOLATION((string, [@opaque] Ppxlib.Location.t)) // <interpolation-token> (non-standard) - (content, content_location)
  | DELIM(char) // <delim-token> for unknown single characters
  | DOT // '.'
  | ASTERISK // '*'
  | AMPERSAND // '&'
  | PLUS // '+'
  | MINUS // '-'
  | TILDE // '~'
  | GREATER_THAN // '>'
  | LESS_THAN // '<'
  | EQUALS // '='
  | SLASH // '/'
  | EXCLAMATION // '!'
  | PIPE // '|'
  | CARET // '^'
  | DOLLAR_SIGN // '$'
  | QUESTION_MARK // '?'
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION((float, string)) // <dimension-token>
  | DESCENDANT_COMBINATOR // whitespace as selector combinator (div span)
  | WS // <whitespace-token> in value context
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
  | RIGHT_BRACE // <}-token>
  | GTE
  | LTE;

let string_of_char = c => String.make(1, c);

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
  | "." => Some(DOT)
  | "*" => Some(ASTERISK)
  | "&" => Some(AMPERSAND)
  | "+" => Some(PLUS)
  | "-" => Some(MINUS)
  | "~" => Some(TILDE)
  | ">" => Some(GREATER_THAN)
  | "<" => Some(LESS_THAN)
  | "=" => Some(EQUALS)
  | "/" => Some(SLASH)
  | "!" => Some(EXCLAMATION)
  | "|" => Some(PIPE)
  | "^" => Some(CARET)
  | "$" => Some(DOLLAR_SIGN)
  | "?" => Some(QUESTION_MARK)
  | "#" => Some(DELIM('#'))
  | "@" => Some(DELIM('@'))
  | s when String.length(s) == 1 => Some(DELIM(s.[0]))
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
  | DELIM(c) => String.make(1, c)
  | DOT => "."
  | ASTERISK => "*"
  | AMPERSAND => "&"
  | PLUS => "+"
  | MINUS => "-"
  | TILDE => "~"
  | GREATER_THAN => ">"
  | LESS_THAN => "<"
  | EQUALS => "="
  | SLASH => "/"
  | EXCLAMATION => "!"
  | PIPE => "|"
  | CARET => "^"
  | DOLLAR_SIGN => "$"
  | QUESTION_MARK => "?"
  | NUMBER(n) => float_to_string(n)
  | PERCENTAGE(n) => Printf.sprintf("%s%%", float_to_string(n))
  | DIMENSION((n, d)) => Printf.sprintf("%s%s", float_to_string(n), d)
  | DESCENDANT_COMBINATOR => " "
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
  | RIGHT_BRACE => "}"
  | GTE => ">="
  | LTE => "<=";

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
  | DELIM(c) => Printf.sprintf("DELIM('%c')", c)
  | DOT => "DOT"
  | ASTERISK => "ASTERISK"
  | AMPERSAND => "AMPERSAND"
  | PLUS => "PLUS"
  | MINUS => "MINUS"
  | TILDE => "TILDE"
  | GREATER_THAN => "GREATER_THAN"
  | LESS_THAN => "LESS_THAN"
  | EQUALS => "EQUALS"
  | SLASH => "SLASH"
  | EXCLAMATION => "EXCLAMATION"
  | PIPE => "PIPE"
  | CARET => "CARET"
  | DOLLAR_SIGN => "DOLLAR_SIGN"
  | QUESTION_MARK => "QUESTION_MARK"
  | DESCENDANT_COMBINATOR => "DESCENDANT_COMBINATOR"
  | WS => "WS"
  | GTE => "GTE"
  | LTE => "LTE";
