open Location;

let pp_loc = (v, fmt, {txt, _}) => v(fmt, txt);

[@deriving show]
type token =
  | EOF
  | IDENT(string) // <ident-token>
  | FUNCTION(string) // <function-token>
  | AT_KEYWORD(string) // <at-keyword-token>
  | HASH((string, [ | `ID | `UNRESTRICTED])) // <hash-token>
  | STRING(string) // <string-token>
  | URL(string) // <url-token>
  | DELIM(string) // <delim-token>
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION((float, string)) // <dimension-token>
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

[@deriving show]
type simple_block_kind =
  | Square
  | Parens
  | Curly
and component_value = token
and prelude = list(loc(component_value))
and value = list(loc(token))
and block = list(loc(block_value))
and block_value =
  | Declaration(declaration)
  | Rule(rule)
and rule_kind =
  | Style
  | At(loc(string))
and declaration = {
  name: loc(string),
  value: loc(value),
  important: loc(bool),
}
and rule = {
  kind: rule_kind,
  prelude: loc(prelude),
  block: loc(block),
}

and stylesheet = list(rule);

type selector =
  | Value;
