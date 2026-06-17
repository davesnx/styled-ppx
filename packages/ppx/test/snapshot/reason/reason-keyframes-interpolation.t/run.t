  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-e6xg4i{0%{height:var(--var-1lcjfri) ;}100%{height:var(--var-1tpym2i) ;}}"
    ".css-dy0iev-styles{-webkit-animation-name:var(--var-1sd4kiq);animation-name:var(--var-1sd4kiq);}"
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--var-wutik1) 180ms ease-out 0s 1 normal both;animation:var(--var-wutik1) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--var-1lcjfri", CSS.Types.Height.toString(prev)),
        ("--var-1tpym2i", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--var-1sd4kiq", animation),
      CSS.Types.AnimationName.toStyleVars("--var-wutik1", animation),
