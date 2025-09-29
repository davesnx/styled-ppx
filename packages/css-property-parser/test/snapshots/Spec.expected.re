open Standard;
open Modifier;
open Rule.Match;
open Driver;
module Types = {
  type _legacy_gradient = [
    | `Function__webkit_gradient(function__webkit_gradient)
    | `_legacy_linear_gradient(_legacy_linear_gradient)
    | `_legacy_repeating_linear_gradient(_legacy_repeating_linear_gradient)
    | `_legacy_radial_gradient(_legacy_radial_gradient)
    | `_legacy_repeating_radial_gradient(_legacy_repeating_radial_gradient)
  ]
  and _legacy_linear_gradient = [
    | `_moz_linear_gradient(_legacy_linear_gradient_arguments)
    | `_webkit_linear_gradient(_legacy_linear_gradient_arguments)
    | `_o_linear_gradient(_legacy_linear_gradient_arguments)
  ]
  and property_height = [
    | `Auto
    | `Extended_length(extended_length)
    | `Extended_percentage(extended_percentage)
    | `Min_content
    | `Max_content
    | `Fit_content_0
    | `Fit_content_1(
        [
          | `Extended_length(extended_length)
          | `Extended_percentage(extended_percentage)
        ],
      )
  ]
  and integer = int
  and number = float
  and length = [
    | `Cap(number)
    | `Ch(number)
    | `Em(number)
    | `Ex(number)
    | `Ic(number)
    | `Lh(number)
    | `Rcap(number)
    | `Rch(number)
    | `Rem(number)
    | `Rex(number)
    | `Ric(number)
    | `Rlh(number)
    | `Vh(number)
    | `Vw(number)
    | `Vmax(number)
    | `Vmin(number)
    | `Vb(number)
    | `Vi(number)
    | `Cqw(number)
    | `Cqh(number)
    | `Cqi(number)
    | `Cqb(number)
    | `Cqmin(number)
    | `Cqmax(number)
    | `Px(number)
    | `Cm(number)
    | `Mm(number)
    | `Q(number)
    | `In(number)
    | `Pc(number)
    | `Pt(number)
    | `Zero
  ]
  and angle = [
    | `Deg(number)
    | `Grad(number)
    | `Rad(number)
    | `Turn(number)
  ]
  and time = [
    | `Ms(float)
    | `S(float)
  ]
  and frequency = [
    | `Hz(float)
    | `KHz(float)
  ]
  and resolution = [
    | `Dpi(float)
    | `Dpcm(float)
    | `Dppx(float)
  ]
  and percentage = float
  and ident = string
  and custom_ident = string
  and dashed_ident = string
  and custom_ident_without_span_or_auto = string
  and url_no_interp = string
  and hex_color = string
  and interpolation = list(string)
  and flex_value = [ | `Fr(float)]
  and media_type = string
  and container_name = string
  and ident_token = string
  and string_token = string
  and function_token = unit
  and hash_token = unit
  and any_value = unit
  and declaration_value = unit
  and zero = unit
  and decibel = unit
  and urange = unit
  and semitones = unit
  and an_plus_b = unit;
};
let rec _legacy_gradient:
  list(Styled_ppx_css_parser.Tokens.t) =>
  (
    Css_property_parser__Rule.data(Types._legacy_gradient),
    list(Styled_ppx_css_parser.Tokens.t),
  ) =
  tokens =>
    Combinator.xor(
      [
        map(function__webkit_gradient, v => `Function__webkit_gradient(v)),
        map(_legacy_linear_gradient, v => `_legacy_linear_gradient(v)),
        map(_legacy_repeating_linear_gradient, v =>
          `_legacy_repeating_linear_gradient(v)
        ),
        map(_legacy_radial_gradient, v => `_legacy_radial_gradient(v)),
        map(_legacy_repeating_radial_gradient, v =>
          `_legacy_repeating_radial_gradient(v)
        ),
      ],
      tokens,
    )
and _legacy_linear_gradient:
  list(Styled_ppx_css_parser.Tokens.t) =>
  (
    Css_property_parser__Rule.data(Types._legacy_linear_gradient),
    list(Styled_ppx_css_parser.Tokens.t),
  ) =
  tokens =>
    Combinator.xor(
      [
        map(
          function_call(
            "-moz-linear-gradient",
            _legacy_linear_gradient_arguments,
          ),
          v =>
          `_moz_linear_gradient(v)
        ),
        map(
          function_call(
            "-webkit-linear-gradient",
            _legacy_linear_gradient_arguments,
          ),
          v =>
          `_webkit_linear_gradient(v)
        ),
        map(
          function_call(
            "-o-linear-gradient",
            _legacy_linear_gradient_arguments,
          ),
          v =>
          `_o_linear_gradient(v)
        ),
      ],
      tokens,
    )
and property_height:
  list(Styled_ppx_css_parser.Tokens.t) =>
  (
    Css_property_parser__Rule.data(Types.property_height),
    list(Styled_ppx_css_parser.Tokens.t),
  ) =
  tokens =>
    Combinator.xor(
      [
        map(keyword("auto"), _v => `Auto),
        map(extended_length, v => `Extended_length(v)),
        map(extended_percentage, v => `Extended_percentage(v)),
        map(keyword("min-content"), _v => `Min_content),
        map(keyword("max-content"), _v => `Max_content),
        map(keyword("fit-content"), _v => `Fit_content_0),
        map(
          function_call(
            "fit-content",
            Combinator.xor([
              map(extended_length, v => `Extended_length(v)),
              map(extended_percentage, v => `Extended_percentage(v)),
            ]),
          ),
          v =>
          `Fit_content_1(v)
        ),
      ],
      tokens,
    );
let check_map =
  StringMap.of_seq(
    List.to_seq([
      ("linear-gradient", _legacy_gradient),
      ("radial-gradient", _legacy_linear_gradient),
    ]),
  );
