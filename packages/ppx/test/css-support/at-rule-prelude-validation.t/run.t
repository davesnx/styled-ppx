Conditional group rule preludes are validated at compile time: the
media-query-list / supports-condition / container-condition-list grammars
check the structure, and @media/@container feature names are checked
against the spec inventory (with a suggestion on typos). @supports bodies
are exempt from deep validation on purpose: probing syntax the compiler
does not know is the whole point of the rule.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (modules input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

A typo in a media feature name fails with a suggestion:

  $ dune build 2>&1 | head -6
  File "input.re", line 3, characters 10-19:
  3 |   @media (min-widht: 768px) {
                ^^^^^^^^^
  Error: Unknown @media feature 'min-widht'. Did you mean 'min-width'?

Valid preludes in every form keep compiling, and @supports stays exempt:

  $ cat > dune << EOF
  > (executable
  >  (name valid)
  >  (modules valid)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -4

Feature values are validated against the feature's value grammar. A
length feature rejects a bare number:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_length)
  >  (modules invalid_length)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_length.re", line 3, characters 10-15:
  3 |   @media (width: 10) {
                ^^^^^
  Error: Invalid value for @media feature 'width', Expected 'length', 'calc()',
         'max()', or 'min()'.

A ratio feature rejects a length:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_ratio)
  >  (modules invalid_ratio)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_ratio.re", line 3, characters 10-29:
  3 |   @media (device-aspect-ratio: 16px) {
                ^^^^^^^^^^^^^^^^^^^
  Error: Invalid value for @media feature 'device-aspect-ratio', Expected
         'integer' or 'number'.

A resolution feature rejects a non-resolution dimension:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_resolution)
  >  (modules invalid_resolution)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_resolution.re", line 3, characters 10-20:
  3 |   @media (resolution: 2px) {
                ^^^^^^^^^^
  Error: Invalid value for @media feature 'resolution', Expected 'resolution'
         or 'infinite'.

An integer feature rejects a fractional number:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_integer)
  >  (modules invalid_integer)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_integer.re", line 3, characters 10-24:
  3 |   @media (max-monochrome: 1.5) {
                ^^^^^^^^^^^^^^
  Error: Invalid value for @media feature 'max-monochrome', Expected 'integer'.

A discrete keyword feature rejects an unknown keyword:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_keyword)
  >  (modules invalid_keyword)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_keyword.re", line 3, characters 10-24:
  3 |   @media (overflow-block: banana) {
                ^^^^^^^^^^^^^^
  Error: Invalid value for @media feature 'overflow-block', Expected 'none',
         'paged', or 'scroll'.

@container size features get the same value validation:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_container)
  >  (modules invalid_container)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_container.re", line 3, characters 14-24:
  3 |   @container (block-size: 10) {
                    ^^^^^^^^^^
  Error: Invalid value for @container feature 'block-size', Expected 'length',
         'calc()', 'max()', or 'min()'.

Compat features take <number>, not keywords:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_compat)
  >  (modules invalid_compat)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_compat.re", line 3, characters 10-36:
  3 |   @media (-webkit-device-pixel-ratio: high) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Invalid value for @media feature '-webkit-device-pixel-ratio',
         Expected 'number'.

Range-form comparison operands validate against the same grammar as
colon-form values:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_range)
  >  (modules invalid_range)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_range.re", line 3, characters 19-21:
  3 |   @media (width >= 10) {
                         ^^
  Error: Invalid value for @media feature 'width', Expected 'length', 'calc()',
         'max()', or 'min()'.

Every operand of a double-bounded range is checked:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_range_double)
  >  (modules invalid_range_double)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid_range_double.re", line 3, characters 28-31:
  3 |   @media (400px <= width <= 900) {
                                  ^^^
  Error: Invalid value for @media feature 'width', Expected 'length', 'calc()',
         'max()', or 'min()'.

Known pre-existing gap: the calc() grammar has no resolution units, so
calc() inside <resolution> is rejected by the structural grammar before
feature-value validation. It errors gracefully rather than crashing:

  $ cat > dune << EOF
  > (executable
  >  (name resolution_calc)
  >  (modules resolution_calc)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "resolution_calc.re", line 6, characters 8-43:
  6 |   @media (min-resolution: calc(2 * 1dppx)) {
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: @media has an invalid condition: '(min-resolution: calc(2 *
         1dppx))',
         Expected 'media_type' or 'not'.

Feature names are checked even when the value nests a function:

  $ cat > dune << EOF
  > (executable
  >  (name calc_typo)
  >  (modules calc_typo)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "calc_typo.re", line 3, characters 10-19:
  3 |   @media (min-widht: calc(700px + 2em)) {
                ^^^^^^^^^
  Error: Unknown @media feature 'min-widht'. Did you mean 'min-width'?

[%styled.global] rejects statement-form conditional group rules instead of
shipping dead CSS:

  $ cat > dune << EOF
  > (executable
  >  (name global_blockless)
  >  (modules global_blockless)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "global_blockless.re", line 5, characters 2-8:
  5 |   @media (min-width: 100px);
        ^^^^^^
  Error: @media without a block is invalid CSS, and browsers drop the whole rule silently. Add the declarations it should apply: `@media ... { ... }`.
