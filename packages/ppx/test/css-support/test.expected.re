CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "space")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "round")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "space repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "round repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "no-repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "repeat space")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "space space")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "round space")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "no-repeat space")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "repeat round")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "space round")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "round round")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "no-repeat round")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "repeat no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "space no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "round no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundRepeat", "no-repeat no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("backgroundAttachment", "local")|]);
CssJs.style(. [|
  CssJs.unsafe("backgroundPosition", "bottom 10px right 20px"),
|]);
CssJs.style(. [|CssJs.unsafe("backgroundPosition", "bottom 10px right")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPosition", "top right 10px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundClip", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundClip", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundClip", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundOrigin", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundOrigin", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundOrigin", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "auto")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "cover")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "contain")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "10px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "50%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "10px auto")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "auto 10%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundSize", "50em 50%")|]);
CssJs.style(. [|CssJs.unsafe("background", "url(foo.png), url(bar.svg)")|]);
CssJs.style(. [|CssJs.unsafe("background", "top left / 50% 60%")|]);
CssJs.style(. [|CssJs.unsafe("background", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("background", "border-box padding-box")|]);
CssJs.style(. [|
  CssJs.unsafe(
    "background",
    "url(foo.png) bottom right / cover padding-box content-box",
  ),
|]);
CssJs.style(. [|CssJs.borderTopLeftRadius(`zero)|]);
CssJs.style(. [|CssJs.borderTopLeftRadius(`percent(50.))|]);
CssJs.style(. [|CssJs.unsafe("borderTopLeftRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.borderTopRightRadius(`zero)|]);
CssJs.style(. [|CssJs.borderTopRightRadius(`percent(50.))|]);
CssJs.style(. [|CssJs.unsafe("borderTopRightRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.borderBottomRightRadius(`zero)|]);
CssJs.style(. [|CssJs.borderBottomRightRadius(`percent(50.))|]);
CssJs.style(. [|CssJs.unsafe("borderBottomRightRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.borderBottomLeftRadius(`zero)|]);
CssJs.style(. [|CssJs.borderBottomLeftRadius(`percent(50.))|]);
CssJs.style(. [|CssJs.unsafe("borderBottomLeftRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.unsafe("borderRadius", "10px")|]);
CssJs.style(. [|CssJs.unsafe("borderRadius", "50%")|]);
CssJs.style(. [|CssJs.unsafe("borderRadius", "10px / 20px")|]);
CssJs.style(. [|CssJs.unsafe("borderRadius", "2px 4px 8px 16px")|]);
CssJs.style(. [|
  CssJs.unsafe("borderRadius", "2px 4px 8px 16px / 2px 4px 8px 16px"),
|]);
CssJs.style(. [|CssJs.unsafe("borderImageSource", "none")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSource", "url(foo.png)")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 10 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 30% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 10 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 10 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 10 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 30% 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% 30% 30% 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "fill 30%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "fill 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "fill 2 4 8% 16%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "30% fill")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "10 fill")|]);
CssJs.style(. [|CssJs.unsafe("borderImageSlice", "2 4 8% 16% fill")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "28")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5% 10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "28 10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "auto 10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px 5%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5% 5%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "28 5%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "auto 5%")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px 28")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5% 28")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "28 28")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "auto 28")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5% auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "28 auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "auto auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "10px 10% 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImageWidth", "5% 10px 20 auto")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "10px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "20")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "10px 20")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "10px 20px")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "20 30")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "2px 3px 4")|]);
CssJs.style(. [|CssJs.unsafe("borderImageOutset", "1 2px 3px 4")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "repeat")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "round")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "space")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "stretch stretch")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "repeat stretch")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "round stretch")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "space stretch")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "stretch repeat")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "round repeat")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "space repeat")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "stretch round")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "repeat round")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "round round")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "space round")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "stretch space")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "repeat space")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "round space")|]);
CssJs.style(. [|CssJs.unsafe("borderImageRepeat", "space space")|]);
CssJs.style(. [|CssJs.unsafe("borderImage", "url(foo.png) 10")|]);
CssJs.style(. [|CssJs.unsafe("borderImage", "url(foo.png) 10%")|]);
CssJs.style(. [|CssJs.unsafe("borderImage", "url(foo.png) 10% fill")|]);
CssJs.style(. [|CssJs.unsafe("borderImage", "url(foo.png) 10 round")|]);
CssJs.style(. [|
  CssJs.unsafe("borderImage", "url(foo.png) 10 stretch repeat"),
|]);
CssJs.style(. [|CssJs.unsafe("borderImage", "url(foo.png) 10 / 10px")|]);
CssJs.style(. [|
  CssJs.unsafe("borderImage", "url(foo.png) 10 / 10% / 10px"),
|]);
CssJs.style(. [|
  CssJs.unsafe("borderImage", "url(foo.png) fill 10 / 10% / 10px"),
|]);
CssJs.style(. [|
  CssJs.unsafe("borderImage", "url(foo.png) fill 10 / 10% / 10px space"),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|
    CssJs.Shadow.box(~x=`pxFloat(1.), ~y=`pxFloat(1.), `currentColor),
  |]),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|CssJs.Shadow.box(~x=`zero, ~y=`zero, CssJs.black)|]),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      CssJs.black,
    ),
  |]),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      CssJs.black,
    ),
  |]),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(1.),
      ~inset=true,
      `currentColor,
    ),
  |]),
|]);
CssJs.style(. [|
  CssJs.boxShadows([|
    CssJs.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      ~spread=`pxFloat(4.),
      ~inset=true,
      CssJs.black,
    ),
  |]),
|]);
CssJs.style(. [|
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
  |]),
