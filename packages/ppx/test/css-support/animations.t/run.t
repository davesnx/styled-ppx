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

  $ dune describe pp ./input.re
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
  let foo =
    CSS.keyframes([|
      (0, [|CSS.opacity(0.)|]),
      (100, [|CSS.opacity(1.)|]),
    |]);
  let bar =
    CSS.keyframes([|
      (0, [|CSS.opacity(0.)|]),
      (100, [|CSS.opacity(1.)|]),
    |]);
  
  CSS.animationName(CSS.Types.AnimationName.make({js|random|js}));
  CSS.animationName(foo);
  CSS.animationNames([|foo, bar|]);
  CSS.animationDuration(`s(0));
  CSS.animationDuration(`s(1));
  CSS.animationDuration(`ms(100));
  CSS.animationTimingFunction(`ease);
  CSS.animationTimingFunction(`linear);
  CSS.animationTimingFunction(`easeIn);
  CSS.animationTimingFunction(`easeOut);
  CSS.animationTimingFunction(`easeInOut);
  CSS.animationTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
  CSS.animationTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
  CSS.animationTimingFunction(`stepStart);
  CSS.animationTimingFunction(`stepEnd);
  CSS.animationTimingFunction(`steps((3, `start)));
  CSS.animationTimingFunction(`steps((5, `end_)));
  CSS.animationIterationCount(`infinite);
  CSS.animationIterationCount(`count(8.));
  CSS.animationIterationCount(`count(4.35));
  CSS.animationDirection(`normal);
  CSS.animationDirection(`alternate);
  CSS.animationDirection(`reverse);
  CSS.animationDirection(`alternateReverse);
  CSS.animationPlayState(`running);
  CSS.animationPlayState(`paused);
  CSS.animationDelay(`s(1));
  CSS.animationDelay(`s(-1));
  CSS.animationFillMode(`none);
  CSS.animationFillMode(`forwards);
  CSS.animationFillMode(`backwards);
  CSS.animationFillMode(`both);
  CSS.animation(
    ~duration=?Some(`s(1)),
    ~delay=?Some(`s(2)),
    ~direction=?Some(`alternate),
    ~timingFunction=?Some(`linear),
    ~fillMode=?Some(`both),
    ~playState=?None,
    ~iterationCount=?Some(`infinite),
    ~name=CSS.Types.AnimationName.make({js|foo|js}),
    (),
  );
  CSS.animation(
    ~duration=?Some(`s(4)),
    ~delay=?Some(`s(1)),
    ~direction=?Some(`reverse),
    ~timingFunction=?Some(`easeIn),
    ~fillMode=?Some(`both),
    ~playState=?Some(`paused),
    ~iterationCount=?Some(`infinite),
    ~name=CSS.Types.AnimationName.make({js|none|js}),
    (),
  );
  CSS.animation(
    ~duration=?Some(`ms(300)),
    ~delay=?Some(`ms(400)),
    ~direction=?Some(`reverse),
    ~timingFunction=?Some(`linear),
    ~fillMode=?Some(`forwards),
    ~playState=?Some(`running),
    ~iterationCount=?Some(`infinite),
    ~name=CSS.Types.AnimationName.make({js|a|js}),
    (),
  );
