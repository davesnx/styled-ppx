CSS Gaps Module Level 1 (https://drafts.csswg.org/css-gaps-1/): row-rule,
column-rule additions, and rule. input.re carries valid declarations for
every property this pass added (accepted silently); invalid.re,
invalid_inset.re and invalid_rule.re each carry one out-of-grammar value -
a repeat() list, an inset shorthand, and the rule shorthand itself - built
and reported one at a time, since the compiler stops at a file's first
error.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid invalid_inset invalid_rule)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build ./invalid.exe
  File "invalid.re", line 7, characters 27-42:
  7 | [%css {|column-rule-color: repeat(2, 10px)|}];
                                 ^^^^^^^^^^^^^^^
  Error: Property 'column-rule-color' has an invalid value: 'repeat(2,
         10px)',
         Expected 'hex-color', 'color()', 'color-mix()', 'hsl()', 'hsla()',
         'hwb()', 'lab()', 'lch()', etc.
  [1]

  $ dune build ./invalid_inset.exe
  File "invalid_inset.re", line 2, characters 37-40:
  2 | [%css {|column-rule-inset-cap-start: red|}];
                                           ^^^
  Error: Property 'column-rule-inset-cap-start' has an invalid value:
         'red',
         Expected 'length', 'percentage', 'calc()', 'clamp()', 'env()',
         'max()', 'min()', or 'overlap-join'.
  [1]

  $ dune build ./invalid_rule.exe
  File "invalid_rule.re", line 3, characters 14-22:
  3 | [%css {|rule: red blue|}];
                    ^^^^^^^^
  Error: Property 'rule' has an invalid value: 'red blue', Expected a valid
         value.
  [1]
