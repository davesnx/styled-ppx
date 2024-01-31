CssJs.verticalAlign(`baseline);
CssJs.verticalAlign(`sub);
CssJs.verticalAlign(`super);
CssJs.verticalAlign(`top);
CssJs.verticalAlign(`textTop);
CssJs.verticalAlign(`middle);
CssJs.verticalAlign(`bottom);
CssJs.verticalAlign(`textBottom);
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
CssJs.backgroundPosition(
  `hv((`hv((`right, `pxFloat(20.))), `hv((`bottom, `pxFloat(10.))))),
);
CssJs.backgroundPosition(`hv((`right, `hv((`bottom, `pxFloat(10.))))));
CssJs.backgroundPosition(`hv((`hv((`right, `pxFloat(10.))), `top)));
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
CssJs.backgroundPosition(`hv((`left, `top)));
CssJs.backgroundOrigin(`borderBox);
CssJs.backgroundColor(CssJs.blue);
CssJs.backgroundColor(CssJs.red);
CssJs.backgroundRepeat(`fixed);
CssJs.backgroundClip(`paddingBox);
CssJs.backgroundImage(`url({js|foo.png|js}));
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
    Some(`Angle(`deg(45.))),
    [|(CssJs.blue, None), (CssJs.red, None)|],
  )),
);
CssJs.backgroundImage(
  `linearGradient((
    Some(`Angle(`deg(90.))),
    [|
      (CssJs.blue, Some(`percent(10.))),
      (CssJs.red, Some(`percent(20.))),
    |],
  )),
);
CssJs.backgroundImage(
  `linearGradient((
    Some(`Angle(`deg(90.))),
    [|(CssJs.blue, Some(`percent(10.))), (CssJs.red, None)|],
  )),
);
[%ocaml.error
  "Property 'background-image' has an invalid value: 'linear-gradient(white, black)'"
];
CssJs.backgroundImage(
  `linearGradient((
    Some(`SideOrCorner(`Right)),
    [|(CssJs.white, None), (CssJs.black, None)|],
  )),
);
CssJs.backgroundImage(
  `linearGradient((
    Some(`Angle(`deg(45.))),
    [|(CssJs.white, None), (CssJs.black, None)|],
  )),
);
CssJs.backgroundImage(
  `linearGradient((
    None,
    [|
      (CssJs.white, None),
      (`hex({js|f06|js}), None),
      (CssJs.black, None),
    |],
  )),
);
CssJs.backgroundImage(
  `linearGradient((
    None,
    [|
      (CssJs.red, Some(`pxFloat(-50.))),
      (CssJs.white, Some(`calc(`add((`pxFloat(-25.), `percent(50.)))))),
      (CssJs.blue, Some(`percent(100.))),
    |],
  )),
);
CssJs.imageRendering(`auto);
CssJs.imageRendering(`smooth);
CssJs.imageRendering(`highQuality);
CssJs.imageRendering(`pixelated);
CssJs.imageRendering(`crispEdges);
CssJs.boxSizing(`borderBox);
CssJs.boxSizing(`contentBox);
CssJs.outlineStyle(`auto);
CssJs.outlineOffset(`pxFloat(-5.));
CssJs.outlineOffset(`zero);
CssJs.outlineOffset(`pxFloat(5.));
CssJs.unsafe({js|resize|js}, {js|none|js});
CssJs.unsafe({js|resize|js}, {js|both|js});
CssJs.unsafe({js|resize|js}, {js|horizontal|js});
CssJs.unsafe({js|resize|js}, {js|vertical|js});
CssJs.textOverflow(`clip);
CssJs.textOverflow(`ellipsis);
CssJs.cursor(`default);
CssJs.cursor(`none);
CssJs.cursor(`contextMenu);
CssJs.cursor(`cell);
CssJs.cursor(`verticalText);
CssJs.cursor(`alias);
CssJs.cursor(`copy);
CssJs.cursor(`noDrop);
CssJs.cursor(`notAllowed);
CssJs.cursor(`grab);
CssJs.cursor(`grabbing);
CssJs.cursor(`ewResize);
CssJs.cursor(`nsResize);
CssJs.cursor(`neswResize);
CssJs.cursor(`nwseResize);
CssJs.cursor(`colResize);
CssJs.cursor(`rowResize);
CssJs.cursor(`allScroll);
CssJs.cursor(`zoomIn);
CssJs.cursor(`zoomOut);
CssJs.unsafe({js|caretColor|js}, {js|auto|js});
CssJs.unsafe({js|caretColor|js}, {js|green|js});
CssJs.unsafe({js|appearance|js}, {js|auto|js});
CssJs.unsafe({js|appearance|js}, {js|none|js});
CssJs.textOverflow(`clip);
CssJs.textOverflow(`ellipsis);
CssJs.textOverflow(`string({js|foo|js}));
CssJs.unsafe({js|textOverflow|js}, {js|clip clip|js});
CssJs.unsafe({js|textOverflow|js}, {js|ellipsis clip|js});
CssJs.unsafe({js|textOverflow|js}, {js|'foo' clip|js});
CssJs.unsafe({js|textOverflow|js}, {js|clip ellipsis|js});
CssJs.unsafe({js|textOverflow|js}, {js|ellipsis ellipsis|js});
CssJs.unsafe({js|textOverflow|js}, {js|'foo' ellipsis|js});
CssJs.unsafe({js|textOverflow|js}, {js|clip 'foo'|js});
CssJs.unsafe({js|textOverflow|js}, {js|ellipsis 'foo'|js});
CssJs.unsafe({js|textOverflow|js}, {js|'foo' 'foo'|js});
CssJs.unsafe({js|userSelect|js}, {js|auto|js});
CssJs.unsafe({js|userSelect|js}, {js|text|js});
CssJs.unsafe({js|userSelect|js}, {js|none|js});
CssJs.unsafe({js|userSelect|js}, {js|contain|js});
CssJs.unsafe({js|userSelect|js}, {js|all|js});
CssJs.transitionProperty({js|none|js});
CssJs.transitionProperty({js|all|js});
CssJs.transitionProperty({js|width|js});
CssJs.unsafe({js|transitionProperty|js}, {js|width, height|js});
CssJs.transitionDuration(0);
CssJs.transitionDuration(1000);
CssJs.transitionDuration(100);
CssJs.transitionTimingFunction(`ease);
CssJs.transitionTimingFunction(`linear);
CssJs.transitionTimingFunction(`easeIn);
CssJs.transitionTimingFunction(`easeOut);
CssJs.transitionTimingFunction(`easeInOut);
CssJs.transitionTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
CssJs.transitionTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
CssJs.transitionTimingFunction(`stepStart);
CssJs.transitionTimingFunction(`stepEnd);
CssJs.transitionTimingFunction(`steps((3, `start)));
CssJs.transitionTimingFunction(`steps((5, `end_)));
CssJs.transitionDelay(1000);
CssJs.transitionDelay(-1000);
CssJs.unsafe({js|transition|js}, {js|1s 2s width linear|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-start)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-end)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js|steps(1, jump-both)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-none)|js});
CssJs.animationName({js|foo|js});
CssJs.unsafe({js|animationName|js}, {js|foo, bar|js});
CssJs.animationDuration(0);
CssJs.animationDuration(1000);
CssJs.animationDuration(100);
CssJs.animationTimingFunction(`ease);
CssJs.animationTimingFunction(`linear);
CssJs.animationTimingFunction(`easeIn);
CssJs.animationTimingFunction(`easeOut);
CssJs.animationTimingFunction(`easeInOut);
CssJs.animationTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
CssJs.animationTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
CssJs.animationTimingFunction(`stepStart);
CssJs.animationTimingFunction(`stepEnd);
CssJs.animationTimingFunction(`steps((3, `start)));
CssJs.animationTimingFunction(`steps((5, `end_)));
CssJs.animationIterationCount(`infinite);
CssJs.animationIterationCount(`count(8.));
CssJs.animationIterationCount(`count(4.35));
CssJs.animationDirection(`normal);
CssJs.animationDirection(`alternate);
CssJs.animationDirection(`reverse);
CssJs.animationDirection(`alternateReverse);
CssJs.animationPlayState(`running);
CssJs.animationPlayState(`paused);
CssJs.animationDelay(1000);
CssJs.animationDelay(-1000);
CssJs.animationFillMode(`none);
CssJs.animationFillMode(`forwards);
CssJs.animationFillMode(`backwards);
CssJs.animationFillMode(`both);
CssJs.animation(
  ~duration=2000,
  ~delay=1000,
  ~direction=`alternate,
  ~timingFunction=`linear,
  ~fillMode=`both,
  ~playState=`running,
  ~iterationCount=`infinite,
  {js|foo|js},
);
CssJs.transform(`none);
CssJs.transform(CssJs.translate(`pxFloat(5.), 0));
CssJs.transform(CssJs.translate(`pxFloat(5.), `pxFloat(10.)));
CssJs.transform(CssJs.translateY(`pxFloat(5.)));
CssJs.transform(CssJs.translateX(`pxFloat(5.)));
CssJs.transform(CssJs.translateY(`percent(5.)));
CssJs.transform(CssJs.translateX(`percent(5.)));
CssJs.transform(CssJs.scale(2., 2.));
CssJs.transform(CssJs.scale(2., -1.));
CssJs.transform(CssJs.scaleX(2.));
CssJs.transform(CssJs.scaleY(2.5));
CssJs.transform(CssJs.rotate(`deg(45.)));
CssJs.transform(CssJs.skew(`deg(45.), 0));
CssJs.transform(CssJs.skew(`deg(45.), `deg(15.)));
CssJs.transform(CssJs.skewX(`deg(45.)));
CssJs.transform(CssJs.skewY(`deg(45.)));
CssJs.transforms([|
  CssJs.translate(`pxFloat(50.), `pxFloat(-24.)),
  CssJs.skew(`deg(0.), `deg(22.5)),
|]);
CssJs.transform(CssJs.translate3d(`zero, `zero, `pxFloat(5.)));
CssJs.transform(CssJs.translateZ(`pxFloat(5.)));
CssJs.transform(CssJs.scale3d(1., 0., -1.));
CssJs.transform(CssJs.scaleZ(1.5));
CssJs.transform(CssJs.rotate3d(1., 1., 1., `deg(45.)));
CssJs.transform(CssJs.rotateX(`deg(-45.)));
CssJs.transform(CssJs.rotateY(`deg(-45.)));
CssJs.transform(CssJs.rotateZ(`deg(-45.)));
CssJs.transforms([|
  CssJs.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
  CssJs.rotate3d(1., 2., 3., `deg(180.)),
  CssJs.scale3d(-1., 0., 0.5),
|]);
CssJs.unsafe({js|transform|js}, {js|perspective(600px)|js});
CssJs.unsafe({js|transformOrigin|js}, {js|10px|js});
CssJs.transformOrigin(`Top, `Center);
CssJs.transformOrigin(`top, `left);
CssJs.transformOrigin(`percent(50.), `percent(100.));
CssJs.transformOrigin(`percent(0.), `left);
CssJs.unsafe({js|transformOrigin|js}, {js|left 50% 0|js});
CssJs.transformBox(`borderBox);
CssJs.transformBox(`fillBox);
CssJs.transformBox(`viewBox);
CssJs.transformBox(`contentBox);
CssJs.transformBox(`strokeBox);
CssJs.unsafe({js|translate|js}, {js|none|js});
CssJs.unsafe({js|translate|js}, {js|50%|js});
CssJs.unsafe({js|translate|js}, {js|50% 50%|js});
CssJs.unsafe({js|translate|js}, {js|50% 50% 10px|js});
CssJs.unsafe({js|scale|js}, {js|none|js});
CssJs.unsafe({js|scale|js}, {js|2|js});
CssJs.unsafe({js|scale|js}, {js|2 2|js});
CssJs.unsafe({js|scale|js}, {js|2 2 2|js});
CssJs.unsafe({js|rotate|js}, {js|none|js});
CssJs.unsafe({js|rotate|js}, {js|45deg|js});
CssJs.unsafe({js|rotate|js}, {js|x 45deg|js});
CssJs.unsafe({js|rotate|js}, {js|y 45deg|js});
CssJs.unsafe({js|rotate|js}, {js|z 45deg|js});
CssJs.unsafe({js|rotate|js}, {js|-1 0 2 45deg|js});
CssJs.unsafe({js|rotate|js}, {js|45deg x|js});
CssJs.unsafe({js|rotate|js}, {js|45deg y|js});
CssJs.unsafe({js|rotate|js}, {js|45deg z|js});
CssJs.unsafe({js|rotate|js}, {js|45deg -1 0 2|js});
CssJs.transformStyle(`flat);
CssJs.transformStyle(`preserve3d);
CssJs.unsafe({js|perspective|js}, {js|none|js});
CssJs.unsafe({js|perspective|js}, {js|600px|js});
CssJs.perspectiveOrigin(`pxFloat(10.), `center);
CssJs.perspectiveOrigin(`center, `top);
CssJs.perspectiveOrigin(`left, `top);
CssJs.unsafe({js|perspectiveOrigin|js}, {js|50% 100%|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js|left 0%|js});
CssJs.backfaceVisibility(`visible);
CssJs.backfaceVisibility(`hidden);
CssJs.unsafe({js|offset|js}, {js|none|js});
CssJs.unsafe({js|offset|js}, {js|auto|js});
CssJs.unsafe({js|offset|js}, {js|center|js});
CssJs.unsafe({js|offset|js}, {js|200px 100px|js});
CssJs.unsafe({js|offset|js}, {js|margin-box|js});
CssJs.unsafe({js|offset|js}, {js|border-box|js});
CssJs.unsafe({js|offset|js}, {js|padding-box|js});
CssJs.unsafe({js|offset|js}, {js|content-box|js});
CssJs.unsafe({js|offset|js}, {js|fill-box|js});
CssJs.unsafe({js|offset|js}, {js|stroke-box|js});
CssJs.unsafe({js|offset|js}, {js|view-box|js});
CssJs.unsafe({js|offset|js}, {js|path('M 20 20 H 80 V 30')|js});
CssJs.unsafe({js|offset|js}, {js|url(image.png)|js});
CssJs.unsafe({js|offset|js}, {js|ray(45deg closest-side)|js});
CssJs.unsafe({js|offset|js}, {js|ray(45deg closest-side) 10%|js});
CssJs.unsafe({js|offset|js}, {js|ray(45deg closest-side) 10% reverse|js});
CssJs.unsafe({js|offset|js}, {js|ray(45deg closest-side) reverse 10%|js});
CssJs.unsafe({js|offset|js}, {js|auto / center|js});
CssJs.unsafe({js|offset|js}, {js|center / 200px 100px|js});
CssJs.unsafe({js|offset|js}, {js|ray(45deg closest-side) / 200px 100px|js});
CssJs.unsafe({js|offsetPath|js}, {js|none|js});
CssJs.unsafe({js|offsetPath|js}, {js|ray(45deg closest-side)|js});
CssJs.unsafe({js|offsetPath|js}, {js|ray(45deg farthest-side)|js});
CssJs.unsafe({js|offsetPath|js}, {js|ray(45deg closest-corner)|js});
CssJs.unsafe({js|offsetPath|js}, {js|ray(45deg farthest-corner)|js});
CssJs.unsafe({js|offsetPath|js}, {js|ray(100grad closest-side contain)|js});
CssJs.unsafe({js|offsetPath|js}, {js|margin-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|border-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|padding-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|content-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|fill-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|stroke-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|view-box|js});
CssJs.unsafe({js|offsetPath|js}, {js|circle(60%) margin-box|js});
CssJs.unsafe({js|offsetDistance|js}, {js|10%|js});
CssJs.unsafe({js|offsetPosition|js}, {js|auto|js});
CssJs.unsafe({js|offsetPosition|js}, {js|200px|js});
CssJs.unsafe({js|offsetPosition|js}, {js|200px 100px|js});
CssJs.unsafe({js|offsetPosition|js}, {js|center|js});
CssJs.unsafe({js|offsetAnchor|js}, {js|auto|js});
CssJs.unsafe({js|offsetAnchor|js}, {js|200px|js});
CssJs.unsafe({js|offsetAnchor|js}, {js|200px 100px|js});
CssJs.unsafe({js|offsetAnchor|js}, {js|center|js});
CssJs.unsafe({js|offsetRotate|js}, {js|auto|js});
CssJs.unsafe({js|offsetRotate|js}, {js|0deg|js});
CssJs.unsafe({js|offsetRotate|js}, {js|reverse|js});
CssJs.unsafe({js|offsetRotate|js}, {js|-45deg|js});
CssJs.unsafe({js|offsetRotate|js}, {js|auto 180deg|js});
CssJs.unsafe({js|offsetRotate|js}, {js|reverse 45deg|js});
CssJs.unsafe({js|offsetRotate|js}, {js|2turn reverse|js});
CssJs.unsafe({js|textTransform|js}, {js|full-width|js});
CssJs.unsafe({js|textTransform|js}, {js|full-size-kana|js});
CssJs.unsafe({js|tabSize|js}, {js|4|js});
CssJs.unsafe({js|tabSize|js}, {js|1em|js});
CssJs.lineBreak(`auto);
CssJs.lineBreak(`loose);
CssJs.lineBreak(`normal);
CssJs.lineBreak(`strict);
CssJs.lineBreak(`anywhere);
CssJs.wordBreak(`normal);
CssJs.wordBreak(`keepAll);
CssJs.wordBreak(`breakAll);
CssJs.whiteSpace(`breakSpaces);
CssJs.hyphens(`auto);
CssJs.hyphens(`manual);
CssJs.hyphens(`none);
CssJs.overflowWrap(`normal);
CssJs.unsafe({js|overflowWrap|js}, {js|break-word|js});
CssJs.overflowWrap(`anywhere);
CssJs.wordWrap(`normal);
CssJs.unsafe({js|wordWrap|js}, {js|break-word|js});
CssJs.wordWrap(`anywhere);
CssJs.textAlign(`start);
CssJs.textAlign(`end_);
CssJs.textAlign(`left);
CssJs.textAlign(`right);
CssJs.textAlign(`center);
CssJs.textAlign(`justify);
CssJs.textAlign(`matchParent);
CssJs.textAlign(`justifyAll);
CssJs.textAlignAll(`start);
CssJs.textAlignAll(`end_);
CssJs.textAlignAll(`left);
CssJs.textAlignAll(`right);
CssJs.textAlignAll(`center);
CssJs.textAlignAll(`justify);
CssJs.textAlignAll(`matchParent);
CssJs.textAlignLast(`auto);
CssJs.textAlignLast(`start);
CssJs.textAlignLast(`end_);
CssJs.textAlignLast(`left);
CssJs.textAlignLast(`right);
CssJs.textAlignLast(`center);
CssJs.textAlignLast(`justify);
CssJs.textAlignLast(`matchParent);
CssJs.textJustify(`auto);
CssJs.textJustify(`none);
CssJs.textJustify(`interWord);
CssJs.textJustify(`InterCharacter);
CssJs.wordSpacing(`percent(50.));
CssJs.unsafe({js|textIndent|js}, {js|1em hanging|js});
CssJs.unsafe({js|textIndent|js}, {js|1em each-line|js});
CssJs.unsafe({js|textIndent|js}, {js|1em hanging each-line|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|none|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|first|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|force-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|allow-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|first last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|first force-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|first force-end last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js|first allow-end last|js});
CssJs.textDecoration(`underline);
CssJs.textDecorationLine(`none);
CssJs.textDecorationLine(`underline);
CssJs.textDecorationLine(`overline);
CssJs.textDecorationLine(`lineThrough);
CssJs.unsafe({js|textDecorationLine|js}, {js|underline overline|js});
CssJs.textDecorationColor(CssJs.white);
CssJs.textDecorationStyle(`solid);
CssJs.textDecorationStyle(`double);
CssJs.textDecorationStyle(`dotted);
CssJs.textDecorationStyle(`dashed);
CssJs.textDecorationStyle(`wavy);
CssJs.unsafe({js|textUnderlinePosition|js}, {js|auto|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js|under|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js|left|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js|right|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js|under left|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js|under right|js});
CssJs.textEmphasisStyle(`none);
CssJs.textEmphasisStyle(`filled);
CssJs.textEmphasisStyle(`open_);
CssJs.textEmphasisStyle(`dot);
CssJs.textEmphasisStyle(`circle);
CssJs.textEmphasisStyle(`double_circle);
CssJs.textEmphasisStyle(`triangle);
CssJs.textEmphasisStyle(`sesame);
CssJs.textEmphasisStyles(`open_, `dot);
CssJs.textEmphasisStyle(`string({js|foo|js}));
CssJs.textEmphasisColor(CssJs.green);
CssJs.unsafe({js|textEmphasis|js}, {js|open dot green|js});
[%ocaml.error
  "Property 'text-emphasis-position' has an invalid value: 'left'"
];
CssJs.textEmphasisPosition(`over);
CssJs.textEmphasisPosition(`under);
CssJs.textEmphasisPositions(`over, `left);
CssJs.textEmphasisPositions(`over, `right);
CssJs.textEmphasisPositions(`under, `left);
CssJs.textEmphasisPositions(`under, `left);
CssJs.textEmphasisPositions(`under, `right);
CssJs.textShadow(`none);
CssJs.textShadow(
  CssJs.Shadow.text(
    ~x=`pxFloat(1.),
    ~y=`pxFloat(2.),
    ~blur=`pxFloat(3.),
    CssJs.black,
  ),
);
CssJs.textDecoration(`underline);
CssJs.unsafe({js|textDecorationSkip|js}, {js|none|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects leading-spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects trailing-spaces|js});
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js|objects leading-spaces trailing-spaces|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js|objects leading-spaces trailing-spaces edges|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js|objects leading-spaces trailing-spaces edges box-decoration|js},
);
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects edges|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|objects box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|spaces edges|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|spaces edges box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|spaces box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|leading-spaces|js});
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js|leading-spaces trailing-spaces edges|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js|leading-spaces trailing-spaces edges box-decoration|js},
);
CssJs.unsafe({js|textDecorationSkip|js}, {js|edges|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|edges box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js|box-decoration|js});
CssJs.textDecorationSkipInk(`none);
CssJs.textDecorationSkipInk(`auto);
CssJs.textDecorationSkipInk(`all);
CssJs.textDecorationSkipBox(`none);
CssJs.textDecorationSkipBox(`all);
CssJs.textDecorationSkipInset(`none);
CssJs.textDecorationSkipInset(`auto);
CssJs.unsafe({js|textUnderlineOffset|js}, {js|auto|js});
CssJs.unsafe({js|textUnderlineOffset|js}, {js|3px|js});
CssJs.unsafe({js|textUnderlineOffset|js}, {js|10%|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js|auto|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js|from-font|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js|3px|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js|10%|js});
CssJs.unsafe({js|quotes|js}, {js|auto|js});
CssJs.unsafe({js|content|js}, {js|"\25BA" / ""|js});
CssJs.fontFamilies([|`custom({js|Inter Semi Bold|js})|]);
CssJs.fontFamilies(fonts: array(Css_AtomicTypes.FontFamilyName.t));
CssJs.fontFamilies([|`custom({js|Inter|js})|]);
CssJs.fontFamilies(font: array(Css_AtomicTypes.FontFamilyName.t));
CssJs.fontFamilies([|`custom({js|Inter|js}), `custom({js|Sans|js})|]);
CssJs.fontFamilies([|`custom({js|Inter|js}), font|]);
CssJs.fontFamilies([|`custom({js|Gill Sans Extrabold|js}), `sansSerif|]);
CssJs.unsafe({js|fontStretch|js}, {js|normal|js});
CssJs.unsafe({js|fontStretch|js}, {js|ultra-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js|extra-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js|condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js|semi-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js|semi-expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js|expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js|extra-expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js|ultra-expanded|js});
CssJs.unsafe({js|fontSizeAdjust|js}, {js|none|js});
CssJs.unsafe({js|fontSizeAdjust|js}, {js|.5|js});
CssJs.unsafe({js|fontSynthesis|js}, {js|none|js});
CssJs.unsafe({js|fontSynthesis|js}, {js|weight|js});
CssJs.unsafe({js|fontSynthesis|js}, {js|style|js});
CssJs.unsafe({js|fontSynthesis|js}, {js|weight style|js});
CssJs.unsafe({js|fontSynthesis|js}, {js|style weight|js});
CssJs.fontKerning(`auto);
CssJs.fontKerning(`normal);
CssJs.fontKerning(`none);
CssJs.fontVariantPosition(`normal);
CssJs.fontVariantPosition(`sub);
CssJs.fontVariantPosition(`super);
CssJs.unsafe({js|fontVariantLigatures|js}, {js|normal|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|none|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|common-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-common-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|discretionary-ligatures|js});
CssJs.unsafe(
  {js|fontVariantLigatures|js},
  {js|no-discretionary-ligatures|js},
);
CssJs.unsafe({js|fontVariantLigatures|js}, {js|historical-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-historical-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|contextual|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-contextual|js});
CssJs.unsafe(
  {js|fontVariantLigatures|js},
  {js|common-ligatures discretionary-ligatures historical-ligatures contextual|js},
);
CssJs.fontVariantCaps(`normal);
CssJs.fontVariantCaps(`smallCaps);
CssJs.fontVariantCaps(`allSmallCaps);
CssJs.fontVariantCaps(`petiteCaps);
CssJs.fontVariantCaps(`allPetiteCaps);
CssJs.fontVariantCaps(`titlingCaps);
CssJs.fontVariantCaps(`unicase);
CssJs.unsafe({js|fontVariantNumeric|js}, {js|normal|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|lining-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|oldstyle-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|proportional-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|tabular-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|diagonal-fractions|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|stacked-fractions|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|ordinal|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js|slashed-zero|js});
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js|lining-nums proportional-nums diagonal-fractions|js},
);
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js|oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|js},
);
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js|slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|js},
);
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|normal|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis78|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis83|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis90|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis04|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|simplified|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|traditional|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|full-width|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|proportional-width|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js|ruby|js});
CssJs.unsafe(
  {js|fontVariantEastAsian|js},
  {js|simplified full-width ruby|js},
);
CssJs.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|'c2sc'|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|'smcp' on|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|'liga' off|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|'smcp', 'swsh' 2|js});
CssJs.fontSynthesisWeight(`none);
CssJs.fontSynthesisStyle(`auto);
CssJs.fontSynthesisSmallCaps(`none);
CssJs.fontSynthesisPosition(`auto);
CssJs.fontSize(`xxx_large);
CssJs.unsafe({|fontVariant|}, {|none|});
CssJs.fontVariant(`normal);
CssJs.unsafe({js|fontVariant|js}, {js|all-petite-caps|js});
CssJs.unsafe({js|fontVariant|js}, {js|historical-forms|js});
CssJs.unsafe({js|fontVariant|js}, {js|super|js});
CssJs.unsafe({js|fontVariant|js}, {js|sub lining-nums contextual ruby|js});
CssJs.unsafe({js|fontVariant|js}, {js|annotation(circled)|js});
CssJs.unsafe(
  {js|fontVariant|js},
  {js|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|js},
);
CssJs.unsafe({js|fontVariantAlternates|js}, {js|normal|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js|historical-forms|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js|styleset(ss01)|js});
CssJs.unsafe(
  {js|fontVariantAlternates|js},
  {js|styleset(stacked-g, geometric-m)|js},
);
CssJs.unsafe({js|fontVariantAlternates|js}, {js|character-variant(cv02)|js});
CssJs.unsafe(
  {js|fontVariantAlternates|js},
  {js|character-variant(beta-3, gamma)|js},
);
CssJs.unsafe({js|fontVariantAlternates|js}, {js|swash(flowing)|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js|ornaments(leaves)|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js|annotation(blocky)|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js|'swsh' 2|js});
CssJs.unsafe({js|fontLanguageOverride|js}, {js|normal|js});
CssJs.unsafe({js|fontLanguageOverride|js}, {js|'SRB'|js});
CssJs.fontWeight(`num(1));
CssJs.fontWeight(`num(90));
CssJs.fontWeight(`num(750));
CssJs.fontWeight(`num(1000));
CssJs.unsafe({js|fontStyle|js}, {js|oblique 15deg|js});
CssJs.unsafe({js|fontStyle|js}, {js|oblique -15deg|js});
CssJs.unsafe({js|fontStyle|js}, {js|oblique 0deg|js});
CssJs.fontOpticalSizing(`none);
CssJs.fontOpticalSizing(`auto);
CssJs.unsafe({js|fontPalette|js}, {js|normal|js});
CssJs.unsafe({js|fontPalette|js}, {js|light|js});
CssJs.unsafe({js|fontPalette|js}, {js|dark|js});
CssJs.fontVariantEmoji(`normal);
CssJs.fontVariantEmoji(`text);
CssJs.fontVariantEmoji(`emoji);
CssJs.fontVariantEmoji(`unicode);
CssJs.unsafe({js|direction|js}, {js|ltr|js});
CssJs.unsafe({js|direction|js}, {js|rtl|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|normal|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|embed|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|isolate|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|bidi-override|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|isolate-override|js});
CssJs.unsafe({js|unicodeBidi|js}, {js|plaintext|js});
CssJs.unsafe({js|writingMode|js}, {js|horizontal-tb|js});
CssJs.unsafe({js|writingMode|js}, {js|vertical-rl|js});
CssJs.unsafe({js|writingMode|js}, {js|vertical-lr|js});
CssJs.unsafe({js|textOrientation|js}, {js|mixed|js});
CssJs.unsafe({js|textOrientation|js}, {js|upright|js});
CssJs.unsafe({js|textOrientation|js}, {js|sideways|js});
CssJs.unsafe({js|textCombineUpright|js}, {js|none|js});
CssJs.unsafe({js|textCombineUpright|js}, {js|all|js});
CssJs.unsafe({js|writingMode|js}, {js|sideways-rl|js});
CssJs.unsafe({js|writingMode|js}, {js|sideways-lr|js});
CssJs.unsafe({js|textCombineUpright|js}, {js|digits 2|js});
CssJs.color(`rgba((0, 0, 0, `num(0.5))));
CssJs.color(`hex({js|F06|js}));
CssJs.color(`hex({js|FF0066|js}));
CssJs.unsafe({js|color|js}, {js|hsl(0,0%,0%)|js});
CssJs.unsafe({js|color|js}, {js|hsl(0,0%,0%,.5)|js});
CssJs.color(`transparent);
CssJs.color(`currentColor);
CssJs.backgroundColor(`rgba((0, 0, 0, `num(0.5))));
CssJs.backgroundColor(`hex({js|F06|js}));
CssJs.backgroundColor(`hex({js|FF0066|js}));
CssJs.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%)|js});
CssJs.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%,.5)|js});
CssJs.backgroundColor(`transparent);
CssJs.backgroundColor(`currentColor);
CssJs.borderColor(`rgba((0, 0, 0, `num(0.5))));
CssJs.borderColor(`hex({js|F06|js}));
CssJs.borderColor(`hex({js|FF0066|js}));
CssJs.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%)|js});
CssJs.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%,.5)|js});
CssJs.borderColor(`transparent);
CssJs.borderColor(`currentColor);
CssJs.textDecorationColor(`rgba((0, 0, 0, `num(0.5))));
CssJs.textDecorationColor(`hex({js|F06|js}));
CssJs.textDecorationColor(`hex({js|FF0066|js}));
CssJs.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%)|js});
CssJs.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%,.5)|js});
CssJs.textDecorationColor(`transparent);
CssJs.textDecorationColor(`currentColor);
CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0,0,0,.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|#F06|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|#FF0066|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%,.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|transparent|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|currentColor|js});
CssJs.color(`rgb((0, 51, 178)));
CssJs.color(`rgb((0, 64, 185)));
CssJs.color(`hsl((`deg(0.), `percent(0.), `percent(0.))));
CssJs.color(`rgba((0, 51, 178, `percent(0.5))));
CssJs.color(`rgba((0, 51, 178, `num(0.5))));
CssJs.color(`rgba((0, 64, 185, `percent(0.5))));
CssJs.color(`rgba((0, 64, 185, `num(0.5))));
CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
CssJs.color(`rgba((0, 51, 178, `percent(0.5))));
CssJs.color(`rgba((0, 51, 178, `num(0.5))));
CssJs.color(`rgba((0, 64, 185, `percent(0.5))));
CssJs.color(`rgba((0, 64, 185, `num(0.5))));
CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
CssJs.color(`hex({js|000F|js}));
CssJs.color(`hex({js|000000FF|js}));
CssJs.color(CssJs.rebeccapurple);
CssJs.backgroundColor(`rgb((0, 51, 178)));
CssJs.backgroundColor(`rgb((0, 64, 185)));
CssJs.backgroundColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.backgroundColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.backgroundColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.backgroundColor(`hex({js|000F|js}));
CssJs.backgroundColor(`hex({js|000000FF|js}));
CssJs.backgroundColor(CssJs.rebeccapurple);
CssJs.borderColor(`rgb((0, 51, 178)));
CssJs.borderColor(`rgb((0, 64, 185)));
CssJs.borderColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.borderColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.borderColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.borderColor(`hex({js|000F|js}));
CssJs.borderColor(`hex({js|000000FF|js}));
CssJs.borderColor(CssJs.rebeccapurple);
CssJs.textDecorationColor(`rgb((0, 51, 178)));
CssJs.textDecorationColor(`rgb((0, 64, 185)));
CssJs.textDecorationColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.textDecorationColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
CssJs.textDecorationColor(
  `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
);
CssJs.textDecorationColor(`hex({js|000F|js}));
CssJs.textDecorationColor(`hex({js|000000FF|js}));
CssJs.textDecorationColor(CssJs.rebeccapurple);
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|hsla(0 0% 0% /.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|#000F|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|#000000FF|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|rebeccapurple|js});
CssJs.unsafe({js|colorAdjust|js}, {js|economy|js});
CssJs.unsafe({js|colorAdjust|js}, {js|exact|js});
CssJs.unsafe({js|forcedColorAdjust|js}, {js|auto|js});
CssJs.unsafe({js|forcedColorAdjust|js}, {js|none|js});
CssJs.unsafe({js|forcedColorAdjust|js}, {js|preserve-parent-color|js});
CssJs.unsafe({js|colorScheme|js}, {js|normal|js});
CssJs.unsafe({js|colorScheme|js}, {js|light|js});
CssJs.unsafe({js|colorScheme|js}, {js|dark|js});
CssJs.unsafe({js|colorScheme|js}, {js|light dark|js});
CssJs.unsafe({js|colorScheme|js}, {js|dark light|js});
CssJs.unsafe({js|colorScheme|js}, {js|only light|js});
CssJs.unsafe({js|colorScheme|js}, {js|light only|js});
CssJs.unsafe({js|colorScheme|js}, {js|light light|js});
CssJs.unsafe({js|colorScheme|js}, {js|dark dark|js});
CssJs.unsafe({js|colorScheme|js}, {js|light purple|js});
CssJs.unsafe({js|colorScheme|js}, {js|purple dark interesting|js});
CssJs.unsafe({js|colorScheme|js}, {js|none|js});
CssJs.unsafe({js|colorScheme|js}, {js|light none|js});
CssJs.columnWidth(`em(10.));
CssJs.columnWidth(`auto);
CssJs.unsafe({js|columnCount|js}, {js|2|js});
CssJs.unsafe({js|columnCount|js}, {js|auto|js});
CssJs.unsafe({js|columns|js}, {js|100px|js});
CssJs.unsafe({js|columns|js}, {js|3|js});
CssJs.unsafe({js|columns|js}, {js|10em 2|js});
CssJs.unsafe({js|columns|js}, {js|auto auto|js});
CssJs.unsafe({js|columns|js}, {js|2 10em|js});
CssJs.unsafe({js|columns|js}, {js|auto 10em|js});
CssJs.unsafe({js|columns|js}, {js|2 auto|js});
CssJs.unsafe({js|columnRuleColor|js}, {js|red|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js|none|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js|solid|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js|dotted|js});
CssJs.unsafe({js|columnRuleWidth|js}, {js|1px|js});
CssJs.unsafe({js|columnRule|js}, {js|transparent|js});
CssJs.unsafe({js|columnRule|js}, {js|1px solid black|js});
CssJs.unsafe({js|columnSpan|js}, {js|none|js});
CssJs.unsafe({js|columnSpan|js}, {js|all|js});
CssJs.unsafe({js|columnFill|js}, {js|auto|js});
CssJs.unsafe({js|columnFill|js}, {js|balance|js});
CssJs.unsafe({js|columnFill|js}, {js|balance-all|js});
CssJs.width(`rem(5.));
CssJs.width(`ch(5.));
CssJs.width(`vw(5.));
CssJs.width(`vh(5.));
CssJs.width(`vmin(5.));
CssJs.width(`vmax(5.));
CssJs.width(`calc(`add((`pxFloat(1.), `pxFloat(2.)))));
CssJs.width(`calc(`mult((`pxFloat(5.), `one(2.)))));
CssJs.width(`calc(`mult((`pxFloat(5.), `one(2.)))));
CssJs.width(`calc(`sub((`pxFloat(5.), `pxFloat(10.)))));
CssJs.width(`calc(`sub((`vw(1.), `pxFloat(1.)))));
CssJs.width(`percent(100.));
CssJs.padding(`rem(5.));
CssJs.padding(`ch(5.));
CssJs.padding(`vw(5.));
CssJs.padding(`vh(5.));
CssJs.padding(`vmin(5.));
CssJs.padding(`vmax(5.));
CssJs.alignContent(`flexStart);
CssJs.alignContent(`flexEnd);
CssJs.alignContent(`spaceBetween);
CssJs.alignContent(`spaceAround);
CssJs.alignItems(`flexStart);
CssJs.alignItems(`flexEnd);
CssJs.alignSelf(`flexStart);
CssJs.alignSelf(`flexEnd);
CssJs.display(`flex);
CssJs.display(`inlineFlex);
CssJs.flex1(`none);
CssJs.flex(5., 7., `percent(10.));
CssJs.flex1(`num(2.));
CssJs.flexBasics(`em(10.));
CssJs.flexBasics(`percent(30.));
CssJs.flexBasics(`minContent);
CssJs.flex2(~basis=`pxFloat(30.), 1.);
CssJs.flex2(~shrink=2., 2.);
CssJs.flex(2., 2., `percent(10.));
CssJs.flex1(X.value);
CssJs.flex2(~shrink=X.value, X.value);
CssJs.flex(X.value, X.value, X.value);
CssJs.flexBasis(`auto);
CssJs.flexBasis(`content);
CssJs.flexBasis(`pxFloat(1.));
CssJs.flexDirection(`row);
CssJs.flexDirection(`rowReverse);
CssJs.flexDirection(`column);
CssJs.flexDirection(`columnReverse);
CssJs.flexDirection(`row);
CssJs.flexDirection(`rowReverse);
CssJs.flexDirection(`column);
CssJs.flexDirection(`columnReverse);
CssJs.flexWrap(`wrap);
CssJs.flexWrap(`wrapReverse);
CssJs.flexGrow(0.);
CssJs.flexGrow(5.);
CssJs.flexShrink(1.);
CssJs.flexShrink(10.);
CssJs.flexWrap(`nowrap);
CssJs.flexWrap(`wrap);
CssJs.flexWrap(`wrapReverse);
CssJs.justifyContent(`flexStart);
CssJs.justifyContent(`flexEnd);
CssJs.justifyContent(`spaceBetween);
CssJs.justifyContent(`spaceAround);
CssJs.unsafe({js|minHeight|js}, {js|auto|js});
CssJs.unsafe({js|minWidth|js}, {js|auto|js});
CssJs.order(0);
CssJs.order(1);
CssJs.display(`grid);
CssJs.display(`inlineGrid);
CssJs.unsafe({js|gridTemplateColumns|js}, {js|none|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|auto|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|100px|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|1fr|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|100px 1fr auto|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|repeat(2, 100px 1fr)|js});
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|repeat(4, 10px [col-start] 250px [col-end]) 10px|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|100px 1fr max-content minmax(min-content, 1fr)|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|repeat(auto-fill, minmax(25ch, 1fr))|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|10px [col-start] 250px [col-end]|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|[first nav-start] 150px [main-start] 1fr [last]|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto)|js},
);
CssJs.unsafe({js|gridTemplateRows|js}, {js|none|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|auto|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|100px|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|1fr|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|100px 1fr auto|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|repeat(2, 100px 1fr)|js});
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|100px 1fr max-content minmax(min-content, 1fr)|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|10px [row-start] 250px [row-end]|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|[first header-start] 50px [main-start] 1fr [footer-start] 50px [last]|js},
);
CssJs.unsafe({js|gridTemplateAreas|js}, {js|none|js});
CssJs.unsafe({js|gridTemplateAreas|js}, {js|'articles'|js});
CssJs.unsafe({js|gridTemplateAreas|js}, {js|'head head'|js});
CssJs.unsafe(
  {js|gridTemplateAreas|js},
  {js|'head head' 'nav main' 'foot ....'|js},
);
CssJs.unsafe({js|gridTemplate|js}, {js|none|js});
CssJs.unsafe({js|gridTemplate|js}, {js|auto 1fr auto / auto 1fr|js});
CssJs.unsafe(
  {js|gridTemplate|js},
  {js|[header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|js},
);
CssJs.unsafe({js|gridAutoColumns|js}, {js|auto|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|1fr|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|100px|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|max-content|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|minmax(min-content, 1fr)|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|min-content max-content auto|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js|100px 150px 390px|js});
CssJs.unsafe(
  {js|gridAutoColumns|js},
  {js|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
);
CssJs.unsafe({js|gridAutoRows|js}, {js|auto|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|1fr|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|100px|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|100px 30%|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|100px 30% 1em|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|min-content|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|minmax(min-content, 1fr)|js});
CssJs.unsafe({js|gridAutoRows|js}, {js|min-content max-content auto|js});
CssJs.unsafe(
  {js|gridAutoRows|js},
  {js|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
);
CssJs.unsafe({js|gridAutoFlow|js}, {js|row|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js|column|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js|row dense|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js|column dense|js});
CssJs.unsafe({js|gridRowStart|js}, {js|auto|js});
CssJs.unsafe({js|gridRowStart|js}, {js|4|js});
CssJs.unsafe({js|gridRowStart|js}, {js|C|js});
CssJs.unsafe({js|gridRowStart|js}, {js|C 2|js});
CssJs.unsafe({js|gridColumnStart|js}, {js|auto|js});
CssJs.unsafe({js|gridColumnStart|js}, {js|4|js});
CssJs.unsafe({js|gridColumnStart|js}, {js|C|js});
CssJs.unsafe({js|gridColumnStart|js}, {js|C 2|js});
CssJs.unsafe({js|gridRowEnd|js}, {js|auto|js});
CssJs.unsafe({js|gridRowEnd|js}, {js|4|js});
CssJs.unsafe({js|gridRowEnd|js}, {js|C|js});
CssJs.unsafe({js|gridRowEnd|js}, {js|C 2|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js|auto|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js|4|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js|C|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js|C 2|js});
CssJs.unsafe({js|gridColumn|js}, {js|auto|js});
CssJs.unsafe({js|gridColumn|js}, {js|1|js});
CssJs.unsafe({js|gridColumn|js}, {js|-1|js});
CssJs.unsafe({js|gridRow|js}, {js|auto|js});
CssJs.unsafe({js|gridRow|js}, {js|1|js});
CssJs.unsafe({js|gridRow|js}, {js|-1|js});
CssJs.gridColumnGap(`zero);
CssJs.gridColumnGap(`em(1.));
CssJs.gridRowGap(`zero);
CssJs.gridRowGap(`em(1.));
CssJs.unsafe({js|gridGap|js}, {js|0 0|js});
CssJs.unsafe({js|gridGap|js}, {js|0 1em|js});
CssJs.gridGap(`em(1.));
CssJs.unsafe({js|gridGap|js}, {js|1em 1em|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|subgrid|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|subgrid [sub-a]|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|subgrid [sub-a] [sub-b]|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|subgrid repeat(1, [sub-a])|js});
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|subgrid repeat(auto-fill, [sub-a] [sub-b])|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|js},
);
CssJs.unsafe({js|gridTemplateRows|js}, {js|subgrid|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|subgrid [sub-a]|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|subgrid [sub-a] [sub-b]|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js|subgrid repeat(1, [sub-a])|js});
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|subgrid repeat(auto-fill, [sub-a] [sub-b])|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js|subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|js},
);
CssJs.alignSelf(`auto);
CssJs.alignSelf(`normal);
CssJs.alignSelf(`stretch);
CssJs.alignSelf(`baseline);
CssJs.alignSelf(`firstBaseline);
CssJs.alignSelf(`lastBaseline);
CssJs.alignSelf(`center);
CssJs.alignSelf(`start);
CssJs.alignSelf(`end_);
CssJs.alignSelf(`selfStart);
CssJs.alignSelf(`selfEnd);
CssJs.alignSelf(`unsafe(`start));
CssJs.alignSelf(`safe(`start));
CssJs.alignItems(`normal);
CssJs.alignItems(`stretch);
CssJs.alignItems(`baseline);
CssJs.alignItems(`firstBaseline);
CssJs.alignItems(`lastBaseline);
CssJs.alignItems(`center);
CssJs.alignItems(`start);
CssJs.alignItems(`end_);
CssJs.alignItems(`selfStart);
CssJs.alignItems(`selfEnd);
CssJs.alignItems(`unsafe(`start));
CssJs.alignItems(`safe(`start));
CssJs.alignContent(`normal);
CssJs.alignContent(`baseline);
CssJs.alignContent(`firstBaseline);
CssJs.alignContent(`lastBaseline);
CssJs.alignContent(`spaceBetween);
CssJs.alignContent(`spaceAround);
CssJs.alignContent(`spaceEvenly);
CssJs.alignContent(`stretch);
CssJs.alignContent(`center);
CssJs.alignContent(`start);
CssJs.alignContent(`end_);
CssJs.alignContent(`flexStart);
CssJs.alignContent(`flexEnd);
CssJs.alignContent(`unsafe(`start));
CssJs.alignContent(`safe(`start));
CssJs.unsafe({js|justifySelf|js}, {js|auto|js});
CssJs.unsafe({js|justifySelf|js}, {js|normal|js});
CssJs.unsafe({js|justifySelf|js}, {js|stretch|js});
CssJs.unsafe({js|justifySelf|js}, {js|baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js|first baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js|last baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js|center|js});
CssJs.unsafe({js|justifySelf|js}, {js|start|js});
CssJs.unsafe({js|justifySelf|js}, {js|end|js});
CssJs.unsafe({js|justifySelf|js}, {js|self-start|js});
CssJs.unsafe({js|justifySelf|js}, {js|self-end|js});
CssJs.unsafe({js|justifySelf|js}, {js|unsafe start|js});
CssJs.unsafe({js|justifySelf|js}, {js|safe start|js});
CssJs.unsafe({js|justifySelf|js}, {js|left|js});
CssJs.unsafe({js|justifySelf|js}, {js|right|js});
CssJs.unsafe({js|justifySelf|js}, {js|safe right|js});
CssJs.justifyItems(`normal);
CssJs.justifyItems(`stretch);
CssJs.justifyItems(`baseline);
CssJs.justifyItems(`firstBaseline);
CssJs.justifyItems(`lastBaseline);
CssJs.justifyItems(`center);
CssJs.justifyItems(`start);
CssJs.justifyItems(`end_);
CssJs.justifyItems(`selfStart);
CssJs.justifyItems(`selfEnd);
CssJs.justifyItems(`unsafe(`start));
CssJs.justifyItems(`safe(`start));
CssJs.justifyItems(`left);
CssJs.justifyItems(`right);
CssJs.justifyItems(`safe(`right));
CssJs.justifyItems(`legacy);
CssJs.justifyItems(`legacyLeft);
CssJs.justifyItems(`legacyRight);
CssJs.justifyItems(`legacyCenter);
CssJs.justifyContent(`normal);
CssJs.justifyContent(`spaceBetween);
CssJs.justifyContent(`spaceAround);
CssJs.justifyContent(`spaceEvenly);
CssJs.justifyContent(`stretch);
CssJs.justifyContent(`center);
CssJs.justifyContent(`start);
CssJs.justifyContent(`end_);
CssJs.justifyContent(`flexStart);
CssJs.justifyContent(`flexEnd);
CssJs.justifyContent(`unsafe(`start));
CssJs.justifyContent(`safe(`start));
CssJs.justifyContent(`left);
CssJs.justifyContent(`right);
CssJs.justifyContent(`safe(`right));
CssJs.unsafe({js|placeContent|js}, {js|normal|js});
CssJs.unsafe({js|placeContent|js}, {js|baseline|js});
CssJs.unsafe({js|placeContent|js}, {js|first baseline|js});
CssJs.unsafe({js|placeContent|js}, {js|last baseline|js});
CssJs.unsafe({js|placeContent|js}, {js|space-between|js});
CssJs.unsafe({js|placeContent|js}, {js|space-around|js});
CssJs.unsafe({js|placeContent|js}, {js|space-evenly|js});
CssJs.unsafe({js|placeContent|js}, {js|stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|center|js});
CssJs.unsafe({js|placeContent|js}, {js|start|js});
CssJs.unsafe({js|placeContent|js}, {js|end|js});
CssJs.unsafe({js|placeContent|js}, {js|flex-start|js});
CssJs.unsafe({js|placeContent|js}, {js|flex-end|js});
CssJs.unsafe({js|placeContent|js}, {js|unsafe start|js});
CssJs.unsafe({js|placeContent|js}, {js|safe start|js});
CssJs.unsafe({js|placeContent|js}, {js|normal normal|js});
CssJs.unsafe({js|placeContent|js}, {js|baseline normal|js});
CssJs.unsafe({js|placeContent|js}, {js|first baseline normal|js});
CssJs.unsafe({js|placeContent|js}, {js|space-between normal|js});
CssJs.unsafe({js|placeContent|js}, {js|center normal|js});
CssJs.unsafe({js|placeContent|js}, {js|unsafe start normal|js});
CssJs.unsafe({js|placeContent|js}, {js|normal stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|baseline stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|first baseline stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|space-between stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|center stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|unsafe start stretch|js});
CssJs.unsafe({js|placeContent|js}, {js|normal safe right|js});
CssJs.unsafe({js|placeContent|js}, {js|baseline safe right|js});
CssJs.unsafe({js|placeContent|js}, {js|first baseline safe right|js});
CssJs.unsafe({js|placeContent|js}, {js|space-between safe right|js});
CssJs.unsafe({js|placeContent|js}, {js|center safe right|js});
CssJs.unsafe({js|placeContent|js}, {js|unsafe start safe right|js});
CssJs.unsafe({js|placeItems|js}, {js|normal|js});
CssJs.unsafe({js|placeItems|js}, {js|stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|first baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|center|js});
CssJs.unsafe({js|placeItems|js}, {js|start|js});
CssJs.unsafe({js|placeItems|js}, {js|end|js});
CssJs.unsafe({js|placeItems|js}, {js|self-start|js});
CssJs.unsafe({js|placeItems|js}, {js|self-end|js});
CssJs.unsafe({js|placeItems|js}, {js|unsafe start|js});
CssJs.unsafe({js|placeItems|js}, {js|safe start|js});
CssJs.unsafe({js|placeItems|js}, {js|normal normal|js});
CssJs.unsafe({js|placeItems|js}, {js|stretch normal|js});
CssJs.unsafe({js|placeItems|js}, {js|baseline normal|js});
CssJs.unsafe({js|placeItems|js}, {js|first baseline normal|js});
CssJs.unsafe({js|placeItems|js}, {js|self-start normal|js});
CssJs.unsafe({js|placeItems|js}, {js|unsafe start normal|js});
CssJs.unsafe({js|placeItems|js}, {js|normal stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|stretch stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|baseline stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|first baseline stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|self-start stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|unsafe start stretch|js});
CssJs.unsafe({js|placeItems|js}, {js|normal last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|stretch last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|baseline last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|first baseline last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|self-start last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|unsafe start last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js|normal legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js|stretch legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js|baseline legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js|first baseline legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js|self-start legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js|unsafe start legacy left|js});
CssJs.gap2(~rowGap=`zero, ~columnGap=`zero);
CssJs.gap2(~rowGap=`zero, ~columnGap=`em(1.));
CssJs.gap(`em(1.));
CssJs.gap2(~rowGap=`em(1.), ~columnGap=`em(1.));
CssJs.unsafe({js|columnGap|js}, {js|0|js});
CssJs.unsafe({js|columnGap|js}, {js|1em|js});
CssJs.unsafe({js|columnGap|js}, {js|normal|js});
CssJs.unsafe({js|rowGap|js}, {js|0|js});
CssJs.unsafe({js|rowGap|js}, {js|1em|js});
CssJs.unsafe({js|marginTrim|js}, {js|none|js});
CssJs.unsafe({js|marginTrim|js}, {js|in-flow|js});
CssJs.unsafe({js|marginTrim|js}, {js|all|js});
CssJs.unsafe({js|color|js}, {js|unset|js});
CssJs.unsafe({js|font-weight|js}, {js|unset|js});
CssJs.unsafe({js|background-image|js}, {js|unset|js});
CssJs.unsafe({js|width|js}, {js|unset|js});
CssJs.unsafe({js|clipPath|js}, {js|url('#clip')|js});
CssJs.unsafe({js|clipPath|js}, {js|inset(50%)|js});
CssJs.unsafe({js|clipPath|js}, {js|path('M 20 20 H 80 V 30')|js});
CssJs.unsafe({js|clipPath|js}, {js|border-box|js});
CssJs.unsafe({js|clipPath|js}, {js|padding-box|js});
CssJs.unsafe({js|clipPath|js}, {js|content-box|js});
CssJs.unsafe({js|clipPath|js}, {js|margin-box|js});
CssJs.unsafe({js|clipPath|js}, {js|fill-box|js});
CssJs.unsafe({js|clipPath|js}, {js|stroke-box|js});
CssJs.unsafe({js|clipPath|js}, {js|view-box|js});
CssJs.unsafe({js|clipPath|js}, {js|none|js});
CssJs.unsafe({js|clipRule|js}, {js|nonzero|js});
CssJs.unsafe({js|clipRule|js}, {js|evenodd|js});
CssJs.maskImage(`none);
CssJs.maskImage(
  `linearGradient((
    Some(`Angle(`deg(45.))),
    [|(CssJs.blue, None), (CssJs.red, None)|],
  )),
);
CssJs.unsafe({js|maskImage|js}, {js|url(image.png)|js});
CssJs.unsafe({js|maskMode|js}, {js|alpha|js});
CssJs.unsafe({js|maskMode|js}, {js|luminance|js});
CssJs.unsafe({js|maskMode|js}, {js|match-source|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat-x|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat-y|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|space|js});
CssJs.unsafe({js|maskRepeat|js}, {js|round|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|space repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|round repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat space|js});
CssJs.unsafe({js|maskRepeat|js}, {js|space space|js});
CssJs.unsafe({js|maskRepeat|js}, {js|round space|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat space|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat round|js});
CssJs.unsafe({js|maskRepeat|js}, {js|space round|js});
CssJs.unsafe({js|maskRepeat|js}, {js|round round|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat round|js});
CssJs.unsafe({js|maskRepeat|js}, {js|repeat no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|space no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|round no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat no-repeat|js});
CssJs.unsafe({js|maskPosition|js}, {js|center|js});
CssJs.unsafe({js|maskPosition|js}, {js|center center|js});
CssJs.unsafe({js|maskPosition|js}, {js|left 50%|js});
CssJs.unsafe({js|maskPosition|js}, {js|bottom 10px right 20px|js});
CssJs.unsafe({js|maskClip|js}, {js|border-box|js});
CssJs.unsafe({js|maskClip|js}, {js|padding-box|js});
CssJs.unsafe({js|maskClip|js}, {js|content-box|js});
CssJs.unsafe({js|maskClip|js}, {js|margin-box|js});
CssJs.unsafe({js|maskClip|js}, {js|fill-box|js});
CssJs.unsafe({js|maskClip|js}, {js|stroke-box|js});
CssJs.unsafe({js|maskClip|js}, {js|view-box|js});
CssJs.unsafe({js|maskClip|js}, {js|no-clip|js});
CssJs.unsafe({js|maskOrigin|js}, {js|border-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|padding-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|content-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|margin-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|fill-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|stroke-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js|view-box|js});
CssJs.unsafe({js|maskSize|js}, {js|auto|js});
CssJs.unsafe({js|maskSize|js}, {js|10px|js});
CssJs.unsafe({js|maskSize|js}, {js|cover|js});
CssJs.unsafe({js|maskSize|js}, {js|contain|js});
CssJs.unsafe({js|maskSize|js}, {js|10px|js});
CssJs.unsafe({js|maskSize|js}, {js|50%|js});
CssJs.unsafe({js|maskSize|js}, {js|10px auto|js});
CssJs.unsafe({js|maskSize|js}, {js|auto 10%|js});
CssJs.unsafe({js|maskSize|js}, {js|50em 50%|js});
CssJs.unsafe({js|maskComposite|js}, {js|add|js});
CssJs.unsafe({js|maskComposite|js}, {js|subtract|js});
CssJs.unsafe({js|maskComposite|js}, {js|intersect|js});
CssJs.unsafe({js|maskComposite|js}, {js|exclude|js});
CssJs.unsafe({js|mask|js}, {js|top|js});
CssJs.unsafe({js|mask|js}, {js|space|js});
CssJs.unsafe({js|mask|js}, {js|url(image.png)|js});
CssJs.unsafe({js|mask|js}, {js|url(image.png) luminance|js});
CssJs.unsafe({js|mask|js}, {js|url(image.png) luminance top space|js});
CssJs.unsafe({js|maskBorderSource|js}, {js|none|js});
CssJs.unsafe({js|maskBorderSource|js}, {js|url(image.png)|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|0 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|50% fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|1.1 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|0 1 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|0 1 2 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js|0 1 2 3 fill|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|auto|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|10px|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|50%|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|1|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|1.0|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|auto 1|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|auto 1 50%|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js|auto 1 50% 1.1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js|0|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js|1.1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js|0 1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js|0 1 2|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js|0 1 2 3|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|stretch stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|repeat stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|round stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|space stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|stretch repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|repeat repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|round repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|space repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|stretch round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|repeat round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|round round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|space round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|stretch space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|repeat space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|round space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js|space space|js});
CssJs.unsafe({js|maskBorder|js}, {js|url(image.png)|js});
CssJs.unsafe({js|maskType|js}, {js|luminance|js});
CssJs.unsafe({js|maskType|js}, {js|alpha|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|normal|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|multiply|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|screen|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|overlay|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|darken|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|lighten|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|color-dodge|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|color-burn|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|hard-light|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|soft-light|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|difference|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|exclusion|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|hue|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|saturation|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|color|js});
CssJs.unsafe({js|mixBlendMode|js}, {js|luminosity|js});
CssJs.unsafe({js|isolation|js}, {js|auto|js});
CssJs.unsafe({js|isolation|js}, {js|isolate|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|normal|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|multiply|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|screen|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|overlay|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|darken|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|lighten|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|color-dodge|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|color-burn|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|hard-light|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|soft-light|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|difference|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|exclusion|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|hue|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|saturation|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|color|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|luminosity|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js|normal, multiply|js});
CssJs.display(`runIn);
CssJs.display(`flow);
CssJs.display(`flowRoot);
CssJs.unsafe({js|filter|js}, {js|none|js});
CssJs.unsafe({js|filter|js}, {js|url(#id)|js});
CssJs.unsafe({js|filter|js}, {js|url(image.svg#id)|js});
CssJs.unsafe({js|filter|js}, {js|blur(5px)|js});
CssJs.unsafe({js|filter|js}, {js|brightness(0.5)|js});
CssJs.unsafe({js|filter|js}, {js|contrast(150%)|js});
CssJs.unsafe({js|filter|js}, {js|drop-shadow(15px 15px 15px black)|js});
CssJs.unsafe({js|filter|js}, {js|grayscale(50%)|js});
CssJs.unsafe({js|filter|js}, {js|hue-rotate(50deg)|js});
CssJs.unsafe({js|filter|js}, {js|invert(50%)|js});
CssJs.unsafe({js|filter|js}, {js|opacity(50%)|js});
CssJs.unsafe({js|filter|js}, {js|sepia(50%)|js});
CssJs.unsafe({js|filter|js}, {js|saturate(150%)|js});
CssJs.unsafe({js|filter|js}, {js|grayscale(100%) sepia(100%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|none|js});
CssJs.unsafe({js|backdropFilter|js}, {js|url(#id)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|url(image.svg#id)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|blur(5px)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|brightness(0.5)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|contrast(150%)|js});
CssJs.unsafe(
  {js|backdropFilter|js},
  {js|drop-shadow(15px 15px 15px black)|js},
);
CssJs.unsafe({js|backdropFilter|js}, {js|grayscale(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|hue-rotate(50deg)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|invert(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|opacity(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|sepia(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|saturate(150%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js|grayscale(100%) sepia(100%)|js});
CssJs.unsafe({js|touchAction|js}, {js|auto|js});
CssJs.unsafe({js|touchAction|js}, {js|none|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-x|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-y|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
CssJs.unsafe({js|touchAction|js}, {js|manipulation|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-left|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-right|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-up|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-down|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-left pan-up|js});
CssJs.unsafe({js|touchAction|js}, {js|pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-x pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-y pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y pinch-zoom|js});
CssJs.unsafe({js|breakBefore|js}, {js|auto|js});
CssJs.unsafe({js|breakBefore|js}, {js|avoid|js});
CssJs.unsafe({js|breakBefore|js}, {js|avoid-page|js});
CssJs.unsafe({js|breakBefore|js}, {js|page|js});
CssJs.unsafe({js|breakBefore|js}, {js|left|js});
CssJs.unsafe({js|breakBefore|js}, {js|right|js});
CssJs.unsafe({js|breakBefore|js}, {js|recto|js});
CssJs.unsafe({js|breakBefore|js}, {js|verso|js});
CssJs.unsafe({js|breakBefore|js}, {js|avoid-column|js});
CssJs.unsafe({js|breakBefore|js}, {js|column|js});
CssJs.unsafe({js|breakBefore|js}, {js|avoid-region|js});
CssJs.unsafe({js|breakBefore|js}, {js|region|js});
CssJs.unsafe({js|breakAfter|js}, {js|auto|js});
CssJs.unsafe({js|breakAfter|js}, {js|avoid|js});
CssJs.unsafe({js|breakAfter|js}, {js|avoid-page|js});
CssJs.unsafe({js|breakAfter|js}, {js|page|js});
CssJs.unsafe({js|breakAfter|js}, {js|left|js});
CssJs.unsafe({js|breakAfter|js}, {js|right|js});
CssJs.unsafe({js|breakAfter|js}, {js|recto|js});
CssJs.unsafe({js|breakAfter|js}, {js|verso|js});
CssJs.unsafe({js|breakAfter|js}, {js|avoid-column|js});
CssJs.unsafe({js|breakAfter|js}, {js|column|js});
CssJs.unsafe({js|breakAfter|js}, {js|avoid-region|js});
CssJs.unsafe({js|breakAfter|js}, {js|region|js});
CssJs.unsafe({js|breakInside|js}, {js|auto|js});
CssJs.unsafe({js|breakInside|js}, {js|avoid|js});
CssJs.unsafe({js|breakInside|js}, {js|avoid-page|js});
CssJs.unsafe({js|breakInside|js}, {js|avoid-column|js});
CssJs.unsafe({js|breakInside|js}, {js|avoid-region|js});
CssJs.unsafe({js|boxDecorationBreak|js}, {js|slice|js});
CssJs.unsafe({js|boxDecorationBreak|js}, {js|clone|js});
CssJs.unsafe({js|orphans|js}, {js|1|js});
CssJs.unsafe({js|orphans|js}, {js|2|js});
CssJs.widows(1);
CssJs.widows(2);
CssJs.unsafe({js|position|js}, {js|sticky|js});
CssJs.unsafe({js|willChange|js}, {js|scroll-position|js});
CssJs.unsafe({js|willChange|js}, {js|contents|js});
CssJs.unsafe({js|willChange|js}, {js|transform|js});
CssJs.unsafe({js|willChange|js}, {js|top, left|js});
CssJs.unsafe({js|scrollBehavior|js}, {js|auto|js});
CssJs.unsafe({js|scrollBehavior|js}, {js|smooth|js});
CssJs.display(`ruby);
CssJs.display(`rubyBase);
CssJs.display(`rubyText);
CssJs.display(`rubyBaseContainer);
CssJs.display(`rubyTextContainer);
CssJs.unsafe({js|scrollMargin|js}, {js|0px|js});
CssJs.unsafe({js|scrollMargin|js}, {js|6px 5px|js});
CssJs.unsafe({js|scrollMargin|js}, {js|10px 20px 30px|js});
CssJs.unsafe({js|scrollMargin|js}, {js|10px 20px 30px 40px|js});
CssJs.unsafe({js|scrollMargin|js}, {js|20px 3em 1in 5rem|js});
CssJs.unsafe({js|scrollMargin|js}, {js|calc(2px)|js});
CssJs.unsafe({js|scrollMargin|js}, {js|calc(3 * 25px)|js});
CssJs.unsafe(
  {js|scrollMargin|js},
  {js|calc(3 * 25px) 5px 10em calc(1vw - 5px)|js},
);
CssJs.unsafe({js|scrollMarginBlock|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginBlock|js}, {js|10px 10px|js});
CssJs.unsafe({js|scrollMarginBlockEnd|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginBlockStart|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginBottom|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginInline|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginInline|js}, {js|10px 10px|js});
CssJs.unsafe({js|scrollMarginInlineStart|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginInlineEnd|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginLeft|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginRight|js}, {js|10px|js});
CssJs.unsafe({js|scrollMarginTop|js}, {js|10px|js});
CssJs.unsafe({js|scrollPadding|js}, {js|auto|js});
CssJs.unsafe({js|scrollPadding|js}, {js|0px|js});
CssJs.unsafe({js|scrollPadding|js}, {js|6px 5px|js});
CssJs.unsafe({js|scrollPadding|js}, {js|10px 20px 30px|js});
CssJs.unsafe({js|scrollPadding|js}, {js|10px 20px 30px 40px|js});
CssJs.unsafe({js|scrollPadding|js}, {js|10px auto 30px auto|js});
CssJs.unsafe({js|scrollPadding|js}, {js|10%|js});
CssJs.unsafe({js|scrollPadding|js}, {js|20% 3em 1in 5rem|js});
CssJs.unsafe({js|scrollPadding|js}, {js|calc(2px)|js});
CssJs.unsafe({js|scrollPadding|js}, {js|calc(50%)|js});
CssJs.unsafe({js|scrollPadding|js}, {js|calc(3 * 25px)|js});
CssJs.unsafe(
  {js|scrollPadding|js},
  {js|calc(3 * 25px) 5px 10% calc(10% - 5px)|js},
);
CssJs.unsafe({js|scrollPaddingBlock|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js|10px 50%|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js|50% 50%|js});
CssJs.unsafe({js|scrollPaddingBlockEnd|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingBlockEnd|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingBlockStart|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingBlockStart|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingBottom|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingBottom|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js|10px 50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js|50% 50%|js});
CssJs.unsafe({js|scrollPaddingInlineEnd|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingInlineEnd|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingInlineStart|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingInlineStart|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingLeft|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingLeft|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingRight|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingRight|js}, {js|50%|js});
CssJs.unsafe({js|scrollPaddingTop|js}, {js|10px|js});
CssJs.unsafe({js|scrollPaddingTop|js}, {js|50%|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|none|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|end|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|center|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|none start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|end center|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|center start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|end none|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js|center center|js});
CssJs.unsafe({js|scrollSnapStop|js}, {js|normal|js});
CssJs.unsafe({js|scrollSnapStop|js}, {js|always|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|none|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|x mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|y mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|block mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|inline mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|both mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|x proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|y proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|block proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|inline proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js|both proximity|js});
CssJs.unsafe({js|overflowAnchor|js}, {js|none|js});
CssJs.unsafe({js|overflowAnchor|js}, {js|auto|js});
CssJs.unsafe({js|captionSide|js}, {js|inline-start|js});
CssJs.unsafe({js|captionSide|js}, {js|inline-end|js});
CssJs.unsafe({js|float|js}, {js|inline-start|js});
CssJs.unsafe({js|float|js}, {js|inline-end|js});
CssJs.unsafe({js|clear|js}, {js|inline-start|js});
CssJs.unsafe({js|clear|js}, {js|inline-end|js});
CssJs.unsafe({js|resize|js}, {js|block|js});
CssJs.unsafe({js|resize|js}, {js|inline|js});
CssJs.unsafe({js|blockSize|js}, {js|100px|js});
CssJs.unsafe({js|inlineSize|js}, {js|100px|js});
CssJs.unsafe({js|minBlockSize|js}, {js|100px|js});
CssJs.unsafe({js|minInlineSize|js}, {js|100px|js});
CssJs.unsafe({js|maxBlockSize|js}, {js|100px|js});
CssJs.unsafe({js|maxInlineSize|js}, {js|100px|js});
CssJs.unsafe({js|marginBlock|js}, {js|10px|js});
CssJs.unsafe({js|marginBlock|js}, {js|10px 10px|js});
CssJs.unsafe({js|marginBlockStart|js}, {js|10px|js});
CssJs.unsafe({js|marginBlockEnd|js}, {js|10px|js});
CssJs.unsafe({js|marginInline|js}, {js|10px|js});
CssJs.unsafe({js|marginInline|js}, {js|10px 10px|js});
CssJs.unsafe({js|marginInlineStart|js}, {js|10px|js});
CssJs.unsafe({js|marginInlineEnd|js}, {js|10px|js});
CssJs.unsafe({js|inset|js}, {js|10px|js});
CssJs.unsafe({js|inset|js}, {js|10px 10px|js});
CssJs.unsafe({js|inset|js}, {js|10px 10px 10px|js});
CssJs.unsafe({js|inset|js}, {js|10px 10px 10px 10px|js});
CssJs.unsafe({js|insetBlock|js}, {js|10px|js});
CssJs.unsafe({js|insetBlock|js}, {js|10px 10px|js});
CssJs.unsafe({js|insetBlockStart|js}, {js|10px|js});
CssJs.unsafe({js|insetBlockEnd|js}, {js|10px|js});
CssJs.unsafe({js|insetInline|js}, {js|10px|js});
CssJs.unsafe({js|insetInline|js}, {js|10px 10px|js});
CssJs.unsafe({js|insetInlineStart|js}, {js|10px|js});
CssJs.unsafe({js|insetInlineEnd|js}, {js|10px|js});
CssJs.unsafe({js|paddingBlock|js}, {js|10px|js});
CssJs.unsafe({js|paddingBlock|js}, {js|10px 10px|js});
CssJs.unsafe({js|paddingBlockStart|js}, {js|10px|js});
CssJs.unsafe({js|paddingBlockEnd|js}, {js|10px|js});
CssJs.unsafe({js|paddingInline|js}, {js|10px|js});
CssJs.unsafe({js|paddingInline|js}, {js|10px 10px|js});
CssJs.unsafe({js|paddingInlineStart|js}, {js|10px|js});
CssJs.unsafe({js|paddingInlineEnd|js}, {js|10px|js});
CssJs.unsafe({js|borderBlock|js}, {js|1px|js});
CssJs.unsafe({js|borderBlock|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderBlock|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderBlockStart|js}, {js|1px|js});
CssJs.unsafe({js|borderBlockStart|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderBlockStart|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderBlockStartWidth|js}, {js|thin|js});
CssJs.unsafe({js|borderBlockStartStyle|js}, {js|dotted|js});
CssJs.unsafe({js|borderBlockStartColor|js}, {js|navy|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js|1px|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderBlockEndWidth|js}, {js|thin|js});
CssJs.unsafe({js|borderBlockEndStyle|js}, {js|dotted|js});
CssJs.unsafe({js|borderBlockEndColor|js}, {js|navy|js});
CssJs.unsafe({js|borderBlockColor|js}, {js|navy blue|js});
CssJs.unsafe({js|borderInline|js}, {js|1px|js});
CssJs.unsafe({js|borderInline|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderInline|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderInlineStart|js}, {js|1px|js});
CssJs.unsafe({js|borderInlineStart|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderInlineStart|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderInlineStartWidth|js}, {js|thin|js});
CssJs.unsafe({js|borderInlineStartStyle|js}, {js|dotted|js});
CssJs.unsafe({js|borderInlineStartColor|js}, {js|navy|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js|1px|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js|2px dotted|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js|medium dashed green|js});
CssJs.unsafe({js|borderInlineEndWidth|js}, {js|thin|js});
CssJs.unsafe({js|borderInlineEndStyle|js}, {js|dotted|js});
CssJs.unsafe({js|borderInlineEndColor|js}, {js|navy|js});
CssJs.unsafe({js|borderInlineColor|js}, {js|navy blue|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js|0|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js|50%|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js|250px 100px|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js|0|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js|50%|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js|250px 100px|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js|0|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js|50%|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js|250px 100px|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js|0|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js|50%|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js|250px 100px|js});
CssJs.unsafe({js|listStyleType|js}, {js|disclosure-closed|js});
CssJs.unsafe({js|listStyleType|js}, {js|disclosure-open|js});
CssJs.unsafe({js|listStyleType|js}, {js|hebrew|js});
CssJs.unsafe({js|listStyleType|js}, {js|cjk-decimal|js});
CssJs.unsafe({js|listStyleType|js}, {js|cjk-ideographic|js});
CssJs.unsafe({js|listStyleType|js}, {js|hiragana|js});
CssJs.unsafe({js|listStyleType|js}, {js|katakana|js});
CssJs.unsafe({js|listStyleType|js}, {js|hiragana-iroha|js});
CssJs.unsafe({js|listStyleType|js}, {js|katakana-iroha|js});
CssJs.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|korean-hangul-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|korean-hanja-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|korean-hanja-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|cjk-heavenly-stem|js});
CssJs.unsafe({js|listStyleType|js}, {js|cjk-earthly-branch|js});
CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js|arabic-indic|js});
CssJs.unsafe({js|listStyleType|js}, {js|persian|js});
CssJs.unsafe({js|listStyleType|js}, {js|urdu|js});
CssJs.unsafe({js|listStyleType|js}, {js|devanagari|js});
CssJs.unsafe({js|listStyleType|js}, {js|gurmukhi|js});
CssJs.unsafe({js|listStyleType|js}, {js|gujarati|js});
CssJs.unsafe({js|listStyleType|js}, {js|oriya|js});
CssJs.unsafe({js|listStyleType|js}, {js|kannada|js});
CssJs.unsafe({js|listStyleType|js}, {js|malayalam|js});
CssJs.unsafe({js|listStyleType|js}, {js|bengali|js});
CssJs.unsafe({js|listStyleType|js}, {js|tamil|js});
CssJs.unsafe({js|listStyleType|js}, {js|telugu|js});
CssJs.unsafe({js|listStyleType|js}, {js|thai|js});
CssJs.unsafe({js|listStyleType|js}, {js|lao|js});
CssJs.unsafe({js|listStyleType|js}, {js|myanmar|js});
CssJs.unsafe({js|listStyleType|js}, {js|khmer|js});
CssJs.unsafe({js|listStyleType|js}, {js|hangul|js});
CssJs.unsafe({js|listStyleType|js}, {js|hangul-consonant|js});
CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame|js});
CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-numeric|js});
CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-am|js});
CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-er|js});
CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-et|js});
CssJs.unsafe({js|listStyleType|js}, {js|other-style|js});
CssJs.unsafe({js|listStyleType|js}, {js|inside|js});
CssJs.unsafe({js|listStyleType|js}, {js|outside|js});
CssJs.unsafe({js|listStyleType|js}, {js|\32 style|js});
CssJs.unsafe({js|listStyleType|js}, {js|"-"|js});
CssJs.unsafe({js|listStyleType|js}, {js|'-'|js});
CssJs.unsafe({js|counterReset|js}, {js|foo|js});
CssJs.unsafe({js|counterReset|js}, {js|foo 1|js});
CssJs.unsafe({js|counterReset|js}, {js|foo 1 bar|js});
CssJs.unsafe({js|counterReset|js}, {js|foo 1 bar 2|js});
CssJs.unsafe({js|counterReset|js}, {js|none|js});
CssJs.unsafe({js|counterSet|js}, {js|foo|js});
CssJs.unsafe({js|counterSet|js}, {js|foo 1|js});
CssJs.unsafe({js|counterSet|js}, {js|foo 1 bar|js});
CssJs.unsafe({js|counterSet|js}, {js|foo 1 bar 2|js});
CssJs.unsafe({js|counterSet|js}, {js|none|js});
CssJs.unsafe({js|counterIncrement|js}, {js|foo|js});
CssJs.unsafe({js|counterIncrement|js}, {js|foo 1|js});
CssJs.unsafe({js|counterIncrement|js}, {js|foo 1 bar|js});
CssJs.unsafe({js|counterIncrement|js}, {js|foo 1 bar 2|js});
CssJs.unsafe({js|counterIncrement|js}, {js|none|js});
CssJs.unsafe({js|lineClamp|js}, {js|none|js});
CssJs.unsafe({js|lineClamp|js}, {js|1|js});
CssJs.unsafe({js|maxLines|js}, {js|none|js});
CssJs.unsafe({js|maxLines|js}, {js|1|js});
CssJs.overflowX(`visible);
CssJs.overflowX(`hidden);
CssJs.overflowX(`clip);
CssJs.overflowX(`scroll);
CssJs.overflowX(`auto);
CssJs.overflowY(`visible);
CssJs.overflowY(`hidden);
CssJs.overflowY(`clip);
CssJs.overflowY(`scroll);
CssJs.overflowY(`auto);
CssJs.overflowInline(`visible);
CssJs.overflowInline(`hidden);
CssJs.overflowInline(`clip);
CssJs.overflowInline(`scroll);
CssJs.overflowInline(`auto);
CssJs.unsafe({js|overflowBlock|js}, {js|visible|js});
CssJs.unsafe({js|overflowBlock|js}, {js|hidden|js});
CssJs.unsafe({js|overflowBlock|js}, {js|clip|js});
CssJs.unsafe({js|overflowBlock|js}, {js|scroll|js});
CssJs.unsafe({js|overflowBlock|js}, {js|auto|js});
CssJs.unsafe({js|contain|js}, {js|none|js});
CssJs.unsafe({js|contain|js}, {js|strict|js});
CssJs.unsafe({js|contain|js}, {js|content|js});
CssJs.unsafe({js|contain|js}, {js|size|js});
CssJs.unsafe({js|contain|js}, {js|layout|js});
CssJs.unsafe({js|contain|js}, {js|paint|js});
CssJs.unsafe({js|contain|js}, {js|size layout|js});
CssJs.unsafe({js|contain|js}, {js|size paint|js});
CssJs.unsafe({js|contain|js}, {js|size layout paint|js});
CssJs.width(`maxContent);
CssJs.width(`minContent);
CssJs.unsafe({js|width|js}, {js|fit-content(10%)|js});
CssJs.minWidth(`maxContent);
CssJs.minWidth(`minContent);
CssJs.unsafe({js|minWidth|js}, {js|fit-content(10%)|js});
CssJs.maxWidth(`maxContent);
CssJs.maxWidth(`minContent);
CssJs.unsafe({js|maxWidth|js}, {js|fit-content(10%)|js});
CssJs.height(`maxContent);
CssJs.height(`minContent);
CssJs.unsafe({js|height|js}, {js|fit-content(10%)|js});
CssJs.minHeight(`maxContent);
CssJs.minHeight(`minContent);
CssJs.unsafe({js|minHeight|js}, {js|fit-content(10%)|js});
CssJs.maxHeight(`maxContent);
CssJs.maxHeight(`minContent);
CssJs.unsafe({js|maxHeight|js}, {js|fit-content(10%)|js});
CssJs.unsafe({js|aspectRatio|js}, {js|auto|js});
CssJs.unsafe({js|aspectRatio|js}, {js|2|js});
CssJs.unsafe({js|aspectRatio|js}, {js|16 / 9|js});
CssJs.unsafe({js|width|js}, {js|fit-content|js});
CssJs.unsafe({js|minWidth|js}, {js|fit-content|js});
CssJs.unsafe({js|maxWidth|js}, {js|fit-content|js});
CssJs.unsafe({js|height|js}, {js|fit-content|js});
CssJs.unsafe({js|minHeight|js}, {js|fit-content|js});
CssJs.unsafe({js|maxHeight|js}, {js|fit-content|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|contain contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|none contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|auto contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|contain none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|none none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|auto none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|contain auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|none auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js|auto auto|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js|contain|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js|none|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js|auto|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js|contain|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js|none|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js|auto|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|contain|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|none|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|auto|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|contain|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|none|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|auto|js});
CssJs.unsafe({js|scrollbarColor|js}, {js|auto|js});
CssJs.unsafe({js|scrollbarColor|js}, {js|dark|js});
CssJs.unsafe({js|scrollbarColor|js}, {js|light|js});
CssJs.unsafe({js|scrollbarColor|js}, {js|red blue|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js|auto|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js|thin|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js|none|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js|12px|js});
CssJs.pointerEvents(`auto);
CssJs.pointerEvents(`visiblePainted);
CssJs.pointerEvents(`visibleFill);
CssJs.pointerEvents(`visibleStroke);
CssJs.pointerEvents(`visible);
CssJs.pointerEvents(`painted);
CssJs.pointerEvents(`fill);
CssJs.pointerEvents(`stroke);
CssJs.pointerEvents(`all);
CssJs.pointerEvents(`none);
CssJs.lineHeightStep(`pxFloat(30.));
CssJs.lineHeightStep(`em(2.));
CssJs.width(`calc(`add((`percent(50.), `pxFloat(4.)))));
CssJs.width(`calc(`sub((`pxFloat(20.), `pxFloat(10.)))));
CssJs.width(
  `calc(`sub((`vh(100.), `calc(`add((`rem(2.), `pxFloat(120.))))))),
);
CssJs.width(
  `calc(
    `sub((
      `vh(100.),
      `calc(
        `add((
          `rem(2.),
          `calc(
            `add((
              `rem(2.),
              `calc(
                `add((
                  `rem(2.),
                  `calc(`add((`rem(2.), `pxFloat(120.)))),
                )),
              ),
            )),
          ),
        )),
      ),
    )),
  ),
);
CssJs.unsafe({js|MozAppearance|js}, {js|textfield|js});
CssJs.unsafe({js|WebkitAppearance|js}, {js|none|js});
CssJs.unsafe({js|WebkitBoxOrient|js}, {js|vertical|js});
CssJs.unsafe(
  {js|WebkitBoxShadow|js},
  {js|inset 0 0 0 1000px $(Color.Background.selectedMuted)|js},
);
CssJs.unsafe({js|WebkitLineClamp|js}, {js|2|js});
CssJs.unsafe({js|WebkitOverflowScrolling|js}, {js|touch|js});
CssJs.unsafe({js|WebkitTapHighlightColor|js}, {js|transparent|js});
CssJs.unsafe({js|WebkitTextFillColor|js}, {js|$(Color.Text.primary)|js});
CssJs.animation(
  ~duration=`ms(0),
  ~delay=`ms(0),
  ~direction=`normal,
  ~timingFunction=`ease,
  ~fillMode=`none,
  ~playState=`running,
  ~iterationCount=`count(1),
  {js|none|js},
);
CssJs.unsafe({js|appearance|js}, {js|none|js});
CssJs.unsafe({js|aspectRatio|js}, {js|21 / 8|js});
(CssJs.backgroundColor(c): CssJs.rule);
CssJs.unsafe({js|border|js}, {js|none|js});
CssJs.unsafe({js|bottom|js}, {js|unset|js});
CssJs.boxShadow(`none);
CssJs.unsafe({js|breakInside|js}, {js|avoid|js});
CssJs.unsafe({js|caretColor|js}, {js|#e15a46|js});
CssJs.unsafe({js|color|js}, {js|inherit|js});
CssJs.color(`var({js|--color-link|js}));
CssJs.columnWidth(`pxFloat(125.));
CssJs.columnWidth(`auto);
CssJs.unsafe({js|content|js}, {js|""|js});
CssJs.unsafe({js|content|js}, {js|unset|js});
CssJs.display(`webkitBox);
CssJs.display(`contents);
CssJs.display(`table);
(CssJs.SVG.fill(color): CssJs.rule);
CssJs.SVG.fill(`currentColor);
CssJs.gap(`pxFloat(4.));
CssJs.unsafe({js|grid-column|js}, {js|unset|js});
CssJs.unsafe({js|grid-row|js}, {js|unset|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|max-content max-content|js});
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|minmax(10px, auto) fit-content(20px) fit-content(20px)|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js|minmax(51px, auto) fit-content(20px) fit-content(20px)|js},
);
CssJs.unsafe({js|gridTemplateColumns|js}, {js|repeat(2, auto)|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js|repeat(3, auto)|js});
CssJs.unsafe({js|height|js}, {js|fit-content|js});
CssJs.justifyItems(`start);
CssJs.unsafe({js|justify-self|js}, {js|unset|js});
CssJs.unsafe({js|left|js}, {js|unset|js});
(CssJs.maskImage(eyeCrossedIcon): CssJs.rule);
CssJs.unsafe({js|maskPosition|js}, {js|center center|js});
CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat|js});
CssJs.maxWidth(`maxContent);
CssJs.unsafe({js|outline|js}, {js|none|js});
CssJs.unsafe({js|overflowAnchor|js}, {js|none|js});
CssJs.unsafe({js|position|js}, {js|unset|js});
CssJs.unsafe({js|resize|js}, {js|none|js});
CssJs.right(`calc(`sub((`percent(50.), `pxFloat(4.)))));
CssJs.unsafe({js|scrollBehavior|js}, {js|smooth|js});
CssJs.SVG.strokeOpacity(`num(0.));
(CssJs.SVG.stroke(Color.Text.white): CssJs.rule);
CssJs.top(`calc(`sub((`percent(50.), `pxFloat(1.)))));
CssJs.unsafe({js|top|js}, {js|unset|js});
CssJs.unsafe({js|touchAction|js}, {js|none|js});
CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
CssJs.transformOrigin(`center, `left);
CssJs.transformOrigin(`center, `right);
CssJs.unsafe({js|transformOrigin|js}, {js|2px|js});
CssJs.transformOrigin(`Bottom, `Center);
CssJs.transformOrigin(`cm(3.), `pxFloat(2.));
CssJs.transformOrigin(`pxFloat(2.), `left);
CssJs.transform(`none);
CssJs.unsafe({js|width|js}, {js|fit-content|js});
CssJs.width(`maxContent);
CssJs.transitionDelay(240);
CssJs.animationDuration(150);
CssJs.borderWidth(`thin);
CssJs.outlineWidth(`medium);
CssJs.outline(`medium, `solid, CssJs.red);
