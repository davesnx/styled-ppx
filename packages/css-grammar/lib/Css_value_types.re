module Ast = Styled_ppx_css_parser.Ast;
module Render = Styled_ppx_css_parser.Render;

open Rule.Let;
open Rule.Pattern;

let render_component = ((value, _): Rule.located_component_value) =>
  Render.component_value(value);

let render_expected_error = (expected, actual) =>
  Error([
    "Expected '"
    ++ expected
    ++ "' but instead got '"
    ++ render_component(actual)
    ++ "'.",
  ]);

let match_component = f => component(f);

let parse_block = (~kind, ~extract, rule) => {
  let.bind_match body =
    match_component((((value, _): Rule.located_component_value) as actual) =>
      switch (extract(value)) {
      | Some(body) => Ok(body)
      | None =>
        Error([
          "Expected "
          ++ kind
          ++ " but instead got '"
          ++ render_component(actual)
          ++ "'.",
        ])
      }
    );
  switch (Rule.run(rule, body)) {
  | Ok(value) => Rule.Match.return(value)
  | Error(message) => Rule.Data.return(Error([message]))
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

let delimiter_from_string = Ast.delimiter_of_string;

let keyword = kw =>
  switch (Ast.delimiter_of_string(kw)) {
  | Some(delimiter) => expect_delim(delimiter)
  | None =>
    match_component((((value, _): Rule.located_component_value) as actual) =>
      switch (value) {
      | Ast.Ident(actual_kw) when actual_kw == kw => Ok()
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
    switch (delimiter_from_string(value)) {
    | Some(delimiter) => expect_delim(delimiter)
    | None =>
      match_component(actual =>
        Error([
          "Unexpected delimiter: "
          ++ value
          ++ ". Got '"
          ++ render_component(actual)
          ++ "'.",
        ])
      )
    }
  | "(" => paren_block(identity)
  | "[" => bracket_block(identity)
  | value =>
    match_component(actual =>
      Error([
        "Unexpected delimiter: "
        ++ value
        ++ ". Got '"
        ++ render_component(actual)
        ++ "'.",
      ])
    );

let function_call = (name, rule) => {
  let.bind_match body =
    match_component((((value, _): Rule.located_component_value) as actual) => {
      let result =
        switch (value) {
        | Ast.Function(f) when fst(f.name) == name => Some(fst(f.body))
        | _ => None
        };
      switch (result) {
      | Some(body) => Ok(body)
      | None =>
        Error([
          "Expected 'function "
          ++ name
          ++ "'. Got '"
          ++ render_component(actual)
          ++ "' instead.",
        ])
      };
    });
  switch (Rule.run(rule, body)) {
  | Ok(value) => Rule.Match.return(value)
  | Error(message) => Rule.Data.return(Error([message]))
  };
};

let integer =
  match_component(
    fun
    | (Ast.Number(n), _) =>
      Float.is_integer(n)
        ? Ok(Float.to_int(n))
        : Error(["Expected an integer, got a float instead."])
    | _ => Error(["Expected an integer."]),
  );

let number =
  match_component((((value, _): Rule.located_component_value) as actual) =>
    switch (value) {
    | Ast.Number(n) => Ok(n)
    | _ =>
      Error([
        "Expected a number. Got '" ++ render_component(actual) ++ "' instead.",
      ])
    }
  );

let invalid_dimension_unit = (kind, unit) =>
  Error(["Invalid " ++ kind ++ " unit '" ++ unit ++ "'."]);

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
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_length(unit) => length_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("length", dimension.unit)
      }
    | (Ast.Number(0.), _) => Ok(`Zero)
    | _ => Error(["Expected length."]),
  );

let length_runtime_module_path = "Css_types.Length";

let angle =
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_angle(unit) => angle_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("angle", dimension.unit)
      }
    | (Ast.Number(0.), _) => Ok(`Deg(0.))
    | _ => Error(["Expected angle."]),
  );

let angle_runtime_module_path = "Css_types.Angle";

let time =
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_time(unit) => time_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("time", dimension.unit)
      }
    | _ => Error(["Expected time."]),
  );

let time_runtime_module_path = "Css_types.Time";

module Time = {
  type t = [
    | `S(float)
    | `Ms(float)
  ];
};

let frequency =
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_frequency(unit) =>
        frequency_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("frequency", dimension.unit)
      }
    | _ => Error(["Expected frequency."]),
  );

