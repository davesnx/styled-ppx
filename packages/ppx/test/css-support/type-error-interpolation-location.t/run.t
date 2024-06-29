This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "input.re", line 11, characters 21-29:
  Error: This expression has type [> `underlin ]
         but an expression was expected of type
           [< `inherit_
            | `initial
            | `lineThrough
            | `none
            | `overline
            | `underline
            | `unset
            | `var of string
            | `varDefault of string * string ]
         The second variant type does not allow tag(s) `underlin
  [1]
