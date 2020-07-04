open Reason_css_lexer;
open Combinator;
open Rule.Let;
open Rule.Pattern;
open Rule.Match;

let (let.ok) = Result.bind;

let keyword = string => expect(IDENT(string));
let function_call = (name, rule) => {
  let.bind_match () = keyword(name);
  let.bind_match () = expect(LEFT_PARENS);
  let.bind_match value = rule;
  let.bind_match () = expect(RIGHT_PARENS);
  return_match((name, value));
};

let integer =
  token(
    fun
    | NUMBER(float) =>
      Float.(
        is_integer(float)
          ? Ok(float |> to_int)
          : Error("expected an integer, received a float")
      )
    | _ => Error("expected an integer"),
  );

let number =
  token(
    fun
    | NUMBER(float) => Ok(float)
    | token => Error("expected a number, receveid " ++ show_token(token)),
  );

let length =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "em" => Ok(`Em(number))
      | "ex" => Ok(`Ex(number))
      | "cap" => Ok(`Cap(number))
      | "ch" => Ok(`Ch(number))
      | "ic" => Ok(`Ic(number))
      | "rem" => Ok(`Rem(number))
      | "lh" => Ok(`Lh(number))
      | "rlh" => Ok(`Rlh(number))
      | "vw" => Ok(`Vw(number))
      | "vh" => Ok(`Vh(number))
      | "vi" => Ok(`Vi(number))
      | "vb" => Ok(`Vb(number))
      | "vmin" => Ok(`Vmin(number))
      | "vmax" => Ok(`Vmax(number))
      // absolute
      | "cm" => Ok(`Cm(number))
      | "mm" => Ok(`Mm(number))
      | "Q" => Ok(`Q(number))
      | "in" => Ok(`In(number))
      | "pt" => Ok(`Pt(number))
      | "pc" => Ok(`Pc(number))
      | "px" => Ok(`Px(number))
      | _ => Error("unknown dimension")
      }
    | NUMBER(0.) => Ok(`Zero)
    | _ => Error("expected length")
    }
  );

// TODO: positive numbers like <number [0,infinity]>
let percentage =
  token(
    fun
    | PERCENTAGE(float) => Ok(float)
    | _ => Error("expected percentage"),
  );

let length_percentage =
  combine_xor([
    map(length, v => `Length(v)),
    map(percentage, v => `Percentage(v)),
  ]);

// TODO: proper implement https://drafts.csswg.org/css-values-4/#custom-idents
let custom_ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | _ => Error("expected an identifier"),
  );

let string =
  token(
    fun
    | STRING(string) => Ok(string)
    | _ => Error("expected a string"),
  );

// https://drafts.csswg.org/css-values-4/#textual-values
let css_wide_keywords =
  combine_xor([
    value(`Initial, keyword("initial")),
    value(`Inherit, keyword("inherit")),
    value(`Unset, keyword("unset")),
  ]);
