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
  /* CSS Values and Units Module Level 3 */
  [%css {|width: 5rem;|}];
  [%css {|width: 5ch;|}];
  [%css {|width: 5vw;|}];
  [%css {|width: 5vh;|}];
  [%css {|width: 5vmin;|}];
  [%css {|width: 5vmax;|}];
  /* [%css {|width: 5q;|}]; */
  /* [%css {|width: attr(data-px);|}]; */
  /* [%css {|width: attr(data-px px);|}]; */
  /* [%css {|width: attr(data-px px, initial);|}]; */
  [%css {|width: calc(1px + 2px);|}];
  [%css {|width: calc(5px*2);|}];
  [%css {|width: calc(5px/2);|}];
  /* [%css {|width: calc(100%/3 - 2*1em - 2*1px);|}]; */
  /* [%css {|width: calc(attr(data-px)*2);|}]; */
  [%css {|width: calc(5px - 10px);|}];
  [%css {|width: calc(1vw - 1px);|}];
  [%css {|width: calc(100%);|}];
  [%css {|padding: 5rem;|}];
  [%css {|padding: 5ch;|}];
  [%css {|padding: 5vw;|}];
  [%css {|padding: 5vh;|}];
  [%css {|padding: 5vmin;|}];
  [%css {|padding: 5vmax;|}];
  /* [%css {|padding: 5q;|}]; */
  /* [%css {|padding: attr(data-px);|}]; */
  /* [%css {|padding: attr(data-px px);|}]; */
  /* [%css {|padding: attr(data-px px, initial);|}]; */
  /* [%css {|padding: calc(1px + 2px);|}]; */
  /* [%css {|padding: calc(5px*2);|}]; */
  /* [%css {|padding: calc(5px/2);|}]; */
  /* [%css {|padding: calc(100%/3 - 2*1em - 2*1px);|}]; */
  /* [%css {|padding: calc(attr(data-px)*2);|}]; */
  /* [%css {|padding: calc(5px - 10px);|}]; */
  /* [%css {|padding: calc(1vw - 1px);|}]; */
  /* [%css {|padding: calc(calc(100%));|}]; */
  
  /* CSS Values and Units Module Level 4 */
  /* [%css {|width: toggle(1px, 2px);|}]; */
  /* [%css {|width: min(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|width: max(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|width: clamp(12px, 10 * (1vw + 1vh) / 2, 100px);|}]; */
  /* [%css {|padding: toggle(1px, 2px);|}]; */
  /* [%css {|padding: min(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|padding: max(10 * (1vw + 1vh) / 2, 12px);|}]; */
  /* [%css {|padding: clamp(12px, 10 * (1vw + 1vh) / 2, 100px);|}]; */

  $ dune build
  File "input.re", line 1, characters 0-5:
  Error: This expression has type
           [> `calc of
                [> `mult of Css_AtomicTypes.Length.t * [> `one of float ] ] ]
         but an expression was expected of type
           [< `auto
            | `calc of
                [ `add of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
                | `mult of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t
                | `one of Css_AtomicTypes.Length.t
                | `sub of Css_AtomicTypes.Length.t * Css_AtomicTypes.Length.t ]
            | `ch of float
            | `cm of float
            | `em of float
            | `ex of float
            | `fitContent
            | `inch of float
            | `inherit_
            | `initial
            | `maxContent
            | `minContent
            | `mm of float
            | `pc of float
            | `percent of float
            | `pt of int
            | `px of int
            | `pxFloat of float
            | `rem of float
            | `revert
            | `revertLayer
            | `unset
            | `var of string
            | `varDefault of string * string
            | `vh of float
            | `vmax of float
            | `vmin of float
            | `vw of float
            | `zero ]
         Type [> `one of float ] is not compatible with type
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
         The second variant type does not allow tag(s) `one
  [1]
