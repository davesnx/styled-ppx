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
  [@css ".css-ivpcph8{-webkit-animation-name:random;animation-name:random;}"];
  [@css
    ".css-ivpc6c6{-webkit-animation-name:foo, bar;animation-name:foo, bar;}"
  ];
  [@css
    ".css-ivpcsyi{-webkit-animation-name:var(--ivpcbs9);animation-name:var(--ivpcbs9);}"
  ];
  [@css
    ".css-ivpcmkt{-webkit-animation-name:var(--ivpcqra), var(--ivpcjki);animation-name:var(--ivpcqra), var(--ivpcjki);}"
  ];
  [@css ".css-ivpchea{-webkit-animation-duration:0s;animation-duration:0s;}"];
  [@css ".css-ivpcnnr{-webkit-animation-duration:1s;animation-duration:1s;}"];
  [@css
    ".css-ivpcab6{-webkit-animation-duration:100ms;animation-duration:100ms;}"
  ];
  [@css
    ".css-ivpczyu{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}"
  ];
  [@css
    ".css-ivpc6oy{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}"
  ];
  [@css
    ".css-ivpc5jk{-webkit-animation-timing-function:ease;animation-timing-function:ease;}"
  ];
  [@css
    ".css-ivpcmym{-webkit-animation-timing-function:linear;animation-timing-function:linear;}"
  ];
  [@css
    ".css-ivpcfmb{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}"
  ];
  [@css
    ".css-ivpc15b{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}"
  ];
  [@css
    ".css-ivpc7gp{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}"
  ];
  [@css
    ".css-ivpcrjy{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-ivpc2jo{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css
    ".css-ivpcm7i{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}"
  ];
  [@css
    ".css-ivpcy68{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}"
  ];
  [@css
    ".css-ivpcygq{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}"
  ];
  [@css
    ".css-ivpc77f{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}"
  ];
  [@css
    ".css-ivpc50h{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css
    ".css-ivpcrx5{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".css-ivpc346{-webkit-animation-iteration-count:8;animation-iteration-count:8;}"
  ];
  [@css
    ".css-ivpczkn{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}"
  ];
  [@css
    ".css-ivpcni1{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}"
  ];
  [@css
    ".css-ivpcqjv{-webkit-animation-direction:normal;animation-direction:normal;}"
  ];
  [@css
    ".css-ivpclee{-webkit-animation-direction:alternate;animation-direction:alternate;}"
  ];
  [@css
    ".css-ivpcgzq{-webkit-animation-direction:reverse;animation-direction:reverse;}"
  ];
  [@css
    ".css-ivpcx5r{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}"
  ];
  [@css
    ".css-ivpcqbn{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}"
  ];
  [@css
    ".css-ivpcny9{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}"
  ];
  [@css
    ".css-ivpc63o{-webkit-animation-play-state:running;animation-play-state:running;}"
  ];
  [@css
    ".css-ivpcj99{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-ivpcvxb{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}"
  ];
  [@css ".css-ivpcv2t{-webkit-animation-delay:1s;animation-delay:1s;}"];
  [@css ".css-ivpc42z{-webkit-animation-delay:-1s;animation-delay:-1s;}"];
  [@css
    ".css-ivpcg8l{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}"
  ];
  [@css
    ".css-ivpcjog{-webkit-animation-fill-mode:none;animation-fill-mode:none;}"
  ];
  [@css
    ".css-ivpc8ed{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}"
  ];
  [@css
    ".css-ivpcrfv{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}"
  ];
  [@css
    ".css-ivpcqnd{-webkit-animation-fill-mode:both;animation-fill-mode:both;}"
  ];
  [@css
    ".css-ivpcbgf{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}"
  ];
  [@css
    ".css-ivpclq7{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}"
  ];
  [@css
    ".css-ivpcvqx{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}"
  ];
  [@css
    ".css-ivpc1gr{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  [@css
    "@keyframes keyframe-kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css
    ".css-ivpctgd{-webkit-animation-name:var(--ivpcsp7);animation-name:var(--ivpcsp7);}"
  ];
  [@css
    ".css-ivpcgsq{-webkit-animation:var(--ivpcn88) 180ms ease-out 0s 1 normal both;animation:var(--ivpcn88) 180ms ease-out 0s 1 normal both;}"
  ];
  [@css.classes
    [
      ("css-ivpcph8", 1, "", "input.re", 5, 8, 5, 30),
      ("css-ivpc6c6", 2, "", "input.re", 6, 8, 6, 32),
      ("css-ivpcsyi", 3, "", "input.re", 7, 8, 7, 30),
      ("css-ivpcmkt", 4, "", "input.re", 8, 8, 8, 38),
      ("css-ivpchea", 5, "", "input.re", 9, 8, 9, 30),
      ("css-ivpcnnr", 6, "", "input.re", 10, 8, 10, 30),
      ("css-ivpcab6", 7, "", "input.re", 11, 8, 11, 33),
      ("css-ivpczyu", 8, "", "input.re", 12, 8, 12, 41),
      ("css-ivpc6oy", 9, "", "input.re", 13, 8, 13, 43),
      ("css-ivpc5jk", 10, "", "input.re", 14, 8, 14, 39),
      ("css-ivpcmym", 11, "", "input.re", 15, 8, 15, 41),
      ("css-ivpcfmb", 12, "", "input.re", 16, 8, 16, 42),
      ("css-ivpc15b", 13, "", "input.re", 17, 8, 17, 43),
      ("css-ivpc7gp", 14, "", "input.re", 18, 8, 18, 46),
      ("css-ivpcrjy", 15, "", "input.re", 19, 8, 19, 63),
      ("css-ivpc2jo", 16, "", "input.re", 20, 8, 20, 66),
      ("css-ivpcm7i", 17, "", "input.re", 21, 8, 21, 45),
      ("css-ivpcy68", 18, "", "input.re", 22, 8, 22, 43),
      ("css-ivpcygq", 19, "", "input.re", 23, 8, 23, 50),
      ("css-ivpc77f", 20, "", "input.re", 24, 8, 24, 48),
      ("css-ivpc50h", 21, "", "input.re", 26, 4, 26, 79),
      ("css-ivpcrx5", 22, "", "input.re", 28, 8, 28, 43),
      ("css-ivpc346", 23, "", "input.re", 29, 8, 29, 36),
      ("css-ivpczkn", 24, "", "input.re", 30, 8, 30, 39),
      ("css-ivpcni1", 25, "", "input.re", 31, 8, 31, 49),
      ("css-ivpcqjv", 26, "", "input.re", 32, 8, 32, 35),
      ("css-ivpclee", 27, "", "input.re", 33, 8, 33, 38),
      ("css-ivpcgzq", 28, "", "input.re", 34, 8, 34, 36),
      ("css-ivpcx5r", 29, "", "input.re", 35, 8, 35, 46),
      ("css-ivpcqbn", 30, "", "input.re", 36, 8, 36, 44),
      ("css-ivpcny9", 31, "", "input.re", 37, 8, 37, 55),
      ("css-ivpc63o", 32, "", "input.re", 38, 8, 38, 37),
      ("css-ivpcj99", 33, "", "input.re", 39, 8, 39, 36),
      ("css-ivpcvxb", 34, "", "input.re", 40, 8, 40, 54),
      ("css-ivpcv2t", 35, "", "input.re", 41, 8, 41, 27),
      ("css-ivpc42z", 36, "", "input.re", 42, 8, 42, 28),
      ("css-ivpcg8l", 37, "", "input.re", 43, 8, 43, 36),
      ("css-ivpcjog", 38, "", "input.re", 44, 8, 44, 33),
      ("css-ivpc8ed", 39, "", "input.re", 45, 8, 45, 37),
      ("css-ivpcrfv", 40, "", "input.re", 46, 8, 46, 38),
      ("css-ivpcqnd", 41, "", "input.re", 47, 8, 47, 33),
      ("css-ivpcbgf", 42, "", "input.re", 48, 8, 48, 49),
      ("css-ivpclq7", 43, "", "input.re", 49, 8, 49, 59),
      ("css-ivpcvqx", 44, "", "input.re", 50, 7, 50, 60),
      ("css-ivpc1gr", 45, "", "input.re", 51, 7, 51, 72),
      ("css-ivpctgd", 47, "", "input.re", 66, 8, 66, 33),
      ("css-ivpcgsq", 48, "", "input.re", 67, 8, 67, 60),
    ]
  ];
  let foo = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  let bar = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  
  CSS.make("css-ivpcph8", []);
  CSS.make("css-ivpc6c6", []);
  CSS.make(
    "css-ivpcsyi",
    CSS.Types.AnimationName.toStyleVars("--ivpcbs9", foo),
  );
  CSS.make(
    "css-ivpcmkt",
    CSS.Types.AnimationName.toStyleVars("--ivpcqra", foo)
    @ CSS.Types.AnimationName.toStyleVars("--ivpcjki", bar),
  );
  CSS.make("css-ivpchea", []);
  CSS.make("css-ivpcnnr", []);
  CSS.make("css-ivpcab6", []);
  CSS.make("css-ivpczyu", []);
  CSS.make("css-ivpc6oy", []);
  CSS.make("css-ivpc5jk", []);
  CSS.make("css-ivpcmym", []);
  CSS.make("css-ivpcfmb", []);
  CSS.make("css-ivpc15b", []);
  CSS.make("css-ivpc7gp", []);
  CSS.make("css-ivpcrjy", []);
  CSS.make("css-ivpc2jo", []);
  CSS.make("css-ivpcm7i", []);
  CSS.make("css-ivpcy68", []);
  CSS.make("css-ivpcygq", []);
  CSS.make("css-ivpc77f", []);
  CSS.make("css-ivpc50h", []);
  CSS.make("css-ivpcrx5", []);
  CSS.make("css-ivpc346", []);
  CSS.make("css-ivpczkn", []);
  CSS.make("css-ivpcni1", []);
  CSS.make("css-ivpcqjv", []);
  CSS.make("css-ivpclee", []);
  CSS.make("css-ivpcgzq", []);
  CSS.make("css-ivpcx5r", []);
  CSS.make("css-ivpcqbn", []);
  CSS.make("css-ivpcny9", []);
  CSS.make("css-ivpc63o", []);
  CSS.make("css-ivpcj99", []);
  CSS.make("css-ivpcvxb", []);
  CSS.make("css-ivpcv2t", []);
  CSS.make("css-ivpc42z", []);
  CSS.make("css-ivpcg8l", []);
  CSS.make("css-ivpcjog", []);
  CSS.make("css-ivpc8ed", []);
  CSS.make("css-ivpcrfv", []);
  CSS.make("css-ivpcqnd", []);
  CSS.make("css-ivpcbgf", []);
  CSS.make("css-ivpclq7", []);
  CSS.make("css-ivpcvqx", []);
  CSS.make("css-ivpc1gr", []);
  
  let previousHeight = 20;
  let currentHeight = 80;
  let previous = `px(previousHeight);
  let current = `px(currentHeight);
  let resize =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--previous-135wur0", CSS.Types.Height.toString(previous)),
        ("--current-18ewl8i", CSS.Types.Height.toString(current)),
      ],
      "keyframe-kuv9ix",
    );
  
  CSS.make(
    "css-ivpctgd",
    CSS.Types.AnimationName.toStyleVars("--ivpcsp7", resize),
  );
  CSS.make(
    "css-ivpcgsq",
    CSS.Types.AnimationName.toStyleVars("--ivpcn88", resize),
  );
