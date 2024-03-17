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
  /* CSS Transforms Module Level 1 */
  [%css {|transform: none|}];
  [%css {|transform: translate(5px)|}];
  [%css {|transform: translate(5px, 10px)|}];
  [%css {|transform: translateY(5px)|}];
  [%css {|transform: translateX(5px)|}];
  [%css {|transform: translateY(5%)|}];
  [%css {|transform: translateX(5%)|}];
  [%css {|transform: scale(2)|}];
  [%css {|transform: scale(2, -1)|}];
  [%css {|transform: scaleX(2)|}];
  [%css {|transform: scaleY(2.5)|}];
  [%css {|transform: rotate(45deg)|}];
  [%css {|transform: skew(45deg)|}];
  [%css {|transform: skew(45deg, 15deg)|}];
  [%css {|transform: skewX(45deg)|}];
  [%css {|transform: skewY(45deg)|}];
  // [%css {|transform: matrix(1,-.2,0,1,0,0)|}];
  // [%css {|transform: matrix(1,-.2,0,1,10,10)|}];
  [%css {|transform: translate(50px, -24px) skew(0, 22.5deg)|}];
  [%css {|transform: translate3d(0, 0, 5px)|}];
  [%css {|transform: translateZ(5px)|}];
  [%css {|transform: scale3d(1, 0, -1)|}];
  [%css {|transform: scaleZ(1.5)|}];
  [%css {|transform: rotate3d(1, 1, 1, 45deg)|}];
  [%css {|transform: rotateX(-45deg)|}];
  [%css {|transform: rotateY(-45deg)|}];
  [%css {|transform: rotateZ(-45deg)|}];
  // [%css {|transform: matrix3d(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)|}];
  // [%css {|transform: matrix3d(0,0,0,0,0,0,0,0,0,0,1,0,10,10,0,1)|}];
  [%css
    {|transform: translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, .5)|}
  ];
  [%css {|transform: perspective(600px)|}];
  [%css {|transform-origin: 10px|}];
  [%css {|transform-origin: top|}];
  [%css {|transform-origin: top left|}];
  [%css {|transform-origin: 50% 100%|}];
  [%css {|transform-origin: left 0%|}];
  [%css {|transform-origin: left 50% 0|}];
  [%css {|transform-box: border-box|}];
  [%css {|transform-box: fill-box|}];
  [%css {|transform-box: view-box|}];
  [%css {|transform-box: content-box|}];
  [%css {|transform-box: stroke-box|}];
  
  /* CSS Transforms Module Level 2 */
  [%css {|translate: none|}];
  [%css {|translate: 50%|}];
  [%css {|translate: 50% 50%|}];
  [%css {|translate: 50% 50% 10px|}];
  [%css {|scale: none|}];
  [%css {|scale: 2|}];
  [%css {|scale: 2 2|}];
  [%css {|scale: 2 2 2|}];
  [%css {|rotate: none|}];
  [%css {|rotate:  45deg|}];
  [%css {|rotate: x 45deg|}];
  [%css {|rotate: y 45deg|}];
  [%css {|rotate: z 45deg|}];
  [%css {|rotate: -1 0 2 45deg|}];
  [%css {|rotate: 45deg x|}];
  [%css {|rotate: 45deg y|}];
  [%css {|rotate: 45deg z|}];
  [%css {|rotate: 45deg -1 0 2|}];
  [%css {|transform-style: flat|}];
  [%css {|transform-style: preserve-3d|}];
  [%css {|perspective: none|}];
  [%css {|perspective: 600px|}];
  [%css {|perspective-origin: 10px|}];
  [%css {|perspective-origin: top|}];
  [%css {|perspective-origin: top left|}];
  [%css {|perspective-origin: 50% 100%|}];
  [%css {|perspective-origin: left 0%|}];
  [%css {|backface-visibility: visible|}];
  [%css {|backface-visibility: hidden|}];

  $ dune build
  File "input.re", line 1, characters 10-25:
  Error: This expression has type
           [> `translate of Css_AtomicTypes.Length.t * int ]
         but an expression was expected of type
           [< `none
            | `perspective of int
            | `rotate of Css_AtomicTypes.Angle.t
            | `rotate3d of float * float * float * Css_AtomicTypes.Angle.t
            | `rotateX of Css_AtomicTypes.Angle.t
            | `rotateY of Css_AtomicTypes.Angle.t
            | `rotateZ of Css_AtomicTypes.Angle.t
            | `scale of float * float
            | `scale3d of float * float * float
            | `scaleX of float
            | `scaleY of float
            | `scaleZ of float
            | `skew of Css_AtomicTypes.Angle.t * Css_AtomicTypes.Angle.t
            | `skewX of Css_AtomicTypes.Angle.t
            | `skewY of Css_AtomicTypes.Angle.t
            | `translate of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
            | `translate3d of
                Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t *
                Css_AtomicTypes.Length.t
            | `translateX of Css_AtomicTypes.Length.t
            | `translateY of Css_AtomicTypes.Length.t
            | `translateZ of Css_AtomicTypes.Length.t ]
         Type int is not compatible with type
           Css_AtomicTypes.Length.t =
             [ `calc of
                 [ `add of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
                 | `mult of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
                 | `one of Css_AtomicTypes.Length.t
                 | `sub of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
                 ]
             | `ch of float
             | `cm of float
             | `em of float
             | `ex of float
             | `inch of float
             | `mm of float
             | `pc of float
             | `percent of float
             | `pt of int
             | `px of int
             | `pxFloat of float
             | `rem of float
             | `vh of float
             | `vmax of float
             | `vmin of float
             | `vw of float
             | `zero ]
         Types for tag `translate are incompatible
  [1]
