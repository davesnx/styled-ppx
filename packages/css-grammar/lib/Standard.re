open Styled_ppx_css_parser.Tokens;
open Rule.Let;
open Rule.Pattern;

let keyword = kw => {
  switch (kw) {
  | "<=" => expect(DELIM("<="))
  | ">=" => expect(DELIM(">="))
  | _ =>
    // Keywords can be TAG or IDENT tokens (e.g., "sub" is both a CSS keyword and HTML tag)
    token(
      fun
      | IDENT(s) when s == kw => Ok()
      | TAG(s) when s == kw => Ok()
      | token =>
        Error([
          "Expected '"
          ++ kw
          ++ "' but instead got '"
          ++ humanize(token)
          ++ "'.",
        ]),
    )
  };
};

let comma = expect(COMMA);
let delim =
  fun
  | "(" => expect(LEFT_PAREN)
  | ")" => expect(RIGHT_PAREN)
  | "[" => expect(LEFT_BRACKET)
  | "]" => expect(RIGHT_BRACKET)
  | ":" => expect(COLON)
  | ";" => expect(SEMI_COLON)
  | "*" => expect(ASTERISK)
  | "." => expect(DOT)
  // Combinators can appear as delimiters in value context (e.g., calc)
  | "+" => expect(COMBINATOR("+"))
  | "~" => expect(COMBINATOR("~"))
  | ">" => expect(COMBINATOR(">"))
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
    | NUMBER(string) =>
      Float.is_integer(Float.of_string(string))
        ? Ok(`Integer(Float.of_string(string) |> Float.to_int))
        : Error(["Expected an integer, got a float instead."])
    | _ => Error(["Expected an integer."]),
  );

let number =
  token(
    fun
    | NUMBER(num_str) => Ok(`Number(Float.of_string(num_str)))
    | token =>
      Error(["Expected a number. Got '" ++ humanize(token) ++ "' instead."]),
  );

let length =
  token(token =>
    switch (token) {
    | FLOAT_DIMENSION((number_str, dimension))
    | DIMENSION((number_str, dimension)) =>
      let number = Float.of_string(number_str);
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
      | "px" => Ok(`Px(number))
      | "cm" => Ok(`Cm(number))
      | "mm" => Ok(`Mm(number))
      | "Q" => Ok(`Q(number))
      | "in" => Ok(`In(number))
      | "pc" => Ok(`Pc(number))
      | "pt" => Ok(`Pt(number))
      | dim => Error(["Invalid length unit '" ++ dim ++ "'."])
      };
    | NUMBER("0") => Ok(`Zero)
    | _ => Error(["Expected length."])
    }
  );

// https://drafts.csswg.org/css-values-4/#angles
let angle =
  token(token =>
    switch (token) {
    | FLOAT_DIMENSION((number_str, dimension))
    | DIMENSION((number_str, dimension)) =>
      let number = Float.of_string(number_str);
      switch (dimension) {
      | "deg" => Ok(`Deg(number))
      | "grad" => Ok(`Grad(number))
      | "rad" => Ok(`Rad(number))
      | "turn" => Ok(`Turn(number))
      | dim => Error(["Invalid angle unit '" ++ dim ++ "'."])
      };
    | NUMBER("0") => Ok(`Deg(0.))
    | _ => Error(["Expected angle."])
    }
  );

// https://drafts.csswg.org/css-values-4/#time
let time =
  token(token =>
    switch (token) {
    | FLOAT_DIMENSION((number_str, dimension))
    | DIMENSION((number_str, dimension)) =>
      let number = Float.of_string(number_str);
      switch (dimension) {
      | "s" => Ok(`S(number))
      | "ms" => Ok(`Ms(number))
      | un => Error(["Invalid time unit '" ++ un ++ "'."])
      };
    | _ => Error(["Expected time."])
    }
  );

// https://drafts.csswg.org/css-values-4/#frequency
let frequency =
  token(token =>
    switch (token) {
    | FLOAT_DIMENSION((number_str, dimension))
    | DIMENSION((number_str, dimension)) =>
      let number = Float.of_string(number_str);
      switch (dimension |> String.lowercase_ascii) {
      | "hz" => Ok(`Hz(number))
      | "khz" => Ok(`KHz(number))
      | dim => Error(["Invalid frequency unit '" ++ dim ++ "'."])
      };
    | _ => Error(["Expected frequency."])
    }
  );

// https://drafts.csswg.org/css-values-4/#resolution
let resolution =
  token(token =>
    switch (token) {
    | FLOAT_DIMENSION((number_str, dimension))
    | DIMENSION((number_str, dimension)) =>
      let number = Float.of_string(number_str);
      switch (dimension |> String.lowercase_ascii) {
      | "dpi" => Ok(`Dpi(number))
      | "dpcm" => Ok(`Dpcm(number))
      | "x"
      | "dppx" => Ok(`Dppx(number))
      | dim => Error(["Invalid resolution unit '" ++ dim ++ "'."])
      };
    | _ => Error(["Expected resolution."])
    }
  );

