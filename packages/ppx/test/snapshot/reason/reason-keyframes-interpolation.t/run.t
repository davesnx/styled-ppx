  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-bmi8wq{0%{height:var(--prev-1lcjfri) ;}100%{height:var(--current-1tpym2i) ;}}"
    ".css-dy0iev-styles{-webkit-animation-name:var(--animation-1sd4kiq);animation-name:var(--animation-1sd4kiq);}"
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--prev-1lcjfri", CSS.Types.Height.toString(prev)),
        ("--current-1tpym2i", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--animation-1sd4kiq", animation),
      CSS.Types.AnimationName.toStyleVars("--animation-wutik1", animation),
