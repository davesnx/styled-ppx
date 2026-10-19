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
  [@css "@keyframes _k_m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css "._a_2z001s9u50{-webkit-animation-name:random;animation-name:random;}"];
  [@css
    "._a_2z001sdu2s{-webkit-animation-name:foo, bar;animation-name:foo, bar;}"
  ];
  [@css
    "._a_2z001sbkch{-webkit-animation-name:var(--foo-ucoxjj);animation-name:var(--foo-ucoxjj);}"
  ];
  [@css
    "._a_2z001sfqed{-webkit-animation-name:var(--foo-qnewyj), var(--bar-1nj9014);animation-name:var(--foo-qnewyj), var(--bar-1nj9014);}"
  ];
  [@css "._a_2z0008nfq1{-webkit-animation-duration:0s;animation-duration:0s;}"];
  [@css "._a_2z0008iaw8{-webkit-animation-duration:1s;animation-duration:1s;}"];
  [@css
    "._a_2z0008wveq{-webkit-animation-duration:100ms;animation-duration:100ms;}"
  ];
  [@css
    "._a_2z0008tj8j{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}"
  ];
  [@css
    "._a_2z0008oaxk{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}"
  ];
  [@css
    "._a_2z01kwt0tu{-webkit-animation-timing-function:ease;animation-timing-function:ease;}"
  ];
  [@css
    "._a_2z01kwwp0a{-webkit-animation-timing-function:linear;animation-timing-function:linear;}"
  ];
  [@css
    "._a_2z01kwviul{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}"
  ];
  [@css
    "._a_2z01kwf3zo{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}"
  ];
  [@css
    "._a_2z01kwa72f{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}"
  ];
  [@css
    "._a_2z01kw4e4x{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    "._a_2z01kwf1tj{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css
    "._a_2z01kw6j52{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}"
  ];
  [@css
    "._a_2z01kww8e9{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}"
  ];
  [@css
    "._a_2z01kwl2sx{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}"
  ];
  [@css
    "._a_2z01kwldx6{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}"
  ];
  [@css
    "._a_2z01kwlnxf{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css
    "._a_2z000w8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    "._a_2z000wslxe{-webkit-animation-iteration-count:8;animation-iteration-count:8;}"
  ];
  [@css
    "._a_2z000wgpcx{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}"
  ];
  [@css
    "._a_2z000wnpot{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}"
  ];
  [@css
    "._a_2z0004jqic{-webkit-animation-direction:normal;animation-direction:normal;}"
  ];
  [@css
    "._a_2z0004i1sk{-webkit-animation-direction:alternate;animation-direction:alternate;}"
  ];
  [@css
    "._a_2z00046c5b{-webkit-animation-direction:reverse;animation-direction:reverse;}"
  ];
  [@css
    "._a_2z00045c2u{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}"
  ];
  [@css
    "._a_2z00042f1p{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}"
  ];
  [@css
    "._a_2z00045ztj{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}"
  ];
  [@css
    "._a_2z003kr8bj{-webkit-animation-play-state:running;animation-play-state:running;}"
  ];
  [@css
    "._a_2z003kbnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    "._a_2z003kgcqk{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}"
  ];
  [@css "._a_2z0002dlyv{-webkit-animation-delay:1s;animation-delay:1s;}"];
  [@css "._a_2z00026y00{-webkit-animation-delay:-1s;animation-delay:-1s;}"];
  [@css
    "._a_2z00022h4y{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}"
  ];
  [@css
    "._a_2z000gy95r{-webkit-animation-fill-mode:none;animation-fill-mode:none;}"
  ];
  [@css
    "._a_2z000gnmjc{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}"
  ];
  [@css
    "._a_2z000g5fpo{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}"
  ];
  [@css
    "._a_2z000gvuyg{-webkit-animation-fill-mode:both;animation-fill-mode:both;}"
  ];
  [@css
    "._a_2z000gr2w3{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}"
  ];
  [@css
    "._a_2zhgs5{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}"
  ];
  [@css
    "._a_2z1me1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}"
  ];
  [@css
    "._a_2z9gym{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  [@css
    "@keyframes _k_kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css
    "._a_2z001sbkao{-webkit-animation-name:var(--resize-1jz21hk);animation-name:var(--resize-1jz21hk);}"
  ];
  [@css
    "._a_2z7afk{-webkit-animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;}"
  ];
  let foo = CSS.Types.AnimationName.make("_k_m6pt8e");
  let bar = CSS.Types.AnimationName.make("_k_m6pt8e");
  
  CSS.make("_a_2z001s9u50", []);
  CSS.make("_a_2z001sdu2s", []);
  CSS.make(
    "_a_2z001sbkch",
    CSS.Types.AnimationName.toStyleVars("--foo-ucoxjj", foo),
  );
  CSS.make(
    "_a_2z001sfqed",
    CSS.Types.AnimationName.toStyleVars("--foo-qnewyj", foo)
    @ CSS.Types.AnimationName.toStyleVars("--bar-1nj9014", bar),
  );
  CSS.make("_a_2z0008nfq1", []);
  CSS.make("_a_2z0008iaw8", []);
  CSS.make("_a_2z0008wveq", []);
  CSS.make("_a_2z0008tj8j", []);
  CSS.make("_a_2z0008oaxk", []);
  CSS.make("_a_2z01kwt0tu", []);
  CSS.make("_a_2z01kwwp0a", []);
  CSS.make("_a_2z01kwviul", []);
  CSS.make("_a_2z01kwf3zo", []);
  CSS.make("_a_2z01kwa72f", []);
  CSS.make("_a_2z01kw4e4x", []);
  CSS.make("_a_2z01kwf1tj", []);
  CSS.make("_a_2z01kw6j52", []);
  CSS.make("_a_2z01kww8e9", []);
  CSS.make("_a_2z01kwl2sx", []);
  CSS.make("_a_2z01kwldx6", []);
  CSS.make("_a_2z01kwlnxf", []);
  CSS.make("_a_2z000w8nyb", []);
  CSS.make("_a_2z000wslxe", []);
  CSS.make("_a_2z000wgpcx", []);
  CSS.make("_a_2z000wnpot", []);
  CSS.make("_a_2z0004jqic", []);
  CSS.make("_a_2z0004i1sk", []);
  CSS.make("_a_2z00046c5b", []);
  CSS.make("_a_2z00045c2u", []);
  CSS.make("_a_2z00042f1p", []);
  CSS.make("_a_2z00045ztj", []);
  CSS.make("_a_2z003kr8bj", []);
  CSS.make("_a_2z003kbnre", []);
  CSS.make("_a_2z003kgcqk", []);
  CSS.make("_a_2z0002dlyv", []);
  CSS.make("_a_2z00026y00", []);
  CSS.make("_a_2z00022h4y", []);
  CSS.make("_a_2z000gy95r", []);
  CSS.make("_a_2z000gnmjc", []);
  CSS.make("_a_2z000g5fpo", []);
  CSS.make("_a_2z000gvuyg", []);
  CSS.make("_a_2z000gr2w3", []);
  CSS.make("_a_2zhgs5", []);
  CSS.make("_a_2z1me1", []);
  CSS.make("_a_2z9gym", []);
  
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
      "_k_kuv9ix",
    );
  
  CSS.make(
    "_a_2z001sbkao",
    CSS.Types.AnimationName.toStyleVars("--resize-1jz21hk", resize),
  );
  CSS.make(
    "_a_2z7afk",
    CSS.Types.AnimationName.toStyleVars("--resize-1aiquq7", resize),
  );
