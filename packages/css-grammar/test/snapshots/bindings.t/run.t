  $ refmt --parse re --print ml ./input.re > input.ml
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
  let rec _legacy_gradient = tokens =>
    Combinators.xor(
      [
        Rule.Match.map(function__webkit_gradient, v =>
          `Function__webkit_gradient(v)
        ),
        Rule.Match.map(legacy_linear_gradient, v => `Legacy_linear_gradient(v)),
        Rule.Match.map(legacy_repeating_linear_gradient, v =>
          `Legacy_repeating_linear_gradient(v)
        ),
        Rule.Match.map(legacy_radial_gradient, v => `Legacy_radial_gradient(v)),
        Rule.Match.map(legacy_repeating_radial_gradient, v =>
          `Legacy_repeating_radial_gradient(v)
        ),
      ],
      tokens,
    )
  and _legacy_linear_gradient = tokens =>
    Combinators.xor(
      [
        Rule.Match.map(
          Standard.function_call(
            "-moz-linear-gradient",
            legacy_linear_gradient_arguments,
          ),
          v =>
          `Moz_linear_gradient(v)
        ),
        Rule.Match.map(
          Standard.function_call(
            "-webkit-linear-gradient",
            legacy_linear_gradient_arguments,
          ),
          v =>
          `Webkit_linear_gradient(v)
        ),
        Rule.Match.map(
          Standard.function_call(
            "-o-linear-gradient",
            legacy_linear_gradient_arguments,
          ),
          v =>
          `O_linear_gradient(v)
        ),
      ],
      tokens,
    )
  and property_height = tokens =>
    Combinators.xor(
      [
        Rule.Match.map(Standard.keyword("auto"), _v => `Auto),
        Rule.Match.map(extended_length, v => `Extended_length(v)),
        Rule.Match.map(extended_percentage, v => `Extended_percentage(v)),
        Rule.Match.map(Standard.keyword("min-content"), _v => `Min_content),
        Rule.Match.map(Standard.keyword("max-content"), _v => `Max_content),
        Rule.Match.map(Standard.keyword("fit-content"), _v => `Fit_content_0),
        Rule.Match.map(
          Standard.function_call(
            "fit-content",
            Combinators.xor([
              Rule.Match.map(extended_length, v => `Extended_length(v)),
              Rule.Match.map(extended_percentage, v => `Extended_percentage(v)),
            ]),
          ),
          v =>
          `Fit_content_1(v)
        ),
      ],
      tokens,
    );
