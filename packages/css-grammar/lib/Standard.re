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

module Integer = {
  type t = int;
  let parser =
    token(
      fun
      | NUMBER(string) =>
        Float.is_integer(Float.of_string(string))
          ? Ok(Float.of_string(string) |> Float.to_int)
          : Error(["Expected an integer, got a float instead."])
      | _ => Error(["Expected an integer."]),
    );
  let toString = string_of_int;
};

module Number = {
  type t = float;
  let parser =
    token(
      fun
      | NUMBER(num_str) => Ok(Float.of_string(num_str))
      | token =>
        Error([
          "Expected a number. Got '" ++ humanize(token) ++ "' instead.",
        ]),
    );
  let toString = string_of_float;
};

module Length = {
  type t = [
    | `Cap(float)
    | `Ch(float)
    | `Em(float)
    | `Ex(float)
    | `Ic(float)
    | `Lh(float)
    | `Rcap(float)
    | `Rch(float)
    | `Rem(float)
    | `Rex(float)
    | `Ric(float)
    | `Rlh(float)
    | `Vh(float)
    | `Vw(float)
    | `Vmax(float)
    | `Vmin(float)
    | `Vb(float)
    | `Vi(float)
    | `Cqw(float)
    | `Cqh(float)
    | `Cqi(float)
    | `Cqb(float)
    | `Cqmin(float)
    | `Cqmax(float)
    | `Px(float)
    | `Cm(float)
    | `Mm(float)
    | `Q(float)
    | `In(float)
    | `Pc(float)
    | `Pt(float)
    | `Zero
  ];

  let parser =
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

  let toString = (length: t) =>
    switch (length) {
    | `Cap(n) => string_of_float(n) ++ "cap"
    | `Ch(n) => string_of_float(n) ++ "ch"
    | `Em(n) => string_of_float(n) ++ "em"
    | `Ex(n) => string_of_float(n) ++ "ex"
    | `Ic(n) => string_of_float(n) ++ "ic"
    | `Lh(n) => string_of_float(n) ++ "lh"
    | `Rcap(n) => string_of_float(n) ++ "rcap"
    | `Rch(n) => string_of_float(n) ++ "rch"
    | `Rem(n) => string_of_float(n) ++ "rem"
    | `Rex(n) => string_of_float(n) ++ "rex"
    | `Ric(n) => string_of_float(n) ++ "ric"
    | `Rlh(n) => string_of_float(n) ++ "rlh"
    | `Vh(n) => string_of_float(n) ++ "vh"
    | `Vw(n) => string_of_float(n) ++ "vw"
    | `Vmax(n) => string_of_float(n) ++ "vmax"
    | `Vmin(n) => string_of_float(n) ++ "vmin"
    | `Vb(n) => string_of_float(n) ++ "vb"
    | `Vi(n) => string_of_float(n) ++ "vi"
    | `Cqw(n) => string_of_float(n) ++ "cqw"
    | `Cqh(n) => string_of_float(n) ++ "cqh"
    | `Cqi(n) => string_of_float(n) ++ "cqi"
    | `Cqb(n) => string_of_float(n) ++ "cqb"
    | `Cqmin(n) => string_of_float(n) ++ "cqmin"
    | `Cqmax(n) => string_of_float(n) ++ "cqmax"
    | `Px(n) => string_of_float(n) ++ "px"
    | `Cm(n) => string_of_float(n) ++ "cm"
    | `Mm(n) => string_of_float(n) ++ "mm"
    | `Q(n) => string_of_float(n) ++ "Q"
    | `In(n) => string_of_float(n) ++ "in"
    | `Pc(n) => string_of_float(n) ++ "pc"
    | `Pt(n) => string_of_float(n) ++ "pt"
    | `Zero => "0"
    };
};

// https://drafts.csswg.org/css-values-4/#angles
module Angle = {
  type t = [
    | `Deg(float)
    | `Grad(float)
    | `Rad(float)
    | `Turn(float)
  ];