|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "right")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "center")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "50%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "left, left")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "left, right")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "right, left")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "left, 0%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "10%, 20%, 40%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "0px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "30px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "0%, 10%, 20%, 30%")|]);
CssJs.style(. [|
  CssJs.unsafe("backgroundPositionX", "left, left, left, left, left"),
|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "right 20px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "left 20px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "right -50px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "left -50px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionX", "right 20px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "bottom")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "center")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "50%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "top, top")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "top, bottom")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "bottom, top")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "top, 0%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "10%, 20%, 40%")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "0px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "30px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "0%, 10%, 20%, 30%")|]);
CssJs.style(. [|
  CssJs.unsafe("backgroundPositionY", "top, top, top, top, top"),
|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "bottom 20px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "top 20px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "bottom -50px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "top -50px")|]);
CssJs.style(. [|CssJs.unsafe("backgroundPositionY", "bottom 20px")|]);
CssJs.style(. [|CssJs.boxSizing(`borderBox)|]);
CssJs.style(. [|CssJs.boxSizing(`contentBox)|]);
CssJs.style(. [|CssJs.unsafe("outlineStyle", "auto")|]);
CssJs.style(. [|CssJs.unsafe("outlineOffset", "-5px")|]);
CssJs.style(. [|CssJs.unsafe("outlineOffset", "0")|]);
CssJs.style(. [|CssJs.unsafe("outlineOffset", "5px")|]);
CssJs.style(. [|CssJs.unsafe("resize", "none")|]);
CssJs.style(. [|CssJs.unsafe("resize", "both")|]);
CssJs.style(. [|CssJs.unsafe("resize", "horizontal")|]);
CssJs.style(. [|CssJs.unsafe("resize", "vertical")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "clip")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "ellipsis")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "url(foo.png) 2 2, auto")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "default")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "none")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "context-menu")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "cell")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "vertical-text")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "alias")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "copy")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "no-drop")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "not-allowed")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "grab")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "grabbing")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "ew-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "ns-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "nesw-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "nwse-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "col-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "row-resize")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "all-scroll")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "zoom-in")|]);
CssJs.style(. [|CssJs.unsafe("cursor", "zoom-out")|]);
CssJs.style(. [|CssJs.unsafe("caretColor", "auto")|]);
CssJs.style(. [|CssJs.unsafe("caretColor", "green")|]);
CssJs.style(. [|CssJs.unsafe("appearance", "auto")|]);
CssJs.style(. [|CssJs.unsafe("appearance", "none")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "clip")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "ellipsis")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "'foo'")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "clip clip")|]);
CssJs.style(. [|CssJs.unsafe("textOverflow", "ellipsis clip")|]);
CssJs.style(. [|CssJs.unsafe("userSelect", "auto")|]);
CssJs.style(. [|CssJs.unsafe("userSelect", "text")|]);
CssJs.style(. [|CssJs.unsafe("userSelect", "none")|]);
CssJs.style(. [|CssJs.unsafe("userSelect", "contain")|]);
CssJs.style(. [|CssJs.unsafe("userSelect", "all")|]);
CssJs.style(. [|CssJs.unsafe("transitionProperty", "none")|]);
CssJs.style(. [|CssJs.unsafe("transitionProperty", "all")|]);
CssJs.style(. [|CssJs.unsafe("transitionProperty", "width")|]);
CssJs.style(. [|CssJs.unsafe("transitionProperty", "width, height")|]);
CssJs.style(. [|CssJs.unsafe("transitionDuration", "0s")|]);
CssJs.style(. [|CssJs.unsafe("transitionDuration", "1s")|]);
CssJs.style(. [|CssJs.unsafe("transitionDuration", "100ms")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "ease")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "linear")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "ease-in")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "ease-out")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "ease-in-out")|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "cubic-bezier(.5, .5, .5, .5)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "cubic-bezier(.5, 1.5, .5, -2.5)"),
|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "step-start")|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "step-end")|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "steps(3, start)"),
|]);
CssJs.style(. [|CssJs.unsafe("transitionTimingFunction", "steps(5, end)")|]);
CssJs.style(. [|CssJs.unsafe("transitionDelay", "1s")|]);
CssJs.style(. [|CssJs.unsafe("transitionDelay", "-1s")|]);
CssJs.style(. [|CssJs.unsafe("transition", "1s 2s width linear")|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "steps(2, jump-start)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "steps(2, jump-end)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "steps(1, jump-both)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("transitionTimingFunction", "steps(2, jump-none)"),
|]);
CssJs.style(. [|CssJs.unsafe("animationName", "foo")|]);
CssJs.style(. [|CssJs.unsafe("animationName", "foo, bar")|]);
CssJs.style(. [|CssJs.unsafe("animationDuration", "0s")|]);
CssJs.style(. [|CssJs.unsafe("animationDuration", "1s")|]);
CssJs.style(. [|CssJs.unsafe("animationDuration", "100ms")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "ease")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "linear")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "ease-in")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "ease-out")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "ease-in-out")|]);
CssJs.style(. [|
  CssJs.unsafe("animationTimingFunction", "cubic-bezier(.5, .5, .5, .5)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("animationTimingFunction", "cubic-bezier(.5, 1.5, .5, -2.5)"),
|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "step-start")|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "step-end")|]);
CssJs.style(. [|
  CssJs.unsafe("animationTimingFunction", "steps(3, start)"),
|]);
CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "steps(5, end)")|]);
CssJs.style(. [|CssJs.unsafe("animationIterationCount", "infinite")|]);
CssJs.style(. [|CssJs.unsafe("animationIterationCount", "8")|]);
CssJs.style(. [|CssJs.unsafe("animationIterationCount", "4.35")|]);
CssJs.style(. [|CssJs.unsafe("animationDirection", "normal")|]);
CssJs.style(. [|CssJs.unsafe("animationDirection", "alternate")|]);
CssJs.style(. [|CssJs.unsafe("animationDirection", "reverse")|]);
CssJs.style(. [|CssJs.unsafe("animationDirection", "alternate-reverse")|]);
CssJs.style(. [|CssJs.unsafe("animationPlayState", "running")|]);
CssJs.style(. [|CssJs.unsafe("animationPlayState", "paused")|]);
CssJs.style(. [|CssJs.unsafe("animationDelay", "1s")|]);
CssJs.style(. [|CssJs.unsafe("animationDelay", "-1s")|]);
CssJs.style(. [|CssJs.unsafe("animationFillMode", "none")|]);
CssJs.style(. [|CssJs.unsafe("animationFillMode", "forwards")|]);
CssJs.style(. [|CssJs.unsafe("animationFillMode", "backwards")|]);
CssJs.style(. [|CssJs.unsafe("animationFillMode", "both")|]);
CssJs.style(. [|
  CssJs.unsafe("animation", "foo 1s 2s infinite linear alternate both"),
|]);
CssJs.style(. [|CssJs.unsafe("transform", "none")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "10px")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "top")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "top left")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "50% 100%")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "left 0%")|]);
CssJs.style(. [|CssJs.unsafe("transformOrigin", "left 50% 0")|]);
CssJs.style(. [|CssJs.unsafe("transformBox", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("transformBox", "fill-box")|]);
CssJs.style(. [|CssJs.unsafe("transformBox", "view-box")|]);
CssJs.style(. [|CssJs.unsafe("translate", "none")|]);
CssJs.style(. [|CssJs.unsafe("translate", "50%")|]);
CssJs.style(. [|CssJs.unsafe("translate", "50% 50%")|]);
CssJs.style(. [|CssJs.unsafe("translate", "50% 50% 10px")|]);
CssJs.style(. [|CssJs.unsafe("scale", "none")|]);
CssJs.style(. [|CssJs.unsafe("scale", "2")|]);
CssJs.style(. [|CssJs.unsafe("scale", "2 2")|]);
CssJs.style(. [|CssJs.unsafe("scale", "2 2 2")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "none")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "45deg")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "x 45deg")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "y 45deg")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "z 45deg")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "-1 0 2 45deg")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "45deg x")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "45deg y")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "45deg z")|]);
CssJs.style(. [|CssJs.unsafe("rotate", "45deg -1 0 2")|]);
CssJs.style(. [|CssJs.unsafe("transformStyle", "flat")|]);
CssJs.style(. [|CssJs.unsafe("transformStyle", "preserve-3d")|]);
CssJs.style(. [|CssJs.unsafe("perspective", "none")|]);
CssJs.style(. [|CssJs.unsafe("perspective", "600px")|]);
CssJs.style(. [|CssJs.unsafe("perspectiveOrigin", "10px")|]);
CssJs.style(. [|CssJs.unsafe("perspectiveOrigin", "top")|]);
CssJs.style(. [|CssJs.unsafe("perspectiveOrigin", "top left")|]);
CssJs.style(. [|CssJs.unsafe("perspectiveOrigin", "50% 100%")|]);
CssJs.style(. [|CssJs.unsafe("perspectiveOrigin", "left 0%")|]);
CssJs.style(. [|CssJs.unsafe("backfaceVisibility", "visible")|]);
CssJs.style(. [|CssJs.unsafe("backfaceVisibility", "hidden")|]);
CssJs.style(. [|CssJs.unsafe("offset", "none")|]);
CssJs.style(. [|CssJs.unsafe("offset", "auto")|]);
CssJs.style(. [|CssJs.unsafe("offset", "center")|]);
CssJs.style(. [|CssJs.unsafe("offset", "200px 100px")|]);
CssJs.style(. [|
  CssJs.unsafe("offset", "inset(10% round 10% 40% 10% 40%)"),
|]);
CssJs.style(. [|CssJs.unsafe("offset", "ellipse(at top 50% left 20%)")|]);
CssJs.style(. [|CssJs.unsafe("offset", "margin-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "fill-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "stroke-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "view-box")|]);
CssJs.style(. [|CssJs.unsafe("offset", "path('M 20 20 H 80 V 30')")|]);
CssJs.style(. [|CssJs.unsafe("offset", "url(image.png)")|]);
CssJs.style(. [|CssJs.unsafe("textTransform", "full-width")|]);
CssJs.style(. [|CssJs.unsafe("textTransform", "full-size-kana")|]);
CssJs.style(. [|CssJs.unsafe("tabSize", "4")|]);
CssJs.style(. [|CssJs.unsafe("tabSize", "1em")|]);
CssJs.style(. [|CssJs.unsafe("lineBreak", "auto")|]);
CssJs.style(. [|CssJs.unsafe("lineBreak", "loose")|]);
CssJs.style(. [|CssJs.unsafe("lineBreak", "normal")|]);
CssJs.style(. [|CssJs.unsafe("lineBreak", "strict")|]);
CssJs.style(. [|CssJs.unsafe("lineBreak", "anywhere")|]);
CssJs.style(. [|CssJs.wordBreak(`normal)|]);
CssJs.style(. [|CssJs.wordBreak(`keepAll)|]);
CssJs.style(. [|CssJs.wordBreak(`breakAll)|]);
CssJs.style(. [|CssJs.whiteSpace(`breakSpaces)|]);
CssJs.style(. [|CssJs.unsafe("hyphens", "auto")|]);
CssJs.style(. [|CssJs.unsafe("hyphens", "manual")|]);
CssJs.style(. [|CssJs.unsafe("hyphens", "none")|]);
CssJs.style(. [|CssJs.overflowWrap(`normal)|]);
CssJs.style(. [|CssJs.unsafe("overflowWrap", "break-word")|]);
CssJs.style(. [|CssJs.overflowWrap(`anywhere)|]);
CssJs.style(. [|CssJs.wordWrap(`normal)|]);
CssJs.style(. [|CssJs.unsafe("wordWrap", "break-word")|]);
CssJs.style(. [|CssJs.textAlign(`start)|]);
CssJs.style(. [|CssJs.unsafe("textAlign", "end")|]);
CssJs.style(. [|CssJs.textAlign(`left)|]);
CssJs.style(. [|CssJs.textAlign(`right)|]);
CssJs.style(. [|CssJs.textAlign(`center)|]);
CssJs.style(. [|CssJs.textAlign(`justify)|]);
CssJs.style(. [|CssJs.unsafe("textAlign", "match-parent")|]);
CssJs.style(. [|CssJs.unsafe("textJustify", "auto")|]);
CssJs.style(. [|CssJs.unsafe("textJustify", "none")|]);
CssJs.style(. [|CssJs.unsafe("textJustify", "inter-word")|]);
CssJs.style(. [|CssJs.unsafe("textJustify", "inter-character")|]);
CssJs.style(. [|CssJs.wordSpacing(`percent(50.))|]);
CssJs.style(. [|CssJs.unsafe("textIndent", "1em hanging")|]);
CssJs.style(. [|CssJs.unsafe("textIndent", "1em each-line")|]);
CssJs.style(. [|CssJs.unsafe("textIndent", "1em hanging each-line")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "none")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "first")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "last")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "force-end")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "allow-end")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "first last")|]);
CssJs.style(. [|CssJs.unsafe("hangingPunctuation", "first force-end")|]);
CssJs.style(. [|
  CssJs.unsafe("hangingPunctuation", "first force-end last"),
|]);
CssJs.style(. [|
  CssJs.unsafe("hangingPunctuation", "first allow-end last"),
|]);
CssJs.style(. [|CssJs.unsafe("textDecoration", "underline dotted green")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationLine", "none")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationLine", "underline")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationLine", "overline")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationLine", "line-through")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationLine", "underline overline")|]);
CssJs.style(. [|CssJs.textDecorationColor(CssJs.white)|]);
CssJs.style(. [|CssJs.unsafe("textDecorationStyle", "solid")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationStyle", "double")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationStyle", "dashed")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationStyle", "wavy")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "auto")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "under")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "left")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "right")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "under left")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlinePosition", "under right")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "none")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "filled")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "open")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "dot")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "circle")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "double-circle")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "triangle")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "sesame")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "open dot")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisStyle", "'foo'")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisColor", "green")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasis", "open dot green")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisPosition", "over left")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisPosition", "over right")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisPosition", "under left")|]);
CssJs.style(. [|CssJs.unsafe("textEmphasisPosition", "under right")|]);
CssJs.style(. [|CssJs.unsafe("textShadow", "none")|]);
CssJs.style(. [|CssJs.unsafe("textShadow", "1px 1px")|]);
CssJs.style(. [|CssJs.unsafe("textShadow", "0 0 black")|]);
CssJs.style(. [|CssJs.unsafe("textShadow", "1px 2px 3px black")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecoration", "underline solid blue 1px"),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "none")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "objects")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "objects spaces")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "objects leading-spaces"),
|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "objects trailing-spaces"),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "textDecorationSkip",
    "objects leading-spaces trailing-spaces",
  ),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "textDecorationSkip",
    "objects leading-spaces trailing-spaces edges",
  ),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "textDecorationSkip",
    "objects leading-spaces trailing-spaces edges box-decoration",
  ),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "objects edges")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "objects box-decoration"),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "spaces")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "spaces edges")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "spaces edges box-decoration"),
|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "spaces box-decoration"),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "leading-spaces")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "leading-spaces trailing-spaces edges"),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "textDecorationSkip",
    "leading-spaces trailing-spaces edges box-decoration",
  ),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "edges")|]);
CssJs.style(. [|
  CssJs.unsafe("textDecorationSkip", "edges box-decoration"),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkip", "box-decoration")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkipInk", "none")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationSkipInk", "auto")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlineOffset", "auto")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlineOffset", "3px")|]);
CssJs.style(. [|CssJs.unsafe("textUnderlineOffset", "10%")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationThickness", "auto")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationThickness", "from-font")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationThickness", "3px")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationThickness", "10%")|]);
CssJs.style(. [|CssJs.unsafe("quotes", "auto")|]);
CssJs.style(. [|CssJs.unsafe("content", "url(./img/star.png) / \"New!\"")|]);
CssJs.style(. [|CssJs.unsafe("content", "\"\\25BA\" / \"\"")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "ultra-condensed")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "extra-condensed")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "condensed")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "semi-condensed")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "semi-expanded")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "expanded")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "extra-expanded")|]);
CssJs.style(. [|CssJs.unsafe("fontStretch", "ultra-expanded")|]);
CssJs.style(. [|CssJs.unsafe("fontSizeAdjust", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontSizeAdjust", ".5")|]);
CssJs.style(. [|CssJs.unsafe("fontSynthesis", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontSynthesis", "weight")|]);
CssJs.style(. [|CssJs.unsafe("fontSynthesis", "style")|]);
CssJs.style(. [|CssJs.unsafe("fontSynthesis", "weight style")|]);
CssJs.style(. [|CssJs.unsafe("fontSynthesis", "style weight")|]);
CssJs.style(. [|CssJs.unsafe("fontKerning", "auto")|]);
CssJs.style(. [|CssJs.unsafe("fontKerning", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontKerning", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantPosition", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantPosition", "sub")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantPosition", "super")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantLigatures", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantLigatures", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantLigatures", "common-ligatures")|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantLigatures", "no-common-ligatures"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantLigatures", "discretionary-ligatures"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantLigatures", "no-discretionary-ligatures"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantLigatures", "historical-ligatures"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantLigatures", "no-historical-ligatures"),
|]);
CssJs.style(. [|CssJs.unsafe("fontVariantLigatures", "contextual")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantLigatures", "no-contextual")|]);
CssJs.style(. [|
  CssJs.unsafe(
    "fontVariantLigatures",
    "common-ligatures discretionary-ligatures historical-ligatures contextual",
  ),
|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "small-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "all-small-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "petite-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "all-petite-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "titling-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantCaps", "unicase")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "lining-nums")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "oldstyle-nums")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "proportional-nums")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "tabular-nums")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "diagonal-fractions")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "stacked-fractions")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "ordinal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantNumeric", "slashed-zero")|]);
CssJs.style(. [|
  CssJs.unsafe(
    "fontVariantNumeric",
    "lining-nums proportional-nums diagonal-fractions",
  ),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "fontVariantNumeric",
    "oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero",
  ),
|]);
CssJs.style(. [|
  CssJs.unsafe(
    "fontVariantNumeric",
    "slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums",
  ),
|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "jis78")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "jis83")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "jis90")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "jis04")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "simplified")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "traditional")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "full-width")|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantEastAsian", "proportional-width"),
|]);
CssJs.style(. [|CssJs.unsafe("fontVariantEastAsian", "ruby")|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantEastAsian", "simplified full-width ruby"),
|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "'c2sc'")|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "'smcp' on")|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "'liga' off")|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "'smcp', 'swsh' 2")|]);
CssJs.style(. [|CssJs.unsafe("fontSize", "xxx-large")|]);
CssJs.style(. [|CssJs.unsafe("fontVariant", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontVariant", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariant", "all-petite-caps")|]);
CssJs.style(. [|CssJs.unsafe("fontVariant", "historical-forms")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantAlternates", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantAlternates", "historical-forms")|]);
CssJs.style(. [|CssJs.unsafe("fontVariantAlternates", "styleset(ss01)")|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantAlternates", "styleset(stacked-g, geometric-m)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantAlternates", "character-variant(cv02)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantAlternates", "character-variant(beta-3, gamma)"),
|]);
CssJs.style(. [|CssJs.unsafe("fontVariantAlternates", "swash(flowing)")|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantAlternates", "ornaments(leaves)"),
|]);
CssJs.style(. [|
  CssJs.unsafe("fontVariantAlternates", "annotation(blocky)"),
|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontFeatureSettings", "'swsh' 2")|]);
CssJs.style(. [|CssJs.unsafe("fontLanguageOverride", "normal")|]);
CssJs.style(. [|CssJs.unsafe("fontLanguageOverride", "'SRB'")|]);
CssJs.style(. [|CssJs.unsafe("fontWeight", "1")|]);
CssJs.style(. [|CssJs.unsafe("fontWeight", "90")|]);
CssJs.style(. [|CssJs.unsafe("fontWeight", "750")|]);
CssJs.style(. [|CssJs.unsafe("fontWeight", "1000")|]);
CssJs.style(. [|CssJs.unsafe("fontStyle", "oblique 15deg")|]);
CssJs.style(. [|CssJs.unsafe("fontStyle", "oblique -15deg")|]);
CssJs.style(. [|CssJs.unsafe("fontStyle", "oblique 0deg")|]);
CssJs.style(. [|CssJs.unsafe("fontOpticalSizing", "none")|]);
CssJs.style(. [|CssJs.unsafe("fontOpticalSizing", "auto")|]);
CssJs.style(. [|CssJs.unsafe("direction", "ltr")|]);
CssJs.style(. [|CssJs.unsafe("direction", "rtl")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "normal")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "embed")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "isolate")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "bidi-override")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "isolate-override")|]);
CssJs.style(. [|CssJs.unsafe("unicodeBidi", "plaintext")|]);
CssJs.style(. [|CssJs.unsafe("writingMode", "horizontal-tb")|]);
CssJs.style(. [|CssJs.unsafe("writingMode", "vertical-rl")|]);
CssJs.style(. [|CssJs.unsafe("writingMode", "vertical-lr")|]);
CssJs.style(. [|CssJs.unsafe("textOrientation", "mixed")|]);
CssJs.style(. [|CssJs.unsafe("textOrientation", "upright")|]);
CssJs.style(. [|CssJs.unsafe("textOrientation", "sideways")|]);
CssJs.style(. [|CssJs.unsafe("textCombineUpright", "none")|]);
CssJs.style(. [|CssJs.unsafe("textCombineUpright", "all")|]);
CssJs.style(. [|CssJs.unsafe("writingMode", "sideways-rl")|]);
CssJs.style(. [|CssJs.unsafe("writingMode", "sideways-lr")|]);
CssJs.style(. [|CssJs.unsafe("textCombineUpright", "digits 2")|]);
CssJs.style(. [|CssJs.color(`rgba((0, 0, 0, `num(0.5))))|]);
CssJs.style(. [|CssJs.color(`hex("F06"))|]);
CssJs.style(. [|CssJs.color(`hex("FF0066"))|]);
CssJs.style(. [|CssJs.unsafe("color", "hsl(0,0%,0%)")|]);
CssJs.style(. [|CssJs.unsafe("color", "hsl(0,0%,0%,.5)")|]);
CssJs.style(. [|CssJs.color(`transparent)|]);
CssJs.style(. [|CssJs.color(`currentColor)|]);
CssJs.style(. [|CssJs.backgroundColor(`rgba((0, 0, 0, `num(0.5))))|]);
CssJs.style(. [|CssJs.backgroundColor(`hex("F06"))|]);
CssJs.style(. [|CssJs.backgroundColor(`hex("FF0066"))|]);
CssJs.style(. [|CssJs.unsafe("backgroundColor", "hsl(0,0%,0%)")|]);
CssJs.style(. [|CssJs.unsafe("backgroundColor", "hsl(0,0%,0%,.5)")|]);
CssJs.style(. [|CssJs.backgroundColor(`transparent)|]);
CssJs.style(. [|CssJs.backgroundColor(`currentColor)|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 0, 0, `num(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`hex("F06"))|]);
CssJs.style(. [|CssJs.borderColor(`hex("FF0066"))|]);
CssJs.style(. [|CssJs.unsafe("borderColor", "hsl(0,0%,0%)")|]);
CssJs.style(. [|CssJs.unsafe("borderColor", "hsl(0,0%,0%,.5)")|]);
CssJs.style(. [|CssJs.borderColor(`transparent)|]);
CssJs.style(. [|CssJs.borderColor(`currentColor)|]);
CssJs.style(. [|CssJs.textDecorationColor(`rgba((0, 0, 0, `num(0.5))))|]);
CssJs.style(. [|CssJs.textDecorationColor(`hex("F06"))|]);
CssJs.style(. [|CssJs.textDecorationColor(`hex("FF0066"))|]);
CssJs.style(. [|CssJs.unsafe("textDecorationColor", "hsl(0,0%,0%)")|]);
CssJs.style(. [|CssJs.unsafe("textDecorationColor", "hsl(0,0%,0%,.5)")|]);
CssJs.style(. [|CssJs.textDecorationColor(`transparent)|]);
CssJs.style(. [|CssJs.textDecorationColor(`currentColor)|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgba(0,0,0,.5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "#F06")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "#FF0066")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "hsl(0,0%,0%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "hsl(0,0%,0%,.5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "transparent")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "currentColor")|]);
CssJs.style(. [|CssJs.color(`rgb((0, 51, 178)))|]);
CssJs.style(. [|CssJs.color(`rgb((0, 64, 185)))|]);
CssJs.style(. [|
  CssJs.color(`hsl((`deg(0.), `percent(0.), `percent(0.)))),
|]);
CssJs.style(. [|CssJs.color(`rgba((0, 51, 178, `percent(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 64, 185, `percent(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|CssJs.unsafe("color", "hsla(0 0% 0% /.5)")|]);
CssJs.style(. [|CssJs.color(`rgba((0, 51, 178, `percent(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 64, 185, `percent(0.5))))|]);
CssJs.style(. [|CssJs.color(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|
  CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5)))),
|]);
CssJs.style(. [|CssJs.color(`hex("000F"))|]);
CssJs.style(. [|CssJs.color(`hex("000000FF"))|]);
CssJs.style(. [|CssJs.color(CssJs.rebeccapurple)|]);
CssJs.style(. [|CssJs.backgroundColor(`rgb((0, 51, 178)))|]);
CssJs.style(. [|CssJs.backgroundColor(`rgb((0, 64, 185)))|]);
CssJs.style(. [|
  CssJs.backgroundColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))),
