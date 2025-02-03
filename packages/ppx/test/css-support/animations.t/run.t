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
  
  CSS.animationNames([|CSS.Types.AnimationName.make({js|random|js})|]);
  CSS.animationNames([|foo|]);
  CSS.animationNames([|foo, bar|]);
  CSS.animationDurations([|`s(0)|]);
  CSS.animationDurations([|`s(1)|]);
  CSS.animationDurations([|`ms(100)|]);
  CSS.animationTimingFunctions([|`ease|]);
  CSS.animationTimingFunctions([|`linear|]);
  CSS.animationTimingFunctions([|`easeIn|]);
  CSS.animationTimingFunctions([|`easeOut|]);
  CSS.animationTimingFunctions([|`easeInOut|]);
  CSS.animationTimingFunctions([|`cubicBezier((0.5, 0.5, 0.5, 0.5))|]);
  CSS.animationTimingFunctions([|`cubicBezier((0.5, 1.5, 0.5, (-2.5)))|]);
  CSS.animationTimingFunctions([|`stepStart|]);
  CSS.animationTimingFunctions([|`stepEnd|]);
  CSS.animationTimingFunctions([|`steps((3, `start))|]);
  CSS.animationTimingFunctions([|`steps((5, `end_))|]);
  CSS.animationIterationCounts([|`infinite|]);
  CSS.animationIterationCounts([|`count(8.)|]);
  CSS.animationIterationCounts([|`count(4.35)|]);
  CSS.animationDirections([|`normal|]);
  CSS.animationDirections([|`alternate|]);
  CSS.animationDirections([|`reverse|]);
  CSS.animationDirections([|`alternateReverse|]);
  CSS.animationPlayStates([|`running|]);
  CSS.animationPlayStates([|`paused|]);
  CSS.animationDelays([|`s(1)|]);
  CSS.animationDelays([|`s(-1)|]);
  CSS.animationFillModes([|`none|]);
  CSS.animationFillModes([|`forwards|]);
  CSS.animationFillModes([|`backwards|]);
  CSS.animationFillModes([|`both|]);
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
