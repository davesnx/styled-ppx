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
  File "input.re", line 22, characters 19-49:
  Error: This expression has type Rule.rule
         but an expression was expected of type Css_types.Transition.Value.t
  [1]

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
  CSS.transitionDelay(`s(1));
  CSS.transitionDelay(`s(-1));
  CSS.transitionList([|
    CSS.transition(
      ~duration=?Some(`s(2)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
    CSS.transition(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`s(2)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|width|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.none),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`easeIn),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?Some(`ms(200)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`linear),
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|margin-right|js})),
      (),
    ),
  |]);
  
  let property = CSS.Types.TransitionProperty.make("margin-right");
  let property2 = CSS.Types.TransitionProperty.all;
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = CSS.Types.TransitionProperty.make("opacity");
  
  CSS.transitionList([|CSS.transition(~property, ())|]);
  CSS.transitionList([|CSS.transition(~property=property2, ())|]);
  
  CSS.transitionList([|
    CSS.transition(~duration, ~delay, ~timingFunction, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration, ~delay, ~timingFunction, ~property, ()),
    CSS.transition(~duration=`s(0), ~property=property3, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction=`easeOut,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration, ~delay=`s(3), ~timingFunction, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration, ~delay, ~timingFunction=`easeOut, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~delay,
      ~timingFunction=`easeOut,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration=`ms(200), ~timingFunction=`easeIn, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration=`ms(200), ~timingFunction, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration, ~timingFunction=`easeIn, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(~duration=`ms(200), ~timingFunction=`easeIn, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.transition(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|CSS.transition(~duration=`ms(200), ~property, ())|]);
  CSS.transitionList([|
    CSS.transition(
      ~duration,
      ~property=CSS.Types.TransitionProperty.make({js|margin-right|js}),
      (),
    ),
  |]);
