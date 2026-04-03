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
  
  CSS.scrollMargin(`pxFloat(0.));
  CSS.scrollMargin2(~v=`pxFloat(6.), ~h=`pxFloat(5.));
  CSS.scrollMargin3(
    ~top=`pxFloat(10.),
    ~h=`pxFloat(20.),
    ~bottom=`pxFloat(30.),
  );
  CSS.scrollMargin4(
    ~top=`pxFloat(10.),
    ~right=`pxFloat(20.),
    ~bottom=`pxFloat(30.),
    ~left=`pxFloat(40.),
  );
  CSS.unsafe({js|scrollMargin|js}, {js|20px 3em 1in 5rem|js});
  CSS.scrollMargin(`calc(`pxFloat(2.)));
  CSS.scrollMargin(`calc(`mult((`num(3.), `pxFloat(25.)))));
  CSS.scrollMargin4(
    ~top=`calc(`mult((`num(3.), `pxFloat(25.)))),
    ~right=`pxFloat(5.),
    ~bottom=`em(10.),
    ~left=`calc(`sub((`vw(1.), `pxFloat(5.)))),
  );
  CSS.scrollMarginBlock(`pxFloat(10.));
  CSS.scrollMarginBlock2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.scrollMarginBlockEnd(`pxFloat(10.));
  CSS.scrollMarginBlockStart(`pxFloat(10.));
  CSS.scrollMarginBottom(`pxFloat(10.));
  CSS.scrollMarginInline(`pxFloat(10.));
  CSS.scrollMarginInline2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.scrollMarginInlineStart(`pxFloat(10.));
  CSS.scrollMarginInlineEnd(`pxFloat(10.));
  CSS.scrollMarginLeft(`pxFloat(10.));
  CSS.scrollMarginRight(`pxFloat(10.));
  CSS.scrollMarginTop(`pxFloat(10.));
  CSS.scrollPadding(`auto);
  CSS.scrollPadding(`pxFloat(0.));
  CSS.scrollPadding2(~v=`pxFloat(6.), ~h=`pxFloat(5.));
  CSS.scrollPadding3(
    ~top=`pxFloat(10.),
    ~h=`pxFloat(20.),
    ~bottom=`pxFloat(30.),
  );
  CSS.scrollPadding4(
    ~top=`pxFloat(10.),
    ~right=`pxFloat(20.),
    ~bottom=`pxFloat(30.),
    ~left=`pxFloat(40.),
  );
  CSS.scrollPadding4(
    ~top=`pxFloat(10.),
    ~right=`auto,
    ~bottom=`pxFloat(30.),
    ~left=`auto,
  );
  CSS.scrollPadding(`percent(10.));
  CSS.unsafe({js|scrollPadding|js}, {js|20% 3em 1in 5rem|js});
  CSS.scrollPadding(`calc(`pxFloat(2.)));
  CSS.scrollPadding(`calc(`percent(50.)));
  CSS.scrollPadding(`calc(`mult((`num(3.), `pxFloat(25.)))));
  CSS.scrollPadding4(
    ~top=`calc(`mult((`num(3.), `pxFloat(25.)))),
    ~right=`pxFloat(5.),
    ~bottom=`percent(10.),
    ~left=`calc(`sub((`percent(10.), `pxFloat(5.)))),
  );
  CSS.scrollPaddingBlock(`pxFloat(10.));
  CSS.scrollPaddingBlock(`percent(50.));
  CSS.scrollPaddingBlock2(~v=`pxFloat(10.), ~h=`percent(50.));
  CSS.scrollPaddingBlock2(~v=`percent(50.), ~h=`percent(50.));
  CSS.scrollPaddingBlockEnd(`pxFloat(10.));
  CSS.scrollPaddingBlockEnd(`percent(50.));
  CSS.scrollPaddingBlockStart(`pxFloat(10.));
  CSS.scrollPaddingBlockStart(`percent(50.));
  CSS.scrollPaddingBottom(`pxFloat(10.));
  CSS.scrollPaddingBottom(`percent(50.));
  CSS.scrollPaddingInline(`pxFloat(10.));
  CSS.scrollPaddingInline(`percent(50.));
  CSS.scrollPaddingInline2(~v=`pxFloat(10.), ~h=`percent(50.));
  CSS.scrollPaddingInline2(~v=`percent(50.), ~h=`percent(50.));
  CSS.scrollPaddingInlineEnd(`pxFloat(10.));
  CSS.scrollPaddingInlineEnd(`percent(50.));
  CSS.scrollPaddingInlineStart(`pxFloat(10.));
  CSS.scrollPaddingInlineStart(`percent(50.));
  CSS.scrollPaddingLeft(`pxFloat(10.));
  CSS.scrollPaddingLeft(`percent(50.));
  CSS.scrollPaddingRight(`pxFloat(10.));
  CSS.scrollPaddingRight(`percent(50.));
  CSS.scrollPaddingTop(`pxFloat(10.));
  CSS.scrollPaddingTop(`percent(50.));
  CSS.unsafe({js|scrollSnapAlign|js}, {js|none|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|none start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end center|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end none|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center center|js});
  CSS.unsafe({js|scrollSnapStop|js}, {js|normal|js});
  CSS.unsafe({js|scrollSnapStop|js}, {js|always|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|none|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|x mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|y mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|block mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|inline mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|both mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|x proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|y proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|block proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|inline proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|both proximity|js});
