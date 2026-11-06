  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "@keyframes keyframe-1nlwrbc{0%{height:var(--prev-1qjy03n);}100%{height:var(--current-1obl5py);}}"
  ];
  [@css.atoms
    [
      (
        "_a41z-V3KR",
        [
          "._a41z-V3KR{-webkit-animation-name:var(--animation-1fn4vhd);animation-name:var(--animation-1fn4vhd);}",
        ],
        1,
        0,
        1,
        [("value", "z-V3KR", "val\\041\\0& | \\0animation-name:$(animation)")],
      ),
      (
        "_a3yUuVoYh",
        [
          "._a3yUuVoYh{-webkit-animation-duration:180ms;animation-duration:180ms;}",
        ],
        1,
        0,
        1,
        [("value", "UuVoYh", "val\\03y\\0& | \\0animation-duration:180ms")],
      ),
      (
        "_a3sJaSxci",
        [
          "._a3sJaSxci{-webkit-animation:var(--animation-1yip9na) 180ms ease-out 0s 1 normal both;animation:var(--animation-1yip9na) 180ms ease-out 0s 1 normal both;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "JaSxci",
            "val\\03s\\0& | \\0animation:$(animation) 180ms ease-out 0s 1 normal both",
          ),
        ],
      ),
      (
        "_iocql4-No",
        [],
        1,
        0,
        0,
        [("id", "_iocql4-No", "bind\\0\\0Output\\0\\0styles\\00")],
      ),
      (
        "_iPEkejt2V",
        [],
        1,
        0,
        0,
        [("id", "_iPEkejt2V", "bind\\0\\0Output\\0\\0shorthand\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.styles", "_iocql4-No _a41z-V3KR _a3yUuVoYh", "_iocql4-No"),
      ("Output.shorthand", "_iPEkejt2V _a3sJaSxci", "_iPEkejt2V"),
    ]
  ];
  let previousHeight = 20;
  let currentHeight = 80;
  let prev = `px(previousHeight);
  let current = `px(currentHeight);
  let animation =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--prev-1qjy03n", CSS.Types.Height.toString(prev)),
        ("--current-1obl5py", CSS.Types.Height.toString(current)),
      ],
      "keyframe-1nlwrbc",
    );
  let styles =
    CSS.make(
      "_iocql4-No _a41z-V3KR _a3yUuVoYh",
      CSS.Types.AnimationName.toStyleVars("--animation-1fn4vhd", animation),
    );
  let shorthand =
    CSS.make(
      "_iPEkejt2V _a3sJaSxci",
      CSS.Types.AnimationName.toStyleVars("--animation-1yip9na", animation),
    );
