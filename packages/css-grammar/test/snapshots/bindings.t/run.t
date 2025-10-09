  $ refmt --parse re --print ml ./input.re > input.ml
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
  let rec _legacy_gradient = tokens =>
    Combinators.xor(
      [
        map(Function__webkit_gradient.parser, v =>
          `Function__webkit_gradient(v)
        ),
        map(Legacy_linear_gradient.parser, v => `_legacy_linear_gradient(v)),
        map(Legacy_repeating_linear_gradient.parser, v =>
          `_legacy_repeating_linear_gradient(v)
        ),
        map(Legacy_radial_gradient.parser, v => `_legacy_radial_gradient(v)),
        map(Legacy_repeating_radial_gradient.parser, v =>
          `_legacy_repeating_radial_gradient(v)
        ),
      ],
      tokens,
    )
  and _legacy_linear_gradient = tokens =>
    Combinators.xor(
      [
        map(
          function_call(
            "-moz-linear-gradient",
            Legacy_linear_gradient_arguments.parser,
          ),
          v =>
          `_moz_linear_gradient(v)
        ),
        map(
          function_call(
            "-webkit-linear-gradient",
            Legacy_linear_gradient_arguments.parser,
          ),
          v =>
          `_webkit_linear_gradient(v)
        ),
        map(
          function_call(
            "-o-linear-gradient",
            Legacy_linear_gradient_arguments.parser,
          ),
          v =>
          `_o_linear_gradient(v)
        ),
      ],
      tokens,
    )
  and property_height = tokens =>
    Combinators.xor(
      [
        map(keyword("auto"), _v => `Auto),
        map(Extended_length.parser, v => `Extended_length(v)),
        map(Extended_percentage.parser, v => `Extended_percentage(v)),
        map(keyword("min-content"), _v => `Min_content),
        map(keyword("max-content"), _v => `Max_content),
        map(keyword("fit-content"), _v => `Fit_content_0),
        map(
          function_call(
            "fit-content",
            Combinators.xor([
              map(Extended_length.parser, v => `Extended_length(v)),
              map(Extended_percentage.parser, v => `Extended_percentage(v)),
            ]),
          ),
          v =>
          `Fit_content_1(v)
        ),
      ],
      tokens,
    );
