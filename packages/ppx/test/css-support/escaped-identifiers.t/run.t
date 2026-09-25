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
  [@css ".a-4pi0m4eiwtd .\\31 a{color:red;}"];
  [@css ".a-48it44eby7r .-\\31 a{color:red;}"];
  [@css ".a-4k2bk4ebr1m #\\31 a{color:red;}"];
  [@css ".a-fb9h24ehelx .a\\.b{color:red;}"];
  [@css ".a-w3jcb4e2wma .foo\\:bar{color:red;}"];
  [@css ".a-lcdsg4e142b .a\\/b{color:red;}"];
  [@css ".a-nyseq4efkpb .foo\\ bar{color:red;}"];
  [@css ".a-p85254ehrsz .héllo{color:red;}"];
  [@css ".a-u8qrs4efzp0 .foo:not(.a\\.b){color:red;}"];
  [@css ".a-zyvb5paat703{--custom\\ prop:red;}"];
  [@css.bindings
    [
      (
        "Input._test",
        "id-1gr654a",
        "a-4pi0m4eiwtd a-48it44eby7r a-4k2bk4ebr1m a-fb9h24ehelx a-w3jcb4e2wma a-lcdsg4e142b a-nyseq4efkpb a-p85254ehrsz a-u8qrs4efzp0",
      ),
    ]
  ];
  let _test =
    CSS.make(
      "label:_test id-1gr654a a-4pi0m4eiwtd a-48it44eby7r a-4k2bk4ebr1m a-fb9h24ehelx a-w3jcb4e2wma a-lcdsg4e142b a-nyseq4efkpb a-p85254ehrsz a-u8qrs4efzp0",
      [],
    );
  
  CSS.make("a-zyvb5paat703", []);

  $ dune build
