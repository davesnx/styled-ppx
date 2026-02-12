open Sedlexing.Utf8;
open Tokens;

let whitespace = [%sedlex.regexp? Plus(' ' | '\t' | '\n')];
let digit = [%sedlex.regexp? '0' .. '9'];
let number = [%sedlex.regexp? (Opt('+' | '-'), Plus(digit))];
let range_restriction = [%sedlex.regexp?
  (
    '[',
    Opt(' '),
    number | 0x221E /* ∞ */ | ('-', 0x221E),
    ',',
    Opt(' '),
    number | 0x221E | ('-', 0x221E),
    Opt(' '),
    ']',
  )
];

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

let parse_range_bound = str => {
  let str = String.trim(str);
  switch (str) {
  | "∞"
  | "+∞" => Ast.Infinity
  | "-∞" => Ast.Neg_infinity
  | s => Ast.Int_bound(int_of_string(s))
  };
};

let parse_range_restriction = str => {
  let inner = String.sub(str, 1, String.length(str) - 2);
  switch (String.split_on_char(',', inner)) {
  | [min_s, max_s] =>
    Some((parse_range_bound(min_s), parse_range_bound(max_s)))
  | _ => None
  };
};

let eat_literal = buf => {
  switch%sedlex (buf) {
  | literal => LITERAL(lexeme(buf))
  | single_token_literal => LITERAL(lexeme(buf))
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
  RANGE((kind, min, max));
};

let rec tokenizer = buf =>
  switch%sedlex (buf) {
  | whitespace => tokenizer(buf)
  | property => PROPERTY(lexeme(buf) |> slice(2, -2))
  | data =>
    let content = lexeme(buf) |> slice(1, -1);
    let (name, range) =
      switch (String.index_opt(content, ' ')) {
      | None => (content, None)
      | Some(idx) =>
        let name = String.sub(content, 0, idx);
        let rest =
          String.trim(
            String.sub(content, idx, String.length(content) - idx),
          );
        let range =
          if (String.length(rest) > 0 && rest.[0] == '[') {
            parse_range_restriction(rest);
          } else {
            None;
          };
        (name, range);
      };
    DATA((name, range));
  | '*' => ASTERISK
  | '+' => PLUS
  | '?' => QUESTION_MARK
  | '#' => RANGE((`Comma, 1, None))
  | range => eat_range(lexeme(buf))
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
  | quoted_delimiter => CHAR(lexeme(buf) |> slice(1, -1))
  | string => LITERAL(lexeme(buf) |> slice(1, -1))
  | eof => EOF
  | _ => eat_literal(buf)
  };
