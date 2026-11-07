This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

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
        "_agwSZhKiI",
        ["._agwSZhKiI{quotes:auto;}"],
        1,
        0,
        1,
        [("value", "SZhKiI", "val\\0gw\\0& | \\0quotes:auto")],
      ),
      (
        "_a8inQWEMe",
        ["._a8inQWEMe{content:\"►\" / \"\";}"],
        1,
        0,
        1,
        [("value", "nQWEMe", "val\\08i\\0& | \\0content:\"►\" / \"\"")],
      ),
      (
        "_a8idP-tby",
        ["._a8idP-tby{content:\"\";}"],
        1,
        0,
        1,
        [("value", "dP-tby", "val\\08i\\0& | \\0content:\"\"")],
      ),
      (
        "_a8iTtuts0",
        ["._a8iTtuts0{content:counter(ol);}"],
        1,
        0,
        1,
        [("value", "Ttuts0", "val\\08i\\0& | \\0content:counter(ol)")],
      ),
      (
        "_a8i7VlGvG",
        ["._a8i7VlGvG{content:counter(count, decimal);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "7VlGvG",
            "val\\08i\\0& | \\0content:counter(count, decimal)",
          ),
        ],
      ),
      (
        "_a8ir-9hue",
        ["._a8ir-9hue{content:counter(count, decimal) \") \";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "r-9hue",
            "val\\08i\\0& | \\0content:counter(count, decimal) \") \"",
          ),
        ],
      ),
      (
        "_a8iAfFl6H",
        ["._a8iAfFl6H{content:unset;}"],
        1,
        0,
        1,
        [("value", "AfFl6H", "val\\08i\\0& | \\0content:unset")],
      ),
      (
        "_a8iMUFDOw",
        ["._a8iMUFDOw{content:normal;}"],
        1,
        0,
        1,
        [("value", "MUFDOw", "val\\08i\\0& | \\0content:normal")],
      ),
      (
        "_a8iNL7OPk",
        ["._a8iNL7OPk{content:none;}"],
        1,
        0,
        1,
        [("value", "NL7OPk", "val\\08i\\0& | \\0content:none")],
      ),
      (
        "_a8i__bNTr",
        ["._a8i__bNTr{content:url(\"http://www.example.com/test.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "__bNTr",
            "val\\08i\\0& | \\0content:url(\"http://www.example.com/test.png\")",
          ),
        ],
      ),
      (
        "_a8i59l1gi",
        ["._a8i59l1gi{content:linear-gradient(#e66465, #9198e5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "59l1gi",
            "val\\08i\\0& | \\0content:linear-gradient(#e66465, #9198e5)",
          ),
        ],
      ),
      (
        "_a8iKhdGny",
        [
          "._a8iKhdGny{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "KhdGny",
            "val\\08i\\0& | \\0content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x)",
          ),
        ],
      ),
      (
        "_a8i87IVQa",
        [
          "._a8i87IVQa{content:url(\"../img/test.png\") / \"This is the alt text\";}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "87IVQa",
            "val\\08i\\0& | \\0content:url(\"../img/test.png\") / \"This is the alt text\"",
          ),
        ],
      ),
      (
        "_a8iLXWSk4",
        ["._a8iLXWSk4{content:\"unparsed text\";}"],
        1,
        0,
        1,
        [("value", "LXWSk4", "val\\08i\\0& | \\0content:\"unparsed text\"")],
      ),
      (
        "_a8iMNXfX7",
        ["._a8iMNXfX7{content:counter(chapter_counter);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MNXfX7",
            "val\\08i\\0& | \\0content:counter(chapter_counter)",
          ),
        ],
      ),
      (
        "_a8ipu50dD",
        ["._a8ipu50dD{content:counter(chapter_counter, upper-roman);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pu50dD",
            "val\\08i\\0& | \\0content:counter(chapter_counter, upper-roman)",
          ),
        ],
      ),
      (
        "_a8iOan5kI",
        ["._a8iOan5kI{content:counters(section_counter, \".\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Oan5kI",
            "val\\08i\\0& | \\0content:counters(section_counter, \".\")",
          ),
        ],
      ),
      (
        "_a8i5xiSpD",
        [
          "._a8i5xiSpD{content:counters(section_counter, \".\", decimal-leading-zero);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "5xiSpD",
            "val\\08i\\0& | \\0content:counters(section_counter, \".\", decimal-leading-zero)",
          ),
        ],
      ),
      (
        "_a8iZh_g0M",
        ["._a8iZh_g0M{content:attr(href);}"],
        1,
        0,
        1,
        [("value", "Zh_g0M", "val\\08i\\0& | \\0content:attr(href)")],
      ),
      (
        "_a8iPzjNbn",
        ["._a8iPzjNbn{content:attr(data-width px);}"],
        1,
        0,
        1,
        [("value", "PzjNbn", "val\\08i\\0& | \\0content:attr(data-width px)")],
      ),
      (
        "_a8iNFCg9i",
        ["._a8iNFCg9i{content:open-quote;}"],
        1,
        0,
        1,
        [("value", "NFCg9i", "val\\08i\\0& | \\0content:open-quote")],
      ),
      (
        "_a8iXlPfpL",
        ["._a8iXlPfpL{content:close-quote;}"],
        1,
        0,
        1,
        [("value", "XlPfpL", "val\\08i\\0& | \\0content:close-quote")],
      ),
      (
        "_a8iAswwHC",
        ["._a8iAswwHC{content:no-open-quote;}"],
        1,
        0,
        1,
        [("value", "AswwHC", "val\\08i\\0& | \\0content:no-open-quote")],
      ),
      (
        "_a8iumxOK6",
        ["._a8iumxOK6{content:no-close-quote;}"],
        1,
        0,
        1,
        [("value", "umxOK6", "val\\08i\\0& | \\0content:no-close-quote")],
      ),
      (
        "_a8i5OFv-C",
        [
          "._a8i5OFv-C{content:\"prefix\" url(\"http://www.example.com/test.png\");}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "5OFv-C",
            "val\\08i\\0& | \\0content:\"prefix\" url(\"http://www.example.com/test.png\")",
          ),
        ],
      ),
      (
        "_a8ioyTYEc",
        [
          "._a8ioyTYEc{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "oyTYEc",
            "val\\08i\\0& | \\0content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\"",
          ),
        ],
      ),
      (
        "_a8i94x6G5",
        ["._a8i94x6G5{content:open-quote counter(chapter_counter);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "94x6G5",
            "val\\08i\\0& | \\0content:open-quote counter(chapter_counter)",
          ),
        ],
      ),
      (
        "_a8iaTKl3u",
        ["._a8iaTKl3u{content:inherit;}"],
        1,
        0,
        1,
        [("value", "aTKl3u", "val\\08i\\0& | \\0content:inherit")],
      ),
      (
        "_a8ingMzar",
        ["._a8ingMzar{content:initial;}"],
        1,
        0,
        1,
        [("value", "ngMzar", "val\\08i\\0& | \\0content:initial")],
      ),
      (
        "_a8iUBTfiY",
        ["._a8iUBTfiY{content:revert;}"],
        1,
        0,
        1,
        [("value", "UBTfiY", "val\\08i\\0& | \\0content:revert")],
      ),
      (
        "_a8ilDZBOA",
        ["._a8ilDZBOA{content:revert-layer;}"],
        1,
        0,
        1,
        [("value", "lDZBOA", "val\\08i\\0& | \\0content:revert-layer")],
      ),
      (
        "_a8i4v2rUc",
        ["._a8i4v2rUc{content:\"点\";}"],
        1,
        0,
        1,
        [("value", "4v2rUc", "val\\08i\\0& | \\0content:\"点\"")],
      ),
      (
        "_a8i3muMMW",
        ["._a8i3muMMW{content:\"lola\";}"],
        1,
        0,
        1,
        [("value", "3muMMW", "val\\08i\\0& | \\0content:\"lola\"")],
      ),
      (
        "_a8ioce12U",
        ["._a8ioce12U{content:\" \";}"],
        1,
        0,
        1,
        [("value", "oce12U", "val\\08i\\0& | \\0content:\" \"")],
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
        "_a8i-GGEma",
        ["._a8i-GGEma{content:\"\\\"\";}"],
        1,
        0,
        1,
        [("value", "-GGEma", "val\\08i\\0& | \\0content:\"\\\\\"\"")],
      ),
      (
        "_a8itTw2PO",
        ["._a8itTw2PO{content:attr(data-value);}"],
        1,
        0,
        1,
        [("value", "tTw2PO", "val\\08i\\0& | \\0content:attr(data-value)")],
      ),
      (
        "_a8iWukNdE",
        ["._a8iWukNdE{content:attr(data-value raw-string);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "WukNdE",
            "val\\08i\\0& | \\0content:attr(data-value raw-string)",
          ),
        ],
      ),
      (
        "_a8i8k1eTx",
        ["._a8i8k1eTx{content:attr(data-value em);}"],
        1,
        0,
        1,
        [("value", "8k1eTx", "val\\08i\\0& | \\0content:attr(data-value em)")],
      ),
      (
        "_a8iEfJrLg",
        ["._a8iEfJrLg{content:attr(data-value px);}"],
        1,
        0,
        1,
        [("value", "EfJrLg", "val\\08i\\0& | \\0content:attr(data-value px)")],
      ),
      (
        "_a8i_gmrcK",
        ["._a8i_gmrcK{content:\"→\";}"],
        1,
        0,
        1,
        [("value", "_gmrcK", "val\\08i\\0& | \\0content:\"→\"")],
      ),
      (
        "_a8i3o8Gge",
        ["._a8i3o8Gge{content:\"←\";}"],
        1,
        0,
        1,
        [("value", "3o8Gge", "val\\08i\\0& | \\0content:\"←\"")],
      ),
      (
        "_a8in7zqKb",
        ["._a8in7zqKb{content:\"↑\";}"],
        1,
        0,
        1,
        [("value", "n7zqKb", "val\\08i\\0& | \\0content:\"↑\"")],
      ),
      (
        "_a8iOuGfkg",
        ["._a8iOuGfkg{content:\"↓\";}"],
        1,
        0,
        1,
        [("value", "OuGfkg", "val\\08i\\0& | \\0content:\"↓\"")],
      ),
      (
        "_a8ii6dUL5",
        ["._a8ii6dUL5{content:\"“\";}"],
        1,
        0,
        1,
        [("value", "i6dUL5", "val\\08i\\0& | \\0content:\"“\"")],
      ),
      (
        "_a8iCF6DzT",
        ["._a8iCF6DzT{content:\"‘\";}"],
        1,
        0,
        1,
        [("value", "CF6DzT", "val\\08i\\0& | \\0content:\"‘\"")],
      ),
      (
        "_a8iJzVAtl",
        ["._a8iJzVAtl{content:\"’\";}"],
        1,
        0,
        1,
        [("value", "JzVAtl", "val\\08i\\0& | \\0content:\"’\"")],
      ),
      (
        "_a8iiAc6xw",
        ["._a8iiAc6xw{content:\"•\";}"],
        1,
        0,
        1,
        [("value", "iAc6xw", "val\\08i\\0& | \\0content:\"•\"")],
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
        "_a8iUUS7Y2",
        ["._a8iUUS7Y2{content:\"…\";}"],
        1,
        0,
        1,
        [("value", "UUS7Y2", "val\\08i\\0& | \\0content:\"…\"")],
      ),
      (
        "_a8id3h6vt",
        ["._a8id3h6vt{content:\"♥\";}"],
        1,
        0,
        1,
        [("value", "d3h6vt", "val\\08i\\0& | \\0content:\"♥\"")],
      ),
      (
        "_a8imibL13",
        ["._a8imibL13{content:\"✓\";}"],
        1,
        0,
        1,
        [("value", "mibL13", "val\\08i\\0& | \\0content:\"✓\"")],
      ),
      (
        "_a8iJG45V0",
        ["._a8iJG45V0{content:\"✗\";}"],
        1,
        0,
        1,
        [("value", "JG45V0", "val\\08i\\0& | \\0content:\"✗\"")],
      ),
      (
        "_a8iKdxJf4",
        ["._a8iKdxJf4{content:\"✦\";}"],
        1,
        0,
        1,
        [("value", "KdxJf4", "val\\08i\\0& | \\0content:\"✦\"")],
      ),
      (
        "_a8it8yLaf",
        ["._a8it8yLaf{content:\"\" attr(data-title) \"”\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "t8yLaf",
            "val\\08i\\0& | \\0content:\"\" attr(data-title) \"”\"",
          ),
        ],
      ),
      (
        "_a8iDrDvgq",
        ["._a8iDrDvgq{content:\"→\" \" Click here\";}"],
        1,
        0,
        1,
        [
          ("value", "DrDvgq", "val\\08i\\0& | \\0content:\"→\" \" Click here\""),
        ],
      ),
      (
        "_a8itf7ln2",
        ["._a8itf7ln2{content:\"Step \" counter(step, decimal) \": \";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "tf7ln2",
            "val\\08i\\0& | \\0content:\"Step \" counter(step, decimal) \": \"",
          ),
        ],
      ),
      (
        "_a8iDXGc23",
        ["._a8iDXGc23{content:\"💡\";}"],
        1,
        0,
        1,
        [("value", "DXGc23", "val\\08i\\0& | \\0content:\"💡\"")],
      ),
      (
        "_a8in_BppB",
        ["._a8in_BppB{content:\"👍\";}"],
        1,
        0,
        1,
        [("value", "n_BppB", "val\\08i\\0& | \\0content:\"👍\"")],
      ),
      (
        "_a8i04Z5QB",
        ["._a8i04Z5QB{content:\"»\";}"],
        1,
        0,
        1,
        [("value", "04Z5QB", "val\\08i\\0& | \\0content:\"»\"")],
      ),
      (
        "_a8i9B3lNo",
        ["._a8i9B3lNo{content:\"§\";}"],
        1,
        0,
        1,
        [("value", "9B3lNo", "val\\08i\\0& | \\0content:\"§\"")],
      ),
      (
        "_a8i54lJ8u",
        ["._a8i54lJ8u{content:\"→ \" attr(href);}"],
        1,
        0,
        1,
        [("value", "54lJ8u", "val\\08i\\0& | \\0content:\"→ \" attr(href)")],
      ),
      (
        "_a8inR1_af",
        ["._a8inR1_af{content:\"• \" counter(item, decimal) \" \";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nR1_af",
            "val\\08i\\0& | \\0content:\"• \" counter(item, decimal) \" \"",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_agwSZhKiI", []);
  
  CSS.make("_a8inQWEMe", []);
  
  CSS.make("_a8idP-tby", []);
  
  CSS.make("_a8iTtuts0", []);
  CSS.make("_a8i7VlGvG", []);
  CSS.make("_a8ir-9hue", []);
  CSS.make("_a8iAfFl6H", []);
  
  CSS.make("_a8iMUFDOw", []);
  CSS.make("_a8iNL7OPk", []);
  
  CSS.make("_a8i__bNTr", []);
  CSS.make("_a8i59l1gi", []);
  CSS.make("_a8iKhdGny", []);
  
  CSS.make("_a8i87IVQa", []);
  
  CSS.make("_a8iLXWSk4", []);
  
  CSS.make("_a8iMNXfX7", []);
  CSS.make("_a8ipu50dD", []);
  
  CSS.make("_a8iOan5kI", []);
  CSS.make("_a8i5xiSpD", []);
  
  CSS.make("_a8iZh_g0M", []);
  CSS.make("_a8iPzjNbn", []);
  
  CSS.make("_a8iNFCg9i", []);
  CSS.make("_a8iXlPfpL", []);
  CSS.make("_a8iAswwHC", []);
  CSS.make("_a8iumxOK6", []);
  
  CSS.make("_a8i5OFv-C", []);
  CSS.make("_a8ioyTYEc", []);
  
  CSS.make("_a8i94x6G5", []);
  
  CSS.make("_a8iaTKl3u", []);
  CSS.make("_a8ingMzar", []);
  CSS.make("_a8iUBTfiY", []);
  CSS.make("_a8ilDZBOA", []);
  CSS.make("_a8iAfFl6H", []);
  
  CSS.make("_a8i4v2rUc", []);
  CSS.make("_a8i4v2rUc", []);
  CSS.make("_a8i4v2rUc", []);
  CSS.make("_a8i3muMMW", []);
  CSS.make("_a8i3muMMW", []);
  CSS.make("_a8idP-tby", []);
  CSS.make("_a8ioce12U", []);
  CSS.make("_a8ioce12U", []);
  CSS.make("_a8idP-tby", []);
  CSS.make("_a8igZuIvg", []);
  CSS.make("_a8i-GGEma", []);
  
  CSS.make("_a8iZh_g0M", []);
  CSS.make("_a8itTw2PO", []);
  
  CSS.make("_a8iWukNdE", []);
  CSS.make("_a8i8k1eTx", []);
  CSS.make("_a8iEfJrLg", []);
  
  CSS.make("_a8i_gmrcK", []);
  CSS.make("_a8i3o8Gge", []);
  CSS.make("_a8in7zqKb", []);
  CSS.make("_a8iOuGfkg", []);
  
  CSS.make("_a8ii6dUL5", []);
  
  CSS.make("_a8iCF6DzT", []);
  CSS.make("_a8iJzVAtl", []);
  
  CSS.make("_a8iiAc6xw", []);
  CSS.make("_a8iuXKjZH", []);
  CSS.make("_a8iUUS7Y2", []);
  CSS.make("_a8id3h6vt", []);
  CSS.make("_a8imibL13", []);
  CSS.make("_a8iJG45V0", []);
  CSS.make("_a8iKdxJf4", []);
  
  CSS.make("_a8it8yLaf", []);
  CSS.make("_a8iDrDvgq", []);
  CSS.make("_a8itf7ln2", []);
  
  CSS.make("_a8iDXGc23", []);
  CSS.make("_a8in_BppB", []);
  
  CSS.make("_a8i04Z5QB", []);
  CSS.make("_a8i9B3lNo", []);
  
  CSS.make("_a8i_gmrcK", []);
  CSS.make("_a8ioce12U", []);
  
  CSS.make("_a8i_gmrcK", []);
  CSS.make("_a8iiAc6xw", []);
  CSS.make("_a8iuXKjZH", []);
  CSS.make("_a8iUUS7Y2", []);
  CSS.make("_a8i-GGEma", []);
  CSS.make("_a8i-GGEma", []);
  CSS.make("_a8imibL13", []);
  CSS.make("_a8id3h6vt", []);
  CSS.make("_a8i54lJ8u", []);
  CSS.make("_a8inR1_af", []);
