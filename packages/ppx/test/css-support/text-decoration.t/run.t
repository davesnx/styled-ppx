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
  CssJs.unsafe({|textDecorationLine|}, {|underline overline|});
  CssJs.textDecorationColor(CssJs.white);
  CssJs.textDecorationStyle(`solid);
  CssJs.textDecorationStyle(`double);
  CssJs.textDecorationStyle(`dotted);
  CssJs.textDecorationStyle(`dashed);
  CssJs.textDecorationStyle(`wavy);
  CssJs.unsafe({|textUnderlinePosition|}, {|auto|});
  CssJs.unsafe({|textUnderlinePosition|}, {|under|});
  CssJs.unsafe({|textUnderlinePosition|}, {|left|});
  CssJs.unsafe({|textUnderlinePosition|}, {|right|});
  CssJs.unsafe({|textUnderlinePosition|}, {|under left|});
  CssJs.unsafe({|textUnderlinePosition|}, {|under right|});
  CssJs.textEmphasisStyle(`none);
  CssJs.textEmphasisStyle(`filled);
  CssJs.textEmphasisStyle(`open_);
  CssJs.textEmphasisStyle(`dot);
  CssJs.textEmphasisStyle(`circle);
  CssJs.textEmphasisStyle(`double_circle);
  CssJs.textEmphasisStyle(`triangle);
  CssJs.textEmphasisStyle(`sesame);
  CssJs.textEmphasisStyles(`open_, `dot);
  CssJs.textEmphasisStyle(`string({|foo|}));
  CssJs.textEmphasisColor(CssJs.green);
  CssJs.unsafe({|textEmphasis|}, {|open dot green|});
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
  CssJs.unsafe({|textDecorationSkip|}, {|none|});
  CssJs.unsafe({|textDecorationSkip|}, {|objects|});
  CssJs.unsafe({|textDecorationSkip|}, {|objects spaces|});
  CssJs.unsafe({|textDecorationSkip|}, {|objects leading-spaces|});
  CssJs.unsafe({|textDecorationSkip|}, {|objects trailing-spaces|});
  CssJs.unsafe(
    {|textDecorationSkip|},
    {|objects leading-spaces trailing-spaces|},
  );
  CssJs.unsafe(
    {|textDecorationSkip|},
    {|objects leading-spaces trailing-spaces edges|},
  );
  CssJs.unsafe(
    {|textDecorationSkip|},
    {|objects leading-spaces trailing-spaces edges box-decoration|},
  );
  CssJs.unsafe({|textDecorationSkip|}, {|objects edges|});
  CssJs.unsafe({|textDecorationSkip|}, {|objects box-decoration|});
  CssJs.unsafe({|textDecorationSkip|}, {|spaces|});
  CssJs.unsafe({|textDecorationSkip|}, {|spaces edges|});
  CssJs.unsafe({|textDecorationSkip|}, {|spaces edges box-decoration|});
  CssJs.unsafe({|textDecorationSkip|}, {|spaces box-decoration|});
  CssJs.unsafe({|textDecorationSkip|}, {|leading-spaces|});
  CssJs.unsafe(
    {|textDecorationSkip|},
    {|leading-spaces trailing-spaces edges|},
  );
  CssJs.unsafe(
    {|textDecorationSkip|},
    {|leading-spaces trailing-spaces edges box-decoration|},
  );
  CssJs.unsafe({|textDecorationSkip|}, {|edges|});
  CssJs.unsafe({|textDecorationSkip|}, {|edges box-decoration|});
  CssJs.unsafe({|textDecorationSkip|}, {|box-decoration|});
  CssJs.textDecorationSkipInk(`none);
  CssJs.textDecorationSkipInk(`auto);
  CssJs.textDecorationSkipInk(`all);
  CssJs.textDecorationSkipBox(`none);
  CssJs.textDecorationSkipBox(`all);
  CssJs.textDecorationSkipInset(`none);
  CssJs.textDecorationSkipInset(`auto);
  CssJs.unsafe({|textUnderlineOffset|}, {|auto|});
  CssJs.unsafe({|textUnderlineOffset|}, {|3px|});
  CssJs.unsafe({|textUnderlineOffset|}, {|10%|});
  CssJs.textDecorationThickness(`auto);
  CssJs.unsafe({|textDecorationThickness|}, {|from-font|});
  CssJs.textDecorationThickness(`pxFloat(3.));
  CssJs.textDecorationThickness(`percent(10.));
