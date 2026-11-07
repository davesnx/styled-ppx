A bundle cell of a custom or unknown property holds the hash of the
property name. The payload lists that hash, once per name, so `generate`
checks it for collisions like the name of a plain atom.

  $ cat > input.ml <<EOF
  > let theme = [%css "@media (min-width: 1px) { --gap: 1px; } @media (min-width: 2px) { --gap: 2px; }"]
  > EOF
  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_bACzzDaTjT0-T3I8pzzDaTjT0KcXeumQNX2D_",
        [
          "@media (min-width:1px){._bACzzDaTjT0-T3I8pzzDaTjT0KcXeumQNX2D_{--gap:1px;}}",
          "@media (min-width:2px){._bACzzDaTjT0-T3I8pzzDaTjT0KcXeumQNX2D_{--gap:2px;}}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "-T3I8p", "ctx\\0& | @media (min-width:1px) | "),
          ("ctx", "KcXeum", "ctx\\0& | @media (min-width:2px) | "),
          ("name", "DaTjT0", "name\\0--gap"),
          (
            "value",
            "QNX2D_",
            "bval\\0& | @media (min-width:1px) | \\0--gap\\0--gap:1px\\0& | @media (min-width:2px) | \\0--gap\\0--gap:2px",
          ),
        ],
      ),
      (
        "_ijYcUjvH7",
        [],
        1,
        0,
        0,
        [("id", "_ijYcUjvH7", "bind\\0\\0Input\\0\\0theme\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input.theme",
        "_ijYcUjvH7 _bACzzDaTjT0-T3I8pzzDaTjT0KcXeumQNX2D_",
        "_ijYcUjvH7",
      ),
    ]
  ];
  let theme = CSS.make("_ijYcUjvH7 _bACzzDaTjT0-T3I8pzzDaTjT0KcXeumQNX2D_", []);
