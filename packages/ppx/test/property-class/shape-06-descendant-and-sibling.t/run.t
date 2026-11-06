Shape 6: descendant, child and sibling scopes are atoms of tier 0.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_cctkDsyxktNCm5K",
        ["._cctkDsyxktNCm5K > *{margin:0;}"],
        0,
        1,
        4,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "tNCm5K", "val\\0ct\\0& > * | \\0margin:0"),
        ],
      ),
      (
        "_cfyHZhI8Udfs9HD",
        ["._cfyHZhI8Udfs9HD td{padding:0;}"],
        0,
        1,
        4,
        [
          ("ctx", "HZhI8U", "ctx\\0& td | "),
          ("value", "dfs9HD", "val\\0fy\\0& td | \\0padding:0"),
        ],
      ),
      (
        "_cd3cDlkYuAPm1dD",
        ["._cd3cDlkYuAPm1dD + *{margin-top:3px;}"],
        0,
        1,
        1,
        [
          ("ctx", "cDlkYu", "ctx\\0& + * | "),
          ("value", "APm1dD", "val\\0d3\\0& + * | \\0margin-top:3px"),
        ],
      ),
      (
        "_cd3CpGzk_xIclOD",
        ["._cd3CpGzk_xIclOD ~ *{margin-top:4px;}"],
        0,
        1,
        1,
        [
          ("ctx", "CpGzk_", "ctx\\0& ~ * | "),
          ("value", "xIclOD", "val\\0d3\\0& ~ * | \\0margin-top:4px"),
        ],
      ),
      (
        "_iBEUWxotJ",
        [],
        1,
        0,
        0,
        [("id", "_iBEUWxotJ", "bind\\0\\0Input\\0\\0child\\00")],
      ),
      (
        "_iUOCl8mIz",
        [],
        1,
        0,
        0,
        [("id", "_iUOCl8mIz", "bind\\0\\0Input\\0\\0cell\\00")],
      ),
      (
        "_iItEeKS6J",
        [],
        1,
        0,
        0,
        [("id", "_iItEeKS6J", "bind\\0\\0Input\\0\\0next\\00")],
      ),
      (
        "_ilXssxRN6",
        [],
        1,
        0,
        0,
        [("id", "_ilXssxRN6", "bind\\0\\0Input\\0\\0later\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.child", "_iBEUWxotJ _cctkDsyxktNCm5K", "_iBEUWxotJ"),
      ("Input.cell", "_iUOCl8mIz _cfyHZhI8Udfs9HD", "_iUOCl8mIz"),
      ("Input.next", "_iItEeKS6J _cd3cDlkYuAPm1dD", "_iItEeKS6J"),
      ("Input.later", "_ilXssxRN6 _cd3CpGzk_xIclOD", "_ilXssxRN6"),
    ]
  ];
  let child = CSS.make("cx-child _iBEUWxotJ _cctkDsyxktNCm5K", []);
  let cell = CSS.make("cx-cell _iUOCl8mIz _cfyHZhI8Udfs9HD", []);
  let next = CSS.make("cx-next _iItEeKS6J _cd3cDlkYuAPm1dD", []);
  let later = CSS.make("cx-later _ilXssxRN6 _cd3CpGzk_xIclOD", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_cctkDsyxktNCm5K",
        ["._cctkDsyxktNCm5K > *{margin:0;}"],
        0,
        1,
        4,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "tNCm5K", "val\\0ct\\0& > * | \\0margin:0"),
        ],
      ),
      (
        "_cfyHZhI8Udfs9HD",
        ["._cfyHZhI8Udfs9HD td{padding:0;}"],
        0,
        1,
        4,
        [
          ("ctx", "HZhI8U", "ctx\\0& td | "),
          ("value", "dfs9HD", "val\\0fy\\0& td | \\0padding:0"),
        ],
      ),
      (
        "_cd3cDlkYuAPm1dD",
        ["._cd3cDlkYuAPm1dD + *{margin-top:3px;}"],
        0,
        1,
        1,
        [
          ("ctx", "cDlkYu", "ctx\\0& + * | "),
          ("value", "APm1dD", "val\\0d3\\0& + * | \\0margin-top:3px"),
        ],
      ),
      (
        "_cd3CpGzk_xIclOD",
        ["._cd3CpGzk_xIclOD ~ *{margin-top:4px;}"],
        0,
        1,
        1,
        [
          ("ctx", "CpGzk_", "ctx\\0& ~ * | "),
          ("value", "xIclOD", "val\\0d3\\0& ~ * | \\0margin-top:4px"),
        ],
      ),
      (
        "_iBEUWxotJ",
        [],
        1,
        0,
        0,
        [("id", "_iBEUWxotJ", "bind\\0\\0Input\\0\\0child\\00")],
      ),
      (
        "_iUOCl8mIz",
        [],
        1,
        0,
        0,
        [("id", "_iUOCl8mIz", "bind\\0\\0Input\\0\\0cell\\00")],
      ),
      (
        "_iItEeKS6J",
        [],
        1,
        0,
        0,
        [("id", "_iItEeKS6J", "bind\\0\\0Input\\0\\0next\\00")],
      ),
      (
        "_ilXssxRN6",
        [],
        1,
        0,
        0,
        [("id", "_ilXssxRN6", "bind\\0\\0Input\\0\\0later\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.child", "_iBEUWxotJ _cctkDsyxktNCm5K", "_iBEUWxotJ"),
      ("Input.cell", "_iUOCl8mIz _cfyHZhI8Udfs9HD", "_iUOCl8mIz"),
      ("Input.next", "_iItEeKS6J _cd3cDlkYuAPm1dD", "_iItEeKS6J"),
      ("Input.later", "_ilXssxRN6 _cd3CpGzk_xIclOD", "_ilXssxRN6"),
    ]
  ];
  let child = CSS.make("_iBEUWxotJ _cctkDsyxktNCm5K", []);
  let cell = CSS.make("_iUOCl8mIz _cfyHZhI8Udfs9HD", []);
  let next = CSS.make("_iItEeKS6J _cd3cDlkYuAPm1dD", []);
  let later = CSS.make("_ilXssxRN6 _cd3CpGzk_xIclOD", []);
