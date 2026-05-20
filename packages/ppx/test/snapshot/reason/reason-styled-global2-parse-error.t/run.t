  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module BadCss = [%ocaml.error "Parse error while reading token 'the end'"];
