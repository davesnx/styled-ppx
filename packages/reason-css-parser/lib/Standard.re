open Tokens;
open Combinator;
open Rule.Let;
open Rule.Pattern;

let keyword = string => expect(IDENT(string));
let comma = expect(COMMA);
let delim = string => expect(DELIM(string));
let function_call = (name, rule) => {
  let.bind_match () =
    token(
      fun
      | FUNCTION(called_name) when name == called_name => Ok()
      | token =>
        Error([
          "expected a function " ++ name ++ ". got an " ++ show_token(token),
        ]),
    );
  let.bind_match value = rule;
  let.bind_match () = expect(RIGHT_PAREN);
  Rule.Match.return(value);
};

let integer =
  token(
    fun
    | NUMBER(float) =>
      Float.(
        is_integer(float)
          ? Ok(float |> to_int)
          : Error(["expected an integer, received a float"])
      )
    | _ => Error(["expected an integer"]),
  );

let number =
  token(
    fun
    | NUMBER(float) => Ok(float)
    | token => Error(["expected a number, receveid " ++ show_token(token)]),
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
      | _ => Error(["unknown dimension"])
      }
    | NUMBER(0.) => Ok(`Zero)
    | _ => Error(["expected length"])
    }
  );

// https://drafts.csswg.org/css-values-4/#angles
let angle =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "deg" => Ok(`Deg(number))
      | "grad" => Ok(`Grad(number))
      | "rad" => Ok(`Rad(number))
      | "turn" => Ok(`Turn(number))
      | _ => Error(["unknown dimension"])
      }
    | NUMBER(0.) => Ok(`Deg(0.))
    | _ => Error(["expected angle"])
    }
  );

// https://drafts.csswg.org/css-values-4/#time
let time =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "s" => Ok(`S(number))
      | "ms" => Ok(`Ms(number))
      | _ => Error(["unknown time unit"])
      }
    | _ => Error(["expected time"])
    }
  );

// https://drafts.csswg.org/css-values-4/#frequency
let frequency =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension |> String.lowercase_ascii) {
      | "hz" => Ok(`Hz(number))
      | "khz" => Ok(`KHz(number))
      | dim => Error(["unknown dimension " ++ dim])
      }
    | token => Error(["expected frequency. got" ++ show_token(token)])
    }
  );

// https://drafts.csswg.org/css-values-4/#resolution
let resolution =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension |> String.lowercase_ascii) {
      | "dpi" => Ok(`Dpi(number))
      | "dpcm" => Ok(`Dpcm(number))
      | "x"
      | "dppx" => Ok(`Dppx(number))
      | _ => Error(["unknown dimension"])
      }
    | _ => Error(["expected resolution"])
    }
  );

// TODO: positive numbers like <number [0,infinity]>
let percentage =
  token(
    fun
    | PERCENTAGE(float) => Ok(float)
    | _ => Error(["expected percentage"]),
  );

// https://drafts.csswg.org/css-values-4/#css-identifier
// TODO: differences between <ident> and keyword
let ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | _ => Error(["expected an indentifier"]),
  );

// https://drafts.csswg.org/css-values-4/#textual-values
let css_wide_keywords =
  combine_xor([
    value(`Initial, keyword("initial")),
    value(`Inherit, keyword("inherit")),
    value(`Unset, keyword("unset")),
    value(`Revert, keyword("revert")),
    value(`RevertLayer, keyword("revert-layer")),
  ]);

// TODO: proper implement
// https://drafts.csswg.org/css-values-4/#custom-idents
let custom_ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | STRING(string) => Ok(string)
    | _ => Error(["expected an identifier"]),
  );

// https://drafts.csswg.org/css-values-4/#dashed-idents
let dashed_ident =
  token(
    fun
    | IDENT(string) when String.sub(string, 0, 2) == "--" => Ok(string)
    | _ => Error(["expected a --variable"]),
  );

// https://drafts.csswg.org/css-values-4/#strings
let string =
  token(
    fun
    | STRING(string) => Ok(string)
    | _ => Error(["expected a string"]),
  );

// TODO: <url-modifier>
// https://drafts.csswg.org/css-values-4/#urls
let url = {
  let url_token =
    token(
      fun
      | URL(url) => Ok(url)
      | _ => Error(["expected a url"]),
    );
  let url_fun = function_call("url", string);
  combine_xor([url_token, url_fun]);
};

// css-color-4
// https://drafts.csswg.org/css-color-4/#hex-notation
let hex_color =
  token(
    fun
    | HASH(str, _) when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(str)
    | _ => Error(["expected a hex-color"]),
  );

/* <interpolation>, It's not part of the spec.
     It's the implementation/workaround to inject Reason variables into CSS definitions.
     `$()` only supports variables and Module accessors to variables.
     In compile-time the bs-css bindings would enforce the types of those variables.
   */
let interpolation = {
  open Rule;
  open Rule.Let;

  let.bind_match _ = Pattern.expect(DELIM("$"));
  let.bind_match _ = Pattern.expect(LEFT_PAREN);
  let.bind_match path = {
    let.bind_match path =
      Modifier.zero_or_more(
        {
          let.bind_match ident = ident;
          let.bind_match _ = Pattern.expect(DELIM("."));
          Match.return(ident);
        },
      );
    let.bind_match ident = ident;
    Match.return(path @ [ident]);
  };
  let.bind_match _ = Pattern.expect(RIGHT_PAREN);

  Match.return(path);
};

/* [%value.rec "'[' [ <custom-ident> ]* ']'"] */
let line_names = {
  open Rule;
  open Rule.Let;

  let.bind_match left = Pattern.expect(LEFT_BRACKET);
  let.bind_match path =
    Modifier.zero_or_more(
      {
        let.bind_match ident = custom_ident;
        Match.return(ident);
      },
    );
  let.bind_match right = Pattern.expect(RIGHT_BRACKET);

  return_match((left, path, right));
};

let flex_value =
  token(
    fun
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "fr" => Ok(`Fr(number))
      | _ => Error(["only fr dimension is valid"])
      }
    | _ => Error(["expected flex_value"]),
  );
