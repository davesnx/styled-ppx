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
  [@css "._a_dm008lsnu{transition-property:none;}"];
  [@css "._a_dm0087oni{transition-property:all;}"];
  [@css "._a_dm0082vzd{transition-property:width;}"];
  [@css "._a_dm0082xp0{transition-property:width, height;}"];
  [@css "._a_dm004qcio{transition-duration:0s;}"];
  [@css "._a_dm004wvco{transition-duration:1s;}"];
  [@css "._a_dm004abun{transition-duration:100ms;}"];
  [@css "._a_dm004wbyo{transition-duration:10s, 30s, 230ms;}"];
  [@css "._a_dm00g62sr{transition-timing-function:ease;}"];
  [@css "._a_dm00gk20j{transition-timing-function:linear;}"];
  [@css "._a_dm00gm6mw{transition-timing-function:ease-in;}"];
  [@css "._a_dm00gwco7{transition-timing-function:ease-out;}"];
  [@css "._a_dm00grnz4{transition-timing-function:ease-in-out;}"];
  [@css
    "._a_dm00gucrr{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    "._a_dm00ghuiw{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css "._a_dm00gkmi5{transition-timing-function:step-start;}"];
  [@css "._a_dm00gglpi{transition-timing-function:step-end;}"];
  [@css "._a_dm00gh31g{transition-timing-function:steps(3, start);}"];
  [@css "._a_dm00g6kkr{transition-timing-function:steps(5, end);}"];
  [@css
    "._a_dm00gj2vv{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css "._a_dm002nxui{transition-delay:1s;}"];
  [@css "._a_dm002h2bu{transition-delay:-1s;}"];
  [@css "._a_dm002w8mt{transition-delay:2s, 4ms;}"];
  [@css "._a_dm001szc2{transition-behavior:normal;}"];
  [@css "._a_dm001g4wh{transition-behavior:allow-discrete;}"];
  [@css "._a_dm00158if{transition-behavior:allow-discrete, normal;}"];
  [@css "._a_dmmma2{transition:margin-right 2s, opacity 0.5s;}"];
  [@css "._a_dmzmc5{transition:1s 2s width linear;}"];
  [@css "._a_dmmdqb{transition:none;}"];
  [@css "._a_dmcb8v{transition:margin-right;}"];
  [@css "._a_dmcwj8{transition:margin-right ease-in;}"];
  [@css "._a_dmny5s{transition:0.5s;}"];
  [@css "._a_dmn6u7{transition:200ms 0.5s;}"];
  [@css "._a_dmixva{transition:linear;}"];
  [@css "._a_dmed1j{transition:1s 0.5s linear margin-right;}"];
  [@css "._a_dm2e7j{transition:display 4s allow-discrete;}"];
  [@css "._a_dmvjvi{transition:all 0.5s ease-out allow-discrete;}"];
  [@css "._a_dm3f4o{transition:var(--fullTransition-ahh0or);}"];
  [@css "._a_dmv9kq{transition:var(--fullTransition2-ezh8oo);}"];
  [@css
    "._a_dm6ojv{transition:var(--property-18qplnj) var(--duration-1iddlz) var(--timingFunction-vob4pv) var(--delay-cibt83) var(--behavior-108fus4);}"
  ];
  [@css
    "._a_dmw6lg{transition:var(--property-14kilfb) var(--duration-1ejdhyh) var(--timingFunction-1j1h4k7) var(--delay-pqgx10), var(--property3-s110ja) 0s;}"
  ];
  [@css "._a_dmxtlc{transition:var(--property-h7mj8c) 0.2s ease-out 3s;}"];
  [@css
    "._a_dmf0xc{transition:var(--property-1skeegy) 0.2s var(--timingFunction-1ftkhfa) 3s;}"
  ];
  [@css
    "._a_dmn3fb{transition:var(--property-ivu2ul) var(--duration-kgrecx) var(--timingFunction-1p09x3l) 3s;}"
  ];
  [@css
    "._a_dmsj4v{transition:margin-right var(--duration-oa45ow) ease-out var(--delay-dgz948);}"
  ];
  [@css
    "._a_dmoj59{transition:var(--property-1fgs2tm) var(--duration-1n1s912) ease-out var(--delay-1ba13bw);}"
  ];
  [@css
    "._a_dmhenj{transition:margin-right 0.2s var(--timingFunction-1tn5ly2) 3s;}"
  ];
  [@css
    "._a_dmix23{transition:margin-right 0.2s ease-out var(--delay-16ruk7g);}"
  ];
  [@css "._a_dmgdrt{transition:var(--property-11bcg03) 0.2s ease-in;}"];
  [@css
    "._a_dmrew9{transition:var(--property-dpf9r8) 0.2s var(--timingFunction-5iq5eh);}"
  ];
  [@css "._a_dmxeae{transition:margin-right var(--duration-sueb4i) ease-in;}"];
  [@css
    "._a_dm5bqb{transition:var(--property-87e7ig) var(--duration-1rwycv) ease-in;}"
  ];
  [@css
    "._a_dm81bt{transition:margin-right 0.2s var(--timingFunction-7aarh0);}"
  ];
  [@css "._a_dmvqcx{transition:var(--property-1f94jkq) 0.2s;}"];
  [@css "._a_dm4q0n{transition:margin-right var(--duration-fvn1cf);}"];
  
  CSS.make("_a_dm008lsnu", []);
  CSS.make("_a_dm0087oni", []);
  CSS.make("_a_dm0082vzd", []);
  CSS.make("_a_dm0082xp0", []);
  CSS.make("_a_dm004qcio", []);
  CSS.make("_a_dm004wvco", []);
  CSS.make("_a_dm004abun", []);
  CSS.make("_a_dm004wbyo", []);
  CSS.make("_a_dm00g62sr", []);
  CSS.make("_a_dm00gk20j", []);
  CSS.make("_a_dm00gm6mw", []);
  CSS.make("_a_dm00gwco7", []);
  CSS.make("_a_dm00grnz4", []);
  CSS.make("_a_dm00gucrr", []);
  CSS.make("_a_dm00ghuiw", []);
  CSS.make("_a_dm00gkmi5", []);
  CSS.make("_a_dm00gglpi", []);
  CSS.make("_a_dm00gh31g", []);
  CSS.make("_a_dm00g6kkr", []);
  CSS.make("_a_dm00gj2vv", []);
  CSS.make("_a_dm002nxui", []);
  CSS.make("_a_dm002h2bu", []);
  CSS.make("_a_dm002w8mt", []);
  CSS.make("_a_dm001szc2", []);
  CSS.make("_a_dm001g4wh", []);
  CSS.make("_a_dm00158if", []);
  CSS.make("_a_dmmma2", []);
  CSS.make("_a_dmzmc5", []);
  CSS.make("_a_dmmdqb", []);
  CSS.make("_a_dmcb8v", []);
  CSS.make("_a_dmcwj8", []);
  CSS.make("_a_dmny5s", []);
  CSS.make("_a_dmn6u7", []);
  CSS.make("_a_dmixva", []);
  CSS.make("_a_dmed1j", []);
  CSS.make("_a_dm2e7j", []);
  CSS.make("_a_dmvjvi", []);
  
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
    "_a_dm3f4o",
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
    "_a_dmv9kq",
    [
      (
        "--fullTransition2-ezh8oo",
        CSS.Types.Transition.toString(fullTransition2),
      ),
    ],
  );
  
  CSS.make(
    "_a_dm6ojv",
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
    "_a_dmw6lg",
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
    "_a_dmxtlc",
    [("--property-h7mj8c", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_a_dmf0xc",
    [
      ("--property-1skeegy", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-1ftkhfa",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_a_dmn3fb",
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
    "_a_dmsj4v",
    [
      ("--duration-oa45ow", CSS.Types.Time.toString(duration)),
      ("--delay-dgz948", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "_a_dmoj59",
    [
      ("--property-1fgs2tm", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1n1s912", CSS.Types.Time.toString(duration)),
      ("--delay-1ba13bw", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "_a_dmhenj",
    [
      (
        "--timingFunction-1tn5ly2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_a_dmix23",
    [("--delay-16ruk7g", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "_a_dmgdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_a_dmrew9",
    [
      ("--property-dpf9r8", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-5iq5eh",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_a_dmxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "_a_dm5bqb",
    [
      ("--property-87e7ig", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1rwycv", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "_a_dm81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_a_dmgdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_a_dmxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "_a_dm81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_a_dmvqcx",
    [("--property-1f94jkq", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_a_dm4q0n",
    [("--duration-fvn1cf", CSS.Types.Time.toString(duration))],
  );
