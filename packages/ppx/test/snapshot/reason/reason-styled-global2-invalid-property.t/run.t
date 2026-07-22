  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module Global = [%ocaml.error
    "Unknown property 'colour'. Did you mean 'color'?"
  ];
