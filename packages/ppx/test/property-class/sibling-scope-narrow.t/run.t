Only a rule with `&` on both sides of a `+` or `~` combinator matches siblings of
the same component, so only that rule prints the binding id next to the atom class.
`.x + &` and `& + .x` keep the plain atom class and no owner in the context.

  $ refmt --parse re --print ml input.re > input.ml
  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_cd3c0AtcpEMmpp_",
        [".x + ._cd3c0AtcpEMmpp_{margin-top:3px;}"],
        2,
        1,
        1,
        [
          ("ctx", "c0Atcp", "ctx\\0.x + & | "),
          ("value", "EMmpp_", "val\\0d3\\0.x + & | \\0margin-top:3px"),
        ],
      ),
      (
        "_cd33Us9-0qnM_9E",
        ["._cd33Us9-0qnM_9E + .x{margin-top:3px;}"],
        0,
        1,
        1,
        [
          ("ctx", "3Us9-0", "ctx\\0& + .x | "),
          ("value", "qnM_9E", "val\\0d3\\0& + .x | \\0margin-top:3px"),
        ],
      ),
      (
        "_cd390BSi4KJuFz9",
        [
          "._cd390BSi4KJuFz9._iIxGXPL5_ + ._cd390BSi4KJuFz9._iIxGXPL5_{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "KJuFz9",
            "val\\0d3\\0& + & | \\0margin-top:3px\\0owner:_iIxGXPL5_",
          ),
        ],
      ),
      (
        "_cd3xlsqqrwcVoCY",
        [
          "._cd3xlsqqrwcVoCY._i2-HCHi01 + .a + ._cd3xlsqqrwcVoCY._i2-HCHi01{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "xlsqqr", "ctx\\0& + .a + & | "),
          (
            "value",
            "wcVoCY",
            "val\\0d3\\0& + .a + & | \\0margin-top:3px\\0owner:_i2-HCHi01",
          ),
        ],
      ),
      (
        "_i0qmHPtRt",
        [],
        1,
        0,
        0,
        [("id", "_i0qmHPtRt", "bind\\0\\0Input\\0\\0before\\00")],
      ),
      (
        "_iVeDmRf6y",
        [],
        1,
        0,
        0,
        [("id", "_iVeDmRf6y", "bind\\0\\0Input\\0\\0after\\00")],
      ),
      (
        "_iIxGXPL5_",
        [],
        1,
        0,
        0,
        [("id", "_iIxGXPL5_", "bind\\0\\0Input\\0\\0both\\00")],
      ),
      (
        "_i2-HCHi01",
        [],
        1,
        0,
        0,
        [("id", "_i2-HCHi01", "bind\\0\\0Input\\0\\0chain\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.before", "_i0qmHPtRt _cd3c0AtcpEMmpp_", "_i0qmHPtRt"),
      ("Input.after", "_iVeDmRf6y _cd33Us9-0qnM_9E", "_iVeDmRf6y"),
      ("Input.both", "_iIxGXPL5_ _cd390BSi4KJuFz9", "_iIxGXPL5_"),
      ("Input.chain", "_i2-HCHi01 _cd3xlsqqrwcVoCY", "_i2-HCHi01"),
    ]
  ];
  let before = CSS.make("_i0qmHPtRt _cd3c0AtcpEMmpp_", []);
  let after = CSS.make("_iVeDmRf6y _cd33Us9-0qnM_9E", []);
  let both = CSS.make("_iIxGXPL5_ _cd390BSi4KJuFz9", []);
  let chain = CSS.make("_i2-HCHi01 _cd3xlsqqrwcVoCY", []);
