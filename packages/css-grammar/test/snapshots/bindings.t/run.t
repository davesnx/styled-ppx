  $ refmt --parse re --print ml ./input.re > input.ml
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
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
    and integer = [ | `Integer(int)]
    and number = [ | `Number(float)]
    and length = [
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
    ]
    and angle = [
      | `Deg(float)
      | `Grad(float)
      | `Rad(float)
      | `Turn(float)
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
    and percentage = [ | `Percentage(float)]
    and ident = [ | `Ident(string)]
    and custom_ident = [ | `Custom_ident(string)]
    and dashed_ident = [ | `Dashed_ident(string)]
    and custom_ident_without_span_or_auto = [
      | `Custom_ident_without_span_or_auto(string)
    ]
    and url_no_interp = string
    and hex_color = [ | `Hex_color(string)]
    and interpolation = [ | `Interpolation(list(string))]
    and flex_value = [ | `Fr(float)]
    and media_type = [ | `Media_type(string)]
    and container_name = [ | `Container_name(string)]
    and ident_token = [ | `Ident_token(string)]
    and string_token = [ | `String_token(string)]
    and function_token = unit
    and hash_token = unit
    and any_value = unit
    and declaration_value = unit
    and zero = unit
    and decibel = unit
    and urange = unit
    and semitones = unit
    and an_plus_b = unit
    and all = [
      | `_legacy_gradient(
          [
            | `Function__webkit_gradient(function__webkit_gradient)
            | `_legacy_linear_gradient(_legacy_linear_gradient)
            | `_legacy_repeating_linear_gradient(
                _legacy_repeating_linear_gradient,
              )
            | `_legacy_radial_gradient(_legacy_radial_gradient)
            | `_legacy_repeating_radial_gradient(
                _legacy_repeating_radial_gradient,
              )
          ],
        )
      | `_legacy_linear_gradient(
          [
            | `_moz_linear_gradient(_legacy_linear_gradient_arguments)
            | `_webkit_linear_gradient(_legacy_linear_gradient_arguments)
            | `_o_linear_gradient(_legacy_linear_gradient_arguments)
          ],
        )
      | `Property_height(
          [
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
          ],
        )
      | `Integer([ | `Integer(int)])
      | `Number([ | `Number(float)])
      | `Length(
          [
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
          ],
        )
      | `Angle(
          [
            | `Deg(float)
            | `Grad(float)
            | `Rad(float)
            | `Turn(float)
          ],
        )
      | `Time(
          [
            | `Ms(float)
            | `S(float)
          ],
        )
      | `Frequency(
          [
            | `Hz(float)
            | `KHz(float)
          ],
        )
      | `Resolution(
          [
            | `Dpi(float)
            | `Dpcm(float)
            | `Dppx(float)
          ],
        )
      | `Percentage([ | `Percentage(float)])
      | `Ident([ | `Ident(string)])
      | `Custom_ident([ | `Custom_ident(string)])
      | `Dashed_ident([ | `Dashed_ident(string)])
      | `Custom_ident_without_span_or_auto(
          [ | `Custom_ident_without_span_or_auto(string)],
        )
      | `Url_no_interp(string)
      | `Hex_color([ | `Hex_color(string)])
      | `Interpolation([ | `Interpolation(list(string))])
      | `Flex_value([ | `Fr(float)])
      | `Media_type([ | `Media_type(string)])
      | `Container_name([ | `Container_name(string)])
      | `Ident_token([ | `Ident_token(string)])
      | `String_token([ | `String_token(string)])
      | `Function_token(unit)
      | `Hash_token(unit)
      | `Any_value(unit)
      | `Declaration_value(unit)
      | `Zero(unit)
      | `Decibel(unit)
      | `Urange(unit)
      | `Semitones(unit)
      | `An_plus_b(unit)
    ];
  };
  let rec _legacy_gradient:
    list(Tokens.t) =>
    (Css_grammar__Rule.data(Types._legacy_gradient), list(Tokens.t)) =
    tokens =>
      Combinators.xor(
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
    list(Tokens.t) =>
    (Css_grammar__Rule.data(Types._legacy_linear_gradient), list(Tokens.t)) =
    tokens =>
      Combinators.xor(
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
    list(Tokens.t) =>
    (Css_grammar__Rule.data(Types.property_height), list(Tokens.t)) =
    tokens =>
      Combinators.xor(
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
              Combinators.xor([
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
