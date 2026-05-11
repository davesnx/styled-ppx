  $ refmt --parse re --print ml ./input.re > input.ml
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
  let property_margin_left = tokens =>
    Combinators.xor_with_expected(
      [
        (
          None,
          Rule.Match.map(lookup("extended-length"), v => `Extended_length(v)),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-percentage"), v =>
            `Extended_percentage(v)
          ),
        ),
        (
          Some("auto"),
          Rule.Match.map(Css_value_types.keyword("auto"), _v => `Auto),
        ),
      ],
      tokens,
    );
  let property_margin_block_end = tokens =>
    lookup("property_margin-left", tokens);
  let property_margin_block = tokens =>
    Modifier.repeat((1, Some(2)), lookup("property_margin-left"), tokens);
  let property_top = tokens =>
    Combinators.xor_with_expected(
      [
        (
          None,
          Rule.Match.map(lookup("extended-length"), v => `Extended_length(v)),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-percentage"), v =>
            `Extended_percentage(v)
          ),
        ),
        (
          Some("auto"),
          Rule.Match.map(Css_value_types.keyword("auto"), _v => `Auto),
        ),
      ],
      tokens,
    );
  let property_inset = tokens =>
    Modifier.repeat((1, Some(4)), lookup("property_top"), tokens);
  let property_row_gap = tokens =>
    Combinators.xor_with_expected(
      [
        (
          Some("normal"),
          Rule.Match.map(Css_value_types.keyword("normal"), _v => `Normal),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-length"), v => `Extended_length(v)),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-percentage"), v =>
            `Extended_percentage(v)
          ),
        ),
      ],
      tokens,
    );
  let property_column_gap = tokens =>
    Combinators.xor_with_expected(
      [
        (
          Some("normal"),
          Rule.Match.map(Css_value_types.keyword("normal"), _v => `Normal),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-length"), v => `Extended_length(v)),
        ),
        (
          None,
          Rule.Match.map(lookup("extended-percentage"), v =>
            `Extended_percentage(v)
          ),
        ),
      ],
      tokens,
    );
  let property_gap = tokens =>
    Rule.Match.map(
      Combinators.static([
        Rule.Match.map(lookup("property_row-gap"), v => `V0(v)),
        Rule.Match.map(Modifier.optional(lookup("property_column-gap")), v =>
          `V1(v)
        ),
      ]),
      [@ocaml.warning "-8"] ([`V0(v0), `V1(v1)]) => (v0, v1),
      tokens,
    );
