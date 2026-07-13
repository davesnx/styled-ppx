  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 2, characters 2-10:
  2 | &:hover {
        ^^^^^^^^
  Error: The nesting selector `&` has no parent selector to resolve against here in [%styled.global] (at-rules like @media don't provide one). Write a concrete selector instead.
  [1]
  $ refmt --parse re --print ml input_media.re > output_media.ml
  $ standalone --impl output_media.ml -o output_media.ml
  File "output_media.ml", line 5, characters 4-12:
  5 |   &:hover {
          ^^^^^^^^
  Error: The nesting selector `&` has no parent selector to resolve against here in [%styled.global] (at-rules like @media don't provide one). Write a concrete selector instead.
  [1]
