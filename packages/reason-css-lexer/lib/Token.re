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
  | RIGHT_CURLY; // <}-token>

type error =
  | Invalid_code_point
  | Eof
  | New_line;

let show_error = fun
  | Invalid_code_point => "Invalid code point"
  | Eof => "Unexpected end"
  | New_line => "New line";
