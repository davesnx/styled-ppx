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
  [@css "@property --flex1-1tqr2xz{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-1iy918v{syntax:\"*\";inherits:false;}"];
  [@css "@property --value2-1udgnd9{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-uqy155{syntax:\"*\";inherits:false;}"];
  [@css "@property --value2-jo073q{syntax:\"*\";inherits:false;}"];
  [@css "@property --min-1gkkmnh{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-144hlpb_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-a4ffto_2{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a3kdaFrG8",
        ["._a3kdaFrG8{align-content:flex-start;}"],
        1,
        0,
        1,
        [("value", "daFrG8", "val\\03k\\0& | \\0align-content:flex-start")],
      ),
      (
        "_a3k-Ur8VP",
        ["._a3k-Ur8VP{align-content:flex-end;}"],
        1,
        0,
        1,
        [("value", "-Ur8VP", "val\\03k\\0& | \\0align-content:flex-end")],
      ),
      (
        "_a3kdmCAOy",
        ["._a3kdmCAOy{align-content:space-between;}"],
        1,
        0,
        1,
        [("value", "dmCAOy", "val\\03k\\0& | \\0align-content:space-between")],
      ),
      (
        "_a3kH1EGPY",
        ["._a3kH1EGPY{align-content:space-around;}"],
        1,
        0,
        1,
        [("value", "H1EGPY", "val\\03k\\0& | \\0align-content:space-around")],
      ),
      (
        "_a3laK86lh",
        ["._a3laK86lh{align-items:flex-start;}"],
        1,
        0,
        1,
        [("value", "aK86lh", "val\\03l\\0& | \\0align-items:flex-start")],
      ),
      (
        "_a3lb9rQ2-",
        ["._a3lb9rQ2-{align-items:flex-end;}"],
        1,
        0,
        1,
        [("value", "b9rQ2-", "val\\03l\\0& | \\0align-items:flex-end")],
      ),
      (
        "_a3mchLPCh",
        ["._a3mchLPCh{align-self:flex-start;}"],
        1,
        0,
        1,
        [("value", "chLPCh", "val\\03m\\0& | \\0align-self:flex-start")],
      ),
      (
        "_a3mreoC70",
        ["._a3mreoC70{align-self:flex-end;}"],
        1,
        0,
        1,
        [("value", "reoC70", "val\\03m\\0& | \\0align-self:flex-end")],
      ),
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_a9fnXfxdl",
        ["._a9fnXfxdl{display:inline-flex;}"],
        1,
        0,
        1,
        [("value", "nXfxdl", "val\\09f\\0& | \\0display:inline-flex")],
      ),
      (
        "_a9pp8sQyy",
        ["._a9pp8sQyy{-webkit-flex:none;-ms-flex:none;flex:none;}"],
        1,
        0,
        3,
        [("value", "p8sQyy", "val\\09p\\0& | \\0flex:none")],
      ),
      (
        "_a9pgpN9qN",
        ["._a9pgpN9qN{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"],
        1,
        0,
        3,
        [("value", "gpN9qN", "val\\09p\\0& | \\0flex:5 7 10%")],
      ),
      (
        "_a9pG_MAfB",
        ["._a9pG_MAfB{-webkit-flex:2;-ms-flex:2;flex:2;}"],
        1,
        0,
        3,
        [("value", "G_MAfB", "val\\09p\\0& | \\0flex:2")],
      ),
      (
        "_a9pOWqbr3",
        ["._a9pOWqbr3{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"],
        1,
        0,
        3,
        [("value", "OWqbr3", "val\\09p\\0& | \\0flex:10em")],
      ),
      (
        "_a9paZ3zof",
        ["._a9paZ3zof{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"],
        1,
        0,
        3,
        [("value", "aZ3zof", "val\\09p\\0& | \\0flex:30%")],
      ),
      (
        "_a9polWM0f",
        [
          "._a9polWM0f{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}",
        ],
        1,
        0,
        3,
        [("value", "olWM0f", "val\\09p\\0& | \\0flex:min-content")],
      ),
      (
        "_a9pIk7v_L",
        ["._a9pIk7v_L{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"],
        1,
        0,
        3,
        [("value", "Ik7v_L", "val\\09p\\0& | \\0flex:1 30px")],
      ),
      (
        "_a9pfksF8K",
        ["._a9pfksF8K{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"],
        1,
        0,
        3,
        [("value", "fksF8K", "val\\09p\\0& | \\0flex:2 2")],
      ),
      (
        "_a9pEffCjo",
        ["._a9pEffCjo{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"],
        1,
        0,
        3,
        [("value", "EffCjo", "val\\09p\\0& | \\0flex:2 2 10%")],
      ),
      (
        "_a9pqT_TD5",
        [
          "._a9pqT_TD5{-webkit-flex:var(--flex1-1tqr2xz);-ms-flex:var(--flex1-1tqr2xz);flex:var(--flex1-1tqr2xz);}",
        ],
        1,
        0,
        3,
        [("value", "qT_TD5", "val\\09p\\0& | \\0flex:$(X.flex1)")],
      ),
      (
        "_a9pngqi_g",
        [
          "._a9pngqi_g{-webkit-flex:var(--value-1iy918v) var(--value2-1udgnd9);-ms-flex:var(--value-1iy918v) var(--value2-1udgnd9);flex:var(--value-1iy918v) var(--value2-1udgnd9);}",
        ],
        1,
        0,
        3,
        [("value", "ngqi_g", "val\\09p\\0& | \\0flex:$(X.value) $(X.value2)")],
      ),
      (
        "_a9p6il93e",
        [
          "._a9p6il93e{-webkit-flex:var(--value-uqy155) var(--value2-jo073q) var(--min-1gkkmnh);-ms-flex:var(--value-uqy155) var(--value2-jo073q) var(--min-1gkkmnh);flex:var(--value-uqy155) var(--value2-jo073q) var(--min-1gkkmnh);}",
        ],
        1,
        0,
        3,
        [
          (
            "value",
            "6il93e",
            "val\\09p\\0& | \\0flex:$(X.value) $(X.value2) $(X.min)",
          ),
        ],
      ),
      (
        "_a9ppGP2pQ",
        [
          "._a9ppGP2pQ{-webkit-flex:var(--value-144hlpb_1) var(--value-a4ffto_2);-ms-flex:var(--value-144hlpb_1) var(--value-a4ffto_2);flex:var(--value-144hlpb_1) var(--value-a4ffto_2);}",
        ],
        1,
        0,
        3,
        [("value", "pGP2pQ", "val\\09p\\0& | \\0flex:$(X.value) $(X.value)")],
      ),
      (
        "_a9qBsx4Ns",
        ["._a9qBsx4Ns{flex-basis:auto;}"],
        1,
        0,
        1,
        [("value", "Bsx4Ns", "val\\09q\\0& | \\0flex-basis:auto")],
      ),
      (
        "_a9qzAxO_k",
        ["._a9qzAxO_k{flex-basis:content;}"],
        1,
        0,
        1,
        [("value", "zAxO_k", "val\\09q\\0& | \\0flex-basis:content")],
      ),
      (
        "_a9qAmeVQP",
        ["._a9qAmeVQP{flex-basis:1px;}"],
        1,
        0,
        1,
        [("value", "AmeVQP", "val\\09q\\0& | \\0flex-basis:1px")],
      ),
      (
        "_a9rWIMFgs",
        [
          "._a9rWIMFgs{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}",
        ],
        1,
        0,
        1,
        [("value", "WIMFgs", "val\\09r\\0& | \\0flex-direction:row")],
      ),
      (
        "_a9rWr2c6k",
        [
          "._a9rWr2c6k{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}",
        ],
        1,
        0,
        1,
        [("value", "Wr2c6k", "val\\09r\\0& | \\0flex-direction:row-reverse")],
      ),
      (
        "_a9r6LKQt1",
        [
          "._a9r6LKQt1{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}",
        ],
        1,
        0,
        1,
        [("value", "6LKQt1", "val\\09r\\0& | \\0flex-direction:column")],
      ),
      (
        "_a9rqEg0sA",
        [
          "._a9rqEg0sA{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}",
        ],
        1,
        0,
        1,
        [
          ("value", "qEg0sA", "val\\09r\\0& | \\0flex-direction:column-reverse"),
        ],
      ),
      (
        "_a9sAaD1F_",
        ["._a9sAaD1F_{flex-flow:row;}"],
        1,
        0,
        2,
        [("value", "AaD1F_", "val\\09s\\0& | \\0flex-flow:row")],
      ),
      (
        "_a9sbwjuEb",
        ["._a9sbwjuEb{flex-flow:row-reverse;}"],
        1,
        0,
        2,
        [("value", "bwjuEb", "val\\09s\\0& | \\0flex-flow:row-reverse")],
      ),
      (
        "_a9s4d14qd",
        ["._a9s4d14qd{flex-flow:column;}"],
        1,
        0,
        2,
        [("value", "4d14qd", "val\\09s\\0& | \\0flex-flow:column")],
      ),
      (
        "_a9sd7IMwu",
        ["._a9sd7IMwu{flex-flow:column-reverse;}"],
        1,
        0,
        2,
        [("value", "d7IMwu", "val\\09s\\0& | \\0flex-flow:column-reverse")],
      ),
      (
        "_a9sPKdjLz",
        ["._a9sPKdjLz{flex-flow:wrap;}"],
        1,
        0,
        2,
        [("value", "PKdjLz", "val\\09s\\0& | \\0flex-flow:wrap")],
      ),
      (
        "_a9s4XU0Qo",
        ["._a9s4XU0Qo{flex-flow:wrap-reverse;}"],
        1,
        0,
        2,
        [("value", "4XU0Qo", "val\\09s\\0& | \\0flex-flow:wrap-reverse")],
      ),
      (
        "_a9sf959J-",
        ["._a9sf959J-{flex-flow:row wrap;}"],
        1,
        0,
        2,
        [("value", "f959J-", "val\\09s\\0& | \\0flex-flow:row wrap")],
      ),
      (
        "_a9sQZZY6i",
        ["._a9sQZZY6i{flex-flow:row-reverse nowrap;}"],
        1,
        0,
        2,
        [
          ("value", "QZZY6i", "val\\09s\\0& | \\0flex-flow:row-reverse nowrap"),
        ],
      ),
      (
        "_a9sJoQbo9",
        ["._a9sJoQbo9{flex-flow:column wrap;}"],
        1,
        0,
        2,
        [("value", "JoQbo9", "val\\09s\\0& | \\0flex-flow:column wrap")],
      ),
      (
        "_a9sM_xRc9",
        ["._a9sM_xRc9{flex-flow:column-reverse wrap-reverse;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "M_xRc9",
            "val\\09s\\0& | \\0flex-flow:column-reverse wrap-reverse",
          ),
        ],
      ),
      (
        "_a9t6n-X-m",
        ["._a9t6n-X-m{flex-grow:0;}"],
        1,
        0,
        1,
        [("value", "6n-X-m", "val\\09t\\0& | \\0flex-grow:0")],
      ),
      (
        "_a9tYltOQA",
        ["._a9tYltOQA{flex-grow:5;}"],
        1,
        0,
        1,
        [("value", "YltOQA", "val\\09t\\0& | \\0flex-grow:5")],
      ),
      (
        "_a9vq7V69w",
        ["._a9vq7V69w{flex-shrink:1;}"],
        1,
        0,
        1,
        [("value", "q7V69w", "val\\09v\\0& | \\0flex-shrink:1")],
      ),
      (
        "_a9vbiJ9YV",
        ["._a9vbiJ9YV{flex-shrink:10;}"],
        1,
        0,
        1,
        [("value", "biJ9YV", "val\\09v\\0& | \\0flex-shrink:10")],
      ),
      (
        "_a9wNFCzzJ",
        ["._a9wNFCzzJ{flex-wrap:nowrap;}"],
        1,
        0,
        1,
        [("value", "NFCzzJ", "val\\09w\\0& | \\0flex-wrap:nowrap")],
      ),
      (
        "_a9wyY18eB",
        ["._a9wyY18eB{flex-wrap:wrap;}"],
        1,
        0,
        1,
        [("value", "yY18eB", "val\\09w\\0& | \\0flex-wrap:wrap")],
      ),
      (
        "_a9wGohxew",
        ["._a9wGohxew{flex-wrap:wrap-reverse;}"],
        1,
        0,
        1,
        [("value", "Gohxew", "val\\09w\\0& | \\0flex-wrap:wrap-reverse")],
      ),
      (
        "_ac7dgmtvy",
        ["._ac7dgmtvy{justify-content:flex-start;}"],
        1,
        0,
        1,
        [("value", "dgmtvy", "val\\0c7\\0& | \\0justify-content:flex-start")],
      ),
      (
        "_ac7D3FJzV",
        ["._ac7D3FJzV{justify-content:flex-end;}"],
        1,
        0,
        1,
        [("value", "D3FJzV", "val\\0c7\\0& | \\0justify-content:flex-end")],
      ),
      (
        "_ac7EEvBtR",
        ["._ac7EEvBtR{justify-content:space-between;}"],
        1,
        0,
        1,
        [
          ("value", "EEvBtR", "val\\0c7\\0& | \\0justify-content:space-between"),
        ],
      ),
      (
        "_ac7Ef0Lz3",
        ["._ac7Ef0Lz3{justify-content:space-around;}"],
        1,
        0,
        1,
        [
          ("value", "Ef0Lz3", "val\\0c7\\0& | \\0justify-content:space-around"),
        ],
      ),
      (
        "_aeqREKjm5",
        ["._aeqREKjm5{min-height:auto;}"],
        1,
        0,
        1,
        [("value", "REKjm5", "val\\0eq\\0& | \\0min-height:auto")],
      ),
      (
        "_aestCUAMI",
        ["._aestCUAMI{min-width:auto;}"],
        1,
        0,
        1,
        [("value", "tCUAMI", "val\\0es\\0& | \\0min-width:auto")],
      ),
      (
        "_afaicqUo6",
        ["._afaicqUo6{order:0;}"],
        1,
        0,
        1,
        [("value", "icqUo6", "val\\0fa\\0& | \\0order:0")],
      ),
      (
        "_afaca05dQ",
        ["._afaca05dQ{order:1;}"],
        1,
        0,
        1,
        [("value", "ca05dQ", "val\\0fa\\0& | \\0order:1")],
      ),
    ]
  ];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("_a3kdaFrG8", []);
  CSS.make("_a3k-Ur8VP", []);
  CSS.make("_a3kdmCAOy", []);
  CSS.make("_a3kH1EGPY", []);
  CSS.make("_a3laK86lh", []);
  CSS.make("_a3lb9rQ2-", []);
  CSS.make("_a3mchLPCh", []);
  CSS.make("_a3mreoC70", []);
  CSS.make("_a9fMU0SCS", []);
  CSS.make("_a9fnXfxdl", []);
  CSS.make("_a9pp8sQyy", []);
  CSS.make("_a9pgpN9qN", []);
  CSS.make("_a9pG_MAfB", []);
  CSS.make("_a9pOWqbr3", []);
  CSS.make("_a9paZ3zof", []);
  CSS.make("_a9polWM0f", []);
  CSS.make("_a9pIk7v_L", []);
  CSS.make("_a9pfksF8K", []);
  CSS.make("_a9pEffCjo", []);
  CSS.make(
    "_a9pqT_TD5",
    [("--flex1-1tqr2xz", CSS.Types.Flex.toString(X.flex1))],
  );
  CSS.make(
    "_a9pngqi_g",
    [
      ("--value-1iy918v", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-1udgnd9", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "_a9p6il93e",
    [
      ("--value-uqy155", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-jo073q", CSS.Types.FlexShrink.toString(X.value2)),
      ("--min-1gkkmnh", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "_a9ppGP2pQ",
    [
      ("--value-144hlpb_1", CSS.Types.FlexGrow.toString(X.value)),
      ("--value-a4ffto_2", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("_a9qBsx4Ns", []);
  CSS.make("_a9qzAxO_k", []);
  CSS.make("_a9qAmeVQP", []);
  CSS.make("_a9rWIMFgs", []);
  CSS.make("_a9rWr2c6k", []);
  CSS.make("_a9r6LKQt1", []);
  CSS.make("_a9rqEg0sA", []);
  CSS.make("_a9sAaD1F_", []);
  CSS.make("_a9sbwjuEb", []);
  CSS.make("_a9s4d14qd", []);
  CSS.make("_a9sd7IMwu", []);
  CSS.make("_a9sPKdjLz", []);
  CSS.make("_a9s4XU0Qo", []);
  CSS.make("_a9sf959J-", []);
  CSS.make("_a9sQZZY6i", []);
  CSS.make("_a9sJoQbo9", []);
  CSS.make("_a9sM_xRc9", []);
  CSS.make("_a9t6n-X-m", []);
  CSS.make("_a9tYltOQA", []);
  CSS.make("_a9vq7V69w", []);
  CSS.make("_a9vbiJ9YV", []);
  CSS.make("_a9wNFCzzJ", []);
  CSS.make("_a9wyY18eB", []);
  CSS.make("_a9wGohxew", []);
  CSS.make("_ac7dgmtvy", []);
  CSS.make("_ac7D3FJzV", []);
  CSS.make("_ac7EEvBtR", []);
  CSS.make("_ac7Ef0Lz3", []);
  CSS.make("_aeqREKjm5", []);
  CSS.make("_aestCUAMI", []);
  CSS.make("_afaicqUo6", []);
  CSS.make("_afaca05dQ", []);
