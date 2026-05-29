  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-ayzqvu{0%{height:var(--var-wfgbo9) ;}100%{height:var(--var-1oc54wd) ;}}"
    ".css-dy0iev-styles{-webkit-animation-name:var(--var-1a009jy);animation-name:var(--var-1a009jy);}"
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--var-1a009jy) 180ms ease-out 0s 1 normal both;animation:var(--var-1a009jy) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--var-wfgbo9", CSS.Types.Height.toString(prev)),
        ("--var-1oc54wd", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--var-1a009jy", animation),
      CSS.Types.AnimationName.toStyleVars("--var-1a009jy", animation),
