Shape 16: a keyframe is a loose rule, not an atom.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  let kf = CSS.Types.AnimationName.make("keyframe-m6pt8e");

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  let kf = CSS.Types.AnimationName.make("keyframe-m6pt8e");
