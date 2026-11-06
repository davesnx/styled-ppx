An empty `[%css {||}]` marker has no content to hash, so its class is the binding
id: a hash of the module name, the submodule path, and the binding name. The id
must exist in production too, and two markers with the same name in different
modules must get different ids.

Development:

  $ refmt --parse re --print ml m.re > m.ml
  $ ../../standalone.exe --env development --impl m.ml -o m.ml
  $ refmt --parse re --print ml n.re > n.ml
  $ ../../standalone.exe --env development --impl n.ml -o n.ml
  $ refmt --parse re --print ml box.re > box.ml
  $ ../../standalone.exe --env development --impl box.ml -o box.ml
  $ refmt --parse re --print ml bare.re > bare.ml
  $ ../../standalone.exe --env development --impl bare.ml -o bare.ml

`M.m`, `M.Inner.m` and `N.m` are three different markers.

  $ refmt --parse ml --print re m.ml
  [@css.atoms
    [
      (
        "_a7fn70fsU",
        ["._a7fn70fsU{color:black;}"],
        1,
        0,
        1,
        [("value", "n70fsU", "val\\07f\\0& | \\0color:black")],
      ),
      (
        "_bAC7fvjtCjL7f0-2WF_oSCA4Y",
        [
          "._bAC7fvjtCjL7f0-2WF_oSCA4Y._iKMiiAc13{color:green;}",
          "._bAC7fvjtCjL7f0-2WF_oSCA4Y:not(._iKMiiAc13){color:red;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "vjtCjL", "ctx\\0&._iKMiiAc13 | "),
          ("ctx", "0-2WF_", "ctx\\0&:not(._iKMiiAc13) | "),
          (
            "value",
            "oSCA4Y",
            "bval\\0&._iKMiiAc13 | \\07f\\0color:green\\0&:not(._iKMiiAc13) | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_iKMiiAc13",
        [],
        1,
        0,
        0,
        [("id", "_iKMiiAc13", "bind\\0\\0M\\0\\0m\\00")],
      ),
      (
        "_il-9sFgHR",
        [],
        1,
        0,
        0,
        [("id", "_il-9sFgHR", "bind\\0\\0M\\0\\0card\\00")],
      ),
      (
        "_injs_hdOK",
        [],
        1,
        0,
        0,
        [("id", "_injs_hdOK", "bind\\0\\0M\\0Inner\\0m\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("M.m", "_iKMiiAc13", "_iKMiiAc13"),
      (
        "M.card",
        "_il-9sFgHR _a7fn70fsU _bAC7fvjtCjL7f0-2WF_oSCA4Y",
        "_il-9sFgHR",
      ),
      ("M.Inner.m", "_injs_hdOK", "_injs_hdOK"),
    ]
  ];
  let m = CSS.make("cx-m _iKMiiAc13", []);
  let card =
    CSS.make("cx-card _il-9sFgHR _a7fn70fsU _bAC7fvjtCjL7f0-2WF_oSCA4Y", []);
  module Inner = {
    let m = CSS.make("cx-m _injs_hdOK", []);
  };

  $ refmt --parse ml --print re n.ml
  [@css.atoms
    [
      (
        "_bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw",
        [
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._i8LfUfMKc{color:green;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000M.m\000{color:red;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000M.Inner.m\000{color:blue;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000Box.Box\000{color:purple;}",
        ],
        2,
        1,
        4,
        [
          ("ctx", "gFg--4", "ctx\\0&._i8LfUfMKc | "),
          ("ctx", "MdR85d", "ctx\\0&.$(M.m)\\0module:N | "),
          ("ctx", "QYUr6K", "ctx\\0&.$(M.Inner.m)\\0module:N | "),
          ("ctx", "EmeCN-", "ctx\\0&.$(Box.Box)\\0module:N | "),
          (
            "value",
            "qicPyw",
            "bval\\0&._i8LfUfMKc | \\07f\\0color:green\\0&.$(M.m)\\0module:N | \\07f\\0color:red\\0module:N\\0&.$(M.Inner.m)\\0module:N | \\07f\\0color:blue\\0module:N\\0&.$(Box.Box)\\0module:N | \\07f\\0color:purple\\0module:N",
          ),
        ],
      ),
      (
        "_i8LfUfMKc",
        [],
        1,
        0,
        0,
        [("id", "_i8LfUfMKc", "bind\\0\\0N\\0\\0m\\00")],
      ),
      (
        "_ipWeUwQYV",
        [],
        1,
        0,
        0,
        [("id", "_ipWeUwQYV", "bind\\0\\0N\\0\\0panel\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("N.m", "_i8LfUfMKc", "_i8LfUfMKc"),
      (
        "N.panel",
        "_ipWeUwQYV _bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw",
        "_ipWeUwQYV",
      ),
    ]
  ];
  [@css.refs
    [
      ("M.m", "n.ml", 6, 6, 9),
      ("M.Inner.m", "n.ml", 7, 6, 15),
      ("Box.Box", "n.ml", 8, 6, 13),
    ]
  ];
  let _ = M.m;
  let _ = M.Inner.m;
  let _ = Box.Box;
  let m = CSS.make("cx-m _i8LfUfMKc", []);
  let panel =
    CSS.make(
      "cx-panel _ipWeUwQYV _bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw",
      [],
    );

  $ refmt --parse ml --print re bare.ml
  [@css.atoms
    [
      (
        "_c7fdsbCucVM2v6u",
        ["._c7fdsbCucVM2v6u > ._inkeWBWLU{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "dsbCuc", "ctx\\0& > ._inkeWBWLU | "),
          ("value", "VM2v6u", "val\\07f\\0& > ._inkeWBWLU | \\0color:blue"),
        ],
      ),
      (
        "_inkeWBWLU",
        [],
        1,
        0,
        0,
        [("id", "_inkeWBWLU", "bind\\0\\0Bare\\0\\0m\\00")],
      ),
      (
        "_iHP7t3VYD",
        [],
        1,
        0,
        0,
        [("id", "_iHP7t3VYD", "bind\\0\\0Bare\\0\\0list\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Bare.m", "_inkeWBWLU", "_inkeWBWLU"),
      ("Bare.list", "_iHP7t3VYD _c7fdsbCucVM2v6u", "_iHP7t3VYD"),
    ]
  ];
  let m = CSS.make("cx-m _inkeWBWLU", []);
  let list = CSS.make("cx-list _iHP7t3VYD _c7fdsbCucVM2v6u", []);

  $ styled-ppx.generate m.ml n.ml box.ml bare.ml
  /* This file is generated by styled-ppx, do not edit manually */
  ._c7fdsbCucVM2v6u > ._inkeWBWLU{color:blue;}
  ._a7fn70fsU{color:black;}
  ._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._i8LfUfMKc{color:green;}
  ._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._iKMiiAc13{color:red;}
  ._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._injs_hdOK{color:blue;}
  ._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._iJ9-MVLDl{color:purple;}
  ._bAC7fvjtCjL7f0-2WF_oSCA4Y._iKMiiAc13{color:green;}
  ._bAC7fvjtCjL7f0-2WF_oSCA4Y:not(._iKMiiAc13){color:red;}

Production. Labels are off, but every marker keeps a class and every
`$(marker)` reference keeps its condition.

  $ mkdir prod
  $ refmt --parse re --print ml m.re > prod/m.ml
  $ ../../standalone.exe --env production --impl prod/m.ml -o prod/m.ml
  $ refmt --parse re --print ml n.re > prod/n.ml
  $ ../../standalone.exe --env production --impl prod/n.ml -o prod/n.ml
  $ refmt --parse re --print ml box.re > prod/box.ml
  $ ../../standalone.exe --env production --impl prod/box.ml -o prod/box.ml
  $ refmt --parse re --print ml bare.re > prod/bare.ml
  $ ../../standalone.exe --env production --impl prod/bare.ml -o prod/bare.ml

  $ refmt --parse ml --print re prod/m.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a7fn70fsU",
        ["._a7fn70fsU{color:black;}"],
        1,
        0,
        1,
        [("value", "n70fsU", "val\\07f\\0& | \\0color:black")],
      ),
      (
        "_bAC7fvjtCjL7f0-2WF_oSCA4Y",
        [
          "._bAC7fvjtCjL7f0-2WF_oSCA4Y._iKMiiAc13{color:green;}",
          "._bAC7fvjtCjL7f0-2WF_oSCA4Y:not(._iKMiiAc13){color:red;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "vjtCjL", "ctx\\0&._iKMiiAc13 | "),
          ("ctx", "0-2WF_", "ctx\\0&:not(._iKMiiAc13) | "),
          (
            "value",
            "oSCA4Y",
            "bval\\0&._iKMiiAc13 | \\07f\\0color:green\\0&:not(._iKMiiAc13) | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_iKMiiAc13",
        [],
        1,
        0,
        0,
        [("id", "_iKMiiAc13", "bind\\0\\0M\\0\\0m\\00")],
      ),
      (
        "_il-9sFgHR",
        [],
        1,
        0,
        0,
        [("id", "_il-9sFgHR", "bind\\0\\0M\\0\\0card\\00")],
      ),
      (
        "_injs_hdOK",
        [],
        1,
        0,
        0,
        [("id", "_injs_hdOK", "bind\\0\\0M\\0Inner\\0m\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("M.m", "_iKMiiAc13", "_iKMiiAc13"),
      (
        "M.card",
        "_il-9sFgHR _a7fn70fsU _bAC7fvjtCjL7f0-2WF_oSCA4Y",
        "_il-9sFgHR",
      ),
      ("M.Inner.m", "_injs_hdOK", "_injs_hdOK"),
    ]
  ];
  let m = CSS.make("_iKMiiAc13", []);
  let card = CSS.make("_il-9sFgHR _a7fn70fsU _bAC7fvjtCjL7f0-2WF_oSCA4Y", []);
  module Inner = {
    let m = CSS.make("_injs_hdOK", []);
  };

  $ refmt --parse ml --print re prod/n.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw",
        [
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._i8LfUfMKc{color:green;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000M.m\000{color:red;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000M.Inner.m\000{color:blue;}",
          "._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw.\000Box.Box\000{color:purple;}",
        ],
        2,
        1,
        4,
        [
          ("ctx", "gFg--4", "ctx\\0&._i8LfUfMKc | "),
          ("ctx", "MdR85d", "ctx\\0&.$(M.m)\\0module:N | "),
          ("ctx", "QYUr6K", "ctx\\0&.$(M.Inner.m)\\0module:N | "),
          ("ctx", "EmeCN-", "ctx\\0&.$(Box.Box)\\0module:N | "),
          (
            "value",
            "qicPyw",
            "bval\\0&._i8LfUfMKc | \\07f\\0color:green\\0&.$(M.m)\\0module:N | \\07f\\0color:red\\0module:N\\0&.$(M.Inner.m)\\0module:N | \\07f\\0color:blue\\0module:N\\0&.$(Box.Box)\\0module:N | \\07f\\0color:purple\\0module:N",
          ),
        ],
      ),
      (
        "_i8LfUfMKc",
        [],
        1,
        0,
        0,
        [("id", "_i8LfUfMKc", "bind\\0\\0N\\0\\0m\\00")],
      ),
      (
        "_ipWeUwQYV",
        [],
        1,
        0,
        0,
        [("id", "_ipWeUwQYV", "bind\\0\\0N\\0\\0panel\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("N.m", "_i8LfUfMKc", "_i8LfUfMKc"),
      (
        "N.panel",
        "_ipWeUwQYV _bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw",
        "_ipWeUwQYV",
      ),
    ]
  ];
  [@css.refs
    [
      ("M.m", "prod/n.ml", 6, 6, 9),
      ("M.Inner.m", "prod/n.ml", 7, 6, 15),
      ("Box.Box", "prod/n.ml", 8, 6, 13),
    ]
  ];
  let _ = M.m;
  let _ = M.Inner.m;
  let _ = Box.Box;
  let m = CSS.make("_i8LfUfMKc", []);
  let panel =
    CSS.make("_ipWeUwQYV _bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw", []);

  $ refmt --parse ml --print re prod/bare.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7fdsbCucVM2v6u",
        ["._c7fdsbCucVM2v6u > ._inkeWBWLU{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "dsbCuc", "ctx\\0& > ._inkeWBWLU | "),
          ("value", "VM2v6u", "val\\07f\\0& > ._inkeWBWLU | \\0color:blue"),
        ],
      ),
      (
        "_inkeWBWLU",
        [],
        1,
        0,
        0,
        [("id", "_inkeWBWLU", "bind\\0\\0Bare\\0\\0m\\00")],
      ),
      (
        "_iHP7t3VYD",
        [],
        1,
        0,
        0,
        [("id", "_iHP7t3VYD", "bind\\0\\0Bare\\0\\0list\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Bare.m", "_inkeWBWLU", "_inkeWBWLU"),
      ("Bare.list", "_iHP7t3VYD _c7fdsbCucVM2v6u", "_iHP7t3VYD"),
    ]
  ];
  let m = CSS.make("_inkeWBWLU", []);
  let list = CSS.make("_iHP7t3VYD _c7fdsbCucVM2v6u", []);

  $ styled-ppx.generate prod/m.ml prod/n.ml prod/box.ml prod/bare.ml
  /* This file is generated by styled-ppx, do not edit manually */
  ._c7fdsbCucVM2v6u > ._inkeWBWLU{color:blue;}._a7fn70fsU{color:black;}._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._i8LfUfMKc{color:green;}._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._iKMiiAc13{color:red;}._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._injs_hdOK{color:blue;}._bAE7fgFg--47fMdR85d7fQYUr6K7fEmeCN-qicPyw._iJ9-MVLDl{color:purple;}._bAC7fvjtCjL7f0-2WF_oSCA4Y._iKMiiAc13{color:green;}._bAC7fvjtCjL7f0-2WF_oSCA4Y:not(._iKMiiAc13){color:red;}

The class depends on the module name, not on the file path or the
target: the same module compiled from another directory for native
gives the same output.

  $ mkdir native
  $ refmt --parse re --print ml m.re > native/m.ml
  $ ../../standalone.exe --env production --native --impl native/m.ml -o native/m.ml
  $ diff prod/m.ml native/m.ml
