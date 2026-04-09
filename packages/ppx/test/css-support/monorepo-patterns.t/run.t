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
  module Color = {
    module Border = {
      let line = `rgba((0, 0, 0, `num(0.1)));
      let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
      let accent = `rgba((0, 0, 255, `num(0.5)));
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
      let elevation1Bottom = `rgba((0, 0, 0, `num(0.06)));
      let elevation2 = `rgba((0, 0, 0, `num(0.1)));
      let border = `rgba((0, 0, 0, `num(0.08)));
      let elevation3 = `rgba((0, 0, 0, `num(0.15)));
      let flag = `rgba((0, 0, 0, `num(0.2)));
    };
    module Background = {
      let selectedMuted = `hex("f5f5f5");
    };
  };
  
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?Some(`ms(0)),
      ~timingFunction=?Some(`ease),
      ~property=?Some(CSS.Types.TransitionProperty.all),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(300)),
      ~delay=?Some(`ms(0)),
      ~timingFunction=?Some(`easeInOut),
      ~property=?Some(CSS.Types.TransitionProperty.all),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(300)),
      ~delay=?Some(`ms(0)),
      ~timingFunction=?Some(`easeInOut),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(150)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|left|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?Some(`easeInOut),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?None,
      ~timingFunction=?Some(`easeInOut),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?None,
      ~timingFunction=?Some(`easeInOut),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|visibility|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?None,
      ~timingFunction=?Some(`ease),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|width|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?None,
      ~timingFunction=?Some(`ease),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|height|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(200)),
      ~delay=?None,
      ~timingFunction=?Some(`ease),
      ~property=?
        Some(CSS.Types.TransitionProperty.make({js|background-color|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(300)),
      ~delay=?None,
      ~timingFunction=?None,
      ~property=?Some(CSS.Types.TransitionProperty.make({js|transform|js})),
      (),
    ),
  |]);
  
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(-1.),
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.lineAlpha,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`zero,
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.line,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(1000.),
      ~inset=true,
      Color.Background.selectedMuted,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(0.5),
      ~inset=true,
      Color.Shadow.flag,
    ),
  |]);
  
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(1.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(1.),
      ~blur=`zero,
      ~spread=`zero,
      Color.Shadow.elevation1Bottom,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(1.),
      Color.Shadow.border,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(4.),
      ~spread=`zero,
      Color.Shadow.elevation2,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(1.),
      Color.Shadow.border,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(3.),
      ~blur=`pxFloat(18.),
      ~spread=`zero,
      Color.Shadow.elevation3,
    ),
  |]);
  
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`zero,
      ~blur=`zero,
      ~spread=`zero,
      Color.Border.line,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`zero,
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.line,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(-1.),
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.line,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(1.),
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.line,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(-1.),
      ~blur=`zero,
      ~spread=`zero,
      ~inset=true,
      Color.Border.line,
    ),
  |]);
  
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(3.),
      ~spread=`zero,
      `rgba((0, 0, 0, `num(0.1))),
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(0.),
      ~blur=`pxFloat(1.),
      ~spread=`zero,
      `rgba((255, 255, 255, `num(0.5))),
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(1.),
      ~spread=`pxFloat(0.),
      `rgba((49, 46, 29, `num(0.06))),
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(2.),
      ~spread=`pxFloat(0.),
      `rgba((49, 46, 29, `num(0.04))),
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(4.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(0.),
      `rgba((49, 46, 29, `num(0.02))),
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(1.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`pxFloat(3.),
      ~blur=`pxFloat(18.),
      ~spread=`zero,
      Color.Shadow.elevation3,
    ),
  |]);
  
  CSS.border(`pxFloat(1.), `solid, Color.Border.line);
  CSS.border(`pxFloat(0.), `none, `transparent);
  CSS.borderTop(`pxFloat(1.), `solid, Color.Border.line);
  CSS.borderBottom(`pxFloat(1.), `solid, Color.Border.line);
  CSS.borderLeft(`pxFloat(1.), `solid, Color.Border.line);
  CSS.borderRight(`pxFloat(1.), `solid, Color.Border.line);
  CSS.border(`pxFloat(1.), `dashed, Color.Border.line);
  CSS.border(`pxFloat(1.), `none, Color.Border.line);
  
  CSS.outline(`pxFloat(1.), `solid, Color.Border.line);
  CSS.outline(`pxFloat(2.), `solid, Color.Border.accent);
  
  CSS.animations([|
    CSS.Types.Animation.Value.make(
      ~duration=?Some(`ms(180)),
      ~delay=?None,
      ~direction=?None,
      ~timingFunction=?Some(`easeInOut),
      ~fillMode=?Some(`forwards),
      ~playState=?None,
      ~iterationCount=?None,
      ~name=?Some(CSS.Types.AnimationName.make({js|helpMenuFadeIn|js})),
      (),
    ),
  |]);
  CSS.animations([|
    CSS.Types.Animation.Value.make(
      ~duration=?Some(`ms(80)),
      ~delay=?None,
      ~direction=?None,
      ~timingFunction=?Some(`easeOut),
      ~fillMode=?Some(`forwards),
      ~playState=?None,
      ~iterationCount=?None,
      ~name=?Some(CSS.Types.AnimationName.make({js|helpMenuFadeOut|js})),
      (),
    ),
  |]);
  
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?Some(`cubicBezier((0.25, 0.46, 0.45, 0.94))),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|height|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(500)),
      ~delay=?None,
      ~timingFunction=?Some(`cubicBezier((0.25, 0.46, 0.45, 0.94))),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  CSS.transitions([|
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(600)),
      ~delay=?None,
      ~timingFunction=?Some(`cubicBezier((0.4, 0., 0.2, 1.))),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|height|js})),
      (),
    ),
    CSS.Types.Transition.Value.make(
      ~behavior=?None,
      ~duration=?Some(`ms(600)),
      ~delay=?None,
      ~timingFunction=?Some(`cubicBezier((0.4, 0., 0.2, 1.))),
      ~property=?Some(CSS.Types.TransitionProperty.make({js|opacity|js})),
      (),
    ),
  |]);
  
  CSS.important(
    CSS.boxShadows([|
      CSS.Shadow.box(
        ~x=`pxFloat(1.),
        ~y=`zero,
        ~blur=`zero,
        ~spread=`zero,
        ~inset=true,
        `transparent,
      ),
    |]),
  );
  CSS.important(
    CSS.boxShadows([|
      CSS.Shadow.box(
        ~x=`pxFloat(1.),
        ~y=`zero,
        ~blur=`zero,
        ~spread=`zero,
        CSS.black,
      ),
    |]),
  );
  CSS.important(
    CSS.boxShadows([|
      CSS.Shadow.box(
        ~x=`pxFloat(1.),
        ~y=`zero,
        ~blur=`zero,
        ~spread=`zero,
        Color.Border.line,
      ),
      CSS.Shadow.box(
        ~x=`zero,
        ~y=`pxFloat(-1.),
        ~blur=`zero,
        ~spread=`zero,
        ~inset=true,
        Color.Border.line,
      ),
    |]),
  );
  
  CSS.important(
    CSS.transitions([|
      CSS.Types.Transition.Value.make(
        ~behavior=?None,
        ~duration=?Some(`ms(300)),
        ~delay=?None,
        ~timingFunction=?None,
        ~property=?Some(CSS.Types.TransitionProperty.make({js|transform|js})),
        (),
      ),
    |]),
  );
  
  let _shadow1: CSS.Shadow.box =
    CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
  let _shadow2: array(CSS.Shadow.box) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`px(4),
      `rgba((0, 0, 0, `num(0.1))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(6),
      ~blur=`px(15),
      `rgba((0, 0, 0, `num(0.2))),
    ),
  |];
