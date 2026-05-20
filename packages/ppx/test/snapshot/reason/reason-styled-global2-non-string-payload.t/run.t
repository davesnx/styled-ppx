  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module BadPayload = [%ocaml.error
    "[%styled.global2] expects a string of CSS with selectors that apply to the whole document.\n\nExample:\n  module Reset = [%styled.global2 \"body { margin: 0; }\"]"
  ];