  let parser =
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

  let toString = (angle: t) =>
    switch (angle) {
    | `Deg(n) => string_of_float(n) ++ "deg"
    | `Grad(n) => string_of_float(n) ++ "grad"
    | `Rad(n) => string_of_float(n) ++ "rad"
    | `Turn(n) => string_of_float(n) ++ "turn"
    };
};

// https://drafts.csswg.org/css-values-4/#time
module Time = {
  type t = [
    | `Ms(float)
    | `S(float)
  ];

  let parser =
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

  let toString = (time: t) =>
    switch (time) {
    | `Ms(n) => string_of_float(n) ++ "ms"
    | `S(n) => string_of_float(n) ++ "s"
    };
};

// https://drafts.csswg.org/css-values-4/#frequency
module Frequency = {
  type t = [
    | `Hz(float)
    | `KHz(float)
  ];

  let parser =
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

  let toString = (freq: t) =>
    switch (freq) {
    | `Hz(n) => string_of_float(n) ++ "Hz"
    | `KHz(n) => string_of_float(n) ++ "kHz"
    };
};

// https://drafts.csswg.org/css-values-4/#resolution
module Resolution = {
  type t = [
    | `Dpi(float)
    | `Dpcm(float)
    | `Dppx(float)
  ];

  let parser =
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

  let toString = (res: t) =>
    switch (res) {
    | `Dpi(n) => string_of_float(n) ++ "dpi"
    | `Dpcm(n) => string_of_float(n) ++ "dpcm"
    | `Dppx(n) => string_of_float(n) ++ "dppx"
    };
};

// TODO: positive numbers like <number [0,infinity]>
module Percentage = {
  type t = float;
  let parser = {
    let.bind_match num = Number.parser;
    let.bind_match () = expect(PERCENT);
    Rule.Match.return(num);
  };
  let toString = (p: t) => string_of_float(p) ++ "%";
};

// https://drafts.csswg.org/css-values-4/#css-identifier
// TODO: differences between <ident> and keyword
module Ident = {
  type t = string;
  let parser =
    token(
      fun
      | IDENT(string) => Ok(string)
      | TAG(string) => Ok(string)
      | _ => Error(["Expected an indentifier."]),
    );
  let toString = (x: t) => x;
};

