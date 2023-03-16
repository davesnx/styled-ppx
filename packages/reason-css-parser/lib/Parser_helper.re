open Rule.Pattern;
open Reason_css_lexer;
open Standard;

module StringMap = Map.Make(String);

let (let.ok) = Result.bind;

let apply_parser = (parser, tokens_with_loc) => {
  open Reason_css_lexer;

  let tokens =
    tokens_with_loc
    |> List.map(({Location.txt, _}) =>
         switch (txt) {
         | Ok(token) => token
         | Error((token, _)) => token
         }
       )
    |> List.rev;

  let tokens_without_ws = tokens |> List.filter((!=)(WHITESPACE));

  let (output, remaining_tokens) = parser(tokens_without_ws);
  let.ok output =
    switch (output) {
    | Ok(data) => Ok(data)
    | Error([message, ..._]) => Error(message)
    | Error([]) => Error("weird")
    };
  let.ok () =
    switch (remaining_tokens) {
    | []
    | [EOF] => Ok()
    | tokens =>
      let tokens = tokens |> List.map(show_token) |> String.concat(", ");
      Error("tokens remaining: " ++ tokens);
    };
  Ok(output);
};

let parse = (rule_parser: Rule.rule('a), str) => {
  let.ok tokens_with_loc =
    Reason_css_lexer.from_string(str) |> Result.map_error(_ => "frozen");

  apply_parser(rule_parser, tokens_with_loc);
};

let check = (prop: Rule.rule('a), value) =>
  parse(prop, value) |> Result.is_ok;

// TODO: workarounds
let invalid = expect(STRING("not-implemented"));
let attr_name = invalid;
let attr_fallback = invalid;
let string_token = invalid;
let ident_token = invalid;
let dimension = invalid;
let declaration_value = invalid;
let positive_integer = integer;
let function_token = invalid;
let any_value = invalid;
let hash_token = invalid;
let zero = invalid;
let custom_property_name = invalid;
let declaration_list = invalid;
let name_repeat = invalid;
let ratio = invalid;
let an_plus_b = invalid;
let declaration = invalid;
let y = invalid;
let x = invalid;
let decibel = invalid;
let urange = invalid;
let semitones = invalid;
let url_token = invalid;
