  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes _k_1nlwrbc{0%{height:var(--prev-1qjy03n);}100%{height:var(--current-1obl5py);}}"
    "._a_2z01s0iev{-webkit-animation-name:var(--animation-1sd4kiq);animation-name:var(--animation-1sd4kiq);}"
    "._a_2z1yyp{-webkit-animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;animation:var(--animation-wutik1) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--prev-1qjy03n", CSS.Types.Height.toString(prev)),
        ("--current-1obl5py", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--animation-1sd4kiq", animation),
      CSS.Types.AnimationName.toStyleVars("--animation-wutik1", animation),
