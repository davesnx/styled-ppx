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
  [@css ".css-3elsnu{transition-property:none;}"];
  [@css ".css-1827oni{transition-property:all;}"];
  [@css ".css-rf2vzd{transition-property:width;}"];
  [@css ".css-vw2xp0{transition-property:width, height;}"];
  [@css ".css-mrqcio{transition-duration:0s;}"];
  [@css ".css-yowvco{transition-duration:1s;}"];
  [@css ".css-1k8abun{transition-duration:100ms;}"];
  [@css ".css-llwbyo{transition-duration:10s, 30s, 230ms;}"];
  [@css ".css-v62sr{transition-timing-function:ease;}"];
  [@css ".css-opk20j{transition-timing-function:linear;}"];
  [@css ".css-qfm6mw{transition-timing-function:ease-in;}"];
  [@css ".css-1j6wco7{transition-timing-function:ease-out;}"];
  [@css ".css-1ufrnz4{transition-timing-function:ease-in-out;}"];
  [@css
    ".css-t5ucrr{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-1xrhuiw{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css ".css-i4kmi5{transition-timing-function:step-start;}"];
  [@css ".css-r6glpi{transition-timing-function:step-end;}"];
  [@css ".css-zrh31g{transition-timing-function:steps(3, start);}"];
  [@css ".css-wj6kkr{transition-timing-function:steps(5, end);}"];
  [@css
    ".css-1fej2vv{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css ".css-1fgnxui{transition-delay:1s;}"];
  [@css ".css-k3h2bu{transition-delay:-1s;}"];
  [@css ".css-1xiw8mt{transition-delay:2s, 4ms;}"];
  [@css ".css-pgszc2{transition-behavior:normal;}"];
  [@css ".css-1grg4wh{transition-behavior:allow-discrete;}"];
  [@css ".css-sp58if{transition-behavior:allow-discrete, normal;}"];
  [@css ".css-iqmma2{transition:margin-right 2s, opacity 0.5s;}"];
  [@css ".css-65zmc5{transition:1s 2s width linear;}"];
  [@css ".css-3dmdqb{transition:none;}"];
  [@css ".css-1a5cb8v{transition:margin-right;}"];
  [@css ".css-eccwj8{transition:margin-right ease-in;}"];
  [@css ".css-ysny5s{transition:0.5s;}"];
  [@css ".css-41n6u7{transition:200ms 0.5s;}"];
  [@css ".css-v6ixva{transition:linear;}"];
  [@css ".css-1i5ed1j{transition:1s 0.5s linear margin-right;}"];
  [@css ".css-1c2e7j{transition:display 4s allow-discrete;}"];
  [@css ".css-1c8vjvi{transition:all 0.5s ease-out allow-discrete;}"];
  [@css ".css-1s53f4o{transition:var(--var-ahh0or);}"];
  [@css ".css-7av9kq{transition:var(--var-ezh8oo);}"];
  [@css
    ".css-vo6ojv{transition:var(--var-18qplnj) var(--var-1iddlz) var(--var-vob4pv) var(--var-cibt83) var(--var-108fus4);}"
  ];
  [@css
    ".css-7fw6lg{transition:var(--var-14kilfb) var(--var-1ejdhyh) var(--var-1j1h4k7) var(--var-pqgx10), var(--var-s110ja) 0s;}"
  ];
  [@css ".css-mpxtlc{transition:var(--var-h7mj8c) 0.2s ease-out 3s;}"];
  [@css
    ".css-1inf0xc{transition:var(--var-1skeegy) 0.2s var(--var-1ftkhfa) 3s;}"
  ];
  [@css
    ".css-g7n3fb{transition:var(--var-ivu2ul) var(--var-kgrecx) var(--var-1p09x3l) 3s;}"
  ];
  [@css
    ".css-exsj4v{transition:margin-right var(--var-oa45ow) ease-out var(--var-dgz948);}"
  ];
  [@css
    ".css-5zoj59{transition:var(--var-1fgs2tm) var(--var-1n1s912) ease-out var(--var-1ba13bw);}"
  ];
  [@css ".css-1bqhenj{transition:margin-right 0.2s var(--var-1tn5ly2) 3s;}"];
  [@css
    ".css-9qix23{transition:margin-right 0.2s ease-out var(--var-16ruk7g);}"
  ];
  [@css ".css-13ygdrt{transition:var(--var-11bcg03) 0.2s ease-in;}"];
  [@css ".css-1ytrew9{transition:var(--var-dpf9r8) 0.2s var(--var-5iq5eh);}"];
  [@css ".css-usxeae{transition:margin-right var(--var-sueb4i) ease-in;}"];
  [@css ".css-zo5bqb{transition:var(--var-87e7ig) var(--var-1rwycv) ease-in;}"];
  [@css ".css-1np81bt{transition:margin-right 0.2s var(--var-7aarh0);}"];
  [@css ".css-2kvqcx{transition:var(--var-1f94jkq) 0.2s;}"];
  [@css ".css-sw4q0n{transition:margin-right var(--var-fvn1cf);}"];
  
  CSS.make("css-3elsnu", []);
  CSS.make("css-1827oni", []);
  CSS.make("css-rf2vzd", []);
  CSS.make("css-vw2xp0", []);
  CSS.make("css-mrqcio", []);
  CSS.make("css-yowvco", []);
  CSS.make("css-1k8abun", []);
  CSS.make("css-llwbyo", []);
  CSS.make("css-v62sr", []);
  CSS.make("css-opk20j", []);
  CSS.make("css-qfm6mw", []);
  CSS.make("css-1j6wco7", []);
  CSS.make("css-1ufrnz4", []);
  CSS.make("css-t5ucrr", []);
  CSS.make("css-1xrhuiw", []);
  CSS.make("css-i4kmi5", []);
  CSS.make("css-r6glpi", []);
  CSS.make("css-zrh31g", []);
  CSS.make("css-wj6kkr", []);
  CSS.make("css-1fej2vv", []);
  CSS.make("css-1fgnxui", []);
  CSS.make("css-k3h2bu", []);
  CSS.make("css-1xiw8mt", []);
  CSS.make("css-pgszc2", []);
  CSS.make("css-1grg4wh", []);
  CSS.make("css-sp58if", []);
  CSS.make("css-iqmma2", []);
  CSS.make("css-65zmc5", []);
  CSS.make("css-3dmdqb", []);
  CSS.make("css-1a5cb8v", []);
  CSS.make("css-eccwj8", []);
  CSS.make("css-ysny5s", []);
  CSS.make("css-41n6u7", []);
  CSS.make("css-v6ixva", []);
  CSS.make("css-1i5ed1j", []);
  CSS.make("css-1c2e7j", []);
  CSS.make("css-1c8vjvi", []);
  
  let property = CSS.Types.TransitionProperty.make("margin-right");
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = CSS.Types.TransitionProperty.make("opacity");
  let behavior = `allowDiscrete;
  
  let fullTransition =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.make("margin-right"),
      ~duration=`ms(200),
      (),
    );
  CSS.make(
    "css-1s53f4o",
    [("--var-ahh0or", CSS.Types.Transition.toString(fullTransition))],
  );
  
  let fullTransition2 =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.all,
      (),
    );
  CSS.make(
    "css-7av9kq",
    [("--var-ezh8oo", CSS.Types.Transition.toString(fullTransition2))],
  );
  
  CSS.make(
    "css-vo6ojv",
    [
      ("--var-18qplnj", CSS.Types.TransitionProperty.toString(property)),
      ("--var-1iddlz", CSS.Types.Time.toString(duration)),
      (
        "--var-vob4pv",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--var-cibt83", CSS.Types.Time.toString(delay)),
      ("--var-108fus4", CSS.Types.TransitionBehavior.toString(behavior)),
    ],
  );
  CSS.make(
    "css-7fw6lg",
    [
      ("--var-14kilfb", CSS.Types.TransitionProperty.toString(property)),
      ("--var-1ejdhyh", CSS.Types.Time.toString(duration)),
      (
        "--var-1j1h4k7",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--var-pqgx10", CSS.Types.Time.toString(delay)),
      ("--var-s110ja", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "css-mpxtlc",
    [("--var-h7mj8c", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1inf0xc",
    [
      ("--var-1skeegy", CSS.Types.TransitionProperty.toString(property)),
      (
        "--var-1ftkhfa",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-g7n3fb",
    [
      ("--var-ivu2ul", CSS.Types.TransitionProperty.toString(property)),
      ("--var-kgrecx", CSS.Types.Time.toString(duration)),
      (
        "--var-1p09x3l",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-exsj4v",
    [
      ("--var-oa45ow", CSS.Types.Time.toString(duration)),
      ("--var-dgz948", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-5zoj59",
    [
      ("--var-1fgs2tm", CSS.Types.TransitionProperty.toString(property)),
      ("--var-1n1s912", CSS.Types.Time.toString(duration)),
      ("--var-1ba13bw", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-1bqhenj",
    [
      (
        "--var-1tn5ly2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-9qix23",
    [("--var-16ruk7g", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "css-13ygdrt",
    [("--var-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1ytrew9",
    [
      ("--var-dpf9r8", CSS.Types.TransitionProperty.toString(property)),
      (
        "--var-5iq5eh",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-usxeae",
    [("--var-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-zo5bqb",
    [
      ("--var-87e7ig", CSS.Types.TransitionProperty.toString(property)),
      ("--var-1rwycv", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "css-1np81bt",
    [
      (
        "--var-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-13ygdrt",
    [("--var-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-usxeae",
    [("--var-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-1np81bt",
    [
      (
        "--var-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-2kvqcx",
    [("--var-1f94jkq", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-sw4q0n",
    [("--var-fvn1cf", CSS.Types.Time.toString(duration))],
  );
