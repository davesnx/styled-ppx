  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E '@keyframes|animation-name:var|animation:var|~vars|toStyleVars|Height.toString'
    "@keyframes keyframe-18lxia8{0%{height:var(--1qjy03n);}100%{height:var(--1obl5py);}}"
    ".css-1f7afs0{-webkit-animation-name:var(--1f7afs0-0);animation-name:var(--1f7afs0-0);-webkit-animation-duration:180ms;animation-duration:180ms;}"
    ".css-1arixw4{-webkit-animation:var(--1arixw4-0) 180ms ease-out 0s 1 normal both;animation:var(--1arixw4-0) 180ms ease-out 0s 1 normal both;}"
      ~vars=[
        ("--1qjy03n", CSS.Types.Height.toString(prev)),
        ("--1obl5py", CSS.Types.Height.toString(current)),
      CSS.Types.AnimationName.toStyleVars("--1f7afs0-0", animation),
      CSS.Types.AnimationName.toStyleVars("--1arixw4-0", animation),
