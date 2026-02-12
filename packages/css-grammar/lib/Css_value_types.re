open Styled_ppx_css_parser.Tokens;
open Rule.Let;
open Rule.Pattern;

let keyword = kw =>
  switch (kw) {
  | ">=" => expect(GTE)
  | "<=" => expect(LTE)
  | ">" => expect(GREATER_THAN)
  | "<" => expect(LESS_THAN)
  | "=" => expect(EQUALS)
  | "(" => expect(LEFT_PAREN)
  | ")" => expect(RIGHT_PAREN)
  | "[" => expect(LEFT_BRACKET)
  | "]" => expect(RIGHT_BRACKET)
  | _ =>
    token(
      fun
      | IDENT(s) when s == kw => Ok()
      | TYPE_SELECTOR(s) when s == kw => Ok()
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
  | "+" => expect(PLUS)
  | "-" => expect(MINUS)
  | "~" => expect(TILDE)
  | ">" => expect(GREATER_THAN)
  | "<" => expect(LESS_THAN)
  | "/" => expect(SLASH)
  | "!" => expect(EXCLAMATION)
  | "|" => expect(PIPE)
  | "^" => expect(CARET)
  | "$" => expect(DOLLAR_SIGN)
  | "=" => expect(EQUALS)
  | "&" => expect(AMPERSAND)
  | s when String.length(s) == 1 => expect(DELIM(s.[0]))
  | s =>
    token(
      fun
      | _ => Error(["Unexpected delimiter: " ++ s]),
    );

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
    | NUMBER(n) =>
      Float.is_integer(n)
        ? Ok(Float.to_int(n))
        : Error(["Expected an integer, got a float instead."])
    | _ => Error(["Expected an integer."]),
  );

let number =
  token(
    fun
    | NUMBER(n) => Ok(n)
    | token =>
      Error(["Expected a number. Got '" ++ humanize(token) ++ "' instead."]),
  );

let length =
  token(token =>
    switch (token) {
    | DIMENSION((number, dimension)) =>
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
      }
    | NUMBER(0.) => Ok(`Zero)
    | _ => Error(["Expected length."])
    }
  );

let length_runtime_module_path = "Css_types.Length";

// https://drafts.csswg.org/css-values-4/#angles
let angle =
  token(token =>
    switch (token) {
    | DIMENSION((number, dimension)) =>
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

let angle_runtime_module_path = "Css_types.Angle";

// https://drafts.csswg.org/css-values-4/#time
let time =
  token(token =>
    switch (token) {
    | DIMENSION((number, dimension)) =>
      switch (dimension) {
      | "s" => Ok(`S(number))
      | "ms" => Ok(`Ms(number))
      | un => Error(["Invalid time unit '" ++ un ++ "'."])
      }
    | _ => Error(["Expected time."])
    }
  );

let time_runtime_module_path = "Css_types.Time";

module Time = {
  type t = [
    | `S(float)
    | `Ms(float)
  ];
};

// https://drafts.csswg.org/css-values-4/#frequency
let frequency =
  token(token =>
    switch (token) {
    | DIMENSION((number, dimension)) =>
      switch (dimension |> String.lowercase_ascii) {
      | "hz" => Ok(`Hz(number))
      | "khz" => Ok(`KHz(number))
      | dim => Error(["Invalid frequency unit '" ++ dim ++ "'."])
      }
    | _ => Error(["Expected frequency."])
    }
  );

let frequency_runtime_module_path = "Css_types.Frequency";

// https://drafts.csswg.org/css-values-4/#resolution
let resolution =
  token(token =>
    switch (token) {
    | DIMENSION((number, dimension)) =>
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

let resolution_runtime_module_path = "Css_types.Resolution";

// TODO: positive numbers like <number [0,infinity]>
let percentage = {
  token(
    fun
    | PERCENTAGE(n) => Ok(n)
    | _ => Error(["Expected a percentage."]),
  );
};

let percentage_runtime_module_path = "Css_types.Percentage";

// https://drafts.csswg.org/css-values-4/#css-identifier
// TODO: differences between <ident> and keyword
let ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | TYPE_SELECTOR(string) => Ok(string)
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

let css_wide_keywords_runtime_module_path = "Css_types.Cascading";

// TODO: proper implement
// https://drafts.csswg.org/css-values-4/#custom-idents
let custom_ident =
  token(
    fun
    | IDENT(string) => Ok(string)
    | TYPE_SELECTOR(string) => Ok(string)
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
let string_token =
  token(
    fun
    | STRING(string) => Ok(string)
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
  Combinators.xor([url_token, function_call("url", string_token)]);
};

let url_runtime_module_path = "Css_types.Url";

// css-color-4
// https://drafts.csswg.org/css-color-4/#hex-notation
let hex_color =
  token(
    fun
    /* TODO: make sure hash is either 3, 4, 6, or 8 hexadecimal digits, precisely */
    | HASH((str, _)) when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(str)
    | _ => Error(["Expected a hex-color."]),
  );

/* hex_color is part of the color type, so use Color as the runtime module */
let hex_color_runtime_module_path = "Css_types.Color";

/* <interpolation>, It's not part of the spec.
     It's the implementation/workaround to inject Reason variables into CSS definitions.
     `$()` only supports variables and Module accessors to variables.
     In compile-time the bs-css bindings would enforce the types of those variables.
   */
let interpolation =
  token(
    fun
    | INTERPOLATION((name, _loc)) => Ok([name])
    | _ => Error(["Expected value."]),
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
    | DIMENSION((number, dimension)) => {
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
        };
      }
    | _ => Error(["Expected flex_value."]),
  );

let custom_ident_without_span_or_auto =
  token(
    fun
    | IDENT("auto")
    | TYPE_SELECTOR("auto")
    | STRING("auto")
    | IDENT("span")
    | TYPE_SELECTOR("span")
    | STRING("span") => Error(["Custom ident cannot be span or auto."])
    | IDENT(string) => Ok(string)
    | TYPE_SELECTOR(string) => Ok(string)
    | STRING(string) => Ok(string)
    | _ => Error(["expected an identifier."]),
  );

let ident_token =
  token(
    fun
    | IDENT(string) => Ok(string)
    | TYPE_SELECTOR(string) => Ok(string)
    | _ => Error(["expected an identifier."]),
  );

// TODO: workarounds
let invalid = expect(STRING("not-implemented"));

/* TODO: Implement all invalid rules */
let declaration_value = invalid;

let positive_integer = integer;

let function_token = invalid;

let any_value = invalid;

let hash_token = invalid;

let zero = invalid;

let custom_property_name = invalid;

let declaration_list = invalid;

let ratio = invalid;

let an_plus_b = invalid;

let declaration = invalid;

let decibel = invalid;

let urange = invalid;

let semitones = invalid;

let url_token = invalid;

/* Extended types - these are defined at the top of Parser.ml and need rules */
let extended_percentage =
  Combinators.xor([
    Rule.Match.map(percentage, p => `Percentage(p)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
    /* TODO: calc, min, max need lazy lookups */
  ]);

let extended_length =
  Combinators.xor([
    Rule.Match.map(length, l => `Length(l)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
    /* TODO: calc, min, max need lazy lookups */
  ]);

let extended_angle =
  Combinators.xor([
    Rule.Match.map(angle, a => `Angle(a)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
    /* TODO: calc, min, max need lazy lookups */
  ]);

let extended_time =
  Combinators.xor([
    Rule.Match.map(time, t => `Time(t)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
    /* TODO: calc, min, max need lazy lookups */
  ]);

let extended_frequency =
  Combinators.xor([
    Rule.Match.map(frequency, f => `Frequency(f)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
    /* TODO: calc, min, max need lazy lookups */
  ]);