|]);
CssJs.style(. [|
  CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5)))),
|]);
CssJs.style(. [|CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|
  CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5)))),
|]);
CssJs.style(. [|CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|CssJs.unsafe("backgroundColor", "hsla(0 0% 0% /.5)")|]);
CssJs.style(. [|
  CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5)))),
|]);
CssJs.style(. [|CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|
  CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5)))),
|]);
CssJs.style(. [|CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|
  CssJs.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ),
|]);
CssJs.style(. [|CssJs.backgroundColor(`hex("000F"))|]);
CssJs.style(. [|CssJs.backgroundColor(`hex("000000FF"))|]);
CssJs.style(. [|CssJs.backgroundColor(CssJs.rebeccapurple)|]);
CssJs.style(. [|CssJs.borderColor(`rgb((0, 51, 178)))|]);
CssJs.style(. [|CssJs.borderColor(`rgb((0, 64, 185)))|]);
CssJs.style(. [|
  CssJs.borderColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))),
|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|CssJs.unsafe("borderColor", "hsla(0 0% 0% /.5)")|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))))|]);
CssJs.style(. [|CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))))|]);
CssJs.style(. [|
  CssJs.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ),
|]);
CssJs.style(. [|CssJs.borderColor(`hex("000F"))|]);
CssJs.style(. [|CssJs.borderColor(`hex("000000FF"))|]);
CssJs.style(. [|CssJs.borderColor(CssJs.rebeccapurple)|]);
CssJs.style(. [|CssJs.textDecorationColor(`rgb((0, 51, 178)))|]);
CssJs.style(. [|CssJs.textDecorationColor(`rgb((0, 64, 185)))|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`hsl((`deg(0.), `percent(0.), `percent(0.)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5)))),
|]);
CssJs.style(. [|CssJs.unsafe("textDecorationColor", "hsla(0 0% 0% /.5)")|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5)))),
|]);
CssJs.style(. [|
  CssJs.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  ),
|]);
CssJs.style(. [|CssJs.textDecorationColor(`hex("000F"))|]);
CssJs.style(. [|CssJs.textDecorationColor(`hex("000000FF"))|]);
CssJs.style(. [|CssJs.textDecorationColor(CssJs.rebeccapurple)|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0% 20% 70%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0 64 185)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "hsl(0 0% 0%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgba(0% 20% 70% / 50%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgba(0% 20% 70% / .5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgba(0 64 185 / 50%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgba(0 64 185 / .5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "hsla(0 0% 0% /.5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0% 20% 70% / 50%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0% 20% 70% / .5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0 64 185 / 50%)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rgb(0 64 185 / .5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "hsl(0 0% 0% / .5)")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "#000F")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "#000000FF")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "rebeccapurple")|]);
CssJs.style(. [|CssJs.unsafe("columnWidth", "10em")|]);
CssJs.style(. [|CssJs.unsafe("columnWidth", "auto")|]);
CssJs.style(. [|CssJs.unsafe("columnCount", "2")|]);
CssJs.style(. [|CssJs.unsafe("columnCount", "auto")|]);
CssJs.style(. [|CssJs.unsafe("columns", "100px")|]);
CssJs.style(. [|CssJs.unsafe("columns", "3")|]);
CssJs.style(. [|CssJs.unsafe("columns", "10em 2")|]);
CssJs.style(. [|CssJs.unsafe("columns", "auto auto")|]);
CssJs.style(. [|CssJs.unsafe("columns", "2 10em")|]);
CssJs.style(. [|CssJs.unsafe("columns", "auto 10em")|]);
CssJs.style(. [|CssJs.unsafe("columns", "2 auto")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleColor", "red")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleStyle", "none")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleStyle", "solid")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("columnRuleWidth", "1px")|]);
CssJs.style(. [|CssJs.unsafe("columnRule", "transparent")|]);
CssJs.style(. [|CssJs.unsafe("columnRule", "1px solid black")|]);
CssJs.style(. [|CssJs.unsafe("columnSpan", "none")|]);
CssJs.style(. [|CssJs.unsafe("columnSpan", "all")|]);
CssJs.style(. [|CssJs.unsafe("columnFill", "auto")|]);
CssJs.style(. [|CssJs.unsafe("columnFill", "balance")|]);
CssJs.style(. [|CssJs.unsafe("columnFill", "balance-all")|]);
CssJs.style(. [|CssJs.width(`rem(5.))|]);
CssJs.style(. [|CssJs.width(`ch(5.))|]);
CssJs.style(. [|CssJs.width(`vw(5.))|]);
CssJs.style(. [|CssJs.width(`vh(5.))|]);
CssJs.style(. [|CssJs.width(`vmin(5.))|]);
CssJs.style(. [|CssJs.width(`vmax(5.))|]);
CssJs.style(. [|CssJs.padding(`rem(5.))|]);
CssJs.style(. [|CssJs.padding(`ch(5.))|]);
CssJs.style(. [|CssJs.padding(`vw(5.))|]);
CssJs.style(. [|CssJs.padding(`vh(5.))|]);
CssJs.style(. [|CssJs.padding(`vmin(5.))|]);
CssJs.style(. [|CssJs.padding(`vmax(5.))|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "space-between")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "space-around")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "flex-end")|]);
CssJs.style(. [|CssJs.display(`flex)|]);
CssJs.style(. [|CssJs.display(`inlineFlex)|]);
CssJs.style(. [|CssJs.flex(`none)|]);
CssJs.style(. [|
  CssJs.flexGrow(5.),
  CssJs.flexShrink(7.),
  CssJs.flexBasis(`percent(10.)),
|]);
CssJs.style(. [|CssJs.flexBasis(`auto)|]);
CssJs.style(. [|CssJs.flexBasis(`content)|]);
CssJs.style(. [|CssJs.flexBasis(`pxFloat(1.))|]);
CssJs.style(. [|CssJs.flexDirection(`row)|]);
CssJs.style(. [|CssJs.flexDirection(`rowReverse)|]);
CssJs.style(. [|CssJs.flexDirection(`column)|]);
CssJs.style(. [|CssJs.flexDirection(`columnReverse)|]);
CssJs.style(. [|CssJs.flexDirection(`row)|]);
CssJs.style(. [|CssJs.flexDirection(`rowReverse)|]);
CssJs.style(. [|CssJs.flexDirection(`column)|]);
CssJs.style(. [|CssJs.flexDirection(`columnReverse)|]);
CssJs.style(. [|CssJs.flexWrap(`wrap)|]);
CssJs.style(. [|CssJs.flexWrap(`wrapReverse)|]);
CssJs.style(. [|CssJs.flexGrow(0.)|]);
CssJs.style(. [|CssJs.flexGrow(5.)|]);
CssJs.style(. [|CssJs.flexShrink(1.)|]);
CssJs.style(. [|CssJs.flexShrink(10.)|]);
CssJs.style(. [|CssJs.flexWrap(`nowrap)|]);
CssJs.style(. [|CssJs.flexWrap(`wrap)|]);
CssJs.style(. [|CssJs.flexWrap(`wrapReverse)|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "space-between")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "space-around")|]);
CssJs.style(. [|CssJs.minHeight(`auto)|]);
CssJs.style(. [|CssJs.minWidth(`auto)|]);
CssJs.style(. [|CssJs.order(0)|]);
CssJs.style(. [|CssJs.order(1)|]);
CssJs.style(. [|CssJs.display(`grid)|]);
CssJs.style(. [|CssJs.display(`inlineGrid)|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "auto")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "normal")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "center")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "start")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "end")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "self-start")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "self-end")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("alignSelf", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "normal")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "center")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "start")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "end")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "self-start")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "self-end")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("alignItems", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "normal")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "space-between")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "space-around")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "space-evenly")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "center")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "start")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "end")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("alignContent", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "auto")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "normal")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "center")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "start")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "end")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "self-start")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "self-end")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "left")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "right")|]);
CssJs.style(. [|CssJs.unsafe("justifySelf", "safe right")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "normal")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "center")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "start")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "end")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "self-start")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "self-end")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "left")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "right")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "safe right")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "legacy")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "legacy left")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "legacy right")|]);
CssJs.style(. [|CssJs.unsafe("justifyItems", "legacy center")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "normal")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "space-between")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "space-around")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "space-evenly")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "center")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "start")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "end")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "left")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "right")|]);
CssJs.style(. [|CssJs.unsafe("justifyContent", "safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-between")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-around")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-evenly")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "center")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "start")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "end")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "flex-start")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "flex-end")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "normal normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "baseline normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "first baseline normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-between normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "center normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "unsafe start normal")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "normal stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "baseline stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "first baseline stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-between stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "center stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "unsafe start stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "normal safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "baseline safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "first baseline safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "space-between safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "center safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeContent", "unsafe start safe right")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "first baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "center")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "start")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "end")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-start")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-end")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "unsafe start")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "safe start")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "normal normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "stretch normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "baseline normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "first baseline normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-start normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "unsafe start normal")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "normal stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "stretch stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "baseline stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "first baseline stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-start stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "unsafe start stretch")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "normal last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "stretch last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "baseline last baseline")|]);
CssJs.style(. [|
  CssJs.unsafe("placeItems", "first baseline last baseline"),
|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-start last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "unsafe start last baseline")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "normal legacy left")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "stretch legacy left")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "baseline legacy left")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "first baseline legacy left")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "self-start legacy left")|]);
CssJs.style(. [|CssJs.unsafe("placeItems", "unsafe start legacy left")|]);
CssJs.style(. [|CssJs.unsafe("gap", "0 0")|]);
CssJs.style(. [|CssJs.unsafe("gap", "0 1em")|]);
CssJs.style(. [|CssJs.unsafe("gap", "1em")|]);
CssJs.style(. [|CssJs.unsafe("gap", "1em 1em")|]);
CssJs.style(. [|CssJs.unsafe("columnGap", "0")|]);
CssJs.style(. [|CssJs.unsafe("columnGap", "1em")|]);
CssJs.style(. [|CssJs.unsafe("columnGap", "normal")|]);
CssJs.style(. [|CssJs.unsafe("rowGap", "0")|]);
CssJs.style(. [|CssJs.unsafe("rowGap", "1em")|]);
CssJs.style(. [|CssJs.unsafe("marginTrim", "none")|]);
CssJs.style(. [|CssJs.unsafe("marginTrim", "in-flow")|]);
CssJs.style(. [|CssJs.unsafe("marginTrim", "all")|]);
CssJs.style(. [|CssJs.unsafe("color", "unset")|]);
CssJs.style(. [|CssJs.unsafe("font-weight", "unset")|]);
CssJs.style(. [|CssJs.unsafe("background-image", "unset")|]);
CssJs.style(. [|CssJs.unsafe("width", "unset")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "url('#clip')")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "inset(50%)")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "circle()")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "ellipse()")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "margin-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "fill-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "stroke-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "view-box")|]);
CssJs.style(. [|CssJs.unsafe("clipPath", "none")|]);
CssJs.style(. [|CssJs.unsafe("clipRule", "nonzero")|]);
CssJs.style(. [|CssJs.unsafe("clipRule", "evenodd")|]);
CssJs.style(. [|CssJs.unsafe("maskImage", "none")|]);
CssJs.style(. [|CssJs.unsafe("maskImage", "url(image.png)")|]);
CssJs.style(. [|CssJs.unsafe("maskMode", "alpha")|]);
CssJs.style(. [|CssJs.unsafe("maskMode", "luminance")|]);
CssJs.style(. [|CssJs.unsafe("maskMode", "match-source")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat-x")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat-y")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "space")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "round")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "space repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "round repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "no-repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat space")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "space space")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "round space")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "no-repeat space")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat round")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "space round")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "round round")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "no-repeat round")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "repeat no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "space no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "round no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskRepeat", "no-repeat no-repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskPosition", "center")|]);
CssJs.style(. [|CssJs.unsafe("maskPosition", "left 50%")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "margin-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "fill-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "stroke-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "view-box")|]);
CssJs.style(. [|CssJs.unsafe("maskClip", "no-clip")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "border-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "padding-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "content-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "margin-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "fill-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "stroke-box")|]);
CssJs.style(. [|CssJs.unsafe("maskOrigin", "view-box")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "auto")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "10px")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "cover")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "contain")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "10px")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "50%")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "10px auto")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "auto 10%")|]);
CssJs.style(. [|CssJs.unsafe("maskSize", "50em 50%")|]);
CssJs.style(. [|CssJs.unsafe("maskComposite", "add")|]);
CssJs.style(. [|CssJs.unsafe("maskComposite", "subtract")|]);
CssJs.style(. [|CssJs.unsafe("maskComposite", "intersect")|]);
CssJs.style(. [|CssJs.unsafe("maskComposite", "exclude")|]);
CssJs.style(. [|CssJs.unsafe("mask", "top")|]);
CssJs.style(. [|CssJs.unsafe("mask", "space")|]);
CssJs.style(. [|CssJs.unsafe("mask", "url(image.png)")|]);
CssJs.style(. [|CssJs.unsafe("mask", "url(image.png) luminance")|]);
CssJs.style(. [|
  CssJs.unsafe("mask", "url(image.png) luminance top space"),
|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSource", "none")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "0 fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "50% fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "1.1 fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "0 1 fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "0 1 2 fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderSlice", "0 1 2 3 fill")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "auto")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "10px")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "50%")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "1")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "1.0")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "auto 1")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "auto 1 50%")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderWidth", "auto 1 50% 1.1")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderOutset", "0")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderOutset", "1.1")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderOutset", "0 1")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderOutset", "0 1 2")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderOutset", "0 1 2 3")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "stretch")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "round")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "space")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "stretch stretch")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "repeat stretch")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "round stretch")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "space stretch")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "stretch repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "repeat repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "round repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "space repeat")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "stretch round")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "repeat round")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "round round")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "space round")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "stretch space")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "repeat space")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "round space")|]);
CssJs.style(. [|CssJs.unsafe("maskBorderRepeat", "space space")|]);
CssJs.style(. [|CssJs.unsafe("maskType", "luminance")|]);
CssJs.style(. [|CssJs.unsafe("maskType", "alpha")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "normal")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "multiply")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "screen")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "overlay")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "darken")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "lighten")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "color-dodge")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "color-burn")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "hard-light")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "soft-light")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "difference")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "exclusion")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "hue")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "saturation")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "color")|]);
CssJs.style(. [|CssJs.unsafe("mixBlendMode", "luminosity")|]);
CssJs.style(. [|CssJs.unsafe("isolation", "auto")|]);
CssJs.style(. [|CssJs.unsafe("isolation", "isolate")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "normal")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "multiply")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "screen")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "overlay")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "darken")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "lighten")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "color-dodge")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "color-burn")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "hard-light")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "soft-light")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "difference")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "exclusion")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "hue")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "saturation")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "color")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "luminosity")|]);
CssJs.style(. [|CssJs.unsafe("backgroundBlendMode", "normal, multiply")|]);
CssJs.style(. [|CssJs.unsafe("display", "run-in")|]);
CssJs.style(. [|CssJs.unsafe("display", "flow")|]);
CssJs.style(. [|CssJs.unsafe("display", "flow-root")|]);
CssJs.style(. [|CssJs.unsafe("filter", "none")|]);
CssJs.style(. [|CssJs.unsafe("filter", "url(#id)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "url(image.svg#id)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "blur(5px)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "brightness(0.5)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "contrast(150%)")|]);
CssJs.style(. [|
  CssJs.unsafe("filter", "drop-shadow(15px 15px 15px black)"),
|]);
CssJs.style(. [|CssJs.unsafe("filter", "grayscale(50%)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "hue-rotate(50deg)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "invert(50%)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "opacity(50%)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "sepia(50%)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "saturate(150%)")|]);
CssJs.style(. [|CssJs.unsafe("filter", "grayscale(100%) sepia(100%)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "none")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "url(#id)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "url(image.svg#id)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "blur(5px)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "brightness(0.5)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "contrast(150%)")|]);
CssJs.style(. [|
  CssJs.unsafe("backdropFilter", "drop-shadow(15px 15px 15px black)"),
|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "grayscale(50%)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "hue-rotate(50deg)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "invert(50%)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "opacity(50%)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "sepia(50%)")|]);
CssJs.style(. [|CssJs.unsafe("backdropFilter", "saturate(150%)")|]);
CssJs.style(. [|
  CssJs.unsafe("backdropFilter", "grayscale(100%) sepia(100%)"),
|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "auto")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "none")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-x")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-y")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-x pan-y")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "manipulation")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-left")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-right")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-up")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-down")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-left pan-up")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pinch-zoom")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-x pinch-zoom")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-y pinch-zoom")|]);
CssJs.style(. [|CssJs.unsafe("touchAction", "pan-x pan-y pinch-zoom")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "auto")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "avoid")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "avoid-page")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "page")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "left")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "right")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "recto")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "verso")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "avoid-column")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "column")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "avoid-region")|]);
CssJs.style(. [|CssJs.unsafe("breakBefore", "region")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "auto")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "avoid")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "avoid-page")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "page")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "left")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "right")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "recto")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "verso")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "avoid-column")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "column")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "avoid-region")|]);
CssJs.style(. [|CssJs.unsafe("breakAfter", "region")|]);
CssJs.style(. [|CssJs.unsafe("breakInside", "auto")|]);
CssJs.style(. [|CssJs.unsafe("breakInside", "avoid")|]);
CssJs.style(. [|CssJs.unsafe("breakInside", "avoid-page")|]);
CssJs.style(. [|CssJs.unsafe("breakInside", "avoid-column")|]);
CssJs.style(. [|CssJs.unsafe("breakInside", "avoid-region")|]);
CssJs.style(. [|CssJs.unsafe("boxDecorationBreak", "slice")|]);
CssJs.style(. [|CssJs.unsafe("boxDecorationBreak", "clone")|]);
CssJs.style(. [|CssJs.unsafe("orphans", "1")|]);
CssJs.style(. [|CssJs.unsafe("orphans", "2")|]);
CssJs.style(. [|CssJs.unsafe("widows", "1")|]);
CssJs.style(. [|CssJs.unsafe("widows", "2")|]);
CssJs.style(. [|CssJs.unsafe("position", "sticky")|]);
CssJs.style(. [|CssJs.unsafe("willChange", "scroll-position")|]);
CssJs.style(. [|CssJs.unsafe("willChange", "contents")|]);
CssJs.style(. [|CssJs.unsafe("willChange", "transform")|]);
CssJs.style(. [|CssJs.unsafe("willChange", "top, left")|]);
CssJs.style(. [|CssJs.unsafe("scrollBehavior", "auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollBehavior", "smooth")|]);
CssJs.style(. [|CssJs.unsafe("display", "ruby")|]);
CssJs.style(. [|CssJs.unsafe("display", "ruby-base")|]);
CssJs.style(. [|CssJs.unsafe("display", "ruby-text")|]);
CssJs.style(. [|CssJs.unsafe("display", "ruby-base-container")|]);
CssJs.style(. [|CssJs.unsafe("display", "ruby-text-container")|]);
CssJs.style(. [|CssJs.unsafe("scrollMargin", "0px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMargin", "6px 5px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMargin", "10px 20px 30px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMargin", "10px 20px 30px 40px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMargin", "20px 3em 1in 5rem")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginBlock", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginBlock", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginBlockEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginBlockStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginBottom", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginInline", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginInline", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginInlineStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginInlineEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginLeft", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginRight", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollMarginTop", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "0px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "6px 5px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "10px 20px 30px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "10px 20px 30px 40px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "10px auto 30px auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "10%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPadding", "20% 3em 1in 5rem")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlock", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlock", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlock", "10px 50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlock", "50% 50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlockEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlockEnd", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlockStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBlockStart", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBottom", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingBottom", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInline", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInline", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInline", "10px 50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInline", "50% 50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInlineEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInlineEnd", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInlineStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingInlineStart", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingLeft", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingLeft", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingRight", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingRight", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingTop", "10px")|]);
CssJs.style(. [|CssJs.unsafe("scrollPaddingTop", "50%")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "none")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "start")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "end")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "center")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "none start")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "end center")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "center start")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "end none")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapAlign", "center center")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapStop", "normal")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapStop", "always")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "none")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "x mandatory")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "y mandatory")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "block mandatory")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "inline mandatory")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "both mandatory")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "x proximity")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "y proximity")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "block proximity")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "inline proximity")|]);
CssJs.style(. [|CssJs.unsafe("scrollSnapType", "both proximity")|]);
CssJs.style(. [|CssJs.unsafe("overflowAnchor", "none")|]);
CssJs.style(. [|CssJs.unsafe("overflowAnchor", "auto")|]);
CssJs.style(. [|CssJs.unsafe("captionSide", "inline-start")|]);
CssJs.style(. [|CssJs.unsafe("captionSide", "inline-end")|]);
CssJs.style(. [|CssJs.unsafe("float", "inline-start")|]);
CssJs.style(. [|CssJs.unsafe("float", "inline-end")|]);
CssJs.style(. [|CssJs.unsafe("clear", "inline-start")|]);
CssJs.style(. [|CssJs.unsafe("clear", "inline-end")|]);
CssJs.style(. [|CssJs.textAlign(`start)|]);
CssJs.style(. [|CssJs.unsafe("textAlign", "end")|]);
CssJs.style(. [|CssJs.unsafe("resize", "block")|]);
CssJs.style(. [|CssJs.unsafe("resize", "inline")|]);
CssJs.style(. [|CssJs.unsafe("blockSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("inlineSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("minBlockSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("minInlineSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("maxBlockSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("maxInlineSize", "100px")|]);
CssJs.style(. [|CssJs.unsafe("marginBlock", "10px")|]);
CssJs.style(. [|CssJs.unsafe("marginBlock", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("marginBlockStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("marginBlockEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("marginInline", "10px")|]);
CssJs.style(. [|CssJs.unsafe("marginInline", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("marginInlineStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("marginInlineEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("inset", "10px")|]);
CssJs.style(. [|CssJs.unsafe("inset", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("inset", "10px 10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("inset", "10px 10px 10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("insetBlock", "10px")|]);
CssJs.style(. [|CssJs.unsafe("insetBlock", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("insetBlockStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("insetBlockEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("insetInline", "10px")|]);
CssJs.style(. [|CssJs.unsafe("insetInline", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("insetInlineStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("insetInlineEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingBlock", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingBlock", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingBlockStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingBlockEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingInline", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingInline", "10px 10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingInlineStart", "10px")|]);
CssJs.style(. [|CssJs.unsafe("paddingInlineEnd", "10px")|]);
CssJs.style(. [|CssJs.unsafe("borderBlock", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderBlock", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderBlock", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStart", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStart", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStart", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStartWidth", "thin")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStartStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockStartColor", "navy")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEnd", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEnd", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEnd", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEndWidth", "thin")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEndStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockEndColor", "navy")|]);
CssJs.style(. [|CssJs.unsafe("borderBlockColor", "navy blue")|]);
CssJs.style(. [|CssJs.unsafe("borderInline", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderInline", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderInline", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStart", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStart", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStart", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStartWidth", "thin")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStartStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineStartColor", "navy")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEnd", "1px")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEnd", "2px dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEnd", "medium dashed green")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEndWidth", "thin")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEndStyle", "dotted")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineEndColor", "navy")|]);
CssJs.style(. [|CssJs.unsafe("borderInlineColor", "navy blue")|]);
CssJs.style(. [|CssJs.unsafe("borderStartStartRadius", "0")|]);
CssJs.style(. [|CssJs.unsafe("borderStartStartRadius", "50%")|]);
CssJs.style(. [|CssJs.unsafe("borderStartStartRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.unsafe("borderStartEndRadius", "0")|]);
CssJs.style(. [|CssJs.unsafe("borderStartEndRadius", "50%")|]);
CssJs.style(. [|CssJs.unsafe("borderStartEndRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.unsafe("borderEndStartRadius", "0")|]);
CssJs.style(. [|CssJs.unsafe("borderEndStartRadius", "50%")|]);
CssJs.style(. [|CssJs.unsafe("borderEndStartRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.unsafe("borderEndEndRadius", "0")|]);
CssJs.style(. [|CssJs.unsafe("borderEndEndRadius", "50%")|]);
CssJs.style(. [|CssJs.unsafe("borderEndEndRadius", "250px 100px")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "disclosure-closed")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "disclosure-open")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "hebrew")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "cjk-decimal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "cjk-ideographic")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "hiragana")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "katakana")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "hiragana-iroha")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "katakana-iroha")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "japanese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "japanese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "korean-hangul-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "korean-hanja-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "korean-hanja-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "simp-chinese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "simp-chinese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "trad-chinese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "trad-chinese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "cjk-heavenly-stem")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "cjk-earthly-branch")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "trad-chinese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "trad-chinese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "simp-chinese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "simp-chinese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "japanese-informal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "japanese-formal")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "arabic-indic")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "persian")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "urdu")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "devanagari")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "gurmukhi")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "gujarati")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "oriya")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "kannada")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "malayalam")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "bengali")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "tamil")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "telugu")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "thai")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "lao")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "myanmar")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "khmer")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "hangul")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "hangul-consonant")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "ethiopic-halehame")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "ethiopic-numeric")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "ethiopic-halehame-am")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "ethiopic-halehame-ti-er")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "ethiopic-halehame-ti-et")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "other-style")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "inside")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "outside")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "\\32 style")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "\"-\"")|]);
CssJs.style(. [|CssJs.unsafe("listStyleType", "'-'")|]);
CssJs.style(. [|CssJs.unsafe("counterReset", "foo")|]);
CssJs.style(. [|CssJs.unsafe("counterReset", "foo 1")|]);
CssJs.style(. [|CssJs.unsafe("counterReset", "foo 1 bar")|]);
CssJs.style(. [|CssJs.unsafe("counterReset", "foo 1 bar 2")|]);
CssJs.style(. [|CssJs.unsafe("counterReset", "none")|]);
CssJs.style(. [|CssJs.unsafe("counterSet", "foo")|]);
CssJs.style(. [|CssJs.unsafe("counterSet", "foo 1")|]);
CssJs.style(. [|CssJs.unsafe("counterSet", "foo 1 bar")|]);
CssJs.style(. [|CssJs.unsafe("counterSet", "foo 1 bar 2")|]);
CssJs.style(. [|CssJs.unsafe("counterSet", "none")|]);
CssJs.style(. [|CssJs.unsafe("counterIncrement", "foo")|]);
CssJs.style(. [|CssJs.unsafe("counterIncrement", "foo 1")|]);
CssJs.style(. [|CssJs.unsafe("counterIncrement", "foo 1 bar")|]);
CssJs.style(. [|CssJs.unsafe("counterIncrement", "foo 1 bar 2")|]);
CssJs.style(. [|CssJs.unsafe("counterIncrement", "none")|]);
CssJs.style(. [|CssJs.unsafe("lineClamp", "none")|]);
CssJs.style(. [|CssJs.unsafe("lineClamp", "1")|]);
CssJs.style(. [|CssJs.unsafe("maxLines", "none")|]);
CssJs.style(. [|CssJs.unsafe("maxLines", "1")|]);
CssJs.style(. [|CssJs.overflowX(`visible)|]);
CssJs.style(. [|CssJs.overflowX(`hidden)|]);
CssJs.style(. [|CssJs.unsafe("overflowX", "clip")|]);
CssJs.style(. [|CssJs.overflowX(`scroll)|]);
CssJs.style(. [|CssJs.overflowX(`auto)|]);
CssJs.style(. [|CssJs.overflowY(`visible)|]);
CssJs.style(. [|CssJs.overflowY(`hidden)|]);
CssJs.style(. [|CssJs.overflowY(`clip)|]);
CssJs.style(. [|CssJs.overflowY(`scroll)|]);
CssJs.style(. [|CssJs.overflowY(`auto)|]);
CssJs.style(. [|CssJs.unsafe("overflowInline", "visible")|]);
CssJs.style(. [|CssJs.unsafe("overflowInline", "hidden")|]);
CssJs.style(. [|CssJs.unsafe("overflowInline", "clip")|]);
CssJs.style(. [|CssJs.unsafe("overflowInline", "scroll")|]);
CssJs.style(. [|CssJs.unsafe("overflowInline", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overflowBlock", "visible")|]);
CssJs.style(. [|CssJs.unsafe("overflowBlock", "hidden")|]);
CssJs.style(. [|CssJs.unsafe("overflowBlock", "clip")|]);
CssJs.style(. [|CssJs.unsafe("overflowBlock", "scroll")|]);
CssJs.style(. [|CssJs.unsafe("overflowBlock", "auto")|]);
CssJs.style(. [|CssJs.unsafe("contain", "none")|]);
CssJs.style(. [|CssJs.unsafe("contain", "strict")|]);
CssJs.style(. [|CssJs.unsafe("contain", "content")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size")|]);
CssJs.style(. [|CssJs.unsafe("contain", "layout")|]);
CssJs.style(. [|CssJs.unsafe("contain", "paint")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size layout")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size paint")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size layout paint")|]);
CssJs.style(. [|CssJs.unsafe("contain", "style")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size style")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size layout style")|]);
CssJs.style(. [|CssJs.unsafe("contain", "size layout style paint")|]);
CssJs.style(. [|CssJs.unsafe("width", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("width", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("width", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("minWidth", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("minWidth", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("minWidth", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("maxWidth", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("maxWidth", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("maxWidth", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("height", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("height", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("height", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("minHeight", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("minHeight", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("minHeight", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("maxHeight", "max-content")|]);
CssJs.style(. [|CssJs.unsafe("maxHeight", "min-content")|]);
CssJs.style(. [|CssJs.unsafe("maxHeight", "fit-content(10%)")|]);
CssJs.style(. [|CssJs.unsafe("aspectRatio", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "contain contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "none contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "auto contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "contain none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "none none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "auto none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "contain auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "none auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehavior", "auto auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorX", "contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorX", "none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorX", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorY", "contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorY", "none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorY", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorInline", "contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorInline", "none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorInline", "auto")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorBlock", "contain")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorBlock", "none")|]);
CssJs.style(. [|CssJs.unsafe("overscrollBehaviorBlock", "auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarColor", "auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarColor", "dark")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarColor", "light")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarColor", "red blue")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarWidth", "auto")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarWidth", "thin")|]);
CssJs.style(. [|CssJs.unsafe("scrollbarWidth", "none")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "auto")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "visiblePainted")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "visibleFill")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "visibleStroke")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "visible")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "painted")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "fill")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "stroke")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "all")|]);
CssJs.style(. [|CssJs.unsafe("pointerEvents", "none")|]);
CssJs.style(. [|CssJs.unsafe("lineHeightStep", "30px")|]);
CssJs.style(. [|CssJs.unsafe("lineHeightStep", "2em")|]);
