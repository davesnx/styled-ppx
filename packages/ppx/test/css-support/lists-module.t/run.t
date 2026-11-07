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
        "_acsE-DInP",
        ["._acsE-DInP{list-style-type:disclosure-closed;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "E-DInP",
            "val\\0cs\\0& | \\0list-style-type:disclosure-closed",
          ),
        ],
      ),
      (
        "_acsxeCjLq",
        ["._acsxeCjLq{list-style-type:disclosure-open;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "xeCjLq",
            "val\\0cs\\0& | \\0list-style-type:disclosure-open",
          ),
        ],
      ),
      (
        "_acsnJXC40",
        ["._acsnJXC40{list-style-type:hebrew;}"],
        1,
        0,
        1,
        [("value", "nJXC40", "val\\0cs\\0& | \\0list-style-type:hebrew")],
      ),
      (
        "_acsd6Y1Lg",
        ["._acsd6Y1Lg{list-style-type:cjk-decimal;}"],
        1,
        0,
        1,
        [("value", "d6Y1Lg", "val\\0cs\\0& | \\0list-style-type:cjk-decimal")],
      ),
      (
        "_acsi3pnIB",
        ["._acsi3pnIB{list-style-type:cjk-ideographic;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "i3pnIB",
            "val\\0cs\\0& | \\0list-style-type:cjk-ideographic",
          ),
        ],
      ),
      (
        "_acsCSdAru",
        ["._acsCSdAru{list-style-type:hiragana;}"],
        1,
        0,
        1,
        [("value", "CSdAru", "val\\0cs\\0& | \\0list-style-type:hiragana")],
      ),
      (
        "_acsh8EgQw",
        ["._acsh8EgQw{list-style-type:katakana;}"],
        1,
        0,
        1,
        [("value", "h8EgQw", "val\\0cs\\0& | \\0list-style-type:katakana")],
      ),
      (
        "_acsl1nobp",
        ["._acsl1nobp{list-style-type:hiragana-iroha;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l1nobp",
            "val\\0cs\\0& | \\0list-style-type:hiragana-iroha",
          ),
        ],
      ),
      (
        "_acscjGQa0",
        ["._acscjGQa0{list-style-type:katakana-iroha;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cjGQa0",
            "val\\0cs\\0& | \\0list-style-type:katakana-iroha",
          ),
        ],
      ),
      (
        "_acs2psItR",
        ["._acs2psItR{list-style-type:japanese-informal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2psItR",
            "val\\0cs\\0& | \\0list-style-type:japanese-informal",
          ),
        ],
      ),
      (
        "_acshhGvsb",
        ["._acshhGvsb{list-style-type:japanese-formal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hhGvsb",
            "val\\0cs\\0& | \\0list-style-type:japanese-formal",
          ),
        ],
      ),
      (
        "_acs2tvIhr",
        ["._acs2tvIhr{list-style-type:korean-hangul-formal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2tvIhr",
            "val\\0cs\\0& | \\0list-style-type:korean-hangul-formal",
          ),
        ],
      ),
      (
        "_acsdSxV-v",
        ["._acsdSxV-v{list-style-type:korean-hanja-informal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "dSxV-v",
            "val\\0cs\\0& | \\0list-style-type:korean-hanja-informal",
          ),
        ],
      ),
      (
        "_acsF-71Ff",
        ["._acsF-71Ff{list-style-type:korean-hanja-formal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "F-71Ff",
            "val\\0cs\\0& | \\0list-style-type:korean-hanja-formal",
          ),
        ],
      ),
      (
        "_acsbkr63v",
        ["._acsbkr63v{list-style-type:simp-chinese-informal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bkr63v",
            "val\\0cs\\0& | \\0list-style-type:simp-chinese-informal",
          ),
        ],
      ),
      (
        "_acsiIQD0p",
        ["._acsiIQD0p{list-style-type:simp-chinese-formal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iIQD0p",
            "val\\0cs\\0& | \\0list-style-type:simp-chinese-formal",
          ),
        ],
      ),
      (
        "_acsRh33Us",
        ["._acsRh33Us{list-style-type:trad-chinese-informal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Rh33Us",
            "val\\0cs\\0& | \\0list-style-type:trad-chinese-informal",
          ),
        ],
      ),
      (
        "_acs4vP-Uz",
        ["._acs4vP-Uz{list-style-type:trad-chinese-formal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "4vP-Uz",
            "val\\0cs\\0& | \\0list-style-type:trad-chinese-formal",
          ),
        ],
      ),
      (
        "_acskKOi2E",
        ["._acskKOi2E{list-style-type:cjk-heavenly-stem;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "kKOi2E",
            "val\\0cs\\0& | \\0list-style-type:cjk-heavenly-stem",
          ),
        ],
      ),
      (
        "_acsnGAuWa",
        ["._acsnGAuWa{list-style-type:cjk-earthly-branch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nGAuWa",
            "val\\0cs\\0& | \\0list-style-type:cjk-earthly-branch",
          ),
        ],
      ),
      (
        "_acsnaKv69",
        ["._acsnaKv69{list-style-type:arabic-indic;}"],
        1,
        0,
        1,
        [
          ("value", "naKv69", "val\\0cs\\0& | \\0list-style-type:arabic-indic"),
        ],
      ),
      (
        "_acsdF44xf",
        ["._acsdF44xf{list-style-type:persian;}"],
        1,
        0,
        1,
        [("value", "dF44xf", "val\\0cs\\0& | \\0list-style-type:persian")],
      ),
      (
        "_acsZXgbhd",
        ["._acsZXgbhd{list-style-type:urdu;}"],
        1,
        0,
        1,
        [("value", "ZXgbhd", "val\\0cs\\0& | \\0list-style-type:urdu")],
      ),
      (
        "_acsR8dEqf",
        ["._acsR8dEqf{list-style-type:devanagari;}"],
        1,
        0,
        1,
        [("value", "R8dEqf", "val\\0cs\\0& | \\0list-style-type:devanagari")],
      ),
      (
        "_acsIxOePy",
        ["._acsIxOePy{list-style-type:gurmukhi;}"],
        1,
        0,
        1,
        [("value", "IxOePy", "val\\0cs\\0& | \\0list-style-type:gurmukhi")],
      ),
      (
        "_acsQ4ahBH",
        ["._acsQ4ahBH{list-style-type:gujarati;}"],
        1,
        0,
        1,
        [("value", "Q4ahBH", "val\\0cs\\0& | \\0list-style-type:gujarati")],
      ),
      (
        "_acsxvhUP0",
        ["._acsxvhUP0{list-style-type:oriya;}"],
        1,
        0,
        1,
        [("value", "xvhUP0", "val\\0cs\\0& | \\0list-style-type:oriya")],
      ),
      (
        "_acs7ZipmZ",
        ["._acs7ZipmZ{list-style-type:kannada;}"],
        1,
        0,
        1,
        [("value", "7ZipmZ", "val\\0cs\\0& | \\0list-style-type:kannada")],
      ),
      (
        "_acsEgrvqG",
        ["._acsEgrvqG{list-style-type:malayalam;}"],
        1,
        0,
        1,
        [("value", "EgrvqG", "val\\0cs\\0& | \\0list-style-type:malayalam")],
      ),
      (
        "_acsoriGhr",
        ["._acsoriGhr{list-style-type:bengali;}"],
        1,
        0,
        1,
        [("value", "oriGhr", "val\\0cs\\0& | \\0list-style-type:bengali")],
      ),
      (
        "_acsrDfGW6",
        ["._acsrDfGW6{list-style-type:tamil;}"],
        1,
        0,
        1,
        [("value", "rDfGW6", "val\\0cs\\0& | \\0list-style-type:tamil")],
      ),
      (
        "_acs0O9dQH",
        ["._acs0O9dQH{list-style-type:telugu;}"],
        1,
        0,
        1,
        [("value", "0O9dQH", "val\\0cs\\0& | \\0list-style-type:telugu")],
      ),
      (
        "_acsPkKQ6m",
        ["._acsPkKQ6m{list-style-type:thai;}"],
        1,
        0,
        1,
        [("value", "PkKQ6m", "val\\0cs\\0& | \\0list-style-type:thai")],
      ),
      (
        "_acsfUjtpi",
        ["._acsfUjtpi{list-style-type:lao;}"],
        1,
        0,
        1,
        [("value", "fUjtpi", "val\\0cs\\0& | \\0list-style-type:lao")],
      ),
      (
        "_acsBXINtZ",
        ["._acsBXINtZ{list-style-type:myanmar;}"],
        1,
        0,
        1,
        [("value", "BXINtZ", "val\\0cs\\0& | \\0list-style-type:myanmar")],
      ),
      (
        "_acs7rnbqt",
        ["._acs7rnbqt{list-style-type:khmer;}"],
        1,
        0,
        1,
        [("value", "7rnbqt", "val\\0cs\\0& | \\0list-style-type:khmer")],
      ),
      (
        "_acsAWSnSU",
        ["._acsAWSnSU{list-style-type:hangul;}"],
        1,
        0,
        1,
        [("value", "AWSnSU", "val\\0cs\\0& | \\0list-style-type:hangul")],
      ),
      (
        "_acse-RhYS",
        ["._acse-RhYS{list-style-type:hangul-consonant;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "e-RhYS",
            "val\\0cs\\0& | \\0list-style-type:hangul-consonant",
          ),
        ],
      ),
      (
        "_acsj-gxRj",
        ["._acsj-gxRj{list-style-type:ethiopic-halehame;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "j-gxRj",
            "val\\0cs\\0& | \\0list-style-type:ethiopic-halehame",
          ),
        ],
      ),
      (
        "_acseh6NWv",
        ["._acseh6NWv{list-style-type:ethiopic-numeric;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "eh6NWv",
            "val\\0cs\\0& | \\0list-style-type:ethiopic-numeric",
          ),
        ],
      ),
      (
        "_acsXpTm9k",
        ["._acsXpTm9k{list-style-type:ethiopic-halehame-am;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XpTm9k",
            "val\\0cs\\0& | \\0list-style-type:ethiopic-halehame-am",
          ),
        ],
      ),
      (
        "_acsYqBmqj",
        ["._acsYqBmqj{list-style-type:ethiopic-halehame-ti-er;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YqBmqj",
            "val\\0cs\\0& | \\0list-style-type:ethiopic-halehame-ti-er",
          ),
        ],
      ),
      (
        "_acsQrNEen",
        ["._acsQrNEen{list-style-type:ethiopic-halehame-ti-et;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QrNEen",
            "val\\0cs\\0& | \\0list-style-type:ethiopic-halehame-ti-et",
          ),
        ],
      ),
      (
        "_acs8l_YJx",
        ["._acs8l_YJx{list-style-type:other-style;}"],
        1,
        0,
        1,
        [("value", "8l_YJx", "val\\0cs\\0& | \\0list-style-type:other-style")],
      ),
      (
        "_acsFoM8_2",
        ["._acsFoM8_2{list-style-type:inside;}"],
        1,
        0,
        1,
        [("value", "FoM8_2", "val\\0cs\\0& | \\0list-style-type:inside")],
      ),
      (
        "_acsL6gaWw",
        ["._acsL6gaWw{list-style-type:outside;}"],
        1,
        0,
        1,
        [("value", "L6gaWw", "val\\0cs\\0& | \\0list-style-type:outside")],
      ),
      (
        "_acsNoiCao",
        ["._acsNoiCao{list-style-type:\\32 style;}"],
        1,
        0,
        1,
        [
          ("value", "NoiCao", "val\\0cs\\0& | \\0list-style-type:\\\\32 style"),
        ],
      ),
      (
        "_acs0knFkl",
        ["._acs0knFkl{list-style-type:custom-counter-style;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0knFkl",
            "val\\0cs\\0& | \\0list-style-type:custom-counter-style",
          ),
        ],
      ),
      (
        "_acsZfX8Km",
        ["._acsZfX8Km{list-style-type:\"👍\";}"],
        1,
        0,
        1,
        [("value", "ZfX8Km", "val\\0cs\\0& | \\0list-style-type:\"👍\"")],
      ),
      (
        "_acs8phfPl",
        ["._acs8phfPl{list-style-type:\"-\";}"],
        1,
        0,
        1,
        [("value", "8phfPl", "val\\0cs\\0& | \\0list-style-type:\"-\"")],
      ),
      (
        "_a92GcS_0P",
        ["._a92GcS_0P{counter-reset:foo;}"],
        1,
        0,
        1,
        [("value", "GcS_0P", "val\\092\\0& | \\0counter-reset:foo")],
      ),
      (
        "_a92KObbkM",
        ["._a92KObbkM{counter-reset:foo 1;}"],
        1,
        0,
        1,
        [("value", "KObbkM", "val\\092\\0& | \\0counter-reset:foo 1")],
      ),
      (
        "_a92HkIOAl",
        ["._a92HkIOAl{counter-reset:foo 1 bar;}"],
        1,
        0,
        1,
        [("value", "HkIOAl", "val\\092\\0& | \\0counter-reset:foo 1 bar")],
      ),
      (
        "_a92zpMfkZ",
        ["._a92zpMfkZ{counter-reset:foo 1 bar 2;}"],
        1,
        0,
        1,
        [("value", "zpMfkZ", "val\\092\\0& | \\0counter-reset:foo 1 bar 2")],
      ),
      (
        "_a92lrX6Lw",
        ["._a92lrX6Lw{counter-reset:none;}"],
        1,
        0,
        1,
        [("value", "lrX6Lw", "val\\092\\0& | \\0counter-reset:none")],
      ),
      (
        "_a93lXcAqO",
        ["._a93lXcAqO{counter-set:foo;}"],
        1,
        0,
        1,
        [("value", "lXcAqO", "val\\093\\0& | \\0counter-set:foo")],
      ),
      (
        "_a935xqwRw",
        ["._a935xqwRw{counter-set:foo 1;}"],
        1,
        0,
        1,
        [("value", "5xqwRw", "val\\093\\0& | \\0counter-set:foo 1")],
      ),
      (
        "_a93zADCaH",
        ["._a93zADCaH{counter-set:foo 1 bar;}"],
        1,
        0,
        1,
        [("value", "zADCaH", "val\\093\\0& | \\0counter-set:foo 1 bar")],
      ),
      (
        "_a93FYVeRN",
        ["._a93FYVeRN{counter-set:foo 1 bar 2;}"],
        1,
        0,
        1,
        [("value", "FYVeRN", "val\\093\\0& | \\0counter-set:foo 1 bar 2")],
      ),
      (
        "_a9303gHLu",
        ["._a9303gHLu{counter-set:none;}"],
        1,
        0,
        1,
        [("value", "03gHLu", "val\\093\\0& | \\0counter-set:none")],
      ),
      (
        "_a91IJsLkg",
        ["._a91IJsLkg{counter-increment:foo;}"],
        1,
        0,
        1,
        [("value", "IJsLkg", "val\\091\\0& | \\0counter-increment:foo")],
      ),
      (
        "_a918XhsDm",
        ["._a918XhsDm{counter-increment:foo 1;}"],
        1,
        0,
        1,
        [("value", "8XhsDm", "val\\091\\0& | \\0counter-increment:foo 1")],
      ),
      (
        "_a91jNlT0J",
        ["._a91jNlT0J{counter-increment:foo 1 bar;}"],
        1,
        0,
        1,
        [("value", "jNlT0J", "val\\091\\0& | \\0counter-increment:foo 1 bar")],
      ),
      (
        "_a91dL2qVy",
        ["._a91dL2qVy{counter-increment:foo 1 bar 2;}"],
        1,
        0,
        1,
        [
          ("value", "dL2qVy", "val\\091\\0& | \\0counter-increment:foo 1 bar 2"),
        ],
      ),
      (
        "_a91qtcDZU",
        ["._a91qtcDZU{counter-increment:none;}"],
        1,
        0,
        1,
        [("value", "qtcDZU", "val\\091\\0& | \\0counter-increment:none")],
      ),
    ]
  ];
  
  CSS.make("_acsE-DInP", []);
  CSS.make("_acsxeCjLq", []);
  CSS.make("_acsnJXC40", []);
  CSS.make("_acsd6Y1Lg", []);
  CSS.make("_acsi3pnIB", []);
  CSS.make("_acsCSdAru", []);
  CSS.make("_acsh8EgQw", []);
  CSS.make("_acsl1nobp", []);
  CSS.make("_acscjGQa0", []);
  CSS.make("_acs2psItR", []);
  CSS.make("_acshhGvsb", []);
  CSS.make("_acs2tvIhr", []);
  CSS.make("_acsdSxV-v", []);
  CSS.make("_acsF-71Ff", []);
  CSS.make("_acsbkr63v", []);
  CSS.make("_acsiIQD0p", []);
  CSS.make("_acsRh33Us", []);
  CSS.make("_acs4vP-Uz", []);
  CSS.make("_acskKOi2E", []);
  CSS.make("_acsnGAuWa", []);
  CSS.make("_acsRh33Us", []);
  CSS.make("_acs4vP-Uz", []);
  CSS.make("_acsbkr63v", []);
  CSS.make("_acsiIQD0p", []);
  CSS.make("_acs2psItR", []);
  CSS.make("_acshhGvsb", []);
  CSS.make("_acsnaKv69", []);
  CSS.make("_acsdF44xf", []);
  CSS.make("_acsZXgbhd", []);
  CSS.make("_acsR8dEqf", []);
  CSS.make("_acsIxOePy", []);
  CSS.make("_acsQ4ahBH", []);
  CSS.make("_acsxvhUP0", []);
  CSS.make("_acs7ZipmZ", []);
  CSS.make("_acsEgrvqG", []);
  CSS.make("_acsoriGhr", []);
  CSS.make("_acsrDfGW6", []);
  CSS.make("_acs0O9dQH", []);
  CSS.make("_acsPkKQ6m", []);
  CSS.make("_acsfUjtpi", []);
  CSS.make("_acsBXINtZ", []);
  CSS.make("_acs7rnbqt", []);
  CSS.make("_acsAWSnSU", []);
  CSS.make("_acse-RhYS", []);
  CSS.make("_acsj-gxRj", []);
  CSS.make("_acseh6NWv", []);
  CSS.make("_acsXpTm9k", []);
  CSS.make("_acsYqBmqj", []);
  CSS.make("_acsQrNEen", []);
  CSS.make("_acs8l_YJx", []);
  CSS.make("_acsFoM8_2", []);
  CSS.make("_acsL6gaWw", []);
  
  CSS.make("_acsNoiCao", []);
  CSS.make("_acs0knFkl", []);
  CSS.make("_acsZfX8Km", []);
  CSS.make("_acs8phfPl", []);
  CSS.make("_acs8phfPl", []);
  
  CSS.make("_a92GcS_0P", []);
  CSS.make("_a92KObbkM", []);
  CSS.make("_a92HkIOAl", []);
  CSS.make("_a92zpMfkZ", []);
  CSS.make("_a92lrX6Lw", []);
  CSS.make("_a93lXcAqO", []);
  CSS.make("_a935xqwRw", []);
  CSS.make("_a93zADCaH", []);
  CSS.make("_a93FYVeRN", []);
  CSS.make("_a9303gHLu", []);
  CSS.make("_a91IJsLkg", []);
  CSS.make("_a918XhsDm", []);
  CSS.make("_a91jNlT0J", []);
  CSS.make("_a91dL2qVy", []);
  CSS.make("_a91qtcDZU", []);
