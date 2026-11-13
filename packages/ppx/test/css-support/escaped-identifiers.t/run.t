The lexer decoded a CSS escape while reading an identifier and kept no
record that one was there, so the decoded text reached the output
unescaped. Before this fix, `.\31 a { color: red; }` (class "1a")
compiled with no error to the invalid `.1a{...}`, and `.a\.b { color: red; }`
(one class literally named "a.b") compiled to `.a.b{...}` — two classes,
silently changing what the selector matches. `consume_identifier`
(`Lexer.re`) now re-serializes the decoded name per CSSOM, so every
identifier token, including the property name in `--custom\ prop`, already
carries valid CSS. A non-ASCII identifier such as "héllo" is left untouched.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-9g1ibu .\\31 a{color:red;}.css-9g1ibu .-\\31 a{color:red;}.css-9g1ibu #\\31 a{color:red;}.css-9g1ibu .a\\.b{color:red;}.css-9g1ibu .foo\\:bar{color:red;}.css-9g1ibu .a\\/b{color:red;}.css-9g1ibu .foo\\ bar{color:red;}.css-9g1ibu .héllo{color:red;}.css-9g1ibu .foo:not(.a\\.b){color:red;}"
  ];
  [@css ".css-1cxbe3a{--custom\\ prop:red;}"];
  [@css.classes
    [
      ("css-9g1ibu", 0, "Input._test", "input.re", 3, 2, 12, 0),
      ("css-1cxbe3a", 1, "", "input.re", 15, 8, 15, 28),
    ]
  ];
  [@css.bindings [("Input._test", "css-9g1ibu")]];
  let _test = CSS.make("css-9g1ibu", []);
  
  CSS.make("css-1cxbe3a", []);

  $ dune build
