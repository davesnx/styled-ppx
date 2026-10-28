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
  [@css
    (
      "._a_2z001s9u50{-webkit-animation-name:random;animation-name:random;}",
      "_a_2z001s9u50",
      "0,1,0 own",
      "107",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_2z001sdu2s{-webkit-animation-name:foo, bar;animation-name:foo, bar;}",
      "_a_2z001sdu2s",
      "0,1,0 own",
      "107",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_2z001sbkch{-webkit-animation-name:var(--foo-ucoxjj);animation-name:var(--foo-ucoxjj);}",
      "_a_2z001sbkch",
      "0,1,0 own",
      "107",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_2z001sfqed{-webkit-animation-name:var(--foo-qnewyj), var(--bar-1nj9014);animation-name:var(--foo-qnewyj), var(--bar-1nj9014);}",
      "_a_2z001sfqed",
      "0,1,0 own",
      "107",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008nfq1{-webkit-animation-duration:0s;animation-duration:0s;}",
      "_a_2z0008nfq1",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008iaw8{-webkit-animation-duration:1s;animation-duration:1s;}",
      "_a_2z0008iaw8",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008wveq{-webkit-animation-duration:100ms;animation-duration:100ms;}",
      "_a_2z0008wveq",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008tj8j{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}",
      "_a_2z0008tj8j",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008oaxk{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}",
      "_a_2z0008oaxk",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwt0tu{-webkit-animation-timing-function:ease;animation-timing-function:ease;}",
      "_a_2z01kwt0tu",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwwp0a{-webkit-animation-timing-function:linear;animation-timing-function:linear;}",
      "_a_2z01kwwp0a",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwviul{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}",
      "_a_2z01kwviul",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwf3zo{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}",
      "_a_2z01kwf3zo",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwa72f{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}",
      "_a_2z01kwa72f",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kw4e4x{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}",
      "_a_2z01kw4e4x",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwf1tj{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}",
      "_a_2z01kwf1tj",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kw6j52{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}",
      "_a_2z01kw6j52",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kww8e9{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}",
      "_a_2z01kww8e9",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwl2sx{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}",
      "_a_2z01kwl2sx",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwldx6{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}",
      "_a_2z01kwldx6",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z01kwlnxf{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}",
      "_a_2z01kwlnxf",
      "0,1,0 own",
      "107",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_2z000w8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}",
      "_a_2z000w8nyb",
      "0,1,0 own",
      "107",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_2z000wslxe{-webkit-animation-iteration-count:8;animation-iteration-count:8;}",
      "_a_2z000wslxe",
      "0,1,0 own",
      "107",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_2z000wgpcx{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}",
      "_a_2z000wgpcx",
      "0,1,0 own",
      "107",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_2z000wnpot{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}",
      "_a_2z000wnpot",
      "0,1,0 own",
      "107",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_2z0004jqic{-webkit-animation-direction:normal;animation-direction:normal;}",
      "_a_2z0004jqic",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z0004i1sk{-webkit-animation-direction:alternate;animation-direction:alternate;}",
      "_a_2z0004i1sk",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z00046c5b{-webkit-animation-direction:reverse;animation-direction:reverse;}",
      "_a_2z00046c5b",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z00045c2u{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}",
      "_a_2z00045c2u",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z00042f1p{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}",
      "_a_2z00042f1p",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z00045ztj{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}",
      "_a_2z00045ztj",
      "0,1,0 own",
      "107",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z003kr8bj{-webkit-animation-play-state:running;animation-play-state:running;}",
      "_a_2z003kr8bj",
      "0,1,0 own",
      "107",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_2z003kbnre{-webkit-animation-play-state:paused;animation-play-state:paused;}",
      "_a_2z003kbnre",
      "0,1,0 own",
      "107",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_2z003kgcqk{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}",
      "_a_2z003kgcqk",
      "0,1,0 own",
      "107",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_2z0002dlyv{-webkit-animation-delay:1s;animation-delay:1s;}",
      "_a_2z0002dlyv",
      "0,1,0 own",
      "107",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_2z00026y00{-webkit-animation-delay:-1s;animation-delay:-1s;}",
      "_a_2z00026y00",
      "0,1,0 own",
      "107",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_2z00022h4y{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}",
      "_a_2z00022h4y",
      "0,1,0 own",
      "107",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_2z000gy95r{-webkit-animation-fill-mode:none;animation-fill-mode:none;}",
      "_a_2z000gy95r",
      "0,1,0 own",
      "107",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_2z000gnmjc{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}",
      "_a_2z000gnmjc",
      "0,1,0 own",
      "107",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_2z000g5fpo{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}",
      "_a_2z000g5fpo",
      "0,1,0 own",
      "107",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_2z000gvuyg{-webkit-animation-fill-mode:both;animation-fill-mode:both;}",
      "_a_2z000gvuyg",
      "0,1,0 own",
      "107",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_2z000gr2w3{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}",
      "_a_2z000gr2w3",
      "0,1,0 own",
      "107",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_2zhgs5{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}",
      "_a_2zhgs5",
      "0,1,0 own",
      "107",
      4095,
      false,
    )
  ];
  [@css
    (
      "._a_2z1me1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}",
      "_a_2z1me1",
      "0,1,0 own",
      "107",
      4095,
      false,
    )
  ];
  [@css
    (
      "._a_2z9gym{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}",
      "_a_2z9gym",
      "0,1,0 own",
      "107",
      4095,
      false,
    )
  ];
  [@css
    "@keyframes _k_kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css
    (
      "._a_2z001sbkao{-webkit-animation-name:var(--resize-1jz21hk);animation-name:var(--resize-1jz21hk);}",
      "_a_2z001sbkao",
      "0,1,0 own",
      "107",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_2z7afk{-webkit-animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;}",
      "_a_2z7afk",
      "0,1,0 own",
      "107",
      4095,
      false,
    )
  ];
  [@css.blocks
    [
      (5, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (8, "", [4]),
      (9, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (18, "", [14]),
      (19, "", [15]),
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
      (23, "", [19]),
      (24, "", [20]),
      (26, "", [21]),
      (28, "", [22]),
      (29, "", [23]),
      (30, "", [24]),
      (31, "", [25]),
      (32, "", [26]),
      (33, "", [27]),
      (34, "", [28]),
      (35, "", [29]),
      (36, "", [30]),
      (37, "", [31]),
      (38, "", [32]),
      (39, "", [33]),
      (40, "", [34]),
      (41, "", [35]),
      (42, "", [36]),
      (43, "", [37]),
      (44, "", [38]),
      (45, "", [39]),
      (46, "", [40]),
      (47, "", [41]),
      (48, "", [42]),
      (49, "", [43]),
      (50, "", [44]),
      (51, "", [45]),
      (66, "", [47]),
      (67, "", [48]),
    ]
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
