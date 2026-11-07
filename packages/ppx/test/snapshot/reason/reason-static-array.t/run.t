  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css.atoms
    [
      (
        "_iDft4zBfh",
        [],
        1,
        0,
        0,
        [("id", "_iDft4zBfh", "bind\\0\\0Output\\0\\0ArrayStatic\\00")],
      ),
    ]
  ];
  module ArrayStatic = [%ocaml.error
    "[%styled.section] expects a string of CSS or a function returning a CSS string for static extraction."
  ];
