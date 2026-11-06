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
  [@css "@property --fullTransition-1y55ds9{syntax:\"*\";inherits:false;}"];
  [@css "@property --fullTransition2-hfulxs{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-29kebl{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-17lnpco{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-43lf1m{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-yoprbn{syntax:\"*\";inherits:false;}"];
  [@css "@property --behavior-1l3b51z{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1h2zkg4{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-h9t1f1{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1cq2vpr{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-4rjqt{syntax:\"*\";inherits:false;}"];
  [@css "@property --property3-r9iqia{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1kywj80{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-ti1cq9{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-j1qzcv{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1llucpv{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-ul7ax4{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1l1hszh{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-122hcof{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-1j986rw{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-lgysoo{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-1ifxxoh{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-110b6u0{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-1mnwu8{syntax:\"*\";inherits:false;}"];
  [@css "@property --delay-eppukr{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-ldzjy8{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-tj1ufq{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-g9wjaa{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-11eqdo8{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-1pi0u9v{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-18om15f{syntax:\"*\";inherits:false;}"];
  [@css "@property --timingFunction-xa3wai{syntax:\"*\";inherits:false;}"];
  [@css "@property --property-a2zdjd{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-12p3q0k{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_ameJjOLrM",
        ["._ameJjOLrM{transition-property:none;}"],
        1,
        0,
        1,
        [("value", "JjOLrM", "val\\0me\\0& | \\0transition-property:none")],
      ),
      (
        "_ameUuycfH",
        ["._ameUuycfH{transition-property:all;}"],
        1,
        0,
        1,
        [("value", "UuycfH", "val\\0me\\0& | \\0transition-property:all")],
      ),
      (
        "_ameO-kQcj",
        ["._ameO-kQcj{transition-property:width;}"],
        1,
        0,
        1,
        [("value", "O-kQcj", "val\\0me\\0& | \\0transition-property:width")],
      ),
      (
        "_ameu5mdDG",
        ["._ameu5mdDG{transition-property:width, height;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "u5mdDG",
            "val\\0me\\0& | \\0transition-property:width, height",
          ),
        ],
      ),
      (
        "_amdJVgZLY",
        ["._amdJVgZLY{transition-duration:0s;}"],
        1,
        0,
        1,
        [("value", "JVgZLY", "val\\0md\\0& | \\0transition-duration:0s")],
      ),
      (
        "_amdcDI6uk",
        ["._amdcDI6uk{transition-duration:1s;}"],
        1,
        0,
        1,
        [("value", "cDI6uk", "val\\0md\\0& | \\0transition-duration:1s")],
      ),
      (
        "_amdLkZek2",
        ["._amdLkZek2{transition-duration:100ms;}"],
        1,
        0,
        1,
        [("value", "LkZek2", "val\\0md\\0& | \\0transition-duration:100ms")],
      ),
      (
        "_amdxV6xnE",
        ["._amdxV6xnE{transition-duration:10s, 30s, 230ms;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "xV6xnE",
            "val\\0md\\0& | \\0transition-duration:10s, 30s, 230ms",
          ),
        ],
      ),
      (
        "_amfCoQZd_",
        ["._amfCoQZd_{transition-timing-function:ease;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CoQZd_",
            "val\\0mf\\0& | \\0transition-timing-function:ease",
          ),
        ],
      ),
      (
        "_amf69KxXK",
        ["._amf69KxXK{transition-timing-function:linear;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "69KxXK",
            "val\\0mf\\0& | \\0transition-timing-function:linear",
          ),
        ],
      ),
      (
        "_amfBsA0DV",
        ["._amfBsA0DV{transition-timing-function:ease-in;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "BsA0DV",
            "val\\0mf\\0& | \\0transition-timing-function:ease-in",
          ),
        ],
      ),
      (
        "_amfP48nfl",
        ["._amfP48nfl{transition-timing-function:ease-out;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "P48nfl",
            "val\\0mf\\0& | \\0transition-timing-function:ease-out",
          ),
        ],
      ),
      (
        "_amfu9vW2c",
        ["._amfu9vW2c{transition-timing-function:ease-in-out;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "u9vW2c",
            "val\\0mf\\0& | \\0transition-timing-function:ease-in-out",
          ),
        ],
      ),
      (
        "_amfB53HMC",
        [
          "._amfB53HMC{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "B53HMC",
            "val\\0mf\\0& | \\0transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5)",
          ),
        ],
      ),
      (
        "_amfWilrpe",
        [
          "._amfWilrpe{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Wilrpe",
            "val\\0mf\\0& | \\0transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5)",
          ),
        ],
      ),
      (
        "_amfpue2ub",
        ["._amfpue2ub{transition-timing-function:step-start;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pue2ub",
            "val\\0mf\\0& | \\0transition-timing-function:step-start",
          ),
        ],
      ),
      (
        "_amf0nvpsM",
        ["._amf0nvpsM{transition-timing-function:step-end;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0nvpsM",
            "val\\0mf\\0& | \\0transition-timing-function:step-end",
          ),
        ],
      ),
      (
        "_amfpAOhBs",
        ["._amfpAOhBs{transition-timing-function:steps(3, start);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "pAOhBs",
            "val\\0mf\\0& | \\0transition-timing-function:steps(3, start)",
          ),
        ],
      ),
      (
        "_amfFYeIlE",
        ["._amfFYeIlE{transition-timing-function:steps(5, end);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FYeIlE",
            "val\\0mf\\0& | \\0transition-timing-function:steps(5, end)",
          ),
        ],
      ),
      (
        "_amfUIJ-Q3",
        [
          "._amfUIJ-Q3{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "UIJ-Q3",
            "val\\0mf\\0& | \\0transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1)",
          ),
        ],
      ),
      (
        "_amc0XS_zw",
        ["._amc0XS_zw{transition-delay:1s;}"],
        1,
        0,
        1,
        [("value", "0XS_zw", "val\\0mc\\0& | \\0transition-delay:1s")],
      ),
      (
        "_amc6iessU",
        ["._amc6iessU{transition-delay:-1s;}"],
        1,
        0,
        1,
        [("value", "6iessU", "val\\0mc\\0& | \\0transition-delay:-1s")],
      ),
      (
        "_amcQsxWu6",
        ["._amcQsxWu6{transition-delay:2s, 4ms;}"],
        1,
        0,
        1,
        [("value", "QsxWu6", "val\\0mc\\0& | \\0transition-delay:2s, 4ms")],
      ),
      (
        "_ambUMW0SI",
        ["._ambUMW0SI{transition-behavior:normal;}"],
        1,
        0,
        1,
        [("value", "UMW0SI", "val\\0mb\\0& | \\0transition-behavior:normal")],
      ),
      (
        "_ambYRRA5F",
        ["._ambYRRA5F{transition-behavior:allow-discrete;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YRRA5F",
            "val\\0mb\\0& | \\0transition-behavior:allow-discrete",
          ),
        ],
      ),
      (
        "_amb8hZMM-",
        ["._amb8hZMM-{transition-behavior:allow-discrete, normal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8hZMM-",
            "val\\0mb\\0& | \\0transition-behavior:allow-discrete, normal",
          ),
        ],
      ),
      (
        "_amaOOH2cg",
        ["._amaOOH2cg{transition:margin-right 2s, opacity 0.5s;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "OOH2cg",
            "val\\0ma\\0& | \\0transition:margin-right 2s, opacity 0.5s",
          ),
        ],
      ),
      (
        "_amaFW1acF",
        ["._amaFW1acF{transition:1s 2s width linear;}"],
        1,
        0,
        5,
        [
          ("value", "FW1acF", "val\\0ma\\0& | \\0transition:1s 2s width linear"),
        ],
      ),
      (
        "_amal35Jb5",
        ["._amal35Jb5{transition:none;}"],
        1,
        0,
        5,
        [("value", "l35Jb5", "val\\0ma\\0& | \\0transition:none")],
      ),
      (
        "_amaVKUTh3",
        ["._amaVKUTh3{transition:margin-right;}"],
        1,
        0,
        5,
        [("value", "VKUTh3", "val\\0ma\\0& | \\0transition:margin-right")],
      ),
      (
        "_ama-x3joi",
        ["._ama-x3joi{transition:margin-right ease-in;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "-x3joi",
            "val\\0ma\\0& | \\0transition:margin-right ease-in",
          ),
        ],
      ),
      (
        "_amadAUAgE",
        ["._amadAUAgE{transition:0.5s;}"],
        1,
        0,
        5,
        [("value", "dAUAgE", "val\\0ma\\0& | \\0transition:0.5s")],
      ),
      (
        "_amavfssoG",
        ["._amavfssoG{transition:200ms 0.5s;}"],
        1,
        0,
        5,
        [("value", "vfssoG", "val\\0ma\\0& | \\0transition:200ms 0.5s")],
      ),
      (
        "_ama1CLubh",
        ["._ama1CLubh{transition:linear;}"],
        1,
        0,
        5,
        [("value", "1CLubh", "val\\0ma\\0& | \\0transition:linear")],
      ),
      (
        "_ama5JvY8s",
        ["._ama5JvY8s{transition:1s 0.5s linear margin-right;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "5JvY8s",
            "val\\0ma\\0& | \\0transition:1s 0.5s linear margin-right",
          ),
        ],
      ),
      (
        "_ama5_Zw4u",
        ["._ama5_Zw4u{transition:display 4s allow-discrete;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "5_Zw4u",
            "val\\0ma\\0& | \\0transition:display 4s allow-discrete",
          ),
        ],
      ),
      (
        "_amaWm2-Rh",
        ["._amaWm2-Rh{transition:all 0.5s ease-out allow-discrete;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "Wm2-Rh",
            "val\\0ma\\0& | \\0transition:all 0.5s ease-out allow-discrete",
          ),
        ],
      ),
      (
        "_amaopkAKV",
        ["._amaopkAKV{transition:var(--fullTransition-1y55ds9);}"],
        1,
        0,
        5,
        [
          ("value", "opkAKV", "val\\0ma\\0& | \\0transition:$(fullTransition)"),
        ],
      ),
      (
        "_amaRIrpYo",
        ["._amaRIrpYo{transition:var(--fullTransition2-hfulxs);}"],
        1,
        0,
        5,
        [
          ("value", "RIrpYo", "val\\0ma\\0& | \\0transition:$(fullTransition2)"),
        ],
      ),
      (
        "_amaD7jo2F",
        [
          "._amaD7jo2F{transition:var(--property-29kebl) var(--duration-17lnpco) var(--timingFunction-43lf1m) var(--delay-yoprbn) var(--behavior-1l3b51z);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "D7jo2F",
            "val\\0ma\\0& | \\0transition:$(property) $(duration) $(timingFunction) $(delay) $(behavior)",
          ),
        ],
      ),
      (
        "_amaSAcpw_",
        [
          "._amaSAcpw_{transition:var(--property-1h2zkg4) var(--duration-h9t1f1) var(--timingFunction-1cq2vpr) var(--delay-4rjqt), var(--property3-r9iqia) 0s;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "SAcpw_",
            "val\\0ma\\0& | \\0transition:$(property) $(duration) $(timingFunction) $(delay), $(property3) 0s",
          ),
        ],
      ),
      (
        "_ama-ScFkA",
        ["._ama-ScFkA{transition:var(--property-1kywj80) 0.2s ease-out 3s;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "-ScFkA",
            "val\\0ma\\0& | \\0transition:$(property) 0.2s ease-out 3s",
          ),
        ],
      ),
      (
        "_amaoemfpn",
        [
          "._amaoemfpn{transition:var(--property-ti1cq9) 0.2s var(--timingFunction-j1qzcv) 3s;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "oemfpn",
            "val\\0ma\\0& | \\0transition:$(property) 0.2s $(timingFunction) 3s",
          ),
        ],
      ),
      (
        "_amaLU0cAY",
        [
          "._amaLU0cAY{transition:var(--property-1llucpv) var(--duration-ul7ax4) var(--timingFunction-1l1hszh) 3s;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "LU0cAY",
            "val\\0ma\\0& | \\0transition:$(property) $(duration) $(timingFunction) 3s",
          ),
        ],
      ),
      (
        "_aman1Y96V",
        [
          "._aman1Y96V{transition:margin-right var(--duration-122hcof) ease-out var(--delay-1j986rw);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "n1Y96V",
            "val\\0ma\\0& | \\0transition:margin-right $(duration) ease-out $(delay)",
          ),
        ],
      ),
      (
        "_amab8DHE5",
        [
          "._amab8DHE5{transition:var(--property-lgysoo) var(--duration-1ifxxoh) ease-out var(--delay-110b6u0);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "b8DHE5",
            "val\\0ma\\0& | \\0transition:$(property) $(duration) ease-out $(delay)",
          ),
        ],
      ),
      (
        "_amagsIXE6",
        [
          "._amagsIXE6{transition:margin-right 0.2s var(--timingFunction-1mnwu8) 3s;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "gsIXE6",
            "val\\0ma\\0& | \\0transition:margin-right 0.2s $(timingFunction) 3s",
          ),
        ],
      ),
      (
        "_amaHkdgSD",
        [
          "._amaHkdgSD{transition:margin-right 0.2s ease-out var(--delay-eppukr);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "HkdgSD",
            "val\\0ma\\0& | \\0transition:margin-right 0.2s ease-out $(delay)",
          ),
        ],
      ),
      (
        "_amasea20Z",
        ["._amasea20Z{transition:var(--property-ldzjy8) 0.2s ease-in;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "sea20Z",
            "val\\0ma\\0& | \\0transition:$(property) 0.2s ease-in",
          ),
        ],
      ),
      (
        "_amawL3dgt",
        [
          "._amawL3dgt{transition:var(--property-tj1ufq) 0.2s var(--timingFunction-g9wjaa);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "wL3dgt",
            "val\\0ma\\0& | \\0transition:$(property) 0.2s $(timingFunction)",
          ),
        ],
      ),
      (
        "_amaRXoOo1",
        [
          "._amaRXoOo1{transition:margin-right var(--duration-11eqdo8) ease-in;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "RXoOo1",
            "val\\0ma\\0& | \\0transition:margin-right $(duration) ease-in",
          ),
        ],
      ),
      (
        "_amaSew_hI",
        [
          "._amaSew_hI{transition:var(--property-1pi0u9v) var(--duration-18om15f) ease-in;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "Sew_hI",
            "val\\0ma\\0& | \\0transition:$(property) $(duration) ease-in",
          ),
        ],
      ),
      (
        "_amaFjFgu8",
        [
          "._amaFjFgu8{transition:margin-right 0.2s var(--timingFunction-xa3wai);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "FjFgu8",
            "val\\0ma\\0& | \\0transition:margin-right 0.2s $(timingFunction)",
          ),
        ],
      ),
      (
        "_amatBXCK5",
        ["._amatBXCK5{transition:var(--property-a2zdjd) 0.2s;}"],
        1,
        0,
        5,
        [("value", "tBXCK5", "val\\0ma\\0& | \\0transition:$(property) 0.2s")],
      ),
      (
        "_amaD813I3",
        ["._amaD813I3{transition:margin-right var(--duration-12p3q0k);}"],
        1,
        0,
        5,
        [
          (
            "value",
            "D813I3",
            "val\\0ma\\0& | \\0transition:margin-right $(duration)",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_ameJjOLrM", []);
  CSS.make("_ameUuycfH", []);
  CSS.make("_ameO-kQcj", []);
  CSS.make("_ameu5mdDG", []);
  CSS.make("_amdJVgZLY", []);
  CSS.make("_amdcDI6uk", []);
  CSS.make("_amdLkZek2", []);
  CSS.make("_amdxV6xnE", []);
  CSS.make("_amfCoQZd_", []);
  CSS.make("_amf69KxXK", []);
  CSS.make("_amfBsA0DV", []);
  CSS.make("_amfP48nfl", []);
  CSS.make("_amfu9vW2c", []);
  CSS.make("_amfB53HMC", []);
  CSS.make("_amfWilrpe", []);
  CSS.make("_amfpue2ub", []);
  CSS.make("_amf0nvpsM", []);
  CSS.make("_amfpAOhBs", []);
  CSS.make("_amfFYeIlE", []);
  CSS.make("_amfUIJ-Q3", []);
  CSS.make("_amc0XS_zw", []);
  CSS.make("_amc6iessU", []);
  CSS.make("_amcQsxWu6", []);
  CSS.make("_ambUMW0SI", []);
  CSS.make("_ambYRRA5F", []);
  CSS.make("_amb8hZMM-", []);
  CSS.make("_amaOOH2cg", []);
  CSS.make("_amaFW1acF", []);
  CSS.make("_amal35Jb5", []);
  CSS.make("_amaVKUTh3", []);
  CSS.make("_ama-x3joi", []);
  CSS.make("_amadAUAgE", []);
  CSS.make("_amavfssoG", []);
  CSS.make("_ama1CLubh", []);
  CSS.make("_ama5JvY8s", []);
  CSS.make("_ama5_Zw4u", []);
  CSS.make("_amaWm2-Rh", []);
  
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
    "_amaopkAKV",
    [
      (
        "--fullTransition-1y55ds9",
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
    "_amaRIrpYo",
    [
      (
        "--fullTransition2-hfulxs",
        CSS.Types.Transition.toString(fullTransition2),
      ),
    ],
  );
  
  CSS.make(
    "_amaD7jo2F",
    [
      ("--property-29kebl", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-17lnpco", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-43lf1m",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--delay-yoprbn", CSS.Types.Time.toString(delay)),
      ("--behavior-1l3b51z", CSS.Types.TransitionBehavior.toString(behavior)),
    ],
  );
  CSS.make(
    "_amaSAcpw_",
    [
      ("--property-1h2zkg4", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-h9t1f1", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-1cq2vpr",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--delay-4rjqt", CSS.Types.Time.toString(delay)),
      ("--property3-r9iqia", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "_ama-ScFkA",
    [("--property-1kywj80", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_amaoemfpn",
    [
      ("--property-ti1cq9", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-j1qzcv",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_amaLU0cAY",
    [
      ("--property-1llucpv", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-ul7ax4", CSS.Types.Time.toString(duration)),
      (
        "--timingFunction-1l1hszh",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_aman1Y96V",
    [
      ("--duration-122hcof", CSS.Types.Time.toString(duration)),
      ("--delay-1j986rw", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "_amab8DHE5",
    [
      ("--property-lgysoo", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-1ifxxoh", CSS.Types.Time.toString(duration)),
      ("--delay-110b6u0", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "_amagsIXE6",
    [
      (
        "--timingFunction-1mnwu8",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_amaHkdgSD",
    [("--delay-eppukr", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "_amasea20Z",
    [("--property-ldzjy8", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_amawL3dgt",
    [
      ("--property-tj1ufq", CSS.Types.TransitionProperty.toString(property)),
      (
        "--timingFunction-g9wjaa",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_amaRXoOo1",
    [("--duration-11eqdo8", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "_amaSew_hI",
    [
      ("--property-1pi0u9v", CSS.Types.TransitionProperty.toString(property)),
      ("--duration-18om15f", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "_amaFjFgu8",
    [
      (
        "--timingFunction-xa3wai",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_amasea20Z",
    [("--property-ldzjy8", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_amaRXoOo1",
    [("--duration-11eqdo8", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "_amaFjFgu8",
    [
      (
        "--timingFunction-xa3wai",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "_amatBXCK5",
    [("--property-a2zdjd", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "_amaD813I3",
    [("--duration-12p3q0k", CSS.Types.Time.toString(duration))],
  );
