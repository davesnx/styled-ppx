String escape round-trip tests. Verifies that characters requiring
backslash escaping inside CSS <string-token>s are correctly re-encoded
when the AST is rendered back to a CSS string. See
documents/string-escape-bug.md for context.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_a8i-GGEma",
        ["._a8i-GGEma{content:\"\\\"\";}"],
        1,
        0,
        1,
        [("value", "-GGEma", "val\\08i\\0& | \\0content:\"\\\\\"\"")],
      ),
      (
        "_a8i8xsN6s",
        ["._a8i8xsN6s{content:\"\\\\\";}"],
        1,
        0,
        1,
        [("value", "8xsN6s", "val\\08i\\0& | \\0content:\"\\\\\\\\\"")],
      ),
      (
        "_a8igZuIvg",
        ["._a8igZuIvg{content:\"'\";}"],
        1,
        0,
        1,
        [("value", "gZuIvg", "val\\08i\\0& | \\0content:\"'\"")],
      ),
      (
        "_a8il8E_4G",
        ["._a8il8E_4G{content:\"a\\\"b\";}"],
        1,
        0,
        1,
        [("value", "l8E_4G", "val\\08i\\0& | \\0content:\"a\\\\\"b\"")],
      ),
      (
        "_a8iWVGK_X",
        ["._a8iWVGK_X{content:\"before\\\\after\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "WVGK_X",
            "val\\08i\\0& | \\0content:\"before\\\\\\\\after\"",
          ),
        ],
      ),
      (
        "_a8iekTnwE",
        ["._a8iekTnwE{content:\"line\\A one\";}"],
        1,
        0,
        1,
        [("value", "ekTnwE", "val\\08i\\0& | \\0content:\"line\\\\A one\"")],
      ),
      (
        "_a8iuXKjZH",
        ["._a8iuXKjZH{content:\"—\";}"],
        1,
        0,
        1,
        [("value", "uXKjZH", "val\\08i\\0& | \\0content:\"—\"")],
      ),
      (
        "_c7fIFMBMdkp4G9N",
        ["._c7fIFMBMdkp4G9N [data-name=\"O\\\"Brien\"]{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "IFMBMd", "ctx\\0& [data-name=\"O\\\\\"Brien\"] | "),
          (
            "value",
            "kp4G9N",
            "val\\07f\\0& [data-name=\"O\\\\\"Brien\"] | \\0color:red",
          ),
        ],
      ),
      (
        "_a4mx963xE",
        ["._a4mx963xE{background-image:url(\"path/with\\\"quote.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "x963xE",
            "val\\04m\\0& | \\0background-image:url(\"path/with\\\\\"quote.png\")",
          ),
        ],
      ),
      (
        "_a4mDHsFua",
        ["._a4mDHsFua{background-image:url(\"path\\\\to\\\\file.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DHsFua",
            "val\\04m\\0& | \\0background-image:url(\"path\\\\\\\\to\\\\\\\\file.png\")",
          ),
        ],
      ),
      (
        "_a8iuKM58j",
        ["._a8iuKM58j{content:\"\\9 \";}"],
        1,
        0,
        1,
        [("value", "uKM58j", "val\\08i\\0& | \\0content:\"\\\\9 \"")],
      ),
      (
        "_a8ikJ2Y4j",
        ["._a8ikJ2Y4j{content:\"\\7F \";}"],
        1,
        0,
        1,
        [("value", "kJ2Y4j", "val\\08i\\0& | \\0content:\"\\\\7F \"")],
      ),
    ]
  ];
  
  CSS.make("_a8i-GGEma", []);
  
  CSS.make("_a8i8xsN6s", []);
  
  CSS.make("_a8igZuIvg", []);
  
  CSS.make("_a8il8E_4G", []);
  
  CSS.make("_a8iWVGK_X", []);
  
  CSS.make("_a8iekTnwE", []);
  
  CSS.make("_a8iuXKjZH", []);
  
  CSS.make("_a8igZuIvg", []);
  
  CSS.make("_c7fIFMBMdkp4G9N", []);
  
  CSS.make("_a4mx963xE", []);
  
  CSS.make("_a4mDHsFua", []);
  
  CSS.make("_a8iuKM58j", []);
  
  CSS.make("_a8ikJ2Y4j", []);
