Two units that bind the same name get different ids, because the module
name is part of the id.

  $ refmt --parse re --print ml a.re > a.ml
  $ ../../standalone.exe --env production --impl a.ml -o a.ml
  $ refmt --parse re --print ml b.re > b.ml
  $ ../../standalone.exe --env production --impl b.ml -o b.ml
  $ refmt --parse ml --print re a.ml
  [@css.config [("env", "production")]];
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("A.card", "css-tokvmb", "_igysSAdl6"),
      ("A.marker", "css-1vuhzdz", "_iLU_l-r4e"),
    ]
  ];
  let card = CSS.make("css-tokvmb", []);
  let marker = CSS.make("css-1vuhzdz", []);
  $ refmt --parse ml --print re b.ml
  [@css.config [("env", "production")]];
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("B.card", "css-tokvmb", "_i3ePpy6ZJ"),
      ("B.marker", "css-9w3nqr", "_iqOMHnUj8"),
    ]
  ];
  let card = CSS.make("css-tokvmb", []);
  let marker = CSS.make("css-9w3nqr", []);
