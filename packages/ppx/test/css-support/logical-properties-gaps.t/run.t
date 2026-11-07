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
        "_acwhJ1LZZ",
        ["._acwhJ1LZZ{margin-block-start:auto;}"],
        1,
        0,
        1,
        [("value", "hJ1LZZ", "val\\0cw\\0& | \\0margin-block-start:auto")],
      ),
      (
        "_acwhCi_Ar",
        ["._acwhCi_Ar{margin-block-start:0;}"],
        1,
        0,
        1,
        [("value", "hCi_Ar", "val\\0cw\\0& | \\0margin-block-start:0")],
      ),
      (
        "_acwyFoHn2",
        ["._acwyFoHn2{margin-block-start:10%;}"],
        1,
        0,
        1,
        [("value", "yFoHn2", "val\\0cw\\0& | \\0margin-block-start:10%")],
      ),
      (
        "_acwu5asRi",
        ["._acwu5asRi{margin-block-start:calc(10px + 5%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "u5asRi",
            "val\\0cw\\0& | \\0margin-block-start:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_acvNcpMHF",
        ["._acvNcpMHF{margin-block-end:auto;}"],
        1,
        0,
        1,
        [("value", "NcpMHF", "val\\0cv\\0& | \\0margin-block-end:auto")],
      ),
      (
        "_acv3_U9iv",
        ["._acv3_U9iv{margin-block-end:0;}"],
        1,
        0,
        1,
        [("value", "3_U9iv", "val\\0cv\\0& | \\0margin-block-end:0")],
      ),
      (
        "_acvdZFvhx",
        ["._acvdZFvhx{margin-block-end:10%;}"],
        1,
        0,
        1,
        [("value", "dZFvhx", "val\\0cv\\0& | \\0margin-block-end:10%")],
      ),
      (
        "_acvUtLFNT",
        ["._acvUtLFNT{margin-block-end:calc(10px + 5%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "UtLFNT",
            "val\\0cv\\0& | \\0margin-block-end:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_ad0PdyC4O",
        [
          "._ad0PdyC4O{-webkit-margin-inline-start:auto;margin-inline-start:auto;}",
        ],
        1,
        0,
        1,
        [("value", "PdyC4O", "val\\0d0\\0& | \\0margin-inline-start:auto")],
      ),
      (
        "_ad0tLv2wQ",
        ["._ad0tLv2wQ{-webkit-margin-inline-start:0;margin-inline-start:0;}"],
        1,
        0,
        1,
        [("value", "tLv2wQ", "val\\0d0\\0& | \\0margin-inline-start:0")],
      ),
      (
        "_ad0WIRr7p",
        [
          "._ad0WIRr7p{-webkit-margin-inline-start:10%;margin-inline-start:10%;}",
        ],
        1,
        0,
        1,
        [("value", "WIRr7p", "val\\0d0\\0& | \\0margin-inline-start:10%")],
      ),
      (
        "_ad0R7bTGe",
        [
          "._ad0R7bTGe{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "R7bTGe",
            "val\\0d0\\0& | \\0margin-inline-start:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_aczfFVoIJ",
        ["._aczfFVoIJ{-webkit-margin-inline-end:auto;margin-inline-end:auto;}"],
        1,
        0,
        1,
        [("value", "fFVoIJ", "val\\0cz\\0& | \\0margin-inline-end:auto")],
      ),
      (
        "_aczdfbjAJ",
        ["._aczdfbjAJ{-webkit-margin-inline-end:0;margin-inline-end:0;}"],
        1,
        0,
        1,
        [("value", "dfbjAJ", "val\\0cz\\0& | \\0margin-inline-end:0")],
      ),
      (
        "_acz2Sg0py",
        ["._acz2Sg0py{-webkit-margin-inline-end:10%;margin-inline-end:10%;}"],
        1,
        0,
        1,
        [("value", "2Sg0py", "val\\0cz\\0& | \\0margin-inline-end:10%")],
      ),
      (
        "_aczmVheUH",
        [
          "._aczmVheUH{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "mVheUH",
            "val\\0cz\\0& | \\0margin-inline-end:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_ag1d719UM",
        ["._ag1d719UM{padding-block-start:0;}"],
        1,
        0,
        1,
        [("value", "d719UM", "val\\0g1\\0& | \\0padding-block-start:0")],
      ),
      (
        "_ag1dOIFEy",
        ["._ag1dOIFEy{padding-block-start:10%;}"],
        1,
        0,
        1,
        [("value", "dOIFEy", "val\\0g1\\0& | \\0padding-block-start:10%")],
      ),
      (
        "_ag1CxO1_n",
        ["._ag1CxO1_n{padding-block-start:calc(10px + 5%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CxO1_n",
            "val\\0g1\\0& | \\0padding-block-start:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_ag0vDM3fL",
        ["._ag0vDM3fL{padding-block-end:0;}"],
        1,
        0,
        1,
        [("value", "vDM3fL", "val\\0g0\\0& | \\0padding-block-end:0")],
      ),
      (
        "_ag0RhWyF9",
        ["._ag0RhWyF9{padding-block-end:10%;}"],
        1,
        0,
        1,
        [("value", "RhWyF9", "val\\0g0\\0& | \\0padding-block-end:10%")],
      ),
      (
        "_ag0eeWj0l",
        ["._ag0eeWj0l{padding-block-end:calc(10px + 5%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "eeWj0l",
            "val\\0g0\\0& | \\0padding-block-end:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_ag5ymD8Nt",
        ["._ag5ymD8Nt{-webkit-padding-inline-start:0;padding-inline-start:0;}"],
        1,
        0,
        1,
        [("value", "ymD8Nt", "val\\0g5\\0& | \\0padding-inline-start:0")],
      ),
      (
        "_ag52CmTuz",
        [
          "._ag52CmTuz{-webkit-padding-inline-start:10%;padding-inline-start:10%;}",
        ],
        1,
        0,
        1,
        [("value", "2CmTuz", "val\\0g5\\0& | \\0padding-inline-start:10%")],
      ),
      (
        "_ag5dpLqG_",
        [
          "._ag5dpLqG_{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "dpLqG_",
            "val\\0g5\\0& | \\0padding-inline-start:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_ag4OpB_kL",
        ["._ag4OpB_kL{-webkit-padding-inline-end:0;padding-inline-end:0;}"],
        1,
        0,
        1,
        [("value", "OpB_kL", "val\\0g4\\0& | \\0padding-inline-end:0")],
      ),
      (
        "_ag4s4QTXn",
        ["._ag4s4QTXn{-webkit-padding-inline-end:10%;padding-inline-end:10%;}"],
        1,
        0,
        1,
        [("value", "s4QTXn", "val\\0g4\\0& | \\0padding-inline-end:10%")],
      ),
      (
        "_ag4q8obBe",
        [
          "._ag4q8obBe{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "q8obBe",
            "val\\0g4\\0& | \\0padding-inline-end:calc(10px + 5%)",
          ),
        ],
      ),
      (
        "_acuyPU-sX",
        ["._acuyPU-sX{margin-block:auto auto;}"],
        1,
        0,
        2,
        [("value", "yPU-sX", "val\\0cu\\0& | \\0margin-block:auto auto")],
      ),
      (
        "_acuEMMlHz",
        ["._acuEMMlHz{margin-block:10px 20px;}"],
        1,
        0,
        2,
        [("value", "EMMlHz", "val\\0cu\\0& | \\0margin-block:10px 20px")],
      ),
      (
        "_acuq2yYbs",
        ["._acuq2yYbs{margin-block:10% 20%;}"],
        1,
        0,
        2,
        [("value", "q2yYbs", "val\\0cu\\0& | \\0margin-block:10% 20%")],
      ),
      (
        "_acy0funBF",
        ["._acy0funBF{margin-inline:auto auto;}"],
        1,
        0,
        2,
        [("value", "0funBF", "val\\0cy\\0& | \\0margin-inline:auto auto")],
      ),
      (
        "_acyZ2Kjlu",
        ["._acyZ2Kjlu{margin-inline:10px 20px;}"],
        1,
        0,
        2,
        [("value", "Z2Kjlu", "val\\0cy\\0& | \\0margin-inline:10px 20px")],
      ),
      (
        "_acyXtSTWf",
        ["._acyXtSTWf{margin-inline:10% 20%;}"],
        1,
        0,
        2,
        [("value", "XtSTWf", "val\\0cy\\0& | \\0margin-inline:10% 20%")],
      ),
      (
        "_afz4yWcP2",
        ["._afz4yWcP2{padding-block:10px 20px;}"],
        1,
        0,
        2,
        [("value", "4yWcP2", "val\\0fz\\0& | \\0padding-block:10px 20px")],
      ),
      (
        "_afzxWKw_h",
        ["._afzxWKw_h{padding-block:10% 20%;}"],
        1,
        0,
        2,
        [("value", "xWKw_h", "val\\0fz\\0& | \\0padding-block:10% 20%")],
      ),
      (
        "_ag3lC_dIW",
        ["._ag3lC_dIW{padding-inline:10px 20px;}"],
        1,
        0,
        2,
        [("value", "lC_dIW", "val\\0g3\\0& | \\0padding-inline:10px 20px")],
      ),
      (
        "_ag3AwUEBr",
        ["._ag3AwUEBr{padding-inline:10% 20%;}"],
        1,
        0,
        2,
        [("value", "AwUEBr", "val\\0g3\\0& | \\0padding-inline:10% 20%")],
      ),
      (
        "_a5cC1rpJ7",
        ["._a5cC1rpJ7{border-block-width:thin;}"],
        1,
        0,
        2,
        [("value", "C1rpJ7", "val\\05c\\0& | \\0border-block-width:thin")],
      ),
      (
        "_a5ccqnGDi",
        ["._a5ccqnGDi{border-block-width:medium;}"],
        1,
        0,
        2,
        [("value", "cqnGDi", "val\\05c\\0& | \\0border-block-width:medium")],
      ),
      (
        "_a5cEjqHUI",
        ["._a5cEjqHUI{border-block-width:thick;}"],
        1,
        0,
        2,
        [("value", "EjqHUI", "val\\05c\\0& | \\0border-block-width:thick")],
      ),
      (
        "_a5cbl-e5F",
        ["._a5cbl-e5F{border-block-width:2px;}"],
        1,
        0,
        2,
        [("value", "bl-e5F", "val\\05c\\0& | \\0border-block-width:2px")],
      ),
      (
        "_a64uMP2Xa",
        ["._a64uMP2Xa{border-inline-width:thin;}"],
        1,
        0,
        2,
        [("value", "uMP2Xa", "val\\064\\0& | \\0border-inline-width:thin")],
      ),
      (
        "_a64b5we8H",
        ["._a64b5we8H{border-inline-width:medium;}"],
        1,
        0,
        2,
        [("value", "b5we8H", "val\\064\\0& | \\0border-inline-width:medium")],
      ),
      (
        "_a645dhHdP",
        ["._a645dhHdP{border-inline-width:thick;}"],
        1,
        0,
        2,
        [("value", "5dhHdP", "val\\064\\0& | \\0border-inline-width:thick")],
      ),
      (
        "_a64urMMgb",
        ["._a64urMMgb{border-inline-width:2px;}"],
        1,
        0,
        2,
        [("value", "urMMgb", "val\\064\\0& | \\0border-inline-width:2px")],
      ),
      (
        "_a5bMBsdca",
        ["._a5bMBsdca{border-block-style:none;}"],
        1,
        0,
        2,
        [("value", "MBsdca", "val\\05b\\0& | \\0border-block-style:none")],
      ),
      (
        "_a5b6X_DvE",
        ["._a5b6X_DvE{border-block-style:solid;}"],
        1,
        0,
        2,
        [("value", "6X_DvE", "val\\05b\\0& | \\0border-block-style:solid")],
      ),
      (
        "_a5bQNlmLM",
        ["._a5bQNlmLM{border-block-style:dashed;}"],
        1,
        0,
        2,
        [("value", "QNlmLM", "val\\05b\\0& | \\0border-block-style:dashed")],
      ),
      (
        "_a63AFSYe7",
        ["._a63AFSYe7{border-inline-style:none;}"],
        1,
        0,
        2,
        [("value", "AFSYe7", "val\\063\\0& | \\0border-inline-style:none")],
      ),
      (
        "_a63FbZKxd",
        ["._a63FbZKxd{border-inline-style:solid;}"],
        1,
        0,
        2,
        [("value", "FbZKxd", "val\\063\\0& | \\0border-inline-style:solid")],
      ),
      (
        "_a63r8T-ew",
        ["._a63r8T-ew{border-inline-style:dashed;}"],
        1,
        0,
        2,
        [("value", "r8T-ew", "val\\063\\0& | \\0border-inline-style:dashed")],
      ),
    ]
  ];
  
  CSS.make("_acwhJ1LZZ", []);
  CSS.make("_acwhCi_Ar", []);
  CSS.make("_acwyFoHn2", []);
  CSS.make("_acwu5asRi", []);
  CSS.make("_acvNcpMHF", []);
  CSS.make("_acv3_U9iv", []);
  CSS.make("_acvdZFvhx", []);
  CSS.make("_acvUtLFNT", []);
  
  CSS.make("_ad0PdyC4O", []);
  CSS.make("_ad0tLv2wQ", []);
  CSS.make("_ad0WIRr7p", []);
  CSS.make("_ad0R7bTGe", []);
  CSS.make("_aczfFVoIJ", []);
  CSS.make("_aczdfbjAJ", []);
  CSS.make("_acz2Sg0py", []);
  CSS.make("_aczmVheUH", []);
  
  CSS.make("_ag1d719UM", []);
  CSS.make("_ag1dOIFEy", []);
  CSS.make("_ag1CxO1_n", []);
  CSS.make("_ag0vDM3fL", []);
  CSS.make("_ag0RhWyF9", []);
  CSS.make("_ag0eeWj0l", []);
  
  CSS.make("_ag5ymD8Nt", []);
  CSS.make("_ag52CmTuz", []);
  CSS.make("_ag5dpLqG_", []);
  CSS.make("_ag4OpB_kL", []);
  CSS.make("_ag4s4QTXn", []);
  CSS.make("_ag4q8obBe", []);
  
  CSS.make("_acuyPU-sX", []);
  CSS.make("_acuEMMlHz", []);
  CSS.make("_acuq2yYbs", []);
  CSS.make("_acy0funBF", []);
  CSS.make("_acyZ2Kjlu", []);
  CSS.make("_acyXtSTWf", []);
  
  CSS.make("_afz4yWcP2", []);
  CSS.make("_afzxWKw_h", []);
  CSS.make("_ag3lC_dIW", []);
  CSS.make("_ag3AwUEBr", []);
  
  CSS.make("_a5cC1rpJ7", []);
  CSS.make("_a5ccqnGDi", []);
  CSS.make("_a5cEjqHUI", []);
  CSS.make("_a5cbl-e5F", []);
  CSS.make("_a64uMP2Xa", []);
  CSS.make("_a64b5we8H", []);
  CSS.make("_a645dhHdP", []);
  CSS.make("_a64urMMgb", []);
  
  CSS.make("_a5bMBsdca", []);
  CSS.make("_a5b6X_DvE", []);
  CSS.make("_a5bQNlmLM", []);
  CSS.make("_a63AFSYe7", []);
  CSS.make("_a63FbZKxd", []);
  CSS.make("_a63r8T-ew", []);