// https://drafts.csswg.org/css-values-4/#textual-values
module Css_wide_keywords = {
  type t = [
    | `Initial
    | `Inherit
    | `Unset
    | `Revert
    | `RevertLayer
  ];
  let parser =
    Combinators.xor([
      Rule.Pattern.value(`Initial, keyword("initial")),
      Rule.Pattern.value(`Inherit, keyword("inherit")),
      Rule.Pattern.value(`Unset, keyword("unset")),
      Rule.Pattern.value(`Revert, keyword("revert")),
      Rule.Pattern.value(`RevertLayer, keyword("revert-layer")),
    ]);
  let toString = (x: t) =>
    switch (x) {
    | `Initial => "initial"
    | `Inherit => "inherit"
    | `Unset => "unset"
    | `Revert => "revert"
    | `RevertLayer => "revert-layer"
    };
};

// TODO: proper implement
// https://drafts.csswg.org/css-values-4/#custom-idents
module Custom_ident = {
  type t = string;
  let parser =
    token(
      fun
      | IDENT(string) => Ok(string)
      | TAG(string) => Ok(string)
      | STRING(string) => Ok(string)
      | _ => Error(["Expected an identifier."]),
    );
  let toString = (x: t) => x;
};

// https://drafts.csswg.org/css-values-4/#dashed-idents
module Dashed_ident = {
  type t = string;
  let parser =
    token(
      fun
      | IDENT(string) when String.sub(string, 0, 2) == "--" => Ok(string)
      | _ => Error(["Expected a --variable."]),
    );
  let toString = (x: t) => x;
};

// https://drafts.csswg.org/css-values-4/#strings
module String_value = {
  type t = string;
  let parser =
    token(
      fun
      | STRING(string) => Ok(string)
      | _ => Error(["Expected a string."]),
    );
  let toString = (x: t) => x;
};

// TODO: <url-modifier>
// https://drafts.csswg.org/css-values-4/#urls
module Url_no_interp = {
  type t = string;
  let parser = {
    let url_token =
      token(
        fun
        | URL(url) => Ok(url)
        | _ => Error(["Expected a url."]),
      );
    let url_fun = function_call("url", String_value.parser);
    Combinators.xor([url_token, url_fun]);
  };
  let toString = (x: t) => "url(" ++ x ++ ")";
};

// css-color-4
// https://drafts.csswg.org/css-color-4/#hex-notation
module Hex_color = {
  type t = string;
  let parser =
    token(
      fun
      | HASH(str) when String.length(str) >= 3 && String.length(str) <= 8 =>
        Ok(str)
      | _ => Error(["Expected a hex-color."]),
    );
  let toString = (x: t) => "#" ++ x;
};

/* <interpolation>, It's not part of the spec.
     It's the implementation/workaround to inject Reason variables into CSS definitions.
     `$()` only supports variables and Module accessors to variables.
     In compile-time the bs-css bindings would enforce the types of those variables.
   */
module Interpolation = {
  type t = list(string);
  let parser =
    token(
      fun
      | INTERPOLATION(parts) => Ok(parts)
      | _ => Error(["Expected interpolation."]),
    );
  let toString = (parts: t) => "$(" ++ String.concat(".", parts) ++ ")";
};

module Media_type = {
  type t = string;
  let parser =
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
  let toString = (x: t) => x;
};

module Container_name = {
  type t = string;
  let parser = {
    open Rule.Let;
    let.bind_match name = Custom_ident.parser;
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
  let toString = (x: t) => x;
};

module Flex_value = {
  type t = [ | `Fr(float)];
  let parser =
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
  let toString = (x: t) =>
    switch (x) {
    | `Fr(n) => string_of_float(n) ++ "fr"
    };
};

module Custom_ident_without_span_or_auto = {
  type t = string;
  let parser =
    token(
      fun
      | IDENT("auto")
      | TAG("auto")
      | STRING("auto")
      | IDENT("span")
      | TAG("span")
      | STRING("span") => Error(["Custom ident cannot be span or auto."])
      | IDENT(string) => Ok(string)
      | TAG(string) => Ok(string)
      | STRING(string) => Ok(string)
      | _ => Error(["expected an identifier."]),
    );
  let toString = (x: t) => x;
};

// TODO: workarounds
module Invalid = {
  type t = unit;
  let parser = expect(STRING("not-implemented"));
  let toString = (_: t) => "invalid";
};

module String_token = {
  type t = string;
  let parser =
    token(
      fun
      | STRING(string) => Ok(string)
      | _ => Error(["expected a string."]),
    );
  let toString = (x: t) => x;
};

module Ident_token = {
  type t = string;
  let parser =
    token(
      fun
      | IDENT(string) => Ok(string)
      | TAG(string) => Ok(string)
      | _ => Error(["expected an identifier."]),
    );
  let toString = (x: t) => x;
};

module Declaration_value = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Positive_integer = {
  type t = int;
  let parser = Integer.parser;
  let toString = Integer.toString;
};

module Function_token = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Any_value = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Hash_token = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Zero = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = (_: t) => "0";
};

module Custom_property_name = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Declaration_list = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Name_repeat = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Ratio = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = (_: t) => "<<ratio>>";
};

module An_plus_b = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Declaration = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Y = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module X = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Decibel = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Urange = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Semitones = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};

module Url_token = {
  type t = unit;
  let parser = Invalid.parser;
  let toString = Invalid.toString;
};
