Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --colorStr-dubz4q{syntax:\"*\";inherits:false;}"];
  [@css "@property --plainStr-1s0lkxl{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-1wnjp36{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_xrS1171000000gk7vnl",
        ["._xrS1171000000gk7vnl{--color-link:var(--colorStr-dubz4q);}"],
        1,
        0,
        1,
        [
          ("name", "rS1171", "name\\0--color-link"),
          (
            "value",
            "gk7vnl",
            "val\\0--color-link\\0& | \\0--color-link:$(colorStr)",
          ),
        ],
      ),
      (
        "_x76yA7b000000fSZSMy",
        ["._x76yA7b000000fSZSMy{--spacing:var(--plainStr-1s0lkxl);}"],
        1,
        0,
        1,
        [
          ("name", "76yA7b", "name\\0--spacing"),
          ("value", "fSZSMy", "val\\0--spacing\\0& | \\0--spacing:$(plainStr)"),
        ],
      ),
      (
        "_xMn1JCa000000WSwvJh",
        ["._xMn1JCa000000WSwvJh{--token:var(--value-1wnjp36);}"],
        1,
        0,
        1,
        [
          ("name", "Mn1JCa", "name\\0--token"),
          ("value", "WSwvJh", "val\\0--token\\0& | \\0--token:$(value)"),
        ],
      ),
      (
        "_iJSA56o3t",
        [],
        1,
        0,
        0,
        [("id", "_iJSA56o3t", "bind\\0\\0Output\\0\\0row\\00")],
      ),
      (
        "_ij_M5a2V6",
        [],
        1,
        0,
        0,
        [("id", "_ij_M5a2V6", "bind\\0\\0Output\\0\\0theme\\00")],
      ),
      (
        "_ipUTKpywx",
        [],
        1,
        0,
        0,
        [("id", "_ipUTKpywx", "bind\\0\\0Output\\0\\0dyn\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.row", "_iJSA56o3t _xrS1171000000gk7vnl", "_iJSA56o3t"),
      (
        "Output.theme",
        "_ij_M5a2V6 _xrS1171000000gk7vnl _x76yA7b000000fSZSMy",
        "_ij_M5a2V6",
      ),
      ("Output.dyn", "_ipUTKpywx _xMn1JCa000000WSwvJh", "_ipUTKpywx"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row =
    CSS.make(
      "_iJSA56o3t _xrS1171000000gk7vnl",
      [("--colorStr-dubz4q", colorStr)],
    );
  let theme =
    CSS.make(
      "_ij_M5a2V6 _xrS1171000000gk7vnl _x76yA7b000000fSZSMy",
      [("--colorStr-dubz4q", colorStr), ("--plainStr-1s0lkxl", plainStr)],
    );
  let dyn = value =>
    CSS.make("_ipUTKpywx _xMn1JCa000000WSwvJh", [("--value-1wnjp36", value)]);
