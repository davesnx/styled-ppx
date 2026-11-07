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
        "_am6HuTSFA",
        [
          "._am6HuTSFA{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}",
        ],
        1,
        0,
        1,
        [("value", "HuTSFA", "val\\0m6\\0& | \\0transform:none")],
      ),
      (
        "_am6KuzmFV",
        [
          "._am6KuzmFV{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}",
        ],
        1,
        0,
        1,
        [("value", "KuzmFV", "val\\0m6\\0& | \\0transform:translate(5px)")],
      ),
      (
        "_am69jXG6g",
        [
          "._am69jXG6g{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "9jXG6g",
            "val\\0m6\\0& | \\0transform:translate(5px, 10px)",
          ),
        ],
      ),
      (
        "_am62d_JYC",
        [
          "._am62d_JYC{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}",
        ],
        1,
        0,
        1,
        [("value", "2d_JYC", "val\\0m6\\0& | \\0transform:translateY(5px)")],
      ),
      (
        "_am6WTBUGh",
        [
          "._am6WTBUGh{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}",
        ],
        1,
        0,
        1,
        [("value", "WTBUGh", "val\\0m6\\0& | \\0transform:translateX(5px)")],
      ),
      (
        "_am6uoBq6G",
        [
          "._am6uoBq6G{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}",
        ],
        1,
        0,
        1,
        [("value", "uoBq6G", "val\\0m6\\0& | \\0transform:translateY(5%)")],
      ),
      (
        "_am6RlvBav",
        [
          "._am6RlvBav{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}",
        ],
        1,
        0,
        1,
        [("value", "RlvBav", "val\\0m6\\0& | \\0transform:translateX(5%)")],
      ),
      (
        "_am6mB1y-Z",
        [
          "._am6mB1y-Z{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}",
        ],
        1,
        0,
        1,
        [("value", "mB1y-Z", "val\\0m6\\0& | \\0transform:scale(2)")],
      ),
      (
        "_am6QtvNne",
        [
          "._am6QtvNne{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}",
        ],
        1,
        0,
        1,
        [("value", "QtvNne", "val\\0m6\\0& | \\0transform:scale(2, -1)")],
      ),
      (
        "_am6QMN3PE",
        [
          "._am6QMN3PE{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}",
        ],
        1,
        0,
        1,
        [("value", "QMN3PE", "val\\0m6\\0& | \\0transform:scaleX(2)")],
      ),
      (
        "_am6taglz2",
        [
          "._am6taglz2{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}",
        ],
        1,
        0,
        1,
        [("value", "taglz2", "val\\0m6\\0& | \\0transform:scaleY(2.5)")],
      ),
      (
        "_am6LJYOtK",
        [
          "._am6LJYOtK{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}",
        ],
        1,
        0,
        1,
        [("value", "LJYOtK", "val\\0m6\\0& | \\0transform:rotate(45deg)")],
      ),
      (
        "_am6qb5eKu",
        [
          "._am6qb5eKu{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}",
        ],
        1,
        0,
        1,
        [("value", "qb5eKu", "val\\0m6\\0& | \\0transform:skew(45deg)")],
      ),
      (
        "_am6gPfYjq",
        [
          "._am6gPfYjq{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}",
        ],
        1,
        0,
        1,
        [
          ("value", "gPfYjq", "val\\0m6\\0& | \\0transform:skew(45deg, 15deg)"),
        ],
      ),
      (
        "_am6KuIvGx",
        [
          "._am6KuIvGx{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}",
        ],
        1,
        0,
        1,
        [("value", "KuIvGx", "val\\0m6\\0& | \\0transform:skewX(45deg)")],
      ),
      (
        "_am6y3olGj",
        [
          "._am6y3olGj{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}",
        ],
        1,
        0,
        1,
        [("value", "y3olGj", "val\\0m6\\0& | \\0transform:skewY(45deg)")],
      ),
      (
        "_am6j-Jf-C",
        [
          "._am6j-Jf-C{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "j-Jf-C",
            "val\\0m6\\0& | \\0transform:translate(50px, -24px) skew(0, 22.5deg)",
          ),
        ],
      ),
      (
        "_am6GVfx-K",
        [
          "._am6GVfx-K{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "GVfx-K",
            "val\\0m6\\0& | \\0transform:translate3d(0, 0, 5px)",
          ),
        ],
      ),
      (
        "_am6S4FrJN",
        [
          "._am6S4FrJN{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}",
        ],
        1,
        0,
        1,
        [("value", "S4FrJN", "val\\0m6\\0& | \\0transform:translateZ(5px)")],
      ),
      (
        "_am6pKozNL",
        [
          "._am6pKozNL{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}",
        ],
        1,
        0,
        1,
        [("value", "pKozNL", "val\\0m6\\0& | \\0transform:scale3d(1, 0, -1)")],
      ),
      (
        "_am6AaPnIv",
        [
          "._am6AaPnIv{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}",
        ],
        1,
        0,
        1,
        [("value", "AaPnIv", "val\\0m6\\0& | \\0transform:scaleZ(1.5)")],
      ),
      (
        "_am63AluVJ",
        [
          "._am63AluVJ{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "3AluVJ",
            "val\\0m6\\0& | \\0transform:rotate3d(1, 1, 1, 45deg)",
          ),
        ],
      ),
      (
        "_am68RGvg2",
        [
          "._am68RGvg2{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}",
        ],
        1,
        0,
        1,
        [("value", "8RGvg2", "val\\0m6\\0& | \\0transform:rotateX(-45deg)")],
      ),
      (
        "_am6ViDO56",
        [
          "._am6ViDO56{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}",
        ],
        1,
        0,
        1,
        [("value", "ViDO56", "val\\0m6\\0& | \\0transform:rotateY(-45deg)")],
      ),
      (
        "_am6zAvcPo",
        [
          "._am6zAvcPo{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}",
        ],
        1,
        0,
        1,
        [("value", "zAvcPo", "val\\0m6\\0& | \\0transform:rotateZ(-45deg)")],
      ),
      (
        "_am6MVs4rB",
        [
          "._am6MVs4rB{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "MVs4rB",
            "val\\0m6\\0& | \\0transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5)",
          ),
        ],
      ),
      (
        "_am62MApTB",
        [
          "._am62MApTB{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}",
        ],
        1,
        0,
        1,
        [
          ("value", "2MApTB", "val\\0m6\\0& | \\0transform:perspective(600px)"),
        ],
      ),
      (
        "_am8eWM15z",
        ["._am8eWM15z{transform-origin:10px;}"],
        1,
        0,
        1,
        [("value", "eWM15z", "val\\0m8\\0& | \\0transform-origin:10px")],
      ),
      (
        "_am8AmKVFx",
        ["._am8AmKVFx{transform-origin:top;}"],
        1,
        0,
        1,
        [("value", "AmKVFx", "val\\0m8\\0& | \\0transform-origin:top")],
      ),
      (
        "_am83lZdN7",
        ["._am83lZdN7{transform-origin:top left;}"],
        1,
        0,
        1,
        [("value", "3lZdN7", "val\\0m8\\0& | \\0transform-origin:top left")],
      ),
      (
        "_am8u9L3ie",
        ["._am8u9L3ie{transform-origin:50% 100%;}"],
        1,
        0,
        1,
        [("value", "u9L3ie", "val\\0m8\\0& | \\0transform-origin:50% 100%")],
      ),
      (
        "_am8QTEtFQ",
        ["._am8QTEtFQ{transform-origin:left 0%;}"],
        1,
        0,
        1,
        [("value", "QTEtFQ", "val\\0m8\\0& | \\0transform-origin:left 0%")],
      ),
      (
        "_am8-Nc3PK",
        ["._am8-Nc3PK{transform-origin:left 50% 0;}"],
        1,
        0,
        1,
        [("value", "-Nc3PK", "val\\0m8\\0& | \\0transform-origin:left 50% 0")],
      ),
      (
        "_am7PlFEPR",
        ["._am7PlFEPR{transform-box:border-box;}"],
        1,
        0,
        1,
        [("value", "PlFEPR", "val\\0m7\\0& | \\0transform-box:border-box")],
      ),
      (
        "_am7hPIf3K",
        ["._am7hPIf3K{transform-box:fill-box;}"],
        1,
        0,
        1,
        [("value", "hPIf3K", "val\\0m7\\0& | \\0transform-box:fill-box")],
      ),
      (
        "_am7OtaeIs",
        ["._am7OtaeIs{transform-box:view-box;}"],
        1,
        0,
        1,
        [("value", "OtaeIs", "val\\0m7\\0& | \\0transform-box:view-box")],
      ),
      (
        "_am7Zkw2OV",
        ["._am7Zkw2OV{transform-box:content-box;}"],
        1,
        0,
        1,
        [("value", "Zkw2OV", "val\\0m7\\0& | \\0transform-box:content-box")],
      ),
      (
        "_am7qCbxdD",
        ["._am7qCbxdD{transform-box:stroke-box;}"],
        1,
        0,
        1,
        [("value", "qCbxdD", "val\\0m7\\0& | \\0transform-box:stroke-box")],
      ),
      (
        "_amgdkWmDZ",
        ["._amgdkWmDZ{translate:none;}"],
        1,
        0,
        1,
        [("value", "dkWmDZ", "val\\0mg\\0& | \\0translate:none")],
      ),
      (
        "_amgDWWzNm",
        ["._amgDWWzNm{translate:50%;}"],
        1,
        0,
        1,
        [("value", "DWWzNm", "val\\0mg\\0& | \\0translate:50%")],
      ),
      (
        "_amg8u9YyH",
        ["._amg8u9YyH{translate:50% 50%;}"],
        1,
        0,
        1,
        [("value", "8u9YyH", "val\\0mg\\0& | \\0translate:50% 50%")],
      ),
      (
        "_amgtHlJHz",
        ["._amgtHlJHz{translate:50% 50% 10px;}"],
        1,
        0,
        1,
        [("value", "tHlJHz", "val\\0mg\\0& | \\0translate:50% 50% 10px")],
      ),
      (
        "_ai6ywF4rN",
        ["._ai6ywF4rN{scale:none;}"],
        1,
        0,
        1,
        [("value", "ywF4rN", "val\\0i6\\0& | \\0scale:none")],
      ),
      (
        "_ai6QaL4MH",
        ["._ai6QaL4MH{scale:2;}"],
        1,
        0,
        1,
        [("value", "QaL4MH", "val\\0i6\\0& | \\0scale:2")],
      ),
      (
        "_ai60BjMJ4",
        ["._ai60BjMJ4{scale:2 2;}"],
        1,
        0,
        1,
        [("value", "0BjMJ4", "val\\0i6\\0& | \\0scale:2 2")],
      ),
      (
        "_ai6Gb_-Yl",
        ["._ai6Gb_-Yl{scale:2 2 2;}"],
        1,
        0,
        1,
        [("value", "Gb_-Yl", "val\\0i6\\0& | \\0scale:2 2 2")],
      ),
      (
        "_ah7JHmq3i",
        ["._ah7JHmq3i{rotate:none;}"],
        1,
        0,
        1,
        [("value", "JHmq3i", "val\\0h7\\0& | \\0rotate:none")],
      ),
      (
        "_ah7Rs51Y0",
        ["._ah7Rs51Y0{rotate:45deg;}"],
        1,
        0,
        1,
        [("value", "Rs51Y0", "val\\0h7\\0& | \\0rotate:45deg")],
      ),
      (
        "_ah7JQkM38",
        ["._ah7JQkM38{rotate:x 45deg;}"],
        1,
        0,
        1,
        [("value", "JQkM38", "val\\0h7\\0& | \\0rotate:x 45deg")],
      ),
      (
        "_ah7V5vD9S",
        ["._ah7V5vD9S{rotate:y 45deg;}"],
        1,
        0,
        1,
        [("value", "V5vD9S", "val\\0h7\\0& | \\0rotate:y 45deg")],
      ),
      (
        "_ah7dWpdCj",
        ["._ah7dWpdCj{rotate:z 45deg;}"],
        1,
        0,
        1,
        [("value", "dWpdCj", "val\\0h7\\0& | \\0rotate:z 45deg")],
      ),
      (
        "_ah7IiSOqg",
        ["._ah7IiSOqg{rotate:-1 0 2 45deg;}"],
        1,
        0,
        1,
        [("value", "IiSOqg", "val\\0h7\\0& | \\0rotate:-1 0 2 45deg")],
      ),
      (
        "_ah7sw3kWt",
        ["._ah7sw3kWt{rotate:45deg x;}"],
        1,
        0,
        1,
        [("value", "sw3kWt", "val\\0h7\\0& | \\0rotate:45deg x")],
      ),
      (
        "_ah7Paeil8",
        ["._ah7Paeil8{rotate:45deg y;}"],
        1,
        0,
        1,
        [("value", "Paeil8", "val\\0h7\\0& | \\0rotate:45deg y")],
      ),
      (
        "_ah7ELdifc",
        ["._ah7ELdifc{rotate:45deg z;}"],
        1,
        0,
        1,
        [("value", "ELdifc", "val\\0h7\\0& | \\0rotate:45deg z")],
      ),
      (
        "_ah7riWFkB",
        ["._ah7riWFkB{rotate:45deg -1 0 2;}"],
        1,
        0,
        1,
        [("value", "riWFkB", "val\\0h7\\0& | \\0rotate:45deg -1 0 2")],
      ),
      (
        "_am9ySt6r4",
        ["._am9ySt6r4{transform-style:flat;}"],
        1,
        0,
        1,
        [("value", "ySt6r4", "val\\0m9\\0& | \\0transform-style:flat")],
      ),
      (
        "_am9ObKW9q",
        ["._am9ObKW9q{transform-style:preserve-3d;}"],
        1,
        0,
        1,
        [("value", "ObKW9q", "val\\0m9\\0& | \\0transform-style:preserve-3d")],
      ),
      (
        "_aggvpbntH",
        ["._aggvpbntH{perspective:none;}"],
        1,
        0,
        1,
        [("value", "vpbntH", "val\\0gg\\0& | \\0perspective:none")],
      ),
      (
        "_aggOLY366",
        ["._aggOLY366{perspective:600px;}"],
        1,
        0,
        1,
        [("value", "OLY366", "val\\0gg\\0& | \\0perspective:600px")],
      ),
      (
        "_aghI3mhFk",
        ["._aghI3mhFk{perspective-origin:10px;}"],
        1,
        0,
        1,
        [("value", "I3mhFk", "val\\0gh\\0& | \\0perspective-origin:10px")],
      ),
      (
        "_aghSNgbnq",
        ["._aghSNgbnq{perspective-origin:top;}"],
        1,
        0,
        1,
        [("value", "SNgbnq", "val\\0gh\\0& | \\0perspective-origin:top")],
      ),
      (
        "_agh0bu2IF",
        ["._agh0bu2IF{perspective-origin:top left;}"],
        1,
        0,
        1,
        [("value", "0bu2IF", "val\\0gh\\0& | \\0perspective-origin:top left")],
      ),
      (
        "_aghabnVo3",
        ["._aghabnVo3{perspective-origin:50% 100%;}"],
        1,
        0,
        1,
        [("value", "abnVo3", "val\\0gh\\0& | \\0perspective-origin:50% 100%")],
      ),
      (
        "_aghMyz9B7",
        ["._aghMyz9B7{perspective-origin:left 0%;}"],
        1,
        0,
        1,
        [("value", "Myz9B7", "val\\0gh\\0& | \\0perspective-origin:left 0%")],
      ),
      (
        "_a4gObGVaW",
        [
          "._a4gObGVaW{-webkit-backface-visibility:visible;backface-visibility:visible;}",
        ],
        1,
        0,
        1,
        [("value", "ObGVaW", "val\\04g\\0& | \\0backface-visibility:visible")],
      ),
      (
        "_a4gwB4Kif",
        [
          "._a4gwB4Kif{-webkit-backface-visibility:hidden;backface-visibility:hidden;}",
        ],
        1,
        0,
        1,
        [("value", "wB4Kif", "val\\04g\\0& | \\0backface-visibility:hidden")],
      ),
    ]
  ];
  
  CSS.make("_am6HuTSFA", []);
  CSS.make("_am6KuzmFV", []);
  CSS.make("_am69jXG6g", []);
  CSS.make("_am62d_JYC", []);
  CSS.make("_am6WTBUGh", []);
  CSS.make("_am6uoBq6G", []);
  CSS.make("_am6RlvBav", []);
  CSS.make("_am6mB1y-Z", []);
  CSS.make("_am6QtvNne", []);
  CSS.make("_am6QMN3PE", []);
  CSS.make("_am6taglz2", []);
  CSS.make("_am6LJYOtK", []);
  CSS.make("_am6qb5eKu", []);
  CSS.make("_am6gPfYjq", []);
  CSS.make("_am6KuIvGx", []);
  CSS.make("_am6y3olGj", []);
  
  CSS.make("_am6j-Jf-C", []);
  CSS.make("_am6GVfx-K", []);
  CSS.make("_am6S4FrJN", []);
  CSS.make("_am6pKozNL", []);
  CSS.make("_am6AaPnIv", []);
  CSS.make("_am63AluVJ", []);
  CSS.make("_am68RGvg2", []);
  CSS.make("_am6ViDO56", []);
  CSS.make("_am6zAvcPo", []);
  
  CSS.make("_am6MVs4rB", []);
  CSS.make("_am62MApTB", []);
  CSS.make("_am8eWM15z", []);
  CSS.make("_am8AmKVFx", []);
  CSS.make("_am83lZdN7", []);
  CSS.make("_am8u9L3ie", []);
  CSS.make("_am8QTEtFQ", []);
  CSS.make("_am8-Nc3PK", []);
  CSS.make("_am7PlFEPR", []);
  CSS.make("_am7hPIf3K", []);
  CSS.make("_am7OtaeIs", []);
  CSS.make("_am7Zkw2OV", []);
  CSS.make("_am7qCbxdD", []);
  
  CSS.make("_amgdkWmDZ", []);
  CSS.make("_amgDWWzNm", []);
  CSS.make("_amg8u9YyH", []);
  CSS.make("_amgtHlJHz", []);
  CSS.make("_ai6ywF4rN", []);
  CSS.make("_ai6QaL4MH", []);
  CSS.make("_ai60BjMJ4", []);
  CSS.make("_ai6Gb_-Yl", []);
  CSS.make("_ah7JHmq3i", []);
  CSS.make("_ah7Rs51Y0", []);
  CSS.make("_ah7JQkM38", []);
  CSS.make("_ah7V5vD9S", []);
  CSS.make("_ah7dWpdCj", []);
  CSS.make("_ah7IiSOqg", []);
  CSS.make("_ah7sw3kWt", []);
  CSS.make("_ah7Paeil8", []);
  CSS.make("_ah7ELdifc", []);
  CSS.make("_ah7riWFkB", []);
  CSS.make("_am9ySt6r4", []);
  CSS.make("_am9ObKW9q", []);
  CSS.make("_aggvpbntH", []);
  CSS.make("_aggOLY366", []);
  CSS.make("_aghI3mhFk", []);
  CSS.make("_aghSNgbnq", []);
  CSS.make("_agh0bu2IF", []);
  CSS.make("_aghabnVo3", []);
  CSS.make("_aghMyz9B7", []);
  CSS.make("_a4gObGVaW", []);
  CSS.make("_a4gwB4Kif", []);
