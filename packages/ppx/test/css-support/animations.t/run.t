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
  [@css "@keyframes keyframe-1khjms2{0%{opacity:0}100%{opacity:1}}"];
  [@css ".css-13g9u50{-webkit-animation-name:random;animation-name:random}"];
  [@css ".css-ytlo8s{-webkit-animation-name:foo,bar;animation-name:foo,bar}"];
  [@css
    ".css-ixbkch{-webkit-animation-name:var(--foo-ucoxjj);animation-name:var(--foo-ucoxjj)}"
  ];
  [@css
    ".css-1rmdvj{-webkit-animation-name:var(--foo-yrs6t2),var(--bar-1n2aszt);animation-name:var(--foo-yrs6t2),var(--bar-1n2aszt)}"
  ];
  [@css ".css-k2nfq1{-webkit-animation-duration:0s;animation-duration:0s}"];
  [@css ".css-kniaw8{-webkit-animation-duration:1s;animation-duration:1s}"];
  [@css
    ".css-2rwveq{-webkit-animation-duration:100ms;animation-duration:100ms}"
  ];
  [@css
    ".css-a92clw{-webkit-animation-duration:1.64s,15.22s;animation-duration:1.64s,15.22s}"
  ];
  [@css
    ".css-b06o0f{-webkit-animation-duration:10s,35s,230ms;animation-duration:10s,35s,230ms}"
  ];
  [@css
    ".css-1qgt0tu{-webkit-animation-timing-function:ease;animation-timing-function:ease}"
  ];
  [@css
    ".css-1lywp0a{-webkit-animation-timing-function:linear;animation-timing-function:linear}"
  ];
  [@css
    ".css-1hyviul{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in}"
  ];
  [@css
    ".css-3wf3zo{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out}"
  ];
  [@css
    ".css-3pa72f{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out}"
  ];
  [@css
    ".css-8zbt8t{-webkit-animation-timing-function:cubic-bezier(0.5,0.5,0.5,0.5);animation-timing-function:cubic-bezier(0.5,0.5,0.5,0.5)}"
  ];
  [@css
    ".css-y31w22{-webkit-animation-timing-function:cubic-bezier(0.5,1.5,0.5,-2.5);animation-timing-function:cubic-bezier(0.5,1.5,0.5,-2.5)}"
  ];
  [@css
    ".css-l6j52{-webkit-animation-timing-function:step-start;animation-timing-function:step-start}"
  ];
  [@css
    ".css-c4w8e9{-webkit-animation-timing-function:step-end;animation-timing-function:step-end}"
  ];
  [@css
    ".css-7lpvg4{-webkit-animation-timing-function:steps(3,start);animation-timing-function:steps(3,start)}"
  ];
  [@css
    ".css-1qtksor{-webkit-animation-timing-function:steps(5,end);animation-timing-function:steps(5,end)}"
  ];
  [@css
    ".css-1netea3{-webkit-animation-timing-function:ease,step-start,cubic-bezier(0.1,0.7,1,0.1);animation-timing-function:ease,step-start,cubic-bezier(0.1,0.7,1,0.1)}"
  ];
  [@css
    ".css-17p8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite}"
  ];
  [@css
    ".css-18cslxe{-webkit-animation-iteration-count:8;animation-iteration-count:8}"
  ];
  [@css
    ".css-1rrgpcx{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35}"
  ];
  [@css
    ".css-11ukcw4{-webkit-animation-iteration-count:2,0,infinite;animation-iteration-count:2,0,infinite}"
  ];
  [@css
    ".css-iqjqic{-webkit-animation-direction:normal;animation-direction:normal}"
  ];
  [@css
    ".css-1dji1sk{-webkit-animation-direction:alternate;animation-direction:alternate}"
  ];
  [@css
    ".css-1ah6c5b{-webkit-animation-direction:reverse;animation-direction:reverse}"
  ];
  [@css
    ".css-6b5c2u{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse}"
  ];
  [@css
    ".css-1n0h4wy{-webkit-animation-direction:normal,reverse;animation-direction:normal,reverse}"
  ];
  [@css
    ".css-9zsao{-webkit-animation-direction:alternate,reverse,normal;animation-direction:alternate,reverse,normal}"
  ];
  [@css
    ".css-1x3r8bj{-webkit-animation-play-state:running;animation-play-state:running}"
  ];
  [@css
    ".css-1i5bnre{-webkit-animation-play-state:paused;animation-play-state:paused}"
  ];
  [@css
    ".css-ury7n2{-webkit-animation-play-state:paused,running,running;animation-play-state:paused,running,running}"
  ];
  [@css ".css-lndlyv{-webkit-animation-delay:1s;animation-delay:1s}"];
  [@css ".css-5q6y00{-webkit-animation-delay:-1s;animation-delay:-1s}"];
  [@css
    ".css-13kdsy5{-webkit-animation-delay:2.1s,480ms;animation-delay:2.1s,480ms}"
  ];
  [@css
    ".css-kjy95r{-webkit-animation-fill-mode:none;animation-fill-mode:none}"
  ];
  [@css
    ".css-144nmjc{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards}"
  ];
  [@css
    ".css-1wl5fpo{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards}"
  ];
  [@css
    ".css-iovuyg{-webkit-animation-fill-mode:both;animation-fill-mode:both}"
  ];
  [@css
    ".css-1yli08t{-webkit-animation-fill-mode:both,forwards,none;animation-fill-mode:both,forwards,none}"
  ];
  [@css
    ".css-bshgs5{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both}"
  ];
  [@css
    ".css-1jo1me1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused}"
  ];
  [@css
    ".css-1e29gym{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running}"
  ];
  [@css
    "@keyframes keyframe-14l6nyn{0%{height:var(--previous-1qdpycu)}100%{height:var(--current-15s71ud)}}"
  ];
  [@css
    ".css-1h7bkao{-webkit-animation-name:var(--resize-1jz21hk);animation-name:var(--resize-1jz21hk)}"
  ];
  [@css
    ".css-1bi7afk{-webkit-animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both;animation:var(--resize-1aiquq7) 180ms ease-out 0s 1 normal both}"
  ];
  let foo = CSS.Types.AnimationName.make("keyframe-1khjms2");
  let bar = CSS.Types.AnimationName.make("keyframe-1khjms2");
  
  CSS.make("css-13g9u50", []);
  CSS.make("css-ytlo8s", []);
  CSS.make(
    "css-ixbkch",
    CSS.Types.AnimationName.toStyleVars("--foo-ucoxjj", foo),
  );
  CSS.make(
    "css-1rmdvj",
    CSS.Types.AnimationName.toStyleVars("--foo-yrs6t2", foo)
    @ CSS.Types.AnimationName.toStyleVars("--bar-1n2aszt", bar),
  );
  CSS.make("css-k2nfq1", []);
  CSS.make("css-kniaw8", []);
  CSS.make("css-2rwveq", []);
  CSS.make("css-a92clw", []);
  CSS.make("css-b06o0f", []);
  CSS.make("css-1qgt0tu", []);
  CSS.make("css-1lywp0a", []);
  CSS.make("css-1hyviul", []);
  CSS.make("css-3wf3zo", []);
  CSS.make("css-3pa72f", []);
  CSS.make("css-8zbt8t", []);
  CSS.make("css-y31w22", []);
  CSS.make("css-l6j52", []);
  CSS.make("css-c4w8e9", []);
  CSS.make("css-7lpvg4", []);
  CSS.make("css-1qtksor", []);
  CSS.make("css-1netea3", []);
  CSS.make("css-17p8nyb", []);
  CSS.make("css-18cslxe", []);
  CSS.make("css-1rrgpcx", []);
  CSS.make("css-11ukcw4", []);
  CSS.make("css-iqjqic", []);
  CSS.make("css-1dji1sk", []);
  CSS.make("css-1ah6c5b", []);
  CSS.make("css-6b5c2u", []);
  CSS.make("css-1n0h4wy", []);
  CSS.make("css-9zsao", []);
  CSS.make("css-1x3r8bj", []);
  CSS.make("css-1i5bnre", []);
  CSS.make("css-ury7n2", []);
  CSS.make("css-lndlyv", []);
  CSS.make("css-5q6y00", []);
  CSS.make("css-13kdsy5", []);
  CSS.make("css-kjy95r", []);
  CSS.make("css-144nmjc", []);
  CSS.make("css-1wl5fpo", []);
  CSS.make("css-iovuyg", []);
  CSS.make("css-1yli08t", []);
  CSS.make("css-bshgs5", []);
  CSS.make("css-1jo1me1", []);
  CSS.make("css-1e29gym", []);
  
  let previousHeight = 20;
  let currentHeight = 80;
  let previous = `px(previousHeight);
  let current = `px(currentHeight);
  let resize =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--previous-1qdpycu", CSS.Types.Height.toString(previous)),
        ("--current-15s71ud", CSS.Types.Height.toString(current)),
      ],
      "keyframe-14l6nyn",
    );
  
  CSS.make(
    "css-1h7bkao",
    CSS.Types.AnimationName.toStyleVars("--resize-1jz21hk", resize),
  );
  CSS.make(
    "css-1bi7afk",
    CSS.Types.AnimationName.toStyleVars("--resize-1aiquq7", resize),
  );
