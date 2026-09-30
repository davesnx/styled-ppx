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
  [@css "._a_4pi0m4eiwtd .\\31 a{color:red;}"];
  [@css "._a_48it44eby7r .-\\31 a{color:red;}"];
  [@css "._a_4k2bk4ebr1m #\\31 a{color:red;}"];
  [@css "._a_fb9h24ehelx .a\\.b{color:red;}"];
  [@css "._a_w3jcb4e2wma .foo\\:bar{color:red;}"];
  [@css "._a_lcdsg4e142b .a\\/b{color:red;}"];
  [@css "._a_nyseq4efkpb .foo\\ bar{color:red;}"];
  [@css "._a_p85254ehrsz .héllo{color:red;}"];
  [@css "._a_u8qrs4efzp0 .foo:not(.a\\.b){color:red;}"];
  [@css "._a_zyvb5paat703{--custom\\ prop:red;}"];
  [@css.bindings
    [
      (
        "Input._test",
        "_id_1gr654a",
        "_a_4pi0m4eiwtd _a_48it44eby7r _a_4k2bk4ebr1m _a_fb9h24ehelx _a_w3jcb4e2wma _a_lcdsg4e142b _a_nyseq4efkpb _a_p85254ehrsz _a_u8qrs4efzp0",
      ),
    ]
  ];
  let _test =
    CSS.make(
      "label:_test _id_1gr654a _a_4pi0m4eiwtd _a_48it44eby7r _a_4k2bk4ebr1m _a_fb9h24ehelx _a_w3jcb4e2wma _a_lcdsg4e142b _a_nyseq4efkpb _a_p85254ehrsz _a_u8qrs4efzp0",
      [],
    );
  
  CSS.make("_a_zyvb5paat703", []);

  $ dune build
