type t = Parser.token;

[@deriving show({ with_path: false })]
type token =
  | EOF
  | WS
  | IDENT(string)
  | FUNCTION(string)
  | NTH_FUNCTION(string)
  | AT_RULE(string)
  | AT_RULE_STATEMENT(string)
  | AT_KEYFRAMES(string)
  | HASH(string)
  | STRING(string)
  | URL(string)
  | DELIM(string)
  | NUMBER(string)
  | FLOAT_DIMENSION((string, string))
  | DIMENSION((string, string))
  | UNICODE_RANGE(string)
  | TAG(string)
  | OPERATOR(string)
  | COMBINATOR(string)
  | INTERPOLATION(list(string))
  | COLON
  | SEMI_COLON
  | COMMA
  | DOT
  | DOUBLE_COLON
  | LEFT_BRACKET
  | RIGHT_BRACKET
  | LEFT_PAREN
  | RIGHT_PAREN
  | LEFT_BRACE
  | RIGHT_BRACE
  | PERCENT
  | AMPERSAND
  | ASTERISK
  | IMPORTANT
  | GTE
  | LTE;

let string_of_char = c => String.make(1, c);

type error =
  | Invalid_code_point
  | Eof
  | New_line;

let show_error =
  fun
  | Invalid_code_point => "Invalid code point"
  | Eof => "Unexpected end"
  | New_line => "New line";

let humanize_local_token =
  fun
  | EOF => "the end"
  | WS => "whitespace"
  | IDENT(s) => "ident " ++ s
  | FUNCTION(f) => "function " ++ f ++ "("
  | NTH_FUNCTION(f) => "function " ++ f ++ "("
  | AT_RULE(s) => "@" ++ s
  | AT_RULE_STATEMENT(s) => "@" ++ s
  | AT_KEYFRAMES(s) => "@" ++ s
  | HASH(h) => "hash: #" ++ h
  | STRING(s) => {|string "|} ++ s ++ {|"|}
  | URL(u) => "url(" ++ u ++ ")"
  | DELIM(d) => "delimiter " ++ d
  | NUMBER(n) => "number: " ++ n
  | FLOAT_DIMENSION((n, u)) => "dimension: " ++ n ++ u
  | DIMENSION((n, u)) => "dimension: " ++ n ++ u
  | UNICODE_RANGE(r) => "unicode-range: " ++ r
  | TAG(t) => t
  | OPERATOR(o) => o
  | COMBINATOR(c) => c
  | INTERPOLATION(parts) => "$(" ++ String.concat(".", parts) ++ ")"
  | COLON => ":"
  | SEMI_COLON => ";"
  | COMMA => ","
  | DOT => "."
  | DOUBLE_COLON => "::"
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}"
  | PERCENT => "%"
  | AMPERSAND => "&"
  | ASTERISK => "*"
  | IMPORTANT => "!important"
  | GTE => ">="
  | LTE => "<=";

let humanize: t => string =
  fun
  | Parser.EOF => "the end"
  | Parser.IDENT(str) => str
  | Parser.TAG(str) => str
  | Parser.BAD_IDENT => "bad ident"
  | Parser.FUNCTION(f) => f ++ "("
  | Parser.NTH_FUNCTION(f) => f ++ "("
  | Parser.AT_KEYFRAMES(at)
  | Parser.AT_RULE(at)
  | Parser.AT_RULE_STATEMENT(at) => "@" ++ at
  | Parser.HASH(h) => "#" ++ h
  | Parser.STRING(s) => "\"" ++ s ++ "\""
  | Parser.URL(u) => "url(" ++ u ++ ")"
  | Parser.BAD_URL => "bad url"
  | Parser.DELIM(d) => d
  | Parser.NUMBER(s)
  | Parser.UNICODE_RANGE(s) => s
  | Parser.FLOAT_DIMENSION((num, unit)) => num ++ unit
  | Parser.DIMENSION((num, unit)) => num ++ unit
  | Parser.WS => "whitespace"
  | Parser.COLON => ":"
  | Parser.SEMI_COLON => ";"
  | Parser.COMMA => ","
  | Parser.LEFT_BRACKET => "["
  | Parser.RIGHT_BRACKET => "]"
  | Parser.LEFT_PAREN => "("
  | Parser.RIGHT_PAREN => ")"
  | Parser.LEFT_BRACE => "{"
  | Parser.RIGHT_BRACE => "}"
  | Parser.ASTERISK => "*"
  | Parser.DOUBLE_COLON => "::"
  | Parser.DOT => "."
  | Parser.COMBINATOR(s)
  | Parser.OPERATOR(s) => s
  | Parser.AMPERSAND => "&"
  | Parser.IMPORTANT => "!important"
  | Parser.INTERPOLATION(parts) => String.concat(".", parts)
  | Parser.PERCENT => "%";

