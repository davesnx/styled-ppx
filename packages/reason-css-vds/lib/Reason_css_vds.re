include Ast;

let provider = (buf, ()) => {
  let token = Lexer.tokenizer(buf);
  let (start, stop) = Sedlexing.lexing_positions(buf);
  (token, start, stop);
};

let multiplier_of_lex =
  MenhirLib.Convert.Simplified.traditional2revised(Parser.multiplier_of_lex);
let rec multiplier_to_string =
  fun
  | One => ""
  | Zero_or_more => "*"
  | One_or_more => "+"
  | Optional => "?"
  | Repeat(min, Some(max)) when min == max =>
    "{" ++ string_of_int(min) ++ "}"
  | Repeat(min, Some(max)) =>
    "{" ++ string_of_int(min) ++ "," ++ string_of_int(max) ++ "}"
  | Repeat(min, None) => "{" ++ string_of_int(min) ++ ",}"
  | Repeat_by_comma(1, None) => "#"
  | Repeat_by_comma(min, max) =>
    "#" ++ multiplier_to_string(Repeat(min, max))
  | At_least_one => "!";
let _multiplier_of_string = string =>
  Sedlexing.Utf8.from_string(string) |> provider |> multiplier_of_lex;

let value_of_lex =
  MenhirLib.Convert.Simplified.traditional2revised(Parser.value_of_lex);
let rec value_to_string = value => {
  let child_needs_brackets = (parent, child) => {
    let precedence =
      fun
      | Combinator(Static, _) => Some(0)
      | Combinator(And, _) => Some(1)
      | Combinator(Or, _) => Some(2)
      | Combinator(Xor, _) => Some(3)
      | _ => None;

    let parent = precedence(parent);
    let child = precedence(child);

    switch (parent, child) {
    | (_, None) => false
    | (None, _) => false
    | (Some(parent), Some(child)) => child > parent
    };
  };
  let child = child =>
    child_needs_brackets(value, child)
      ? "[ " ++ value_to_string(child) ++ " ]" : value_to_string(child);
  let childs = (sep, childs) =>
    childs |> List.map(child) |> String.concat(sep);
  let (string, multiplier) =
    switch (value) {
    | Terminal(kind, multiplier) =>
      let full_name =
        switch (kind) {
        | Keyword(name) => "'" ++ name ++ "'"
        | Data_type(name) => "<" ++ name ++ ">"
        | Property_type(name) => "<'" ++ name ++ "'>"
        };
      (full_name, Some(multiplier));
    | Combinator(kind, values) =>
      let separator =
        switch (kind) {
        | Static => " "
        | And => " && "
        | Or => " || "
        | Xor => " | "
        };
      (childs(separator, values), None);
    | Group(value, multiplier) => (child(value), Some(multiplier))
    | Function_call(name, value) => (
        name ++ "( " ++ child(value) ++ " )",
        None,
      )
    };

  switch (value, multiplier) {
  | (Group(_), None) => "[ " ++ string ++ " ]"
  | (Group(_), Some(multiplier)) =>
    "[ " ++ string ++ " ]" ++ multiplier_to_string(multiplier)
  | (_, None)
  | (_, Some(One)) => string
  | (_, Some(multiplier)) =>
    "[ " ++ string ++ " ]" ++ multiplier_to_string(multiplier)
  };
};
let value_of_string = string =>
  Sedlexing.Utf8.from_string(string) |> provider |> value_of_lex;
