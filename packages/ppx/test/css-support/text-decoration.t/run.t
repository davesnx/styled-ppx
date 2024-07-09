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
  CSS.textDecorationLine(`none);
  CSS.textDecorationLine(`underline);
  CSS.textDecorationLine(`overline);
  CSS.textDecorationLine(`lineThrough);
  CSS.unsafe({js|textDecorationLine|js}, {js|underline overline|js});
  CSS.textDecorationColor(CSS.white);
  CSS.textDecorationStyle(`solid);
  CSS.textDecorationStyle(`double);
  CSS.textDecorationStyle(`dotted);
  CSS.textDecorationStyle(`dashed);
  CSS.textDecorationStyle(`wavy);
  CSS.unsafe({js|textUnderlinePosition|js}, {js|auto|js});
  CSS.unsafe({js|textUnderlinePosition|js}, {js|under|js});
  CSS.unsafe({js|textUnderlinePosition|js}, {js|left|js});
  CSS.unsafe({js|textUnderlinePosition|js}, {js|right|js});
  CSS.unsafe({js|textUnderlinePosition|js}, {js|under left|js});
  CSS.unsafe({js|textUnderlinePosition|js}, {js|under right|js});
  CSS.textEmphasisStyle(`none);
  CSS.textEmphasisStyle(`filled);
  CSS.textEmphasisStyle(`open_);
  CSS.textEmphasisStyle(`dot);
  CSS.textEmphasisStyle(`circle);
  CSS.textEmphasisStyle(`double_circle);
  CSS.textEmphasisStyle(`triangle);
  CSS.textEmphasisStyle(`sesame);
  CSS.textEmphasisStyles(`open_, `dot);
  CSS.textEmphasisStyle(`string({js|foo|js}));
  CSS.textEmphasisColor(CSS.green);
  CSS.unsafe({js|textEmphasis|js}, {js|open dot green|js});
  CSS.textEmphasisPosition(`over);
  CSS.textEmphasisPosition(`under);
  CSS.textEmphasisPositions(`over, `left);
  CSS.textEmphasisPositions(`over, `right);
  CSS.textEmphasisPositions(`under, `left);
  CSS.textEmphasisPositions(`under, `left);
  CSS.textEmphasisPositions(`under, `right);
  CSS.textShadow(`none);
  CSS.textShadow(
    CSS.Shadow.text(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      CSS.black,
    ),
  );
  CSS.unsafe({js|textDecorationSkip|js}, {js|none|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects spaces|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects leading-spaces|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects trailing-spaces|js});
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|objects leading-spaces trailing-spaces|js},
  );
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|objects leading-spaces trailing-spaces edges|js},
  );
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|objects leading-spaces trailing-spaces edges box-decoration|js},
  );
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects edges|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|objects box-decoration|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|spaces|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|spaces edges|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|spaces edges box-decoration|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|spaces box-decoration|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|leading-spaces|js});
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|leading-spaces trailing-spaces edges|js},
  );
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|leading-spaces trailing-spaces edges box-decoration|js},
  );
  CSS.unsafe({js|textDecorationSkip|js}, {js|edges|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|edges box-decoration|js});
  CSS.unsafe({js|textDecorationSkip|js}, {js|box-decoration|js});
  CSS.textDecorationSkipInk(`none);
  CSS.textDecorationSkipInk(`auto);
  CSS.textDecorationSkipInk(`all);
  CSS.textDecorationSkipBox(`none);
  CSS.textDecorationSkipBox(`all);
  CSS.textDecorationSkipInset(`none);
  CSS.textDecorationSkipInset(`auto);
  CSS.unsafe({js|textUnderlineOffset|js}, {js|auto|js});
  CSS.unsafe({js|textUnderlineOffset|js}, {js|3px|js});
  CSS.unsafe({js|textUnderlineOffset|js}, {js|10%|js});
  CSS.textDecorationThickness(`auto);
  CSS.unsafe({js|textDecorationThickness|js}, {js|from-font|js});
  CSS.textDecorationThickness(`pxFloat(3.));
  CSS.textDecorationThickness(`percent(10.));
