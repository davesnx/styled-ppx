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
  File "input.re", line 70, characters 2-80:
  70 |   {|transition: $(property) $(duration) $(timingFunction) $(delay) $(behavior)|}
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: The value property has type Css_types.TransitionProperty.t
         but an expression was expected of type
           [< `inherit_
            | `initial
            | `revert
            | `revertLayer
            | `unset
            | `value of Css_types.Transition.Value.value
            | `var of string
            | `varDefault of string * string ]
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-3elsnu{transition-property:none;}\n.css-1827oni{transition-property:all;}\n.css-rf2vzd{transition-property:width;}\n.css-vw2xp0{transition-property:width, height;}\n.css-mrqcio{transition-duration:0s;}\n.css-yowvco{transition-duration:1s;}\n.css-1k8abun{transition-duration:100ms;}\n.css-llwbyo{transition-duration:10s, 30s, 230ms;}\n.css-v62sr{transition-timing-function:ease;}\n.css-opk20j{transition-timing-function:linear;}\n.css-qfm6mw{transition-timing-function:ease-in;}\n.css-1j6wco7{transition-timing-function:ease-out;}\n.css-1ufrnz4{transition-timing-function:ease-in-out;}\n.css-t5ucrr{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}\n.css-1xrhuiw{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}\n.css-i4kmi5{transition-timing-function:step-start;}\n.css-r6glpi{transition-timing-function:step-end;}\n.css-zrh31g{transition-timing-function:steps(3, start);}\n.css-wj6kkr{transition-timing-function:steps(5, end);}\n.css-1fej2vv{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}\n.css-1fgnxui{transition-delay:1s;}\n.css-k3h2bu{transition-delay:-1s;}\n.css-1xiw8mt{transition-delay:2s, 4ms;}\n.css-pgszc2{transition-behavior:normal;}\n.css-1grg4wh{transition-behavior:allow-discrete;}\n.css-sp58if{transition-behavior:allow-discrete, normal;}\n.css-iqmma2{transition:margin-right 2s, opacity 0.5s;}\n.css-65zmc5{transition:1s 2s width linear;}\n.css-3dmdqb{transition:none;}\n.css-1a5cb8v{transition:margin-right;}\n.css-eccwj8{transition:margin-right ease-in;}\n.css-ysny5s{transition:0.5s;}\n.css-41n6u7{transition:200ms 0.5s;}\n.css-v6ixva{transition:linear;}\n.css-1i5ed1j{transition:1s 0.5s linear margin-right;}\n.css-1c2e7j{transition:display 4s allow-discrete;}\n.css-1c8vjvi{transition:all 0.5s ease-out allow-discrete;}\n.css-1s53f4o{transition:var(--var-mzypqe);}\n.css-7av9kq{transition:var(--var-tbzsda);}\n.css-vo6ojv{transition:var(--var-fefko6) var(--var-7p0nz0) var(--var-ml3rsq) var(--var-h43taz) var(--var-vo645f);}\n.css-mpxtlc{transition:var(--var-fefko6) 0.2s ease-out 3s;}\n.css-1inf0xc{transition:var(--var-fefko6) 0.2s var(--var-ml3rsq) 3s;}\n.css-g7n3fb{transition:var(--var-fefko6) var(--var-7p0nz0) var(--var-ml3rsq) 3s;}\n.css-exsj4v{transition:margin-right var(--var-7p0nz0) ease-out var(--var-h43taz);}\n.css-5zoj59{transition:var(--var-fefko6) var(--var-7p0nz0) ease-out var(--var-h43taz);}\n.css-1bqhenj{transition:margin-right 0.2s var(--var-ml3rsq) 3s;}\n.css-9qix23{transition:margin-right 0.2s ease-out var(--var-h43taz);}\n.css-13ygdrt{transition:var(--var-fefko6) 0.2s ease-in;}\n.css-1ytrew9{transition:var(--var-fefko6) 0.2s var(--var-ml3rsq);}\n.css-usxeae{transition:margin-right var(--var-7p0nz0) ease-in;}\n.css-zo5bqb{transition:var(--var-fefko6) var(--var-7p0nz0) ease-in;}\n.css-1np81bt{transition:margin-right 0.2s var(--var-ml3rsq);}\n.css-2kvqcx{transition:var(--var-fefko6) 0.2s;}\n.css-sw4q0n{transition:margin-right var(--var-7p0nz0);}\n"
  ];
  
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
  let property2 = CSS.Types.TransitionProperty.all;
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
    [("--var-mzypqe", CSS.Types.Transition.toString(fullTransition))],
  );
  
  let fullTransition2 =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.all,
      (),
    );
  CSS.make(
    "css-7av9kq",
    [("--var-tbzsda", CSS.Types.Transition.toString(fullTransition2))],
  );
  
  CSS.make(
    "css-vo6ojv",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-7p0nz0", CSS.Types.Transition.toString(duration)),
      ("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction)),
      ("--var-h43taz", CSS.Types.Transition.toString(delay)),
      ("--var-vo645f", CSS.Types.Transition.toString(behavior)),
    ],
  );
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~delay,
      ~timingFunction,
      ~property,
      (),
    ),
    CSS.Types.Transition.Value.make(~duration=`s(0), ~property=property3, ()),
  |]);
  CSS.make(
    "css-mpxtlc",
    [("--var-fefko6", CSS.Types.Transition.toString(property))],
  );
  CSS.make(
    "css-1inf0xc",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction)),
    ],
  );
  CSS.make(
    "css-g7n3fb",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-7p0nz0", CSS.Types.Transition.toString(duration)),
      ("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction)),
    ],
  );
  CSS.make(
    "css-exsj4v",
    [
      ("--var-7p0nz0", CSS.Types.Transition.toString(duration)),
      ("--var-h43taz", CSS.Types.Transition.toString(delay)),
    ],
  );
  CSS.make(
    "css-5zoj59",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-7p0nz0", CSS.Types.Transition.toString(duration)),
      ("--var-h43taz", CSS.Types.Transition.toString(delay)),
    ],
  );
  CSS.make(
    "css-1bqhenj",
    [("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction))],
  );
  CSS.make(
    "css-9qix23",
    [("--var-h43taz", CSS.Types.Transition.toString(delay))],
  );
  CSS.make(
    "css-13ygdrt",
    [("--var-fefko6", CSS.Types.Transition.toString(property))],
  );
  CSS.make(
    "css-1ytrew9",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction)),
    ],
  );
  CSS.make(
    "css-usxeae",
    [("--var-7p0nz0", CSS.Types.Transition.toString(duration))],
  );
  CSS.make(
    "css-zo5bqb",
    [
      ("--var-fefko6", CSS.Types.Transition.toString(property)),
      ("--var-7p0nz0", CSS.Types.Transition.toString(duration)),
    ],
  );
  CSS.make(
    "css-1np81bt",
    [("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction))],
  );
  CSS.make(
    "css-13ygdrt",
    [("--var-fefko6", CSS.Types.Transition.toString(property))],
  );
  CSS.make(
    "css-usxeae",
    [("--var-7p0nz0", CSS.Types.Transition.toString(duration))],
  );
  CSS.make(
    "css-1np81bt",
    [("--var-ml3rsq", CSS.Types.Transition.toString(timingFunction))],
  );
  CSS.make(
    "css-2kvqcx",
    [("--var-fefko6", CSS.Types.Transition.toString(property))],
  );
  CSS.make(
    "css-sw4q0n",
    [("--var-7p0nz0", CSS.Types.Transition.toString(duration))],
  );
