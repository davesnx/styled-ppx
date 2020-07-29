open Sedlexing.Utf8;
open Tokens;

// TODO: is rgb(255 255 255/0) valid?
let whitespace = [%sedlex.regexp? Plus(' ' | '\t' | '\n')];
let digit = [%sedlex.regexp? '0'..'9'];
let number = [%sedlex.regexp? (Opt('+' | '-'), digit | "∞")];
let range_restriction = [%sedlex.regexp? ('[', number, ',', number, ']')];

let stop_literal = [%sedlex.regexp?
  ' ' | '\t' | '\n' | '?' | '!' | '*' | '+' | '#' | '{' | ']' | '(' | ')' | ','
];

let literal = [%sedlex.regexp? Plus(Sub(any, stop_literal))];
let string = [%sedlex.regexp? ('\'', Plus(Sub(any, '\'')), '\'')];

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

let range = str => {
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
  RANGE((kind, min, max));
};

let literal = buf =>
  switch%sedlex (buf) {
  | literal => LITERAL(lexeme(buf))
  | ',' => LITERAL(",")
  | _ => failwith("something is wrong here")
  };

let rec tokenizer = buf =>
  switch%sedlex (buf) {
  | whitespace => tokenizer(buf)
  | property => PROPERTY(lexeme(buf) |> slice(2, -2))
  | data =>
    switch (lexeme(buf) |> slice(1, -1) |> String.split_on_char(' ')) {
    | [value, ..._] => DATA(value)
    | [] => failwith("unreachable")
    }
  | '*' => ASTERISK
  | '+' => PLUS
  | '?' => QUESTION_MARK
  | '#' => RANGE((`Comma, 1, None))
  | range => range(lexeme(buf))
  | '!' => EXCLAMATION_POINT
  // combinators
  | "&&" => DOUBLE_AMPERSAND
  | "||" => DOUBLE_BAR
  | "|" => BAR
  | "[" => LEFT_BRACKET
  | "]" => RIGHT_BRACKET
  // functions
  | '(' => LEFT_PARENS
  | ')' => RIGHT_PARENS
  | string => LITERAL(lexeme(buf) |> slice(1, -1))
  | eof => EOF
  | _ => literal(buf)
  };
