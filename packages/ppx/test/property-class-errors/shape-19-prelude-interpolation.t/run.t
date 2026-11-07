Shape 19: an interpolation in an at-rule prelude is an error, in development
and in production.

  $ refmt --parse re --print ml input.re > input.ml
  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  File "input.ml", line 2, characters 23-46:
  2 | let bad = [%css "@media (max-width: $(width)) { color: red }"]
                             ^^^^^^^^^^^^^^^^^^^^^^^
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]
  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  File "input.ml", line 2, characters 23-46:
  2 | let bad = [%css "@media (max-width: $(width)) { color: red }"]
                             ^^^^^^^^^^^^^^^^^^^^^^^
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]
