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
    };
    module Text = {
      let tertiary = `hex("999999");
      let secondary = `hex("666666");
    };
    module Background = {
      let box_ = `hex("f0f0f0");
    };
  };
  
  let _spaceBeforeColon =
    CSS.style([|
      CSS.label("_spaceBeforeColon"),
      CSS.width(`pxFloat(30.)),
      (CSS.color(Color.Text.tertiary): CSS.rule),
    |]);
  
  let _tabInnerFirst =
    CSS.style([|
      CSS.label("_tabInnerFirst"),
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
      ),
    |]);
  
  let _multiShadowImportant =
    CSS.style([|
      CSS.label("_multiShadowImportant"),
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
      ),
    |]);
  
  let _tabTextFirst =
    CSS.style([|
      CSS.label("_tabTextFirst"),
      CSS.boxShadows([|
        CSS.Shadow.box(
          ~x=`zero,
          ~y=`zero,
          ~blur=`zero,
          ~spread=`zero,
          ~inset=true,
          `transparent,
        ),
      |]),
      CSS.selectorMany(
        [|{js|:hover|js}|],
        [|
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
          ),
        |],
      ),
    |]);
  
  let _tabText =
    CSS.style([|
      CSS.label("_tabText"),
      (CSS.color(Color.Text.secondary): CSS.rule),
      CSS.selectorMany(
        [|{js|:hover|js}|],
        [|
          (CSS.backgroundColor(Color.Background.box_): CSS.rule),
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
          |]),
        |],
      ),
    |]);
  
  let sidebarClosed = CSS.style([|CSS.label("sidebarClosed")|]);
  
  let _sidebar =
    CSS.style([|
      CSS.label("_sidebar"),
      CSS.flexGrow(1.),
      CSS.zIndex(`num(1)),
      CSS.transitions([|
        CSS.Types.Transition.Value.make(
          ~behavior=?None,
          ~duration=?Some(`ms(200)),
          ~delay=?Some(`ms(0)),
          ~timingFunction=?Some(`ease),
          ~property=?Some(CSS.Types.TransitionProperty.all),
          (),
        ),
      |]),
      CSS.selectorMany(
        [|{js|&.|js} ++ sidebarClosed|],
        [|
          CSS.minWidth(`zero),
          CSS.maxWidth(`zero),
          CSS.opacity(0.),
          CSS.overflow(`hidden),
        |],
      ),
    |]);
  
  let _checkbox =
    CSS.style([|
      CSS.label("_checkbox"),
      CSS.important(
        CSS.transitions([|
          CSS.Types.Transition.Value.make(
            ~behavior=?None,
            ~duration=?Some(`ms(300)),
            ~delay=?None,
            ~timingFunction=?None,
            ~property=?
              Some(CSS.Types.TransitionProperty.make({js|transform|js})),
            (),
          ),
        |]),
      ),
    |]);
  
  let _transitions =
    CSS.style([|
      CSS.label("_transitions"),
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
          ~property=?
            Some(CSS.Types.TransitionProperty.make({js|visibility|js})),
          (),
        ),
      |]),
    |]);
  
  let _shadow1: CSS.Shadow.t =
    CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
  let _shadow2: array(CSS.Shadow.t) = [|
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
