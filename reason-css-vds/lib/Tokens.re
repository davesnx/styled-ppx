[@deriving show]
type token =
  // literals
  | LITERAL(string) // auto 'auto'
  | DATA(string) // <number>
  | FUNCTION(string) // <rgb()>
  | PROPERTY(string) // <'color'>
  | OPEN_FUNCTION(string) // rgb(
  | CLOSE_FUNCTION // )
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
  | EOF;
