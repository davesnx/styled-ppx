[@deriving show]
type token =
  | LITERAL(string)
  | DATA((string, option(Ast.range)))
  | PROPERTY(string)
  | DOUBLE_AMPERSAND
  | DOUBLE_BAR
  | BAR
  | LEFT_BRACKET
  | RIGHT_BRACKET
  | ASTERISK
  | PLUS
  | QUESTION_MARK
  | RANGE(
      (
        [
          | `Comma
          | `Space
        ],
        int,
        option(int),
      ),
    )
  | EXCLAMATION_POINT
  | LEFT_PARENS
  | RIGHT_PARENS
  | CHAR(string)
  | EOF;
