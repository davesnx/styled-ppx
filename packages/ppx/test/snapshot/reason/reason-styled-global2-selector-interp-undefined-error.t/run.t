  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 2, characters 5-22:
  Error: Selector interpolation `$(undefined_binding)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `undefined_binding` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `undefined_binding` is a computed string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
  $ refmt --parse ml --print re output.ml
  module Globals = [%styled.global
    {|
    .$(undefined_binding) {
      color: red;
    }
  |}
  ];
