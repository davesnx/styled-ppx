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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  CSS.unsafe({js|clipPath|js}, {js|url("#clip")|js});
  CSS.unsafe({js|clipPath|js}, {js|inset(50%)|js});
  CSS.unsafe({js|clipPath|js}, {js|path("M 20 20 H 80 V 30")|js});
  CSS.unsafe({js|clipPath|js}, {js|polygon(50% 100%, 0 0, 100% 0)|js});
  CSS.unsafe(
    {js|clipPath|js},
    {js|polygon(evenodd, 0% 0%, 50% 50%, 0% 100%)|js},
  );
  CSS.unsafe(
    {js|clipPath|js},
    {js|polygon(nonzero, 0% 0%, 50% 50%, 0% 100%)|js},
  );
  CSS.unsafe({js|clipPath|js}, {js|border-box|js});
  CSS.unsafe({js|clipPath|js}, {js|padding-box|js});
  CSS.unsafe({js|clipPath|js}, {js|content-box|js});
  CSS.unsafe({js|clipPath|js}, {js|margin-box|js});
  CSS.unsafe({js|clipPath|js}, {js|fill-box|js});
  CSS.unsafe({js|clipPath|js}, {js|stroke-box|js});
  CSS.unsafe({js|clipPath|js}, {js|view-box|js});
  CSS.unsafe({js|clipPath|js}, {js|none|js});
  CSS.unsafe({js|clipRule|js}, {js|nonzero|js});
  CSS.unsafe({js|clipRule|js}, {js|evenodd|js});
  CSS.maskImage(`none);
  CSS.maskImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(`hex({js|333|js})), None), (Some(`hex({js|000|js})), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.unsafe({js|maskImage|js}, {js|url("image.png")|js});
  CSS.unsafe({js|maskMode|js}, {js|alpha|js});
  CSS.unsafe({js|maskMode|js}, {js|luminance|js});
  CSS.unsafe({js|maskMode|js}, {js|match-source|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat-x|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat-y|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|space|js});
  CSS.unsafe({js|maskRepeat|js}, {js|round|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|space repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|round repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat space|js});
  CSS.unsafe({js|maskRepeat|js}, {js|space space|js});
  CSS.unsafe({js|maskRepeat|js}, {js|round space|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat space|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat round|js});
  CSS.unsafe({js|maskRepeat|js}, {js|space round|js});
  CSS.unsafe({js|maskRepeat|js}, {js|round round|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat round|js});
  CSS.unsafe({js|maskRepeat|js}, {js|repeat no-repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|space no-repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|round no-repeat|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat no-repeat|js});
  CSS.maskPosition(`center);
  CSS.maskPosition(`hv((`center, `center)));
  CSS.maskPosition(`hv((`left, `percent(50.))));
  CSS.maskPosition(
    `hvOffset((`right, `pxFloat(20.), `bottom, `pxFloat(10.))),
  );
  CSS.maskPositions([|`hv((`rem(1.), `rem(1.))), `center|]);
  CSS.unsafe({js|maskClip|js}, {js|border-box|js});
  CSS.unsafe({js|maskClip|js}, {js|padding-box|js});
  CSS.unsafe({js|maskClip|js}, {js|content-box|js});
  CSS.unsafe({js|maskClip|js}, {js|margin-box|js});
  CSS.unsafe({js|maskClip|js}, {js|fill-box|js});
  CSS.unsafe({js|maskClip|js}, {js|stroke-box|js});
  CSS.unsafe({js|maskClip|js}, {js|view-box|js});
  CSS.unsafe({js|maskClip|js}, {js|no-clip|js});
  CSS.unsafe({js|maskOrigin|js}, {js|border-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|padding-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|content-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|margin-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|fill-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|stroke-box|js});
  CSS.unsafe({js|maskOrigin|js}, {js|view-box|js});
  CSS.unsafe({js|maskSize|js}, {js|auto|js});
  CSS.unsafe({js|maskSize|js}, {js|10px|js});
  CSS.unsafe({js|maskSize|js}, {js|cover|js});
  CSS.unsafe({js|maskSize|js}, {js|contain|js});
  CSS.unsafe({js|maskSize|js}, {js|10px|js});
  CSS.unsafe({js|maskSize|js}, {js|50%|js});
  CSS.unsafe({js|maskSize|js}, {js|10px auto|js});
  CSS.unsafe({js|maskSize|js}, {js|auto 10%|js});
  CSS.unsafe({js|maskSize|js}, {js|50em 50%|js});
  CSS.unsafe({js|maskComposite|js}, {js|add|js});
  CSS.unsafe({js|maskComposite|js}, {js|subtract|js});
  CSS.unsafe({js|maskComposite|js}, {js|intersect|js});
  CSS.unsafe({js|maskComposite|js}, {js|exclude|js});
  CSS.unsafe({js|mask|js}, {js|top|js});
  CSS.unsafe({js|mask|js}, {js|space|js});
  CSS.unsafe({js|mask|js}, {js|url("image.png")|js});
  CSS.unsafe({js|mask|js}, {js|url("image.png") luminance|js});
  CSS.unsafe({js|mask|js}, {js|url("image.png") luminance top space|js});
  CSS.unsafe({js|maskBorderSource|js}, {js|none|js});
  CSS.unsafe({js|maskBorderSource|js}, {js|url("image.png")|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|0 fill|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|50% fill|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|1.1 fill|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|0 1 fill|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|0 1 2 fill|js});
  CSS.unsafe({js|maskBorderSlice|js}, {js|0 1 2 3 fill|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|auto|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|10px|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|50%|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|1|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|1.0|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|auto 1|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|auto 1 50%|js});
  CSS.unsafe({js|maskBorderWidth|js}, {js|auto 1 50% 1.1|js});
  CSS.unsafe({js|maskBorderOutset|js}, {js|0|js});
  CSS.unsafe({js|maskBorderOutset|js}, {js|1.1|js});
  CSS.unsafe({js|maskBorderOutset|js}, {js|0 1|js});
  CSS.unsafe({js|maskBorderOutset|js}, {js|0 1 2|js});
  CSS.unsafe({js|maskBorderOutset|js}, {js|0 1 2 3|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|stretch|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|repeat|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|round|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|space|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|stretch stretch|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|repeat stretch|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|round stretch|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|space stretch|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|stretch repeat|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|repeat repeat|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|round repeat|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|space repeat|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|stretch round|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|repeat round|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|round round|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|space round|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|stretch space|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|repeat space|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|round space|js});
  CSS.unsafe({js|maskBorderRepeat|js}, {js|space space|js});
  CSS.unsafe({js|maskBorder|js}, {js|url("image.png")|js});
  CSS.unsafe({js|maskType|js}, {js|luminance|js});
  CSS.unsafe({js|maskType|js}, {js|alpha|js});
