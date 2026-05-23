  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module ArrayStatic = [%ocaml.error
    "[%styled.section] expects a string of CSS or a function returning a CSS string for static extraction."
  ];
