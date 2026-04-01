module Ast = Styled_ppx_css_parser.Ast;
module Render = Styled_ppx_css_parser.Render;

open Rule.Let;
open Rule.Pattern;

let render_expected_error = (expected, actual) =>
  Rule.err_keyword(expected, actual);

let parse_block = (~kind, ~extract, rule) => {
  let.bind_match body =
    component((((_value, _): Rule.located_component_value) as actual) =>
      switch (extract(fst(actual))) {
      | Some(body) => Ok(body)
      | None => Rule.err_desc_got(kind, actual)
      }
    );
  switch (Rule.run(rule, body)) {
  | Ok(value) => Rule.Match.return(value)
  | Error(info) => Rule.Data.return(Error([info]))
  };
};

let paren_block = rule =>
  parse_block(
    ~kind="a parenthesized block",
    ~extract=
      fun
      | Ast.Paren_block(body) => Some(body)
      | _ => None,
    rule,
  );

let bracket_block = rule =>
  parse_block(
    ~kind="a bracket block",
    ~extract=
      fun
      | Ast.Bracket_block(body) => Some(body)
      | _ => None,
    rule,
  );

let keyword = kw =>
  switch (Ast.delimiter_of_string(kw)) {
  | Some(delimiter) => expect_delim(delimiter)
  | None =>
    component(actual =>
      switch (actual) {
      | (Ast.Ident(actual_kw), _) when actual_kw == kw => Ok()
      | _ => render_expected_error(kw, actual)
      }
    )
  };

let comma = expect_delim(Ast.Delimiter_comma);

let delim =
  fun
  | "," as value
  | ":" as value
  | "." as value
  | "*" as value
  | "&" as value
  | "+" as value
  | "-" as value
  | "~" as value
  | ">" as value
  | "<" as value
  | "/" as value
  | "!" as value
  | "|" as value
  | "^" as value
  | "$" as value
  | "=" as value
  | ">=" as value
  | "<=" as value =>
    switch (Ast.delimiter_of_string(value)) {
    | Some(delimiter) => expect_delim(delimiter)
    | None =>
      component(actual => Rule.err_keyword(value, actual))
    }
  | "(" => paren_block(identity)
  | "[" => bracket_block(identity)
  | value =>
    component(actual => Rule.err_keyword(value, actual));

let function_call = (name, rule) => {
  let.bind_match body =
    component(actual => {
      let result =
        switch (actual) {
        | (Ast.Function(f), _) when fst(f.name) == name =>
          Some(fst(f.body))
        | _ => None
        };
      switch (result) {
      | Some(body) => Ok(body)
      | None => Rule.err_fn(name, actual)
      };
    });
  switch (Rule.run(rule, body)) {
  | Ok(value) => Rule.Match.return(value)
  | Error(info) => Rule.Data.return(Error([info]))
  };
};

let integer =
  component(
    fun
    | (Ast.Number(n), _) =>
      Float.is_integer(n)
        ? Ok(Float.to_int(n))
        : Rule.err_kind("integer")
    | actual => Rule.err_kind_got("integer", actual),
  );

let number =
  component(
    fun
    | (Ast.Number(n), _) => Ok(n)
    | actual => Rule.err_kind_got("number", actual),
  );

let invalid_dimension_unit = (kind, _unit) =>
  Rule.err_kind(kind);