let frequency_runtime_module_path = "Css_types.Frequency";

let resolution =
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_resolution(unit) =>
        resolution_of_unit(dimension.value, unit)
      | _ => invalid_dimension_unit("resolution", dimension.unit)
      }
    | _ => Error(["Expected resolution."]),
  );

let resolution_runtime_module_path = "Css_types.Resolution";

let percentage =
  match_component(
    fun
    | (Ast.Percentage(n), _) => Ok(n)
    | _ => Error(["Expected a percentage."]),
  );

let percentage_runtime_module_path = "Css_types.Percentage";

let ident =
  match_component(
    fun
    | (Ast.Ident(value), _) => Ok(value)
    | _ => Error(["Expected an indentifier."]),
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
  match_component(
    fun
    | (Ast.Ident(value), _)
    | (Ast.String(value), _) => Ok(value)
    | _ => Error(["Expected an identifier."]),
  );

let dashed_ident =
  match_component(
    fun
    | (Ast.Ident(value), _)
        when String.length(value) >= 2 && String.sub(value, 0, 2) == "--" =>
      Ok(value)
    | _ => Error(["Expected a --variable."]),
  );

let string_token =
  match_component(
    fun
    | (Ast.String(value), _) => Ok(value)
    | _ => Error(["Expected a string."]),
  );

let string = string_token;

let url_no_interp = {
  let url_token =
    match_component(
      fun
      | (Ast.Uri(url), _) => Ok(url)
      | _ => Error(["Expected a url."]),
    );
  Combinators.xor([url_token, function_call("url", string_token)]);
};

let url_runtime_module_path = "Css_types.Url";

let hex_color =
  match_component(
    fun
    | (Ast.Hash((str, _)), _)
        when String.length(str) >= 3 && String.length(str) <= 8 =>
      Ok(str)
    | _ => Error(["Expected a hex-color."]),
  );

let hex_color_runtime_module_path = "Css_types.Color";

let interpolation =
  match_component(
    fun
    | (Ast.Variable(name, _loc), _) => Ok([name])
    | _ => Error(["Expected value."]),
  );

let media_type =
  match_component(
    fun
    | (Ast.Ident(value), _) => {
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
    | actual =>
      Error([
        Format.sprintf(
          "expected media_type, got %s instead",
          render_component(actual),
        ),
      ]),
  );

let container_name = {
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
  match_component(
    fun
    | (Ast.Dimension(dimension), _) =>
      switch (dimension.kind) {
      | Ast.Dimension_flex(Ast.Flex_unit_fr) => Ok(`Fr(dimension.value))
      | _ =>
        Error([
          Format.sprintf(
            "Invalid flex value %g%s, only fr is valid.",
            dimension.value,
            dimension.unit,
          ),
        ])
      }
    | _ => Error(["Expected flex_value."]),
  );

let custom_ident_without_span_or_auto =
  match_component(
    fun
    | (Ast.Ident("auto"), _)
    | (Ast.String("auto"), _)
    | (Ast.Ident("span"), _)
    | (Ast.String("span"), _) =>
      Error(["Custom ident cannot be span or auto."])
    | (Ast.Ident(value), _)
    | (Ast.String(value), _) => Ok(value)
    | _ => Error(["expected an identifier."]),
  );

let ident_token =
  match_component(
    fun
    | (Ast.Ident(value), _) => Ok(value)
    | _ => Error(["expected an identifier."]),
  );

let invalid =
  match_component(
    fun
    | (Ast.String("not-implemented"), _) => Ok()
    | _ => Error(["not implemented"]),
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
