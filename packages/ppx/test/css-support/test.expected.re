(CssJs.backgroundRepeat(`space): CssJs.rule);
(CssJs.backgroundRepeat(`round): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`repeat, `repeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`space, `repeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`round, `repeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`noRepeat, `repeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`repeat, `space))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`space, `space))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`round, `space))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`noRepeat, `space))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`repeat, `round))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`space, `round))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`round, `round))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`noRepeat, `round))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`repeat, `noRepeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`space, `noRepeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`round, `noRepeat))): CssJs.rule);
(CssJs.backgroundRepeat(`hv((`noRepeat, `noRepeat))): CssJs.rule);
(CssJs.backgroundAttachment(`local): CssJs.rule);
(
  CssJs.backgroundPosition(
    `hv((`hv((`center, `pxFloat(20.))), `hv((`center, `pxFloat(10.))))),
  ): CssJs.rule
);
(
  CssJs.backgroundPosition(`hv((`center, `hv((`center, `pxFloat(10.)))))): CssJs.rule
);
(
  CssJs.backgroundPosition(`hv((`hv((`center, `pxFloat(10.))), `center))): CssJs.rule
);
(CssJs.backgroundClip(`borderBox): CssJs.rule);
(CssJs.backgroundClip(`padding_box): CssJs.rule);
(CssJs.backgroundClip(`contentBox): CssJs.rule);
(CssJs.backgroundOrigin(`borderBox): CssJs.rule);
(CssJs.backgroundOrigin(`padding_box): CssJs.rule);
(CssJs.backgroundOrigin(`contentBox): CssJs.rule);
(CssJs.backgroundSize(`auto): CssJs.rule);
(CssJs.backgroundSize(`cover): CssJs.rule);
(CssJs.backgroundSize(`contain): CssJs.rule);
CssJs.unsafe({js|backgroundSize|js}, {js| 10px|js});
CssJs.unsafe({js|backgroundSize|js}, {js| 50%|js});
CssJs.unsafe({js|backgroundSize|js}, {js| 10px auto|js});
CssJs.unsafe({js|backgroundSize|js}, {js| auto 10%|js});
(CssJs.backgroundSize(`size((`em(50.), `percent(50.)))): CssJs.rule);
CssJs.unsafe({js|background|js}, {js| top left / 50% 60%|js});
(CssJs.origin(`borderBox): CssJs.rule);
(CssJs.backgroundColor(CssJs.blue): CssJs.rule);
(CssJs.backgroundColor(CssJs.red): CssJs.rule);
(CssJs.backgroundRepeat(`fixed): CssJs.rule);
(CssJs.clip(`padding_box): CssJs.rule);
CssJs.unsafe(
  {js|background|js},
  {js| url(foo.png) bottom right / cover padding-box content-box|js},
);
(CssJs.borderTopLeftRadius(`zero): CssJs.rule);
(CssJs.borderTopLeftRadius(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|borderTopLeftRadius|js}, {js| 250px 100px|js});
(CssJs.borderTopRightRadius(`zero): CssJs.rule);
(CssJs.borderTopRightRadius(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|borderTopRightRadius|js}, {js| 250px 100px|js});
(CssJs.borderBottomRightRadius(`zero): CssJs.rule);
(CssJs.borderBottomRightRadius(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|borderBottomRightRadius|js}, {js| 250px 100px|js});
(CssJs.borderBottomLeftRadius(`zero): CssJs.rule);
(CssJs.borderBottomLeftRadius(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|borderBottomLeftRadius|js}, {js| 250px 100px|js});
(CssJs.borderRadius(`pxFloat(10.)): CssJs.rule);
(CssJs.borderRadius(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|borderImageSource|js}, {js| none|js});
CssJs.unsafe({js|borderImageSource|js}, {js| url(foo.png)|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 10 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 30% 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 10 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 10 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 10 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 30% 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% 30% 30% 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| fill 30%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| fill 10|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| fill 2 4 8% 16%|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 30% fill|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 10 fill|js});
CssJs.unsafe({js|borderImageSlice|js}, {js| 2 4 8% 16% fill|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5%|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 28|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| auto|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px 10px|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5% 10px|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 28 10px|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| auto 10px|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px 5%|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5% 5%|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 28 5%|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| auto 5%|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px 28|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5% 28|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 28 28|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| auto 28|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px auto|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5% auto|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 28 auto|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| auto auto|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 10px 10% 10|js});
CssJs.unsafe({js|borderImageWidth|js}, {js| 5% 10px 20 auto|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 10px|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 20|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 10px 20|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 10px 20px|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 20 30|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 2px 3px 4|js});
CssJs.unsafe({js|borderImageOutset|js}, {js| 1 2px 3px 4|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| stretch|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| repeat|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| round|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| space|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| stretch stretch|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| repeat stretch|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| round stretch|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| space stretch|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| stretch repeat|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| repeat repeat|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| round repeat|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| space repeat|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| stretch round|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| repeat round|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| round round|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| space round|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| stretch space|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| repeat space|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| round space|js});
CssJs.unsafe({js|borderImageRepeat|js}, {js| space space|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10%|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10% fill|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10 round|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10 stretch repeat|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10 / 10px|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) 10 / 10% / 10px|js});
CssJs.unsafe({js|borderImage|js}, {js| url(foo.png) fill 10 / 10% / 10px|js});
CssJs.unsafe(
  {js|borderImage|js},
  {js| url(foo.png) fill 10 / 10% / 10px space|js},
);
(
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CssJs.black,
    ),
  |]): CssJs.rule
);
(
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CssJs.black,
    ),
  |]): CssJs.rule
);
(
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
  |]): CssJs.rule
);
CssJs.unsafe({js|backgroundPositionX|js}, {js| right|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| center|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| 50%|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| left, left|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| left, right|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| right, left|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| left, 0%|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| 10%, 20%, 40%|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| 0px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| 30px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| 0%, 10%, 20%, 30%|js});
CssJs.unsafe(
  {js|backgroundPositionX|js},
  {js| left, left, left, left, left|js},
);
CssJs.unsafe({js|backgroundPositionX|js}, {js| right 20px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| left 20px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| right -50px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| left -50px|js});
CssJs.unsafe({js|backgroundPositionX|js}, {js| right 20px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| bottom|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| center|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| 50%|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top, top|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top, bottom|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| bottom, top|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top, 0%|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| 10%, 20%, 40%|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| 0px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| 30px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| 0%, 10%, 20%, 30%|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top, top, top, top, top|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| bottom 20px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top 20px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| bottom -50px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| top -50px|js});
CssJs.unsafe({js|backgroundPositionY|js}, {js| bottom 20px|js});
(CssJs.boxSizing(`borderBox): CssJs.rule);
(CssJs.boxSizing(`contentBox): CssJs.rule);
CssJs.unsafe({js|outlineStyle|js}, {js| auto|js});
CssJs.unsafe({js|outlineOffset|js}, {js| -5px|js});
CssJs.unsafe({js|outlineOffset|js}, {js| 0|js});
CssJs.unsafe({js|outlineOffset|js}, {js| 5px|js});
CssJs.unsafe({js|resize|js}, {js| none|js});
CssJs.unsafe({js|resize|js}, {js| both|js});
CssJs.unsafe({js|resize|js}, {js| horizontal|js});
CssJs.unsafe({js|resize|js}, {js| vertical|js});
CssJs.unsafe({js|textOverflow|js}, {js| clip|js});
CssJs.unsafe({js|textOverflow|js}, {js| ellipsis|js});
CssJs.unsafe({js|cursor|js}, {js| url(foo.png) 2 2, auto|js});
CssJs.unsafe({js|cursor|js}, {js| default|js});
CssJs.unsafe({js|cursor|js}, {js| none|js});
CssJs.unsafe({js|cursor|js}, {js| context-menu|js});
CssJs.unsafe({js|cursor|js}, {js| cell|js});
CssJs.unsafe({js|cursor|js}, {js| vertical-text|js});
CssJs.unsafe({js|cursor|js}, {js| alias|js});
CssJs.unsafe({js|cursor|js}, {js| copy|js});
CssJs.unsafe({js|cursor|js}, {js| no-drop|js});
CssJs.unsafe({js|cursor|js}, {js| not-allowed|js});
CssJs.unsafe({js|cursor|js}, {js| grab|js});
CssJs.unsafe({js|cursor|js}, {js| grabbing|js});
CssJs.unsafe({js|cursor|js}, {js| ew-resize|js});
CssJs.unsafe({js|cursor|js}, {js| ns-resize|js});
CssJs.unsafe({js|cursor|js}, {js| nesw-resize|js});
CssJs.unsafe({js|cursor|js}, {js| nwse-resize|js});
CssJs.unsafe({js|cursor|js}, {js| col-resize|js});
CssJs.unsafe({js|cursor|js}, {js| row-resize|js});
CssJs.unsafe({js|cursor|js}, {js| all-scroll|js});
CssJs.unsafe({js|cursor|js}, {js| zoom-in|js});
CssJs.unsafe({js|cursor|js}, {js| zoom-out|js});
CssJs.unsafe({js|caretColor|js}, {js| auto|js});
CssJs.unsafe({js|caretColor|js}, {js| green|js});
CssJs.unsafe({js|appearance|js}, {js| auto|js});
CssJs.unsafe({js|appearance|js}, {js| none|js});
CssJs.unsafe({js|textOverflow|js}, {js| clip|js});
CssJs.unsafe({js|textOverflow|js}, {js| ellipsis|js});
CssJs.unsafe({js|textOverflow|js}, {js| 'foo'|js});
CssJs.unsafe({js|textOverflow|js}, {js| clip clip|js});
CssJs.unsafe({js|textOverflow|js}, {js| ellipsis clip|js});
CssJs.unsafe({js|userSelect|js}, {js| auto|js});
CssJs.unsafe({js|userSelect|js}, {js| text|js});
CssJs.unsafe({js|userSelect|js}, {js| none|js});
CssJs.unsafe({js|userSelect|js}, {js| contain|js});
CssJs.unsafe({js|userSelect|js}, {js| all|js});
CssJs.unsafe({js|transitionProperty|js}, {js| none|js});
CssJs.unsafe({js|transitionProperty|js}, {js| all|js});
CssJs.unsafe({js|transitionProperty|js}, {js| width|js});
CssJs.unsafe({js|transitionProperty|js}, {js| width, height|js});
CssJs.unsafe({js|transitionDuration|js}, {js| 0s|js});
CssJs.unsafe({js|transitionDuration|js}, {js| 1s|js});
CssJs.unsafe({js|transitionDuration|js}, {js| 100ms|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| ease|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| linear|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| ease-in|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| ease-out|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| ease-in-out|js});
CssJs.unsafe(
  {js|transitionTimingFunction|js},
  {js| cubic-bezier(.5, .5, .5, .5)|js},
);
CssJs.unsafe(
  {js|transitionTimingFunction|js},
  {js| cubic-bezier(.5, 1.5, .5, -2.5)|js},
);
CssJs.unsafe({js|transitionTimingFunction|js}, {js| step-start|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| step-end|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(3, start)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(5, end)|js});
CssJs.unsafe({js|transitionDelay|js}, {js| 1s|js});
CssJs.unsafe({js|transitionDelay|js}, {js| -1s|js});
CssJs.unsafe({js|transition|js}, {js| 1s 2s width linear|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(2, jump-start)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(2, jump-end)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(1, jump-both)|js});
CssJs.unsafe({js|transitionTimingFunction|js}, {js| steps(2, jump-none)|js});
CssJs.unsafe({js|animationName|js}, {js| foo|js});
CssJs.unsafe({js|animationName|js}, {js| foo, bar|js});
CssJs.unsafe({js|animationDuration|js}, {js| 0s|js});
CssJs.unsafe({js|animationDuration|js}, {js| 1s|js});
CssJs.unsafe({js|animationDuration|js}, {js| 100ms|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| ease|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| linear|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| ease-in|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| ease-out|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| ease-in-out|js});
CssJs.unsafe(
  {js|animationTimingFunction|js},
  {js| cubic-bezier(.5, .5, .5, .5)|js},
);
CssJs.unsafe(
  {js|animationTimingFunction|js},
  {js| cubic-bezier(.5, 1.5, .5, -2.5)|js},
);
CssJs.unsafe({js|animationTimingFunction|js}, {js| step-start|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| step-end|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| steps(3, start)|js});
CssJs.unsafe({js|animationTimingFunction|js}, {js| steps(5, end)|js});
CssJs.unsafe({js|animationIterationCount|js}, {js| infinite|js});
CssJs.unsafe({js|animationIterationCount|js}, {js| 8|js});
CssJs.unsafe({js|animationIterationCount|js}, {js| 4.35|js});
CssJs.unsafe({js|animationDirection|js}, {js| normal|js});
CssJs.unsafe({js|animationDirection|js}, {js| alternate|js});
CssJs.unsafe({js|animationDirection|js}, {js| reverse|js});
CssJs.unsafe({js|animationDirection|js}, {js| alternate-reverse|js});
CssJs.unsafe({js|animationPlayState|js}, {js| running|js});
CssJs.unsafe({js|animationPlayState|js}, {js| paused|js});
CssJs.unsafe({js|animationDelay|js}, {js| 1s|js});
CssJs.unsafe({js|animationDelay|js}, {js| -1s|js});
CssJs.unsafe({js|animationFillMode|js}, {js| none|js});
CssJs.unsafe({js|animationFillMode|js}, {js| forwards|js});
CssJs.unsafe({js|animationFillMode|js}, {js| backwards|js});
CssJs.unsafe({js|animationFillMode|js}, {js| both|js});
CssJs.unsafe(
  {js|animation|js},
  {js| foo 1s 2s infinite linear alternate both|js},
);
(CssJs.transform(`none): CssJs.rule);
(CssJs.transform(CssJs.translate(`pxFloat(5.), 0)): CssJs.rule);
(
  CssJs.transform(CssJs.translate(`pxFloat(5.), `pxFloat(10.))): CssJs.rule
);
(CssJs.transform(CssJs.translateY(`pxFloat(5.))): CssJs.rule);
(CssJs.transform(CssJs.translateX(`pxFloat(5.))): CssJs.rule);
(CssJs.transform(CssJs.translateY(`percent(5.))): CssJs.rule);
(CssJs.transform(CssJs.translateX(`percent(5.))): CssJs.rule);
(CssJs.transform(CssJs.scale(2., 2.)): CssJs.rule);
(CssJs.transform(CssJs.scale(2., -1.)): CssJs.rule);
(CssJs.transform(CssJs.scaleX(2.)): CssJs.rule);
(CssJs.transform(CssJs.scaleY(2.5)): CssJs.rule);
(CssJs.transform(CssJs.rotate(`deg(45.))): CssJs.rule);
(CssJs.transform(CssJs.skew(`deg(45.), 0)): CssJs.rule);
(CssJs.transform(CssJs.skew(`deg(45.), `deg(15.))): CssJs.rule);
(CssJs.transform(CssJs.skewX(`deg(45.))): CssJs.rule);
(CssJs.transform(CssJs.skewY(`deg(45.))): CssJs.rule);
(
  CssJs.transforms([|
    CssJs.translate(`pxFloat(50.), `pxFloat(-24.)),
    CssJs.skew(`deg(0.), `deg(22.5)),
  |]): CssJs.rule
);
(
  CssJs.transform(CssJs.translate3d(`zero, `zero, `pxFloat(5.))): CssJs.rule
);
(CssJs.transform(CssJs.translateZ(`pxFloat(5.))): CssJs.rule);
(CssJs.transform(CssJs.scale3d(1., 0., -1.)): CssJs.rule);
(CssJs.transform(CssJs.scaleZ(1.5)): CssJs.rule);
(CssJs.transform(CssJs.rotate3d(1., 1., 1., `deg(45.))): CssJs.rule);
(CssJs.transform(CssJs.rotateX(`deg(-45.))): CssJs.rule);
(CssJs.transform(CssJs.rotateY(`deg(-45.))): CssJs.rule);
(CssJs.transform(CssJs.rotateZ(`deg(-45.))): CssJs.rule);
(
  CssJs.transforms([|
    CssJs.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
    CssJs.rotate3d(1., 2., 3., `deg(180.)),
    CssJs.scale3d(-1., 0., 0.5),
  |]): CssJs.rule
);
CssJs.unsafe({js|transform|js}, {js| perspective(600px)|js});
CssJs.unsafe({js|transformOrigin|js}, {js| 10px|js});
CssJs.unsafe({js|transformOrigin|js}, {js| top|js});
CssJs.unsafe({js|transformOrigin|js}, {js| top left|js});
CssJs.unsafe({js|transformOrigin|js}, {js| 50% 100%|js});
CssJs.unsafe({js|transformOrigin|js}, {js| left 0%|js});
CssJs.unsafe({js|transformOrigin|js}, {js| left 50% 0|js});
CssJs.unsafe({js|transformBox|js}, {js| border-box|js});
CssJs.unsafe({js|transformBox|js}, {js| fill-box|js});
CssJs.unsafe({js|transformBox|js}, {js| view-box|js});
CssJs.unsafe({js|translate|js}, {js| none|js});
CssJs.unsafe({js|translate|js}, {js| 50%|js});
CssJs.unsafe({js|translate|js}, {js| 50% 50%|js});
CssJs.unsafe({js|translate|js}, {js| 50% 50% 10px|js});
CssJs.unsafe({js|scale|js}, {js| none|js});
CssJs.unsafe({js|scale|js}, {js| 2|js});
CssJs.unsafe({js|scale|js}, {js| 2 2|js});
CssJs.unsafe({js|scale|js}, {js| 2 2 2|js});
CssJs.unsafe({js|rotate|js}, {js| none|js});
CssJs.unsafe({js|rotate|js}, {js|  45deg|js});
CssJs.unsafe({js|rotate|js}, {js| x 45deg|js});
CssJs.unsafe({js|rotate|js}, {js| y 45deg|js});
CssJs.unsafe({js|rotate|js}, {js| z 45deg|js});
CssJs.unsafe({js|rotate|js}, {js| -1 0 2 45deg|js});
CssJs.unsafe({js|rotate|js}, {js| 45deg x|js});
CssJs.unsafe({js|rotate|js}, {js| 45deg y|js});
CssJs.unsafe({js|rotate|js}, {js| 45deg z|js});
CssJs.unsafe({js|rotate|js}, {js| 45deg -1 0 2|js});
CssJs.unsafe({js|transformStyle|js}, {js| flat|js});
CssJs.unsafe({js|transformStyle|js}, {js| preserve-3d|js});
CssJs.unsafe({js|perspective|js}, {js| none|js});
CssJs.unsafe({js|perspective|js}, {js| 600px|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js| 10px|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js| top|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js| top left|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js| 50% 100%|js});
CssJs.unsafe({js|perspectiveOrigin|js}, {js| left 0%|js});
CssJs.unsafe({js|backfaceVisibility|js}, {js| visible|js});
CssJs.unsafe({js|backfaceVisibility|js}, {js| hidden|js});
CssJs.unsafe({js|offset|js}, {js| none|js});
CssJs.unsafe({js|offset|js}, {js| auto|js});
CssJs.unsafe({js|offset|js}, {js| center|js});
CssJs.unsafe({js|offset|js}, {js| 200px 100px|js});
CssJs.unsafe({js|offset|js}, {js| margin-box|js});
CssJs.unsafe({js|offset|js}, {js| border-box|js});
CssJs.unsafe({js|offset|js}, {js| padding-box|js});
CssJs.unsafe({js|offset|js}, {js| content-box|js});
CssJs.unsafe({js|offset|js}, {js| fill-box|js});
CssJs.unsafe({js|offset|js}, {js| stroke-box|js});
CssJs.unsafe({js|offset|js}, {js| view-box|js});
CssJs.unsafe({js|offset|js}, {js| path('M 20 20 H 80 V 30')|js});
CssJs.unsafe({js|offset|js}, {js| url(image.png)|js});
CssJs.unsafe({js|textTransform|js}, {js| full-width|js});
CssJs.unsafe({js|textTransform|js}, {js| full-size-kana|js});
CssJs.unsafe({js|tabSize|js}, {js| 4|js});
CssJs.unsafe({js|tabSize|js}, {js| 1em|js});
CssJs.unsafe({js|lineBreak|js}, {js| auto|js});
CssJs.unsafe({js|lineBreak|js}, {js| loose|js});
CssJs.unsafe({js|lineBreak|js}, {js| normal|js});
CssJs.unsafe({js|lineBreak|js}, {js| strict|js});
CssJs.unsafe({js|lineBreak|js}, {js| anywhere|js});
(CssJs.wordBreak(`normal): CssJs.rule);
(CssJs.wordBreak(`keepAll): CssJs.rule);
(CssJs.wordBreak(`breakAll): CssJs.rule);
(CssJs.whiteSpace(`breakSpaces): CssJs.rule);
CssJs.unsafe({js|hyphens|js}, {js| auto|js});
CssJs.unsafe({js|hyphens|js}, {js| manual|js});
CssJs.unsafe({js|hyphens|js}, {js| none|js});
(CssJs.overflowWrap(`normal): CssJs.rule);
CssJs.unsafe({js|overflowWrap|js}, {js| break-word|js});
(CssJs.overflowWrap(`anywhere): CssJs.rule);
(CssJs.wordWrap(`normal): CssJs.rule);
CssJs.unsafe({js|wordWrap|js}, {js| break-word|js});
(CssJs.wordWrap(`anywhere): CssJs.rule);
(CssJs.textAlign(`start): CssJs.rule);
(CssJs.textAlign(`end_): CssJs.rule);
(CssJs.textAlign(`left): CssJs.rule);
(CssJs.textAlign(`right): CssJs.rule);
(CssJs.textAlign(`center): CssJs.rule);
(CssJs.textAlign(`justify): CssJs.rule);
CssJs.unsafe({js|textAlign|js}, {js| match-parent|js});
CssJs.unsafe({js|textJustify|js}, {js| auto|js});
CssJs.unsafe({js|textJustify|js}, {js| none|js});
CssJs.unsafe({js|textJustify|js}, {js| inter-word|js});
CssJs.unsafe({js|textJustify|js}, {js| inter-character|js});
(CssJs.wordSpacing(`percent(50.)): CssJs.rule);
CssJs.unsafe({js|textIndent|js}, {js| 1em hanging|js});
CssJs.unsafe({js|textIndent|js}, {js| 1em each-line|js});
CssJs.unsafe({js|textIndent|js}, {js| 1em hanging each-line|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| none|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| first|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| force-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| allow-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| first last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| first force-end|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| first force-end last|js});
CssJs.unsafe({js|hangingPunctuation|js}, {js| first allow-end last|js});
CssJs.unsafe({js|textDecoration|js}, {js| underline dotted green|js});
CssJs.unsafe({js|textDecorationLine|js}, {js| none|js});
CssJs.unsafe({js|textDecorationLine|js}, {js| underline|js});
CssJs.unsafe({js|textDecorationLine|js}, {js| overline|js});
CssJs.unsafe({js|textDecorationLine|js}, {js| line-through|js});
CssJs.unsafe({js|textDecorationLine|js}, {js| underline overline|js});
(CssJs.textDecorationColor(CssJs.white): CssJs.rule);
CssJs.unsafe({js|textDecorationStyle|js}, {js| solid|js});
CssJs.unsafe({js|textDecorationStyle|js}, {js| double|js});
CssJs.unsafe({js|textDecorationStyle|js}, {js| dotted|js});
CssJs.unsafe({js|textDecorationStyle|js}, {js| dashed|js});
CssJs.unsafe({js|textDecorationStyle|js}, {js| wavy|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| auto|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| under|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| left|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| right|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| under left|js});
CssJs.unsafe({js|textUnderlinePosition|js}, {js| under right|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| none|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| filled|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| open|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| dot|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| circle|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| double-circle|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| triangle|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| sesame|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| open dot|js});
CssJs.unsafe({js|textEmphasisStyle|js}, {js| 'foo'|js});
CssJs.unsafe({js|textEmphasisColor|js}, {js| green|js});
CssJs.unsafe({js|textEmphasis|js}, {js| open dot green|js});
CssJs.unsafe({js|textEmphasisPosition|js}, {js| over left|js});
CssJs.unsafe({js|textEmphasisPosition|js}, {js| over right|js});
CssJs.unsafe({js|textEmphasisPosition|js}, {js| under left|js});
CssJs.unsafe({js|textEmphasisPosition|js}, {js| under right|js});
CssJs.unsafe({js|textShadow|js}, {js| none|js});
CssJs.unsafe({js|textShadow|js}, {js| 1px 2px 3px black|js});
CssJs.unsafe({js|textDecoration|js}, {js| underline solid blue 1px|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| none|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects leading-spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects trailing-spaces|js});
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| objects leading-spaces trailing-spaces|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| objects leading-spaces trailing-spaces edges|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| objects leading-spaces trailing-spaces edges box-decoration|js},
);
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects edges|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| objects box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| spaces|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| spaces edges|js});
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| spaces edges box-decoration|js},
);
CssJs.unsafe({js|textDecorationSkip|js}, {js| spaces box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| leading-spaces|js});
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| leading-spaces trailing-spaces edges|js},
);
CssJs.unsafe(
  {js|textDecorationSkip|js},
  {js| leading-spaces trailing-spaces edges box-decoration|js},
);
CssJs.unsafe({js|textDecorationSkip|js}, {js| edges|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| edges box-decoration|js});
CssJs.unsafe({js|textDecorationSkip|js}, {js| box-decoration|js});
CssJs.unsafe({js|textDecorationSkipInk|js}, {js| none|js});
CssJs.unsafe({js|textDecorationSkipInk|js}, {js| auto|js});
CssJs.unsafe({js|textUnderlineOffset|js}, {js| auto|js});
CssJs.unsafe({js|textUnderlineOffset|js}, {js| 3px|js});
CssJs.unsafe({js|textUnderlineOffset|js}, {js| 10%|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js| auto|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js| from-font|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js| 3px|js});
CssJs.unsafe({js|textDecorationThickness|js}, {js| 10%|js});
CssJs.unsafe({js|quotes|js}, {js| auto|js});
CssJs.unsafe({js|content|js}, {js| "\25BA" / ""|js});
CssJs.unsafe({js|fontStretch|js}, {js| normal|js});
CssJs.unsafe({js|fontStretch|js}, {js| ultra-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js| extra-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js| condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js| semi-condensed|js});
CssJs.unsafe({js|fontStretch|js}, {js| semi-expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js| expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js| extra-expanded|js});
CssJs.unsafe({js|fontStretch|js}, {js| ultra-expanded|js});
CssJs.unsafe({js|fontSizeAdjust|js}, {js| none|js});
CssJs.unsafe({js|fontSizeAdjust|js}, {js| .5|js});
CssJs.unsafe({js|fontSynthesis|js}, {js| none|js});
CssJs.unsafe({js|fontSynthesis|js}, {js| weight|js});
CssJs.unsafe({js|fontKerning|js}, {js| auto|js});
CssJs.unsafe({js|fontKerning|js}, {js| normal|js});
CssJs.unsafe({js|fontKerning|js}, {js| none|js});
CssJs.unsafe({js|fontVariantPosition|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantPosition|js}, {js| super|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| none|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| common-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| no-common-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| discretionary-ligatures|js});
CssJs.unsafe(
  {js|fontVariantLigatures|js},
  {js| no-discretionary-ligatures|js},
);
CssJs.unsafe({js|fontVariantLigatures|js}, {js| historical-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| no-historical-ligatures|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| contextual|js});
CssJs.unsafe({js|fontVariantLigatures|js}, {js| no-contextual|js});
CssJs.unsafe(
  {js|fontVariantLigatures|js},
  {js| common-ligatures discretionary-ligatures historical-ligatures contextual|js},
);
CssJs.unsafe({js|fontVariantCaps|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| small-caps|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| all-small-caps|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| petite-caps|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| all-petite-caps|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| titling-caps|js});
CssJs.unsafe({js|fontVariantCaps|js}, {js| unicase|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| lining-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| oldstyle-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| proportional-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| tabular-nums|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| diagonal-fractions|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| stacked-fractions|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| ordinal|js});
CssJs.unsafe({js|fontVariantNumeric|js}, {js| slashed-zero|js});
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js| lining-nums proportional-nums diagonal-fractions|js},
);
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js| oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|js},
);
CssJs.unsafe(
  {js|fontVariantNumeric|js},
  {js| slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|js},
);
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| jis78|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| jis83|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| jis90|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| jis04|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| simplified|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| traditional|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| full-width|js});
CssJs.unsafe({js|fontVariantEastAsian|js}, {js| proportional-width|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| normal|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| 'c2sc'|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| 'smcp' on|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| 'liga' off|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| 'smcp', 'swsh' 2|js});
(CssJs.fontSize(`xxx_large): CssJs.rule);
CssJs.unsafe({js|fontVariant|js}, {js| none|js});
CssJs.unsafe({js|fontVariant|js}, {js| normal|js});
CssJs.unsafe({js|fontVariant|js}, {js| all-petite-caps|js});
CssJs.unsafe({js|fontVariant|js}, {js| historical-forms|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js| normal|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js| historical-forms|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js| styleset(ss01)|js});
CssJs.unsafe(
  {js|fontVariantAlternates|js},
  {js| styleset(stacked-g, geometric-m)|js},
);
CssJs.unsafe({js|fontVariantAlternates|js}, {js| character-variant(cv02)|js});
CssJs.unsafe(
  {js|fontVariantAlternates|js},
  {js| character-variant(beta-3, gamma)|js},
);
CssJs.unsafe({js|fontVariantAlternates|js}, {js| swash(flowing)|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js| ornaments(leaves)|js});
CssJs.unsafe({js|fontVariantAlternates|js}, {js| annotation(blocky)|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| normal|js});
CssJs.unsafe({js|fontFeatureSettings|js}, {js| 'swsh' 2|js});
CssJs.unsafe({js|fontLanguageOverride|js}, {js| normal|js});
CssJs.unsafe({js|fontLanguageOverride|js}, {js| 'SRB'|js});
CssJs.unsafe({js|fontWeight|js}, {js| 1|js});
CssJs.unsafe({js|fontWeight|js}, {js| 90|js});
CssJs.unsafe({js|fontWeight|js}, {js| 750|js});
CssJs.unsafe({js|fontWeight|js}, {js| 1000|js});
CssJs.unsafe({js|fontStyle|js}, {js| oblique 15deg|js});
CssJs.unsafe({js|fontStyle|js}, {js| oblique -15deg|js});
CssJs.unsafe({js|fontStyle|js}, {js| oblique 0deg|js});
CssJs.unsafe({js|fontOpticalSizing|js}, {js| none|js});
CssJs.unsafe({js|fontOpticalSizing|js}, {js| auto|js});
CssJs.unsafe({js|direction|js}, {js| ltr|js});
CssJs.unsafe({js|direction|js}, {js| rtl|js});
CssJs.unsafe({js|unicodeBidi|js}, {js| normal|js});
CssJs.unsafe({js|unicodeBidi|js}, {js| isolate|js});
CssJs.unsafe({js|unicodeBidi|js}, {js| bidi-override|js});
CssJs.unsafe({js|unicodeBidi|js}, {js| isolate-override|js});
CssJs.unsafe({js|unicodeBidi|js}, {js| plaintext|js});
CssJs.unsafe({js|writingMode|js}, {js| horizontal-tb|js});
CssJs.unsafe({js|writingMode|js}, {js| vertical-rl|js});
CssJs.unsafe({js|writingMode|js}, {js| vertical-lr|js});
CssJs.unsafe({js|textOrientation|js}, {js| mixed|js});
CssJs.unsafe({js|textOrientation|js}, {js| upright|js});
CssJs.unsafe({js|textOrientation|js}, {js| sideways|js});
CssJs.unsafe({js|textCombineUpright|js}, {js| none|js});
CssJs.unsafe({js|textCombineUpright|js}, {js| all|js});
CssJs.unsafe({js|writingMode|js}, {js| sideways-rl|js});
CssJs.unsafe({js|writingMode|js}, {js| sideways-lr|js});
CssJs.unsafe({js|textCombineUpright|js}, {js| digits 2|js});
(CssJs.color(`rgba((0, 0, 0, `num(0.5)))): CssJs.rule);
(CssJs.color(`hex({js|F06|js})): CssJs.rule);
(CssJs.color(`hex({js|FF0066|js})): CssJs.rule);
CssJs.unsafe({js|color|js}, {js| hsl(0,0%,0%)|js});
CssJs.unsafe({js|color|js}, {js| hsl(0,0%,0%,.5)|js});
(CssJs.color(`transparent): CssJs.rule);
(CssJs.color(`currentColor): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 0, 0, `num(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`hex({js|F06|js})): CssJs.rule);
(CssJs.backgroundColor(`hex({js|FF0066|js})): CssJs.rule);
CssJs.unsafe({js|backgroundColor|js}, {js| hsl(0,0%,0%)|js});
CssJs.unsafe({js|backgroundColor|js}, {js| hsl(0,0%,0%,.5)|js});
(CssJs.backgroundColor(`transparent): CssJs.rule);
(CssJs.backgroundColor(`currentColor): CssJs.rule);
(CssJs.borderColor(`rgba((0, 0, 0, `num(0.5)))): CssJs.rule);
(CssJs.borderColor(`hex({js|F06|js})): CssJs.rule);
(CssJs.borderColor(`hex({js|FF0066|js})): CssJs.rule);
CssJs.unsafe({js|borderColor|js}, {js| hsl(0,0%,0%)|js});
CssJs.unsafe({js|borderColor|js}, {js| hsl(0,0%,0%,.5)|js});
(CssJs.borderColor(`transparent): CssJs.rule);
(CssJs.borderColor(`currentColor): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 0, 0, `num(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`hex({js|F06|js})): CssJs.rule);
(CssJs.textDecorationColor(`hex({js|FF0066|js})): CssJs.rule);
CssJs.unsafe({js|textDecorationColor|js}, {js| hsl(0,0%,0%)|js});
CssJs.unsafe({js|textDecorationColor|js}, {js| hsl(0,0%,0%,.5)|js});
(CssJs.textDecorationColor(`transparent): CssJs.rule);
(CssJs.textDecorationColor(`currentColor): CssJs.rule);
CssJs.unsafe({js|columnRuleColor|js}, {js| rgba(0,0,0,.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| #F06|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| #FF0066|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| hsl(0,0%,0%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| hsl(0,0%,0%,.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| transparent|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| currentColor|js});
(CssJs.color(`rgb((0, 51, 178))): CssJs.rule);
(CssJs.color(`rgb((0, 64, 185))): CssJs.rule);
(CssJs.color(`hsl((`deg(0.), `percent(0.), `percent(0.)))): CssJs.rule);
(CssJs.color(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
CssJs.unsafe({js|color|js}, {js| hsla(0 0% 0% /.5)|js});
(CssJs.color(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.color(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
(
  CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5)))): CssJs.rule
);
(CssJs.color(`hex({js|000F|js})): CssJs.rule);
(CssJs.color(`hex({js|000000FF|js})): CssJs.rule);
(CssJs.color(CssJs.rebeccapurple): CssJs.rule);
(CssJs.backgroundColor(`rgb((0, 51, 178))): CssJs.rule);
(CssJs.backgroundColor(`rgb((0, 64, 185))): CssJs.rule);
(
  CssJs.backgroundColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))): CssJs.rule
);
(CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
CssJs.unsafe({js|backgroundColor|js}, {js| hsla(0 0% 0% /.5)|js});
(CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
(
  CssJs.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ): CssJs.rule
);
(CssJs.backgroundColor(`hex({js|000F|js})): CssJs.rule);
(CssJs.backgroundColor(`hex({js|000000FF|js})): CssJs.rule);
(CssJs.backgroundColor(CssJs.rebeccapurple): CssJs.rule);
(CssJs.borderColor(`rgb((0, 51, 178))): CssJs.rule);
(CssJs.borderColor(`rgb((0, 64, 185))): CssJs.rule);
(
  CssJs.borderColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))): CssJs.rule
);
(CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
CssJs.unsafe({js|borderColor|js}, {js| hsla(0 0% 0% /.5)|js});
(CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.borderColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
(
  CssJs.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ): CssJs.rule
);
(CssJs.borderColor(`hex({js|000F|js})): CssJs.rule);
(CssJs.borderColor(`hex({js|000000FF|js})): CssJs.rule);
(CssJs.borderColor(CssJs.rebeccapurple): CssJs.rule);
(CssJs.textDecorationColor(`rgb((0, 51, 178))): CssJs.rule);
(CssJs.textDecorationColor(`rgb((0, 64, 185))): CssJs.rule);
(
  CssJs.textDecorationColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))): CssJs.rule
);
(CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
CssJs.unsafe({js|textDecorationColor|js}, {js| hsla(0 0% 0% /.5)|js});
(CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5)))): CssJs.rule);
(CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5)))): CssJs.rule);
(
  CssJs.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ): CssJs.rule
);
(CssJs.textDecorationColor(`hex({js|000F|js})): CssJs.rule);
(CssJs.textDecorationColor(`hex({js|000000FF|js})): CssJs.rule);
(CssJs.textDecorationColor(CssJs.rebeccapurple): CssJs.rule);
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0% 20% 70%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0 64 185)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| hsl(0 0% 0%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgba(0% 20% 70% / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgba(0% 20% 70% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgba(0 64 185 / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgba(0 64 185 / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| hsla(0 0% 0% /.5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0% 20% 70% / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0% 20% 70% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0 64 185 / 50%)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rgb(0 64 185 / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| hsl(0 0% 0% / .5)|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| #000F|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| #000000FF|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| rebeccapurple|js});
CssJs.unsafe({js|columnWidth|js}, {js| 10em|js});
CssJs.unsafe({js|columnWidth|js}, {js| auto|js});
CssJs.unsafe({js|columnCount|js}, {js| 2|js});
CssJs.unsafe({js|columnCount|js}, {js| auto|js});
CssJs.unsafe({js|columns|js}, {js| 100px|js});
CssJs.unsafe({js|columns|js}, {js| 3|js});
CssJs.unsafe({js|columns|js}, {js| 10em 2|js});
CssJs.unsafe({js|columns|js}, {js| auto auto|js});
CssJs.unsafe({js|columns|js}, {js| 2 10em|js});
CssJs.unsafe({js|columns|js}, {js| auto 10em|js});
CssJs.unsafe({js|columns|js}, {js| 2 auto|js});
CssJs.unsafe({js|columnRuleColor|js}, {js| red|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js| none|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js| solid|js});
CssJs.unsafe({js|columnRuleStyle|js}, {js| dotted|js});
CssJs.unsafe({js|columnRuleWidth|js}, {js| 1px|js});
CssJs.unsafe({js|columnRule|js}, {js| transparent|js});
CssJs.unsafe({js|columnRule|js}, {js| 1px solid black|js});
CssJs.unsafe({js|columnSpan|js}, {js| none|js});
CssJs.unsafe({js|columnSpan|js}, {js| all|js});
CssJs.unsafe({js|columnFill|js}, {js| auto|js});
CssJs.unsafe({js|columnFill|js}, {js| balance|js});
CssJs.unsafe({js|columnFill|js}, {js| balance-all|js});
(CssJs.width(`rem(5.)): CssJs.rule);
(CssJs.width(`ch(5.)): CssJs.rule);
(CssJs.width(`vw(5.)): CssJs.rule);
(CssJs.width(`vh(5.)): CssJs.rule);
(CssJs.width(`vmin(5.)): CssJs.rule);
(CssJs.width(`vmax(5.)): CssJs.rule);
(CssJs.padding(`rem(5.)): CssJs.rule);
(CssJs.padding(`ch(5.)): CssJs.rule);
(CssJs.padding(`vw(5.)): CssJs.rule);
(CssJs.padding(`vh(5.)): CssJs.rule);
(CssJs.padding(`vmin(5.)): CssJs.rule);
(CssJs.padding(`vmax(5.)): CssJs.rule);
CssJs.unsafe({js|alignContent|js}, {js| flex-start|js});
CssJs.unsafe({js|alignContent|js}, {js| flex-end|js});
CssJs.unsafe({js|alignContent|js}, {js| space-between|js});
CssJs.unsafe({js|alignContent|js}, {js| space-around|js});
CssJs.unsafe({js|alignItems|js}, {js| flex-start|js});
CssJs.unsafe({js|alignItems|js}, {js| flex-end|js});
CssJs.unsafe({js|alignSelf|js}, {js| flex-start|js});
CssJs.unsafe({js|alignSelf|js}, {js| flex-end|js});
(CssJs.display(`flex): CssJs.rule);
(CssJs.display(`inlineFlex): CssJs.rule);
(CssJs.flex(`none): CssJs.rule);
((CssJs.flexGrow(5.): CssJs.rule): CssJs.rule);
(CssJs.flexBasis(`auto): CssJs.rule);
(CssJs.flexBasis(`content): CssJs.rule);
(CssJs.flexBasis(`pxFloat(1.)): CssJs.rule);
(CssJs.flexDirection(`row): CssJs.rule);
(CssJs.flexDirection(`rowReverse): CssJs.rule);
(CssJs.flexDirection(`column): CssJs.rule);
(CssJs.flexDirection(`columnReverse): CssJs.rule);
((CssJs.flexDirection(`row): CssJs.rule): CssJs.rule);
((CssJs.flexDirection(`rowReverse): CssJs.rule): CssJs.rule);
((CssJs.flexDirection(`column): CssJs.rule): CssJs.rule);
((CssJs.flexDirection(`columnReverse): CssJs.rule): CssJs.rule);
((CssJs.flexWrap(`wrap): CssJs.rule): CssJs.rule);
((CssJs.flexWrap(`wrapReverse): CssJs.rule): CssJs.rule);
(CssJs.flexGrow(0.): CssJs.rule);
(CssJs.flexGrow(5.): CssJs.rule);
(CssJs.flexShrink(1.): CssJs.rule);
(CssJs.flexShrink(10.): CssJs.rule);
(CssJs.flexWrap(`nowrap): CssJs.rule);
(CssJs.flexWrap(`wrap): CssJs.rule);
(CssJs.flexWrap(`wrapReverse): CssJs.rule);
CssJs.unsafe({js|justifyContent|js}, {js| flex-start|js});
CssJs.unsafe({js|justifyContent|js}, {js| flex-end|js});
CssJs.unsafe({js|justifyContent|js}, {js| space-between|js});
CssJs.unsafe({js|justifyContent|js}, {js| space-around|js});
(CssJs.minHeight(`auto): CssJs.rule);
(CssJs.minWidth(`auto): CssJs.rule);
(CssJs.order(0): CssJs.rule);
(CssJs.order(1): CssJs.rule);
(CssJs.display(`grid): CssJs.rule);
(CssJs.display(`inlineGrid): CssJs.rule);
CssJs.unsafe({js|gridTemplateColumns|js}, {js| 100px|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js| 1fr|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js| 100px 1fr auto|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js| repeat(2, 100px 1fr)|js});
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js| 100px 1fr max-content minmax(min-content, 1fr)|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js| repeat(auto-fill, minmax(25ch, 1fr))|js},
);
CssJs.unsafe({js|gridTemplateRows|js}, {js| none|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js| auto|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js| 100px|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js| 1fr|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js| 100px 1fr auto|js});
CssJs.unsafe({js|gridTemplateRows|js}, {js| repeat(2, 100px 1fr)|js});
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js| 100px 1fr max-content minmax(min-content, 1fr)|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js| 10px [row-start] 250px [row-end]|js},
);
CssJs.unsafe(
  {js|gridTemplateRows|js},
  {js| [first header-start] 50px [main-start] 1fr [footer-start] 50px [last]|js},
);
CssJs.unsafe({js|gridTemplateAreas|js}, {js| none|js});
CssJs.unsafe({js|gridTemplateAreas|js}, {js| 'articles'|js});
CssJs.unsafe({js|gridTemplateAreas|js}, {js| 'head head'|js});
CssJs.unsafe(
  {js|gridTemplateAreas|js},
  {js| 'head head' 'nav main' 'foot ....'|js},
);
CssJs.unsafe({js|gridTemplate|js}, {js| none|js});
CssJs.unsafe({js|gridTemplate|js}, {js| auto 1fr auto / auto 1fr|js});
CssJs.unsafe(
  {js|gridTemplate|js},
  {js| [header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|js},
);
CssJs.unsafe({js|gridAutoColumns|js}, {js| auto|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| 1fr|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| 100px|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| max-content|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| minmax(min-content, 1fr)|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| min-content max-content auto|js});
CssJs.unsafe({js|gridAutoColumns|js}, {js| 100px 150px 390px|js});
CssJs.unsafe(
  {js|gridAutoColumns|js},
  {js| 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
);
CssJs.unsafe({js|gridAutoRows|js}, {js| auto|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| 1fr|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| 100px|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| 100px 30%|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| 100px 30% 1em|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| min-content|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| minmax(min-content, 1fr)|js});
CssJs.unsafe({js|gridAutoRows|js}, {js| min-content max-content auto|js});
CssJs.unsafe(
  {js|gridAutoRows|js},
  {js| 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
);
CssJs.unsafe({js|gridAutoFlow|js}, {js| row|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js| column|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js| row dense|js});
CssJs.unsafe({js|gridAutoFlow|js}, {js| column dense|js});
CssJs.unsafe({js|gridRowStart|js}, {js| auto|js});
CssJs.unsafe({js|gridRowStart|js}, {js| 4|js});
CssJs.unsafe({js|gridRowStart|js}, {js| C|js});
CssJs.unsafe({js|gridRowStart|js}, {js| C 2|js});
CssJs.unsafe({js|gridColumnStart|js}, {js| auto|js});
CssJs.unsafe({js|gridColumnStart|js}, {js| 4|js});
CssJs.unsafe({js|gridColumnStart|js}, {js| C|js});
CssJs.unsafe({js|gridColumnStart|js}, {js| C 2|js});
CssJs.unsafe({js|gridRowEnd|js}, {js| auto|js});
CssJs.unsafe({js|gridRowEnd|js}, {js| 4|js});
CssJs.unsafe({js|gridRowEnd|js}, {js| C|js});
CssJs.unsafe({js|gridRowEnd|js}, {js| C 2|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js| auto|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js| 4|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js| C|js});
CssJs.unsafe({js|gridColumnEnd|js}, {js| C 2|js});
CssJs.unsafe({js|gridColumn|js}, {js| auto|js});
CssJs.unsafe({js|gridColumn|js}, {js| 1|js});
CssJs.unsafe({js|gridColumn|js}, {js| -1|js});
CssJs.unsafe({js|gridRow|js}, {js| auto|js});
CssJs.unsafe({js|gridRow|js}, {js| 1|js});
CssJs.unsafe({js|gridRow|js}, {js| -1|js});
CssJs.unsafe({js|gridColumnGap|js}, {js| 0|js});
CssJs.unsafe({js|gridColumnGap|js}, {js| 1em|js});
CssJs.unsafe({js|gridRowGap|js}, {js| 0|js});
CssJs.unsafe({js|gridRowGap|js}, {js| 1em|js});
CssJs.unsafe({js|gridGap|js}, {js| 0 0|js});
CssJs.unsafe({js|gridGap|js}, {js| 0 1em|js});
CssJs.unsafe({js|gridGap|js}, {js| 1em|js});
CssJs.unsafe({js|gridGap|js}, {js| 1em 1em|js});
CssJs.unsafe({js|alignSelf|js}, {js| auto|js});
CssJs.unsafe({js|alignSelf|js}, {js| normal|js});
CssJs.unsafe({js|alignSelf|js}, {js| stretch|js});
CssJs.unsafe({js|alignSelf|js}, {js| baseline|js});
CssJs.unsafe({js|alignSelf|js}, {js| first baseline|js});
CssJs.unsafe({js|alignSelf|js}, {js| last baseline|js});
CssJs.unsafe({js|alignSelf|js}, {js| center|js});
CssJs.unsafe({js|alignSelf|js}, {js| start|js});
CssJs.unsafe({js|alignSelf|js}, {js| end|js});
CssJs.unsafe({js|alignSelf|js}, {js| self-start|js});
CssJs.unsafe({js|alignSelf|js}, {js| self-end|js});
CssJs.unsafe({js|alignSelf|js}, {js| unsafe start|js});
CssJs.unsafe({js|alignSelf|js}, {js| safe start|js});
CssJs.unsafe({js|alignItems|js}, {js| normal|js});
CssJs.unsafe({js|alignItems|js}, {js| stretch|js});
CssJs.unsafe({js|alignItems|js}, {js| baseline|js});
CssJs.unsafe({js|alignItems|js}, {js| first baseline|js});
CssJs.unsafe({js|alignItems|js}, {js| last baseline|js});
CssJs.unsafe({js|alignItems|js}, {js| center|js});
CssJs.unsafe({js|alignItems|js}, {js| start|js});
CssJs.unsafe({js|alignItems|js}, {js| end|js});
CssJs.unsafe({js|alignItems|js}, {js| self-start|js});
CssJs.unsafe({js|alignItems|js}, {js| self-end|js});
CssJs.unsafe({js|alignItems|js}, {js| unsafe start|js});
CssJs.unsafe({js|alignItems|js}, {js| safe start|js});
CssJs.unsafe({js|alignContent|js}, {js| normal|js});
CssJs.unsafe({js|alignContent|js}, {js| baseline|js});
CssJs.unsafe({js|alignContent|js}, {js| first baseline|js});
CssJs.unsafe({js|alignContent|js}, {js| last baseline|js});
CssJs.unsafe({js|alignContent|js}, {js| space-between|js});
CssJs.unsafe({js|alignContent|js}, {js| space-around|js});
CssJs.unsafe({js|alignContent|js}, {js| space-evenly|js});
CssJs.unsafe({js|alignContent|js}, {js| stretch|js});
CssJs.unsafe({js|alignContent|js}, {js| center|js});
CssJs.unsafe({js|alignContent|js}, {js| start|js});
CssJs.unsafe({js|alignContent|js}, {js| end|js});
CssJs.unsafe({js|alignContent|js}, {js| flex-start|js});
CssJs.unsafe({js|alignContent|js}, {js| flex-end|js});
CssJs.unsafe({js|alignContent|js}, {js| unsafe start|js});
CssJs.unsafe({js|alignContent|js}, {js| safe start|js});
CssJs.unsafe({js|justifySelf|js}, {js| auto|js});
CssJs.unsafe({js|justifySelf|js}, {js| normal|js});
CssJs.unsafe({js|justifySelf|js}, {js| stretch|js});
CssJs.unsafe({js|justifySelf|js}, {js| baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js| first baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js| last baseline|js});
CssJs.unsafe({js|justifySelf|js}, {js| center|js});
CssJs.unsafe({js|justifySelf|js}, {js| start|js});
CssJs.unsafe({js|justifySelf|js}, {js| end|js});
CssJs.unsafe({js|justifySelf|js}, {js| self-start|js});
CssJs.unsafe({js|justifySelf|js}, {js| self-end|js});
CssJs.unsafe({js|justifySelf|js}, {js| unsafe start|js});
CssJs.unsafe({js|justifySelf|js}, {js| safe start|js});
CssJs.unsafe({js|justifySelf|js}, {js| left|js});
CssJs.unsafe({js|justifySelf|js}, {js| right|js});
CssJs.unsafe({js|justifySelf|js}, {js| safe right|js});
CssJs.unsafe({js|justifyItems|js}, {js| normal|js});
CssJs.unsafe({js|justifyItems|js}, {js| stretch|js});
CssJs.unsafe({js|justifyItems|js}, {js| baseline|js});
CssJs.unsafe({js|justifyItems|js}, {js| first baseline|js});
CssJs.unsafe({js|justifyItems|js}, {js| last baseline|js});
CssJs.unsafe({js|justifyItems|js}, {js| center|js});
CssJs.unsafe({js|justifyItems|js}, {js| start|js});
CssJs.unsafe({js|justifyItems|js}, {js| end|js});
CssJs.unsafe({js|justifyItems|js}, {js| self-start|js});
CssJs.unsafe({js|justifyItems|js}, {js| self-end|js});
CssJs.unsafe({js|justifyItems|js}, {js| unsafe start|js});
CssJs.unsafe({js|justifyItems|js}, {js| safe start|js});
CssJs.unsafe({js|justifyItems|js}, {js| left|js});
CssJs.unsafe({js|justifyItems|js}, {js| right|js});
CssJs.unsafe({js|justifyItems|js}, {js| safe right|js});
CssJs.unsafe({js|justifyItems|js}, {js| legacy|js});
CssJs.unsafe({js|justifyItems|js}, {js| legacy left|js});
CssJs.unsafe({js|justifyItems|js}, {js| legacy right|js});
CssJs.unsafe({js|justifyItems|js}, {js| legacy center|js});
CssJs.unsafe({js|justifyContent|js}, {js| normal|js});
CssJs.unsafe({js|justifyContent|js}, {js| space-between|js});
CssJs.unsafe({js|justifyContent|js}, {js| space-around|js});
CssJs.unsafe({js|justifyContent|js}, {js| space-evenly|js});
CssJs.unsafe({js|justifyContent|js}, {js| stretch|js});
CssJs.unsafe({js|justifyContent|js}, {js| center|js});
CssJs.unsafe({js|justifyContent|js}, {js| start|js});
CssJs.unsafe({js|justifyContent|js}, {js| end|js});
CssJs.unsafe({js|justifyContent|js}, {js| flex-start|js});
CssJs.unsafe({js|justifyContent|js}, {js| flex-end|js});
CssJs.unsafe({js|justifyContent|js}, {js| unsafe start|js});
CssJs.unsafe({js|justifyContent|js}, {js| safe start|js});
CssJs.unsafe({js|justifyContent|js}, {js| left|js});
CssJs.unsafe({js|justifyContent|js}, {js| right|js});
CssJs.unsafe({js|justifyContent|js}, {js| safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| normal|js});
CssJs.unsafe({js|placeContent|js}, {js| baseline|js});
CssJs.unsafe({js|placeContent|js}, {js| first baseline|js});
CssJs.unsafe({js|placeContent|js}, {js| last baseline|js});
CssJs.unsafe({js|placeContent|js}, {js| space-between|js});
CssJs.unsafe({js|placeContent|js}, {js| space-around|js});
CssJs.unsafe({js|placeContent|js}, {js| space-evenly|js});
CssJs.unsafe({js|placeContent|js}, {js| stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| center|js});
CssJs.unsafe({js|placeContent|js}, {js| start|js});
CssJs.unsafe({js|placeContent|js}, {js| end|js});
CssJs.unsafe({js|placeContent|js}, {js| flex-start|js});
CssJs.unsafe({js|placeContent|js}, {js| flex-end|js});
CssJs.unsafe({js|placeContent|js}, {js| unsafe start|js});
CssJs.unsafe({js|placeContent|js}, {js| safe start|js});
CssJs.unsafe({js|placeContent|js}, {js| normal normal|js});
CssJs.unsafe({js|placeContent|js}, {js| baseline normal|js});
CssJs.unsafe({js|placeContent|js}, {js| first baseline normal|js});
CssJs.unsafe({js|placeContent|js}, {js| space-between normal|js});
CssJs.unsafe({js|placeContent|js}, {js| center normal|js});
CssJs.unsafe({js|placeContent|js}, {js| unsafe start normal|js});
CssJs.unsafe({js|placeContent|js}, {js| normal stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| baseline stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| first baseline stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| space-between stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| center stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| unsafe start stretch|js});
CssJs.unsafe({js|placeContent|js}, {js| normal safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| baseline safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| first baseline safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| space-between safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| center safe right|js});
CssJs.unsafe({js|placeContent|js}, {js| unsafe start safe right|js});
CssJs.unsafe({js|placeItems|js}, {js| normal|js});
CssJs.unsafe({js|placeItems|js}, {js| stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| first baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| center|js});
CssJs.unsafe({js|placeItems|js}, {js| start|js});
CssJs.unsafe({js|placeItems|js}, {js| end|js});
CssJs.unsafe({js|placeItems|js}, {js| self-start|js});
CssJs.unsafe({js|placeItems|js}, {js| self-end|js});
CssJs.unsafe({js|placeItems|js}, {js| unsafe start|js});
CssJs.unsafe({js|placeItems|js}, {js| safe start|js});
CssJs.unsafe({js|placeItems|js}, {js| normal normal|js});
CssJs.unsafe({js|placeItems|js}, {js| stretch normal|js});
CssJs.unsafe({js|placeItems|js}, {js| baseline normal|js});
CssJs.unsafe({js|placeItems|js}, {js| first baseline normal|js});
CssJs.unsafe({js|placeItems|js}, {js| self-start normal|js});
CssJs.unsafe({js|placeItems|js}, {js| unsafe start normal|js});
CssJs.unsafe({js|placeItems|js}, {js| normal stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| stretch stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| baseline stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| first baseline stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| self-start stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| unsafe start stretch|js});
CssJs.unsafe({js|placeItems|js}, {js| normal last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| stretch last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| baseline last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| first baseline last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| self-start last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| unsafe start last baseline|js});
CssJs.unsafe({js|placeItems|js}, {js| normal legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js| stretch legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js| baseline legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js| first baseline legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js| self-start legacy left|js});
CssJs.unsafe({js|placeItems|js}, {js| unsafe start legacy left|js});
CssJs.unsafe({js|gap|js}, {js| 0 0|js});
CssJs.unsafe({js|gap|js}, {js| 0 1em|js});
CssJs.unsafe({js|gap|js}, {js| 1em|js});
CssJs.unsafe({js|gap|js}, {js| 1em 1em|js});
CssJs.unsafe({js|columnGap|js}, {js| 0|js});
CssJs.unsafe({js|columnGap|js}, {js| 1em|js});
CssJs.unsafe({js|columnGap|js}, {js| normal|js});
CssJs.unsafe({js|rowGap|js}, {js| 0|js});
CssJs.unsafe({js|rowGap|js}, {js| 1em|js});
CssJs.unsafe({js|marginTrim|js}, {js| none|js});
CssJs.unsafe({js|marginTrim|js}, {js| in-flow|js});
CssJs.unsafe({js|marginTrim|js}, {js| all|js});
(CssJs.unsafe({js|color|js}, "unset"): CssJs.rule);
(CssJs.unsafe({js|font-weight|js}, "unset"): CssJs.rule);
(CssJs.unsafe({js|background-image|js}, "unset"): CssJs.rule);
(CssJs.unsafe({js|width|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|clipPath|js}, {js| url('#clip')|js});
CssJs.unsafe({js|clipPath|js}, {js| inset(50%)|js});
CssJs.unsafe({js|clipPath|js}, {js| border-box|js});
CssJs.unsafe({js|clipPath|js}, {js| padding-box|js});
CssJs.unsafe({js|clipPath|js}, {js| content-box|js});
CssJs.unsafe({js|clipPath|js}, {js| margin-box|js});
CssJs.unsafe({js|clipPath|js}, {js| fill-box|js});
CssJs.unsafe({js|clipPath|js}, {js| stroke-box|js});
CssJs.unsafe({js|clipPath|js}, {js| view-box|js});
CssJs.unsafe({js|clipPath|js}, {js| none|js});
CssJs.unsafe({js|clipRule|js}, {js| nonzero|js});
CssJs.unsafe({js|clipRule|js}, {js| evenodd|js});
CssJs.unsafe({js|maskImage|js}, {js| none|js});
CssJs.unsafe({js|maskImage|js}, {js| url(image.png)|js});
CssJs.unsafe({js|maskMode|js}, {js| alpha|js});
CssJs.unsafe({js|maskMode|js}, {js| luminance|js});
CssJs.unsafe({js|maskMode|js}, {js| match-source|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat-x|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat-y|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| space|js});
CssJs.unsafe({js|maskRepeat|js}, {js| round|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| space repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| round repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat space|js});
CssJs.unsafe({js|maskRepeat|js}, {js| space space|js});
CssJs.unsafe({js|maskRepeat|js}, {js| round space|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat space|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat round|js});
CssJs.unsafe({js|maskRepeat|js}, {js| space round|js});
CssJs.unsafe({js|maskRepeat|js}, {js| round round|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat round|js});
CssJs.unsafe({js|maskRepeat|js}, {js| repeat no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| space no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| round no-repeat|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat no-repeat|js});
CssJs.unsafe({js|maskPosition|js}, {js| center|js});
CssJs.unsafe({js|maskPosition|js}, {js| center center|js});
CssJs.unsafe({js|maskPosition|js}, {js| left 50%|js});
CssJs.unsafe({js|maskClip|js}, {js| border-box|js});
CssJs.unsafe({js|maskClip|js}, {js| padding-box|js});
CssJs.unsafe({js|maskClip|js}, {js| content-box|js});
CssJs.unsafe({js|maskClip|js}, {js| margin-box|js});
CssJs.unsafe({js|maskClip|js}, {js| fill-box|js});
CssJs.unsafe({js|maskClip|js}, {js| stroke-box|js});
CssJs.unsafe({js|maskClip|js}, {js| view-box|js});
CssJs.unsafe({js|maskClip|js}, {js| no-clip|js});
CssJs.unsafe({js|maskOrigin|js}, {js| border-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| padding-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| content-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| margin-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| fill-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| stroke-box|js});
CssJs.unsafe({js|maskOrigin|js}, {js| view-box|js});
CssJs.unsafe({js|maskSize|js}, {js| auto|js});
CssJs.unsafe({js|maskSize|js}, {js| 10px|js});
CssJs.unsafe({js|maskSize|js}, {js| cover|js});
CssJs.unsafe({js|maskSize|js}, {js| contain|js});
CssJs.unsafe({js|maskSize|js}, {js| 10px|js});
CssJs.unsafe({js|maskSize|js}, {js| 50%|js});
CssJs.unsafe({js|maskSize|js}, {js| 10px auto|js});
CssJs.unsafe({js|maskSize|js}, {js| auto 10%|js});
CssJs.unsafe({js|maskSize|js}, {js| 50em 50%|js});
CssJs.unsafe({js|maskComposite|js}, {js| add|js});
CssJs.unsafe({js|maskComposite|js}, {js| subtract|js});
CssJs.unsafe({js|maskComposite|js}, {js| intersect|js});
CssJs.unsafe({js|maskComposite|js}, {js| exclude|js});
CssJs.unsafe({js|mask|js}, {js| top|js});
CssJs.unsafe({js|mask|js}, {js| space|js});
CssJs.unsafe({js|mask|js}, {js| url(image.png)|js});
CssJs.unsafe({js|mask|js}, {js| url(image.png) luminance|js});
CssJs.unsafe({js|mask|js}, {js| url(image.png) luminance top space|js});
CssJs.unsafe({js|maskBorderSource|js}, {js| none|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 0 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 50% fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 1.1 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 0 1 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 0 1 2 fill|js});
CssJs.unsafe({js|maskBorderSlice|js}, {js| 0 1 2 3 fill|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| auto|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| 10px|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| 50%|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| 1|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| 1.0|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| auto 1|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| auto 1 50%|js});
CssJs.unsafe({js|maskBorderWidth|js}, {js| auto 1 50% 1.1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js| 0|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js| 1.1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js| 0 1|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js| 0 1 2|js});
CssJs.unsafe({js|maskBorderOutset|js}, {js| 0 1 2 3|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| stretch stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| repeat stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| round stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| space stretch|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| stretch repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| repeat repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| round repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| space repeat|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| stretch round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| repeat round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| round round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| space round|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| stretch space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| repeat space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| round space|js});
CssJs.unsafe({js|maskBorderRepeat|js}, {js| space space|js});
CssJs.unsafe({js|maskType|js}, {js| luminance|js});
CssJs.unsafe({js|maskType|js}, {js| alpha|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| normal|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| multiply|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| screen|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| overlay|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| darken|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| lighten|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| color-dodge|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| color-burn|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| hard-light|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| soft-light|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| difference|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| exclusion|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| hue|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| saturation|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| color|js});
CssJs.unsafe({js|mixBlendMode|js}, {js| luminosity|js});
CssJs.unsafe({js|isolation|js}, {js| auto|js});
CssJs.unsafe({js|isolation|js}, {js| isolate|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| normal|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| multiply|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| screen|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| overlay|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| darken|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| lighten|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| color-dodge|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| color-burn|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| hard-light|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| soft-light|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| difference|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| exclusion|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| hue|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| saturation|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| color|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| luminosity|js});
CssJs.unsafe({js|backgroundBlendMode|js}, {js| normal, multiply|js});
CssJs.unsafe({js|display|js}, {js| run-in|js});
CssJs.unsafe({js|display|js}, {js| flow|js});
CssJs.unsafe({js|display|js}, {js| flow-root|js});
CssJs.unsafe({js|filter|js}, {js| none|js});
CssJs.unsafe({js|filter|js}, {js| url(#id)|js});
CssJs.unsafe({js|filter|js}, {js| blur(5px)|js});
CssJs.unsafe({js|filter|js}, {js| brightness(0.5)|js});
CssJs.unsafe({js|filter|js}, {js| contrast(150%)|js});
CssJs.unsafe({js|filter|js}, {js| drop-shadow(15px 15px 15px black)|js});
CssJs.unsafe({js|filter|js}, {js| grayscale(50%)|js});
CssJs.unsafe({js|filter|js}, {js| hue-rotate(50deg)|js});
CssJs.unsafe({js|filter|js}, {js| invert(50%)|js});
CssJs.unsafe({js|filter|js}, {js| opacity(50%)|js});
CssJs.unsafe({js|filter|js}, {js| sepia(50%)|js});
CssJs.unsafe({js|filter|js}, {js| saturate(150%)|js});
CssJs.unsafe({js|filter|js}, {js| grayscale(100%) sepia(100%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| none|js});
CssJs.unsafe({js|backdropFilter|js}, {js| url(#id)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| blur(5px)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| brightness(0.5)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| contrast(150%)|js});
CssJs.unsafe(
  {js|backdropFilter|js},
  {js| drop-shadow(15px 15px 15px black)|js},
);
CssJs.unsafe({js|backdropFilter|js}, {js| grayscale(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| hue-rotate(50deg)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| invert(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| opacity(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| sepia(50%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| saturate(150%)|js});
CssJs.unsafe({js|backdropFilter|js}, {js| grayscale(100%) sepia(100%)|js});
CssJs.unsafe({js|touchAction|js}, {js| auto|js});
CssJs.unsafe({js|touchAction|js}, {js| none|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-x|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-y|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-x pan-y|js});
CssJs.unsafe({js|touchAction|js}, {js| manipulation|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-left|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-right|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-up|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-down|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-left pan-up|js});
CssJs.unsafe({js|touchAction|js}, {js| pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-x pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-y pinch-zoom|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-x pan-y pinch-zoom|js});
CssJs.unsafe({js|breakBefore|js}, {js| auto|js});
CssJs.unsafe({js|breakBefore|js}, {js| avoid|js});
CssJs.unsafe({js|breakBefore|js}, {js| avoid-page|js});
CssJs.unsafe({js|breakBefore|js}, {js| page|js});
CssJs.unsafe({js|breakBefore|js}, {js| left|js});
CssJs.unsafe({js|breakBefore|js}, {js| right|js});
CssJs.unsafe({js|breakBefore|js}, {js| recto|js});
CssJs.unsafe({js|breakBefore|js}, {js| verso|js});
CssJs.unsafe({js|breakBefore|js}, {js| avoid-column|js});
CssJs.unsafe({js|breakBefore|js}, {js| column|js});
CssJs.unsafe({js|breakBefore|js}, {js| avoid-region|js});
CssJs.unsafe({js|breakBefore|js}, {js| region|js});
CssJs.unsafe({js|breakAfter|js}, {js| auto|js});
CssJs.unsafe({js|breakAfter|js}, {js| avoid|js});
CssJs.unsafe({js|breakAfter|js}, {js| avoid-page|js});
CssJs.unsafe({js|breakAfter|js}, {js| page|js});
CssJs.unsafe({js|breakAfter|js}, {js| left|js});
CssJs.unsafe({js|breakAfter|js}, {js| right|js});
CssJs.unsafe({js|breakAfter|js}, {js| recto|js});
CssJs.unsafe({js|breakAfter|js}, {js| verso|js});
CssJs.unsafe({js|breakAfter|js}, {js| avoid-column|js});
CssJs.unsafe({js|breakAfter|js}, {js| column|js});
CssJs.unsafe({js|breakAfter|js}, {js| avoid-region|js});
CssJs.unsafe({js|breakAfter|js}, {js| region|js});
CssJs.unsafe({js|breakInside|js}, {js| auto|js});
CssJs.unsafe({js|breakInside|js}, {js| avoid|js});
CssJs.unsafe({js|breakInside|js}, {js| avoid-page|js});
CssJs.unsafe({js|breakInside|js}, {js| avoid-column|js});
CssJs.unsafe({js|breakInside|js}, {js| avoid-region|js});
CssJs.unsafe({js|boxDecorationBreak|js}, {js| slice|js});
CssJs.unsafe({js|boxDecorationBreak|js}, {js| clone|js});
CssJs.unsafe({js|orphans|js}, {js| 1|js});
CssJs.unsafe({js|orphans|js}, {js| 2|js});
(CssJs.widows(1): CssJs.rule);
(CssJs.widows(2): CssJs.rule);
CssJs.unsafe({js|position|js}, {js| sticky|js});
CssJs.unsafe({js|willChange|js}, {js| scroll-position|js});
CssJs.unsafe({js|willChange|js}, {js| contents|js});
CssJs.unsafe({js|willChange|js}, {js| transform|js});
CssJs.unsafe({js|willChange|js}, {js| top, left|js});
CssJs.unsafe({js|scrollBehavior|js}, {js| auto|js});
CssJs.unsafe({js|scrollBehavior|js}, {js| smooth|js});
CssJs.unsafe({js|scrollMargin|js}, {js| 0px|js});
CssJs.unsafe({js|scrollMargin|js}, {js| 6px 5px|js});
CssJs.unsafe({js|scrollMargin|js}, {js| 10px 20px 30px|js});
CssJs.unsafe({js|scrollMargin|js}, {js| 10px 20px 30px 40px|js});
CssJs.unsafe({js|scrollMargin|js}, {js| 20px 3em 1in 5rem|js});
CssJs.unsafe({js|scrollMarginBlock|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginBlock|js}, {js| 10px 10px|js});
CssJs.unsafe({js|scrollMarginBlockEnd|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginBlockStart|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginBottom|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginInline|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginInline|js}, {js| 10px 10px|js});
CssJs.unsafe({js|scrollMarginInlineStart|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginInlineEnd|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginLeft|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginRight|js}, {js| 10px|js});
CssJs.unsafe({js|scrollMarginTop|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPadding|js}, {js| auto|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 0px|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 6px 5px|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 10px 20px 30px|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 10px 20px 30px 40px|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 10px auto 30px auto|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 10%|js});
CssJs.unsafe({js|scrollPadding|js}, {js| 20% 3em 1in 5rem|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js| 10px 50%|js});
CssJs.unsafe({js|scrollPaddingBlock|js}, {js| 50% 50%|js});
CssJs.unsafe({js|scrollPaddingBlockEnd|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingBlockEnd|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingBlockStart|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingBlockStart|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingBottom|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingBottom|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js| 10px 50%|js});
CssJs.unsafe({js|scrollPaddingInline|js}, {js| 50% 50%|js});
CssJs.unsafe({js|scrollPaddingInlineEnd|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingInlineEnd|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingInlineStart|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingInlineStart|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingLeft|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingLeft|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingRight|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingRight|js}, {js| 50%|js});
CssJs.unsafe({js|scrollPaddingTop|js}, {js| 10px|js});
CssJs.unsafe({js|scrollPaddingTop|js}, {js| 50%|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| none|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| end|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| center|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| none start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| end center|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| center start|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| end none|js});
CssJs.unsafe({js|scrollSnapAlign|js}, {js| center center|js});
CssJs.unsafe({js|scrollSnapStop|js}, {js| normal|js});
CssJs.unsafe({js|scrollSnapStop|js}, {js| always|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| none|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| x mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| y mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| block mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| inline mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| both mandatory|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| x proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| y proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| block proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| inline proximity|js});
CssJs.unsafe({js|scrollSnapType|js}, {js| both proximity|js});
CssJs.unsafe({js|overflowAnchor|js}, {js| none|js});
CssJs.unsafe({js|overflowAnchor|js}, {js| auto|js});
CssJs.unsafe({js|captionSide|js}, {js| inline-start|js});
CssJs.unsafe({js|captionSide|js}, {js| inline-end|js});
CssJs.unsafe({js|float|js}, {js| inline-start|js});
CssJs.unsafe({js|float|js}, {js| inline-end|js});
CssJs.unsafe({js|clear|js}, {js| inline-start|js});
CssJs.unsafe({js|clear|js}, {js| inline-end|js});
(CssJs.textAlign(`start): CssJs.rule);
(CssJs.textAlign(`end_): CssJs.rule);
CssJs.unsafe({js|resize|js}, {js| block|js});
CssJs.unsafe({js|resize|js}, {js| inline|js});
CssJs.unsafe({js|blockSize|js}, {js| 100px|js});
CssJs.unsafe({js|inlineSize|js}, {js| 100px|js});
CssJs.unsafe({js|minBlockSize|js}, {js| 100px|js});
CssJs.unsafe({js|minInlineSize|js}, {js| 100px|js});
CssJs.unsafe({js|maxBlockSize|js}, {js| 100px|js});
CssJs.unsafe({js|maxInlineSize|js}, {js| 100px|js});
CssJs.unsafe({js|marginBlock|js}, {js| 10px|js});
CssJs.unsafe({js|marginBlock|js}, {js| 10px 10px|js});
CssJs.unsafe({js|marginBlockStart|js}, {js| 10px|js});
CssJs.unsafe({js|marginBlockEnd|js}, {js| 10px|js});
CssJs.unsafe({js|marginInline|js}, {js| 10px|js});
CssJs.unsafe({js|marginInline|js}, {js| 10px 10px|js});
CssJs.unsafe({js|marginInlineStart|js}, {js| 10px|js});
CssJs.unsafe({js|marginInlineEnd|js}, {js| 10px|js});
CssJs.unsafe({js|inset|js}, {js| 10px|js});
CssJs.unsafe({js|inset|js}, {js| 10px 10px|js});
CssJs.unsafe({js|inset|js}, {js| 10px 10px 10px|js});
CssJs.unsafe({js|inset|js}, {js| 10px 10px 10px 10px|js});
CssJs.unsafe({js|insetBlock|js}, {js| 10px|js});
CssJs.unsafe({js|insetBlock|js}, {js| 10px 10px|js});
CssJs.unsafe({js|insetBlockStart|js}, {js| 10px|js});
CssJs.unsafe({js|insetBlockEnd|js}, {js| 10px|js});
CssJs.unsafe({js|insetInline|js}, {js| 10px|js});
CssJs.unsafe({js|insetInline|js}, {js| 10px 10px|js});
CssJs.unsafe({js|insetInlineStart|js}, {js| 10px|js});
CssJs.unsafe({js|insetInlineEnd|js}, {js| 10px|js});
CssJs.unsafe({js|paddingBlock|js}, {js| 10px|js});
CssJs.unsafe({js|paddingBlock|js}, {js| 10px 10px|js});
CssJs.unsafe({js|paddingBlockStart|js}, {js| 10px|js});
CssJs.unsafe({js|paddingBlockEnd|js}, {js| 10px|js});
CssJs.unsafe({js|paddingInline|js}, {js| 10px|js});
CssJs.unsafe({js|paddingInline|js}, {js| 10px 10px|js});
CssJs.unsafe({js|paddingInlineStart|js}, {js| 10px|js});
CssJs.unsafe({js|paddingInlineEnd|js}, {js| 10px|js});
CssJs.unsafe({js|borderBlock|js}, {js| 1px|js});
CssJs.unsafe({js|borderBlock|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderBlock|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderBlockStart|js}, {js| 1px|js});
CssJs.unsafe({js|borderBlockStart|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderBlockStart|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderBlockStartWidth|js}, {js| thin|js});
CssJs.unsafe({js|borderBlockStartStyle|js}, {js| dotted|js});
CssJs.unsafe({js|borderBlockStartColor|js}, {js| navy|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js| 1px|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderBlockEnd|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderBlockEndWidth|js}, {js| thin|js});
CssJs.unsafe({js|borderBlockEndStyle|js}, {js| dotted|js});
CssJs.unsafe({js|borderBlockEndColor|js}, {js| navy|js});
CssJs.unsafe({js|borderBlockColor|js}, {js| navy blue|js});
CssJs.unsafe({js|borderInline|js}, {js| 1px|js});
CssJs.unsafe({js|borderInline|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderInline|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderInlineStart|js}, {js| 1px|js});
CssJs.unsafe({js|borderInlineStart|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderInlineStart|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderInlineStartWidth|js}, {js| thin|js});
CssJs.unsafe({js|borderInlineStartStyle|js}, {js| dotted|js});
CssJs.unsafe({js|borderInlineStartColor|js}, {js| navy|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js| 1px|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js| 2px dotted|js});
CssJs.unsafe({js|borderInlineEnd|js}, {js| medium dashed green|js});
CssJs.unsafe({js|borderInlineEndWidth|js}, {js| thin|js});
CssJs.unsafe({js|borderInlineEndStyle|js}, {js| dotted|js});
CssJs.unsafe({js|borderInlineEndColor|js}, {js| navy|js});
CssJs.unsafe({js|borderInlineColor|js}, {js| navy blue|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js| 0|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js| 50%|js});
CssJs.unsafe({js|borderStartStartRadius|js}, {js| 250px 100px|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js| 0|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js| 50%|js});
CssJs.unsafe({js|borderStartEndRadius|js}, {js| 250px 100px|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js| 0|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js| 50%|js});
CssJs.unsafe({js|borderEndStartRadius|js}, {js| 250px 100px|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js| 0|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js| 50%|js});
CssJs.unsafe({js|borderEndEndRadius|js}, {js| 250px 100px|js});
CssJs.unsafe({js|listStyleType|js}, {js| disclosure-closed|js});
CssJs.unsafe({js|listStyleType|js}, {js| disclosure-open|js});
CssJs.unsafe({js|listStyleType|js}, {js| hebrew|js});
CssJs.unsafe({js|listStyleType|js}, {js| cjk-decimal|js});
CssJs.unsafe({js|listStyleType|js}, {js| cjk-ideographic|js});
CssJs.unsafe({js|listStyleType|js}, {js| hiragana|js});
CssJs.unsafe({js|listStyleType|js}, {js| katakana|js});
CssJs.unsafe({js|listStyleType|js}, {js| hiragana-iroha|js});
CssJs.unsafe({js|listStyleType|js}, {js| katakana-iroha|js});
CssJs.unsafe({js|listStyleType|js}, {js| japanese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| japanese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| korean-hangul-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| korean-hanja-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| korean-hanja-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| simp-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| simp-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| trad-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| trad-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| cjk-heavenly-stem|js});
CssJs.unsafe({js|listStyleType|js}, {js| cjk-earthly-branch|js});
CssJs.unsafe({js|listStyleType|js}, {js| trad-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| trad-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| simp-chinese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| simp-chinese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| japanese-informal|js});
CssJs.unsafe({js|listStyleType|js}, {js| japanese-formal|js});
CssJs.unsafe({js|listStyleType|js}, {js| arabic-indic|js});
CssJs.unsafe({js|listStyleType|js}, {js| persian|js});
CssJs.unsafe({js|listStyleType|js}, {js| urdu|js});
CssJs.unsafe({js|listStyleType|js}, {js| devanagari|js});
CssJs.unsafe({js|listStyleType|js}, {js| gurmukhi|js});
CssJs.unsafe({js|listStyleType|js}, {js| gujarati|js});
CssJs.unsafe({js|listStyleType|js}, {js| oriya|js});
CssJs.unsafe({js|listStyleType|js}, {js| kannada|js});
CssJs.unsafe({js|listStyleType|js}, {js| malayalam|js});
CssJs.unsafe({js|listStyleType|js}, {js| bengali|js});
CssJs.unsafe({js|listStyleType|js}, {js| tamil|js});
CssJs.unsafe({js|listStyleType|js}, {js| telugu|js});
CssJs.unsafe({js|listStyleType|js}, {js| thai|js});
CssJs.unsafe({js|listStyleType|js}, {js| lao|js});
CssJs.unsafe({js|listStyleType|js}, {js| myanmar|js});
CssJs.unsafe({js|listStyleType|js}, {js| khmer|js});
CssJs.unsafe({js|listStyleType|js}, {js| hangul|js});
CssJs.unsafe({js|listStyleType|js}, {js| hangul-consonant|js});
CssJs.unsafe({js|listStyleType|js}, {js| ethiopic-halehame|js});
CssJs.unsafe({js|listStyleType|js}, {js| ethiopic-numeric|js});
CssJs.unsafe({js|listStyleType|js}, {js| ethiopic-halehame-am|js});
CssJs.unsafe({js|listStyleType|js}, {js| ethiopic-halehame-ti-er|js});
CssJs.unsafe({js|listStyleType|js}, {js| ethiopic-halehame-ti-et|js});
CssJs.unsafe({js|listStyleType|js}, {js| other-style|js});
CssJs.unsafe({js|listStyleType|js}, {js| inside|js});
CssJs.unsafe({js|listStyleType|js}, {js| outside|js});
CssJs.unsafe({js|listStyleType|js}, {js| \32 style|js});
CssJs.unsafe({js|listStyleType|js}, {js| "-"|js});
CssJs.unsafe({js|listStyleType|js}, {js| '-'|js});
CssJs.unsafe({js|counterReset|js}, {js| foo|js});
CssJs.unsafe({js|counterReset|js}, {js| foo 1|js});
CssJs.unsafe({js|counterReset|js}, {js| foo 1 bar|js});
CssJs.unsafe({js|counterReset|js}, {js| foo 1 bar 2|js});
CssJs.unsafe({js|counterReset|js}, {js| none|js});
CssJs.unsafe({js|counterSet|js}, {js| foo|js});
CssJs.unsafe({js|counterSet|js}, {js| foo 1|js});
CssJs.unsafe({js|counterSet|js}, {js| foo 1 bar|js});
CssJs.unsafe({js|counterSet|js}, {js| foo 1 bar 2|js});
CssJs.unsafe({js|counterSet|js}, {js| none|js});
CssJs.unsafe({js|counterIncrement|js}, {js| foo|js});
CssJs.unsafe({js|counterIncrement|js}, {js| foo 1|js});
CssJs.unsafe({js|counterIncrement|js}, {js| foo 1 bar|js});
CssJs.unsafe({js|counterIncrement|js}, {js| foo 1 bar 2|js});
CssJs.unsafe({js|counterIncrement|js}, {js| none|js});
CssJs.unsafe({js|lineClamp|js}, {js| none|js});
CssJs.unsafe({js|lineClamp|js}, {js| 1|js});
CssJs.unsafe({js|maxLines|js}, {js| none|js});
CssJs.unsafe({js|maxLines|js}, {js| 1|js});
(CssJs.overflowX(`visible): CssJs.rule);
(CssJs.overflowX(`hidden): CssJs.rule);
CssJs.unsafe({js|overflowX|js}, {js| clip|js});
(CssJs.overflowX(`scroll): CssJs.rule);
(CssJs.overflowX(`auto): CssJs.rule);
(CssJs.overflowY(`visible): CssJs.rule);
(CssJs.overflowY(`hidden): CssJs.rule);
(CssJs.overflowY(`clip): CssJs.rule);
(CssJs.overflowY(`scroll): CssJs.rule);
(CssJs.overflowY(`auto): CssJs.rule);
CssJs.unsafe({js|overflowInline|js}, {js| visible|js});
CssJs.unsafe({js|overflowInline|js}, {js| hidden|js});
CssJs.unsafe({js|overflowInline|js}, {js| clip|js});
CssJs.unsafe({js|overflowInline|js}, {js| scroll|js});
CssJs.unsafe({js|overflowInline|js}, {js| auto|js});
CssJs.unsafe({js|overflowBlock|js}, {js| visible|js});
CssJs.unsafe({js|overflowBlock|js}, {js| hidden|js});
CssJs.unsafe({js|overflowBlock|js}, {js| clip|js});
CssJs.unsafe({js|overflowBlock|js}, {js| scroll|js});
CssJs.unsafe({js|overflowBlock|js}, {js| auto|js});
CssJs.unsafe({js|contain|js}, {js| none|js});
CssJs.unsafe({js|contain|js}, {js| strict|js});
CssJs.unsafe({js|contain|js}, {js| content|js});
CssJs.unsafe({js|contain|js}, {js| size|js});
CssJs.unsafe({js|contain|js}, {js| layout|js});
CssJs.unsafe({js|contain|js}, {js| paint|js});
CssJs.unsafe({js|contain|js}, {js| size layout|js});
CssJs.unsafe({js|contain|js}, {js| size paint|js});
CssJs.unsafe({js|contain|js}, {js| size layout paint|js});
(CssJs.width(`maxContent): CssJs.rule);
(CssJs.width(`minContent): CssJs.rule);
CssJs.unsafe({js|width|js}, {js| fit-content(10%)|js});
(CssJs.minWidth(`maxContent): CssJs.rule);
(CssJs.minWidth(`minContent): CssJs.rule);
CssJs.unsafe({js|minWidth|js}, {js| fit-content(10%)|js});
(CssJs.maxWidth(`maxContent): CssJs.rule);
(CssJs.maxWidth(`minContent): CssJs.rule);
CssJs.unsafe({js|maxWidth|js}, {js| fit-content(10%)|js});
(CssJs.height(`maxContent): CssJs.rule);
(CssJs.height(`minContent): CssJs.rule);
CssJs.unsafe({js|height|js}, {js| fit-content(10%)|js});
(CssJs.minHeight(`maxContent): CssJs.rule);
(CssJs.minHeight(`minContent): CssJs.rule);
CssJs.unsafe({js|minHeight|js}, {js| fit-content(10%)|js});
(CssJs.maxHeight(`maxContent): CssJs.rule);
(CssJs.maxHeight(`minContent): CssJs.rule);
CssJs.unsafe({js|maxHeight|js}, {js| fit-content(10%)|js});
CssJs.unsafe({js|aspectRatio|js}, {js| auto|js});
(CssJs.width(`fitContent): CssJs.rule);
(CssJs.minWidth(`fitContent): CssJs.rule);
(CssJs.maxWidth(`fitContent): CssJs.rule);
(CssJs.height(`fitContent): CssJs.rule);
(CssJs.minHeight(`fitContent): CssJs.rule);
(CssJs.maxHeight(`fitContent): CssJs.rule);
CssJs.unsafe({js|overscrollBehavior|js}, {js| contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| contain contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| none contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| auto contain|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| contain none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| none none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| auto none|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| contain auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| none auto|js});
CssJs.unsafe({js|overscrollBehavior|js}, {js| auto auto|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js| contain|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js| none|js});
CssJs.unsafe({js|overscrollBehaviorX|js}, {js| auto|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js| contain|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js| none|js});
CssJs.unsafe({js|overscrollBehaviorY|js}, {js| auto|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js| contain|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js| none|js});
CssJs.unsafe({js|overscrollBehaviorInline|js}, {js| auto|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js| contain|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js| none|js});
CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js| auto|js});
CssJs.unsafe({js|scrollbarColor|js}, {js| auto|js});
CssJs.unsafe({js|scrollbarColor|js}, {js| dark|js});
CssJs.unsafe({js|scrollbarColor|js}, {js| light|js});
CssJs.unsafe({js|scrollbarColor|js}, {js| red blue|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js| auto|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js| thin|js});
CssJs.unsafe({js|scrollbarWidth|js}, {js| none|js});
CssJs.unsafe({js|pointerEvents|js}, {js| auto|js});
CssJs.unsafe({js|pointerEvents|js}, {js| visiblePainted|js});
CssJs.unsafe({js|pointerEvents|js}, {js| visibleFill|js});
CssJs.unsafe({js|pointerEvents|js}, {js| visibleStroke|js});
CssJs.unsafe({js|pointerEvents|js}, {js| visible|js});
CssJs.unsafe({js|pointerEvents|js}, {js| painted|js});
CssJs.unsafe({js|pointerEvents|js}, {js| fill|js});
CssJs.unsafe({js|pointerEvents|js}, {js| stroke|js});
CssJs.unsafe({js|pointerEvents|js}, {js| all|js});
CssJs.unsafe({js|pointerEvents|js}, {js| none|js});
(CssJs.lineHeightStep(`pxFloat(30.)): CssJs.rule);
(CssJs.lineHeightStep(`em(2.)): CssJs.rule);
(CssJs.width(`calc((`add, `percent(50.), `pxFloat(4.)))): CssJs.rule);
(CssJs.width(`calc((`sub, `pxFloat(20.), `pxFloat(10.)))): CssJs.rule);
(
  CssJs.width(
    `calc((`sub, `vh(100.), `calc((`add, `rem(2.), `pxFloat(120.))))),
  ): CssJs.rule
);
(
  CssJs.width(
    `calc((
      `sub,
      `vh(100.),
      `calc((
        `add,
        `rem(2.),
        `calc((
          `add,
          `rem(2.),
          `calc((
            `add,
            `rem(2.),
            `calc((`add, `rem(2.), `pxFloat(120.))),
          )),
        )),
      )),
    )),
  ): CssJs.rule
);
CssJs.unsafe({js|MozAppearance|js}, {js| textfield|js});
CssJs.unsafe({js|WebkitAppearance|js}, {js| none|js});
CssJs.unsafe({js|WebkitBoxOrient|js}, {js| vertical|js});
CssJs.unsafe(
  {js|WebkitBoxShadow|js},
  {js| inset 0 0 0 1000px $(Color.Background.selectedMuted)|js},
);
CssJs.unsafe({js|WebkitLineClamp|js}, {js| 2|js});
CssJs.unsafe({js|WebkitOverflowScrolling|js}, {js| touch|js});
CssJs.unsafe({js|WebkitTapHighlightColor|js}, {js| transparent|js});
CssJs.unsafe({js|WebkitTextFillColor|js}, {js| $(Color.Text.primary)|js});
CssJs.unsafe({js|animation|js}, {js| none|js});
CssJs.unsafe({js|appearance|js}, {js| none|js});
CssJs.unsafe({js|aspectRatio|js}, {js| 21 / 8|js});
(CssJs.backgroundColor(c): CssJs.rule);
(CssJs.unsafe({js|bottom|js}, "unset"): CssJs.rule);
(CssJs.boxShadows(`none): CssJs.rule);
CssJs.unsafe({js|breakInside|js}, {js| avoid|js});
CssJs.unsafe({js|caretColor|js}, {js| #e15a46|js});
(CssJs.unsafe({js|color|js}, "inherit"): CssJs.rule);
CssJs.unsafe({js|columnWidth|js}, {js| 125px|js});
CssJs.unsafe({js|columnWidth|js}, {js| auto|js});
CssJs.unsafe({js|content|js}, {js| ""|js});
(CssJs.unsafe({js|content|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|display|js}, {js| -webkit-box|js});
(CssJs.display(`contents): CssJs.rule);
CssJs.unsafe({js|fill|js}, {js| $(color)|js});
CssJs.unsafe({js|fill|js}, {js| currentColor|js});
CssJs.unsafe({js|gap|js}, {js| 4px|js});
(CssJs.unsafe({js|grid-column|js}, "unset"): CssJs.rule);
(CssJs.unsafe({js|grid-row|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|gridTemplateColumns|js}, {js| max-content max-content|js});
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js| minmax(10px, auto) fit-content(20px) fit-content(20px)|js},
);
CssJs.unsafe(
  {js|gridTemplateColumns|js},
  {js| minmax(51px, auto) fit-content(20px) fit-content(20px)|js},
);
CssJs.unsafe({js|gridTemplateColumns|js}, {js| repeat(2, auto)|js});
CssJs.unsafe({js|gridTemplateColumns|js}, {js| repeat(3, auto)|js});
(CssJs.height(`fitContent): CssJs.rule);
CssJs.unsafe({js|justifyItems|js}, {js| start|js});
(CssJs.unsafe({js|justify-self|js}, "unset"): CssJs.rule);
(CssJs.unsafe({js|left|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|maskPosition|js}, {js| center center|js});
CssJs.unsafe({js|maskRepeat|js}, {js| no-repeat|js});
(CssJs.maxWidth(`maxContent): CssJs.rule);
CssJs.unsafe({js|outline|js}, {js| none|js});
CssJs.unsafe({js|overflowAnchor|js}, {js| none|js});
(CssJs.unsafe({js|position|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|resize|js}, {js| none|js});
CssJs.unsafe({js|scrollBehavior|js}, {js| smooth|js});
CssJs.unsafe({js|strokeOpacity|js}, {js| 0|js});
CssJs.unsafe({js|stroke|js}, {js| $(Color.Text.white)|js});
(CssJs.top(`calc((`sub, `percent(50.), `pxFloat(1.)))): CssJs.rule);
(CssJs.unsafe({js|top|js}, "unset"): CssJs.rule);
CssJs.unsafe({js|touchAction|js}, {js| none|js});
CssJs.unsafe({js|touchAction|js}, {js| pan-x pan-y|js});
(CssJs.transform(`none): CssJs.rule);
(CssJs.width(`fitContent): CssJs.rule);
(CssJs.width(`maxContent): CssJs.rule);
CssJs.unsafe({js|wordBreak|js}, {js| break-word|js});
