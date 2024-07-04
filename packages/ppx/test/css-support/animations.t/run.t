This test ensures the ppx generates the correct output against styled-ppx.emotion_native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native)
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
  CssJs.animationName({js|foo|js});
  CssJs.unsafe({js|animationName|js}, {js|foo, bar|js});
  CssJs.animationDuration(`s(0));
  CssJs.animationDuration(`s(1));
  CssJs.animationDuration(`ms(100));
  CssJs.animationTimingFunction(`ease);
  CssJs.animationTimingFunction(`linear);
  CssJs.animationTimingFunction(`easeIn);
  CssJs.animationTimingFunction(`easeOut);
  CssJs.animationTimingFunction(`easeInOut);
  CssJs.animationTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
  CssJs.animationTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
  CssJs.animationTimingFunction(`stepStart);
  CssJs.animationTimingFunction(`stepEnd);
  CssJs.animationTimingFunction(`steps((3, `start)));
  CssJs.animationTimingFunction(`steps((5, `end_)));
  CssJs.animationIterationCount(`infinite);
  CssJs.animationIterationCount(`count(8.));
  CssJs.animationIterationCount(`count(4.35));
  CssJs.animationDirection(`normal);
  CssJs.animationDirection(`alternate);
  CssJs.animationDirection(`reverse);
  CssJs.animationDirection(`alternateReverse);
  CssJs.animationPlayState(`running);
  CssJs.animationPlayState(`paused);
  CssJs.animationDelay(`s(1));
  CssJs.animationDelay(`s(-1));
  CssJs.animationFillMode(`none);
  CssJs.animationFillMode(`forwards);
  CssJs.animationFillMode(`backwards);
  CssJs.animationFillMode(`both);
  CssJs.animation(
    ~duration=?Some(`s(1)),
    ~delay=?Some(`s(2)),
    ~direction=?Some(`alternate),
    ~timingFunction=?Some(`linear),
    ~fillMode=?Some(`both),
    ~playState=?None,
    ~iterationCount=?Some(`infinite),
    {js|foo|js},
  );
  CssJs.animation(
    ~duration=?Some(`s(4)),
    ~delay=?Some(`s(1)),
    ~direction=?Some(`reverse),
    ~timingFunction=?Some(`easeIn),
    ~fillMode=?Some(`both),
    ~playState=?Some(`paused),
    ~iterationCount=?Some(`infinite),
    {js|none|js},
  );
  CssJs.animation(
    ~duration=?Some(`ms(300)),
    ~delay=?Some(`ms(400)),
    ~direction=?Some(`reverse),
    ~timingFunction=?Some(`linear),
    ~fillMode=?Some(`forwards),
    ~playState=?Some(`running),
    ~iterationCount=?Some(`infinite),
    {js|a|js},
  );
