  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let () = [%ocaml.error
    "[%styled.global2] must now be bound to a module name. Replace `let () = [%styled.global2 ...]` with `module <Name> = [%styled.global2 ...]` and mount the resulting component (or call `<Name>.to_string ()` on native).\n\nExample:\n  module Reset = [%styled.global2 \"body { margin: 0; }\"]\n\nMore info: https://styled-ppx.vercel.app/reference/global"
  ];
