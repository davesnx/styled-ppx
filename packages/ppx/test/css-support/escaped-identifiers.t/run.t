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
  [@css ".a-14kiwtd .\\31 a{color:red;}"];
  [@css ".a-10mby7r .-\\31 a{color:red;}"];
  [@css ".a-1vlbr1m #\\31 a{color:red;}"];
  [@css ".a-1klhelx .a\\.b{color:red;}"];
  [@css ".a-1jd2wma .foo\\:bar{color:red;}"];
  [@css ".a-67142b .a\\/b{color:red;}"];
  [@css ".a-nxfkpb .foo\\ bar{color:red;}"];
  [@css ".a-r5hrsz .héllo{color:red;}"];
  [@css ".a-hufzp0 .foo:not(.a\\.b){color:red;}"];
  [@css ".a-1x6t703{--custom\\ prop:red;}"];
  [@css.bindings
    [
      (
        "Input._test",
        "id-1gr654a",
        "a-14kiwtd a-10mby7r a-1vlbr1m a-1klhelx a-1jd2wma a-67142b a-nxfkpb a-r5hrsz a-hufzp0",
      ),
    ]
  ];
  let _test =
    CSS.make(
      "label:_test id-1gr654a a-14kiwtd a-10mby7r a-1vlbr1m a-1klhelx a-1jd2wma a-67142b a-nxfkpb a-r5hrsz a-hufzp0",
      [],
    );
  
  CSS.make("a-1x6t703", []);

  $ dune build
