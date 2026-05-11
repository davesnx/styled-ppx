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
  
  CSS.alignSelf(`auto);
  CSS.alignSelf(`normal);
  CSS.alignSelf(`stretch);
  CSS.alignSelf(`baseline);
  CSS.alignSelf(`firstBaseline);
  CSS.alignSelf(`lastBaseline);
  CSS.alignSelf(`center);
  CSS.alignSelf(`start);
  CSS.alignSelf(`end_);
  CSS.alignSelf(`selfStart);
  CSS.alignSelf(`selfEnd);
  CSS.alignSelf(`unsafe(`start));
  CSS.alignSelf(`safe(`start));
  CSS.alignItems(`normal);
  CSS.alignItems(`stretch);
  CSS.alignItems(`baseline);
  CSS.alignItems(`firstBaseline);
  CSS.alignItems(`lastBaseline);
  CSS.alignItems(`center);
  CSS.alignItems(`start);
  CSS.alignItems(`end_);
  CSS.alignItems(`selfStart);
  CSS.alignItems(`selfEnd);
  CSS.alignItems(`unsafe(`start));
  CSS.alignItems(`safe(`start));
  CSS.alignContent(`normal);
  CSS.alignContent(`baseline);
  CSS.alignContent(`firstBaseline);
  CSS.alignContent(`lastBaseline);
  CSS.alignContent(`spaceBetween);
  CSS.alignContent(`spaceAround);
  CSS.alignContent(`spaceEvenly);
  CSS.alignContent(`stretch);
  CSS.alignContent(`center);
  CSS.alignContent(`start);
  CSS.alignContent(`end_);
  CSS.alignContent(`flexStart);
  CSS.alignContent(`flexEnd);
  CSS.alignContent(`unsafe(`start));
  CSS.alignContent(`safe(`start));
  CSS.justifySelf(`auto);
  CSS.justifySelf(`normal);
  CSS.justifySelf(`stretch);
  CSS.justifySelf(`baseline);
  CSS.justifySelf(`firstBaseline);
  CSS.justifySelf(`lastBaseline);
  CSS.justifySelf(`center);
  CSS.justifySelf(`start);
  CSS.justifySelf(`end_);
  CSS.justifySelf(`selfStart);
  CSS.justifySelf(`selfEnd);
  CSS.justifySelf(`unsafe(`start));
  CSS.justifySelf(`safe(`start));
  CSS.justifySelf(`left);
  CSS.justifySelf(`right);
  CSS.justifySelf(`safe(`right));
  CSS.justifyItems(`normal);
  CSS.justifyItems(`stretch);
  CSS.justifyItems(`baseline);
  CSS.justifyItems(`firstBaseline);
  CSS.justifyItems(`lastBaseline);
  CSS.justifyItems(`center);
  CSS.justifyItems(`start);
  CSS.justifyItems(`end_);
  CSS.justifyItems(`selfStart);
  CSS.justifyItems(`selfEnd);
  CSS.justifyItems(`unsafe(`start));
  CSS.justifyItems(`safe(`start));
  CSS.justifyItems(`left);
  CSS.justifyItems(`right);
  CSS.justifyItems(`safe(`right));
  CSS.justifyItems(`legacy);
  CSS.justifyItems(`legacyLeft);
  CSS.justifyItems(`legacyRight);
  CSS.justifyItems(`legacyCenter);
  CSS.justifyContent(`normal);
  CSS.justifyContent(`spaceBetween);
  CSS.justifyContent(`spaceAround);
  CSS.justifyContent(`spaceEvenly);
  CSS.justifyContent(`stretch);
  CSS.justifyContent(`center);
  CSS.justifyContent(`start);
  CSS.justifyContent(`end_);
  CSS.justifyContent(`flexStart);
  CSS.justifyContent(`flexEnd);
  CSS.justifyContent(`unsafe(`start));
  CSS.justifyContent(`safe(`start));
  CSS.justifyContent(`left);
  CSS.justifyContent(`right);
  CSS.justifyContent(`safe(`right));
  CSS.placeContent(`normal);
  CSS.placeContent(`baseline);
  CSS.placeContent(`firstBaseline);
  CSS.placeContent(`lastBaseline);
  CSS.placeContent(`spaceBetween);
  CSS.placeContent(`spaceAround);
  CSS.placeContent(`spaceEvenly);
  CSS.placeContent(`stretch);
  CSS.placeContent(`center);
  CSS.placeContent(`start);
  CSS.placeContent(`end_);
  CSS.placeContent(`flexStart);
  CSS.placeContent(`flexEnd);
  CSS.placeContent(`unsafe(`start));
  CSS.placeContent(`safe(`start));
  CSS.alignContent(`normal);
  CSS.alignContent(`baseline);
  CSS.alignContent(`firstBaseline);
  CSS.alignContent(`spaceBetween);
  CSS.alignContent(`center);
  CSS.alignContent(`unsafe(`start));
  CSS.alignContent(`normal);
  CSS.alignContent(`baseline);
  CSS.alignContent(`firstBaseline);
  CSS.alignContent(`center);
  CSS.alignContent(`unsafe(`start));
  CSS.alignContent(`normal);
  CSS.alignContent(`baseline);
  CSS.alignContent(`firstBaseline);
  CSS.alignContent(`spaceBetween);
  CSS.alignContent(`center);
  CSS.alignContent(`unsafe(`start));
  CSS.placeItems(`normal);
  CSS.placeItems(`stretch);
  CSS.placeItems(`baseline);
  CSS.placeItems(`firstBaseline);
  CSS.placeItems(`lastBaseline);
  CSS.placeItems(`center);
  CSS.placeItems(`start);
  CSS.placeItems(`end_);
  CSS.placeItems(`selfStart);
  CSS.placeItems(`selfEnd);
  CSS.placeItems(`unsafe(`start));
  CSS.placeItems(`safe(`start));
  CSS.alignItems(`normal);
  CSS.alignItems(`stretch);
  CSS.alignItems(`baseline);
  CSS.alignItems(`firstBaseline);
  CSS.alignItems(`selfStart);
  CSS.alignItems(`unsafe(`start));
  CSS.alignItems(`normal);
  CSS.alignItems(`stretch);
  CSS.alignItems(`baseline);
  CSS.alignItems(`firstBaseline);
  CSS.alignItems(`selfStart);
  CSS.alignItems(`unsafe(`start));
  CSS.alignItems(`normal);
  CSS.alignItems(`stretch);
  CSS.alignItems(`baseline);
  CSS.alignItems(`firstBaseline);
  CSS.alignItems(`selfStart);
  CSS.alignItems(`unsafe(`start));
  CSS.alignItems(`normal);
  CSS.alignItems(`stretch);
  CSS.alignItems(`baseline);
  CSS.alignItems(`firstBaseline);
  CSS.alignItems(`selfStart);
  CSS.alignItems(`unsafe(`start));
  
  CSS.gap2(~rowGap=`zero, ~columnGap=`zero);
  CSS.gap2(~rowGap=`zero, ~columnGap=`em(1.));
  CSS.gap(`em(1.));
  CSS.gap2(~rowGap=`em(1.), ~columnGap=`em(1.));
  CSS.columnGap(`zero);
  CSS.columnGap(`em(1.));
  CSS.columnGap(`normal);
  CSS.rowGap(`zero);
  CSS.rowGap(`em(1.));
  
  CSS.unsafe({js|marginTrim|js}, {js|none|js});
  CSS.unsafe({js|marginTrim|js}, {js|in-flow|js});
  CSS.unsafe({js|marginTrim|js}, {js|all|js});
