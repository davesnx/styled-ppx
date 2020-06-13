include Parser;
open Combinator;
open Standard;
open Rule.Match;

let parse = (prop, str) => {
  let (output, _) =
    Sedlexing.Utf8.from_string(str) |> Lexer.read_all |> prop;
  output;
};
let parse_property = prop =>
  map(prop, value => `Property_value(value))
  lxor map(css_wide_keywords, value => `Css_wide_value(value))
  |> parse;
