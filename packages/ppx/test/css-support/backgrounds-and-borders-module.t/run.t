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
  CssJs.unsafe({js|backgroundSize|js}, {js|auto|js});
  CssJs.backgroundSize(`cover);
  CssJs.backgroundSize(`contain);
  CssJs.unsafe({js|backgroundSize|js}, {js|10px|js});
  CssJs.unsafe({js|backgroundSize|js}, {js|50%|js});
  CssJs.unsafe({js|backgroundSize|js}, {js|10px auto|js});
  CssJs.unsafe({js|backgroundSize|js}, {js|auto 10%|js});
  CssJs.backgroundSize(`size((`em(50.), `percent(50.))));
  CssJs.unsafe({js|background|js}, {js|top left / 50% 60%|js});
  CssJs.backgroundOrigin(`borderBox);
  CssJs.backgroundColor(CssJs.blue);
  CssJs.backgroundColor(CssJs.red);
  CssJs.backgroundClip(`paddingBox);
  CssJs.unsafe(
    {js|background|js},
    {js|url(foo.png) bottom right / cover padding-box content-box|js},
  );
  CssJs.borderTopLeftRadius(`zero);
  CssJs.borderTopLeftRadius(`percent(50.));
  CssJs.unsafe({js|borderTopLeftRadius|js}, {js|250px 100px|js});
  CssJs.borderTopRightRadius(`zero);
  CssJs.borderTopRightRadius(`percent(50.));
  CssJs.unsafe({js|borderTopRightRadius|js}, {js|250px 100px|js});
  CssJs.borderBottomRightRadius(`zero);
  CssJs.borderBottomRightRadius(`percent(50.));
  CssJs.unsafe({js|borderBottomRightRadius|js}, {js|250px 100px|js});
  CssJs.borderBottomLeftRadius(`zero);
  CssJs.borderBottomLeftRadius(`percent(50.));
  CssJs.unsafe({js|borderBottomLeftRadius|js}, {js|250px 100px|js});
  CssJs.borderRadius(`pxFloat(10.));
  CssJs.borderRadius(`percent(50.));
  CssJs.borderImageSource(`none);
  CssJs.borderImageSource(`url({js|foo.png|js}));
  CssJs.unsafe({js|borderImageSlice|js}, {js|10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 10 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 30% 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 10 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 10 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 10 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 30% 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% 30% 30% 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|fill 30%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|fill 10|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|fill 2 4 8% 16%|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|30% fill|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|10 fill|js});
  CssJs.unsafe({js|borderImageSlice|js}, {js|2 4 8% 16% fill|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5%|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|28|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|auto|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px 10px|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5% 10px|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|28 10px|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|auto 10px|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px 5%|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5% 5%|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|28 5%|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|auto 5%|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px 28|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5% 28|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|28 28|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|auto 28|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px auto|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5% auto|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|28 auto|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|auto auto|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|10px 10% 10|js});
  CssJs.unsafe({js|borderImageWidth|js}, {js|5% 10px 20 auto|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|10px|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|20|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|10px 20|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|10px 20px|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|20 30|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|2px 3px 4|js});
  CssJs.unsafe({js|borderImageOutset|js}, {js|1 2px 3px 4|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|stretch|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|repeat|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|round|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|space|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|stretch stretch|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|repeat stretch|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|round stretch|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|space stretch|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|stretch repeat|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|repeat repeat|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|round repeat|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|space repeat|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|stretch round|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|repeat round|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|round round|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|space round|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|stretch space|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|repeat space|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|round space|js});
  CssJs.unsafe({js|borderImageRepeat|js}, {js|space space|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10%|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10% fill|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10 round|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10 stretch repeat|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10 / 10px|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) 10 / 10% / 10px|js});
  CssJs.unsafe({js|borderImage|js}, {js|url(foo.png) fill 10 / 10% / 10px|js});
  CssJs.unsafe(
    {js|borderImage|js},
    {js|url(foo.png) fill 10 / 10% / 10px space|js},
  );
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
  CssJs.unsafe({js|backgroundPositionX|js}, {js|right|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|center|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|50%|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|left, left|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|left, right|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|right, left|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|left, 0%|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|10%, 20%, 40%|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|0px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|30px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|0%, 10%, 20%, 30%|js});
  CssJs.unsafe(
    {js|backgroundPositionX|js},
    {js|left, left, left, left, left|js},
  );
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(20px)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(20px + 1em)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(20px / 2)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(20px + 50%)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(50% - 10px)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(-20px)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(-50%)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|calc(-20%)|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|right 20px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|left 20px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|right -50px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|left -50px|js});
  CssJs.unsafe({js|backgroundPositionX|js}, {js|right 20px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|bottom|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|center|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|50%|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top, top|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top, bottom|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|bottom, top|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top, 0%|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|10%, 20%, 40%|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|0px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|30px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|0%, 10%, 20%, 30%|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top, top, top, top, top|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(20px)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(20px + 1em)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(20px / 2)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(20px + 50%)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(50% - 10px)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(-20px)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(-50%)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|calc(-20%)|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|bottom 20px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top 20px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|bottom -50px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|top -50px|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|bottom 20px|js});
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CssJs.blue), Some(`percent(10.))),
        (Some(CssJs.red), Some(`percent(20.))),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|(Some(CssJs.blue), Some(`percent(10.))), (Some(CssJs.red), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CssJs.blue), None),
        (None, Some(`percent(10.))),
        (Some(CssJs.red), None),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`percent(50.))),
        (Some(CssJs.black), None),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), None),
        (Some(`hex({js|f06|js})), None),
        (Some(CssJs.black), None),
      |]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(Color.Background.boxDark), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(25.))),
      |]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.blue), None), (Some(CssJs.red), None)|]: Css_types.Gradient.color_stop_list,
    )),
  |]);
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.unsafe(
    {js|backgroundImage|js},
    {js|radial-gradient(60% 60%, white, black)|js},
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`percent(50.))),
        (Some(CssJs.black), None),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), Some(`pxFloat(5.))),
        (Some(CssJs.black), None),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CssJs.white), None),
        (Some(`hex({js|f06|js})), None),
        (Some(CssJs.black), None),
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `linearGradient((
      None,
      [|(Some(`currentColor), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CssJs.white), None), (Some(CssJs.black), None)|]: Css_types.Gradient.color_stop_list,
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
      |]: Css_types.Gradient.color_stop_list,
    )),
  );
  CssJs.unsafe(
    {js|listStyleImage|js},
    {js|radial-gradient(60% 60%, white, black)|js},
  );
  CssJs.imageRendering(`auto);
  CssJs.imageRendering(`smooth);
  CssJs.imageRendering(`highQuality);
  CssJs.imageRendering(`pixelated);
  CssJs.imageRendering(`crispEdges);
  CssJs.backgroundPosition(`bottom);
  CssJs.unsafe({js|backgroundPositionX|js}, {js|50%|js});
  CssJs.unsafe({js|backgroundPositionY|js}, {js|0|js});
  CssJs.backgroundPosition2(`zero, `zero);
  CssJs.backgroundPosition2(`rem(1.), `zero);
  CssJs.objectPosition2(`center, `top);
  CssJs.objectPosition2(`center, `bottom);
  CssJs.objectPosition2(`left, `center);
  CssJs.objectPosition2(`right, `center);
  CssJs.objectPosition2(`center, `center);
  CssJs.unsafe({js|objectPosition|js}, {js|25% 75%|js});
  CssJs.objectPosition2(`percent(25.), `center);
  CssJs.objectPosition2(`zero, `zero);
  CssJs.objectPosition2(`cm(1.), `cm(2.));
  CssJs.objectPosition2(`ch(10.), `em(8.));
  CssJs.unsafe({js|objectPosition|js}, {js|bottom 10px right 20px|js});
  CssJs.unsafe({js|objectPosition|js}, {js|right 3em bottom 10px|js});
  CssJs.unsafe({js|objectPosition|js}, {js|top 0 right 10px|js});
  CssJs.unsafe({js|object-position|js}, {js|inherit|js});
  CssJs.unsafe({js|object-position|js}, {js|initial|js});
  CssJs.unsafe({js|object-position|js}, {js|revert|js});
  CssJs.unsafe({js|object-position|js}, {js|revert-layer|js});
  CssJs.unsafe({js|object-position|js}, {js|unset|js});
  let _loadingKeyframes =
    CssJs.keyframes([|
      (0, [|CssJs.backgroundPosition2(`zero, `zero)|]),
      (100, [|CssJs.backgroundPosition2(`rem(1.), `zero)|]),
    |]);

