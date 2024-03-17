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
  /* Filter Effects Module Level 1 */
  [%css {|filter: none|}];
  [%css {|filter: url(#id)|}];
  [%css {|filter: url(image.svg#id)|}];
  [%css {|filter: blur(5px)|}];
  [%css {|filter: brightness(0.5)|}];
  [%css {|filter: contrast(150%)|}];
  [%css {|filter: drop-shadow(15px 15px 15px black)|}];
  [%css {|filter: grayscale(50%)|}];
  [%css {|filter: hue-rotate(50deg)|}];
  [%css {|filter: invert(50%)|}];
  [%css {|filter: opacity(50%)|}];
  [%css {|filter: sepia(50%)|}];
  [%css {|filter: saturate(150%)|}];
  [%css {|filter: grayscale(100%) sepia(100%)|}];
  [%css {|filter:
      drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));|}];
  [%css
    {|filter:
      drop-shadow(0 1px 0 $(DropShadowFilter.dropShadowTop))
      drop-shadow(0 1px 0 $(DropShadowFilter.dropShadowMiddle))
      drop-shadow(0 1px 0 $(DropShadowFilter.dropShadowBottom))
      drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075))
      drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));|}
  ];
  
  /* Filter Effects Module Level 2 */
  [%css {|backdrop-filter: none|}];
  [%css {|backdrop-filter: url(#id)|}];
  [%css {|backdrop-filter: url(image.svg#id)|}];
  [%css {|backdrop-filter: blur(5px)|}];
  [%css {|backdrop-filter: brightness(0.5)|}];
  [%css {|backdrop-filter: contrast(150%)|}];
  [%css {|backdrop-filter: drop-shadow(15px 15px 15px black)|}];
  [%css {|backdrop-filter: grayscale(50%)|}];
  [%css {|backdrop-filter: hue-rotate(50deg)|}];
  [%css {|backdrop-filter: invert(50%)|}];
  [%css {|backdrop-filter: opacity(50%)|}];
  [%css {|backdrop-filter: sepia(50%)|}];
  [%css {|backdrop-filter: saturate(150%)|}];
  [%css {|backdrop-filter: grayscale(100%) sepia(100%)|}];

  $ dune build
  File "input.re", line 1, characters 0-6:
  Error: This expression has type [> `contrast of [> `percent of float ] ]
         but an expression was expected of type
           [< `blur of
                [< `calc of
                     [< `add of 'a * 'a
                      | `mult of 'a * 'a
                      | `one of 'a
                      | `sub of 'a * 'a ]
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
                as 'a
            | `brightness of float
            | `contrast of float
            | `dropShadow of
                ([< `calc of
                      [< `add of 'a0 * 'a0
                       | `mult of 'a0 * 'a0
                       | `one of 'a0
                       | `sub of 'a0 * 'a0 ]
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
                 as 'a0) *
                ([< `calc of
                      [< `add of 'a1 * 'a1
                       | `mult of 'a1 * 'a1
                       | `one of 'a1
                       | `sub of 'a1 * 'a1 ]
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
                 as 'a1) *
                ([< `calc of
                      [< `add of 'a2 * 'a2
                       | `mult of 'a2 * 'a2
                       | `one of 'a2
                       | `sub of 'a2 * 'a2 ]
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
                 as 'a2) *
                [< `colorMix of
                     Css_AtomicTypes.ColorMixMethod.t *
                     (Css_AtomicTypes.Color.t * Css_AtomicTypes.Percentage.t) *
                     (Css_AtomicTypes.Color.t * Css_AtomicTypes.Percentage.t)
                 | `currentColor
                 | `hex of string
                 | `hsl of
                     Css_AtomicTypes.Angle.t * Css_AtomicTypes.Percentage.t *
                     Css_AtomicTypes.Percentage.t
                 | `hsla of
                     Css_AtomicTypes.Angle.t * Css_AtomicTypes.Percentage.t *
                     Css_AtomicTypes.Percentage.t *
                     [ `num of float | `percent of float ]
                 | `rgb of int * int * int
                 | `rgba of
                     int * int * int * [ `num of float | `percent of float ]
                 | `transparent
                 | `var of string
                 | `varDefault of string * string ]
            | `grayscale of float
            | `hueRotate of
                [< `deg of float
                 | `grad of float
                 | `rad of float
                 | `turn of float ]
            | `inherit_
            | `initial
            | `invert of float
            | `none
            | `opacity of float
            | `revert
            | `revertLayer
            | `saturate of float
            | `sepia of float
            | `unset
            | `url of string
            | `var of string
            | `varDefault of string * string ]
         Types for tag `contrast are incompatible
  [1]
