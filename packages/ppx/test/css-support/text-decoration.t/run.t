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
  
  CSS.textDecorationLine(`none);
  CSS.textDecorationLine(
    CSS.Types.TextDecorationLine.Value.make(
      ~underline=?Some(true),
      ~overline=?None,
      ~lineThrough=?None,
      ~blink=?None,
      (),
    ),
  );
  CSS.textDecorationLine(
    CSS.Types.TextDecorationLine.Value.make(
      ~underline=?None,
      ~overline=?Some(true),
      ~lineThrough=?None,
      ~blink=?None,
      (),
    ),
  );
  CSS.textDecorationLine(
    CSS.Types.TextDecorationLine.Value.make(
      ~underline=?None,
      ~overline=?None,
      ~lineThrough=?Some(true),
      ~blink=?None,
      (),
    ),
  );
  CSS.textDecorationLine(
    CSS.Types.TextDecorationLine.Value.make(
      ~underline=?Some(true),
      ~overline=?Some(true),
      ~lineThrough=?None,
      ~blink=?None,
      (),
    ),
  );
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
    CSS.TextShadow.text(~x=`pxFloat(1.), ~y=`pxFloat(1.), `currentColor),
  );
  
  CSS.textShadow(CSS.TextShadow.text(~x=`zero, ~y=`zero, CSS.black));
  
  CSS.textShadow(
    CSS.TextShadow.text(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      `currentColor,
    ),
  );
  
  CSS.textShadow(
    CSS.TextShadow.text(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      CSS.black,
    ),
  );
  
  CSS.textShadows([|
    CSS.TextShadow.text(~x=`pxFloat(1.), ~y=`pxFloat(1.), `currentColor),
    CSS.TextShadow.text(~x=`pxFloat(2.), ~y=`pxFloat(2.), CSS.red),
  |]);
  CSS.textShadows([|
    CSS.TextShadow.text(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(2.),
      ~blur=`pxFloat(3.),
      CSS.black,
    ),
    CSS.TextShadow.text(~x=`zero, ~y=`zero, ~blur=`pxFloat(5.), CSS.white),
  |]);
  
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
