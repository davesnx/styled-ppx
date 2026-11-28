  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-1nlwrbc{0%{height:var(--prev-1qjy03n);}100%{height:var(--current-1obl5py);}}"
    ".css-vdivif4{-webkit-animation-name:var(--vdivfq0);animation-name:var(--vdivfq0);-webkit-animation-duration:180ms;animation-duration:180ms;}"
    ".css-vdivp3b{-webkit-animation:var(--vdiv9kk) 180ms ease-out 0s 1 normal both;animation:var(--vdiv9kk) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--prev-1qjy03n", CSS.Types.Height.toString(prev)),
        ("--current-1obl5py", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--vdivfq0", animation),
      CSS.Types.AnimationName.toStyleVars("--vdiv9kk", animation),
