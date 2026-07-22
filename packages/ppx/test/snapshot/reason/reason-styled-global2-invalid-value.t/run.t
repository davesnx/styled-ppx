  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module Global = [%ocaml.error
    "Property 'display' has an invalid value: 'blocki',\nExpected 'block', 'contents', 'flex', 'flow', 'flow-root', 'grid', 'inline', 'inline-block', etc. Did you mean 'block'?"
  ];
