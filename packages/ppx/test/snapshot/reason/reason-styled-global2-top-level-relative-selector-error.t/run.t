  $ refmt --parse re --print ml input_media.re > output_media.ml
  $ ../../../standalone.exe --impl output_media.ml -o output_media.ml
  File "output_media.ml", line 5, characters 4-9:
  5 |   > .a {
          ^^^^^
  Error: The nesting selector `&` has no parent selector to resolve against here in [%styled.global] (at-rules like @media don't provide one). Write a concrete selector instead.
  [1]
