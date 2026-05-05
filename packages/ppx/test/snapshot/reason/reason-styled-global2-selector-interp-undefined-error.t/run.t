  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 2, characters 5-22:
  Error: Selector interpolation `$(undefined_binding)` does not refer to a [%cx2] binding earlier in this module.
  - If `undefined_binding` is bound to a [%cx2] later in the file, reorder the bindings.
  - If `undefined_binding` is a plain string, inline the class name literally.
  - Otherwise, use [%cx] for runtime substitution.
  [1]
  $ refmt --parse ml --print re output.ml
  module Globals = [%styled.global2
    {|
    .$(undefined_binding) {
      color: red;
    }
  |}
  ];
