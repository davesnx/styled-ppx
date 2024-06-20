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
  CssJs.unsafe({|clipPath|}, {|url('#clip')|});
  CssJs.unsafe({|clipPath|}, {|inset(50%)|});
  CssJs.unsafe({|clipPath|}, {|path('M 20 20 H 80 V 30')|});
  CssJs.unsafe({|clipPath|}, {|border-box|});
  CssJs.unsafe({|clipPath|}, {|padding-box|});
  CssJs.unsafe({|clipPath|}, {|content-box|});
  CssJs.unsafe({|clipPath|}, {|margin-box|});
  CssJs.unsafe({|clipPath|}, {|fill-box|});
  CssJs.unsafe({|clipPath|}, {|stroke-box|});
  CssJs.unsafe({|clipPath|}, {|view-box|});
  CssJs.unsafe({|clipPath|}, {|none|});
  CssJs.unsafe({|clipRule|}, {|nonzero|});
  CssJs.unsafe({|clipRule|}, {|evenodd|});
  CssJs.maskImage(`none);
  CssJs.maskImage(
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(`hex({|333|})), None), (Some(`hex({|000|})), None)|]: Css_AtomicTypes.Gradient.color_stop_list,
    )),
  );
  CssJs.unsafe({|maskImage|}, {|url(image.png)|});
  CssJs.unsafe({|maskMode|}, {|alpha|});
  CssJs.unsafe({|maskMode|}, {|luminance|});
  CssJs.unsafe({|maskMode|}, {|match-source|});
  CssJs.unsafe({|maskRepeat|}, {|repeat-x|});
  CssJs.unsafe({|maskRepeat|}, {|repeat-y|});
  CssJs.unsafe({|maskRepeat|}, {|repeat|});
  CssJs.unsafe({|maskRepeat|}, {|space|});
  CssJs.unsafe({|maskRepeat|}, {|round|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat|});
  CssJs.unsafe({|maskRepeat|}, {|repeat repeat|});
  CssJs.unsafe({|maskRepeat|}, {|space repeat|});
  CssJs.unsafe({|maskRepeat|}, {|round repeat|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat repeat|});
  CssJs.unsafe({|maskRepeat|}, {|repeat space|});
  CssJs.unsafe({|maskRepeat|}, {|space space|});
  CssJs.unsafe({|maskRepeat|}, {|round space|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat space|});
  CssJs.unsafe({|maskRepeat|}, {|repeat round|});
  CssJs.unsafe({|maskRepeat|}, {|space round|});
  CssJs.unsafe({|maskRepeat|}, {|round round|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat round|});
  CssJs.unsafe({|maskRepeat|}, {|repeat no-repeat|});
  CssJs.unsafe({|maskRepeat|}, {|space no-repeat|});
  CssJs.unsafe({|maskRepeat|}, {|round no-repeat|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat no-repeat|});
  CssJs.unsafe({|maskPosition|}, {|center|});
  CssJs.unsafe({|maskPosition|}, {|center center|});
  CssJs.unsafe({|maskPosition|}, {|left 50%|});
  CssJs.unsafe({|maskPosition|}, {|bottom 10px right 20px|});
  CssJs.unsafe({|maskClip|}, {|border-box|});
  CssJs.unsafe({|maskClip|}, {|padding-box|});
  CssJs.unsafe({|maskClip|}, {|content-box|});
  CssJs.unsafe({|maskClip|}, {|margin-box|});
  CssJs.unsafe({|maskClip|}, {|fill-box|});
  CssJs.unsafe({|maskClip|}, {|stroke-box|});
  CssJs.unsafe({|maskClip|}, {|view-box|});
  CssJs.unsafe({|maskClip|}, {|no-clip|});
  CssJs.unsafe({|maskOrigin|}, {|border-box|});
  CssJs.unsafe({|maskOrigin|}, {|padding-box|});
  CssJs.unsafe({|maskOrigin|}, {|content-box|});
  CssJs.unsafe({|maskOrigin|}, {|margin-box|});
  CssJs.unsafe({|maskOrigin|}, {|fill-box|});
  CssJs.unsafe({|maskOrigin|}, {|stroke-box|});
  CssJs.unsafe({|maskOrigin|}, {|view-box|});
  CssJs.unsafe({|maskSize|}, {|auto|});
  CssJs.unsafe({|maskSize|}, {|10px|});
  CssJs.unsafe({|maskSize|}, {|cover|});
  CssJs.unsafe({|maskSize|}, {|contain|});
  CssJs.unsafe({|maskSize|}, {|10px|});
  CssJs.unsafe({|maskSize|}, {|50%|});
  CssJs.unsafe({|maskSize|}, {|10px auto|});
  CssJs.unsafe({|maskSize|}, {|auto 10%|});
  CssJs.unsafe({|maskSize|}, {|50em 50%|});
  CssJs.unsafe({|maskComposite|}, {|add|});
  CssJs.unsafe({|maskComposite|}, {|subtract|});
  CssJs.unsafe({|maskComposite|}, {|intersect|});
  CssJs.unsafe({|maskComposite|}, {|exclude|});
  CssJs.unsafe({|mask|}, {|top|});
  CssJs.unsafe({|mask|}, {|space|});
  CssJs.unsafe({|mask|}, {|url(image.png)|});
  CssJs.unsafe({|mask|}, {|url(image.png) luminance|});
  CssJs.unsafe({|mask|}, {|url(image.png) luminance top space|});
  CssJs.unsafe({|maskBorderSource|}, {|none|});
  CssJs.unsafe({|maskBorderSource|}, {|url(image.png)|});
  CssJs.unsafe({|maskBorderSlice|}, {|0 fill|});
  CssJs.unsafe({|maskBorderSlice|}, {|50% fill|});
  CssJs.unsafe({|maskBorderSlice|}, {|1.1 fill|});
  CssJs.unsafe({|maskBorderSlice|}, {|0 1 fill|});
  CssJs.unsafe({|maskBorderSlice|}, {|0 1 2 fill|});
  CssJs.unsafe({|maskBorderSlice|}, {|0 1 2 3 fill|});
  CssJs.unsafe({|maskBorderWidth|}, {|auto|});
  CssJs.unsafe({|maskBorderWidth|}, {|10px|});
  CssJs.unsafe({|maskBorderWidth|}, {|50%|});
  CssJs.unsafe({|maskBorderWidth|}, {|1|});
  CssJs.unsafe({|maskBorderWidth|}, {|1.0|});
  CssJs.unsafe({|maskBorderWidth|}, {|auto 1|});
  CssJs.unsafe({|maskBorderWidth|}, {|auto 1 50%|});
  CssJs.unsafe({|maskBorderWidth|}, {|auto 1 50% 1.1|});
  CssJs.unsafe({|maskBorderOutset|}, {|0|});
  CssJs.unsafe({|maskBorderOutset|}, {|1.1|});
  CssJs.unsafe({|maskBorderOutset|}, {|0 1|});
  CssJs.unsafe({|maskBorderOutset|}, {|0 1 2|});
  CssJs.unsafe({|maskBorderOutset|}, {|0 1 2 3|});
  CssJs.unsafe({|maskBorderRepeat|}, {|stretch|});
  CssJs.unsafe({|maskBorderRepeat|}, {|repeat|});
  CssJs.unsafe({|maskBorderRepeat|}, {|round|});
  CssJs.unsafe({|maskBorderRepeat|}, {|space|});
  CssJs.unsafe({|maskBorderRepeat|}, {|stretch stretch|});
  CssJs.unsafe({|maskBorderRepeat|}, {|repeat stretch|});
  CssJs.unsafe({|maskBorderRepeat|}, {|round stretch|});
  CssJs.unsafe({|maskBorderRepeat|}, {|space stretch|});
  CssJs.unsafe({|maskBorderRepeat|}, {|stretch repeat|});
  CssJs.unsafe({|maskBorderRepeat|}, {|repeat repeat|});
  CssJs.unsafe({|maskBorderRepeat|}, {|round repeat|});
  CssJs.unsafe({|maskBorderRepeat|}, {|space repeat|});
  CssJs.unsafe({|maskBorderRepeat|}, {|stretch round|});
  CssJs.unsafe({|maskBorderRepeat|}, {|repeat round|});
  CssJs.unsafe({|maskBorderRepeat|}, {|round round|});
  CssJs.unsafe({|maskBorderRepeat|}, {|space round|});
  CssJs.unsafe({|maskBorderRepeat|}, {|stretch space|});
  CssJs.unsafe({|maskBorderRepeat|}, {|repeat space|});
  CssJs.unsafe({|maskBorderRepeat|}, {|round space|});
  CssJs.unsafe({|maskBorderRepeat|}, {|space space|});
  CssJs.unsafe({|maskBorder|}, {|url(image.png)|});
  CssJs.unsafe({|maskType|}, {|luminance|});
  CssJs.unsafe({|maskType|}, {|alpha|});
