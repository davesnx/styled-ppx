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
  CSS.animationNames([|
    CSS.Types.AnimationName.make({js|foo|js}),
    CSS.Types.AnimationName.make({js|bar|js}),
  |]);
  CSS.animationName(foo);
  CSS.animationNames([|foo, bar|]);
  CSS.animationDuration(`s(0));
  CSS.animationDuration(`s(1));
  CSS.animationDuration(`ms(100));
  CSS.animationDurations([|`s(1), `s(15)|]);
  CSS.animationDurations([|`s(10), `s(35), `ms(230)|]);
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
  CSS.animationTimingFunctions([|
    `ease,
    `stepStart,
    `cubicBezier((0.1, 0.7, 1., 0.1)),
  |]);
  CSS.animationIterationCount(`infinite);
  CSS.animationIterationCount(`count(8.));
  CSS.animationIterationCount(`count(4.35));
  CSS.animationIterationCounts([|`count(2.), `count(0.), `infinite|]);
  CSS.animationDirection(`normal);
  CSS.animationDirection(`alternate);
  CSS.animationDirection(`reverse);
  CSS.animationDirection(`alternateReverse);
  CSS.animationDirections([|`normal, `reverse|]);
  CSS.animationDirections([|`alternate, `reverse, `normal|]);
  CSS.animationPlayState(`running);
  CSS.animationPlayState(`paused);
  CSS.animationPlayStates([|`paused, `running, `running|]);
  CSS.animationDelay(`s(1));
  CSS.animationDelay(`s(-1));
  CSS.animationDelays([|`s(2), `ms(480)|]);
  CSS.animationFillMode(`none);
  CSS.animationFillMode(`forwards);
  CSS.animationFillMode(`backwards);
  CSS.animationFillMode(`both);
  CSS.animationFillModes([|`both, `forwards, `none|]);
  CSS.animations([|
    CSS.Types.Animation.Value.make(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`s(2)),
      ~direction=?Some(`alternate),
      ~timingFunction=?Some(`linear),
      ~fillMode=?Some(`both),
      ~playState=?None,
      ~iterationCount=?Some(`infinite),
      ~name=?Some(CSS.Types.AnimationName.make({js|foo|js})),
      (),
    ),
  |]);
  CSS.animations([|
    CSS.Types.Animation.Value.make(
      ~duration=?Some(`s(4)),
      ~delay=?Some(`s(1)),
      ~direction=?Some(`reverse),
      ~timingFunction=?Some(`easeIn),
      ~fillMode=?Some(`both),
      ~playState=?Some(`paused),
      ~iterationCount=?Some(`infinite),
      ~name=?None,
      (),
    ),
  |]);
  CSS.animations([|
    CSS.Types.Animation.Value.make(
      ~duration=?Some(`ms(300)),
      ~delay=?Some(`ms(400)),
      ~direction=?Some(`reverse),
      ~timingFunction=?Some(`linear),
      ~fillMode=?Some(`forwards),
      ~playState=?Some(`running),
      ~iterationCount=?Some(`infinite),
      ~name=?Some(CSS.Types.AnimationName.make({js|a|js})),
      (),
    ),
  |]);
