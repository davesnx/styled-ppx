This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
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
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  CssJs.backgroundRepeat(`space);
  CssJs.backgroundRepeat(`round);
  CssJs.backgroundRepeat(`hv((`repeat, `repeat)));
  CssJs.backgroundRepeat(`hv((`space, `repeat)));
  CssJs.backgroundRepeat(`hv((`round, `repeat)));
  CssJs.backgroundRepeat(`hv((`noRepeat, `repeat)));
  CssJs.backgroundRepeat(`hv((`repeat, `space)));
  CssJs.backgroundRepeat(`hv((`space, `space)));
  CssJs.backgroundRepeat(`hv((`round, `space)));
  CssJs.backgroundRepeat(`hv((`noRepeat, `space)));
  CssJs.backgroundRepeat(`hv((`repeat, `round)));
  CssJs.backgroundRepeat(`hv((`space, `round)));
  CssJs.backgroundRepeat(`hv((`round, `round)));
  CssJs.backgroundRepeat(`hv((`noRepeat, `round)));
  CssJs.backgroundRepeat(`hv((`repeat, `noRepeat)));
  CssJs.backgroundRepeat(`hv((`space, `noRepeat)));
  CssJs.backgroundRepeat(`hv((`round, `noRepeat)));
  CssJs.backgroundRepeat(`hv((`noRepeat, `noRepeat)));
  CssJs.backgroundAttachment(`local);
  CssJs.backgroundClip(`borderBox);
  CssJs.backgroundClip(`paddingBox);
  CssJs.backgroundClip(`contentBox);
  CssJs.backgroundOrigin(`borderBox);
  CssJs.backgroundOrigin(`paddingBox);
  CssJs.backgroundOrigin(`contentBox);
  CssJs.unsafe({|backgroundSize|}, {|auto|});
  CssJs.backgroundSize(`cover);
  CssJs.backgroundSize(`contain);
  CssJs.unsafe({|backgroundSize|}, {|10px|});
  CssJs.unsafe({|backgroundSize|}, {|50%|});
  CssJs.unsafe({|backgroundSize|}, {|10px auto|});
  CssJs.unsafe({|backgroundSize|}, {|auto 10%|});
  CssJs.backgroundSize(`size((`em(50.), `percent(50.))));
  CssJs.unsafe({|background|}, {|top left / 50% 60%|});
  CssJs.backgroundOrigin(`borderBox);
  CssJs.backgroundColor(CssJs.blue);
  CssJs.backgroundColor(CssJs.red);
  CssJs.backgroundClip(`paddingBox);
  CssJs.unsafe(
    {|background|},
    {|url(foo.png) bottom right / cover padding-box content-box|},
  );
  CssJs.borderTopLeftRadius(`zero);
  CssJs.borderTopLeftRadius(`percent(50.));
  CssJs.unsafe({|borderTopLeftRadius|}, {|250px 100px|});
  CssJs.borderTopRightRadius(`zero);
  CssJs.borderTopRightRadius(`percent(50.));
  CssJs.unsafe({|borderTopRightRadius|}, {|250px 100px|});
  CssJs.borderBottomRightRadius(`zero);
  CssJs.borderBottomRightRadius(`percent(50.));
  CssJs.unsafe({|borderBottomRightRadius|}, {|250px 100px|});
  CssJs.borderBottomLeftRadius(`zero);
  CssJs.borderBottomLeftRadius(`percent(50.));
  CssJs.unsafe({|borderBottomLeftRadius|}, {|250px 100px|});
  CssJs.borderRadius(`pxFloat(10.));
  CssJs.borderRadius(`percent(50.));
  CssJs.borderImageSource(`none);
  CssJs.borderImageSource(`url({|foo.png|}));
  CssJs.unsafe({|borderImageSlice|}, {|10|});
  CssJs.unsafe({|borderImageSlice|}, {|30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 10 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 30% 10|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 10 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 10 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 10 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|10 30% 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% 30% 30% 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|fill 30%|});
  CssJs.unsafe({|borderImageSlice|}, {|fill 10|});
  CssJs.unsafe({|borderImageSlice|}, {|fill 2 4 8% 16%|});
  CssJs.unsafe({|borderImageSlice|}, {|30% fill|});
  CssJs.unsafe({|borderImageSlice|}, {|10 fill|});
  CssJs.unsafe({|borderImageSlice|}, {|2 4 8% 16% fill|});
  CssJs.unsafe({|borderImageWidth|}, {|10px|});
  CssJs.unsafe({|borderImageWidth|}, {|5%|});
  CssJs.unsafe({|borderImageWidth|}, {|28|});
  CssJs.unsafe({|borderImageWidth|}, {|auto|});
  CssJs.unsafe({|borderImageWidth|}, {|10px 10px|});
  CssJs.unsafe({|borderImageWidth|}, {|5% 10px|});
  CssJs.unsafe({|borderImageWidth|}, {|28 10px|});
  CssJs.unsafe({|borderImageWidth|}, {|auto 10px|});
  CssJs.unsafe({|borderImageWidth|}, {|10px 5%|});
  CssJs.unsafe({|borderImageWidth|}, {|5% 5%|});
  CssJs.unsafe({|borderImageWidth|}, {|28 5%|});
  CssJs.unsafe({|borderImageWidth|}, {|auto 5%|});
  CssJs.unsafe({|borderImageWidth|}, {|10px 28|});
  CssJs.unsafe({|borderImageWidth|}, {|5% 28|});
  CssJs.unsafe({|borderImageWidth|}, {|28 28|});
  CssJs.unsafe({|borderImageWidth|}, {|auto 28|});
  CssJs.unsafe({|borderImageWidth|}, {|10px auto|});
  CssJs.unsafe({|borderImageWidth|}, {|5% auto|});
  CssJs.unsafe({|borderImageWidth|}, {|28 auto|});
  CssJs.unsafe({|borderImageWidth|}, {|auto auto|});
  CssJs.unsafe({|borderImageWidth|}, {|10px 10% 10|});
  CssJs.unsafe({|borderImageWidth|}, {|5% 10px 20 auto|});
  CssJs.unsafe({|borderImageOutset|}, {|10px|});
  CssJs.unsafe({|borderImageOutset|}, {|20|});
  CssJs.unsafe({|borderImageOutset|}, {|10px 20|});
  CssJs.unsafe({|borderImageOutset|}, {|10px 20px|});
  CssJs.unsafe({|borderImageOutset|}, {|20 30|});
  CssJs.unsafe({|borderImageOutset|}, {|2px 3px 4|});
  CssJs.unsafe({|borderImageOutset|}, {|1 2px 3px 4|});
  CssJs.unsafe({|borderImageRepeat|}, {|stretch|});
  CssJs.unsafe({|borderImageRepeat|}, {|repeat|});
  CssJs.unsafe({|borderImageRepeat|}, {|round|});
  CssJs.unsafe({|borderImageRepeat|}, {|space|});
  CssJs.unsafe({|borderImageRepeat|}, {|stretch stretch|});
  CssJs.unsafe({|borderImageRepeat|}, {|repeat stretch|});
  CssJs.unsafe({|borderImageRepeat|}, {|round stretch|});
  CssJs.unsafe({|borderImageRepeat|}, {|space stretch|});
  CssJs.unsafe({|borderImageRepeat|}, {|stretch repeat|});
  CssJs.unsafe({|borderImageRepeat|}, {|repeat repeat|});
  CssJs.unsafe({|borderImageRepeat|}, {|round repeat|});
  CssJs.unsafe({|borderImageRepeat|}, {|space repeat|});
  CssJs.unsafe({|borderImageRepeat|}, {|stretch round|});
  CssJs.unsafe({|borderImageRepeat|}, {|repeat round|});
  CssJs.unsafe({|borderImageRepeat|}, {|round round|});
  CssJs.unsafe({|borderImageRepeat|}, {|space round|});
  CssJs.unsafe({|borderImageRepeat|}, {|stretch space|});
  CssJs.unsafe({|borderImageRepeat|}, {|repeat space|});
  CssJs.unsafe({|borderImageRepeat|}, {|round space|});
  CssJs.unsafe({|borderImageRepeat|}, {|space space|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10%|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10% fill|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10 round|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10 stretch repeat|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10 / 10px|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) 10 / 10% / 10px|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) fill 10 / 10% / 10px|});
  CssJs.unsafe({|borderImage|}, {|url(foo.png) fill 10 / 10% / 10px space|});
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CssJs.black,
    ),
  |]);
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CssJs.black,
    ),
  |]);
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CssJs.black,
    ),
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CssJs.black,
    ),
  |]);
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(-1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CssJs.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(-1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
  |]);
  CssJs.unsafe({|backgroundPositionX|}, {|right|});
  CssJs.unsafe({|backgroundPositionX|}, {|center|});
  CssJs.unsafe({|backgroundPositionX|}, {|50%|});
  CssJs.unsafe({|backgroundPositionX|}, {|left, left|});
  CssJs.unsafe({|backgroundPositionX|}, {|left, right|});
  CssJs.unsafe({|backgroundPositionX|}, {|right, left|});
  CssJs.unsafe({|backgroundPositionX|}, {|left, 0%|});
  CssJs.unsafe({|backgroundPositionX|}, {|10%, 20%, 40%|});
  CssJs.unsafe({|backgroundPositionX|}, {|0px|});
  CssJs.unsafe({|backgroundPositionX|}, {|30px|});
  CssJs.unsafe({|backgroundPositionX|}, {|0%, 10%, 20%, 30%|});
  CssJs.unsafe({|backgroundPositionX|}, {|left, left, left, left, left|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(20px)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(20px + 1em)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(20px / 2)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(20px + 50%)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(50% - 10px)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(-20px)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(-50%)|});
  CssJs.unsafe({|backgroundPositionX|}, {|calc(-20%)|});
  CssJs.unsafe({|backgroundPositionX|}, {|right 20px|});
  CssJs.unsafe({|backgroundPositionX|}, {|left 20px|});
  CssJs.unsafe({|backgroundPositionX|}, {|right -50px|});
  CssJs.unsafe({|backgroundPositionX|}, {|left -50px|});
  CssJs.unsafe({|backgroundPositionX|}, {|right 20px|});
  CssJs.unsafe({|backgroundPositionY|}, {|bottom|});
  CssJs.unsafe({|backgroundPositionY|}, {|center|});
  CssJs.unsafe({|backgroundPositionY|}, {|50%|});
  CssJs.unsafe({|backgroundPositionY|}, {|top, top|});
  CssJs.unsafe({|backgroundPositionY|}, {|top, bottom|});
  CssJs.unsafe({|backgroundPositionY|}, {|bottom, top|});
  CssJs.unsafe({|backgroundPositionY|}, {|top, 0%|});
  CssJs.unsafe({|backgroundPositionY|}, {|10%, 20%, 40%|});
  CssJs.unsafe({|backgroundPositionY|}, {|0px|});
  CssJs.unsafe({|backgroundPositionY|}, {|30px|});
  CssJs.unsafe({|backgroundPositionY|}, {|0%, 10%, 20%, 30%|});
  CssJs.unsafe({|backgroundPositionY|}, {|top, top, top, top, top|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(20px)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(20px + 1em)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(20px / 2)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(20px + 50%)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(50% - 10px)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(-20px)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(-50%)|});
  CssJs.unsafe({|backgroundPositionY|}, {|calc(-20%)|});
  CssJs.unsafe({|backgroundPositionY|}, {|bottom 20px|});
  CssJs.unsafe({|backgroundPositionY|}, {|top 20px|});
  CssJs.unsafe({|backgroundPositionY|}, {|bottom -50px|});
  CssJs.unsafe({|backgroundPositionY|}, {|top -50px|});
  CssJs.unsafe({|backgroundPositionY|}, {|bottom 20px|});
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CssJs.blue), Some(`percent(10.))),
        (Some(CssJs.red), Some(`percent(20.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|(Some(CssJs.blue), Some(`percent(10.))), (Some(CssJs.red), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CssJs.blue), None),
        (None, Some(`percent(10.))),
        (Some(CssJs.red), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`percent(50.))),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), None),
        (Some(`hex({|f06|})), None),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.red), Some(`pxFloat(-50.))),
        (
          Some(CssJs.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CssJs.blue), Some(`percent(100.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CssJs.red), Some(`pxFloat(-50.))),
        (
          Some(CssJs.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CssJs.blue), Some(`percent(100.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  |]);
  let color = `hex("333");
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(50.))),
        (Some(color), Some(`percent(0.))),
        (Some(color), Some(`percent(75.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(100.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `repeatingLinearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`pxFloat(0.))),
        (Some(color), Some(`pxFloat(4.))),
        (Some(color), Some(`pxFloat(5.))),
        (Some(color), Some(`pxFloat(9.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(Color.Background.boxDark), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(25.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CssJs.red), Some(`pxFloat(-50.))),
        (
          Some(CssJs.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CssJs.blue), Some(`percent(100.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  |]);
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|
        (None, Some(`percent(50.))),
        (Some(CssJs.white), None),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.unsafe({|backgroundImage|}, {|radial-gradient(60% 60%, white, black)|});
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`percent(50.))),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`pxFloat(5.))),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), None),
        (Some(`hex({|f06|})), None),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|(Some(`currentColor), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.red), Some(`pxFloat(-50.))),
        (
          Some(CssJs.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CssJs.blue), Some(`percent(100.))),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|
        (None, Some(`percent(50.))),
        (Some(CssJs.white), None),
        (Some(CssJs.black), None),
      |]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.unsafe({|listStyleImage|}, {|radial-gradient(60% 60%, white, black)|});
  CssJs.imageRendering(`auto);
  CssJs.imageRendering(`smooth);
  CssJs.imageRendering(`highQuality);
  CssJs.imageRendering(`pixelated);
  CssJs.imageRendering(`crispEdges);
  CssJs.backgroundPosition(`bottom);
  CssJs.unsafe({|backgroundPositionX|}, {|50%|});
  CssJs.unsafe({|backgroundPositionY|}, {|0|});
  CssJs.backgroundPosition2(`zero, `zero);
  CssJs.backgroundPosition2(`rem(1.), `zero);
  CssJs.objectPosition2(`center, `top);
  CssJs.objectPosition2(`center, `bottom);
  CssJs.objectPosition2(`left, `center);
  CssJs.objectPosition2(`right, `center);
  CssJs.objectPosition2(`center, `center);
  CssJs.unsafe({|objectPosition|}, {|25% 75%|});
  CssJs.objectPosition2(`percent(25.), `center);
  CssJs.objectPosition2(`zero, `zero);
  CssJs.objectPosition2(`cm(1.), `cm(2.));
  CssJs.objectPosition2(`ch(10.), `em(8.));
  CssJs.unsafe({|objectPosition|}, {|bottom 10px right 20px|});
  CssJs.unsafe({|objectPosition|}, {|right 3em bottom 10px|});
  CssJs.unsafe({|objectPosition|}, {|top 0 right 10px|});
  CssJs.unsafe({|object-position|}, {|inherit|});
  CssJs.unsafe({|object-position|}, {|initial|});
  CssJs.unsafe({|object-position|}, {|revert|});
  CssJs.unsafe({|object-position|}, {|revert-layer|});
  CssJs.unsafe({|object-position|}, {|unset|});
  let _loadingKeyframes =
    CssJs.keyframes([|
      (0, [|CssJs.backgroundPosition2(`zero, `zero)|]),
      (100, [|CssJs.backgroundPosition2(`rem(1.), `zero)|]),
    |]);

