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
    (
      "._a_4pi0m4eiwtd .\\31 a{color:red;}",
      "_a_4pi0m4eiwtd",
      "0,2,0 & .\\31 a",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_48it44eby7r .-\\31 a{color:red;}",
      "_a_48it44eby7r",
      "0,2,0 & .-\\31 a",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4k2bk4ebr1m #\\31 a{color:red;}",
      "_a_4k2bk4ebr1m",
      "1,1,0 & #\\31 a",
      "158",
      1,
      true,
    )
  ];
  [@css
    (
      "._a_fb9h24ehelx .a\\.b{color:red;}",
      "_a_fb9h24ehelx",
      "0,2,0 & .a\\.b",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_w3jcb4e2wma .foo\\:bar{color:red;}",
      "_a_w3jcb4e2wma",
      "0,2,0 & .foo\\:bar",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_lcdsg4e142b .a\\/b{color:red;}",
      "_a_lcdsg4e142b",
      "0,2,0 & .a\\/b",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_nyseq4efkpb .foo\\ bar{color:red;}",
      "_a_nyseq4efkpb",
      "0,2,0 & .foo\\ bar",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_p85254ehrsz .héllo{color:red;}",
      "_a_p85254ehrsz",
      "0,2,0 & .héllo",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_u8qrs4efzp0 .foo:not(.a\\.b){color:red;}",
      "_a_u8qrs4efzp0",
      "0,3,0 & .foo:not(.a\\.b)",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_zyvb5paat703{--custom\\ prop:red;}",
      "_a_zyvb5paat703",
      "0,1,0 own",
      "-c1893193282",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      (
        "Input._test",
        "_id_uwo8zr",
        "_a_4pi0m4eiwtd _a_48it44eby7r _a_4k2bk4ebr1m _a_fb9h24ehelx _a_w3jcb4e2wma _a_lcdsg4e142b _a_nyseq4efkpb _a_p85254ehrsz _a_u8qrs4efzp0",
      ),
    ]
  ];
  [@css.blocks
    [(2, "_id_uwo8zr", [0, 1, 2, 3, 4, 5, 6, 7, 8]), (15, "", [9])]
  ];
  let _test =
    CSS.make(
      "label:_test _id_uwo8zr _a_4pi0m4eiwtd _a_48it44eby7r _a_4k2bk4ebr1m _a_fb9h24ehelx _a_w3jcb4e2wma _a_lcdsg4e142b _a_nyseq4efkpb _a_p85254ehrsz _a_u8qrs4efzp0",
      [],
    );
  
  CSS.make("_a_zyvb5paat703", []);

  $ dune build
