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

  $ dune describe pp input.re
  /* CSS Lists Module Level 3 */
  [%css {|list-style-type: disclosure-closed|}];
  [%css {|list-style-type: disclosure-open|}];
  [%css {|list-style-type: hebrew|}];
  [%css {|list-style-type: cjk-decimal|}];
  [%css {|list-style-type: cjk-ideographic|}];
  [%css {|list-style-type: hiragana|}];
  [%css {|list-style-type: katakana|}];
  [%css {|list-style-type: hiragana-iroha|}];
  [%css {|list-style-type: katakana-iroha|}];
  [%css {|list-style-type: japanese-informal|}];
  [%css {|list-style-type: japanese-formal|}];
  [%css {|list-style-type: korean-hangul-formal|}];
  [%css {|list-style-type: korean-hanja-informal|}];
  [%css {|list-style-type: korean-hanja-formal|}];
  [%css {|list-style-type: simp-chinese-informal|}];
  [%css {|list-style-type: simp-chinese-formal|}];
  [%css {|list-style-type: trad-chinese-informal|}];
  [%css {|list-style-type: trad-chinese-formal|}];
  [%css {|list-style-type: cjk-heavenly-stem|}];
  [%css {|list-style-type: cjk-earthly-branch|}];
  [%css {|list-style-type: trad-chinese-informal|}];
  [%css {|list-style-type: trad-chinese-formal|}];
  [%css {|list-style-type: simp-chinese-informal|}];
  [%css {|list-style-type: simp-chinese-formal|}];
  [%css {|list-style-type: japanese-informal|}];
  [%css {|list-style-type: japanese-formal|}];
  [%css {|list-style-type: arabic-indic|}];
  [%css {|list-style-type: persian|}];
  [%css {|list-style-type: urdu|}];
  [%css {|list-style-type: devanagari|}];
  [%css {|list-style-type: gurmukhi|}];
  [%css {|list-style-type: gujarati|}];
  [%css {|list-style-type: oriya|}];
  [%css {|list-style-type: kannada|}];
  [%css {|list-style-type: malayalam|}];
  [%css {|list-style-type: bengali|}];
  [%css {|list-style-type: tamil|}];
  [%css {|list-style-type: telugu|}];
  [%css {|list-style-type: thai|}];
  [%css {|list-style-type: lao|}];
  [%css {|list-style-type: myanmar|}];
  [%css {|list-style-type: khmer|}];
  [%css {|list-style-type: hangul|}];
  [%css {|list-style-type: hangul-consonant|}];
  [%css {|list-style-type: ethiopic-halehame|}];
  [%css {|list-style-type: ethiopic-numeric|}];
  [%css {|list-style-type: ethiopic-halehame-am|}];
  [%css {|list-style-type: ethiopic-halehame-ti-er|}];
  [%css {|list-style-type: ethiopic-halehame-ti-et|}];
  [%css {|list-style-type: other-style|}];
  [%css {|list-style-type: inside|}];
  [%css {|list-style-type: outside|}];
  [%css {|list-style-type: \32 style|}];
  [%css {|list-style-type: "-"|}];
  [%css {|list-style-type: '-'|}];
  /* [%css {|list-style-type: symbols("*" "\2020" "\2021" "\A7")|}]; */
  /* [%css {|list-style-type: symbols(cyclic '*' '\2020' '\2021' '\A7')|}]; */
  /* [%css {|marker-side: match-self|}]; */
  /* [%css {|marker-side: match-parent|}]; */
  [%css {|counter-reset: foo|}];
  [%css {|counter-reset: foo 1|}];
  [%css {|counter-reset: foo 1 bar|}];
  [%css {|counter-reset: foo 1 bar 2|}];
  [%css {|counter-reset: none|}];
  [%css {|counter-set: foo|}];
  [%css {|counter-set: foo 1|}];
  [%css {|counter-set: foo 1 bar|}];
  [%css {|counter-set: foo 1 bar 2|}];
  [%css {|counter-set: none|}];
  [%css {|counter-increment: foo|}];
  [%css {|counter-increment: foo 1|}];
  [%css {|counter-increment: foo 1 bar|}];
  [%css {|counter-increment: foo 1 bar 2|}];
  [%css {|counter-increment: none|}];
  /* [%css {|content: counter(chno, upper-latin) '. '|}]; */
  /* [%css {|content: counter(section, upper-roman) ' - '|}]; */
  /* [%css {|content: ' [' counter(bq, decimal) ']'|}]; */
  /* [%css {|content: counter(notecntr, disc) ' '|}]; */
  /* [%css {|content: counter(p, none)|}]; */
  /* [%css {|content: counter(h1, upper-alpha) '.' counter(h2, decimal) ' '|}]; */
  /* [%css {|content: '(' counters(list-item, '.') ') '|}]; */

  $ dune build
