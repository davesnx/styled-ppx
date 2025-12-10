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
  [@css
    ".css-rvgufc { transform: none; }\n.css-psdz64 { transform: translate(5px); }\n.css-1qxml79 { transform: translate(5px, 10px); }\n.css-1n726tu { transform: translateY(5px); }\n.css-1ymv1nb { transform: translateX(5px); }\n.css-b59bzf { transform: translateY(5%); }\n.css-263wpj { transform: translateX(5%); }\n.css-v168aj { transform: scale(2); }\n.css-1es540k { transform: scale(2, -1); }\n.css-1dm21d7 { transform: scaleX(2); }\n.css-q2zc7x { transform: scaleY(2.5); }\n.css-xrkpec { transform: rotate(45deg); }\n.css-hwwl22 { transform: skew(45deg); }\n.css-1p4dzz8 { transform: skew(45deg, 15deg); }\n.css-1dwcn19 { transform: skewX(45deg); }\n.css-zd7c4w { transform: skewY(45deg); }\n.css-17kgk27 { transform: translate(50px, -24px) skew(0, 22.5deg); }\n.css-82jkvb { transform: translate3d(0, 0, 5px); }\n.css-lj5k8q { transform: translateZ(5px); }\n.css-6v23gs { transform: scale3d(1, 0, -1); }\n.css-xaolnt { transform: scaleZ(1.5); }\n.css-j119ej { transform: rotate3d(1, 1, 1, 45deg); }\n.css-1n6wxae { transform: rotateX(-45deg); }\n.css-1cfig91 { transform: rotateY(-45deg); }\n.css-6gox3k { transform: rotateZ(-45deg); }\n.css-qe5f4i { transform: perspective(600px); }\n.css-1w3wsmp { transform-origin: 10px; }\n.css-u6bh57 { transform-origin: top; }\n.css-109lamp { transform-origin: top left; }\n.css-l0djar { transform-origin: 50% 100%; }\n.css-1cy2e1v { transform-origin: left 0%; }\n.css-tt5zhg { transform-origin: left 50% 0; }\n.css-1uf2j6y { transform-box: border-box; }\n.css-evwekd { transform-box: fill-box; }\n.css-mx7s1i { transform-box: view-box; }\n.css-z41t2h { transform-box: content-box; }\n.css-ggl8ox { transform-box: stroke-box; }\n.css-1gyqzff { translate: none; }\n.css-199e556 { translate: 50%; }\n.css-1qsbscj { translate: 50% 50%; }\n.css-17if83b { translate: 50% 50% 10px; }\n.css-17hryoj { scale: none; }\n.css-gna23o { scale: 2; }\n.css-kiossf { scale: 2 2; }\n.css-99kl0i { scale: 2 2 2; }\n.css-or9hag { rotate: none; }\n.css-skm1y5 { rotate: 45deg; }\n.css-eiw9y5 { rotate: x 45deg; }\n.css-1t8hgu3 { rotate: y 45deg; }\n.css-4gmc4d { rotate: z 45deg; }\n.css-1am0ye9 { rotate: -1 0 2 45deg; }\n.css-1kyi1la { rotate: 45deg x; }\n.css-ap6n2w { rotate: 45deg y; }\n.css-dro9zg { rotate: 45deg z; }\n.css-isfzw0 { rotate: 45deg -1 0 2; }\n.css-1gsl80z { transform-style: flat; }\n.css-1watsq4 { transform-style: preserve-3d; }\n.css-1q8f747 { perspective: none; }\n.css-1y0p5vc { perspective: 600px; }\n.css-67qfnd { perspective-origin: 10px; }\n.css-1j35tav { perspective-origin: top; }\n.css-ilmezo { perspective-origin: top left; }\n.css-1n1t60y { perspective-origin: 50% 100%; }\n.css-1be9kay { perspective-origin: left 0%; }\n.css-1koryfy { backface-visibility: visible; }\n.css-176v6q6 { backface-visibility: hidden; }\n"
  ];
  CSS.make("css-rvgufc", []);
  CSS.make("css-psdz64", []);
  CSS.make("css-1qxml79", []);
  CSS.make("css-1n726tu", []);
  CSS.make("css-1ymv1nb", []);
  CSS.make("css-b59bzf", []);
  CSS.make("css-263wpj", []);
  CSS.make("css-v168aj", []);
  CSS.make("css-1es540k", []);
  CSS.make("css-1dm21d7", []);
  CSS.make("css-q2zc7x", []);
  CSS.make("css-xrkpec", []);
  CSS.make("css-hwwl22", []);
  CSS.make("css-1p4dzz8", []);
  CSS.make("css-1dwcn19", []);
  CSS.make("css-zd7c4w", []);
  
  CSS.make("css-17kgk27", []);
  CSS.make("css-82jkvb", []);
  CSS.make("css-lj5k8q", []);
  CSS.make("css-6v23gs", []);
  CSS.make("css-xaolnt", []);
  CSS.make("css-j119ej", []);
  CSS.make("css-1n6wxae", []);
  CSS.make("css-1cfig91", []);
  CSS.make("css-6gox3k", []);
  
  CSS.transforms([|
    CSS.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
    CSS.rotate3d(1., 2., 3., `deg(180.)),
    CSS.scale3d(-1., 0., 0.5),
  |]);
  CSS.make("css-qe5f4i", []);
  CSS.make("css-1w3wsmp", []);
  CSS.make("css-u6bh57", []);
  CSS.make("css-109lamp", []);
  CSS.make("css-l0djar", []);
  CSS.make("css-1cy2e1v", []);
  CSS.make("css-tt5zhg", []);
  CSS.make("css-1uf2j6y", []);
  CSS.make("css-evwekd", []);
  CSS.make("css-mx7s1i", []);
  CSS.make("css-z41t2h", []);
  CSS.make("css-ggl8ox", []);
  
  CSS.make("css-1gyqzff", []);
  CSS.make("css-199e556", []);
  CSS.make("css-1qsbscj", []);
  CSS.make("css-17if83b", []);
  CSS.make("css-17hryoj", []);
  CSS.make("css-gna23o", []);
  CSS.make("css-kiossf", []);
  CSS.make("css-99kl0i", []);
  CSS.make("css-or9hag", []);
  CSS.make("css-skm1y5", []);
  CSS.make("css-eiw9y5", []);
  CSS.make("css-1t8hgu3", []);
  CSS.make("css-4gmc4d", []);
  CSS.make("css-1am0ye9", []);
  CSS.make("css-1kyi1la", []);
  CSS.make("css-ap6n2w", []);
  CSS.make("css-dro9zg", []);
  CSS.make("css-isfzw0", []);
  CSS.make("css-1gsl80z", []);
  CSS.make("css-1watsq4", []);
  CSS.make("css-1q8f747", []);
  CSS.make("css-1y0p5vc", []);
  CSS.make("css-67qfnd", []);
  CSS.make("css-1j35tav", []);
  CSS.make("css-ilmezo", []);
  CSS.make("css-1n1t60y", []);
  CSS.make("css-1be9kay", []);
  CSS.make("css-1koryfy", []);
  CSS.make("css-176v6q6", []);
