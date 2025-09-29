let lexeme = Sedlexing.Utf8.lexeme;

// TODO: is rgb(255 255 255/0) valid?
let whitespace = [%sedlex.regexp? Plus(' ' | '\t' | '\n')];
let digit = [%sedlex.regexp? '0' .. '9'];
/* TODO: number should contain infinity "∞" */
let number = [%sedlex.regexp? (Opt('+' | '-'), digit)];
let range_restriction = [%sedlex.regexp? ('[', number, ',', number, ']')];

let stop_literal = [%sedlex.regexp?
  ' ' | '\t' | '\n' | '?' | '!' | '*' | '+' | '#' | '{' | ']' | '(' | ')' | ','
];
let literal = [%sedlex.regexp? Star(Sub(any, stop_literal))];
let string = [%sedlex.regexp? ('\'', Plus(Sub(any, '\'')), '\'')];
let single_token_literal = [%sedlex.regexp? ',' | '{'];

let delimiters = [%sedlex.regexp?
  '-' | ',' | ';' | ':' | '.' | '(' | ')' | '[' | ']' | '{' | '}' | '*' | '/' |
  '^' |
  '+' |
  '<' |
  '=' |
  '>' |
  '|' |
  '~' |
  '$'
];
let quoted_delimiter = [%sedlex.regexp? ('\'', delimiters, '\'')];

let data = [%sedlex.regexp?
  ("<", Plus(Sub(any, '>')), Opt(range_restriction), ">")
];
let property = [%sedlex.regexp? ("<'", Plus(Sub(any, '\'')), "'>")];

let range = [%sedlex.regexp?
  (Opt('#'), '{', Plus(digit), Opt(',', Star(digit)), '}')
];

let slice = (start, end_, string) => {
  let len = String.length(string);
  let end_ = len - start + end_;
  String.sub(string, start, end_);
};

let eat_literal = buf => {
  switch%sedlex (buf) {
  | literal => Tokens.LITERAL(lexeme(buf))
  | single_token_literal => Tokens.LITERAL(lexeme(buf))
  | _ => failwith("something is wrong here")
  };
};

let eat_range = str => {
  let int = int_of_string;

  let (kind, starts_at) = str.[0] == '#' ? (`Comma, 2) : (`Space, 1);
  let content = str |> slice(starts_at, -1);
  let (min, max) =
    switch (String.split_on_char(',', content)) {
    | [min] => (int(min), Some(int(min)))
    | [min, ""] => (int(min), None)
    | [min, max] => (int(min), Some(int(max)))
    | _ => failwith("cannot understand " ++ content)
    };
  Tokens.RANGE((kind, min, max));
};

let rec tokenizer = buf =>
  switch%sedlex (buf) {
  | whitespace => tokenizer(buf)
  | property => Tokens.PROPERTY(lexeme(buf) |> slice(2, -2))
  | data =>
    switch (lexeme(buf) |> slice(1, -1) |> String.split_on_char(' ')) {
    | [value, ..._] => Tokens.DATA(value)
    | [] => failwith("unreachable")
    }
  | '*' => Tokens.ASTERISK
  | '+' => Tokens.PLUS
  | '?' => Tokens.QUESTION_MARK
  | '#' => Tokens.RANGE((`Comma, 1, None))
  | range => eat_range(lexeme(buf))
  | '!' => Tokens.EXCLAMATION_POINT
  // combinators
  | "&&" => Tokens.DOUBLE_AMPERSAND
  | "||" => Tokens.DOUBLE_BAR
  | "|" => Tokens.BAR
  | "[" => Tokens.LEFT_BRACKET
  | "]" => Tokens.RIGHT_BRACKET
  // functions
  | '(' => Tokens.LEFT_PARENS
  | ')' => Tokens.RIGHT_PARENS
  | quoted_delimiter => Tokens.CHAR(lexeme(buf) |> slice(1, -1))
  | string => Tokens.LITERAL(lexeme(buf) |> slice(1, -1))
  | eof => Tokens.EOF
  | _ => eat_literal(buf)
  };
