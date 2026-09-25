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
  [@css "@keyframes k-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css ".a-13g9u50{-webkit-animation-name:random;animation-name:random;}"];
  [@css ".a-1b4du2s{-webkit-animation-name:foo, bar;animation-name:foo, bar;}"];
  [@css
    ".in-ixbkch{-webkit-animation-name:var(--foo-ucoxjj);animation-name:var(--foo-ucoxjj);}"
  ];
  [@css
    ".in-bcfqed{-webkit-animation-name:var(--foo-qnewyj), var(--bar-1nj9014);animation-name:var(--foo-qnewyj), var(--bar-1nj9014);}"
  ];
  [@css ".a-k2nfq1{-webkit-animation-duration:0s;animation-duration:0s;}"];
  [@css ".a-kniaw8{-webkit-animation-duration:1s;animation-duration:1s;}"];
  [@css ".a-2rwveq{-webkit-animation-duration:100ms;animation-duration:100ms;}"];
  [@css
    ".a-15rtj8j{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}"
  ];
  [@css
    ".a-1ehoaxk{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}"
  ];
  [@css
    ".a-1qgt0tu{-webkit-animation-timing-function:ease;animation-timing-function:ease;}"
  ];
  [@css
    ".a-1lywp0a{-webkit-animation-timing-function:linear;animation-timing-function:linear;}"
  ];
  [@css
    ".a-1hyviul{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}"
  ];
  [@css
    ".a-3wf3zo{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}"
  ];
  [@css
    ".a-3pa72f{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}"
  ];
  [@css
    ".a-17l4e4x{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".a-ktf1tj{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css
    ".a-l6j52{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}"
  ];
  [@css
    ".a-c4w8e9{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}"
  ];
  [@css
    ".a-1stl2sx{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}"
  ];
  [@css
    ".a-11mldx6{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}"
  ];
  [@css
    ".a-1x6lnxf{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css
    ".a-17p8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".a-18cslxe{-webkit-animation-iteration-count:8;animation-iteration-count:8;}"
  ];
  [@css
    ".a-1rrgpcx{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}"
  ];
  [@css
    ".a-13pnpot{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}"
  ];
  [@css
    ".a-iqjqic{-webkit-animation-direction:normal;animation-direction:normal;}"
  ];
  [@css
    ".a-1dji1sk{-webkit-animation-direction:alternate;animation-direction:alternate;}"
  ];
  [@css
    ".a-1ah6c5b{-webkit-animation-direction:reverse;animation-direction:reverse;}"
  ];
  [@css
    ".a-6b5c2u{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}"
  ];
  [@css
    ".a-qf2f1p{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}"
  ];
  [@css
    ".a-yl5ztj{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}"
  ];
  [@css
    ".a-1x3r8bj{-webkit-animation-play-state:running;animation-play-state:running;}"
  ];
  [@css
    ".a-1i5bnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".a-1ejgcqk{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}"
  ];
  [@css ".a-lndlyv{-webkit-animation-delay:1s;animation-delay:1s;}"];
  [@css ".a-5q6y00{-webkit-animation-delay:-1s;animation-delay:-1s;}"];
  [@css
    ".a-vz2h4y{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}"
  ];
  [@css ".a-kjy95r{-webkit-animation-fill-mode:none;animation-fill-mode:none;}"];
  [@css
    ".a-144nmjc{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}"
  ];
  [@css
    ".a-1wl5fpo{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}"
  ];
  [@css ".a-iovuyg{-webkit-animation-fill-mode:both;animation-fill-mode:both;}"];
  [@css
    ".a-rar2w3{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}"
  ];
  [@css
    ".a-bshgs5{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}"
  ];
  [@css
    ".a-1jo1me1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}"
  ];
  [@css
    ".a-1e29gym{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  [@css
    "@keyframes k-kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css
    ".in-1h7bkao{-webkit-animation-name:var(--resize-1jz21hk);animation-name:var(--resize-1jz21hk);}"
  ];
  [@css
    ".in-1bi7afk{-webkit-animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;}"
  ];
  let foo = CSS.Types.AnimationName.make("k-m6pt8e");
  let bar = CSS.Types.AnimationName.make("k-m6pt8e");
  
  CSS.make("a-13g9u50", []);
  CSS.make("a-1b4du2s", []);
  CSS.make(
    "in-ixbkch",
    CSS.Types.AnimationName.toStyleVars("--foo-ucoxjj", foo),
  );
  CSS.make(
    "in-bcfqed",
    CSS.Types.AnimationName.toStyleVars("--foo-qnewyj", foo)
    @ CSS.Types.AnimationName.toStyleVars("--bar-1nj9014", bar),
  );
  CSS.make("a-k2nfq1", []);
  CSS.make("a-kniaw8", []);
  CSS.make("a-2rwveq", []);
  CSS.make("a-15rtj8j", []);
  CSS.make("a-1ehoaxk", []);
  CSS.make("a-1qgt0tu", []);
  CSS.make("a-1lywp0a", []);
  CSS.make("a-1hyviul", []);
  CSS.make("a-3wf3zo", []);
  CSS.make("a-3pa72f", []);
  CSS.make("a-17l4e4x", []);
  CSS.make("a-ktf1tj", []);
  CSS.make("a-l6j52", []);
  CSS.make("a-c4w8e9", []);
  CSS.make("a-1stl2sx", []);
  CSS.make("a-11mldx6", []);
  CSS.make("a-1x6lnxf", []);
  CSS.make("a-17p8nyb", []);
  CSS.make("a-18cslxe", []);
  CSS.make("a-1rrgpcx", []);
  CSS.make("a-13pnpot", []);
  CSS.make("a-iqjqic", []);
  CSS.make("a-1dji1sk", []);
  CSS.make("a-1ah6c5b", []);
  CSS.make("a-6b5c2u", []);
  CSS.make("a-qf2f1p", []);
  CSS.make("a-yl5ztj", []);
  CSS.make("a-1x3r8bj", []);
  CSS.make("a-1i5bnre", []);
  CSS.make("a-1ejgcqk", []);
  CSS.make("a-lndlyv", []);
  CSS.make("a-5q6y00", []);
  CSS.make("a-vz2h4y", []);
  CSS.make("a-kjy95r", []);
  CSS.make("a-144nmjc", []);
  CSS.make("a-1wl5fpo", []);
  CSS.make("a-iovuyg", []);
  CSS.make("a-rar2w3", []);
  CSS.make("a-bshgs5", []);
  CSS.make("a-1jo1me1", []);
  CSS.make("a-1e29gym", []);
  
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
      "k-kuv9ix",
    );
  
  CSS.make(
    "in-1h7bkao",
    CSS.Types.AnimationName.toStyleVars("--resize-1jz21hk", resize),
  );
  CSS.make(
    "in-1bi7afk",
    CSS.Types.AnimationName.toStyleVars("--resize-1aiquq7", resize),
  );
