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
  [@css "@property --property-1ns97xd{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-l3l64y{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-4qa60r{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-1qsey2r{syntax:\"*\";inherits:false;}"];
  [@css "@property --property3-m9lzeg{syntax:\"*\";inherits:false;}"];
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
  [@css ".css-3elsnu{transition-property:none}"];
  [@css ".css-1827oni{transition-property:all}"];
  [@css ".css-rf2vzd{transition-property:width}"];
  [@css ".css-71kb5m{transition-property:width,height}"];
  [@css ".css-mrqcio{transition-duration:0s}"];
  [@css ".css-yowvco{transition-duration:1s}"];
  [@css ".css-1k8abun{transition-duration:100ms}"];
  [@css ".css-38cood{transition-duration:10s,30s,230ms}"];
  [@css ".css-v62sr{transition-timing-function:ease}"];
  [@css ".css-opk20j{transition-timing-function:linear}"];
  [@css ".css-qfm6mw{transition-timing-function:ease-in}"];
  [@css ".css-1j6wco7{transition-timing-function:ease-out}"];
  [@css ".css-1ufrnz4{transition-timing-function:ease-in-out}"];
  [@css
    ".css-1608bvf{transition-timing-function:cubic-bezier(0.5,0.5,0.5,0.5)}"
  ];
  [@css
    ".css-wksupw{transition-timing-function:cubic-bezier(0.5,1.5,0.5,-2.5)}"
  ];
  [@css ".css-i4kmi5{transition-timing-function:step-start}"];
  [@css ".css-r6glpi{transition-timing-function:step-end}"];
  [@css ".css-ue0frb{transition-timing-function:steps(3,start)}"];
  [@css ".css-1vb4kmz{transition-timing-function:steps(5,end)}"];
  [@css
    ".css-1gr5mwr{transition-timing-function:ease,step-start,cubic-bezier(0.1,0.7,1,0.1)}"
  ];
  [@css ".css-1fgnxui{transition-delay:1s}"];
  [@css ".css-k3h2bu{transition-delay:-1s}"];
  [@css ".css-o2royv{transition-delay:2s,4ms}"];
  [@css ".css-pgszc2{transition-behavior:normal}"];
  [@css ".css-1grg4wh{transition-behavior:allow-discrete}"];
  [@css ".css-xuti4e{transition-behavior:allow-discrete,normal}"];
  [@css ".css-ohyla1{transition:margin-right 2s,opacity 0.5s}"];
  [@css ".css-65zmc5{transition:1s 2s width linear}"];
  [@css ".css-3dmdqb{transition:none}"];
  [@css ".css-1a5cb8v{transition:margin-right}"];
  [@css ".css-eccwj8{transition:margin-right ease-in}"];
  [@css ".css-ysny5s{transition:0.5s}"];
  [@css ".css-41n6u7{transition:200ms 0.5s}"];
  [@css ".css-v6ixva{transition:linear}"];
  [@css ".css-1i5ed1j{transition:1s 0.5s linear margin-right}"];
  [@css ".css-1c2e7j{transition:display 4s allow-discrete}"];
  [@css ".css-1c8vjvi{transition:all 0.5s ease-out allow-discrete}"];
  [@css ".css-1s53f4o{transition:var(--fullTransition-ahh0or)}"];
  [@css ".css-7av9kq{transition:var(--fullTransition2-ezh8oo)}"];
  [@css
    ".css-vo6ojv{transition:var(--property-18qplnj) var(--duration-1iddlz) var(--timingFunction-vob4pv) var(--delay-cibt83) var(--behavior-108fus4)}"
  ];
  [@css
    ".css-1vrkans{transition:var(--property-1ns97xd) var(--duration-l3l64y) var(--timingFunction-4qa60r) var(--delay-1qsey2r),var(--property3-m9lzeg) 0s}"
  ];
  [@css ".css-mpxtlc{transition:var(--property-h7mj8c) 0.2s ease-out 3s}"];
  [@css
    ".css-1inf0xc{transition:var(--property-1skeegy) 0.2s var(--timingFunction-1ftkhfa) 3s}"
  ];
  [@css
    ".css-g7n3fb{transition:var(--property-ivu2ul) var(--duration-kgrecx) var(--timingFunction-1p09x3l) 3s}"
  ];
  [@css
    ".css-exsj4v{transition:margin-right var(--duration-oa45ow) ease-out var(--delay-dgz948)}"
  ];
  [@css
    ".css-5zoj59{transition:var(--property-1fgs2tm) var(--duration-1n1s912) ease-out var(--delay-1ba13bw)}"
  ];
  [@css
    ".css-1bqhenj{transition:margin-right 0.2s var(--timingFunction-1tn5ly2) 3s}"
  ];
  [@css
    ".css-9qix23{transition:margin-right 0.2s ease-out var(--delay-16ruk7g)}"
  ];
  [@css ".css-13ygdrt{transition:var(--property-11bcg03) 0.2s ease-in}"];
  [@css
    ".css-1ytrew9{transition:var(--property-dpf9r8) 0.2s var(--timingFunction-5iq5eh)}"
  ];
  [@css ".css-usxeae{transition:margin-right var(--duration-sueb4i) ease-in}"];
  [@css
    ".css-zo5bqb{transition:var(--property-87e7ig) var(--duration-1rwycv) ease-in}"
  ];
  [@css
    ".css-1np81bt{transition:margin-right 0.2s var(--timingFunction-7aarh0)}"
  ];
  [@css ".css-2kvqcx{transition:var(--property-1f94jkq) 0.2s}"];
  [@css ".css-sw4q0n{transition:margin-right var(--duration-fvn1cf)}"];
  
  CSS.make("css-3elsnu", []);
  CSS.make("css-1827oni", []);
  CSS.make("css-rf2vzd", []);
  CSS.make("css-71kb5m", []);
  CSS.make("css-mrqcio", []);
  CSS.make("css-yowvco", []);
  CSS.make("css-1k8abun", []);
  CSS.make("css-38cood", []);
  CSS.make("css-v62sr", []);
  CSS.make("css-opk20j", []);
  CSS.make("css-qfm6mw", []);
  CSS.make("css-1j6wco7", []);
  CSS.make("css-1ufrnz4", []);
  CSS.make("css-1608bvf", []);
  CSS.make("css-wksupw", []);
  CSS.make("css-i4kmi5", []);
  CSS.make("css-r6glpi", []);
  CSS.make("css-ue0frb", []);
  CSS.make("css-1vb4kmz", []);
  CSS.make("css-1gr5mwr", []);
  CSS.make("css-1fgnxui", []);
  CSS.make("css-k3h2bu", []);
  CSS.make("css-o2royv", []);
  CSS.make("css-pgszc2", []);
  CSS.make("css-1grg4wh", []);
  CSS.make("css-xuti4e", []);
  CSS.make("css-ohyla1", []);
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
    "css-7av9kq",
    [
      (
        "--fullTransition2-ezh8oo",
        CSS.Types.Transition.toString(fullTransition2),
      ),
    ],
  );
  
  CSS.make(
    "css-vo6ojv",
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
    "css-1vrkans",
    [
      ("--property-1ns97xd", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-l3l64y", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-4qa60r",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--delay-1qsey2r", CSS.Types.Time.toString(delay)),
      ("--property3-m9lzeg", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "css-mpxtlc",
    [("--property-h7mj8c", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1inf0xc",
    [
      ("--property-1skeegy", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-1ftkhfa",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-g7n3fb",
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
    "css-exsj4v",
    [
      ("--duration-oa45ow", CSS.Types.Time.toString(duration)),
      ("--delay-dgz948", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-5zoj59",
    [
      ("--property-1fgs2tm", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1n1s912", CSS.Types.Time.toString(duration)),
      ("--delay-1ba13bw", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-1bqhenj",
    [
      (
        "--timingFunction-1tn5ly2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-9qix23",
    [("--delay-16ruk7g", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "css-13ygdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1ytrew9",
    [
      ("--property-dpf9r8", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-5iq5eh",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-usxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-zo5bqb",
    [
      ("--property-87e7ig", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1rwycv", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "css-1np81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-13ygdrt",
    [("--property-11bcg03", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-usxeae",
    [("--duration-sueb4i", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-1np81bt",
    [
      (
        "--timingFunction-7aarh0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-2kvqcx",
    [("--property-1f94jkq", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-sw4q0n",
    [("--duration-fvn1cf", CSS.Types.Time.toString(duration))],
  );
