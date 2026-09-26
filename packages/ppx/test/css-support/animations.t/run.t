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
  [@css ".a-2z01s9u50{-webkit-animation-name:random;animation-name:random;}"];
  [@css
    ".a-2z01sdu2s{-webkit-animation-name:foo, bar;animation-name:foo, bar;}"
  ];
  [@css
    ".a-2z01sbkch{-webkit-animation-name:var(--foo-ucoxjj);animation-name:var(--foo-ucoxjj);}"
  ];
  [@css
    ".a-2z01sfqed{-webkit-animation-name:var(--foo-qnewyj), var(--bar-1nj9014);animation-name:var(--foo-qnewyj), var(--bar-1nj9014);}"
  ];
  [@css ".a-2z008nfq1{-webkit-animation-duration:0s;animation-duration:0s;}"];
  [@css ".a-2z008iaw8{-webkit-animation-duration:1s;animation-duration:1s;}"];
  [@css
    ".a-2z008wveq{-webkit-animation-duration:100ms;animation-duration:100ms;}"
  ];
  [@css
    ".a-2z008tj8j{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}"
  ];
  [@css
    ".a-2z008oaxk{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}"
  ];
  [@css
    ".a-2z1kwt0tu{-webkit-animation-timing-function:ease;animation-timing-function:ease;}"
  ];
  [@css
    ".a-2z1kwwp0a{-webkit-animation-timing-function:linear;animation-timing-function:linear;}"
  ];
  [@css
    ".a-2z1kwviul{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}"
  ];
  [@css
    ".a-2z1kwf3zo{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}"
  ];
  [@css
    ".a-2z1kwa72f{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}"
  ];
  [@css
    ".a-2z1kw4e4x{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".a-2z1kwf1tj{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css
    ".a-2z1kw6j52{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}"
  ];
  [@css
    ".a-2z1kww8e9{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}"
  ];
  [@css
    ".a-2z1kwl2sx{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}"
  ];
  [@css
    ".a-2z1kwldx6{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}"
  ];
  [@css
    ".a-2z1kwlnxf{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css
    ".a-2z00w8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".a-2z00wslxe{-webkit-animation-iteration-count:8;animation-iteration-count:8;}"
  ];
  [@css
    ".a-2z00wgpcx{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}"
  ];
  [@css
    ".a-2z00wnpot{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}"
  ];
  [@css
    ".a-2z004jqic{-webkit-animation-direction:normal;animation-direction:normal;}"
  ];
  [@css
    ".a-2z004i1sk{-webkit-animation-direction:alternate;animation-direction:alternate;}"
  ];
  [@css
    ".a-2z0046c5b{-webkit-animation-direction:reverse;animation-direction:reverse;}"
  ];
  [@css
    ".a-2z0045c2u{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}"
  ];
  [@css
    ".a-2z0042f1p{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}"
  ];
  [@css
    ".a-2z0045ztj{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}"
  ];
  [@css
    ".a-2z03kr8bj{-webkit-animation-play-state:running;animation-play-state:running;}"
  ];
  [@css
    ".a-2z03kbnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".a-2z03kgcqk{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}"
  ];
  [@css ".a-2z002dlyv{-webkit-animation-delay:1s;animation-delay:1s;}"];
  [@css ".a-2z0026y00{-webkit-animation-delay:-1s;animation-delay:-1s;}"];
  [@css
    ".a-2z0022h4y{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}"
  ];
  [@css
    ".a-2z00gy95r{-webkit-animation-fill-mode:none;animation-fill-mode:none;}"
  ];
  [@css
    ".a-2z00gnmjc{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}"
  ];
  [@css
    ".a-2z00g5fpo{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}"
  ];
  [@css
    ".a-2z00gvuyg{-webkit-animation-fill-mode:both;animation-fill-mode:both;}"
  ];
  [@css
    ".a-2z00gr2w3{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}"
  ];
  [@css
    ".a-2zhgs5{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}"
  ];
  [@css
    ".a-2z1me1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}"
  ];
  [@css
    ".a-2z9gym{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  [@css
    "@keyframes k-kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css
    ".a-2z01sbkao{-webkit-animation-name:var(--resize-1jz21hk);animation-name:var(--resize-1jz21hk);}"
  ];
  [@css
    ".a-2z7afk{-webkit-animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;}"
  ];
  let foo = CSS.Types.AnimationName.make("k-m6pt8e");
  let bar = CSS.Types.AnimationName.make("k-m6pt8e");
  
  CSS.make("a-2z01s9u50", []);
  CSS.make("a-2z01sdu2s", []);
  CSS.make(
    "a-2z01sbkch",
    CSS.Types.AnimationName.toStyleVars("--foo-ucoxjj", foo),
  );
  CSS.make(
    "a-2z01sfqed",
    CSS.Types.AnimationName.toStyleVars("--foo-qnewyj", foo)
    @ CSS.Types.AnimationName.toStyleVars("--bar-1nj9014", bar),
  );
  CSS.make("a-2z008nfq1", []);
  CSS.make("a-2z008iaw8", []);
  CSS.make("a-2z008wveq", []);
  CSS.make("a-2z008tj8j", []);
  CSS.make("a-2z008oaxk", []);
  CSS.make("a-2z1kwt0tu", []);
  CSS.make("a-2z1kwwp0a", []);
  CSS.make("a-2z1kwviul", []);
  CSS.make("a-2z1kwf3zo", []);
  CSS.make("a-2z1kwa72f", []);
  CSS.make("a-2z1kw4e4x", []);
  CSS.make("a-2z1kwf1tj", []);
  CSS.make("a-2z1kw6j52", []);
  CSS.make("a-2z1kww8e9", []);
  CSS.make("a-2z1kwl2sx", []);
  CSS.make("a-2z1kwldx6", []);
  CSS.make("a-2z1kwlnxf", []);
  CSS.make("a-2z00w8nyb", []);
  CSS.make("a-2z00wslxe", []);
  CSS.make("a-2z00wgpcx", []);
  CSS.make("a-2z00wnpot", []);
  CSS.make("a-2z004jqic", []);
  CSS.make("a-2z004i1sk", []);
  CSS.make("a-2z0046c5b", []);
  CSS.make("a-2z0045c2u", []);
  CSS.make("a-2z0042f1p", []);
  CSS.make("a-2z0045ztj", []);
  CSS.make("a-2z03kr8bj", []);
  CSS.make("a-2z03kbnre", []);
  CSS.make("a-2z03kgcqk", []);
  CSS.make("a-2z002dlyv", []);
  CSS.make("a-2z0026y00", []);
  CSS.make("a-2z0022h4y", []);
  CSS.make("a-2z00gy95r", []);
  CSS.make("a-2z00gnmjc", []);
  CSS.make("a-2z00g5fpo", []);
  CSS.make("a-2z00gvuyg", []);
  CSS.make("a-2z00gr2w3", []);
  CSS.make("a-2zhgs5", []);
  CSS.make("a-2z1me1", []);
  CSS.make("a-2z9gym", []);
  
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
    "a-2z01sbkao",
    CSS.Types.AnimationName.toStyleVars("--resize-1jz21hk", resize),
  );
  CSS.make(
    "a-2z7afk",
    CSS.Types.AnimationName.toStyleVars("--resize-1aiquq7", resize),
  );
