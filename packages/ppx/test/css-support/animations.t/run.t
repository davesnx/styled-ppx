This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css ".css-1yyuph8{-webkit-animation-name:random;animation-name:random;}"];
  [@css ".css-zv96c6{-webkit-animation-name:foo, bar;animation-name:foo, bar;}"];
  [@css
    ".css-1tdc8ex{-webkit-animation-name:var(--1tdc8ex-0);animation-name:var(--1tdc8ex-0);}"
  ];
  [@css
    ".css-1asvpqo{-webkit-animation-name:var(--1asvpqo-0), var(--1asvpqo-1);animation-name:var(--1asvpqo-0), var(--1asvpqo-1);}"
  ];
  [@css ".css-1a5thea{-webkit-animation-duration:0s;animation-duration:0s;}"];
  [@css ".css-6dcnnr{-webkit-animation-duration:1s;animation-duration:1s;}"];
  [@css
    ".css-hsoab6{-webkit-animation-duration:100ms;animation-duration:100ms;}"
  ];
  [@css
    ".css-858zyu{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}"
  ];
  [@css
    ".css-1dw46oy{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}"
  ];
  [@css
    ".css-1goa5jk{-webkit-animation-timing-function:ease;animation-timing-function:ease;}"
  ];
  [@css
    ".css-h5tmym{-webkit-animation-timing-function:linear;animation-timing-function:linear;}"
  ];
  [@css
    ".css-11tfmb{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}"
  ];
  [@css
    ".css-alb15b{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}"
  ];
  [@css
    ".css-90t7gp{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}"
  ];
  [@css
    ".css-1cfvrjy{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-jto2jo{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css
    ".css-a4im7i{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}"
  ];
  [@css
    ".css-1dedy68{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}"
  ];
  [@css
    ".css-k4lygq{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}"
  ];
  [@css
    ".css-13re77f{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}"
  ];
  [@css
    ".css-2mz50h{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css
    ".css-12bmrx5{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".css-6yo346{-webkit-animation-iteration-count:8;animation-iteration-count:8;}"
  ];
  [@css
    ".css-1m1yzkn{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}"
  ];
  [@css
    ".css-1ntbni1{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}"
  ];
  [@css
    ".css-31dqjv{-webkit-animation-direction:normal;animation-direction:normal;}"
  ];
  [@css
    ".css-2j9lee{-webkit-animation-direction:alternate;animation-direction:alternate;}"
  ];
  [@css
    ".css-7mwgzq{-webkit-animation-direction:reverse;animation-direction:reverse;}"
  ];
  [@css
    ".css-15f7x5r{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}"
  ];
  [@css
    ".css-1okwqbn{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}"
  ];
  [@css
    ".css-ksyny9{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}"
  ];
  [@css
    ".css-1v4q63o{-webkit-animation-play-state:running;animation-play-state:running;}"
  ];
  [@css
    ".css-vaxj99{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-gikvxb{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}"
  ];
  [@css ".css-t90v2t{-webkit-animation-delay:1s;animation-delay:1s;}"];
  [@css ".css-1j1142z{-webkit-animation-delay:-1s;animation-delay:-1s;}"];
  [@css
    ".css-1h8hg8l{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}"
  ];
  [@css
    ".css-nj6jog{-webkit-animation-fill-mode:none;animation-fill-mode:none;}"
  ];
  [@css
    ".css-12488ed{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}"
  ];
  [@css
    ".css-ckcrfv{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}"
  ];
  [@css
    ".css-kj5qnd{-webkit-animation-fill-mode:both;animation-fill-mode:both;}"
  ];
  [@css
    ".css-i8dbgf{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}"
  ];
  [@css
    ".css-arxlq7{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}"
  ];
  [@css
    ".css-1icjvqx{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}"
  ];
  [@css
    ".css-hsf1gr{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  [@css
    "@keyframes keyframe-1n426j4{0%{height:var(--135wur0);}100%{height:var(--18ewl8i);}}"
  ];
  [@css
    ".css-dxr7gs{-webkit-animation-name:var(--dxr7gs-0);animation-name:var(--dxr7gs-0);}"
  ];
  [@css
    ".css-1w6ap1g{-webkit-animation:var(--1w6ap1g-0) 180ms ease-out 0s 1 normal both;animation:var(--1w6ap1g-0) 180ms ease-out 0s 1 normal both;}"
  ];
  [@css.classes
    [
      ("css-1yyuph8", 1, "", "input.re", 5, 8, 5, 30),
      ("css-zv96c6", 2, "", "input.re", 6, 8, 6, 32),
      ("css-1tdc8ex", 3, "", "input.re", 7, 8, 7, 30),
      ("css-1asvpqo", 4, "", "input.re", 8, 8, 8, 38),
      ("css-1a5thea", 5, "", "input.re", 9, 8, 9, 30),
      ("css-6dcnnr", 6, "", "input.re", 10, 8, 10, 30),
      ("css-hsoab6", 7, "", "input.re", 11, 8, 11, 33),
      ("css-858zyu", 8, "", "input.re", 12, 8, 12, 41),
      ("css-1dw46oy", 9, "", "input.re", 13, 8, 13, 43),
      ("css-1goa5jk", 10, "", "input.re", 14, 8, 14, 39),
      ("css-h5tmym", 11, "", "input.re", 15, 8, 15, 41),
      ("css-11tfmb", 12, "", "input.re", 16, 8, 16, 42),
      ("css-alb15b", 13, "", "input.re", 17, 8, 17, 43),
      ("css-90t7gp", 14, "", "input.re", 18, 8, 18, 46),
      ("css-1cfvrjy", 15, "", "input.re", 19, 8, 19, 63),
      ("css-jto2jo", 16, "", "input.re", 20, 8, 20, 66),
      ("css-a4im7i", 17, "", "input.re", 21, 8, 21, 45),
      ("css-1dedy68", 18, "", "input.re", 22, 8, 22, 43),
      ("css-k4lygq", 19, "", "input.re", 23, 8, 23, 50),
      ("css-13re77f", 20, "", "input.re", 24, 8, 24, 48),
      ("css-2mz50h", 21, "", "input.re", 26, 4, 26, 79),
      ("css-12bmrx5", 22, "", "input.re", 28, 8, 28, 43),
      ("css-6yo346", 23, "", "input.re", 29, 8, 29, 36),
      ("css-1m1yzkn", 24, "", "input.re", 30, 8, 30, 39),
      ("css-1ntbni1", 25, "", "input.re", 31, 8, 31, 49),
      ("css-31dqjv", 26, "", "input.re", 32, 8, 32, 35),
      ("css-2j9lee", 27, "", "input.re", 33, 8, 33, 38),
      ("css-7mwgzq", 28, "", "input.re", 34, 8, 34, 36),
      ("css-15f7x5r", 29, "", "input.re", 35, 8, 35, 46),
      ("css-1okwqbn", 30, "", "input.re", 36, 8, 36, 44),
      ("css-ksyny9", 31, "", "input.re", 37, 8, 37, 55),
      ("css-1v4q63o", 32, "", "input.re", 38, 8, 38, 37),
      ("css-vaxj99", 33, "", "input.re", 39, 8, 39, 36),
      ("css-gikvxb", 34, "", "input.re", 40, 8, 40, 54),
      ("css-t90v2t", 35, "", "input.re", 41, 8, 41, 27),
      ("css-1j1142z", 36, "", "input.re", 42, 8, 42, 28),
      ("css-1h8hg8l", 37, "", "input.re", 43, 8, 43, 36),
      ("css-nj6jog", 38, "", "input.re", 44, 8, 44, 33),
      ("css-12488ed", 39, "", "input.re", 45, 8, 45, 37),
      ("css-ckcrfv", 40, "", "input.re", 46, 8, 46, 38),
      ("css-kj5qnd", 41, "", "input.re", 47, 8, 47, 33),
      ("css-i8dbgf", 42, "", "input.re", 48, 8, 48, 49),
      ("css-arxlq7", 43, "", "input.re", 49, 8, 49, 59),
      ("css-1icjvqx", 44, "", "input.re", 50, 7, 50, 60),
      ("css-hsf1gr", 45, "", "input.re", 51, 7, 51, 72),
      ("css-dxr7gs", 47, "", "input.re", 66, 8, 66, 33),
      ("css-1w6ap1g", 48, "", "input.re", 67, 8, 67, 60),
    ]
  ];
  let foo = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  let bar = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  
  CSS.make("css-1yyuph8", []);
  CSS.make("css-zv96c6", []);
  CSS.make(
    "css-1tdc8ex",
    CSS.Types.AnimationName.toStyleVars("--1tdc8ex-0", foo),
  );
  CSS.make(
    "css-1asvpqo",
    CSS.Types.AnimationName.toStyleVars("--1asvpqo-0", foo)
    @ CSS.Types.AnimationName.toStyleVars("--1asvpqo-1", bar),
  );
  CSS.make("css-1a5thea", []);
  CSS.make("css-6dcnnr", []);
  CSS.make("css-hsoab6", []);
  CSS.make("css-858zyu", []);
  CSS.make("css-1dw46oy", []);
  CSS.make("css-1goa5jk", []);
  CSS.make("css-h5tmym", []);
  CSS.make("css-11tfmb", []);
  CSS.make("css-alb15b", []);
  CSS.make("css-90t7gp", []);
  CSS.make("css-1cfvrjy", []);
  CSS.make("css-jto2jo", []);
  CSS.make("css-a4im7i", []);
  CSS.make("css-1dedy68", []);
  CSS.make("css-k4lygq", []);
  CSS.make("css-13re77f", []);
  CSS.make("css-2mz50h", []);
  CSS.make("css-12bmrx5", []);
  CSS.make("css-6yo346", []);
  CSS.make("css-1m1yzkn", []);
  CSS.make("css-1ntbni1", []);
  CSS.make("css-31dqjv", []);
  CSS.make("css-2j9lee", []);
  CSS.make("css-7mwgzq", []);
  CSS.make("css-15f7x5r", []);
  CSS.make("css-1okwqbn", []);
  CSS.make("css-ksyny9", []);
  CSS.make("css-1v4q63o", []);
  CSS.make("css-vaxj99", []);
  CSS.make("css-gikvxb", []);
  CSS.make("css-t90v2t", []);
  CSS.make("css-1j1142z", []);
  CSS.make("css-1h8hg8l", []);
  CSS.make("css-nj6jog", []);
  CSS.make("css-12488ed", []);
  CSS.make("css-ckcrfv", []);
  CSS.make("css-kj5qnd", []);
  CSS.make("css-i8dbgf", []);
  CSS.make("css-arxlq7", []);
  CSS.make("css-1icjvqx", []);
  CSS.make("css-hsf1gr", []);
  
  let previousHeight = 20;
  let currentHeight = 80;
  let previous = `px(previousHeight);
  let current = `px(currentHeight);
  let resize =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--135wur0", CSS.Types.Height.toString(previous)),
        ("--18ewl8i", CSS.Types.Height.toString(current)),
      ],
      "keyframe-1n426j4",
    );
  
  CSS.make(
    "css-dxr7gs",
    CSS.Types.AnimationName.toStyleVars("--dxr7gs-0", resize),
  );
  CSS.make(
    "css-1w6ap1g",
    CSS.Types.AnimationName.toStyleVars("--1w6ap1g-0", resize),
  );
