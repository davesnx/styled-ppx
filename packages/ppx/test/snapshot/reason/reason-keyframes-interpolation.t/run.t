  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-d8raru{0%{height:var(--var-16opwhh) ;}100%{height:var(--var-cce28y) ;}}"
    ".css-dy0iev-styles{-webkit-animation-name:var(--var-cxins4);animation-name:var(--var-cxins4);}"
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--var-1k48smk) 180ms ease-out 0s 1 normal both;animation:var(--var-1k48smk) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--var-16opwhh", CSS.Types.Height.toString(prev)),
        ("--var-cce28y", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--var-cxins4", animation),
      CSS.Types.AnimationName.toStyleVars("--var-1k48smk", animation),
