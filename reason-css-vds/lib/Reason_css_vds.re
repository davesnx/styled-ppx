include Ast;

let provider = (buf, ()) => {
  let token = Lexer.read(buf);
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
      | Keyword(_, _)
      | Data_type(_, _)
      | Property_type(_, _) => None
      | Group(_) => None
      | Static(_) => Some(0)
      | And(_) => Some(1)
      | Or(_) => Some(2)
      | Xor(_) => Some(3);

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

  let (string, multiplier) =
    switch (value) {
    | Keyword(name, m) => (name, Some(m))
    | Data_type(name, m) => ("<" ++ name ++ ">", Some(m))
    | Property_type(name, m) => ("<'" ++ name ++ "'>", Some(m))
    | Group(v1, m) => (child(v1), Some(m))
    | Static(v1, v2) => (child(v1) ++ " " ++ child(v2), None)
    | And(v1, v2) => (child(v1) ++ " && " ++ child(v2), None)
    | Or(v1, v2) => (child(v1) ++ " || " ++ child(v2), None)
    | Xor(v1, v2) => (child(v1) ++ " | " ++ child(v2), None)
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
