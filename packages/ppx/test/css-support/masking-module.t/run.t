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
      Some(`deg(45.)),
      [|(Some(`hex({js|333|js})), None), (Some(`hex({js|000|js})), None)|]: CssJs.Types.Gradient.color_stop_list,
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
