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
  [@css "@property --fullTransition-ahh0or{syntax:\"*\";inherits:false;}"];
  [@css "@property --fullTransition2-ezh8oo{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-18qplnj{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-1iddlz{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-vob4pv{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-cibt83{syntax:\"*\";inherits:false;}"];
  [@css "@property --behavior-108fus4{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-14kilfb{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-1ejdhyh{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1j1h4k7{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-pqgx10{syntax:\"*\";inherits:false;}"];
  [@css "@property --property3-s110ja{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-h7mj8c{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1skeegy{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1ftkhfa{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-ivu2ul{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-kgrecx{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1p09x3l{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-oa45ow{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-dgz948{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1fgs2tm{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-1n1s912{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-1ba13bw{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1tn5ly2{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-16ruk7g{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-11bcg03{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-dpf9r8{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-5iq5eh{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-sueb4i{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-87e7ig{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-1rwycv{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-7aarh0{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1f94jkq{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-fvn1cf{syntax:\"*\";inherits:false;}"];
  [@css ".a-dm008lsnu{transition-property:none;}"];
  [@css ".a-dm0087oni{transition-property:all;}"];
  [@css ".a-dm0082vzd{transition-property:width;}"];
  [@css ".a-dm0082xp0{transition-property:width, height;}"];
  [@css ".a-dm004qcio{transition-duration:0s;}"];
  [@css ".a-dm004wvco{transition-duration:1s;}"];
  [@css ".a-dm004abun{transition-duration:100ms;}"];
  [@css ".a-dm004wbyo{transition-duration:10s, 30s, 230ms;}"];
  [@css ".a-dm00g62sr{transition-timing-function:ease;}"];
  [@css ".a-dm00gk20j{transition-timing-function:linear;}"];
  [@css ".a-dm00gm6mw{transition-timing-function:ease-in;}"];
  [@css ".a-dm00gwco7{transition-timing-function:ease-out;}"];
  [@css ".a-dm00grnz4{transition-timing-function:ease-in-out;}"];
  [@css
    ".a-dm00gucrr{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".a-dm00ghuiw{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css ".a-dm00gkmi5{transition-timing-function:step-start;}"];
  [@css ".a-dm00gglpi{transition-timing-function:step-end;}"];
  [@css ".a-dm00gh31g{transition-timing-function:steps(3, start);}"];
  [@css ".a-dm00g6kkr{transition-timing-function:steps(5, end);}"];
  [@css
    ".a-dm00gj2vv{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css ".a-dm002nxui{transition-delay:1s;}"];
  [@css ".a-dm002h2bu{transition-delay:-1s;}"];
  [@css ".a-dm002w8mt{transition-delay:2s, 4ms;}"];
  [@css ".a-dm001szc2{transition-behavior:normal;}"];
  [@css ".a-dm001g4wh{transition-behavior:allow-discrete;}"];
  [@css ".a-dm00158if{transition-behavior:allow-discrete, normal;}"];
  [@css ".a-dmmma2{transition:margin-right 2s, opacity 0.5s;}"];
  [@css ".a-dmzmc5{transition:1s 2s width linear;}"];
  [@css ".a-dmmdqb{transition:none;}"];
  [@css ".a-dmcb8v{transition:margin-right;}"];
  [@css ".a-dmcwj8{transition:margin-right ease-in;}"];
  [@css ".a-dmny5s{transition:0.5s;}"];
  [@css ".a-dmn6u7{transition:200ms 0.5s;}"];
  [@css ".a-dmixva{transition:linear;}"];
  [@css ".a-dmed1j{transition:1s 0.5s linear margin-right;}"];
  [@css ".a-dm2e7j{transition:display 4s allow-discrete;}"];
  [@css ".a-dmvjvi{transition:all 0.5s ease-out allow-discrete;}"];
  [@css ".in-1s53f4o{transition:var(--fullTransition-ahh0or);}"];
  [@css ".in-7av9kq{transition:var(--fullTransition2-ezh8oo);}"];
  [@css
    ".in-vo6ojv{transition:var(--property-18qplnj) var(--duration-1iddlz) var(--timingFunction-vob4pv) var(--delay-cibt83) var(--behavior-108fus4);}"
  ];
  [@css
    ".in-7fw6lg{transition:var(--property-14kilfb) var(--duration-1ejdhyh) var(--timingFunction-1j1h4k7) var(--delay-pqgx10), var(--property3-s110ja) 0s;}"
  ];
  [@css ".in-mpxtlc{transition:var(--property-h7mj8c) 0.2s ease-out 3s;}"];
  [@css
    ".in-1inf0xc{transition:var(--property-1skeegy) 0.2s var(--timingFunction-1ftkhfa) 3s;}"
  ];
  [@css
    ".in-g7n3fb{transition:var(--property-ivu2ul) var(--duration-kgrecx) var(--timingFunction-1p09x3l) 3s;}"
  ];
  [@css
    ".in-exsj4v{transition:margin-right var(--duration-oa45ow) ease-out var(--delay-dgz948);}"
  ];
  [@css
    ".in-5zoj59{transition:var(--property-1fgs2tm) var(--duration-1n1s912) ease-out var(--delay-1ba13bw);}"
  ];
  [@css
    ".in-1bqhenj{transition:margin-right 0.2s var(--timingFunction-1tn5ly2) 3s;}"
  ];
  [@css
    ".in-9qix23{transition:margin-right 0.2s ease-out var(--delay-16ruk7g);}"
  ];
  [@css ".in-13ygdrt{transition:var(--property-11bcg03) 0.2s ease-in;}"];
  [@css
    ".in-1ytrew9{transition:var(--property-dpf9r8) 0.2s var(--timingFunction-5iq5eh);}"
  ];
  [@css ".in-usxeae{transition:margin-right var(--duration-sueb4i) ease-in;}"];
  [@css
    ".in-zo5bqb{transition:var(--property-87e7ig) var(--duration-1rwycv) ease-in;}"
  ];
  [@css
    ".in-1np81bt{transition:margin-right 0.2s var(--timingFunction-7aarh0);}"
  ];
  [@css ".in-2kvqcx{transition:var(--property-1f94jkq) 0.2s;}"];
  [@css ".in-sw4q0n{transition:margin-right var(--duration-fvn1cf);}"];
  
  CSS.make("a-dm008lsnu", []);
  CSS.make("a-dm0087oni", []);
  CSS.make("a-dm0082vzd", []);
  CSS.make("a-dm0082xp0", []);
  CSS.make("a-dm004qcio", []);
  CSS.make("a-dm004wvco", []);
  CSS.make("a-dm004abun", []);
  CSS.make("a-dm004wbyo", []);
  CSS.make("a-dm00g62sr", []);
  CSS.make("a-dm00gk20j", []);
  CSS.make("a-dm00gm6mw", []);
  CSS.make("a-dm00gwco7", []);
  CSS.make("a-dm00grnz4", []);
  CSS.make("a-dm00gucrr", []);
  CSS.make("a-dm00ghuiw", []);
  CSS.make("a-dm00gkmi5", []);
  CSS.make("a-dm00gglpi", []);
  CSS.make("a-dm00gh31g", []);
  CSS.make("a-dm00g6kkr", []);
  CSS.make("a-dm00gj2vv", []);
  CSS.make("a-dm002nxui", []);
  CSS.make("a-dm002h2bu", []);
  CSS.make("a-dm002w8mt", []);
  CSS.make("a-dm001szc2", []);
  CSS.make("a-dm001g4wh", []);
  CSS.make("a-dm00158if", []);
  CSS.make("a-dmmma2", []);
  CSS.make("a-dmzmc5", []);
  CSS.make("a-dmmdqb", []);
  CSS.make("a-dmcb8v", []);
  CSS.make("a-dmcwj8", []);
  CSS.make("a-dmny5s", []);
  CSS.make("a-dmn6u7", []);
  CSS.make("a-dmixva", []);
  CSS.make("a-dmed1j", []);
  CSS.make("a-dm2e7j", []);
  CSS.make("a-dmvjvi", []);
  
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
    "in-1s53f4o",
    [
      (
        "--fullTransition-ahh0or",
        CSS.Types.Transition.toString(fullTransition),
      ),
    ],
  );
  
  let fullTransition2 =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.all,
      (),
    );
  CSS.make(
    "in-7av9kq",
    [
      (
        "--fullTransition2-ezh8oo",
        CSS.Types.Transition.toString(fullTransition2),
      ),
    ],
  );
  
  CSS.make(
    "in-vo6ojv",
    [
      ("--property-18qplnj", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1iddlz", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-vob4pv",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--delay-cibt83", CSS.Types.Time.toString(delay)),
      ("--behavior-108fus4", CSS.Types.TransitionBehavior.toString(behavior)),
    ],
  );
  CSS.make(
    "in-7fw6lg",
    [
      ("--property-14kilfb", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1ejdhyh", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-1j1h4k7",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--delay-pqgx10", CSS.Types.Time.toString(delay)),
      ("--property3-s110ja", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "in-mpxtlc",
    [("--property-h7mj8c", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "in-1inf0xc",
    [
      ("--property-1skeegy", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-1ftkhfa",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-g7n3fb",
    [
      ("--property-ivu2ul", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-kgrecx", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-1p09x3l",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-exsj4v",
    [
      ("--duration-oa45ow", CSS.Types.Time.toString(duration)),
      ("--delay-dgz948", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "in-5zoj59",
    [
      ("--property-1fgs2tm", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1n1s912", CSS.Types.Time.toString(duration)),
      ("--delay-1ba13bw", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "in-1bqhenj",
    [
      (
        "--timingFunction-1tn5ly2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-9qix23",
    [("--delay-16ruk7g", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "in-13ygdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "in-1ytrew9",
    [
      ("--property-dpf9r8", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-5iq5eh",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-usxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "in-zo5bqb",
    [
      ("--property-87e7ig", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1rwycv", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "in-1np81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-13ygdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "in-usxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "in-1np81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "in-2kvqcx",
    [("--property-1f94jkq", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "in-sw4q0n",
    [("--duration-fvn1cf", CSS.Types.Time.toString(duration))],
  );
