module Ast = Ast;

let starts_with = (~prefix, value) => {
  let prefix_len = String.length(prefix);
  let value_len = String.length(value);
  value_len >= prefix_len && String.sub(value, 0, prefix_len) == prefix;
};

module Ident = {
  let value =
    fun
    | Ast.Ident(value) => Some(value)
    | _ => None;

  let matches = (~expected, component_value) =>
    switch (value(component_value)) {
    | Some(actual) => actual == expected
    | None => false
    };

  let starts_with = (~prefix, component_value) =>
    switch (value(component_value)) {
    | Some(actual) => starts_with(~prefix, actual)
    | None => false
    };
};

module Textual = {
  let value =
    fun
    | Ast.Ident(value)
    | Ast.String(value) => Some(value)
    | _ => None;

  let matches = (~expected, component_value) =>
    switch (value(component_value)) {
    | Some(actual) => actual == expected
    | None => false
    };
};

module Function = {
  let kind = (component_value: Ast.component_value) =>
    switch (component_value) {
    | Ast.Function(function_) => Some(function_.kind)
    | _ => None
    };

  let body_if_named = (~expected, component_value: Ast.component_value) =>
    switch (component_value) {
    | Ast.Function(function_) when fst(function_.name) == expected =>
      Some(fst(function_.body))
    | _ => None
    };
};

module Delim = {
  let of_string =
    fun
    | ":" => Some(Ast.Delimiter_colon)
    | "::" => Some(Ast.Delimiter_double_colon)
    | "," => Some(Ast.Delimiter_comma)
    | "." => Some(Ast.Delimiter_dot)
    | "*" => Some(Ast.Delimiter_asterisk)
    | "&" => Some(Ast.Delimiter_ampersand)
    | "+" => Some(Ast.Delimiter_plus)
    | "-" => Some(Ast.Delimiter_minus)
    | "~" => Some(Ast.Delimiter_tilde)
    | ">" => Some(Ast.Delimiter_greater_than)
    | "<" => Some(Ast.Delimiter_less_than)
    | "=" => Some(Ast.Delimiter_equals)
    | "/" => Some(Ast.Delimiter_slash)
    | "!" => Some(Ast.Delimiter_exclamation)
    | "|" => Some(Ast.Delimiter_pipe)
    | "^" => Some(Ast.Delimiter_caret)
    | "$" => Some(Ast.Delimiter_dollar_sign)
    | "?" => Some(Ast.Delimiter_question_mark)
    | "#" => Some(Ast.Delimiter_hash)
    | "@" => Some(Ast.Delimiter_at)
    | "%" => Some(Ast.Delimiter_percent)
    | "_" => Some(Ast.Delimiter_underscore)
    | ">=" => Some(Ast.Delimiter_gte)
    | "<=" => Some(Ast.Delimiter_lte)
    | _ => None;

  let value =
    fun
    | Ast.Delim(value) => Some(value)
    | _ => None;

  let matches = (~expected, component_value) =>
    switch (value(component_value), of_string(expected)) {
    | (Some(actual), Some(expected)) => actual == expected
    | _ => false
    };
};

module Dimension = {
  let payload =
    fun
    | Ast.Dimension(payload) => Some(payload)
    | _ => None;

  module Length_unit = {
    let of_string =
      fun
      | "cap" => Some(Ast.Length_unit_cap)
      | "ch" => Some(Ast.Length_unit_ch)
      | "em" => Some(Ast.Length_unit_em)
      | "ex" => Some(Ast.Length_unit_ex)
      | "ic" => Some(Ast.Length_unit_ic)
      | "lh" => Some(Ast.Length_unit_lh)
      | "rcap" => Some(Ast.Length_unit_rcap)
      | "rch" => Some(Ast.Length_unit_rch)
      | "rem" => Some(Ast.Length_unit_rem)
      | "rex" => Some(Ast.Length_unit_rex)
      | "ric" => Some(Ast.Length_unit_ric)
      | "rlh" => Some(Ast.Length_unit_rlh)
      | "vh" => Some(Ast.Length_unit_vh)
      | "vw" => Some(Ast.Length_unit_vw)
      | "vmax" => Some(Ast.Length_unit_vmax)
      | "vmin" => Some(Ast.Length_unit_vmin)
      | "vb" => Some(Ast.Length_unit_vb)
      | "vi" => Some(Ast.Length_unit_vi)
      | "cqw" => Some(Ast.Length_unit_cqw)
      | "cqh" => Some(Ast.Length_unit_cqh)
      | "cqi" => Some(Ast.Length_unit_cqi)
      | "cqb" => Some(Ast.Length_unit_cqb)
      | "cqmin" => Some(Ast.Length_unit_cqmin)
      | "cqmax" => Some(Ast.Length_unit_cqmax)
      | "px" => Some(Ast.Length_unit_px)
      | "cm" => Some(Ast.Length_unit_cm)
      | "mm" => Some(Ast.Length_unit_mm)
      | "Q" => Some(Ast.Length_unit_q)
      | "in" => Some(Ast.Length_unit_in)
      | "pc" => Some(Ast.Length_unit_pc)
      | "pt" => Some(Ast.Length_unit_pt)
      | _ => None;
  };

