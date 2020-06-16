open Tokens;
open Combinator;
open Rule.Let;
open Rule.Pattern;

let keyword = string => expect(STRING(string));
let function_call = (name, rule) => {
  let.bind_match () = keyword(name);
  let.bind_match () = expect(LEFT_PARENS);
  let.bind_match value = rule;
  let.bind_match () = expect(RIGHT_PARENS);
  return_match(value);
};

type integer = int;
let integer =
  token(
    fun
    | INT(int) => Ok(int)
    | _ => Error("expected an integer"),
  );

type number = float;
let number =
  token(
    fun
    | INT(int) => Ok(int |> float_of_int)
    | _ => Error("expected a number"),
  );

type percentage = number;
let percentage = {
  let.bind_match number = number;
  let.bind_match () = expect(PERCENT);
  return_match(number);
};

let css_wide_keywords =
  combine_xor([
    value(`Initial, keyword("initial")),
    value(`Inherit, keyword("inherit")),
    value(`Unset, keyword("unset")),
  ]);
