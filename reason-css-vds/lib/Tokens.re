[@deriving show]
type token =
  // literals
  | LITERAL(string) // auto 'auto'
  | DATA(string) // <number>
  | FUNCTION(string) // <rgb()>
  | PROPERTY(string) // <'color'>
  // combinators
  | DOUBLE_AMPERSAND // &&
  | DOUBLE_BAR // ||
  | BAR // |
  | LEFT_BRACKET // [
  | RIGHT_BRACKET // ]
  // modifiers
  | ASTERISK // *
  | PLUS // +
  | QUESTION_MARK // ?
  | RANGE(([ | `Comma | `Space], int, option(int))) // {1} {1,} {1, 2} #{1}
  | EXCLAMATION_POINT // !
  // for functions
  | LEFT_PARENS // (
  | RIGHT_PARENS // )
  | EOF;