let length_of_unit = (number, unit) =>
  switch ((unit: Ast.length_unit)) {
  | Ast.Length_unit_cap => Ok(`Cap(number))
  | Length_unit_ch => Ok(`Ch(number))
  | Length_unit_em => Ok(`Em(number))
  | Length_unit_ex => Ok(`Ex(number))
  | Length_unit_ic => Ok(`Ic(number))
  | Length_unit_lh => Ok(`Lh(number))
  | Length_unit_rcap => Ok(`Rcap(number))
  | Length_unit_rch => Ok(`Rch(number))
  | Length_unit_rem => Ok(`Rem(number))
  | Length_unit_rex => Ok(`Rex(number))
  | Length_unit_ric => Ok(`Ric(number))
  | Length_unit_rlh => Ok(`Rlh(number))
  | Length_unit_vh => Ok(`Vh(number))
  | Length_unit_vw => Ok(`Vw(number))
  | Length_unit_vmax => Ok(`Vmax(number))
  | Length_unit_vmin => Ok(`Vmin(number))
  | Length_unit_vb => Ok(`Vb(number))
  | Length_unit_vi => Ok(`Vi(number))
  | Length_unit_cqw => Ok(`Cqw(number))
  | Length_unit_cqh => Ok(`Cqh(number))
  | Length_unit_cqi => Ok(`Cqi(number))
  | Length_unit_cqb => Ok(`Cqb(number))
  | Length_unit_cqmin => Ok(`Cqmin(number))
  | Length_unit_cqmax => Ok(`Cqmax(number))
  | Length_unit_px => Ok(`Px(number))
  | Length_unit_cm => Ok(`Cm(number))
  | Length_unit_mm => Ok(`Mm(number))
  | Length_unit_q => Ok(`Q(number))
  | Length_unit_in => Ok(`In(number))
  | Length_unit_pc => Ok(`Pc(number))
  | Length_unit_pt => Ok(`Pt(number))
  };

let angle_of_unit = (number, unit) =>
  switch ((unit: Ast.angle_unit)) {
  | Ast.Angle_unit_deg => Ok(`Deg(number))
  | Angle_unit_grad => Ok(`Grad(number))
  | Angle_unit_rad => Ok(`Rad(number))
  | Angle_unit_turn => Ok(`Turn(number))
  };

let time_of_unit = (number, unit) =>
  switch ((unit: Ast.time_unit)) {
  | Ast.Time_unit_s => Ok(`S(number))
  | Time_unit_ms => Ok(`Ms(number))
  };

let frequency_of_unit = (number, unit) =>
  switch ((unit: Ast.frequency_unit)) {
  | Ast.Frequency_unit_hz => Ok(`Hz(number))
  | Frequency_unit_khz => Ok(`KHz(number))
  };

let resolution_of_unit = (number, unit) =>
  switch ((unit: Ast.resolution_unit)) {
  | Ast.Resolution_unit_dpi => Ok(`Dpi(number))
  | Resolution_unit_dpcm => Ok(`Dpcm(number))
  | Resolution_unit_dppx => Ok(`Dppx(number))
  };

let length =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_length(unit) => length_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("length", dimension.unit)
      }
    | (Ast.Number(0.), _) => Ok(`Zero)
    | _ => Rule.err_kind("length"),
  );

let length_runtime_module_path = "Css_types.Length";

let angle =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_angle(unit) => angle_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("angle", dimension.unit)
      }
    | (Ast.Number(0.), _) => Ok(`Deg(0.))
    | _ => Rule.err_kind("angle"),
  );

let angle_runtime_module_path = "Css_types.Angle";

let time =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_time(unit) => time_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("time", dimension.unit)
      }
    | _ => Rule.err_kind("time"),
  );

let time_runtime_module_path = "Css_types.Time";

module Time = {
  type t = [
    | `S(float)
    | `Ms(float)
  ];
};

let frequency =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_frequency(unit) =>
        frequency_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("frequency", dimension.unit)
      }
    | _ => Rule.err_kind("frequency"),
  );

let frequency_runtime_module_path = "Css_types.Frequency";

let resolution =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_resolution(unit) =>
        resolution_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("resolution", dimension.unit)
      }
    | _ => Rule.err_kind("resolution"),
  );

let resolution_runtime_module_path = "Css_types.Resolution";

let percentage =
  component(
    fun
    | (Ast.Percentage(n), _) => Ok(n)
    | _ => Rule.err_kind("percentage"),
  );

let percentage_runtime_module_path = "Css_types.Percentage";

let ident =
  component(
    fun
    | (Ast.Ident(value), _) => Ok(value)
    | _ => Rule.err_kind("identifier"),
  );

