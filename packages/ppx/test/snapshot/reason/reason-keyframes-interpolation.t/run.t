  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-19wviuw{0%{height:var(--prev-8kacnv)}100%{height:var(--current-u1690)}}"
    ".css-dy0iev-styles{-webkit-animation-name:var(--animation-1sd4kiq);animation-name:var(--animation-1sd4kiq)}"
    ".css-1hy1yyp-shorthand{-webkit-animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both}"
      ~vars=[
        ("--prev-8kacnv", CSS.Types.Height.toString(prev)),
        ("--current-u1690", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--animation-1sd4kiq", animation),
      CSS.Types.AnimationName.toStyleVars("--animation-wutik1", animation),
