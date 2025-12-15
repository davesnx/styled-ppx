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
  let color = CSS.hex("333");
  
  CSS.filter([|`none|]);
  CSS.filter([|`url({js|#id|js})|]);
  CSS.filter([|`url({js|image.svg#id|js})|]);
  CSS.filter([|`blur(`pxFloat(5.))|]);
  CSS.filter([|`brightness(`num(0.5))|]);
  CSS.filter([|`contrast(`percent(150.))|]);
  
  CSS.filter([|`dropShadow((`pxFloat(5.), `pxFloat(5.), `pxFloat(10.), `currentColor))|]);
  
  CSS.filter([|`dropShadow((`pxFloat(15.), `pxFloat(15.), `pxFloat(15.), `hex({js|123|js})))|]);
  CSS.filter([|`grayscale(`percent(50.))|]);
  CSS.filter([|`hueRotate(`deg(50.))|]);
  CSS.filter([|`invert(`percent(50.))|]);
  CSS.filter([|`opacity(`percent(50.))|]);
  CSS.filter([|`sepia(`percent(50.))|]);
  CSS.filter([|`saturate(`percent(150.))|]);
  CSS.filter([|`grayscale(`percent(100.)), `sepia(`percent(100.))|]);
  CSS.filter([|`dropShadow((`zero, `pxFloat(8.), `pxFloat(32.), `rgba((0, 0, 0, `num(0.03)))))|]);
  CSS.filter([|
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(32.), `pxFloat(48.), `rgba((0, 0, 0, `num(0.075))))),
    `dropShadow((`zero, `pxFloat(8.), `pxFloat(32.), `rgba((0, 0, 0, `num(0.03))))),
  |]);
  
  CSS.backdropFilter([|`none|]);
  CSS.backdropFilter([|`url({js|#id|js})|]);
  CSS.backdropFilter([|`url({js|image.svg#id|js})|]);
  CSS.backdropFilter([|`blur(`pxFloat(5.))|]);
  CSS.backdropFilter([|`brightness(`num(0.5))|]);
  CSS.backdropFilter([|`contrast(`percent(150.))|]);
  CSS.backdropFilter([|`dropShadow((`pxFloat(15.), `pxFloat(15.), `pxFloat(15.), `rgba((0, 0, 0, `num(1.)))))|]);
  CSS.backdropFilter([|`grayscale(`percent(50.))|]);
  CSS.backdropFilter([|`hueRotate(`deg(50.))|]);
  CSS.backdropFilter([|`invert(`percent(50.))|]);
  CSS.backdropFilter([|`opacity(`percent(50.))|]);
  CSS.backdropFilter([|`sepia(`percent(50.))|]);
  CSS.backdropFilter([|`saturate(`percent(150.))|]);
  CSS.backdropFilter([|`grayscale(`percent(100.)), `sepia(`percent(100.))|]);
