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
  
  CSS.textTransform(`fullWidth);
  CSS.textTransform(`fullSizeKana);
  
  CSS.tabSize(`num(4.));
  CSS.tabSize(`em(1.));
  CSS.lineBreak(`auto);
  CSS.lineBreak(`loose);
  CSS.lineBreak(`normal);
  CSS.lineBreak(`strict);
  CSS.lineBreak(`anywhere);
  CSS.wordBreak(`normal);
  CSS.wordBreak(`keepAll);
  CSS.wordBreak(`breakAll);
  CSS.whiteSpace(`breakSpaces);
  CSS.hyphens(`auto);
  CSS.hyphens(`manual);
  CSS.hyphens(`none);
  CSS.overflowWrap(`normal);
  CSS.overflowWrap(`breakWord);
  CSS.overflowWrap(`anywhere);
  CSS.wordWrap(`normal);
  CSS.wordWrap(`breakWord);
  CSS.wordWrap(`anywhere);
  CSS.textAlign(`start);
  CSS.textAlign(`end_);
  CSS.textAlign(`left);
  CSS.textAlign(`right);
  CSS.textAlign(`center);
  CSS.textAlign(`justify);
  CSS.textAlign(`matchParent);
  CSS.textAlign(`justifyAll);
  CSS.textAlignAll(`start);
  CSS.textAlignAll(`end_);
  CSS.textAlignAll(`left);
  CSS.textAlignAll(`right);
  CSS.textAlignAll(`center);
  CSS.textAlignAll(`justify);
  CSS.textAlignAll(`matchParent);
  CSS.textAlignLast(`auto);
  CSS.textAlignLast(`start);
  CSS.textAlignLast(`end_);
  CSS.textAlignLast(`left);
  CSS.textAlignLast(`right);
  CSS.textAlignLast(`center);
  CSS.textAlignLast(`justify);
  CSS.textAlignLast(`matchParent);
  CSS.textJustify(`auto);
  CSS.textJustify(`none);
  CSS.textJustify(`interWord);
  CSS.textJustify(`interCharacter);
  CSS.wordSpacing(`percent(50.));
  CSS.textIndent(
    `value(CSS.Types.Length.toString(`em(1.)) ++ {js| hanging|js}),
  );
  CSS.textIndent(
    `value(CSS.Types.Length.toString(`em(1.)) ++ {js| each-line|js}),
  );
  CSS.textIndent(
    `value(CSS.Types.Length.toString(`em(1.)) ++ {js| hanging each-line|js}),
  );
  CSS.hangingPunctuation(`none);
  CSS.hangingPunctuation(`first);
  CSS.hangingPunctuation(`last);
  CSS.hangingPunctuation(`forceEnd);
  CSS.hangingPunctuation(`allowEnd);
  CSS.hangingPunctuation(`value({js|first last|js}));
  CSS.hangingPunctuation(`value({js|first force-end|js}));
  CSS.hangingPunctuation(`value({js|first force-end last|js}));
  CSS.hangingPunctuation(`value({js|first allow-end last|js}));
  
  CSS.hyphenateCharacter(`auto);
  CSS.hyphenateLimitZone(`percent(1.));
  CSS.hyphenateLimitZone(`em(1.));
  CSS.hyphenateLimitChars(`auto);
  CSS.hyphenateLimitChars(`count(5));
  
  CSS.hyphenateLimitLines(`noLimit);
  CSS.hyphenateLimitLines(`int(2));
