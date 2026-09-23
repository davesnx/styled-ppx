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
  [@css ".css-14kiwtd-_test .\\31 a{color:red;}"];
  [@css ".css-10mby7r-_test .-\\31 a{color:red;}"];
  [@css ".css-1vlbr1m-_test #\\31 a{color:red;}"];
  [@css ".css-1klhelx-_test .a\\.b{color:red;}"];
  [@css ".css-1jd2wma-_test .foo\\:bar{color:red;}"];
  [@css ".css-67142b-_test .a\\/b{color:red;}"];
  [@css ".css-nxfkpb-_test .foo\\ bar{color:red;}"];
  [@css ".css-r5hrsz-_test .héllo{color:red;}"];
  [@css ".css-hufzp0-_test .foo:not(.a\\.b){color:red;}"];
  [@css ".css-1x6t703{--custom\\ prop:red;}"];
  [@css.bindings
    [
      (
        "Input._test",
        "css-14kiwtd-_test css-10mby7r-_test css-1vlbr1m-_test css-1klhelx-_test css-1jd2wma-_test css-67142b-_test css-nxfkpb-_test css-r5hrsz-_test css-hufzp0-_test",
      ),
    ]
  ];
  let _test =
    CSS.make(
      "css-14kiwtd-_test css-10mby7r-_test css-1vlbr1m-_test css-1klhelx-_test css-1jd2wma-_test css-67142b-_test css-nxfkpb-_test css-r5hrsz-_test css-hufzp0-_test",
      [],
    );
  
  CSS.make("css-1x6t703", []);

  $ dune build