let to_string =
  fun
  | EOF => ""
  | WS => " "
  | IDENT(s) => s
  | FUNCTION(fn) => fn ++ "("
  | NTH_FUNCTION(fn) => fn ++ "("
  | AT_RULE(s) => "@" ++ s
  | AT_RULE_STATEMENT(s) => "@" ++ s
  | AT_KEYFRAMES(s) => "@" ++ s
  | HASH(s) => "#" ++ s
  | STRING(s) => "'" ++ s ++ "'"
  | URL(url) => "url(" ++ url ++ ")"
  | DELIM(s) => s
  | NUMBER(s) => s
  | FLOAT_DIMENSION((n, u)) => n ++ u
  | DIMENSION((n, u)) => n ++ u
  | UNICODE_RANGE(s) => s
  | TAG(s) => s
  | OPERATOR(s) => s
  | COMBINATOR(s) => s
  | INTERPOLATION(v) => "$(" ++ String.concat(".", v) ++ ")"
  | COLON => ":"
  | SEMI_COLON => ";"
  | COMMA => ","
  | DOT => "."
  | DOUBLE_COLON => "::"
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}"
  | PERCENT => "%"
  | AMPERSAND => "&"
  | ASTERISK => "*"
  | IMPORTANT => "!important"
  | GTE => ">="
  | LTE => "<=";

let to_debug =
  fun
  | EOF => "EOF"
  | WS => "WS"
  | IDENT(s) => "IDENT('" ++ s ++ "')"
  | FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | NTH_FUNCTION(fn) => "NTH_FUNCTION(" ++ fn ++ ")"
  | AT_RULE(s) => "AT_RULE('" ++ s ++ "')"
  | AT_RULE_STATEMENT(s) => "AT_RULE_STATEMENT('" ++ s ++ "')"
  | AT_KEYFRAMES(s) => "AT_KEYFRAMES('" ++ s ++ "')"
  | HASH(s) => "HASH('" ++ s ++ "')"
  | STRING(s) => "STRING('" ++ s ++ "')"
  | URL(u) => "URL(" ++ u ++ ")"
  | DELIM(s) => "DELIM('" ++ s ++ "')"
  | NUMBER(s) => "NUMBER('" ++ s ++ "')"
  | FLOAT_DIMENSION((n, u)) => "FLOAT_DIMENSION('" ++ n ++ ", " ++ u ++ "')"
  | DIMENSION((n, u)) => "DIMENSION('" ++ n ++ ", " ++ u ++ "')"
  | UNICODE_RANGE(s) => "UNICODE_RANGE('" ++ s ++ "')"
  | TAG(s) => "TAG('" ++ s ++ "')"
  | OPERATOR(s) => "OPERATOR('" ++ s ++ "')"
  | COMBINATOR(s) => "COMBINATOR(" ++ s ++ ")"
  | INTERPOLATION(v) => "INTERPOLATION('" ++ String.concat(".", v) ++ "')"
  | COLON => "COLON"
  | SEMI_COLON => "SEMI_COLON"
  | COMMA => "COMMA"
  | DOT => "DOT"
  | DOUBLE_COLON => "DOUBLE_COLON"
  | LEFT_BRACKET => "LEFT_BRACKET"
  | RIGHT_BRACKET => "RIGHT_BRACKET"
  | LEFT_PAREN => "LEFT_PAREN"
  | RIGHT_PAREN => "RIGHT_PAREN"
  | LEFT_BRACE => "LEFT_BRACE"
  | RIGHT_BRACE => "RIGHT_BRACE"
  | PERCENT => "PERCENT"
  | AMPERSAND => "AMPERSAND"
  | ASTERISK => "ASTERISK"
  | IMPORTANT => "IMPORTANT"
  | GTE => "GTE"
  | LTE => "LTE";
