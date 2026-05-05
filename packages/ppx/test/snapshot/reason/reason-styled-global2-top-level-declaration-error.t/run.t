  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module Reset = [%ocaml.error
    "Declarations does not make sense in global styles. Global should consists of style rules or at-rules (e.g @media, @print, etc.)\n\nIf your intent is to apply the declaration to all elements, use the universal selector\n* {\n  /* Your declarations here */\n}"
  ];
