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
  
  CSS.transitionProperty(CSS.Types.TransitionProperty.none);
  CSS.transitionProperties([|CSS.Types.TransitionProperty.all|]);
  CSS.transitionProperties([|
    CSS.Types.TransitionProperty.make({js|width|js}),
  |]);
  CSS.transitionProperties([|
    CSS.Types.TransitionProperty.make({js|width|js}),
    CSS.Types.TransitionProperty.make({js|height|js}),
  |]);
  CSS.transitionDuration(`s(0));
  CSS.transitionDuration(`s(1));
  CSS.transitionDuration(`ms(100));
  CSS.transitionDurations([|`s(10), `s(30), `ms(230)|]);
  CSS.transitionTimingFunction(`ease);
  CSS.transitionTimingFunction(`linear);
  CSS.transitionTimingFunction(`easeIn);
  CSS.transitionTimingFunction(`easeOut);
  CSS.transitionTimingFunction(`easeInOut);
  CSS.transitionTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
  CSS.transitionTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
  CSS.transitionTimingFunction(`stepStart);
  CSS.transitionTimingFunction(`stepEnd);
  CSS.transitionTimingFunction(`steps((3, `start)));
  CSS.transitionTimingFunction(`steps((5, `end_)));
  CSS.transitionTimingFunctions([|
    `ease,
    `stepStart,
    `cubicBezier((0.1, 0.7, 1., 0.1)),
  |]);
  CSS.transitionDelay(`s(1));
  CSS.transitionDelay(`s(-1));
  CSS.transitionDelays([|`s(2), `ms(4)|]);
  CSS.transitionBehavior(`normal);
  CSS.transitionBehavior(`allowDiscrete);
  CSS.transitionBehaviors([|`allowDiscrete, `normal|]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`s(2)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`s(1)),
      ~delay=?Some(`s(2)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|width|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.none),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`easeIn),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`linear),
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`s(1)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?Some(`allowDiscrete),
      ~duration=?Some(`s(4)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|display|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?Some(`allowDiscrete),
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?Some(`easeOut),
      ~property=?Some(CSS.Types.TransitionProperty.all),
      (),
    ),
  |]);
  
  let property = CSS.Types.TransitionProperty.make("margin-right");
  let property2 = CSS.Types.TransitionProperty.all;
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = CSS.Types.TransitionProperty.make("opacity");
  let behavior = `allowDiscrete;
  
  CSS.transitions([|CSS.Types.Transition.Value.make(~property, ())|]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(~property=property2, ()),
  |]);
  
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior,
      ~duration,
      ~delay,
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
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
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction=`easeOut,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~delay=`s(3),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~delay,
      ~timingFunction=`easeOut,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~timingFunction=`easeIn,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      ~property,
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(~duration=`ms(200), ~property, ()),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~duration,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
