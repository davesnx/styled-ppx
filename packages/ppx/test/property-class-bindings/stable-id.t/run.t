The id depends on the module name, not on the file path, the target or
the build. Four builds of one unit give one output.

  $ mkdir one two native
  $ refmt --parse re --print ml m.re > one/m.ml
  $ ../../standalone.exe --env production --impl one/m.ml -o one/m.ml
  $ refmt --parse re --print ml m.re > two/m.ml
  $ ../../standalone.exe --env production --impl two/m.ml -o two/m.ml
  $ refmt --parse re --print ml m.re > native/m.ml
  $ ../../standalone.exe --env production --native --impl native/m.ml -o native/m.ml
  $ diff one/m.ml two/m.ml
  $ diff one/m.ml native/m.ml
  $ refmt --parse ml --print re one/m.ml
  [@css.config [("env", "production")]];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-1w3378v._iKMiiAc13{color:blue;}"];
  [@css.bindings
    [
      ("M.m", "css-1hfcgi6", "_iKMiiAc13"),
      ("M.card", "css-tokvmb css-1w3378v", "_il-9sFgHR"),
    ]
  ];
  let m = CSS.make("css-1hfcgi6", []);
  let card = CSS.make("css-tokvmb css-1w3378v", []);
