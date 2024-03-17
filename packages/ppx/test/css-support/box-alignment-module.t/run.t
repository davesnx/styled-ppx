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
  /* CSS Box Alignment Module Level 3 */
  [%css {|align-self: auto|}];
  [%css {|align-self: normal|}];
  [%css {|align-self: stretch|}];
  [%css {|align-self: baseline|}];
  [%css {|align-self: first baseline|}];
  [%css {|align-self: last baseline|}];
  [%css {|align-self: center|}];
  [%css {|align-self: start|}];
  [%css {|align-self: end|}];
  [%css {|align-self: self-start|}];
  [%css {|align-self: self-end|}];
  [%css {|align-self: unsafe start|}];
  [%css {|align-self: safe start|}];
  [%css {|align-items: normal|}];
  [%css {|align-items: stretch|}];
  [%css {|align-items: baseline|}];
  [%css {|align-items: first baseline|}];
  [%css {|align-items: last baseline|}];
  [%css {|align-items: center|}];
  [%css {|align-items: start|}];
  [%css {|align-items: end|}];
  [%css {|align-items: self-start|}];
  [%css {|align-items: self-end|}];
  [%css {|align-items: unsafe start|}];
  [%css {|align-items: safe start|}];
  [%css {|align-content: normal|}];
  [%css {|align-content: baseline|}];
  [%css {|align-content: first baseline|}];
  [%css {|align-content: last baseline|}];
  [%css {|align-content: space-between|}];
  [%css {|align-content: space-around|}];
  [%css {|align-content: space-evenly|}];
  [%css {|align-content: stretch|}];
  [%css {|align-content: center|}];
  [%css {|align-content: start|}];
  [%css {|align-content: end|}];
  [%css {|align-content: flex-start|}];
  [%css {|align-content: flex-end|}];
  [%css {|align-content: unsafe start|}];
  [%css {|align-content: safe start|}];
  [%css {|justify-self: auto|}];
  [%css {|justify-self: normal|}];
  [%css {|justify-self: stretch|}];
  [%css {|justify-self: baseline|}];
  [%css {|justify-self: first baseline|}];
  [%css {|justify-self: last baseline|}];
  [%css {|justify-self: center|}];
  [%css {|justify-self: start|}];
  [%css {|justify-self: end|}];
  [%css {|justify-self: self-start|}];
  [%css {|justify-self: self-end|}];
  [%css {|justify-self: unsafe start|}];
  [%css {|justify-self: safe start|}];
  [%css {|justify-self: left|}];
  [%css {|justify-self: right|}];
  [%css {|justify-self: safe right|}];
  [%css {|justify-items: normal|}];
  [%css {|justify-items: stretch|}];
  [%css {|justify-items: baseline|}];
  [%css {|justify-items: first baseline|}];
  [%css {|justify-items: last baseline|}];
  [%css {|justify-items: center|}];
  [%css {|justify-items: start|}];
  [%css {|justify-items: end|}];
  [%css {|justify-items: self-start|}];
  [%css {|justify-items: self-end|}];
  [%css {|justify-items: unsafe start|}];
  [%css {|justify-items: safe start|}];
  [%css {|justify-items: left|}];
  [%css {|justify-items: right|}];
  [%css {|justify-items: safe right|}];
  [%css {|justify-items: legacy|}];
  [%css {|justify-items: legacy left|}];
  [%css {|justify-items: legacy right|}];
  [%css {|justify-items: legacy center|}];
  [%css {|justify-content: normal|}];
  [%css {|justify-content: space-between|}];
  [%css {|justify-content: space-around|}];
  [%css {|justify-content: space-evenly|}];
  [%css {|justify-content: stretch|}];
  [%css {|justify-content: center|}];
  [%css {|justify-content: start|}];
  [%css {|justify-content: end|}];
  [%css {|justify-content: flex-start|}];
  [%css {|justify-content: flex-end|}];
  [%css {|justify-content: unsafe start|}];
  [%css {|justify-content: safe start|}];
  [%css {|justify-content: left|}];
  [%css {|justify-content: right|}];
  [%css {|justify-content: safe right|}];
  [%css {|place-content: normal|}];
  [%css {|place-content: baseline|}];
  [%css {|place-content: first baseline|}];
  [%css {|place-content: last baseline|}];
  [%css {|place-content: space-between|}];
  [%css {|place-content: space-around|}];
  [%css {|place-content: space-evenly|}];
  [%css {|place-content: stretch|}];
  [%css {|place-content: center|}];
  [%css {|place-content: start|}];
  [%css {|place-content: end|}];
  [%css {|place-content: flex-start|}];
  [%css {|place-content: flex-end|}];
  [%css {|place-content: unsafe start|}];
  [%css {|place-content: safe start|}];
  [%css {|place-content: normal normal|}];
  [%css {|place-content: baseline normal|}];
  [%css {|place-content: first baseline normal|}];
  [%css {|place-content: space-between normal|}];
  [%css {|place-content: center normal|}];
  [%css {|place-content: unsafe start normal|}];
  [%css {|place-content: normal stretch|}];
  [%css {|place-content: baseline stretch|}];
  [%css {|place-content: first baseline stretch|}];
  [%css {|place-content: space-between stretch|}];
  [%css {|place-content: center stretch|}];
  [%css {|place-content: unsafe start stretch|}];
  [%css {|place-content: normal safe right|}];
  [%css {|place-content: baseline safe right|}];
  [%css {|place-content: first baseline safe right|}];
  [%css {|place-content: space-between safe right|}];
  [%css {|place-content: center safe right|}];
  [%css {|place-content: unsafe start safe right|}];
  [%css {|place-items: normal|}];
  [%css {|place-items: stretch|}];
  [%css {|place-items: baseline|}];
  [%css {|place-items: first baseline|}];
  [%css {|place-items: last baseline|}];
  [%css {|place-items: center|}];
  [%css {|place-items: start|}];
  [%css {|place-items: end|}];
  [%css {|place-items: self-start|}];
  [%css {|place-items: self-end|}];
  [%css {|place-items: unsafe start|}];
  [%css {|place-items: safe start|}];
  [%css {|place-items: normal normal|}];
  [%css {|place-items: stretch normal|}];
  [%css {|place-items: baseline normal|}];
  [%css {|place-items: first baseline normal|}];
  [%css {|place-items: self-start normal|}];
  [%css {|place-items: unsafe start normal|}];
  [%css {|place-items: normal stretch|}];
  [%css {|place-items: stretch stretch|}];
  [%css {|place-items: baseline stretch|}];
  [%css {|place-items: first baseline stretch|}];
  [%css {|place-items: self-start stretch|}];
  [%css {|place-items: unsafe start stretch|}];
  [%css {|place-items: normal last baseline|}];
  [%css {|place-items: stretch last baseline|}];
  [%css {|place-items: baseline last baseline|}];
  [%css {|place-items: first baseline last baseline|}];
  [%css {|place-items: self-start last baseline|}];
  [%css {|place-items: unsafe start last baseline|}];
  [%css {|place-items: normal legacy left|}];
  [%css {|place-items: stretch legacy left|}];
  [%css {|place-items: baseline legacy left|}];
  [%css {|place-items: first baseline legacy left|}];
  [%css {|place-items: self-start legacy left|}];
  [%css {|place-items: unsafe start legacy left|}];
  [%css {|gap: 0 0|}];
  [%css {|gap: 0 1em|}];
  [%css {|gap: 1em|}];
  [%css {|gap: 1em 1em|}];
  [%css {|column-gap: 0|}];
  [%css {|column-gap: 1em|}];
  [%css {|column-gap: normal|}];
  [%css {|row-gap: 0|}];
  [%css {|row-gap: 1em|}];
  
  /* CSS Box Model Module Level 4 */
  [%css {|margin-trim: none|}];
  [%css {|margin-trim: in-flow|}];
  [%css {|margin-trim: all|}];

  $ dune build
  File "input.re", line 1, characters 0-10:
  Error: This expression has type [> `unsafe of [> `start ] ]
         but an expression was expected of type
           [< `auto
            | `baseline
            | `center
            | `end_
            | `firstBaseline
            | `flexEnd
            | `flexStart
            | `inherit_
            | `initial
            | `lastBaseline
            | `left
            | `normal
            | `revert
            | `revertLayer
            | `right
            | `selfEnd
            | `selfStart
            | `start
            | `stretch
            | `unset
            | `var of string
            | `varDefault of string * string ]
         The second variant type does not allow tag(s) `unsafe
  [1]
