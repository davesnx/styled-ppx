type t = Parser.token;

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

/* TODO: This should render Token, not Parser.token */
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
  | Parser.PERCENT => "%"
  | Parser.AMPERSAND => "&"
  | Parser.IMPORTANT => "!important"
  | Parser.IDENT(s)
  | Parser.TAG(s)
  | Parser.NUMBER(s)
  | Parser.UNICODE_RANGE(s)
  | Parser.OPERATOR(s)
  | Parser.COMBINATOR(s)
  | Parser.DELIM(s) => s
  | Parser.STRING(s) => "\"" ++ s ++ "\""
  | Parser.FLOAT_DIMENSION((n, unit))
  | Parser.DIMENSION((n, unit)) => n ++ unit
  | Parser.HASH(s) => "#" ++ s
  | Parser.FUNCTION(fn)
  | Parser.NTH_FUNCTION(fn) => fn ++ "("
  | Parser.URL(url) => url ++ "("
  | Parser.BAD_URL => "bad url"
  | Parser.BAD_IDENT => "bad ident"
  | Parser.WS => " "
  | Parser.DOT => "."
  | Parser.COMMA => ","
  | Parser.ASTERISK => "*"
  | Parser.AT_KEYFRAMES(s)
  | Parser.AT_RULE_STATEMENT(s)
  | Parser.AT_RULE(s) => "@" ++ s
  | Parser.INTERPOLATION(parts) => String.concat(".", parts);

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
  | Parser.PERCENT => "PERCENT"
  | Parser.AMPERSAND => "AMPERSAND"
  | Parser.IMPORTANT => "IMPORTANT"
  | Parser.IDENT(s) => "IDENT(\"" ++ s ++ "\")"
  | Parser.TAG(s) => "TAG(\"" ++ s ++ "\")"
  | Parser.STRING(s) => "STRING(\"" ++ s ++ "\")"
  | Parser.OPERATOR(s) => "OPERATOR(\"" ++ s ++ "\")"
  | Parser.DELIM(s) => "DELIM(\"" ++ s ++ "\")"
  | Parser.AT_RULE(s) => "AT_RULE(\"" ++ s ++ "\")"
  | Parser.AT_RULE_STATEMENT(s) => "AT_RULE_STATEMENT(\"" ++ s ++ "\")"
  | Parser.AT_KEYFRAMES(s) => "AT_KEYFRAMES(\"" ++ s ++ "\")"
  | Parser.HASH(s) => "HASH(\"" ++ s ++ "\")"
  | Parser.NUMBER(s) => "NUMBER(\"" ++ s ++ "\")"
  | Parser.UNICODE_RANGE(s) => "UNICODE_RANGE(\"" ++ s ++ "\")"
  | Parser.FLOAT_DIMENSION((n, s)) =>
    "FLOAT_DIMENSION(\"" ++ n ++ "', \"" ++ s ++ "\")"
  | Parser.DIMENSION((n, d)) => "DIMENSION(\"" ++ n ++ "\", \"" ++ d ++ "\")"
  | Parser.INTERPOLATION(v) => "VARIABLE(\"" ++ String.concat(".", v) ++ "\")"
  | Parser.COMBINATOR(s) => "COMBINATOR(" ++ s ++ ")"
  | Parser.DOT => "DOT"
  | Parser.COMMA => "COMMA"
  | Parser.WS => "WS"
  | Parser.ASTERISK => "ASTERISK"
  | Parser.FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | Parser.NTH_FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | Parser.URL(u) => "URL(" ++ u ++ ")"
  | Parser.BAD_URL => "BAD_URL"
  | Parser.BAD_IDENT => "BAD_IDENT";

let show_token = token_to_debug;
