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
  
  CSS.transitionProperty(`none);
  CSS.transitionProperties([|`all|]);
  CSS.transitionProperties([|`ident({js|width|js})|]);
  CSS.transitionProperties([|`ident({js|width|js}), `ident({js|height|js})|]);
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
    CSS.Transition.shorthand(
      ~duration=?Some(`s(2)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(`ident({js|margin-right|js})),
      (),
    ),
    CSS.Transition.shorthand(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(`ident({js|opacity|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`s(2)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(`ident({js|width|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(`none),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(`ident({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`easeIn),
      ~property=?Some(`ident({js|margin-right|js})),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?Some(`ms(200)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?None,
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?None,
      ~delay=?None,
      ~timingFunction=?Some(`linear),
      ~property=?None,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=?Some(`s(1)),
      ~delay=?Some(`ms(500)),
      ~timingFunction=?Some(`linear),
      ~property=?Some(`ident({js|margin-right|js})),
      (),
    ),
  |]);
  
  let property = `ident("margin-right");
  let property2 = `all;
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = `ident("opacity");
  
  CSS.transitionList([|CSS.Transition.shorthand(~property, ())|]);
  CSS.transitionList([|CSS.Transition.shorthand(~property=property2, ())|]);
  
  CSS.transitionList([|
    CSS.Transition.shorthand(~duration, ~delay, ~timingFunction, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(~duration, ~delay, ~timingFunction, ~property, ()),
    CSS.Transition.shorthand(~duration=`s(0), ~property=property3, ()),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction=`easeOut,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~delay=`s(3),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~delay,
      ~timingFunction=`easeOut,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~delay=`s(3),
      ~timingFunction,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~delay,
      ~timingFunction=`easeOut,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(~duration, ~timingFunction=`easeIn, ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction=`easeIn,
      ~property,
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~timingFunction=`easeIn,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration=`ms(200),
      ~timingFunction,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(~duration=`ms(200), ~property, ()),
  |]);
  CSS.transitionList([|
    CSS.Transition.shorthand(
      ~duration,
      ~property=`ident({js|margin-right|js}),
      (),
    ),
  |]);
