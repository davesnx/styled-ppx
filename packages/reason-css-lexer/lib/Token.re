[@deriving show({with_path: false})]
type token =
  | EOF
  | IDENT(string) // <ident-token>
  | BAD_IDENT // TODO: this is needed?
  | FUNCTION(string) // <function-token>
  | AT_KEYWORD(string) // <at-keyword-token>
  | HASH(string, [ | `ID | `UNRESTRICTED]) // <hash-token>
  | STRING(string) // <string-token>
  | BAD_STRING(string) // <bad-string-token>
  | URL(string) // <url-token>
  | BAD_URL // <bad-url-token>
  | DELIM(string) // <delim-token>
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION(float, string) // <dimension-token>
  | WHITESPACE // <whitespace-token>
  | CDO // <CDO-token>
  | CDC // <CDC-token>
  | COLON // <colon-token>
  | SEMICOLON // <semicolon-token>
  | COMMA // <comma-token>
  | LEFT_SQUARE // <[-token>
  | RIGHT_SQUARE // <]-token>
  | LEFT_PARENS // <(-token>
  | RIGHT_PARENS // <)-token>
  | LEFT_CURLY // <{-token>
  | RIGHT_CURLY // <}-token>
;

let string_of_char = c => String.make(1, c);

let humanize = fun
  | EOF => "the end"
  | IDENT(str) => "ident " ++ str
  | BAD_IDENT => "bad ident"
  | FUNCTION(f) => "function " ++ f
  | AT_KEYWORD(at) => "@ " ++ at
  | HASH(h, _) => "hash: #" ++ h
  | STRING(s) => {|string "|} ++ s ++ {|"|}
  | BAD_STRING(_) => "bad string"
  | URL(u) => "url " ++ u
  | BAD_URL => "bad url"
  | DELIM(d) => "delimiter " ++ d
  | NUMBER(f) => "number: " ++ string_of_float(f)
  | PERCENTAGE(f) => "percentage: " ++ string_of_float(f) ++ string_of_char('%')
  | DIMENSION(f, s) => "dimension: " ++ string_of_float(f) ++ s
  | WHITESPACE => "whitespace"
  | CDO => "<!--"
  | CDC => "-->"
  | COLON => ":"
  | SEMICOLON => ";"
  | COMMA => ","
  | LEFT_SQUARE => "["
  | RIGHT_SQUARE => "]"
  | LEFT_PARENS => "("
  | RIGHT_PARENS => ")"
  | LEFT_CURLY => "{"
  | RIGHT_CURLY => "}";

type error =
  | Invalid_code_point
  | Eof
  | New_line;

let show_error = fun
  | Invalid_code_point => "Invalid code point"
  | Eof => "Unexpected end"
  | New_line => "New line";
