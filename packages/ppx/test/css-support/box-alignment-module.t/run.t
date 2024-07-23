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
  CSS.unsafe({js|placeContent|js}, {js|normal|js});
  CSS.unsafe({js|placeContent|js}, {js|baseline|js});
  CSS.unsafe({js|placeContent|js}, {js|first baseline|js});
  CSS.unsafe({js|placeContent|js}, {js|last baseline|js});
  CSS.unsafe({js|placeContent|js}, {js|space-between|js});
  CSS.unsafe({js|placeContent|js}, {js|space-around|js});
  CSS.unsafe({js|placeContent|js}, {js|space-evenly|js});
  CSS.unsafe({js|placeContent|js}, {js|stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|center|js});
  CSS.unsafe({js|placeContent|js}, {js|start|js});
  CSS.unsafe({js|placeContent|js}, {js|end|js});
  CSS.unsafe({js|placeContent|js}, {js|flex-start|js});
  CSS.unsafe({js|placeContent|js}, {js|flex-end|js});
  CSS.unsafe({js|placeContent|js}, {js|unsafe start|js});
  CSS.unsafe({js|placeContent|js}, {js|safe start|js});
  CSS.unsafe({js|placeContent|js}, {js|normal normal|js});
  CSS.unsafe({js|placeContent|js}, {js|baseline normal|js});
  CSS.unsafe({js|placeContent|js}, {js|first baseline normal|js});
  CSS.unsafe({js|placeContent|js}, {js|space-between normal|js});
  CSS.unsafe({js|placeContent|js}, {js|center normal|js});
  CSS.unsafe({js|placeContent|js}, {js|unsafe start normal|js});
  CSS.unsafe({js|placeContent|js}, {js|normal stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|baseline stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|first baseline stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|center stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|unsafe start stretch|js});
  CSS.unsafe({js|placeContent|js}, {js|normal safe right|js});
  CSS.unsafe({js|placeContent|js}, {js|baseline safe right|js});
  CSS.unsafe({js|placeContent|js}, {js|first baseline safe right|js});
  CSS.unsafe({js|placeContent|js}, {js|space-between safe right|js});
  CSS.unsafe({js|placeContent|js}, {js|center safe right|js});
  CSS.unsafe({js|placeContent|js}, {js|unsafe start safe right|js});
  CSS.unsafe({js|placeItems|js}, {js|normal|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|first baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|center|js});
  CSS.unsafe({js|placeItems|js}, {js|start|js});
  CSS.unsafe({js|placeItems|js}, {js|end|js});
  CSS.unsafe({js|placeItems|js}, {js|self-start|js});
  CSS.unsafe({js|placeItems|js}, {js|self-end|js});
  CSS.unsafe({js|placeItems|js}, {js|unsafe start|js});
  CSS.unsafe({js|placeItems|js}, {js|safe start|js});
  CSS.unsafe({js|placeItems|js}, {js|normal normal|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch normal|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline normal|js});
  CSS.unsafe({js|placeItems|js}, {js|first baseline normal|js});
  CSS.unsafe({js|placeItems|js}, {js|self-start normal|js});
  CSS.unsafe({js|placeItems|js}, {js|unsafe start normal|js});
  CSS.unsafe({js|placeItems|js}, {js|normal stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|first baseline stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|self-start stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|unsafe start stretch|js});
  CSS.unsafe({js|placeItems|js}, {js|normal last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|first baseline last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|self-start last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|unsafe start last baseline|js});
  CSS.unsafe({js|placeItems|js}, {js|normal legacy left|js});
  CSS.unsafe({js|placeItems|js}, {js|stretch legacy left|js});
  CSS.unsafe({js|placeItems|js}, {js|baseline legacy left|js});
  CSS.unsafe({js|placeItems|js}, {js|first baseline legacy left|js});
  CSS.unsafe({js|placeItems|js}, {js|self-start legacy left|js});
  CSS.unsafe({js|placeItems|js}, {js|unsafe start legacy left|js});
  
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
