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
  /* CSS Text Module Level 3 */
  [%css {|text-transform: full-width|}];
  [%css {|text-transform: full-size-kana|}];
  /* [%css {|text-transform: capitalize full-width|}]; */
  /* [%css {|text-transform: capitalize full-width full-size-kana|}]; */
  [%css {|tab-size: 4|}];
  [%css {|tab-size: 1em|}];
  [%css {|line-break: auto|}];
  [%css {|line-break: loose|}];
  [%css {|line-break: normal|}];
  [%css {|line-break: strict|}];
  [%css {|line-break: anywhere|}];
  [%css {|word-break: normal|}];
  [%css {|word-break: keep-all|}];
  [%css {|word-break: break-all|}];
  [%css {|white-space: break-spaces|}];
  [%css {|hyphens: auto|}];
  [%css {|hyphens: manual|}];
  [%css {|hyphens: none|}];
  [%css {|overflow-wrap: normal|}];
  [%css {|overflow-wrap: break-word|}];
  [%css {|overflow-wrap: anywhere|}];
  [%css {|word-wrap: normal|}];
  [%css {|word-wrap: break-word|}];
  [%css {|word-wrap: anywhere|}];
  [%css {|text-align: start|}];
  [%css {|text-align: end|}];
  [%css {|text-align: left|}];
  [%css {|text-align: right|}];
  [%css {|text-align: center|}];
  [%css {|text-align: justify|}];
  [%css {|text-align: match-parent|}];
  [%css {|text-align: justify-all|}];
  [%css {|text-align-all: start|}];
  [%css {|text-align-all: end|}];
  [%css {|text-align-all: left|}];
  [%css {|text-align-all: right|}];
  [%css {|text-align-all: center|}];
  [%css {|text-align-all: justify|}];
  [%css {|text-align-all: match-parent|}];
  [%css {|text-align-last: auto|}];
  [%css {|text-align-last: start|}];
  [%css {|text-align-last: end|}];
  [%css {|text-align-last: left|}];
  [%css {|text-align-last: right|}];
  [%css {|text-align-last: center|}];
  [%css {|text-align-last: justify|}];
  [%css {|text-align-last: match-parent|}];
  [%css {|text-justify: auto|}];
  [%css {|text-justify: none|}];
  [%css {|text-justify: inter-word|}];
  [%css {|text-justify: inter-character|}];
  [%css {|word-spacing: 50%|}];
  [%css {|text-indent: 1em hanging|}];
  [%css {|text-indent: 1em each-line|}];
  [%css {|text-indent: 1em hanging each-line|}];
  [%css {|hanging-punctuation: none|}];
  [%css {|hanging-punctuation: first|}];
  [%css {|hanging-punctuation: last|}];
  [%css {|hanging-punctuation: force-end|}];
  [%css {|hanging-punctuation: allow-end|}];
  [%css {|hanging-punctuation: first last|}];
  [%css {|hanging-punctuation: first force-end|}];
  [%css {|hanging-punctuation: first force-end last|}];
  [%css {|hanging-punctuation: first allow-end last|}];
  
  /* CSS Text Module Level 4 */
  /* [%css {|text-space-collapse: collapse|}]; */
  /* [%css {|text-space-collapse: discard|}]; */
  /* [%css {|text-space-collapse: preserve|}]; */
  /* [%css {|text-space-collapse: preserve-breaks|}]; */
  /* [%css {|text-space-collapse: preserve-spaces|}]; */
  /* [%css {|text-space-trim: none|}]; */
  /* [%css {|text-space-trim: trim-inner|}]; */
  /* [%css {|text-space-trim:  discard-before|}]; */
  /* [%css {|text-space-trim: discard-after|}]; */
  /* [%css {|text-space-trim: trim-inner discard-before|}]; */
  /* [%css {|text-space-trim: trim-inner discard-before discard-after|}]; */
  /* [%css {|text-wrap: wrap|}]; */
  /* [%css {|text-wrap: nowrap|}]; */
  /* [%css {|text-wrap: balance |}]; */
  /* [%css {|wrap-before: auto|}]; */
  /* [%css {|wrap-before: avoid|}]; */
  /* [%css {|wrap-before: avoid-line|}]; */
  /* [%css {|wrap-before: avoid-flex|}]; */
  /* [%css {|wrap-before: line|}]; */
  /* [%css {|wrap-before: flex|}]; */
  /* [%css {|wrap-after: auto|}]; */
  /* [%css {|wrap-after: avoid|}]; */
  /* [%css {|wrap-after: avoid-line|}]; */
  /* [%css {|wrap-after: avoid-flex|}]; */
  /* [%css {|wrap-after: line|}]; */
  /* [%css {|wrap-after: flex|}]; */
  /* [%css {|wrap-inside: auto|}]; */
  /* [%css {|wrap-inside: avoid|}]; */
  /* [%css {|hyphenate-character: auto|}]; */
  /* [%css {|hyphenate-limit-zone: 1%|}]; */
  /* [%css {|hyphenate-limit-zone: 1em|}]; */
  /* [%css {|hyphenate-limit-chars: auto|}]; */
  /* [%css {|hyphenate-limit-chars: 5|}]; */
  /* [%css {|hyphenate-limit-chars: auto 3|}]; */
  /* [%css {|hyphenate-limit-chars: 5 4 3|}]; */
  /* [%css {|hyphenate-limit-lines: no-limit|}]; */
  /* [%css {|hyphenate-limit-lines: 2|}]; */
  /* [%css {|hyphenate-limit-last: none|}]; */
  /* [%css {|hyphenate-limit-last: always|}]; */
  /* [%css {|hyphenate-limit-last: column|}]; */
  /* [%css {|hyphenate-limit-last: page|}]; */
  /* [%css {|hyphenate-limit-last: spread|}]; */

  $ dune build
  File "input.re", line 1, characters 13-29:
  Error: This expression has type [> `InterCharacter ]
         but an expression was expected of type
           [< `auto
            | `inherit_
            | `initial
            | `interCharacter
            | `interWord
            | `none
            | `revert
            | `revertLayer
            | `unset
            | `var of string
            | `varDefault of string * string ]
         The second variant type does not allow tag(s) `InterCharacter
  [1]
