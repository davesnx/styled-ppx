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
  [@css "@keyframes keyframe-c958s{0%{opacity:0 ;}100%{opacity:1 ;}}"];
  [@css ".css-13g9u50{animation-name:random;}"];
  [@css ".css-1b4du2s{animation-name:foo, bar;}"];
  [@css ".css-ixbkch{animation-name:var(--var-13g64p);}"];
  [@css ".css-bcfqed{animation-name:var(--var-13g64p), var(--var-rgjxtb);}"];
  [@css ".css-k2nfq1{animation-duration:0s;}"];
  [@css ".css-kniaw8{animation-duration:1s;}"];
  [@css ".css-2rwveq{animation-duration:100ms;}"];
  [@css ".css-15rtj8j{animation-duration:1.64s, 15.22s;}"];
  [@css ".css-1ehoaxk{animation-duration:10s, 35s, 230ms;}"];
  [@css ".css-1qgt0tu{animation-timing-function:ease;}"];
  [@css ".css-1lywp0a{animation-timing-function:linear;}"];
  [@css ".css-1hyviul{animation-timing-function:ease-in;}"];
  [@css ".css-3wf3zo{animation-timing-function:ease-out;}"];
  [@css ".css-3pa72f{animation-timing-function:ease-in-out;}"];
  [@css
    ".css-17l4e4x{animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-ktf1tj{animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css ".css-l6j52{animation-timing-function:step-start;}"];
  [@css ".css-c4w8e9{animation-timing-function:step-end;}"];
  [@css ".css-1stl2sx{animation-timing-function:steps(3, start);}"];
  [@css ".css-11mldx6{animation-timing-function:steps(5, end);}"];
  [@css ".css-17p8nyb{animation-iteration-count:infinite;}"];
  [@css ".css-18cslxe{animation-iteration-count:8;}"];
  [@css ".css-1rrgpcx{animation-iteration-count:4.35;}"];
  [@css ".css-13pnpot{animation-iteration-count:2, 0, infinite;}"];
  [@css ".css-iqjqic{animation-direction:normal;}"];
  [@css ".css-1dji1sk{animation-direction:alternate;}"];
  [@css ".css-1ah6c5b{animation-direction:reverse;}"];
  [@css ".css-6b5c2u{animation-direction:alternate-reverse;}"];
  [@css ".css-qf2f1p{animation-direction:normal, reverse;}"];
  [@css ".css-yl5ztj{animation-direction:alternate, reverse, normal;}"];
  [@css ".css-1x3r8bj{animation-play-state:running;}"];
  [@css ".css-1i5bnre{animation-play-state:paused;}"];
  [@css ".css-1ejgcqk{animation-play-state:paused, running, running;}"];
  [@css ".css-lndlyv{animation-delay:1s;}"];
  [@css ".css-5q6y00{animation-delay:-1s;}"];
  [@css ".css-vz2h4y{animation-delay:2.1s, 480ms;}"];
  [@css ".css-kjy95r{animation-fill-mode:none;}"];
  [@css ".css-144nmjc{animation-fill-mode:forwards;}"];
  [@css ".css-1wl5fpo{animation-fill-mode:backwards;}"];
  [@css ".css-iovuyg{animation-fill-mode:both;}"];
  [@css ".css-rar2w3{animation-fill-mode:both, forwards, none;}"];
  [@css ".css-bshgs5{animation:foo 1s 2s infinite linear alternate both;}"];
  [@css ".css-1jo1me1{animation:4s ease-in 1s infinite reverse both paused;}"];
  [@css
    ".css-1e29gym{animation:a 300ms linear 400ms infinite reverse forwards running;}"
  ];
  let foo = CSS.Types.AnimationName.make("keyframe-c958s");
  let bar = CSS.Types.AnimationName.make("keyframe-c958s");
  
  CSS.make("css-13g9u50", []);
  CSS.make("css-1b4du2s", []);
  CSS.make(
    "css-ixbkch",
    [("--var-13g64p", CSS.Types.AnimationName.toString(foo))],
  );
  CSS.make(
    "css-bcfqed",
    [
      ("--var-13g64p", CSS.Types.AnimationName.toString(foo)),
      ("--var-rgjxtb", CSS.Types.AnimationName.toString(bar)),
    ],
  );
  CSS.make("css-k2nfq1", []);
  CSS.make("css-kniaw8", []);
  CSS.make("css-2rwveq", []);
  CSS.make("css-15rtj8j", []);
  CSS.make("css-1ehoaxk", []);
  CSS.make("css-1qgt0tu", []);
  CSS.make("css-1lywp0a", []);
  CSS.make("css-1hyviul", []);
  CSS.make("css-3wf3zo", []);
  CSS.make("css-3pa72f", []);
  CSS.make("css-17l4e4x", []);
  CSS.make("css-ktf1tj", []);
  CSS.make("css-l6j52", []);
  CSS.make("css-c4w8e9", []);
  CSS.make("css-1stl2sx", []);
  CSS.make("css-11mldx6", []);
  CSS.animationTimingFunctions([|
    `ease,
    `stepStart,
    `cubicBezier((0.1, 0.7, 1., 0.1)),
  |]);
  CSS.make("css-17p8nyb", []);
  CSS.make("css-18cslxe", []);
  CSS.make("css-1rrgpcx", []);
  CSS.make("css-13pnpot", []);
  CSS.make("css-iqjqic", []);
  CSS.make("css-1dji1sk", []);
  CSS.make("css-1ah6c5b", []);
  CSS.make("css-6b5c2u", []);
  CSS.make("css-qf2f1p", []);
  CSS.make("css-yl5ztj", []);
  CSS.make("css-1x3r8bj", []);
  CSS.make("css-1i5bnre", []);
  CSS.make("css-1ejgcqk", []);
  CSS.make("css-lndlyv", []);
  CSS.make("css-5q6y00", []);
  CSS.make("css-vz2h4y", []);
  CSS.make("css-kjy95r", []);
  CSS.make("css-144nmjc", []);
  CSS.make("css-1wl5fpo", []);
  CSS.make("css-iovuyg", []);
  CSS.make("css-rar2w3", []);
  CSS.make("css-bshgs5", []);
  CSS.make("css-1jo1me1", []);
  CSS.make("css-1e29gym", []);
