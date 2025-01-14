  $ alias run='./Render_test.exe'

Render component values
  $ cat <<"EOF" | run
  > /* simple values */
  > height: 20px;
  > width: 20%;
  > width: 20.832%;
  > color: red;
  > content: 'not emoji';
  > color: lch(from rebeccapurple l c calc(h + 80));
  > color: #f00;
  > opacity: 0.7;
  > content: url('../../media/examples/fire.png');
  > content: image-set("image1x.png" 1x, "image2x.png" 2x);
  > content: url("../img/test.png") / "This is the alt text";
  > /* fallback content */
  > content: url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico")
  >   " - alt text is not supported - ";
  > /* content with alternative text */
  > content: url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico") /
  >   " MOZILLA: ";
  > font:
  >   x-small Arial,
  >   sans-serif;
  > flex-grow: 3;
  > 
  > /* unicode ranges */
  > unicode-range: U+26; /* single code point */
  > unicode-range: U+0-7F;
  > unicode-range: U+0025-00FF; /* code point range */
  > unicode-range: U+4??; /* wildcard range */
  > unicode-range: U+0025-00FF, U+4??; /* multiple values */
  > EOF

An+B microsyntax
  $ cat <<"EOF" | run
  > li:nth-child(even) { foo: bar; }
  > li:nth-child(odd) { foo: bar; }
  > li:nth-child(5) { foo: bar; }
  > li:nth-child(n) { foo: bar; }
  > li:nth-child(-4n+10) { foo: bar; }
  > li:nth-child(3n-6) { foo: bar; }
  > li:nth-child(3n + -6) { foo: bar; }
  > li:nth-child(3n + 1) { foo: bar; }
  > li:nth-child(-n+ 6) { foo: bar; }
  > EOF

Remove empty rules
  $ cat <<"EOF" | run
  > .foo {}
  > .bar { color: red; }
  > /* .foo2 rule will be discarded */
  > .foo2 { .bar2 { color: red; } }
  > EOF

Split multiple selectors
  $ cat <<"EOF" | run
  > .foo, .bar { color: red; }
  > EOF

Split multiple selectors
  $ cat <<"EOF" | run
  > .foo, .bar { color: red; }
  > EOF

Resolve ampersand
  $ cat <<"EOF" | run
  > .foo {
  >   font-size: 1px;
  >   & .lola {
  >     font-size: 2px;
  >   }
  >   & .lola & {
  >     font-size: 3px;
  >   }
  >   .lola & {
  >     font-size: 4px;
  >   }
  >   .lola {
  >     font-size: 5px;
  >   }
  >   .lola & & & & .lola {
  >     font-size: 6px;
  >   }
  > }
  > EOF

Resolve nested pseudo class and pseudo element
  $ cat <<"EOF" | run
  > h3.foo#baz[data-foo=bar] {
  >   :hover { color: red; }
  >   :nth-child(even) { color: red; }
  >   ::first-line { color: red; }
  > }
  > EOF

Resolve nested other than pseudo class and pseudo element
  $ cat <<"EOF" | run
  > h3.foo#baz[data-foo=bar] {
  >   .color { color: red; }
  >   #what { color: red; }
  >   [data-foo=bar] { color: red; }
  > }
  > EOF

Ampersand join
  $ cat <<"EOF" | run
  > .foo .bar[data-foo=bar]#baz {
  >   &:nth-child(even) { color: red; }
  >   &:hover { color: red; }
  >   &.color { color: red; }
  >   &[data-baz=bar] { color: red; }
  >   &#myid { color: red; }
  > }
  > EOF

Nested with media query
  $ cat <<"EOF" | run
  > li {
  >   list-style-type: none;
  > 
  >   ::before {
  >     position: absolute;
  >     left: -20px;
  >     content: "✓";
  >   }
  > 
  >   @media screen and (min-width: 600px) {
  >     position: relative;
  >   }
  > }
  > EOF

Nested pseudo class and selector
  $ cat <<"EOF" | run
  > li {
  >   position: relative;
  >   :hover {
  >     ::after {
  >       top: 50px;
  >     }
  >   }
  > }
  > EOF

Nested pseduo class and selector with ampersand
  $ cat <<"EOF" | run
  > li {
  >   position: relative;
  >   &:hover {
  >     & ::after {
  >       top: 50px;
  >     }
  >   }
  > }
  > EOF

Media query inside selector with declarations
  $ cat <<"EOF" | run
  > .foo {
  >   display: block;
  > 
  >   & div {
  >     display: flex;
  > 
  >     @media (min-width: 768px) {
  >       height: auto;
  >     }
  >   }
  > }
  > EOF