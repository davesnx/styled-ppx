open Styled_ppx_css_parser.Tokens;
open Rule.Let;
open Rule.Pattern;

let keyword =
  fun
  | "<=" => expect(LTE)
  | ">=" => expect(GTE)
  | s => expect(IDENT(s));

let comma = expect(COMMA);
let delim =
  fun
  | "(" => expect(LEFT_PAREN)
  | ")" => expect(RIGHT_PAREN)
  | "[" => expect(LEFT_BRACKET)
  | "]" => expect(RIGHT_BRACKET)
  | ":" => expect(COLON)
  | ";" => expect(SEMI_COLON)
  | s => expect(DELIM(s));
let function_call = (name, rule) => {
  let.bind_match () =
    token(
      fun
      | FUNCTION(called_name) when name == called_name => Ok()
      | token =>
        Error([
          "Expected 'function "
          ++ name
          ++ "'. Got '"
          ++ humanize(token)
          ++ "' instead.",
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
          : Error(["Expected an integer, got a float instead."])
      )
    | _ => Error(["Expected an integer."]),
  );

let number =
  token(
    fun
    | NUMBER(float) => Ok(float)
    | token =>
      Error(["Expected a number. Got '" ++ humanize(token) ++ "' instead."]),
  );

let length =
  token(token =>
    switch (token) {
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "cap" => Ok(`Cap(number))
      | "ch" => Ok(`Ch(number))
      | "em" => Ok(`Em(number))
      | "ex" => Ok(`Ex(number))
      | "ic" => Ok(`Ic(number))
      | "lh" => Ok(`Lh(number))
      | "rcap" => Ok(`Rcap(number))
      | "rch" => Ok(`Rch(number))
      | "rem" => Ok(`Rem(number))
      | "rex" => Ok(`Rex(number))
      | "ric" => Ok(`Ric(number))
      | "rlh" => Ok(`Rlh(number))
      | "vh" => Ok(`Vh(number))
      | "vw" => Ok(`Vw(number))
      | "vmax" => Ok(`Vmax(number))
      | "vmin" => Ok(`Vmin(number))
      | "vb" => Ok(`Vb(number))
      | "vi" => Ok(`Vi(number))
      | "cqw" => Ok(`Cqw(number))
      | "cqh" => Ok(`Cqh(number))
      | "cqi" => Ok(`Cqi(number))
      | "cqb" => Ok(`Cqb(number))
      | "cqmin" => Ok(`Cqmin(number))
      | "cqmax" => Ok(`Cqmax(number))
      // absolute
      | "px" => Ok(`Px(number))
      | "cm" => Ok(`Cm(number))
      | "mm" => Ok(`Mm(number))
      | "Q" => Ok(`Q(number))
      | "in" => Ok(`In(number))
      | "pc" => Ok(`Pc(number))
      | "pt" => Ok(`Pt(number))
      | dim => Error(["Invalid length unit '" ++ dim ++ "'."])
      }
    | NUMBER(0.) => Ok(`Zero)
    | _ => Error(["Expected length."])
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
      | dim => Error(["Invalid angle unit '" ++ dim ++ "'."])
      }
    | NUMBER(0.) => Ok(`Deg(0.))
    | _ => Error(["Expected angle."])
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
      | un => Error(["Invalid time unit '" ++ un ++ "'."])
      }
    | _ => Error(["Expected time."])
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
      | dim => Error(["Invalid frequency unit '" ++ dim ++ "'."])
      }
    | _ => Error(["Expected frequency."])
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
      | dim => Error(["Invalid resolution unit '" ++ dim ++ "'."])
      }
    | _ => Error(["Expected resolution."])
    }
  );

// TODO: positive numbers like <number [0,infinity]>
let percentage =
  token(
    fun
    | PERCENTAGE(float) => Ok(float)
    | _ => Error(["Expected percentage."]),
  );

// https://drafts.csswg.org/css-values-4/#css-identifier
// TODO: differences between <ident> and keyword
let ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | _ => Error(["Expected an indentifier."]),
  );

// https://drafts.csswg.org/css-values-4/#textual-values
let css_wide_keywords =
  Combinator.xor([
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
    | _ => Error(["Expected an identifier."]),
  );

// https://drafts.csswg.org/css-values-4/#dashed-idents
let dashed_ident =
  token(
    fun
    | IDENT(string) when String.sub(string, 0, 2) == "--" => Ok(string)
    | _ => Error(["Expected a --variable."]),
  );

// https://drafts.csswg.org/css-values-4/#strings
let string =
  token(
    fun
    | STRING(string) => Ok(string)
    | _ => Error(["Expected a string."]),
  );

// TODO: <url-modifier>
// https://drafts.csswg.org/css-values-4/#urls
let url = {
  let url_token =
    token(
      fun
      | URL(url) => Ok(url)
      | _ => Error(["Expected a url."]),
    );
  let url_fun = function_call("url", string);
  Combinator.xor([url_token, url_fun]);
};

// https://drafts.csswg.org/css-variables-2/#funcdef-var
/* let var = function_call("var", dashed_ident); */

// css-color-4
// https://drafts.csswg.org/css-color-4/#hex-notation
let hex_color =
  token(
    fun
    | HASH(str, _) when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(str)
    | _ => Error(["Expected a hex-color."]),
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

let media_type =
  token(
    fun
    | IDENT(value) => {
        switch (value) {
        | "only"
        | "not"
        | "and"
        | "or"
        | "layer" =>
          Error([
            Format.sprintf("media_type has an invalid value: '%s'", value),
          ])
        | _ => Ok(value)
        };
      }
    | token =>
      Error([
        Format.sprintf(
          "expected media_type, got %s instead",
          show_token(token),
        ),
      ]),
  );

let container_name = {
  open Rule.Let;
  let.bind_match name = custom_ident;
  let value = {
    switch (name) {
    | "none"
    | "and"
    | "not"
    | "or" =>
      Error([
        Format.sprintf("container_name has an invalid value: '%s'", name),
      ])
    | _ => Ok(name)
    };
  };
  return_data(value);
};

let flex_value =
  token(
    fun
    | DIMENSION(number, dimension) =>
      switch (dimension) {
      | "fr" => Ok(`Fr(number))
      | _ =>
        Error([
          Format.sprintf(
            "Invalid flex value %g%s, only fr is valid.",
            number,
            dimension,
          ),
        ])
      }
    | _ => Error(["Expected flex_value."]),
  );

let custom_ident_without_span_or_auto =
  token(
    fun
    | IDENT("auto")
    | STRING("auto")
    | IDENT("span")
    | STRING("span") => Error(["Custom ident cannot be span or auto."])
    | IDENT(string) => Ok(string)
    | STRING(string) => Ok(string)
    | _ => Error(["expected an identifier."]),
  );

// TODO: workarounds
let invalid = expect(STRING("not-implemented"));
let attr_name = invalid;
let attr_fallback = invalid;
let string_token = invalid;
let ident_token = invalid;
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
