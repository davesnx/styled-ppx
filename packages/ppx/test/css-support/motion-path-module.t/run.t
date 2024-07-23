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
  
  CSS.unsafe({js|offset|js}, {js|none|js});
  CSS.unsafe({js|offset|js}, {js|auto|js});
  CSS.unsafe({js|offset|js}, {js|center|js});
  CSS.unsafe({js|offset|js}, {js|200px 100px|js});
  
  CSS.unsafe({js|offset|js}, {js|margin-box|js});
  CSS.unsafe({js|offset|js}, {js|border-box|js});
  CSS.unsafe({js|offset|js}, {js|padding-box|js});
  CSS.unsafe({js|offset|js}, {js|content-box|js});
  CSS.unsafe({js|offset|js}, {js|fill-box|js});
  CSS.unsafe({js|offset|js}, {js|stroke-box|js});
  CSS.unsafe({js|offset|js}, {js|view-box|js});
  
  CSS.unsafe({js|offset|js}, {js|path('M 20 20 H 80 V 30')|js});
  CSS.unsafe({js|offset|js}, {js|url(image.png)|js});
  CSS.unsafe({js|offset|js}, {js|ray(45deg closest-side)|js});
  CSS.unsafe({js|offset|js}, {js|ray(45deg closest-side) 10%|js});
  CSS.unsafe({js|offset|js}, {js|ray(45deg closest-side) 10% reverse|js});
  
  CSS.unsafe({js|offset|js}, {js|ray(45deg closest-side) reverse 10%|js});
  
  CSS.unsafe({js|offset|js}, {js|auto / center|js});
  CSS.unsafe({js|offset|js}, {js|center / 200px 100px|js});
  CSS.unsafe({js|offset|js}, {js|ray(45deg closest-side) / 200px 100px|js});
  
  CSS.unsafe({js|offsetPath|js}, {js|none|js});
  CSS.unsafe({js|offsetPath|js}, {js|ray(45deg closest-side)|js});
  CSS.unsafe({js|offsetPath|js}, {js|ray(45deg farthest-side)|js});
  CSS.unsafe({js|offsetPath|js}, {js|ray(45deg closest-corner)|js});
  CSS.unsafe({js|offsetPath|js}, {js|ray(45deg farthest-corner)|js});
  
  CSS.unsafe({js|offsetPath|js}, {js|ray(100grad closest-side contain)|js});
  
  CSS.unsafe({js|offsetPath|js}, {js|margin-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|border-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|padding-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|content-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|fill-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|stroke-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|view-box|js});
  CSS.unsafe({js|offsetPath|js}, {js|circle(60%) margin-box|js});
  
  CSS.unsafe({js|offsetDistance|js}, {js|10%|js});
  CSS.unsafe({js|offsetPosition|js}, {js|auto|js});
  CSS.unsafe({js|offsetPosition|js}, {js|200px|js});
  CSS.unsafe({js|offsetPosition|js}, {js|200px 100px|js});
  CSS.unsafe({js|offsetPosition|js}, {js|center|js});
  CSS.unsafe({js|offsetAnchor|js}, {js|auto|js});
  CSS.unsafe({js|offsetAnchor|js}, {js|200px|js});
  CSS.unsafe({js|offsetAnchor|js}, {js|200px 100px|js});
  CSS.unsafe({js|offsetAnchor|js}, {js|center|js});
  CSS.unsafe({js|offsetRotate|js}, {js|auto|js});
  CSS.unsafe({js|offsetRotate|js}, {js|0deg|js});
  CSS.unsafe({js|offsetRotate|js}, {js|reverse|js});
  CSS.unsafe({js|offsetRotate|js}, {js|-45deg|js});
  CSS.unsafe({js|offsetRotate|js}, {js|auto 180deg|js});
  CSS.unsafe({js|offsetRotate|js}, {js|reverse 45deg|js});
  CSS.unsafe({js|offsetRotate|js}, {js|2turn reverse|js});
