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
  /*Motion Path Module Level 1*/
  [%css {|offset: none|}];
  [%css {|offset: auto|}];
  [%css {|offset: center|}];
  [%css {|offset: 200px 100px|}];
  /* [%css {|offset: inset(10% round 10% 40% 10% 40%)|}]; */
  /* [%css {|offset: ellipse(at top 50% left 20%)|}]; */
  /* [%css {|offset: circle(at right 5% top)|}]; */
  [%css {|offset: margin-box|}];
  [%css {|offset: border-box|}];
  [%css {|offset: padding-box|}];
  [%css {|offset: content-box|}];
  [%css {|offset: fill-box|}];
  [%css {|offset: stroke-box|}];
  [%css {|offset: view-box|}];
  /* [%css {|offset: polygon(100% 0, 100% 100%, 0 100%)|}]; */
  [%css {|offset: path('M 20 20 H 80 V 30')|}];
  [%css {|offset: url(image.png)|}];
  [%css {|offset: ray(45deg closest-side)|}];
  [%css {|offset: ray(45deg closest-side) 10%|}];
  [%css {|offset: ray(45deg closest-side) 10% reverse|}];
  /* [%css {|offset: ray(45deg closest-side) 10% reverse 45deg|}]; */
  /* [%css {|offset: ray(45deg closest-side) 10% 45deg reverse|}]; */
  /* [%css {|offset: ray(45deg closest-side) 45deg 10%|}]; */
  /* [%css {|offset: ray(45deg closest-side) 45deg reverse 10%|}]; */
  [%css {|offset: ray(45deg closest-side) reverse 10%|}];
  /* [%css {|offset: 200px 100px ray(45deg closest-side)|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10%|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% reverse|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% reverse 45deg|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% 45deg reverse|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 45deg 10%|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 45deg reverse 10%|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) reverse 10%|}]; */
  [%css {|offset: auto / center|}];
  [%css {|offset: center / 200px 100px|}];
  [%css {|offset: ray(45deg closest-side) / 200px 100px|}];
  /* [%css {|offset: ray(45deg closest-side) 10% / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) 10% reverse / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) 10% reverse 45deg / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) 10% 45deg reverse / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) 45deg 10% / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) 45deg reverse 10% / 200px 100px|}]; */
  /* [%css {|offset: ray(45deg closest-side) reverse 10% / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% reverse / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% reverse 45deg / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 10% 45deg reverse / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 45deg 10% / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) 45deg reverse 10% / 200px 100px|}]; */
  /* [%css {|offset: 200px 100px ray(45deg closest-side) reverse 10% / 200px 100px|}]; */
  [%css {|offset-path: none|}];
  [%css {|offset-path: ray(45deg closest-side)|}];
  [%css {|offset-path: ray(45deg farthest-side)|}];
  [%css {|offset-path: ray(45deg closest-corner)|}];
  [%css {|offset-path: ray(45deg farthest-corner)|}];
  /* [%css {|offset-path: ray(45deg sides)|}]; */
  /* [%css {|offset-path: ray(0.25turn sides contain)|}]; */
  [%css {|offset-path: ray(100grad closest-side contain)|}];
  /* [%css {|offset-path: ray(calc(180deg - 0.25turn) closest-side)|}]; */
  /* [%css {|offset-path: inset(10% round 10% 40% 10% 40%)|}]; */
  /* [%css {|offset-path: ellipse(at top 50% left 20%)|}]; */
  /* [%css {|offset-path: circle(at right 5% top)|}]; */
  [%css {|offset-path: margin-box|}];
  [%css {|offset-path: border-box|}];
  [%css {|offset-path: padding-box|}];
  [%css {|offset-path: content-box|}];
  [%css {|offset-path: fill-box|}];
  [%css {|offset-path: stroke-box|}];
  [%css {|offset-path: view-box|}];
  [%css {|offset-path: circle(60%) margin-box|}];
  /* [%css {|offset-path: polygon(100% 0, 100% 100%, 0 100%)|}]; */
  /* [%css {|offset-path: path('M 20 20 H 80 V 30')|}]; */
  /* [%css {|offset-path: url(image.png)|}]; */
  /* [%css {|offset-path: url(#id)|}]; */
  [%css {|offset-distance: 10%|}];
  [%css {|offset-position: auto|}];
  [%css {|offset-position: 200px|}];
  [%css {|offset-position: 200px 100px|}];
  [%css {|offset-position: center|}];
  [%css {|offset-anchor: auto|}];
  [%css {|offset-anchor: 200px|}];
  [%css {|offset-anchor: 200px 100px|}];
  [%css {|offset-anchor: center|}];
  [%css {|offset-rotate: auto|}];
  [%css {|offset-rotate: 0deg|}];
  [%css {|offset-rotate: reverse|}];
  [%css {|offset-rotate: -45deg|}];
  [%css {|offset-rotate: auto 180deg|}];
  [%css {|offset-rotate: reverse 45deg|}];
  [%css {|offset-rotate: 2turn reverse|}];

  $ dune build
