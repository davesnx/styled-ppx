This test ensures declaration lists accept nested selectors and `@media` blocks even when the preceding declaration omits its trailing semicolon.

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

  $ dune describe pp ./input.re | sed -n '/let _case1/,$p'
  let _case1 =
    CSS.style([|
      CSS.label("_case1"),
      CSS.backgroundColor(CSS.red),
      CSS.selectorMany(
        [|{js|&:nth-child(2n)|js}|],
        [|CSS.backgroundColor(CSS.blue)|],
      ),
    |]);
  
  let _case2 =
    CSS.style([|
      CSS.label("_case2"),
      CSS.transitions([|
        CSS.Types.Transition.Value.make(
          ~behavior=?None,
          ~duration=?Some(`ms(400)),
          ~delay=?Some(`ms(0)),
          ~timingFunction=?Some(`easeInOut),
          ~property=?
            Some(CSS.Types.TransitionProperty.make({js|max-height|js})),
          (),
        ),
      |]),
      CSS.selectorMany(
        [|{js|& > *|js}|],
        [|CSS.opacity(0.), CSS.transitionDuration(`ms(400))|],
      ),
    |]);
  
  let _case3 =
    CSS.style([|
      CSS.label("_case3"),
      CSS.marginBottom(`pxFloat(24.)),
      CSS.media({js|(min-width: 1024px)|js}, [|CSS.width(`percent(50.))|]),
    |]);
  
  let _case4 =
    CSS.style([|
      CSS.label("_case4"),
      CSS.transitions([|
        CSS.Types.Transition.Value.make(
          ~behavior=?None,
          ~duration=?Some(`ms(200)),
          ~delay=?Some(`ms(0)),
          ~timingFunction=?Some(`easeInOut),
          ~property=?
            Some(CSS.Types.TransitionProperty.make({js|transform|js})),
          (),
        ),
      |]),
      CSS.selectorMany(
        [|{js|&.contentAfterOpen|js}|],
        [|CSS.transform(CSS.translateY(`pxFloat(16.)))|],
      ),
    |]);
  
  let _case5 =
    CSS.style([|
      CSS.label("_case5"),
      CSS.borderBottom(`pxFloat(1.), `solid, CSS.black),
      CSS.selectorMany(
        [|{js|&:last-child|js}|],
        [|CSS.paddingBottom(`zero), CSS.borderBottomWidth(`zero)|],
      ),
    |]);
  
  let _case6 =
    CSS.style([|
      CSS.label("_case6"),
      CSS.justifyContent(`spaceBetween),
      CSS.media({js|(min-width: 768px)|js}, [|CSS.justifyContent(`center)|]),
    |]);
  
  let _case7 =
    CSS.style([|
      CSS.label("_case7"),
      CSS.width(`minContent),
      CSS.media(
        {js|(min-width: 1200px)|js},
        [|CSS.paddingTop(`pxFloat(8.))|],
      ),
    |]);
  
  let _case8 =
    CSS.style([|
      CSS.label("_case8"),
      CSS.height(`percent(100.)),
      CSS.selectorMany([|{js|& h4|js}|], [|CSS.padding(`zero)|]),
    |]);
  
  let _case9 =
    CSS.style([|
      CSS.label("_case9"),
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
        [|{js|&.sidebarClosed|js}|],
        [|
          CSS.minWidth(`zero),
          CSS.maxWidth(`zero),
          CSS.opacity(0.),
          CSS.overflow(`hidden),
          CSS.paddingLeft(`zero),
          CSS.paddingRight(`zero),
        |],
      ),
    |]);
  
  let _case10 =
    CSS.style([|
      CSS.label("_case10"),
      CSS.color(CSS.red),
      CSS.selectorMany([|{js|.child|js}|], [|CSS.color(CSS.blue)|]),
    |]);
  
  let _case11 =
    CSS.style([|
      CSS.label("_case11"),
      CSS.color(CSS.red),
      CSS.selectorMany([|{js|div|js}|], [|CSS.color(CSS.blue)|]),
    |]);
  
  let _case12 =
    CSS.style([|
      CSS.label("_case12"),
      CSS.color(CSS.red),
      CSS.selectorMany([|{js|#child|js}|], [|CSS.color(CSS.blue)|]),
    |]);
  
  let _case13 =
    CSS.style([|
      CSS.label("_case13"),
      CSS.color(CSS.red),
      CSS.selectorMany([|{js|svg path|js}|], [|CSS.SVG.fill(CSS.blue)|]),
    |]);

  let _case14 = borderColor =>
    CSS.style([|
      CSS.label("_case14"),
      CSS.borderBottom(`pxFloat(1.), `solid, borderColor),
      CSS.selectorMany(
        [|{js|&:last-child|js}|],
        [|CSS.paddingBottom(`zero), CSS.borderBottomWidth(`zero)|],
      ),
    |]);

  let _case15 = (marginBottom, wide) =>
    CSS.style([|
      CSS.label("_case15"),
      (CSS.marginBottom(marginBottom): CSS.rule),
      CSS.media(wide, [|CSS.width(`percent(50.))|]),
    |]);
