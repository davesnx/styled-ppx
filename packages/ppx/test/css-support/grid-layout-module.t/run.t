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
  /* CSS Grid Layout Module Level 1 */
  [%css {|display: grid|}];
  [%css {|display: inline-grid|}];
  [%css {|grid-template-columns: none|}];
  [%css {|grid-template-columns: auto|}];
  [%css {|grid-template-columns: 100px|}];
  [%css {|grid-template-columns: 1fr|}];
  [%css {|grid-template-columns: 100px 1fr auto|}];
  [%css {|grid-template-columns: repeat(2, 100px 1fr)|}];
  [%css
    {|grid-template-columns: repeat(4, 10px [col-start] 250px [col-end]) 10px|}
  ];
  [%css
    {|grid-template-columns: 100px 1fr max-content minmax(min-content, 1fr)|}
  ];
  [%css {|grid-template-columns: repeat(auto-fill, minmax(25ch, 1fr))|}];
  [%css {|grid-template-columns: 10px [col-start] 250px [col-end]|}];
  [%css
    {|grid-template-columns: [first nav-start] 150px [main-start] 1fr [last]|}
  ];
  [%css
    {|grid-template-columns: 10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px|}
  ];
  [%css
    {|grid-template-columns: [a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto)|}
  ];
  [%css {|grid-template-columns: 200px repeat(auto-fill, 100px) 300px; |}];
  [%css
    {|grid-template-columns: minmax(100px, max-content) repeat(auto-fill, 200px) 20%; |}
  ];
  [%css
    {|grid-template-columns: [linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px; |}
  ];
  
  [%css
    {|grid-template-columns: [linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3]; |}
  ];
  [%css {|grid-template-columns: $(externals)|}];
  [%css {|grid-template-rows: none|}];
  [%css {|grid-template-rows: auto|}];
  [%css {|grid-template-rows: 100px|}];
  [%css {|grid-template-rows: 1fr|}];
  [%css {|grid-template-rows: 100px 1fr auto|}];
  [%css {|grid-template-rows: repeat(2, 100px 1fr)|}];
  [%css {|grid-template-rows: 100px 1fr max-content minmax(min-content, 1fr)|}];
  [%css {|grid-template-rows: 10px [row-start] 250px [row-end]|}];
  [%css
    {|grid-template-rows: [first header-start] 50px [main-start] 1fr [footer-start] 50px [last]|}
  ];
  [%css {|grid-template-areas: none|}];
  [%css {|grid-template-areas: 'articles'|}];
  [%css {|grid-template-areas: 'head head'|}];
  [%css {|grid-template-areas: 'head head' 'nav main' 'foot ....'|}];
  [%css {|grid-template: none|}];
  [%css {|grid-template: auto 1fr auto / auto 1fr|}];
  [%css
    {|grid-template: [header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|}
  ];
  [%css {|grid-auto-columns: auto|}];
  [%css {|grid-auto-columns: 1fr|}];
  [%css {|grid-auto-columns: 100px|}];
  [%css {|grid-auto-columns: max-content|}];
  [%css {|grid-auto-columns: minmax(min-content, 1fr)|}];
  [%css {|grid-auto-columns: min-content max-content auto|}];
  [%css {|grid-auto-columns: 100px 150px 390px|}];
  [%css
    {|grid-auto-columns: 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|}
  ];
  [%css {|grid-auto-rows: auto|}];
  [%css {|grid-auto-rows: 1fr|}];
  [%css {|grid-auto-rows: 100px|}];
  [%css {|grid-auto-rows: 100px 30%|}];
  [%css {|grid-auto-rows: 100px 30% 1em|}];
  [%css {|grid-auto-rows: min-content|}];
  [%css {|grid-auto-rows: minmax(min-content, 1fr)|}];
  [%css {|grid-auto-rows: min-content max-content auto|}];
  [%css
    {|grid-auto-rows: 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|}
  ];
  [%css {|grid-auto-flow: row|}];
  [%css {|grid-auto-flow: column|}];
  [%css {|grid-auto-flow: row dense|}];
  [%css {|grid-auto-flow: column dense|}];
  /* [%css {|grid: auto-flow 1fr / 100px|}]; */
  /* [%css {|grid: none / auto-flow 1fr|}]; */
  /* [%css {|grid: auto-flow / auto 1fr|}]; */
  /* [%css {|grid: repeat(auto-fill, 5em) / auto-flow 1fr|}]; */
  /* [%css {|grid:  auto-flow 1fr / repeat(auto-fill, 5em)|}]; */
  /* [%css {|grid: 'H    H ' 'A    B ' 'F    F ' 30px / auto 1fr|}]; */
  [%css {|grid-row-start: auto|}];
  [%css {|grid-row-start: 4|}];
  [%css {|grid-row-start: C|}];
  [%css {|grid-row-start: C 2|}];
  /* [%css {|grid-row-start: span C|}]; */
  /* [%css {|grid-row-start: span 1|}]; */
  [%css {|grid-column-start: auto|}];
  [%css {|grid-column-start: 4|}];
  [%css {|grid-column-start: C|}];
  [%css {|grid-column-start: C 2|}];
  /* [%css {|grid-column-start: span C|}]; */
  /* [%css {|grid-column-start: span 1|}]; */
  [%css {|grid-row-end: auto|}];
  [%css {|grid-row-end: 4|}];
  [%css {|grid-row-end: C|}];
  [%css {|grid-row-end: C 2|}];
  /* [%css {|grid-row-end: span C|}]; */
  /* [%css {|grid-row-end: span 1|}]; */
  [%css {|grid-column-end: auto|}];
  [%css {|grid-column-end: 4|}];
  [%css {|grid-column-end: C|}];
  [%css {|grid-column-end: C 2|}];
  /* [%css {|grid-column-end: span C|}]; */
  /* [%css {|grid-column-end: span 1|}]; */
  [%css {|grid-column: auto|}];
  [%css {|grid-column: 1|}];
  [%css {|grid-column: -1|}];
  /* [%css {|grid-column: 1 / 1|}]; */
  /* [%css {|grid-column: 1 / -1|}]; */
  /* [%css {|grid-column: auto / auto|}]; */
  /* [%css {|grid-column: 2 / span 2|}]; */
  [%css {|grid-row: auto|}];
  [%css {|grid-row: 1|}];
  [%css {|grid-row: -1|}];
  /* [%css {|grid-row: 1 / 1|}]; */
  /* [%css {|grid-row: 1 / -1|}]; */
  /* [%css {|grid-row: auto / auto|}]; */
  /* [%css {|grid-row: 2 / span 2|}]; */
  /* [%css {|grid-area: 1 / 1|}]; */
  /* [%css {|grid-area: 1 / span 1|}]; */
  /* [%css {|grid-area: span / 10 / -1|}]; */
  [%css {|grid-column-gap: 0|}];
  [%css {|grid-column-gap: 1em|}];
  [%css {|grid-row-gap: 0|}];
  [%css {|grid-row-gap: 1em|}];
  [%css {|grid-gap: 0 0|}];
  [%css {|grid-gap: 0 1em|}];
  [%css {|grid-gap: 1em|}];
  [%css {|grid-gap: 1em 1em|}];
  
  /* CSS Grid Layout Module Level 2 */
  [%css {|grid-template-columns: subgrid|}];
  [%css {|grid-template-columns: subgrid [sub-a]|}];
  [%css {|grid-template-columns: subgrid [sub-a] [sub-b]|}];
  [%css {|grid-template-columns: subgrid repeat(1, [sub-a])|}];
  [%css {|grid-template-columns: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|}];
  [%css {|grid-template-columns: subgrid repeat(auto-fill, [sub-a] [sub-b])|}];
  [%css
    {|grid-template-columns: subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|}
  ];
  [%css {|grid-template-rows: subgrid|}];
  [%css {|grid-template-rows: subgrid [sub-a]|}];
  [%css {|grid-template-rows: subgrid [sub-a] [sub-b]|}];
  [%css {|grid-template-rows: subgrid repeat(1, [sub-a])|}];
  [%css {|grid-template-rows: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|}];
  [%css {|grid-template-rows: subgrid repeat(auto-fill, [sub-a] [sub-b])|}];
  [%css
    {|grid-template-rows: subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|}
  ];
  
  /* CSS Grid Layout Module Level 3 */
  /* [%css {|grid-template-columns: masonry|}]; */
  /* [%css {|grid-template-rows: masonry |}]; */
  /* [%css {|masonry-auto-flow: pack|}]; */
  /* [%css {|masonry-auto-flow: next|}]; */
  /* [%css {|masonry-auto-flow: definite-first|}]; */
  /* [%css {|masonry-auto-flow: ordered|}]; */
  /* [%css {|masonry-auto-flow: pack definite-first|}]; */
  /* [%css {|masonry-auto-flow: pack ordered|}]; */
  /* [%css {|masonry-auto-flow: next definite-first|}]; */
  /* [%css {|masonry-auto-flow: next ordered|}]; */
  /* [%css {|masonry-auto-flow: ordered pack|}]; */
  /* [%css {|align-tracks: normal|}]; */
  /* [%css {|align-tracks: baseline|}]; */
  /* [%css {|align-tracks: first baseline|}]; */
  /* [%css {|align-tracks: last baseline|}]; */
  /* [%css {|align-tracks: space-between|}]; */
  /* [%css {|align-tracks: space-around|}]; */
  /* [%css {|align-tracks: space-evenly|}]; */
  /* [%css {|align-tracks: stretch|}]; */
  /* [%css {|align-tracks: center|}]; */
  /* [%css {|align-tracks: start|}]; */
  /* [%css {|align-tracks: end|}]; */
  /* [%css {|align-tracks: flex-start|}]; */
  /* [%css {|align-tracks: flex-end|}]; */
  /* [%css {|align-tracks: unsafe center|}]; */
  /* [%css {|align-tracks: safe start|}]; */
  /* [%css {|justify-tracks: normal|}]; */
  /* [%css {|justify-tracks: space-between|}]; */
  /* [%css {|justify-tracks: space-around|}]; */
  /* [%css {|justify-tracks: space-evenly|}]; */
  /* [%css {|justify-tracks: stretch|}]; */
  /* [%css {|justify-tracks: center|}]; */
  /* [%css {|justify-tracks: start|}]; */
  /* [%css {|justify-tracks: end|}]; */
  /* [%css {|justify-tracks: flex-start|}]; */
  /* [%css {|justify-tracks: flex-end|}]; */
  /* [%css {|justify-tracks: left|}]; */
  /* [%css {|justify-tracks: right|}]; */
  /* [%css {|justify-tracks: unsafe center|}]; */
  /* [%css {|justify-tracks: safe start|}]; */

  $ dune build
  File "input.re", line 1, characters 0-21:
  Error: Unbound value externals
  [1]
