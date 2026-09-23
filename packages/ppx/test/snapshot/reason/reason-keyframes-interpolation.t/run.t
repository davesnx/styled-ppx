  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "@keyframes keyframe-bmi8wq{0%{height:var(--prev-1lcjfri) ;}100%{height:var(--current-1tpym2i) ;}}"
  ];
  [@css
    ".css-dy0iev-styles{-webkit-animation-name:var(--animation-1sd4kiq);animation-name:var(--animation-1sd4kiq);}"
  ];
  [@css
    ".css-1c3wjsg-styles{-webkit-animation-duration:180ms;animation-duration:180ms;}"
  ];
  [@css
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;}"
  ];
  [@css.bindings
    [
      ("Output.styles", "css-dy0iev-styles css-1c3wjsg-styles"),
      ("Output.shorthand", "css-1hy1yyp-shorthand"),
    ]
  ];
  let previousHeight = 20;
  let currentHeight = 80;
  let prev = `px(previousHeight);
  let current = `px(currentHeight);
  let animation =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--prev-1lcjfri", CSS.Types.Height.toString(prev)),
        ("--current-1tpym2i", CSS.Types.Height.toString(current)),
      ],
      "keyframe-bmi8wq",
    );
  let styles =
    CSS.make(
      "css-dy0iev-styles css-1c3wjsg-styles",
      CSS.Types.AnimationName.toStyleVars("--animation-1sd4kiq", animation),
    );
  let shorthand =
    CSS.make(
      "css-1hy1yyp-shorthand",
      CSS.Types.AnimationName.toStyleVars("--animation-wutik1", animation),
    );