  module Angle_unit = {
    let of_string =
      fun
      | "deg" => Some(Ast.Angle_unit_deg)
      | "grad" => Some(Ast.Angle_unit_grad)
      | "rad" => Some(Ast.Angle_unit_rad)
      | "turn" => Some(Ast.Angle_unit_turn)
      | _ => None;
  };

  module Time_unit = {
    let of_string =
      fun
      | "s" => Some(Ast.Time_unit_s)
      | "ms" => Some(Ast.Time_unit_ms)
      | _ => None;
  };

  module Frequency_unit = {
    let of_string = unit =>
      switch (String.lowercase_ascii(unit)) {
      | "hz" => Some(Ast.Frequency_unit_hz)
      | "khz" => Some(Ast.Frequency_unit_khz)
      | _ => None
      };
  };

  module Resolution_unit = {
    let of_string = unit =>
      switch (String.lowercase_ascii(unit)) {
      | "dpi" => Some(Ast.Resolution_unit_dpi)
      | "dpcm" => Some(Ast.Resolution_unit_dpcm)
      | "x"
      | "dppx" => Some(Ast.Resolution_unit_dppx)
      | _ => None
      };
  };

  module Flex_unit = {
    let of_string =
      fun
      | "fr" => Some(Ast.Flex_unit_fr)
      | _ => None;
  };

  let kind_of_unit = unit =>
    switch (Length_unit.of_string(unit)) {
    | Some(length_unit) => Ast.Dimension_length(length_unit)
    | None =>
      switch (Angle_unit.of_string(unit)) {
      | Some(angle_unit) => Ast.Dimension_angle(angle_unit)
      | None =>
        switch (Time_unit.of_string(unit)) {
        | Some(time_unit) => Ast.Dimension_time(time_unit)
        | None =>
          switch (Frequency_unit.of_string(unit)) {
          | Some(frequency_unit) => Ast.Dimension_frequency(frequency_unit)
          | None =>
            switch (Resolution_unit.of_string(unit)) {
            | Some(resolution_unit) => Ast.Dimension_resolution(resolution_unit)
            | None =>
              switch (Flex_unit.of_string(unit)) {
              | Some(flex_unit) => Ast.Dimension_flex(flex_unit)
              | None => Ast.Dimension_unknown
              }
            }
          }
        }
      }
    };

  let make = payload => {
    let (value, unit) = payload;
    ({
      value: value,
      unit: unit,
      kind: kind_of_unit(unit),
    }: Ast.dimension);
  };
};

module Keyword = {
  type media_reserved =
    | Only
    | Not
    | And
    | Or
    | Layer;

  let media_reserved_of_string =
    fun
    | "only" => Some(Only)
    | "not" => Some(Not)
    | "and" => Some(And)
    | "or" => Some(Or)
    | "layer" => Some(Layer)
    | _ => None;

  let media_reserved = component_value =>
    switch (Ident.value(component_value)) {
    | Some(value) => media_reserved_of_string(value)
    | None => None
    };

  type container_reserved =
    | None_
    | And_
    | Not_
    | Or_;

  let container_reserved_of_string =
    fun
    | "none" => Some(None_)
    | "and" => Some(And_)
    | "not" => Some(Not_)
    | "or" => Some(Or_)
    | _ => None;

  let container_reserved = component_value =>
    switch (Textual.value(component_value)) {
    | Some(value) => container_reserved_of_string(value)
    | None => None
    };

  type custom_ident_exclusion =
    | Auto
    | Span;

  let custom_ident_exclusion_of_string =
    fun
    | "auto" => Some(Auto)
    | "span" => Some(Span)
    | _ => None;

  let custom_ident_exclusion = component_value =>
    switch (Textual.value(component_value)) {
    | Some(value) => custom_ident_exclusion_of_string(value)
    | None => None
    };
};
