Shape 12: animation-name with an interpolation takes the vars of the keyframe.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css.atoms
    [
      (
        "_a41ypBz8h",
        [
          "._a41ypBz8h{-webkit-animation-name:var(--kf-122efng);animation-name:var(--kf-122efng);}",
        ],
        1,
        0,
        1,
        [("value", "ypBz8h", "val\\041\\0& | \\0animation-name:$(kf)")],
      ),
      (
        "_iHBoakOhP",
        [],
        1,
        0,
        0,
        [("id", "_iHBoakOhP", "bind\\0\\0Input\\0\\0fade\\00")],
      ),
    ]
  ];
  [@css.bindings [("Input.fade", "_iHBoakOhP _a41ypBz8h", "_iHBoakOhP")]];
  let kf = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  let fade =
    CSS.make(
      "cx-fade _iHBoakOhP _a41ypBz8h",
      CSS.Types.AnimationName.toStyleVars("--kf-122efng", kf),
    );

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css.atoms
    [
      (
        "_a41ypBz8h",
        [
          "._a41ypBz8h{-webkit-animation-name:var(--kf-122efng);animation-name:var(--kf-122efng);}",
        ],
        1,
        0,
        1,
        [("value", "ypBz8h", "val\\041\\0& | \\0animation-name:$(kf)")],
      ),
      (
        "_iHBoakOhP",
        [],
        1,
        0,
        0,
        [("id", "_iHBoakOhP", "bind\\0\\0Input\\0\\0fade\\00")],
      ),
    ]
  ];
  [@css.bindings [("Input.fade", "_iHBoakOhP _a41ypBz8h", "_iHBoakOhP")]];
  let kf = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  let fade =
    CSS.make(
      "_iHBoakOhP _a41ypBz8h",
      CSS.Types.AnimationName.toStyleVars("--kf-122efng", kf),
    );