// TODO: positive numbers like <number [0,infinity]>
let percentage = {
  let.bind_match `Number(num) = number;
  let.bind_match () = expect(PERCENT);
  Rule.Match.return(`Percentage(num));
};

// https://drafts.csswg.org/css-values-4/#css-identifier
// TODO: differences between <ident> and keyword
let ident =
  token(
    fun
    | IDENT(string) => Ok(`Ident(string))
    | TAG(string) => Ok(`Ident(string))
    | _ => Error(["Expected an indentifier."]),
  );

// https://drafts.csswg.org/css-values-4/#textual-values
let css_wide_keywords =
  Combinators.xor([
    Rule.Pattern.value(`Initial, keyword("initial")),
    Rule.Pattern.value(`Inherit, keyword("inherit")),
    Rule.Pattern.value(`Unset, keyword("unset")),
    Rule.Pattern.value(`Revert, keyword("revert")),
    Rule.Pattern.value(`RevertLayer, keyword("revert-layer")),
  ]);

// TODO: proper implement
// https://drafts.csswg.org/css-values-4/#custom-idents
let custom_ident =
  token(
    fun
    | IDENT(string) => Ok(`Custom_ident(string))
    | TAG(string) => Ok(`Custom_ident(string))
    | STRING(string) => Ok(`Custom_ident(string))
    | _ => Error(["Expected an identifier."]),
  );

// https://drafts.csswg.org/css-values-4/#dashed-idents
let dashed_ident =
  token(
    fun
    | IDENT(string) when String.sub(string, 0, 2) == "--" =>
      Ok(`Dashed_ident(string))
    | _ => Error(["Expected a --variable."]),
  );

// https://drafts.csswg.org/css-values-4/#strings
let string_token =
  token(
    fun
    | STRING(string) => Ok(`String_token(string))
    | _ => Error(["Expected a string."]),
  );

/* TODO: Somewhere in the generate, we point to string and some places to string_token */
let string = string_token;

// TODO: <url-modifier>
// https://drafts.csswg.org/css-values-4/#urls
let url_no_interp = {
  let url_token =
    token(
      fun
      | URL(url) => Ok(url)
      | _ => Error(["Expected a url."]),
    );
  let string_unwrapped = {
    let.bind_match `String_token(s) = string_token;
    Rule.Match.return(s);
  };
  Combinators.xor([url_token, function_call("url", string_unwrapped)]);
};

// css-color-4
// https://drafts.csswg.org/css-color-4/#hex-notation
let hex_color =
  token(
    fun
    | HASH(str) when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(`Hex_color(str))
    | _ => Error(["Expected a hex-color."]),
  );

/* <interpolation>, It's not part of the spec.
     It's the implementation/workaround to inject Reason variables into CSS definitions.
     `$()` only supports variables and Module accessors to variables.
     In compile-time the bs-css bindings would enforce the types of those variables.
   */
let interpolation =
  token(
    fun
    | INTERPOLATION(parts) => Ok(`Interpolation(parts))
    | _ => Error(["Expected interpolation."]),
  );

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
        | _ => Ok(`Media_type(value))
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
  let.bind_match `Custom_ident(name) = custom_ident;
  let value = {
    switch (name) {
    | "none"
    | "and"
    | "not"
    | "or" =>
      Error([
        Format.sprintf("container_name has an invalid value: '%s'", name),
      ])
    | _ => Ok(`Container_name(name))
    };
  };
  return_data(value);
};

let flex_value =
  token(
    fun
    | DIMENSION((number_str, dimension)) => {
        let num = Float.of_string(number_str);
        switch (dimension) {
        | "fr" => Ok(`Fr(num))
        | _ =>
          Error([
            Format.sprintf(
              "Invalid flex value %g%s, only fr is valid.",
              num,
              dimension,
            ),
          ])
        };
      }
    | _ => Error(["Expected flex_value."]),
  );

let custom_ident_without_span_or_auto =
  token(
    fun
    | IDENT("auto")
    | TAG("auto")
    | STRING("auto")
    | IDENT("span")
    | TAG("span")
    | STRING("span") => Error(["Custom ident cannot be span or auto."])
    | IDENT(string) => Ok(`Custom_ident_without_span_or_auto(string))
    | TAG(string) => Ok(`Custom_ident_without_span_or_auto(string))
    | STRING(string) => Ok(`Custom_ident_without_span_or_auto(string))
    | _ => Error(["expected an identifier."]),
  );

let ident_token =
  token(
    fun
    | IDENT(string) => Ok(`Ident_token(string))
    | TAG(string) => Ok(`Ident_token(string))
    | _ => Error(["expected an identifier."]),
  );

// TODO: workarounds
let invalid =
  token(
    fun
    | _ => Ok(),
  );

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

let decibel = invalid;

let urange = invalid;

let semitones = invalid;

let url_token = invalid;
