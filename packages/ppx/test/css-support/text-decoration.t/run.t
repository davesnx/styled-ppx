This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
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
  CssJs.textDecorationThickness(`auto);
  CssJs.unsafe({js|textDecorationThickness|js}, {js|from-font|js});
  CssJs.textDecorationThickness(`pxFloat(3.));
  CssJs.textDecorationThickness(`percent(10.));
