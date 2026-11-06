Shape 5: a selector list gives one declaration per selector. Declarations that overlap in one block join into a bundle.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_bAC7f1Tl5-w7ftbJlv2awcECD",
        [
          "._bAC7f1Tl5-w7ftbJlv2awcECD:hover{color:red;}",
          "._bAC7f1Tl5-w7ftbJlv2awcECD:focus{color:red;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          (
            "value",
            "awcECD",
            "bval\\0&:hover | \\07f\\0color:red\\0&:focus | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_bACfy1Tl5-wfytbJlv27F4lIo",
        [
          "._bACfy1Tl5-wfytbJlv27F4lIo:hover{padding:0;}",
          "._bACfy1Tl5-wfytbJlv27F4lIo:focus{padding:0;}",
        ],
        2,
        1,
        8,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          (
            "value",
            "7F4lIo",
            "bval\\0&:hover | \\0fy\\0padding:0\\0&:focus | \\0fy\\0padding:0",
          ),
        ],
      ),
      (
        "_c7f1Tl5-wvpMs6j",
        ["._c7f1Tl5-wvpMs6j:hover{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "vpMs6j", "val\\07f\\0&:hover | \\0color:red"),
        ],
      ),
      (
        "_ccttbJlv2VsQjpf",
        ["._ccttbJlv2VsQjpf:focus{margin:0;}"],
        2,
        1,
        4,
        [
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          ("value", "VsQjpf", "val\\0ct\\0&:focus | \\0margin:0"),
        ],
      ),
      (
        "_iaAgIHCSb",
        [],
        1,
        0,
        0,
        [("id", "_iaAgIHCSb", "bind\\0\\0Input\\0\\0list\\00")],
      ),
      (
        "_iwELOSwKL",
        [],
        1,
        0,
        0,
        [("id", "_iwELOSwKL", "bind\\0\\0Input\\0\\0listTwo\\00")],
      ),
      (
        "_iOvPQxoE7",
        [],
        1,
        0,
        0,
        [("id", "_iOvPQxoE7", "bind\\0\\0Input\\0\\0apart\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.list", "_iaAgIHCSb _bAC7f1Tl5-w7ftbJlv2awcECD", "_iaAgIHCSb"),
      (
        "Input.listTwo",
        "_iwELOSwKL _bAC7f1Tl5-w7ftbJlv2awcECD _bACfy1Tl5-wfytbJlv27F4lIo",
        "_iwELOSwKL",
      ),
      (
        "Input.apart",
        "_iOvPQxoE7 _c7f1Tl5-wvpMs6j _ccttbJlv2VsQjpf",
        "_iOvPQxoE7",
      ),
    ]
  ];
  let list = CSS.make("cx-list _iaAgIHCSb _bAC7f1Tl5-w7ftbJlv2awcECD", []);
  let listTwo =
    CSS.make(
      "cx-listTwo _iwELOSwKL _bAC7f1Tl5-w7ftbJlv2awcECD _bACfy1Tl5-wfytbJlv27F4lIo",
      [],
    );
  let apart =
    CSS.make("cx-apart _iOvPQxoE7 _c7f1Tl5-wvpMs6j _ccttbJlv2VsQjpf", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_bAC7f1Tl5-w7ftbJlv2awcECD",
        [
          "._bAC7f1Tl5-w7ftbJlv2awcECD:hover{color:red;}",
          "._bAC7f1Tl5-w7ftbJlv2awcECD:focus{color:red;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          (
            "value",
            "awcECD",
            "bval\\0&:hover | \\07f\\0color:red\\0&:focus | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_bACfy1Tl5-wfytbJlv27F4lIo",
        [
          "._bACfy1Tl5-wfytbJlv27F4lIo:hover{padding:0;}",
          "._bACfy1Tl5-wfytbJlv27F4lIo:focus{padding:0;}",
        ],
        2,
        1,
        8,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          (
            "value",
            "7F4lIo",
            "bval\\0&:hover | \\0fy\\0padding:0\\0&:focus | \\0fy\\0padding:0",
          ),
        ],
      ),
      (
        "_c7f1Tl5-wvpMs6j",
        ["._c7f1Tl5-wvpMs6j:hover{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "vpMs6j", "val\\07f\\0&:hover | \\0color:red"),
        ],
      ),
      (
        "_ccttbJlv2VsQjpf",
        ["._ccttbJlv2VsQjpf:focus{margin:0;}"],
        2,
        1,
        4,
        [
          ("ctx", "tbJlv2", "ctx\\0&:focus | "),
          ("value", "VsQjpf", "val\\0ct\\0&:focus | \\0margin:0"),
        ],
      ),
      (
        "_iaAgIHCSb",
        [],
        1,
        0,
        0,
        [("id", "_iaAgIHCSb", "bind\\0\\0Input\\0\\0list\\00")],
      ),
      (
        "_iwELOSwKL",
        [],
        1,
        0,
        0,
        [("id", "_iwELOSwKL", "bind\\0\\0Input\\0\\0listTwo\\00")],
      ),
      (
        "_iOvPQxoE7",
        [],
        1,
        0,
        0,
        [("id", "_iOvPQxoE7", "bind\\0\\0Input\\0\\0apart\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.list", "_iaAgIHCSb _bAC7f1Tl5-w7ftbJlv2awcECD", "_iaAgIHCSb"),
      (
        "Input.listTwo",
        "_iwELOSwKL _bAC7f1Tl5-w7ftbJlv2awcECD _bACfy1Tl5-wfytbJlv27F4lIo",
        "_iwELOSwKL",
      ),
      (
        "Input.apart",
        "_iOvPQxoE7 _c7f1Tl5-wvpMs6j _ccttbJlv2VsQjpf",
        "_iOvPQxoE7",
      ),
    ]
  ];
  let list = CSS.make("_iaAgIHCSb _bAC7f1Tl5-w7ftbJlv2awcECD", []);
  let listTwo =
    CSS.make(
      "_iwELOSwKL _bAC7f1Tl5-w7ftbJlv2awcECD _bACfy1Tl5-wfytbJlv27F4lIo",
      [],
    );
  let apart = CSS.make("_iOvPQxoE7 _c7f1Tl5-wvpMs6j _ccttbJlv2VsQjpf", []);
