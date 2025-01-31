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
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.backgroundRepeat(`space);
  CSS.backgroundRepeat(`round);
  CSS.backgroundRepeat(`hv((`repeat, `repeat)));
  CSS.backgroundRepeat(`hv((`space, `repeat)));
  CSS.backgroundRepeat(`hv((`round, `repeat)));
  CSS.backgroundRepeat(`hv((`noRepeat, `repeat)));
  CSS.backgroundRepeat(`hv((`repeat, `space)));
  CSS.backgroundRepeat(`hv((`space, `space)));
  CSS.backgroundRepeat(`hv((`round, `space)));
  CSS.backgroundRepeat(`hv((`noRepeat, `space)));
  CSS.backgroundRepeat(`hv((`repeat, `round)));
  CSS.backgroundRepeat(`hv((`space, `round)));
  CSS.backgroundRepeat(`hv((`round, `round)));
  CSS.backgroundRepeat(`hv((`noRepeat, `round)));
  CSS.backgroundRepeat(`hv((`repeat, `noRepeat)));
  CSS.backgroundRepeat(`hv((`space, `noRepeat)));
  CSS.backgroundRepeat(`hv((`round, `noRepeat)));
  CSS.backgroundRepeat(`hv((`noRepeat, `noRepeat)));
  CSS.backgroundAttachment(`local);
  
  CSS.backgroundClip(`borderBox);
  CSS.backgroundClip(`paddingBox);
  CSS.backgroundClip(`contentBox);
  CSS.backgroundOrigin(`borderBox);
  CSS.backgroundOrigin(`paddingBox);
  CSS.backgroundOrigin(`contentBox);
  CSS.unsafe({js|backgroundSize|js}, {js|auto|js});
  CSS.backgroundSize(`cover);
  CSS.backgroundSize(`contain);
  CSS.unsafe({js|backgroundSize|js}, {js|10px|js});
  CSS.unsafe({js|backgroundSize|js}, {js|50%|js});
  CSS.unsafe({js|backgroundSize|js}, {js|10px auto|js});
  CSS.unsafe({js|backgroundSize|js}, {js|auto 10%|js});
  CSS.backgroundSize(`size((`em(50.), `percent(50.))));
  
  CSS.backgroundPosition(`hvOffset((`left, `top)));
  CSS.backgroundOrigin(`borderBox);
  CSS.backgroundColor(CSS.blue);
  CSS.backgroundColor(CSS.red);
  
  CSS.backgroundClip(`paddingBox);
  CSS.backgroundImage(`url({js|foo.png|js}));
  CSS.borderTopLeftRadius(`zero);
  CSS.borderTopLeftRadius(`percent(50.));
  CSS.unsafe({js|borderTopLeftRadius|js}, {js|250px 100px|js});
  CSS.borderTopRightRadius(`zero);
  CSS.borderTopRightRadius(`percent(50.));
  CSS.unsafe({js|borderTopRightRadius|js}, {js|250px 100px|js});
  CSS.borderBottomRightRadius(`zero);
  CSS.borderBottomRightRadius(`percent(50.));
  CSS.unsafe({js|borderBottomRightRadius|js}, {js|250px 100px|js});
  CSS.borderBottomLeftRadius(`zero);
  CSS.borderBottomLeftRadius(`percent(50.));
  CSS.unsafe({js|borderBottomLeftRadius|js}, {js|250px 100px|js});
  CSS.borderRadius(`pxFloat(10.));
  CSS.borderRadius(`percent(50.));
  
  CSS.borderImageSource(`none);
  CSS.borderImageSource(`url({js|foo.png|js}));
  CSS.unsafe({js|borderImageSlice|js}, {js|10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 10 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 30% 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 10 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 10 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 10 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 30% 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% 30% 30% 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|fill 30%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|fill 10|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|fill 2 4 8% 16%|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|30% fill|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|10 fill|js});
  CSS.unsafe({js|borderImageSlice|js}, {js|2 4 8% 16% fill|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5%|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|28|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|auto|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px 10px|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5% 10px|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|28 10px|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|auto 10px|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px 5%|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5% 5%|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|28 5%|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|auto 5%|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px 28|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5% 28|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|28 28|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|auto 28|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px auto|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5% auto|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|28 auto|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|auto auto|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|10px 10% 10|js});
  CSS.unsafe({js|borderImageWidth|js}, {js|5% 10px 20 auto|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|10px|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|20|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|10px 20|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|10px 20px|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|20 30|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|2px 3px 4|js});
  CSS.unsafe({js|borderImageOutset|js}, {js|1 2px 3px 4|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|stretch|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|repeat|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|round|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|space|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|stretch stretch|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|repeat stretch|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|round stretch|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|space stretch|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|stretch repeat|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|repeat repeat|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|round repeat|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|space repeat|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|stretch round|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|repeat round|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|round round|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|space round|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|stretch space|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|repeat space|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|round space|js});
  CSS.unsafe({js|borderImageRepeat|js}, {js|space space|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10%|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10% fill|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10 round|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10 stretch repeat|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10 / 10px|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) 10 / 10% / 10px|js});
  CSS.unsafe({js|borderImage|js}, {js|url(foo.png) fill 10 / 10% / 10px|js});
  CSS.unsafe(
    {js|borderImage|js},
    {js|url(foo.png) fill 10 / 10% / 10px space|js},
  );
  
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CSS.black,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CSS.black,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CSS.black,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CSS.black,
    ),
  |]);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(-1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(-1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
  |]);
  
  CSS.unsafe({js|backgroundPositionX|js}, {js|right|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|center|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|50%|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left, left|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left, right|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|right, left|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left, 0%|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|10%, 20%, 40%|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|0px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|30px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|0%, 10%, 20%, 30%|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left, left, left, left, left|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(20px)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(20px + 1em)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(20px / 2)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(20px + 50%)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(50% - 10px)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(-20px)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(-50%)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|calc(-20%)|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|right 20px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left 20px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|right -50px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|left -50px|js});
  CSS.unsafe({js|backgroundPositionX|js}, {js|right 20px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|bottom|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|center|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|50%|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top, top|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top, bottom|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|bottom, top|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top, 0%|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|10%, 20%, 40%|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|0px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|30px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|0%, 10%, 20%, 30%|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top, top, top, top, top|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(20px)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(20px + 1em)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(20px / 2)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(20px + 50%)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(50% - 10px)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(-20px)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(-50%)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|calc(-20%)|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|bottom 20px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top 20px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|bottom -50px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|top -50px|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|bottom 20px|js});
  
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CSS.blue), Some(`percent(10.))),
        (Some(CSS.red), Some(`percent(20.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|(Some(CSS.blue), Some(`percent(10.))), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(90.)),
      [|
        (Some(CSS.blue), None),
        (None, Some(`percent(10.))),
        (Some(CSS.red), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|(Some(CSS.white), Some(`percent(50.))), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.white), None),
        (Some(`hex({js|f06|js})), None),
        (Some(CSS.black), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  let color = `hex("333");
  CSS.backgroundImage(
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
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `repeatingLinearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`pxFloat(0.))),
        (Some(color), Some(`pxFloat(4.))),
        (Some(color), Some(`pxFloat(5.))),
        (Some(color), Some(`pxFloat(9.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(Color.Background.boxDark), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(25.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  
  CSS.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|
        (None, Some(`percent(50.))),
        (Some(CSS.white), None),
        (Some(CSS.black), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.unsafe(
    {js|backgroundImage|js},
    {js|radial-gradient(60% 60%, white, black)|js},
  );
  
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      Some(`Right),
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|(Some(CSS.white), Some(`percent(50.))), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|(Some(CSS.white), Some(`pxFloat(5.))), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.white), None),
        (Some(`hex({js|f06|js})), None),
        (Some(CSS.black), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|(Some(`currentColor), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.listStyleImage(
    `radialGradient((
      Some(`ellipse),
      None,
      None,
      [|
        (None, Some(`percent(50.))),
        (Some(CSS.white), None),
        (Some(CSS.black), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.unsafe(
    {js|listStyleImage|js},
    {js|radial-gradient(60% 60%, white, black)|js},
  );
  
  CSS.imageRendering(`auto);
  CSS.imageRendering(`smooth);
  CSS.imageRendering(`highQuality);
  CSS.imageRendering(`pixelated);
  CSS.imageRendering(`crispEdges);
  
  CSS.backgroundPositions([|`bottom|]);
  CSS.unsafe({js|backgroundPositionX|js}, {js|50%|js});
  CSS.unsafe({js|backgroundPositionY|js}, {js|0|js});
  CSS.backgroundPositions([|`hv((`zero, `zero))|]);
  CSS.backgroundPositions([|`hv((`rem(1.), `zero))|]);
  
  CSS.objectPosition(`top);
  CSS.objectPosition(`bottom);
  CSS.objectPosition(`left);
  CSS.objectPosition(`right);
  CSS.objectPosition(`center);
  
  CSS.objectPosition(`hv((`percent(25.), `percent(75.))));
  CSS.objectPosition(`percent(25.));
  
  CSS.objectPosition(`hv((`zero, `zero)));
  CSS.objectPosition(`hv((`cm(1.), `cm(2.))));
  CSS.objectPosition(`hv((`ch(10.), `em(8.))));
  
  CSS.objectPosition(
    `hvOffset((`right, `pxFloat(20.), `bottom, `pxFloat(10.))),
  );
  CSS.objectPosition(`hvOffset((`right, `em(3.), `bottom, `pxFloat(10.))));
  CSS.objectPosition(`hvOffset((`right, `pxFloat(10.), `top, `zero)));
  
  CSS.unsafe({js|objectPosition|js}, {js|inherit|js});
  CSS.unsafe({js|objectPosition|js}, {js|initial|js});
  CSS.unsafe({js|objectPosition|js}, {js|revert|js});
  CSS.unsafe({js|objectPosition|js}, {js|revert-layer|js});
  CSS.unsafe({js|objectPosition|js}, {js|unset|js});
  
  let _loadingKeyframes =
    CSS.keyframes([|
      (0, [|CSS.backgroundPositions([|`hv((`zero, `zero))|])|]),
      (100, [|CSS.backgroundPositions([|`hv((`rem(1.), `zero))|])|]),
    |]);

