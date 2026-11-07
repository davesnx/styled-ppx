This test ensures declaration lists accept nested selectors and `@media` blocks even when the preceding declaration omits its trailing semicolon.

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
  [@css "@property --borderColor-lw4o0e{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a4lHaOsX3",
        ["._a4lHaOsX3{background-color:red;}"],
        1,
        0,
        1,
        [("value", "HaOsX3", "val\\04l\\0& | \\0background-color:red")],
      ),
      (
        "_c4lbUNzBq7pHd-C",
        ["._c4lbUNzBq7pHd-C:nth-child(2n){background-color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "bUNzBq", "ctx\\0&:nth-child(2n) | "),
          (
            "value",
            "7pHd-C",
            "val\\04l\\0&:nth-child(2n) | \\0background-color:blue",
          ),
        ],
      ),
      (
        "_amazEikwp",
        ["._amazEikwp{transition:max-height 400ms ease-in-out 0ms;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "zEikwp",
            "val\\0ma\\0& | \\0transition:max-height 400ms ease-in-out 0ms",
          ),
        ],
      ),
      (
        "_cf9kDsyxkq0t9MI",
        ["._cf9kDsyxkq0t9MI > *{opacity:0;}"],
        0,
        1,
        1,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "q0t9MI", "val\\0f9\\0& > * | \\0opacity:0"),
        ],
      ),
      (
        "_cmdkDsyxkoRq0K-",
        ["._cmdkDsyxkoRq0K- > *{transition-duration:400ms;}"],
        0,
        1,
        1,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          (
            "value",
            "oRq0K-",
            "val\\0md\\0& > * | \\0transition-duration:400ms",
          ),
        ],
      ),
      (
        "_acx_rV5bk",
        ["._acx_rV5bk{margin-bottom:24px;}"],
        1,
        0,
        1,
        [("value", "_rV5bk", "val\\0cx\\0& | \\0margin-bottom:24px")],
      ),
      (
        "_cn8NPimJabfDfKP",
        ["@media (min-width:1024px){._cn8NPimJabfDfKP{width:50%;}}"],
        2,
        1,
        1,
        [
          ("ctx", "NPimJa", "ctx\\0& | @media (min-width:1024px) | "),
          (
            "value",
            "bfDfKP",
            "val\\0n8\\0& | @media (min-width:1024px) | \\0width:50%",
          ),
        ],
      ),
      (
        "_amatVIEZs",
        ["._amatVIEZs{transition:transform 200ms ease-in-out 0ms;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "tVIEZs",
            "val\\0ma\\0& | \\0transition:transform 200ms ease-in-out 0ms",
          ),
        ],
      ),
      (
        "_cm6eo0aiLJp2tM-",
        [
          "._cm6eo0aiLJp2tM-.contentAfterOpen{-webkit-transform:translateY(16px);-moz-transform:translateY(16px);-ms-transform:translateY(16px);transform:translateY(16px);}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "eo0aiL", "ctx\\0&.contentAfterOpen | "),
          (
            "value",
            "Jp2tM-",
            "val\\0m6\\0&.contentAfterOpen | \\0transform:translateY(16px)",
          ),
        ],
      ),
      (
        "_a5diBj4d_",
        ["._a5diBj4d_{border-bottom:1px solid black;}"],
        1,
        0,
        3,
        [
          ("value", "iBj4d_", "val\\05d\\0& | \\0border-bottom:1px solid black"),
        ],
      ),
      (
        "_cg2eH7qFlrYGmjB",
        ["._cg2eH7qFlrYGmjB:last-child{padding-bottom:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "eH7qFl", "ctx\\0&:last-child | "),
          ("value", "rYGmjB", "val\\0g2\\0&:last-child | \\0padding-bottom:0"),
        ],
      ),
      (
        "_c5ieH7qFlgUBAeW",
        ["._c5ieH7qFlgUBAeW:last-child{border-bottom-width:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "eH7qFl", "ctx\\0&:last-child | "),
          (
            "value",
            "gUBAeW",
            "val\\05i\\0&:last-child | \\0border-bottom-width:0",
          ),
        ],
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
        "_cc7SO36iemNMQdh",
        [
          "@media (min-width:768px){._cc7SO36iemNMQdh{justify-content:center;}}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "SO36ie", "ctx\\0& | @media (min-width:768px) | "),
          (
            "value",
            "mNMQdh",
            "val\\0c7\\0& | @media (min-width:768px) | \\0justify-content:center",
          ),
        ],
      ),
      (
        "_an8nSf-2W",
        [
          "._an8nSf-2W{width:-webkit-min-content;width:-moz-min-content;width:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "nSf-2W", "val\\0n8\\0& | \\0width:min-content")],
      ),
      (
        "_cg8qmuVFYadoXVw",
        ["@media (min-width:1200px){._cg8qmuVFYadoXVw{padding-top:8px;}}"],
        2,
        1,
        1,
        [
          ("ctx", "qmuVFY", "ctx\\0& | @media (min-width:1200px) | "),
          (
            "value",
            "adoXVw",
            "val\\0g8\\0& | @media (min-width:1200px) | \\0padding-top:8px",
          ),
        ],
      ),
      (
        "_abdWWDqhK",
        ["._abdWWDqhK{height:100%;}"],
        1,
        0,
        1,
        [("value", "WWDqhK", "val\\0bd\\0& | \\0height:100%")],
      ),
      (
        "_cfybxDcu-_dRzoa",
        ["._cfybxDcu-_dRzoa h4{padding:0;}"],
        0,
        1,
        4,
        [
          ("ctx", "bxDcu-", "ctx\\0& h4 | "),
          ("value", "_dRzoa", "val\\0fy\\0& h4 | \\0padding:0"),
        ],
      ),
      (
        "_amad6u9qq",
        ["._amad6u9qq{transition:all 200ms ease 0ms;}"],
        1,
        0,
        5,
        [
          ("value", "d6u9qq", "val\\0ma\\0& | \\0transition:all 200ms ease 0ms"),
        ],
      ),
      (
        "_cesfghJedVoqhjc",
        ["._cesfghJedVoqhjc.sidebarClosed{min-width:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          ("value", "Voqhjc", "val\\0es\\0&.sidebarClosed | \\0min-width:0"),
        ],
      ),
      (
        "_cdzfghJedv-M8UJ",
        ["._cdzfghJedv-M8UJ.sidebarClosed{max-width:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          ("value", "v-M8UJ", "val\\0dz\\0&.sidebarClosed | \\0max-width:0"),
        ],
      ),
      (
        "_cf9fghJedd22Ko2",
        ["._cf9fghJedd22Ko2.sidebarClosed{opacity:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          ("value", "d22Ko2", "val\\0f9\\0&.sidebarClosed | \\0opacity:0"),
        ],
      ),
      (
        "_cfhfghJedo6MrDV",
        ["._cfhfghJedo6MrDV.sidebarClosed{overflow:hidden;}"],
        2,
        1,
        2,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          (
            "value",
            "o6MrDV",
            "val\\0fh\\0&.sidebarClosed | \\0overflow:hidden",
          ),
        ],
      ),
      (
        "_cg6fghJedIeCXQn",
        ["._cg6fghJedIeCXQn.sidebarClosed{padding-left:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          ("value", "IeCXQn", "val\\0g6\\0&.sidebarClosed | \\0padding-left:0"),
        ],
      ),
      (
        "_cg7fghJedmH5jyZ",
        ["._cg7fghJedmH5jyZ.sidebarClosed{padding-right:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "fghJed", "ctx\\0&.sidebarClosed | "),
          (
            "value",
            "mH5jyZ",
            "val\\0g7\\0&.sidebarClosed | \\0padding-right:0",
          ),
        ],
      ),
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_c7fsFnj_7WI0HJB",
        ["._c7fsFnj_7WI0HJB .child{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "sFnj_7", "ctx\\0& .child | "),
          ("value", "WI0HJB", "val\\07f\\0& .child | \\0color:blue"),
        ],
      ),
      (
        "_c7fTtondTagFI90",
        ["._c7fTtondTagFI90 div{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "TtondT", "ctx\\0& div | "),
          ("value", "agFI90", "val\\07f\\0& div | \\0color:blue"),
        ],
      ),
      (
        "_c7frl3ERTCiN8hr",
        ["._c7frl3ERTCiN8hr #child{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "rl3ERT", "ctx\\0& #child | "),
          ("value", "CiN8hr", "val\\07f\\0& #child | \\0color:blue"),
        ],
      ),
      (
        "_c9lY7app2Cj0jsJ",
        ["._c9lY7app2Cj0jsJ svg path{fill:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "Y7app2", "ctx\\0& svg path | "),
          ("value", "Cj0jsJ", "val\\09l\\0& svg path | \\0fill:blue"),
        ],
      ),
      (
        "_a5d57ixVv",
        ["._a5d57ixVv{border-bottom:1px solid var(--borderColor-lw4o0e);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "57ixVv",
            "val\\05d\\0& | \\0border-bottom:1px solid $(borderColor)",
          ),
        ],
      ),
      (
        "_i1x13bs_l",
        [],
        1,
        0,
        0,
        [("id", "_i1x13bs_l", "bind\\0\\0Input\\0\\0_case1\\00")],
      ),
      (
        "_iV9BCttCT",
        [],
        1,
        0,
        0,
        [("id", "_iV9BCttCT", "bind\\0\\0Input\\0\\0_case2\\00")],
      ),
      (
        "_iPPaJrbqs",
        [],
        1,
        0,
        0,
        [("id", "_iPPaJrbqs", "bind\\0\\0Input\\0\\0_case3\\00")],
      ),
      (
        "_iDEeQJNNy",
        [],
        1,
        0,
        0,
        [("id", "_iDEeQJNNy", "bind\\0\\0Input\\0\\0_case4\\00")],
      ),
      (
        "_ippW4sFxr",
        [],
        1,
        0,
        0,
        [("id", "_ippW4sFxr", "bind\\0\\0Input\\0\\0_case5\\00")],
      ),
      (
        "_i1aXavgi7",
        [],
        1,
        0,
        0,
        [("id", "_i1aXavgi7", "bind\\0\\0Input\\0\\0_case6\\00")],
      ),
      (
        "_iJM1nZ1-R",
        [],
        1,
        0,
        0,
        [("id", "_iJM1nZ1-R", "bind\\0\\0Input\\0\\0_case7\\00")],
      ),
      (
        "_iFq6RDJMr",
        [],
        1,
        0,
        0,
        [("id", "_iFq6RDJMr", "bind\\0\\0Input\\0\\0_case8\\00")],
      ),
      (
        "_inn0o0wVZ",
        [],
        1,
        0,
        0,
        [("id", "_inn0o0wVZ", "bind\\0\\0Input\\0\\0_case9\\00")],
      ),
      (
        "_icDFEDUgy",
        [],
        1,
        0,
        0,
        [("id", "_icDFEDUgy", "bind\\0\\0Input\\0\\0_case10\\00")],
      ),
      (
        "_iBZqpzLBV",
        [],
        1,
        0,
        0,
        [("id", "_iBZqpzLBV", "bind\\0\\0Input\\0\\0_case11\\00")],
      ),
      (
        "_ipQK_gvgM",
        [],
        1,
        0,
        0,
        [("id", "_ipQK_gvgM", "bind\\0\\0Input\\0\\0_case12\\00")],
      ),
      (
        "_iLbdXuyc7",
        [],
        1,
        0,
        0,
        [("id", "_iLbdXuyc7", "bind\\0\\0Input\\0\\0_case13\\00")],
      ),
      (
        "_ijGzzz6MH",
        [],
        1,
        0,
        0,
        [("id", "_ijGzzz6MH", "bind\\0\\0Input\\0\\0_case14\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input._case1", "_i1x13bs_l _a4lHaOsX3 _c4lbUNzBq7pHd-C", "_i1x13bs_l"),
      (
        "Input._case2",
        "_iV9BCttCT _amazEikwp _cf9kDsyxkq0t9MI _cmdkDsyxkoRq0K-",
        "_iV9BCttCT",
      ),
      ("Input._case3", "_iPPaJrbqs _acx_rV5bk _cn8NPimJabfDfKP", "_iPPaJrbqs"),
      ("Input._case4", "_iDEeQJNNy _amatVIEZs _cm6eo0aiLJp2tM-", "_iDEeQJNNy"),
      (
        "Input._case5",
        "_ippW4sFxr _a5diBj4d_ _cg2eH7qFlrYGmjB _c5ieH7qFlgUBAeW",
        "_ippW4sFxr",
      ),
      ("Input._case6", "_i1aXavgi7 _ac7EEvBtR _cc7SO36iemNMQdh", "_i1aXavgi7"),
      ("Input._case7", "_iJM1nZ1-R _an8nSf-2W _cg8qmuVFYadoXVw", "_iJM1nZ1-R"),
      ("Input._case8", "_iFq6RDJMr _abdWWDqhK _cfybxDcu-_dRzoa", "_iFq6RDJMr"),
      (
        "Input._case9",
        "_inn0o0wVZ _amad6u9qq _cesfghJedVoqhjc _cdzfghJedv-M8UJ _cf9fghJedd22Ko2 _cfhfghJedo6MrDV _cg6fghJedIeCXQn _cg7fghJedmH5jyZ",
        "_inn0o0wVZ",
      ),
      ("Input._case10", "_icDFEDUgy _a7fadbhEW _c7fsFnj_7WI0HJB", "_icDFEDUgy"),
      ("Input._case11", "_iBZqpzLBV _a7fadbhEW _c7fTtondTagFI90", "_iBZqpzLBV"),
      ("Input._case12", "_ipQK_gvgM _a7fadbhEW _c7frl3ERTCiN8hr", "_ipQK_gvgM"),
      ("Input._case13", "_iLbdXuyc7 _a7fadbhEW _c9lY7app2Cj0jsJ", "_iLbdXuyc7"),
      (
        "Input._case14",
        "_ijGzzz6MH _a5d57ixVv _cg2eH7qFlrYGmjB _c5ieH7qFlgUBAeW",
        "_ijGzzz6MH",
      ),
    ]
  ];
  let _case1 = CSS.make("_i1x13bs_l _a4lHaOsX3 _c4lbUNzBq7pHd-C", []);
  
  let _case2 =
    CSS.make("_iV9BCttCT _amazEikwp _cf9kDsyxkq0t9MI _cmdkDsyxkoRq0K-", []);
  
  let _case3 = CSS.make("_iPPaJrbqs _acx_rV5bk _cn8NPimJabfDfKP", []);
  
  let _case4 = CSS.make("_iDEeQJNNy _amatVIEZs _cm6eo0aiLJp2tM-", []);
  
  let _case5 =
    CSS.make("_ippW4sFxr _a5diBj4d_ _cg2eH7qFlrYGmjB _c5ieH7qFlgUBAeW", []);
  
  let _case6 = CSS.make("_i1aXavgi7 _ac7EEvBtR _cc7SO36iemNMQdh", []);
  
  let _case7 = CSS.make("_iJM1nZ1-R _an8nSf-2W _cg8qmuVFYadoXVw", []);
  
  let _case8 = CSS.make("_iFq6RDJMr _abdWWDqhK _cfybxDcu-_dRzoa", []);
  
  let _case9 =
    CSS.make(
      "_inn0o0wVZ _amad6u9qq _cesfghJedVoqhjc _cdzfghJedv-M8UJ _cf9fghJedd22Ko2 _cfhfghJedo6MrDV _cg6fghJedIeCXQn _cg7fghJedmH5jyZ",
      [],
    );
  
  let _case10 = CSS.make("_icDFEDUgy _a7fadbhEW _c7fsFnj_7WI0HJB", []);
  
  let _case11 = CSS.make("_iBZqpzLBV _a7fadbhEW _c7fTtondTagFI90", []);
  
  let _case12 = CSS.make("_ipQK_gvgM _a7fadbhEW _c7frl3ERTCiN8hr", []);
  
  let _case13 = CSS.make("_iLbdXuyc7 _a7fadbhEW _c9lY7app2Cj0jsJ", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "_ijGzzz6MH _a5d57ixVv _cg2eH7qFlrYGmjB _c5ieH7qFlgUBAeW",
      [("--borderColor-lw4o0e", CSS.Types.Color.toString(borderColor))],
    );


