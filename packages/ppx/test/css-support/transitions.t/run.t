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
  [@css
    (
      "._a_dm0008lsnu{transition-property:none;}",
      "_a_dm0008lsnu",
      "0,1,0 own",
      "490",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_dm00087oni{transition-property:all;}",
      "_a_dm00087oni",
      "0,1,0 own",
      "490",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_dm00082vzd{transition-property:width;}",
      "_a_dm00082vzd",
      "0,1,0 own",
      "490",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_dm00082xp0{transition-property:width, height;}",
      "_a_dm00082xp0",
      "0,1,0 own",
      "490",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_dm0004qcio{transition-duration:0s;}",
      "_a_dm0004qcio",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_dm0004wvco{transition-duration:1s;}",
      "_a_dm0004wvco",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_dm0004abun{transition-duration:100ms;}",
      "_a_dm0004abun",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_dm0004wbyo{transition-duration:10s, 30s, 230ms;}",
      "_a_dm0004wbyo",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_dm000g62sr{transition-timing-function:ease;}",
      "_a_dm000g62sr",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gk20j{transition-timing-function:linear;}",
      "_a_dm000gk20j",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gm6mw{transition-timing-function:ease-in;}",
      "_a_dm000gm6mw",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gwco7{transition-timing-function:ease-out;}",
      "_a_dm000gwco7",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000grnz4{transition-timing-function:ease-in-out;}",
      "_a_dm000grnz4",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gucrr{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}",
      "_a_dm000gucrr",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000ghuiw{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}",
      "_a_dm000ghuiw",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gkmi5{transition-timing-function:step-start;}",
      "_a_dm000gkmi5",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gglpi{transition-timing-function:step-end;}",
      "_a_dm000gglpi",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gh31g{transition-timing-function:steps(3, start);}",
      "_a_dm000gh31g",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000g6kkr{transition-timing-function:steps(5, end);}",
      "_a_dm000g6kkr",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gj2vv{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}",
      "_a_dm000gj2vv",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm0002nxui{transition-delay:1s;}",
      "_a_dm0002nxui",
      "0,1,0 own",
      "490",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_dm0002h2bu{transition-delay:-1s;}",
      "_a_dm0002h2bu",
      "0,1,0 own",
      "490",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_dm0002w8mt{transition-delay:2s, 4ms;}",
      "_a_dm0002w8mt",
      "0,1,0 own",
      "490",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_dm0001szc2{transition-behavior:normal;}",
      "_a_dm0001szc2",
      "0,1,0 own",
      "490",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dm0001g4wh{transition-behavior:allow-discrete;}",
      "_a_dm0001g4wh",
      "0,1,0 own",
      "490",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dm000158if{transition-behavior:allow-discrete, normal;}",
      "_a_dm000158if",
      "0,1,0 own",
      "490",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dmmma2{transition:margin-right 2s, opacity 0.5s;}",
      "_a_dmmma2",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmzmc5{transition:1s 2s width linear;}",
      "_a_dmzmc5",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    ("._a_dmmdqb{transition:none;}", "_a_dmmdqb", "0,1,0 own", "490", 31, false)
  ];
  [@css
    (
      "._a_dmcb8v{transition:margin-right;}",
      "_a_dmcb8v",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmcwj8{transition:margin-right ease-in;}",
      "_a_dmcwj8",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    ("._a_dmny5s{transition:0.5s;}", "_a_dmny5s", "0,1,0 own", "490", 31, false)
  ];
  [@css
    (
      "._a_dmn6u7{transition:200ms 0.5s;}",
      "_a_dmn6u7",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmixva{transition:linear;}",
      "_a_dmixva",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmed1j{transition:1s 0.5s linear margin-right;}",
      "_a_dmed1j",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm2e7j{transition:display 4s allow-discrete;}",
      "_a_dm2e7j",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmvjvi{transition:all 0.5s ease-out allow-discrete;}",
      "_a_dmvjvi",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm3f4o{transition:var(--fullTransition-ahh0or);}",
      "_a_dm3f4o",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmv9kq{transition:var(--fullTransition2-ezh8oo);}",
      "_a_dmv9kq",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm6ojv{transition:var(--property-18qplnj) var(--duration-1iddlz) var(--timingFunction-vob4pv) var(--delay-cibt83) var(--behavior-108fus4);}",
      "_a_dm6ojv",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmw6lg{transition:var(--property-14kilfb) var(--duration-1ejdhyh) var(--timingFunction-1j1h4k7) var(--delay-pqgx10), var(--property3-s110ja) 0s;}",
      "_a_dmw6lg",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmxtlc{transition:var(--property-h7mj8c) 0.2s ease-out 3s;}",
      "_a_dmxtlc",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmf0xc{transition:var(--property-1skeegy) 0.2s var(--timingFunction-1ftkhfa) 3s;}",
      "_a_dmf0xc",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmn3fb{transition:var(--property-ivu2ul) var(--duration-kgrecx) var(--timingFunction-1p09x3l) 3s;}",
      "_a_dmn3fb",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmsj4v{transition:margin-right var(--duration-oa45ow) ease-out var(--delay-dgz948);}",
      "_a_dmsj4v",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmoj59{transition:var(--property-1fgs2tm) var(--duration-1n1s912) ease-out var(--delay-1ba13bw);}",
      "_a_dmoj59",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmhenj{transition:margin-right 0.2s var(--timingFunction-1tn5ly2) 3s;}",
      "_a_dmhenj",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmix23{transition:margin-right 0.2s ease-out var(--delay-16ruk7g);}",
      "_a_dmix23",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmgdrt{transition:var(--property-11bcg03) 0.2s ease-in;}",
      "_a_dmgdrt",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmrew9{transition:var(--property-dpf9r8) 0.2s var(--timingFunction-5iq5eh);}",
      "_a_dmrew9",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmxeae{transition:margin-right var(--duration-sueb4i) ease-in;}",
      "_a_dmxeae",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm5bqb{transition:var(--property-87e7ig) var(--duration-1rwycv) ease-in;}",
      "_a_dm5bqb",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm81bt{transition:margin-right 0.2s var(--timingFunction-7aarh0);}",
      "_a_dm81bt",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmvqcx{transition:var(--property-1f94jkq) 0.2s;}",
      "_a_dmvqcx",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dm4q0n{transition:margin-right var(--duration-fvn1cf);}",
      "_a_dm4q0n",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [34]),
      (3, "", [35]),
      (4, "", [36]),
      (5, "", [37]),
      (6, "", [38]),
      (7, "", [39]),
      (8, "", [40]),
      (9, "", [41]),
      (10, "", [42]),
      (11, "", [43]),
      (12, "", [44]),
      (13, "", [45]),
      (14, "", [46]),
      (15, "", [47]),
      (16, "", [48]),
      (17, "", [49]),
      (18, "", [50]),
      (19, "", [51]),
      (20, "", [52]),
      (22, "", [53]),
      (24, "", [54]),
      (25, "", [55]),
      (26, "", [56]),
      (27, "", [57]),
      (28, "", [58]),
      (29, "", [59]),
      (30, "", [60]),
      (31, "", [61]),
      (32, "", [62]),
      (33, "", [63]),
      (34, "", [64]),
      (35, "", [65]),
      (36, "", [66]),
      (37, "", [67]),
      (38, "", [68]),
      (39, "", [69]),
      (40, "", [70]),
      (58, "", [71]),
      (65, "", [72]),
      (69, "", [73]),
      (72, "", [74]),
      (74, "", [75]),
      (75, "", [76]),
      (76, "", [77]),
      (77, "", [78]),
      (78, "", [79]),
      (79, "", [80]),
      (80, "", [81]),
      (81, "", [82]),
      (82, "", [83]),
      (83, "", [84]),
      (84, "", [85]),
      (85, "", [86]),
      (86, "", [82]),
      (87, "", [84]),
      (88, "", [86]),
      (89, "", [87]),
      (90, "", [88]),
    ]
  ];
  
  CSS.make("_a_dm0008lsnu", []);
  CSS.make("_a_dm00087oni", []);
  CSS.make("_a_dm00082vzd", []);
  CSS.make("_a_dm00082xp0", []);
  CSS.make("_a_dm0004qcio", []);
  CSS.make("_a_dm0004wvco", []);
  CSS.make("_a_dm0004abun", []);
  CSS.make("_a_dm0004wbyo", []);
  CSS.make("_a_dm000g62sr", []);
  CSS.make("_a_dm000gk20j", []);
  CSS.make("_a_dm000gm6mw", []);
  CSS.make("_a_dm000gwco7", []);
  CSS.make("_a_dm000grnz4", []);
  CSS.make("_a_dm000gucrr", []);
  CSS.make("_a_dm000ghuiw", []);
  CSS.make("_a_dm000gkmi5", []);
  CSS.make("_a_dm000gglpi", []);
  CSS.make("_a_dm000gh31g", []);
  CSS.make("_a_dm000g6kkr", []);
  CSS.make("_a_dm000gj2vv", []);
  CSS.make("_a_dm0002nxui", []);
  CSS.make("_a_dm0002h2bu", []);
  CSS.make("_a_dm0002w8mt", []);
  CSS.make("_a_dm0001szc2", []);
  CSS.make("_a_dm0001g4wh", []);
  CSS.make("_a_dm000158if", []);
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
