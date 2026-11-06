A name bound twice in one scope gets one id per binding site, so the
second `m` does not share the id of the first. A submodule has its own
scope. `$(m)` selects the id of the binding in force at that point.

  $ refmt --parse re --print ml m.re > m.ml
  $ ../../standalone.exe --env production --impl m.ml -o m.ml
  $ refmt --parse ml --print re m.ml
  [@css.config [("env", "production")]];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-14ksm7b{color:blue;}"];
  [@css ".css-bjcoli{color:green;}"];
  [@css ".css-1xu3tth{color:black;}"];
  [@css ".css-8eudvh._iGT3WW03w{color:purple;}"];
  [@css.bindings
    [
      ("M.m", "css-14ksm7b", "_iGT3WW03w"),
      ("M.Inner.m", "css-bjcoli", "_inoiI2ThF"),
      ("M.card", "css-1xu3tth css-8eudvh", "_il-9sFgHR"),
    ]
  ];
  let m = CSS.make("css-1hfcgi6", []);
  let m = CSS.make("css-tokvmb", []);
  let m = CSS.make("css-14ksm7b", []);
  module Inner = {
    let m = CSS.make("css-1lkazb8", []);
    let m = CSS.make("css-bjcoli", []);
  };
  let card = CSS.make("css-1xu3tth css-8eudvh", []);
