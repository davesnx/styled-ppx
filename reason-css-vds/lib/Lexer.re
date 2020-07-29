open Sedlexing.Utf8;
open Tokens;

// TODO: is rgb(255 255 255/0) valid?
let whitespace = [%sedlex.regexp? Plus(' ' | '\t' | '\n')];
let digit = [%sedlex.regexp? '0'..'9'];
let number = [%sedlex.regexp? (Opt('+' | '-'), digit | "∞")];
let range_restriction = [%sedlex.regexp? ('[', number, ',', number, ']')];

let stop_literal = [%sedlex.regexp?
  ' ' | '\t' | '\n' | '?' | '!' | '*' | '+' | '#' | '{' | ']'
];

let data = [%sedlex.regexp? ("<", Plus(any), Opt(range_restriction), ">")];
let function_ = [%sedlex.regexp? ("<", Plus(any), "()>")];
let property = [%sedlex.regexp? ("<'", Plus(any), ">'")];

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

let literal_and_string = buf => {
  let rec string = () => {
    switch (Sedlexing.next(buf)) {
    // TODO: escaping
    | Some(char) when char == Uchar.of_char('\'') => ()
    | Some(_) => string()
    | None => ()
    };
  };
  let rec literal = acc =>
    switch%sedlex (buf) {
    | stop_literal =>
      Sedlexing.rollback(buf);
      acc;
    | any => literal(acc ++ lexeme(buf))
    | _ => acc
    };

  switch%sedlex (buf) {
  | '\'' =>
    string();
    LITERAL(lexeme(buf) |> slice(1, -1));
  | _ => LITERAL(literal(""))
  };
};
let rec tokenizer = buf =>
  switch%sedlex (buf) {
  | whitespace => tokenizer(buf)
  | property => PROPERTY(lexeme(buf) |> slice(2, -2))
  | function_ => FUNCTION(lexeme(buf) |> slice(1, -3))
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
  | eof => EOF
  | _ => literal_and_string(buf)
  };
