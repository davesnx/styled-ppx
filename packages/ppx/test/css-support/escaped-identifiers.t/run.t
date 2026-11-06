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
  [@css.atoms
    [
      (
        "_bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34",
        [
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .\\31 a{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .-\\31 a{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 #\\31 a{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .a\\.b{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .foo\\:bar{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .a\\/b{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .foo\\ bar{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .héllo{color:red;}",
          "._bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34 .foo:not(.a\\.b){color:red;}",
        ],
        0,
        1,
        9,
        [
          ("ctx", "9DCaxS", "ctx\\0& .\\\\31 a | "),
          ("ctx", "z9ZcNq", "ctx\\0& .-\\\\31 a | "),
          ("ctx", "4thBrR", "ctx\\0& #\\\\31 a | "),
          ("ctx", "GASMLv", "ctx\\0& .a\\\\.b | "),
          ("ctx", "ZI_QqY", "ctx\\0& .foo\\\\:bar | "),
          ("ctx", "I60X2v", "ctx\\0& .a\\\\/b | "),
          ("ctx", "CL1Wdp", "ctx\\0& .foo\\\\ bar | "),
          ("ctx", "K-gtrS", "ctx\\0& .héllo | "),
          ("ctx", "TJNzGw", "ctx\\0& .foo:not(.a\\\\.b) | "),
          (
            "value",
            "E0mZ34",
            "bval\\0& .\\\\31 a | \\07f\\0color:red\\0& .-\\\\31 a | \\07f\\0color:red\\0& #\\\\31 a | \\07f\\0color:red\\0& .a\\\\.b | \\07f\\0color:red\\0& .foo\\\\:bar | \\07f\\0color:red\\0& .a\\\\/b | \\07f\\0color:red\\0& .foo\\\\ bar | \\07f\\0color:red\\0& .héllo | \\07f\\0color:red\\0& .foo:not(.a\\\\.b) | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_xMLN4WT000000pC72Dd",
        ["._xMLN4WT000000pC72Dd{--custom\\ prop:red;}"],
        1,
        0,
        1,
        [
          ("name", "MLN4WT", "name\\0--custom\\\\ prop"),
          (
            "value",
            "pC72Dd",
            "val\\0--custom\\\\ prop\\0& | \\0--custom\\\\ prop:red",
          ),
        ],
      ),
      (
        "_iXV5XLuz3",
        [],
        1,
        0,
        0,
        [("id", "_iXV5XLuz3", "bind\\0\\0Input\\0\\0_test\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input._test",
        "_iXV5XLuz3 _bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34",
        "_iXV5XLuz3",
      ),
    ]
  ];
  let _test =
    CSS.make(
      "_iXV5XLuz3 _bAJ7f9DCaxS7fz9ZcNq7f4thBrR7fGASMLv7fZI_QqY7fI60X2v7fCL1Wdp7fK-gtrS7fTJNzGwE0mZ34",
      [],
    );
  
  CSS.make("_xMLN4WT000000pC72Dd", []);

  $ dune build
