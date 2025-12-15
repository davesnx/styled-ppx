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
  module X = {
    let value = 1.;
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.alignContent(`flexStart);
  CSS.alignContent(`flexEnd);
  CSS.alignContent(`spaceBetween);
  CSS.alignContent(`spaceAround);
  CSS.alignItems(`flexStart);
  CSS.alignItems(`flexEnd);
  CSS.alignSelf(`flexStart);
  CSS.alignSelf(`flexEnd);
  CSS.display(`flex);
  CSS.display(`inlineFlex);
  CSS.flex1(`none);
  CSS.flex(5., 7., `percent(10.));
  CSS.flex1(`num(2.));
  CSS.flexBasis(`em(10.));
  CSS.flexBasis(`percent(30.));
  CSS.flexBasis(`minContent);
  CSS.flex2(~basis=`pxFloat(30.), 1.);
  CSS.flex2(~shrink=2., 2.);
  CSS.flex(2., 2., `percent(10.));
  CSS.flex1(X.flex1);
  CSS.flex2(~shrink=X.value, X.value);
  CSS.flex(X.value, X.value, X.min);
  CSS.flexBasis(`auto);
  CSS.flexBasis(`content);
  CSS.flexBasis(`pxFloat(1.));
  CSS.flexDirection(`row);
  CSS.flexDirection(`rowReverse);
  CSS.flexDirection(`column);
  CSS.flexDirection(`columnReverse);
  CSS.flexFlow(Some(`row), None);
  CSS.flexFlow(Some(`rowReverse), None);
  CSS.flexFlow(Some(`column), None);
  CSS.flexFlow(Some(`columnReverse), None);
  CSS.flexFlow(None, Some(`wrap));
  CSS.flexFlow(None, Some(`wrapReverse));
  CSS.flexFlow(Some(`row), Some(`wrap));
  CSS.flexFlow(Some(`rowReverse), Some(`nowrap));
  CSS.flexFlow(Some(`column), Some(`wrap));
  CSS.flexFlow(Some(`columnReverse), Some(`wrapReverse));
  CSS.flexGrow(0.);
  CSS.flexGrow(5.);
  CSS.flexShrink(1.);
  CSS.flexShrink(10.);
  CSS.flexWrap(`nowrap);
  CSS.flexWrap(`wrap);
  CSS.flexWrap(`wrapReverse);
  CSS.justifyContent(`flexStart);
  CSS.justifyContent(`flexEnd);
  CSS.justifyContent(`spaceBetween);
  CSS.justifyContent(`spaceAround);
  CSS.unsafe({js|minHeight|js}, {js|auto|js});
  CSS.unsafe({js|minWidth|js}, {js|auto|js});
  CSS.order(0);
  CSS.order(1);