let css_wide_keywords =
  Combinators.xor([
    Rule.Pattern.value(`Initial, keyword("initial")),
    Rule.Pattern.value(`Inherit, keyword("inherit")),
    Rule.Pattern.value(`Unset, keyword("unset")),
    Rule.Pattern.value(`Revert, keyword("revert")),
    Rule.Pattern.value(`RevertLayer, keyword("revert-layer")),
  ]);

let css_wide_keywords_runtime_module_path = "Css_types.Cascading";

let custom_ident =
  component(
    fun
    | (Ast.Ident(value), _)
    | (Ast.String(value), _) => Ok(value)
    | _ => Rule.err_kind("identifier"),
  );

let dashed_ident =
  component(
    fun
    | (Ast.Ident(value), _)
        when String.length(value) >= 2 && String.sub(value, 0, 2) == "--" =>
      Ok(value)
    | _ => Rule.err_kind("--variable"),
  );

let string_token =
  component(
    fun
    | (Ast.String(value), _) => Ok(value)
    | _ => Rule.err_kind("string"),
  );

let string = string_token;

let url_no_interp = {
  let url_token =
    component(
      fun
      | (Ast.Uri(url), _) => Ok(url)
      | _ => Rule.err_kind("url"),
    );
  Combinators.xor([url_token, function_call("url", string_token)]);
};

let url_runtime_module_path = "Css_types.Url";

let hex_color =
  component(
    fun
    | (Ast.Hash((str, _)), _)
        when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(str)
    | _ => Rule.err_kind("hex-color"),
  );

let hex_color_runtime_module_path = "Css_types.Color";

let interpolation =
  component(
    fun
    | (Ast.Variable(name, _loc), _) => Ok([name])
    | _ => Rule.err_kind("value"),
  );

let media_type =
  component(
    fun
    | (Ast.Ident(value), _) => {
        switch (value) {
        | "only"
        | "not"
        | "and"
        | "or"
        | "layer" =>
          Rule.err_kind("media_type")
        | _ => Ok(value)
        };
      }
    | actual => Rule.err_kind_got("media_type", actual),
  );

let container_name = {
  let.bind_match name = custom_ident;
  let value = {
    switch (name) {
    | "none"
    | "and"
    | "not"
    | "or" =>
      Rule.err_kind("container_name")
    | _ => Ok(name)
    };
  };
  return_data(value);
};

let flex_value =
  component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_flex(Ast.Flex_unit_fr) => Ok(`Fr(dimension.value))
      | _ => Rule.err_kind("flex_value")
      }
    | _ => Rule.err_kind("flex_value"),
  );

let custom_ident_without_span_or_auto =
  component(
    fun
    | (Ast.Ident("auto"), _)
    | (Ast.String("auto"), _)
    | (Ast.Ident("span"), _)
    | (Ast.String("span"), _) =>
      Rule.err_kind("identifier (not span or auto)")
    | (Ast.Ident(value), _)
    | (Ast.String(value), _) => Ok(value)
    | _ => Rule.err_kind("identifier"),
  );

let ident_token =
  component(
    fun
    | (Ast.Ident(value), _) => Ok(value)
    | _ => Rule.err_kind("identifier"),
  );

let invalid =
  component(
    fun
    | (Ast.String("not-implemented"), _) => Ok()
    | _ => Rule.err_desc("not implemented"),
  );

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

let extended_percentage =
  Combinators.xor([
    Rule.Match.map(percentage, p => `Percentage(p)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
  ]);

let extended_length =
  Combinators.xor([
    Rule.Match.map(length, l => `Length(l)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
  ]);

let extended_angle =
  Combinators.xor([
    Rule.Match.map(angle, a => `Angle(a)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
  ]);

let extended_time =
  Combinators.xor([
    Rule.Match.map(time, t => `Time(t)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
  ]);

let extended_frequency =
  Combinators.xor([
    Rule.Match.map(frequency, f => `Frequency(f)),
    Rule.Match.map(interpolation, i => `Interpolation(i)),
  ]);
