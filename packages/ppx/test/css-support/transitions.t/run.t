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

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  CssJs.transitionProperty({js|none|js});
  CssJs.transitionProperty({js|all|js});
  CssJs.transitionProperty({js|width|js});
  CssJs.unsafe({js|transitionProperty|js}, {js|width, height|js});
  CssJs.transitionDuration(`s(0));
  CssJs.transitionDuration(`s(1));
  CssJs.transitionDuration(`ms(100));
  CssJs.transitionTimingFunction(`ease);
  CssJs.transitionTimingFunction(`linear);
  CssJs.transitionTimingFunction(`easeIn);
  CssJs.transitionTimingFunction(`easeOut);
  CssJs.transitionTimingFunction(`easeInOut);
  CssJs.transitionTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
  CssJs.transitionTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
  CssJs.transitionTimingFunction(`stepStart);
  CssJs.transitionTimingFunction(`stepEnd);
  CssJs.transitionTimingFunction(`steps((3, `start)));
  CssJs.transitionTimingFunction(`steps((5, `end_)));
  CssJs.transitionDelay(`s(1));
  CssJs.transitionDelay(`s(-1));
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?Some(`s(2)),
      ~delay=?None,
      ~timingFunction=?None,
      {js|margin-right|js},
    ),
    CssJs.Transition.shorthand(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      {js|opacity|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`s(2)),
      ~timingFunction=?Some(`linear),
      {js|width|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      {js|none|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`easeIn),
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      {js|all|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?Some(`ms(200)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?None,
      {js|all|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`linear),
      {js|all|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?Some(`linear),
      {js|margin-right|js},
    ),
  |]);
  let transitions = [|
    CssJs.Transition.shorthand("margin-left"),
    CssJs.Transition.shorthand(~duration=`s(2), "opacity"),
  |];
  let property = "margin-right";
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property2 = "opacity";
  (CssJs.transitionList(transitions): CssJs.rule);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration, ~delay, ~timingFunction, property),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration, ~delay, ~timingFunction, property),
    CssJs.Transition.shorthand(~duration=`s(0), property2),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction=`easeOut,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration,
      ~delay=`s(3),
      ~timingFunction,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~delay,
      ~timingFunction=`easeOut,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration=`ms(200), ~timingFunction, property),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration,
      ~timingFunction=`easeIn,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration, ~timingFunction=`easeIn, property),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      property,
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration,
      ~timingFunction=`easeIn,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction,
      {js|margin-right|js},
    ),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration=`ms(200), property),
  |]);
  CssJs.transitionList([|
    CssJs.Transition.shorthand(~duration, {js|margin-right|js}),
  |]);
