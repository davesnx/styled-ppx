  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 2, characters 5-10:
  Error: Selector interpolation `$(later)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `later` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `later` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
  $ refmt --parse ml --print re output.ml
  module Globals = [%styled.global {|
    .$(later) {
      color: red;
    }
  |}];
  let later = [%css "padding: 0;"];
