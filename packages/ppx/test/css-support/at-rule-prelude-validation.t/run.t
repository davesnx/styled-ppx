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
  Error: At-rule @media requires a block (`@media ... { ... }`)
