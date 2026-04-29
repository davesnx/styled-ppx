/* CSS Grid Layout Module Level 1 */
[%cx2 {|display: grid|}];
[%cx2 {|display: inline-grid|}];
[%cx2 {|grid-template-columns: none|}];
[%cx2 {|grid-template-columns: auto|}];
[%cx2 {|grid-template-columns: 100px|}];
[%cx2 {|grid-template-columns: 1fr|}];
[%cx2 {|grid-template-columns: 100px 1fr auto|}];
[%cx2 {|grid-template-columns: repeat(2, 100px 1fr)|}];
[%css
  {|grid-template-columns: repeat(4, 10px [col-start] 250px [col-end]) 10px|}
];
[%css
  {|grid-template-columns: 100px 1fr max-content minmax(min-content, 1fr)|}
];
[%cx2 {|grid-template-columns: repeat(auto-fill, minmax(25ch, 1fr))|}];
[%cx2 {|grid-template-columns: 10px [col-start] 250px [col-end]|}];
[%css
  {|grid-template-columns: [first nav-start] 150px [main-start] 1fr [last]|}
];
[%css
  {|grid-template-columns: 10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px|}
];
[%css
  {|grid-template-columns: [a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto)|}
];
[%cx2 {|grid-template-columns: 200px repeat(auto-fill, 100px) 300px; |}];
[%css
  {|grid-template-columns: minmax(100px, max-content) repeat(auto-fill, 200px) 20%; |}
];
[%css
  {|grid-template-columns: [linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px; |}
];

[%css
  {|grid-template-columns: [linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3]; |}
];
let value =
  CSS.tracks([|
    CSS.repeatFn(
      CSS.numInt(4),
      [|
        CSS.pxFloat(10.),
        CSS.lineNames({js|[col-start]|js}),
        CSS.pxFloat(250.),
        CSS.lineNames({js|[col-end]|js}),
      |],
    ),
    CSS.pxFloat(10.),
  |]);
[%cx2 {|grid-template-columns: $(value)|}];
[%cx2 {|grid-template-rows: none|}];
[%cx2 {|grid-template-rows: auto|}];
[%cx2 {|grid-template-rows: 100px|}];
[%cx2 {|grid-template-rows: 1fr|}];
[%cx2 {|grid-template-rows: 100px 1fr auto|}];
[%cx2 {|grid-template-rows: repeat(2, 100px 1fr)|}];
[%cx2 {|grid-template-rows: 100px 1fr max-content minmax(min-content, 1fr)|}];
[%cx2 {|grid-template-rows: 10px [row-start] 250px [row-end]|}];
[%css
  {|grid-template-rows: [first header-start] 50px [main-start] 1fr [footer-start] 50px [last]|}
];
[%cx2 {|grid-template-areas: none|}];
[%cx2 {|grid-template-areas: 'articles'|}];
[%cx2 {|grid-template-areas: 'head head'|}];
[%cx2 {|grid-template-areas: 'head head' 'nav main' 'foot ....'|}];
[%cx2 {|grid-template: none|}];
[%cx2 {|grid-template: auto 1fr auto / auto 1fr|}];
[%css
  {|grid-template: [header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|}
];
[%cx2 {|grid-auto-columns: auto|}];
[%cx2 {|grid-auto-columns: 1fr|}];
[%cx2 {|grid-auto-columns: 100px|}];
[%cx2 {|grid-auto-columns: max-content|}];
[%cx2 {|grid-auto-columns: minmax(min-content, 1fr)|}];
[%cx2 {|grid-auto-columns: min-content max-content auto|}];
[%cx2 {|grid-auto-columns: 100px 150px 390px|}];
[%css
  {|grid-auto-columns: 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|}
];
[%cx2 {|grid-auto-rows: auto|}];
[%cx2 {|grid-auto-rows: 1fr|}];
[%cx2 {|grid-auto-rows: 100px|}];
[%cx2 {|grid-auto-rows: 100px 30%|}];
[%cx2 {|grid-auto-rows: 100px 30% 1em|}];
[%cx2 {|grid-auto-rows: min-content|}];
[%cx2 {|grid-auto-rows: minmax(min-content, 1fr)|}];
[%cx2 {|grid-auto-rows: min-content max-content auto|}];
[%css
  {|grid-auto-rows: 100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|}
];
[%cx2 {|grid-auto-flow: row|}];
[%cx2 {|grid-auto-flow: column|}];
[%cx2 {|grid-auto-flow: row dense|}];
[%cx2 {|grid-auto-flow: column dense|}];
[%cx2 {|grid: auto-flow 1fr / 100px|}];
[%cx2 {|grid: none / auto-flow 1fr|}];
[%cx2 {|grid: auto-flow / auto 1fr|}];
[%cx2 {|grid: repeat(auto-fill, 5em) / auto-flow 1fr|}];
[%cx2 {|grid:  auto-flow 1fr / repeat(auto-fill, 5em)|}];
[%cx2 {|grid: 'H    H ' 'A    B ' 'F    F ' 30px / auto 1fr|}];
[%cx2 {|grid-row-start: auto|}];
[%cx2 {|grid-row-start: 4|}];
[%cx2 {|grid-row-start: C|}];
[%cx2 {|grid-row-start: C 2|}];
[%cx2 {|grid-row-start: span C|}];
[%cx2 {|grid-row-start: span 1|}];
[%cx2 {|grid-column-start: auto|}];
[%cx2 {|grid-column-start: 4|}];
[%cx2 {|grid-column-start: C|}];
[%cx2 {|grid-column-start: C 2|}];
[%cx2 {|grid-column-start: span C|}];
[%cx2 {|grid-column-start: span 1|}];
[%cx2 {|grid-row-end: auto|}];
[%cx2 {|grid-row-end: 4|}];
[%cx2 {|grid-row-end: C|}];
[%cx2 {|grid-row-end: C 2|}];
[%cx2 {|grid-row-end: span C|}];
[%cx2 {|grid-row-end: span 1|}];
[%cx2 {|grid-column-end: auto|}];
[%cx2 {|grid-column-end: 4|}];
[%cx2 {|grid-column-end: C|}];
[%cx2 {|grid-column-end: C 2|}];
[%cx2 {|grid-column-end: span C|}];
[%cx2 {|grid-column-end: span 1|}];
[%cx2 {|grid-column: auto|}];
[%cx2 {|grid-column: 1|}];
[%cx2 {|grid-column: -1|}];
[%cx2 {|grid-column: 1 / 1|}];
[%cx2 {|grid-column: 1 / -1|}];
[%cx2 {|grid-column: auto / auto|}];
[%cx2 {|grid-column: 2 / span 2|}];
[%cx2 {|grid-row: auto|}];
[%cx2 {|grid-row: 1|}];
[%cx2 {|grid-row: -1|}];
[%cx2 {|grid-row: 1 / 1|}];
[%cx2 {|grid-row: 1 / -1|}];
[%cx2 {|grid-row: auto / auto|}];
[%cx2 {|grid-row: 2 / span 2|}];
[%cx2 {|grid-area: 1 / 1|}];
let area = `num(33);
[%cx2 {|grid-area: $(area)|}];
[%cx2 {|grid-area: 1 / span 1|}];
[%cx2 {|grid-area: span 1 / 10 / -1|}];
[%cx2 {|grid-column-gap: 0|}];
[%cx2 {|grid-column-gap: 1em|}];
[%cx2 {|grid-row-gap: 0|}];
[%cx2 {|grid-row-gap: 1em|}];
[%cx2 {|grid-gap: 0 0|}];
[%cx2 {|grid-gap: 0 1em|}];
[%cx2 {|grid-gap: 1em|}];
[%cx2 {|grid-gap: 1em 1em|}];

/* CSS Grid Layout Module Level 2 */
[%cx2 {|grid-template-columns: subgrid|}];
[%cx2 {|grid-template-columns: subgrid [sub-a]|}];
[%cx2 {|grid-template-columns: subgrid [sub-a] [sub-b]|}];
[%cx2 {|grid-template-columns: subgrid repeat(1, [sub-a])|}];
[%cx2 {|grid-template-columns: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|}];
[%cx2 {|grid-template-columns: subgrid repeat(auto-fill, [sub-a] [sub-b])|}];
[%css
  {|grid-template-columns: subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|}
];
[%cx2 {|grid-template-rows: subgrid|}];
[%cx2 {|grid-template-rows: subgrid [sub-a]|}];
[%cx2 {|grid-template-rows: subgrid [sub-a] [sub-b]|}];
[%cx2 {|grid-template-rows: subgrid repeat(1, [sub-a])|}];
[%cx2 {|grid-template-rows: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]|}];
[%cx2 {|grid-template-rows: subgrid repeat(auto-fill, [sub-a] [sub-b])|}];
[%css
  {|grid-template-rows: subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])|}
];

/* CSS Grid Layout Module Level 3 */
[%cx2 {|grid-template-columns: masonry|}];
[%cx2 {|grid-template-rows: masonry |}];
[%cx2 {|masonry-auto-flow: pack|}];
[%cx2 {|masonry-auto-flow: next|}];
[%cx2 {|masonry-auto-flow: definite-first|}];
[%cx2 {|masonry-auto-flow: ordered|}];
[%cx2 {|masonry-auto-flow: pack definite-first|}];
[%cx2 {|masonry-auto-flow: pack ordered|}];
[%cx2 {|masonry-auto-flow: next definite-first|}];
[%cx2 {|masonry-auto-flow: next ordered|}];
[%cx2 {|masonry-auto-flow: ordered pack|}];
/* [%cx2 {|align-tracks: normal|}]; */
/* [%cx2 {|align-tracks: baseline|}]; */
/* [%cx2 {|align-tracks: first baseline|}]; */
/* [%cx2 {|align-tracks: last baseline|}]; */
/* [%cx2 {|align-tracks: space-between|}]; */
/* [%cx2 {|align-tracks: space-around|}]; */
/* [%cx2 {|align-tracks: space-evenly|}]; */
/* [%cx2 {|align-tracks: stretch|}]; */
/* [%cx2 {|align-tracks: center|}]; */
/* [%cx2 {|align-tracks: start|}]; */
/* [%cx2 {|align-tracks: end|}]; */
/* [%cx2 {|align-tracks: flex-start|}]; */
/* [%cx2 {|align-tracks: flex-end|}]; */
/* [%cx2 {|align-tracks: unsafe center|}]; */
/* [%cx2 {|align-tracks: safe start|}]; */
/* [%cx2 {|justify-tracks: normal|}]; */
/* [%cx2 {|justify-tracks: space-between|}]; */
/* [%cx2 {|justify-tracks: space-around|}]; */
/* [%cx2 {|justify-tracks: space-evenly|}]; */
/* [%cx2 {|justify-tracks: stretch|}]; */
/* [%cx2 {|justify-tracks: center|}]; */
/* [%cx2 {|justify-tracks: start|}]; */
/* [%cx2 {|justify-tracks: end|}]; */
/* [%cx2 {|justify-tracks: flex-start|}]; */
/* [%cx2 {|justify-tracks: flex-end|}]; */
/* [%cx2 {|justify-tracks: left|}]; */
/* [%cx2 {|justify-tracks: right|}]; */
/* [%cx2 {|justify-tracks: unsafe center|}]; */
/* [%cx2 {|justify-tracks: safe start|}]; */
