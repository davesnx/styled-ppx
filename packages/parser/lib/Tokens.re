[@deriving show({with_path: false})]
type token =
  | EOF
  | IDENT(string) // <ident-token>
  | BAD_IDENT // TODO: this is needed?
  | FUNCTION(string) // <function-token>
  | AT_KEYWORD(string) // <at-keyword-token>
  | HASH(string, [ | `ID | `UNRESTRICTED]) // <hash-token>
  | STRING(string) // <string-token>
  | URL(string) // <url-token>
  | BAD_URL // <bad-url-token>
  | DELIM(string) // <delim-token>
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION(float, string) // <dimension-token>
  | WS // <whitespace-token>
  | COLON // <colon-token>
  | SEMI_COLON // <semicolon-token>
  | COMMA // <comma-token>
  | LEFT_BRACKET // <[-token>
  | RIGHT_BRACKET // <]-token>
  | LEFT_PAREN // <(-token>
  | RIGHT_PAREN // <)-token>
  | LEFT_BRACE // <{-token>
  | RIGHT_BRACE; // <}-token>

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

let humanize =
  fun
  | EOF => "the end"
  | IDENT(str) => "ident " ++ str
  | BAD_IDENT => "bad ident"
  | FUNCTION(f) => "function " ++ f
  | AT_KEYWORD(at) => "@ " ++ at
  | HASH(h, _) => "hash: #" ++ h
  | STRING(s) => {|string "|} ++ s ++ {|"|}
  | URL(u) => "url " ++ u
  | BAD_URL => "bad url"
  | DELIM(d) => "delimiter " ++ d
  | NUMBER(f) => "number: " ++ string_of_float(f)
  | PERCENTAGE(f) =>
    "percentage: " ++ string_of_float(f) ++ string_of_char('%')
  | DIMENSION(f, s) => "dimension: " ++ string_of_float(f) ++ s
  | WS => "whitespace"
  | COLON => ":"
  | SEMI_COLON => ";"
  | COMMA => ","
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}";

module Parser = Css_parser;

let token_to_string =
  fun
  | Parser.EOF => ""
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | COLON => ":"
  | DOUBLE_COLON => "::"
  | SEMI_COLON => ";"
  | PERCENT => "%"
  | AMPERSAND => "&"
  | IMPORTANT => "!important"
  | IDENT(s) => s
  | TAG(s) => s
  | STRING(s) => "'" ++ s ++ "'"
  | OPERATOR(s) => s
  | COMBINATOR(s)
  | DELIM(s) => s
  | EQUAL_SIGN(s) => s
  | MEDIA_QUERY_OPERATOR(s) => s
  | SCREEN_MEDIA_TYPE(s) => s
  | PRINT_MEDIA_TYPE(s) => s
  | ALL_MEDIA_TYPE(s) => s
  | MEDIA_FEATURE_COMPARISON(s) => s
  | AT_MEDIA(s)
  | AT_KEYFRAMES(s)
  | AT_RULE_STATEMENT(s)
  | AT_RULE(s) => "@" ++ s
  | HASH(s) => "#" ++ s
  | NUMBER(s) => s
  | UNICODE_RANGE(s) => s
  | FLOAT_DIMENSION((n, s)) => n ++ s
  | DIMENSION((n, d)) => n ++ d
  | INTERPOLATION(v) => String.concat(".", v)
  | WS => " "
  | DOT => "."
  | COMMA => ","
  | ASTERISK => "*"
  | FUNCTION(fn) => fn ++ "("
  | NTH_FUNCTION(fn) => fn ++ "("
  | URL(url) => url ++ "("
  | BAD_URL => "bad url"
  | BAD_IDENT => "bad indent";

let token_to_debug =
  fun
  | Parser.EOF => "EOF"
  | LEFT_BRACE => "LEFT_BRACE"
  | RIGHT_BRACE => "RIGHT_BRACE"
  | LEFT_PAREN => "LEFT_PAREN"
  | RIGHT_PAREN => "RIGHT_PAREN"
  | LEFT_BRACKET => "LEFT_BRACKET"
  | RIGHT_BRACKET => "RIGHT_BRACKET"
  | COLON => "COLON"
  | DOUBLE_COLON => "DOUBLE_COLON"
  | SEMI_COLON => "SEMI_COLON"
  | PERCENT => "PERCENTAGE"
  | AMPERSAND => "AMPERSAND"
  | IMPORTANT => "IMPORTANT"
  | IDENT(s) => "IDENT('" ++ s ++ "')"
  | TAG(s) => "TAG('" ++ s ++ "')"
  | STRING(s) => "STRING('" ++ s ++ "')"
  | OPERATOR(s) => "OPERATOR('" ++ s ++ "')"
  | DELIM(s) => "DELIM('" ++ s ++ "')"
  | EQUAL_SIGN(s) => "EQUAL_SIGN('" ++ s ++ "')"
  | MEDIA_QUERY_OPERATOR(s) => "MEDIA_QUERY_OPERATOR('" ++ s ++ "')"
  | AT_RULE(s) => "AT_RULE('" ++ s ++ "')"
  | AT_RULE_STATEMENT(s) => "AT_RULE_STATEMENT('" ++ s ++ "')"
  | AT_MEDIA(s) => "AT_MEDIA('" ++ s ++ "')"
  | SCREEN_MEDIA_TYPE(s) => "SCREEN('" ++ s ++ "')"
  | PRINT_MEDIA_TYPE(s) => "PRINT('" ++ s ++ "')"
  | ALL_MEDIA_TYPE(s) => "ALL('" ++ s ++ "')"
  | MEDIA_FEATURE_COMPARISON(s) => "MEDIA_FEATURE_COMPARISON('" ++ s ++ "')"
  | AT_KEYFRAMES(s) => "AT_KEYFRAMES('" ++ s ++ "')"
  | HASH(s) => "HASH('" ++ s ++ "')"
  | NUMBER(s) => "NUMBER('" ++ s ++ "')"
  | UNICODE_RANGE(s) => "UNICODE_RANGE('" ++ s ++ "')"
  | FLOAT_DIMENSION((n, s)) => "FLOAT_DIMENSION('" ++ n ++ ", " ++ s ++ "')"
  | DIMENSION((n, d)) => "DIMENSION('" ++ n ++ ", " ++ d ++ "')"
  | INTERPOLATION(v) => "VARIABLE('" ++ String.concat(".", v) ++ "')"
  | COMBINATOR(s) => "COMBINATOR(" ++ s ++ ")"
  | DOT => "DOT"
  | COMMA => "COMMA"
  | WS => "WS"
  | ASTERISK => "ASTERISK"
  | FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | NTH_FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | URL(u) => "URL(" ++ u ++ ")"
  | BAD_URL => "BAD_URL"
  | BAD_IDENT => "BAD_IDENT";
