Render component values
  $ cat << "EOF" | ./Render_test.exe
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
  > grid-template-columns:
  >   [line-name1] 100px [line-name2]
  >   repeat(auto-fit, [line-name3 line-name4] 300px)
  >   100px;
  > 
  > /* unicode ranges */
  > unicode-range: U+26; /* single code point */
  > unicode-range: U+0-7F;
  > unicode-range: U+0025-00FF; /* code point range */
  > unicode-range: U+4??; /* wildcard range */
  > unicode-range: U+0025-00FF, U+4??; /* multiple values */
  > EOF
  height:20px;width:20%;width:20.832%;color:red;content:"not emoji";color:lch(from rebeccapurple l c calc(h + 80));color:#f00;opacity:0.7;content:url("../../media/examples/fire.png");content:image-set("image1x.png" 1x,"image2x.png" 2x);content:url("../img/test.png") / "This is the alt text";content:url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico") " - alt text is not supported - ";content:url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico") / " MOZILLA: ";font:x-small Arial,sans-serif;flex-grow:3;grid-template-columns:[line-name1] 100px [line-name2] repeat(auto-fit,[line-name3 line-name4] 300px) 100px;unicode-range:U+26;unicode-range:U+0-7F;unicode-range:U+0025-00FF;unicode-range:U+4??;unicode-range:U+0025-00FF,U+4??

An+B microsyntax
  $ cat << "EOF" | ./Render_test.exe
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
  li:nth-child(even){foo:bar}li:nth-child(odd){foo:bar}li:nth-child(5){foo:bar}li:nth-child(n){foo:bar}li:nth-child(-4n+10){foo:bar}li:nth-child(3n-6){foo:bar}li:nth-child(3n-6){foo:bar}li:nth-child(3n+1){foo:bar}li:nth-child(-n+6){foo:bar}

An+B microsyntax is ASCII case-insensitive, "n-<digits>" idents and
"an- <signless-integer>" carry a negative b
  $ cat << "EOF" | ./Render_test.exe
  > li:nth-child(EVEN) { foo: bar; }
  > li:nth-child(2N) { foo: bar; }
  > li:nth-child(2N-1) { foo: bar; }
  > li:nth-child(-N+3) { foo: bar; }
  > li:nth-child(n-3) { foo: bar; }
  > li:nth-child(-n-3) { foo: bar; }
  > li:nth-child(2n- 3) { foo: bar; }
  > li:nth-child(n- 3) { foo: bar; }
  > EOF
  li:nth-child(even){foo:bar}li:nth-child(2n){foo:bar}li:nth-child(2n-1){foo:bar}li:nth-child(-n+3){foo:bar}li:nth-child(n-3){foo:bar}li:nth-child(-n-3){foo:bar}li:nth-child(2n-3){foo:bar}li:nth-child(n-3){foo:bar}

Invalid An+B payloads are located parse errors, not crashes
  $ echo "li:nth-child(3n-abc) { foo: bar; }" | ./Render_test.exe
  Error parsing CSS: Invalid an+b value in :nth-child() on line 1 at position 13
  $ echo "li:nth-child(3n-99999999999999999999) { foo: bar; }" | ./Render_test.exe
  Error parsing CSS: Invalid an+b value in :nth-child() on line 1 at position 13
  $ echo "li:nth-child(99999999999999999999n) { foo: bar; }" | ./Render_test.exe
  Error parsing CSS: Invalid an+b value in :nth-child() on line 1 at position 13
  $ echo "li:nth-child(2px) { foo: bar; }" | ./Render_test.exe
  Error parsing CSS: Invalid an+b value in :nth-child() on line 1 at position 13
  $ echo "li:nth-child(n-abc) { foo: bar; }" | ./Render_test.exe
  Error parsing CSS: Invalid an+b value in :nth-child() on line 1 at position 13

Remove empty rules
  $ cat << "EOF" | ./Render_test.exe
  > /* .foo rule will be discarded */
  > .foo {}
  > .bar { color: red; }
  > .foo2 { .bar2 { color: red; } }
  > EOF
  .bar{color:red}.foo2 .bar2{color:red}

Split multiple selectors
  $ cat << "EOF" | ./Render_test.exe
  > .foo, .bar { color: red; }
  > EOF
  .foo{color:red}.bar{color:red}

Resolve ampersand
  $ cat << "EOF" | ./Render_test.exe
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
  .foo{font-size:1px}.foo .lola{font-size:2px}.foo .lola .foo{font-size:3px}.lola .foo{font-size:4px}.foo .lola{font-size:5px}.lola .foo .foo .foo .foo .lola{font-size:6px}

Resolve nested pseudo class and pseudo element
  $ cat << "EOF" | ./Render_test.exe
  > h3.foo#baz[data-foo=bar] {
  >   :hover { color: red; }
  >   :nth-child(even) { color: red; }
  >   ::first-line { color: red; }
  > }
  > EOF
  h3.foo#baz[data-foo=bar] :hover{color:red}h3.foo#baz[data-foo=bar] :nth-child(even){color:red}h3.foo#baz[data-foo=bar] ::first-line{color:red}

Resolve nested other than pseudo class and pseudo element
  $ cat << "EOF" | ./Render_test.exe
  > h3.foo#baz[data-foo=bar] {
  >   .color { color: red; }
  >   #what { color: red; }
  >   [data-foo=bar] { color: red; }
  > }
  > EOF
  h3.foo#baz[data-foo=bar] .color{color:red}h3.foo#baz[data-foo=bar] #what{color:red}h3.foo#baz[data-foo=bar] [data-foo=bar]{color:red}

Ampersand join
  $ cat << "EOF" | ./Render_test.exe
  > .foo .bar[data-foo=bar]#baz {
  >   &:nth-child(even) { color: red; }
  >   &:hover { color: red; }
  >   &.color { color: red; }
  >   &[data-baz=bar] { color: red; }
  >   &#myid { color: red; }
  > }
  > EOF
  .foo .bar[data-foo=bar]#baz:nth-child(even){color:red}.foo .bar[data-foo=bar]#baz:hover{color:red}.foo .bar[data-foo=bar]#baz.color{color:red}.foo .bar[data-foo=bar]#baz[data-baz=bar]{color:red}.foo .bar[data-foo=bar]#baz#myid{color:red}

Nested with media query
  $ cat << "EOF" | ./Render_test.exe
  > li {
  >   list-style-type: none;
  > 
  >   ::before {
  >     position: absolute;
  >     left: -20px;
  >     content: "check";
  >   }
  > 
  >   @media screen and (min-width: 600px) {
  >     position: relative;
  >   }
  > }
  > EOF
  li{list-style-type:none}li ::before{position:absolute;left:-20px;content:"check"}@media screen and (min-width:600px){li{position:relative}}

Nested pseudo class and selector
  $ cat << "EOF" | ./Render_test.exe
  > li {
  >   position: relative;
  >   :hover {
  >     ::after {
  >       top: 50px;
  >     }
  >   }
  > }
  > EOF
  li{position:relative}li :hover ::after{top:50px}

Nested pseduo class and selector with ampersand
  $ cat << "EOF" | ./Render_test.exe
  > li {
  >   position: relative;
  >   &:hover {
  >     & ::after {
  >       top: 50px;
  >     }
  >   }
  > }
  > EOF
  li{position:relative}li:hover ::after{top:50px}

Media query inside selector with declarations
  $ cat << "EOF" | ./Render_test.exe
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
  .foo{display:block}.foo div{display:flex}@media (min-width:768px){.foo div{height:auto}}

Selector nested
  $ cat << "EOF" | ./Render_test.exe
  > display: flex;
  > a {
  >   display: block;
  >   div {
  >     display: none;
  >     span {
  >       display: none;
  >       hr {
  >         display: none;
  >         code {
  >           display: none;
  >         }
  >       }
  >     }
  >   }
  > }
  > EOF
  display:flex;a{display:block}a div{display:none}a div span{display:none}a div span hr{display:none}a div span hr code{display:none}

Declaration list descendant selector
  $ cat << "EOF" | ./Render_test.exe
  > display: flex;
  > svg path {
  >   fill: red;
  > }
  > EOF
  display:flex;svg path{fill:red}

Declaration list type selector pseudo
  $ cat << "EOF" | ./Render_test.exe
  > body:hover main {
  >   color: blue;
  > }
  > EOF
  body:hover main{color:blue}

Declaration list missing semicolon before nested selector
  $ cat << "EOF" | ./Render_test.exe
  > background-color: red
  > &:nth-child(2n) {
  >   background-color: blue;
  > }
  > EOF
  background-color:red;&:nth-child(2n){background-color:blue}

Declaration list missing semicolon before nested class selector
  $ cat << "EOF" | ./Render_test.exe
  > color: red
  > .child {
  >   color: blue;
  > }
  > EOF
  color:red;.child{color:blue}

Declaration list missing semicolon before nested type selector
  $ cat << "EOF" | ./Render_test.exe
  > color: red
  > div {
  >   color: blue;
  > }
  > EOF
  color:red;div{color:blue}

Declaration list missing semicolon before nested id selector
  $ cat << "EOF" | ./Render_test.exe
  > color: red
  > #child {
  >   color: blue;
  > }
  > EOF
  color:red;#child{color:blue}

Declaration list missing semicolon before nested descendant selector
  $ cat << "EOF" | ./Render_test.exe
  > color: red
  > svg path {
  >   fill: blue;
  > }
  > EOF
  color:red;svg path{fill:blue}

Declaration list missing semicolon before nested selector after interpolation
  $ cat << "EOF" | ./Render_test.exe
  > border-bottom: 1px solid $(borderColor)
  > &:last-child {
  >   padding-bottom: 0;
  >   border-bottom-width: 0;
  > }
  > EOF
  border-bottom:1px solid $(borderColor);&:last-child{padding-bottom:0;border-bottom-width:0}

Declaration list missing semicolon before nested media query after interpolation
  $ cat << "EOF" | ./Render_test.exe
  > margin-bottom: $(Size.lg) @media $(Media.wide) {
  >   width: 50%;
  > }
  > EOF
  margin-bottom:$(Size.lg);@media $(Media.wide){width:50%}

Nested descendant selector from declaration list
  $ cat << "EOF" | ./Render_test.exe
  > a {
  >   svg path {
  >     fill: red;
  >   }
  > }
  > EOF
  a svg path{fill:red}

Declaration after nested block
  $ cat << "EOF" | ./Render_test.exe
  > .recharts-wrapper, .recharts-surface {
  >   @media print {
  >     width: 100%;
  >   }
  > }
  > margin-top: 17px;
  > EOF
  margin-top:17px;@media print{.recharts-wrapper{width:100%}.recharts-surface{width:100%}}

Declaration list missing semicolon before nested media query
  $ cat << "EOF" | ./Render_test.exe
  > margin-bottom: 24px @media (min-width: 1024px) {
  >   width: 50%;
  > }
  > EOF
  margin-bottom:24px;@media (min-width:1024px){width:50%}

Media query nested
  $ cat << "EOF" | ./Render_test.exe
  > max-width: 800px;
  > @media (min-width: 300px) {
  >   margin-left: 10px;
  >   @media (max-width: 768px) {
  >     position: fixed;
  >     @media (max-width: 1200px) {
  >       border: 1px solid transparent;
  >       @media (max-width: 1200px) {
  >         border: 1px solid transparent;
  >         @media (max-width: 1200px) {
  >         border: 1px solid transparent;
  >           @media (max-width: 1200px) {
  >             border: 1px solid transparent;
  >           }
  >         }
  >       }
  >     }
  >   }
  > }
  > EOF
  max-width:800px;@media (min-width:300px){margin-left:10px}@media (min-width:300px) and (max-width:768px){position:fixed}@media (min-width:300px) and (max-width:768px) and (max-width:1200px){border:1px solid transparent}@media (min-width:300px) and (max-width:768px) and (max-width:1200px) and (max-width:1200px){border:1px solid transparent}@media (min-width:300px) and (max-width:768px) and (max-width:1200px) and (max-width:1200px) and (max-width:1200px){border:1px solid transparent}@media (min-width:300px) and (max-width:768px) and (max-width:1200px) and (max-width:1200px) and (max-width:1200px) and (max-width:1200px){border:1px solid transparent}

Complex selector test
  $ cat << "EOF" | ./Render_test.exe
  > div#main.container[data-role="content"]:not(:empty):nth-child(2n+1) > ul li:nth-of-type(odd):first-child a[target="_blank"]:hover,
  > section[lang|="en"] + article#special ~ aside:last-of-type *,
  > input[type="checkbox"]:checked:focus,
  > p::before {
  >   color: red;
  > }
  > EOF
  div#main.container[data-role=content]:not(:empty):nth-child(2n+1)>ul li:nth-of-type(odd):first-child a[target=_blank]:hover{color:red}section[lang|=en]+article#special~aside:last-of-type *{color:red}input[type=checkbox]:checked:focus{color:red}p::before{color:red}

CSS Variable
  $ cat << "EOF" | ./Render_test.exe
  > :root {
  >   --bs-dropdown-bg: #343a40;
  >   --bs-dropdown-border-color: var(--bs-border-color-translucent, black);
  >   --bs-dropdown-box-shadow: ;
  > }
  > EOF
  :root{--bs-dropdown-bg:#343a40;--bs-dropdown-border-color:var(--bs-border-color-translucent, black);--bs-dropdown-box-shadow:}

Ampersand on root
  $ cat << "EOF" | ./Render_test.exe
  > color: green;
  > & .test {
  >   color: white;
  > }
  > EOF
  color:green;& .test{color:white}

Ampersand list nested two levels deep compounds with the last segment of a
multi-segment parent selector (regression: `&` used to resolve with a
descendant space, `td :first-child`)
  $ cat << "EOF" | ./Render_test.exe
  > tbody {
  >   tr:first-child td {
  >     &:first-child, &:last-child {
  >       color: red;
  >     }
  >   }
  > }
  > EOF
  tbody tr:first-child td:first-child{color:red}tbody tr:first-child td:last-child{color:red}

Single ampersand at the same depth
  $ cat << "EOF" | ./Render_test.exe
  > tbody {
  >   tr:first-child td {
  >     &:first-child {
  >       color: red;
  >     }
  >   }
  > }
  > EOF
  tbody tr:first-child td:first-child{color:red}

Ampersand list where the parent's last segment is a compound with pseudo
  $ cat << "EOF" | ./Render_test.exe
  > ul {
  >   li:hover {
  >     &::before, &::after {
  >       content: "";
  >     }
  >   }
  > }
  > EOF
  ul li:hover::before{content:""}ul li:hover::after{content:""}

Ampersand compound under a pseudo-element parent keeps literal substitution
order: the pseudo-class renders after the pseudo-element (`:hover` of the
`::before`), not before it (regression: used to produce `.a:hover::before`,
the `::before` of a hovered `.a` — a different selector)
  $ cat << "EOF" | ./Render_test.exe
  > .a::before {
  >   &:hover {
  >     color: red;
  >   }
  > }
  > EOF
  .a::before:hover{color:red}

Non-pseudo subclasses under a pseudo-element parent stay in subclass position
(`::before.foo` is invalid CSS and unrepresentable; `.a.foo::before` is the
only sensible reading)
  $ cat << "EOF" | ./Render_test.exe
  > .a::before {
  >   &.foo {
  >     color: red;
  >   }
  > }
  > EOF
  .a.foo::before{color:red}

Ampersand compound under a trailing-ampersand parent (nesting introduced by
substitution rather than descendant join)
  $ cat << "EOF" | ./Render_test.exe
  > tbody {
  >   tr {
  >     td & {
  >       &:hover {
  >         color: red;
  >       }
  >     }
  >   }
  > }
  > EOF
  td tbody tr:hover{color:red}

Style rules and non-media at-rules survive next to a nested media query
(regression: `swap` used to silently drop them)
  $ cat << "EOF" | ./Render_test.exe
  > @media (min-width: 100px) {
  >   .x { color: red; }
  >   @media (min-width: 200px) {
  >     color: blue;
  >   }
  >   @supports (display: grid) {
  >     display: grid;
  >   }
  > }
  > EOF
  @media (min-width:100px){.x{color:red}}@media (min-width:100px) and (min-width:200px){color:blue}@media (min-width:100px){@supports (display:grid){display:grid}}

Outer media declarations are emitted once with multiple nested media queries
(regression: they used to duplicate once per nested media)
  $ cat << "EOF" | ./Render_test.exe
  > @media (min-width: 100px) {
  >   color: red;
  >   @media (min-width: 200px) { color: blue; }
  >   @media (min-width: 300px) { color: green; }
  > }
  > EOF
  @media (min-width:100px){color:red}@media (min-width:100px) and (min-width:200px){color:blue}@media (min-width:100px) and (min-width:300px){color:green}

Nested media with a comma-list prelude stays literally nested: `and`-joining
would bind tighter than the comma and drop the constraint for one alternative
  $ cat << "EOF" | ./Render_test.exe
  > @media screen, print {
  >   @media (min-width: 100px) { color: red; }
  > }
  > EOF
  @media screen,print{@media (min-width:100px){color:red}}

Nested media under a `not` prelude stays literally nested: appending `and`
conditions would change what the `not` negates
  $ cat << "EOF" | ./Render_test.exe
  > @media not screen {
  >   @media (min-width: 100px) { color: red; }
  > }
  > EOF
  @media not screen{@media (min-width:100px){color:red}}

Nested media with a media-type-headed inner prelude stays literally nested:
a `<media-type>` may only appear at the head of a query, so
`(min-width: 5px) and screen` would fail the media-query grammar and
evaluate as `not all` — silently dead CSS
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @media (min-width: 5px) {
  >     @media screen { color: red; }
  >     @media only print { color: blue; }
  >   }
  > }
  > EOF
  @media (min-width:5px){@media screen{.a{color:red}}@media only print{.a{color:blue}}}

Nested media with a top-level `or` in either prelude stays literally nested:
mixing `and`/`or` at one level fails the media-query grammar
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @media (min-width: 5px) {
  >     @media (color) or (min-width: 10px) { color: red; }
  >   }
  >   @media (color) or (min-width: 10px) {
  >     @media (min-width: 5px) { color: blue; }
  >   }
  > }
  > EOF
  @media (min-width:5px){@media (color) or (min-width:10px){.a{color:red}}}@media (color) or (min-width:10px){@media (min-width:5px){.a{color:blue}}}

Media-type-headed OUTER preludes still combine with condition-only inner
preludes (`screen and (mw)` extends fine on the right)
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @media screen and (min-width: 5px) {
  >     @media (min-width: 10px) and (min-height: 3px) { color: red; }
  >   }
  > }
  > EOF
  @media screen and (min-width:5px) and (min-width:10px) and (min-height:3px){.a{color:red}}

Nested media with an interpolated prelude stays literally nested: the
interpolation may expand to a comma list or `not` query at runtime
  $ cat << "EOF" | ./Render_test.exe
  > @media $(Media.wide) {
  >   @media (min-width: 100px) { color: red; }
  > }
  > EOF
  @media $(Media.wide){@media (min-width:100px){color:red}}

Declarations keep their source position around a nested media query
(regression: trailing declarations used to hoist above the media,
flipping the cascade)
  $ cat << "EOF" | ./Render_test.exe
  > @media (min-width: 1px) {
  >   color: red;
  >   @media (min-width: 2px) { color: blue; }
  >   color: green;
  > }
  > EOF
  @media (min-width:1px){color:red}@media (min-width:1px) and (min-width:2px){color:blue}@media (min-width:1px){color:green}

Top-level source order between style rules and media queries is preserved
(regression: media used to hoist after all style rules, flipping the cascade)
  $ cat << "EOF" | ./Render_test.exe
  > @media print {
  >   body { color: red; }
  > }
  > body { color: blue; }
  > EOF
  @media print{body{color:red}}body{color:blue}

Nesting inside at-rule blocks is flattened
(regression: `&:hover` used to ship literally inside hoisted @media blocks)
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @media print {
  >     &:hover { color: blue; }
  >   }
  > }
  > EOF
  @media print{.a:hover{color:blue}}

Nesting two levels deep inside a hoisted media query
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   .b {
  >     @media print {
  >       &:hover { color: red; }
  >     }
  >   }
  > }
  > EOF
  @media print{.a .b:hover{color:red}}

Media nested through a style rule inside another media combines both preludes
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @media (min-width: 100px) {
  >     @media (min-width: 200px) { color: red; }
  >   }
  > }
  > EOF
  @media (min-width:100px) and (min-width:200px){.a{color:red}}

Nesting inside @supports blocks is flattened and @supports keeps its position
  $ cat << "EOF" | ./Render_test.exe
  > .a {
  >   @supports (display: grid) {
  >     &:hover { display: grid; }
  >   }
  > }
  > EOF
  @supports (display:grid){.a:hover{display:grid}}

Blockless at-rules pass through verbatim
(regression: `@import` used to vanish silently)
  $ cat << "EOF" | ./Render_test.exe
  > @import "foo.css";
  > body { margin: 0; }
  > EOF
  @import "foo.css";body{margin:0}

@font-face passes through verbatim with its descriptors intact
  $ cat << "EOF" | ./Render_test.exe
  > @font-face {
  >   font-family: "Inter";
  >   src: url("/fonts/inter.woff2") format("woff2");
  > }
  > body { margin: 0; }
  > EOF
  @font-face{font-family:"Inter";src:url("/fonts/inter.woff2") format("woff2")}body{margin:0}

Multiple selectors
  $ cat << "EOF" | ./Render_test.exe
  > .classname {
  >  margin-right: 20px;
  > 
  >  &:hover, .menuOpened {
  >    .languageIcon {
  >      opacity: 1.0;
  >    }
  > 
  >    & svg > path {
  >      fill: #333;
  >    }
  >  }
  >  }
  > EOF
  .classname{margin-right:20px}.classname:hover .languageIcon{opacity:1}.classname:hover svg>path{fill:#333}.classname .menuOpened .languageIcon{opacity:1}.classname .menuOpened svg>path{fill:#333}

Spec-derived corpus. Test inputs adapted from the cascade project
(https://github.com/samoht/cascade, ISC License, Copyright (c) 2024-2025
Thomas Gazagnaire), whose vectors are in turn derived from W3C CSS
specifications. Expected outputs are styled-ppx's own renderer output:
unlike cascade, our renderer serializes without cascade-level transforms
(no color canonicalisation, rule merging, or shorthand rewriting).

CSS 2.x selectors and at-rules
  $ cat << "EOF" | ./Render_test.exe
  > body { margin: 0; color: black }
  > EOF
  body{margin:0;color:black}
  $ cat << "EOF" | ./Render_test.exe
  > @charset "UTF-8";
  > EOF
  @charset "UTF-8";
  $ cat << "EOF" | ./Render_test.exe
  > @import 'legacy.css';
  > EOF
  @import "legacy.css";
  $ cat << "EOF" | ./Render_test.exe
  > @media print { body { color: black } }
  > EOF
  @media print{body{color:black}}
  $ cat << "EOF" | ./Render_test.exe
  > @page :left { margin-left: 4cm; margin-right: 3cm }
  > EOF
  @page:left{margin-left:4cm;margin-right:3cm}
  $ cat << "EOF" | ./Render_test.exe
  > html > body p + p { text-indent: 1em }
  > EOF
  html>body p+p{text-indent:1em}
  $ cat << "EOF" | ./Render_test.exe
  > a:link { color: blue } a:visited { color: purple }
  > EOF
  a:link{color:blue}a:visited{color:purple}
  $ cat << "EOF" | ./Render_test.exe
  > li:first-child { list-style-type: none }
  > EOF
  li:first-child{list-style-type:none}

CSS 2.x pseudo-elements
  $ cat << "EOF" | ./Render_test.exe
  > h1:first-letter { color: red }
  > EOF
  h1:first-letter{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > p::first-line { color: blue }
  > EOF
  p::first-line{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > q:before { content: open-quote }
  > EOF
  q:before{content:open-quote}
  $ cat << "EOF" | ./Render_test.exe
  > q::after { content: close-quote }
  > EOF
  q::after{content:close-quote}
  $ cat << "EOF" | ./Render_test.exe
  > div { page-break-before: always }
  > EOF
  div{page-break-before:always}
  $ cat << "EOF" | ./Render_test.exe
  > div { page-break-after: avoid }
  > EOF
  div{page-break-after:avoid}
  $ cat << "EOF" | ./Render_test.exe
  > div { page-break-inside: avoid }
  > EOF
  div{page-break-inside:avoid}

CSS 2.x chapter matrix
  $ cat << "EOF" | ./Render_test.exe
  > html, body { display: block; min-height: 100% }
  > EOF
  html{display:block;min-height:100%}body{display:block;min-height:100%}
  $ cat << "EOF" | ./Render_test.exe
  > body *[lang|="en"] + p:first-line { text-transform: uppercase }
  > EOF
  body [lang|=en]+p:first-line{text-transform:uppercase}
  $ cat << "EOF" | ./Render_test.exe
  > table > caption + colgroup col { visibility: collapse }
  > EOF
  table>caption+colgroup col{visibility:collapse}
  $ cat << "EOF" | ./Render_test.exe
  > ol li { list-style: decimal inside }
  > EOF
  ol li{list-style:decimal inside}
  $ cat << "EOF" | ./Render_test.exe
  > q:before { content: open-quote } q:after { content: close-quote }
  > EOF
  q:before{content:open-quote}q:after{content:close-quote}
  $ cat << "EOF" | ./Render_test.exe
  > pre { white-space: pre; tab-size: 4 }
  > EOF
  pre{white-space:pre;tab-size:4}
  $ cat << "EOF" | ./Render_test.exe
  > img { float: left; clear: both; vertical-align: middle }
  > EOF
  img{float:left;clear:both;vertical-align:middle}
  $ cat << "EOF" | ./Render_test.exe
  > @media print { h1 { page-break-before: always } }
  > EOF
  @media print{h1{page-break-before:always}}
  $ cat << "EOF" | ./Render_test.exe
  > @page chapter:right { margin: 2cm; size: A4 }
  > EOF
  @page chapter:right{margin:2cm;size:A4}

CSS Syntax 3: qualified rules
  $ cat << "EOF" | ./Render_test.exe
  > h1 { color: red }
  > EOF
  h1{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1, h2, h3 { margin: 0 }
  > EOF
  h1{margin:0}h2{margin:0}h3{margin:0}
  $ cat << "EOF" | ./Render_test.exe
  > p { color: blue; font-size: 16px }
  > EOF
  p{color:blue;font-size:16px}
  $ cat << "EOF" | ./Render_test.exe
  > h1 { color: red } p { margin: 0 }
  > EOF
  h1{color:red}p{margin:0}

CSS Syntax 3: at-rules
  $ cat << "EOF" | ./Render_test.exe
  > @media screen { .btn { color: green } }
  > EOF
  @media screen{.btn{color:green}}
  $ cat << "EOF" | ./Render_test.exe
  > @import url("reset.css");
  > EOF
  @import url("reset.css");
  $ cat << "EOF" | ./Render_test.exe
  > @layer base { body { margin: 0 } }
  > EOF
  @layer base{body{margin:0}}

CSS Syntax 3: comments
  $ cat << "EOF" | ./Render_test.exe
  > /* This is a comment */ h1 { color: red }
  > EOF
  h1{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1 { /* inline comment */ color: red }
  > EOF
  h1{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1 { color: /* mid-value */ red }
  > EOF
  h1{color:red}

CSS Syntax 3: whitespace
  $ cat << "EOF" | ./Render_test.exe
  >   h1  {  color  :  red  }  
  > EOF
  h1{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1	{
  > 	color:	red
  > }
  > EOF
  h1{color:red}

CSS Syntax 3: escapes
  $ cat << "EOF" | ./Render_test.exe
  > .sm\:p-4{color:red}
  > EOF
  .sm\:p-4{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > .w-1\/2{width:50%}
  > EOF
  .w-1\/2{width:50%}

Selectors 4: type selectors
  $ cat << "EOF" | ./Render_test.exe
  > div { display: block }
  > EOF
  div{display:block}
  $ cat << "EOF" | ./Render_test.exe
  > span { color: blue }
  > EOF
  span{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > article { margin: 0 }
  > EOF
  article{margin:0}

Selectors 4: universal selector
  $ cat << "EOF" | ./Render_test.exe
  > * { box-sizing: border-box }
  > EOF
  *{box-sizing:border-box}

Selectors 4: class selectors
  $ cat << "EOF" | ./Render_test.exe
  > .warning { color: red }
  > EOF
  .warning{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > .info { color: blue }
  > EOF
  .info{color:blue}

Selectors 4: id selectors
  $ cat << "EOF" | ./Render_test.exe
  > #myid { color: red }
  > EOF
  #myid{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > #main { display: flex }
  > EOF
  #main{display:flex}

Selectors 4: attribute selectors
  $ cat << "EOF" | ./Render_test.exe
  > [href] { color: blue }
  > EOF
  [href]{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > [type="text"] { border: 1px solid gray }
  > EOF
  [type=text]{border:1px solid gray}
  $ cat << "EOF" | ./Render_test.exe
  > [class~="warning"] { color: red }
  > EOF
  [class~=warning]{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > [lang|="en"] { color: blue }
  > EOF
  [lang|=en]{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > [href^="https"] { color: green }
  > EOF
  [href^=https]{color:green}
  $ cat << "EOF" | ./Render_test.exe
  > [href$=".pdf"] { color: red }
  > EOF
  [href$=".pdf"]{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > [title*="hello"] { color: blue }
  > EOF
  [title*=hello]{color:blue}

Selectors 4: pseudo-classes
  $ cat << "EOF" | ./Render_test.exe
  > :hover { color: red }
  > EOF
  :hover{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :first-child { color: red }
  > EOF
  :first-child{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :last-child { margin: 0 }
  > EOF
  :last-child{margin:0}
  $ cat << "EOF" | ./Render_test.exe
  > :nth-child(2n+1) { color: red }
  > EOF
  :nth-child(2n+1){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :nth-child(even) { color: blue }
  > EOF
  :nth-child(even){color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > :nth-child(odd) { color: red }
  > EOF
  :nth-child(odd){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :not(.foo) { color: red }
  > EOF
  :not(.foo){color:red}

Selectors 4: pseudo-elements
  $ cat << "EOF" | ./Render_test.exe
  > ::before { content: '' }
  > EOF
  ::before{content:""}
  $ cat << "EOF" | ./Render_test.exe
  > ::after { content: '' }
  > EOF
  ::after{content:""}
  $ cat << "EOF" | ./Render_test.exe
  > ::first-line { color: red }
  > EOF
  ::first-line{color:red}

Selectors 4: combinators
  $ cat << "EOF" | ./Render_test.exe
  > div p { color: red }
  > EOF
  div p{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > div > p { color: red }
  > EOF
  div>p{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1 + p { color: red }
  > EOF
  h1+p{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > h1 ~ p { color: red }
  > EOF
  h1~p{color:red}

Selectors 4: selector lists
  $ cat << "EOF" | ./Render_test.exe
  > .a, .b, .c { display: block }
  > EOF
  .a{display:block}.b{display:block}.c{display:block}

Selectors 4: :is() and :where()
  $ cat << "EOF" | ./Render_test.exe
  > :where(.a, .b) { color: red }
  > EOF
  :where(.a,.b){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :is(.a, .b) { color: red }
  > EOF
  :is(.a,.b){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :is() { color: red }
  > EOF
  :is(){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :where() { color: red }
  > EOF
  :where(){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :is(:future-pseudo, .a) { color: red }
  > EOF
  :is(:future-pseudo,.a){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :where(:future-pseudo, .a) { color: red }
  > EOF
  :where(:future-pseudo,.a){color:red}

Values 4: absolute lengths
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 100px }
  > EOF
  .x{width:100px}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 10cm }
  > EOF
  .x{width:10cm}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 10mm }
  > EOF
  .x{width:10mm}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 1in }
  > EOF
  .x{width:1in}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 12pt }
  > EOF
  .x{width:12pt}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 1pc }
  > EOF
  .x{width:1pc}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 1unknown; height: 10px }
  > EOF
  .x{width:1unknown;height:10px}
  $ cat << "EOF" | ./Render_test.exe
  > .x { font-size: 16xyz }
  > EOF
  .x{font-size:16xyz}

Values 4: relative lengths
  $ cat << "EOF" | ./Render_test.exe
  > .x { font-size: 2em }
  > EOF
  .x{font-size:2em}
  $ cat << "EOF" | ./Render_test.exe
  > .x { font-size: 1.5rem }
  > EOF
  .x{font-size:1.5rem}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 50vw }
  > EOF
  .x{width:50vw}
  $ cat << "EOF" | ./Render_test.exe
  > .x { height: 100vh }
  > EOF
  .x{height:100vh}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: 50% }
  > EOF
  .x{width:50%}

Values 4: calc()
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: calc(100% - 2rem) }
  > EOF
  .x{width:calc(100% - 2rem)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: calc(2 * 3rem) }
  > EOF
  .x{width:calc(2 * 3rem)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: calc(100% - calc(2rem + 10px)) }
  > EOF
  .x{width:calc(100% - calc(2rem + 10px))}

Values 4: angles
  $ cat << "EOF" | ./Render_test.exe
  > .x { transform: rotate(45deg) }
  > EOF
  .x{transform:rotate(45deg)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { transform: rotate(1rad) }
  > EOF
  .x{transform:rotate(1rad)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { transform: rotate(.5turn) }
  > EOF
  .x{transform:rotate(0.5turn)}

Values 4: durations
  $ cat << "EOF" | ./Render_test.exe
  > .x { transition-duration: 200ms }
  > EOF
  .x{transition-duration:200ms}
  $ cat << "EOF" | ./Render_test.exe
  > .x { transition-duration: 1s }
  > EOF
  .x{transition-duration:1s}
  $ cat << "EOF" | ./Render_test.exe
  > .x { transition-duration: 1500ms }
  > EOF
  .x{transition-duration:1500ms}

Color 4: named colors
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: red }
  > EOF
  .x{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: blue }
  > EOF
  .x{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: rebeccapurple }
  > EOF
  .x{color:rebeccapurple}

Color 4: hex colors
  $ cat << "EOF" | ./Render_test.exe
  > .x{color:red}
  > EOF
  .x{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > .x{color:#ff0000}
  > EOF
  .x{color:#ff0000}
  $ cat << "EOF" | ./Render_test.exe
  > .x{color:#f00f}
  > EOF
  .x{color:#f00f}
  $ cat << "EOF" | ./Render_test.exe
  > .x{color:#ff0000ff}
  > EOF
  .x{color:#ff0000ff}

Color 4: rgb()
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: rgb(255 0 0) }
  > EOF
  .x{color:rgb(255 0 0)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: rgb(255 0 0 / 50%) }
  > EOF
  .x{color:rgb(255 0 0 / 50%)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: rgb(100% 0% 0%) }
  > EOF
  .x{color:rgb(100% 0% 0%)}

Color 4: hsl()
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: hsl(120 100% 50%) }
  > EOF
  .x{color:hsl(120 100% 50%)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: hsl(120 100% 50% / 50%) }
  > EOF
  .x{color:hsl(120 100% 50% / 50%)}

Color 4: hwb()
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: hwb(90 10% 20%) }
  > EOF
  .x{color:hwb(90 10% 20%)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: hwb(90 10% 20% / 0.25) }
  > EOF
  .x{color:hwb(90 10% 20% / 0.25)}

Color 4: oklch()/oklab()
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: oklch(50% 0.2 30) }
  > EOF
  .x{color:oklch(50% 0.2 30)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: oklab(50% 0.1 -0.05) }
  > EOF
  .x{color:oklab(50% 0.1 -0.05)}

Color 5: color-mix()
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: color-mix(in srgb, red, blue) }
  > EOF
  .x{color:color-mix(in srgb,red,blue)}

Color 4: system color keywords
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: transparent }
  > EOF
  .x{color:transparent}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: currentColor }
  > EOF
  .x{color:currentColor}

Media Queries 4
  $ cat << "EOF" | ./Render_test.exe
  > @media (min-width: 768px) { .btn { display: block } }
  > EOF
  @media (min-width:768px){.btn{display:block}}
  $ cat << "EOF" | ./Render_test.exe
  > @media (max-width: 640px) { .btn { font-size: 14px } }
  > EOF
  @media (max-width:640px){.btn{font-size:14px}}
  $ cat << "EOF" | ./Render_test.exe
  > @media (prefers-color-scheme: dark) { body { background-color: black } }
  > EOF
  @media (prefers-color-scheme:dark){body{background-color:black}}

Conditional 3: @supports
  $ cat << "EOF" | ./Render_test.exe
  > @supports (display: grid) { .grid { display: grid } }
  > EOF
  @supports (display:grid){.grid{display:grid}}
  $ cat << "EOF" | ./Render_test.exe
  > @supports at-rule(@container) { .cq { container-type: inline-size } }
  > EOF
  @supports at-rule(@container){.cq{container-type:inline-size}}

Stylesheet at-rules (@import, @namespace, @page)
  $ cat << "EOF" | ./Render_test.exe
  > @namespace url(http://www.w3.org/1999/xhtml);
  > EOF
  @namespace url("http://www.w3.org/1999/xhtml");
  $ cat << "EOF" | ./Render_test.exe
  > @namespace svg url(http://www.w3.org/2000/svg);
  > EOF
  @namespace svg url("http://www.w3.org/2000/svg");
  $ cat << "EOF" | ./Render_test.exe
  > @page :first:left { margin: 1cm }
  > EOF
  @page:first:left{margin:1cm}
  $ cat << "EOF" | ./Render_test.exe
  > @page :blank:first { margin: .5cm }
  > EOF
  @page:blank:first{margin:0.5cm}

Cascade 4: CSS-wide keywords
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: inherit }
  > EOF
  .x{color:inherit}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: initial }
  > EOF
  .x{color:initial}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: unset }
  > EOF
  .x{color:unset}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: revert }
  > EOF
  .x{color:revert}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: revert-layer }
  > EOF
  .x{color:revert-layer}
  $ cat << "EOF" | ./Render_test.exe
  > .x { font-family: Arial, inherit }.y { color: red }
  > EOF
  .x{font-family:Arial,inherit}.y{color:red}

Cascade 5: @layer
  $ cat << "EOF" | ./Render_test.exe
  > @layer reset, base, components;
  > EOF
  @layer reset,base,components;
  $ cat << "EOF" | ./Render_test.exe
  > @layer base { h1 { color: red } p { margin: 0 } }
  > EOF
  @layer base{h1{color:red}p{margin:0}}

Cascade 5/6: current at-rules
  $ cat << "EOF" | ./Render_test.exe
  > @import url("theme.css") layer(theme) supports(display: grid) screen;
  > EOF
  @import url("theme.css") layer(theme) supports(display:grid) screen;
  $ cat << "EOF" | ./Render_test.exe
  > @scope (.card) to (.footer) { .title { color: red } }
  > EOF
  @scope (.card) to (.footer){.title{color:red}}
  $ cat << "EOF" | ./Render_test.exe
  > @scope (.card) { .title { color: red } }
  > EOF
  @scope (.card){.title{color:red}}
  $ cat << "EOF" | ./Render_test.exe
  > @scope (:root) to (.stop, .end) { .title { color: blue } }
  > EOF
  @scope (:root) to (.stop,.end){.title{color:blue}}
  $ cat << "EOF" | ./Render_test.exe
  > @starting-style { .dialog { opacity: 0 } }
  > EOF
  @starting-style{.dialog{opacity:0}}

Containment 3: @container
  $ cat << "EOF" | ./Render_test.exe
  > @container card (inline-size > 30em) { .item { display: grid } }
  > EOF
  @container card (inline-size > 30em){.item{display:grid}}
  $ cat << "EOF" | ./Render_test.exe
  > @container style(--variant: featured) { .card { color: red } }
  > EOF
  @container style(--variant:featured){.card{color:red}}
  $ cat << "EOF" | ./Render_test.exe
  > @container scroll-state(stuck: top) { .card { color: red } }
  > EOF
  @container scroll-state(stuck:top){.card{color:red}}

Grid 2: grid-template-areas
  $ cat << "EOF" | ./Render_test.exe
  > .x { grid-template-areas: "nav  main" ".    foot" }
  > EOF
  .x{grid-template-areas:"nav  main" ".    foot"}
  $ cat << "EOF" | ./Render_test.exe
  > .x { grid-template-areas: ".  ." }
  > EOF
  .x{grid-template-areas:".  ."}
  $ cat << "EOF" | ./Render_test.exe
  > .x { content: "nav  main" }
  > EOF
  .x{content:"nav  main"}

Nesting 1
  $ cat << "EOF" | ./Render_test.exe
  > .card { color: red; & > img { display: block } }
  > EOF
  .card{color:red}.card>img{display:block}
  $ cat << "EOF" | ./Render_test.exe
  > .card { @scope (&) to (.boundary) { & .title { color: blue } } }
  > EOF
  @scope (&) to (.boundary){.card .title{color:blue}}
  $ cat << "EOF" | ./Render_test.exe
  > .card { @media (width >= 40em) { & > img { display: block } } }
  > EOF
  @media (width >= 40em){.card>img{display:block}}

Variables 1: custom properties
  $ cat << "EOF" | ./Render_test.exe
  > :root { --primary-color: blue }
  > EOF
  :root{--primary-color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: var(--primary-color) }
  > EOF
  .x{color:var(--primary-color)}

Fonts 4: @font-face
  $ cat << "EOF" | ./Render_test.exe
  > @font-face { font-family: MyFont; src: url(font.woff2); }
  > EOF
  @font-face{font-family:MyFont;src:url("font.woff2")}
  $ cat << "EOF" | ./Render_test.exe
  > @font-face { font-family: Brand; src: url("brand.woff2") format("woff2"); font-display: swap; unicode-range: U+0025-00FF; }
  > EOF
  @font-face{font-family:Brand;src:url("brand.woff2") format("woff2");font-display:swap;unicode-range:U+0025-00FF}

Animations 1: @keyframes
  $ cat << "EOF" | ./Render_test.exe
  > @keyframes slide { 0% { opacity: 0 } 100% { opacity: 1 } }
  > EOF
  @keyframes slide{0%{opacity:0}100%{opacity:1}}

Selectors 4: compound selectors
  $ cat << "EOF" | ./Render_test.exe
  > div.container { margin: auto }
  > EOF
  div.container{margin:auto}
  $ cat << "EOF" | ./Render_test.exe
  > div#main { display: flex }
  > EOF
  div#main{display:flex}
  $ cat << "EOF" | ./Render_test.exe
  > a:hover { color: red }
  > EOF
  a:hover{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > a.link:hover { color: red }
  > EOF
  a.link:hover{color:red}

Properties & Values API: @property
  $ cat << "EOF" | ./Render_test.exe
  > @property --color { syntax: "<color>"; inherits: true; initial-value: red }
  > EOF
  @property --color{syntax:"<color>";inherits:true;initial-value:red}

Value fidelity: CSS 2.x forms
  $ cat << "EOF" | ./Render_test.exe
  > body *[lang|="en"] + p:first-line { color: red }
  > EOF
  body [lang|=en]+p:first-line{color:red}

Value fidelity: at-rule forms
  $ cat << "EOF" | ./Render_test.exe
  > @import "legacy.css";
  > EOF
  @import "legacy.css";
  $ cat << "EOF" | ./Render_test.exe
  > @import url(reset.css);
  > EOF
  @import url("reset.css");
  $ cat << "EOF" | ./Render_test.exe
  > @namespace "http://www.w3.org/1999/xhtml";
  > EOF
  @namespace "http://www.w3.org/1999/xhtml";
  $ cat << "EOF" | ./Render_test.exe
  > @namespace url("http://www.w3.org/1999/xhtml");
  > EOF
  @namespace url("http://www.w3.org/1999/xhtml");
  $ cat << "EOF" | ./Render_test.exe
  > @namespace svg "http://www.w3.org/2000/svg";
  > EOF
  @namespace svg "http://www.w3.org/2000/svg";
  $ cat << "EOF" | ./Render_test.exe
  > @namespace svg url("http://www.w3.org/2000/svg");
  > EOF
  @namespace svg url("http://www.w3.org/2000/svg");

Value fidelity: selector forms
  $ cat << "EOF" | ./Render_test.exe
  > ::first-letter { color: red }
  > EOF
  ::first-letter{color:red}

Value fidelity: value forms
  $ cat << "EOF" | ./Render_test.exe
  > .x { background-image: url("hero image.png") }
  > EOF
  .x{background-image:url("hero image.png")}
  $ cat << "EOF" | ./Render_test.exe
  > .x { background-image: url(hero.png) }
  > EOF
  .x{background-image:url("hero.png")}

Value fidelity: color forms
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: #ff0000 }
  > EOF
  .x{color:#ff0000}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: #f00f }
  > EOF
  .x{color:#f00f}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: #ff0000ff }
  > EOF
  .x{color:#ff0000ff}
  $ cat << "EOF" | ./Render_test.exe
  > .x { color: attr(data-color type(<color>), red) }
  > EOF
  .x{color:attr(data-color type(<color>),red)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: attr(data-w px, 10px) }
  > EOF
  .x{width:attr(data-w px,10px)}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: attr(data-w px, calc(100% - 1rem)) }
  > EOF
  .x{width:attr(data-w px,calc(100% - 1rem))}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: attr(data-w px, calc(10px + 0px)) }
  > EOF
  .x{width:attr(data-w px,calc(10px + 0px))}
  $ cat << "EOF" | ./Render_test.exe
  > .x { width: attr(data-w px, var(--fallback, 10px)) }
  > EOF
  .x{width:attr(data-w px,var(--fallback,10px))}
  $ cat << "EOF" | ./Render_test.exe
  > .x { --label: attr(data-label raw-string, "x y") }
  > EOF
  .x{--label:attr(data-label raw-string, "x y")}
  $ cat << "EOF" | ./Render_test.exe
  > .x { --label: attr(data-label raw-string, var(--label, "x y")) }
  > EOF
  .x{--label:attr(data-label raw-string, var(--label, "x y"))}

Value fidelity: cascade forms
  $ cat << "EOF" | ./Render_test.exe
  > @import url(theme.css) layer(theme) supports(display: grid) screen;
  > EOF
  @import url("theme.css") layer(theme) supports(display:grid) screen;
  $ cat << "EOF" | ./Render_test.exe
  > @import "theme.css" layer(theme) supports(display: grid) screen;
  > EOF
  @import "theme.css" layer(theme) supports(display:grid) screen;

Value fidelity: font and animation forms
  $ cat << "EOF" | ./Render_test.exe
  > @font-face { font-family: Brand; src: url(brand.woff2) format("woff2") }
  > EOF
  @font-face{font-family:Brand;src:url("brand.woff2") format("woff2")}

Serialization invariants
  $ cat << "EOF" | ./Render_test.exe
  > @charset "UTF-8"; @import url(theme.css) layer(theme) supports(display: grid) screen; @namespace svg url(http://www.w3.org/2000/svg); svg|circle { fill: red }
  > EOF
  @charset "UTF-8";@import url("theme.css") layer(theme) supports(display:grid) screen;@namespace svg url("http://www.w3.org/2000/svg");svg|circle{fill:red}
  $ cat << "EOF" | ./Render_test.exe
  > @layer reset, theme; @layer theme { .btn::before { content: ""; color: rgb(255 0 0 / 50%) } }
  > EOF
  @layer reset,theme;@layer theme{.btn::before{content:"";color:rgb(255 0 0 / 50%)}}
  $ cat << "EOF" | ./Render_test.exe
  > @media (min-width: 30em) { @supports (display: grid) { @container card (inline-size > 40em) { .x { display: grid } } } }
  > EOF
  @media (min-width:30em){@supports (display:grid){@container card (inline-size > 40em){.x{display:grid}}}}
  $ cat << "EOF" | ./Render_test.exe
  > @scope (.card) to (.footer) { .item { color: var(--brand, color-mix(in srgb, red, blue)) } }
  > EOF
  @scope (.card) to (.footer){.item{color:var(--brand,color-mix(in srgb,red,blue))}}
  $ cat << "EOF" | ./Render_test.exe
  > @font-face { font-family: Brand; src: url("brand.woff2") format("woff2"); unicode-range: U+0025-00FF }
  > EOF
  @font-face{font-family:Brand;src:url("brand.woff2") format("woff2");unicode-range:U+0025-00FF}
  $ cat << "EOF" | ./Render_test.exe
  > @keyframes fade { from { opacity: 0 } to { opacity: 1 } }
  > EOF
  @keyframes fade{from{opacity:0}to{opacity:1}}
  $ cat << "EOF" | ./Render_test.exe
  > @property --gap { syntax: "<length>"; inherits: false; initial-value: 1rem }
  > EOF
  @property --gap{syntax:"<length>";inherits:false;initial-value:1rem}

Minified shortest forms
  $ cat << "EOF" | ./Render_test.exe
  > @import url(foo.css);
  > EOF
  @import url("foo.css");
  $ cat << "EOF" | ./Render_test.exe
  > @import url(foo.css) print;
  > EOF
  @import url("foo.css") print;
  $ cat << "EOF" | ./Render_test.exe
  > @import url(foo.css) layer(theme) supports(display: flex) print;
  > EOF
  @import url("foo.css") layer(theme) supports(display:flex) print;
  $ cat << "EOF" | ./Render_test.exe
  > @scope (.card) to (.footer, .aside) { .title { color: blue } }
  > EOF
  @scope (.card) to (.footer,.aside){.title{color:blue}}
  $ cat << "EOF" | ./Render_test.exe
  > ::first-line { color: blue }
  > EOF
  ::first-line{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > ::first-letter { color: blue }
  > EOF
  ::first-letter{color:blue}
  $ cat << "EOF" | ./Render_test.exe
  > .x { transition-duration: 500ms }
  > EOF
  .x{transition-duration:500ms}

Selectors 4: attribute case-sensitivity flags
  $ cat << "EOF" | ./Render_test.exe
  > [type="text" i] { color: red }
  > EOF
  [type=text i]{color:red}
  $ cat << "EOF" | ./Render_test.exe
  > [data-state=on s] { color: red }
  > EOF
  [data-state=on s]{color:red}

Selectors 4: nth-child of <selector-list>
  $ cat << "EOF" | ./Render_test.exe
  > li:nth-child(2n of .highlighted, .starred) { color: red }
  > EOF
  li:nth-child(2n of .highlighted,.starred){color:red}
  $ cat << "EOF" | ./Render_test.exe
  > :nth-child(odd of .x) { color: red }
  > EOF
  :nth-child(odd of .x){color:red}

Selectors 4: column combinator
  $ cat << "EOF" | ./Render_test.exe
  > .grid || td { background: silver }
  > EOF
  .grid||td{background:silver}

Functional pseudo-elements
  $ cat << "EOF" | ./Render_test.exe
  > ::part(button) { color: red }
  > ::slotted(span.active) { color: red }
  > ::highlight(range) { background: yellow }
  > EOF
  ::part(button){color:red}::slotted(span.active){color:red}::highlight(range){background:yellow}

Selectors 4: no-namespace universal
  $ cat << "EOF" | ./Render_test.exe
  > |* { fill: red }
  > *|* { fill: red }
  > EOF
  |*{fill:red}*|*{fill:red}

Custom property values are an observable token stream: edge-trimmed only,
never minified (whitespace around commas/colons, function bodies preserved)
  $ cat << "EOF" | ./Render_test.exe
  > --x: a , b;
  > --y: foo( a , b );
  > --z: foo : bar;
  > color: rgb(1 , 2 , 3);
  > EOF
  --x:a , b;--y:foo( a , b );--z:foo : bar;color:rgb(1,2,3)

Component values preserve CDO/CDC and column-combinator delims
(all valid <declaration-value> content)
  $ cat << "EOF" | ./Render_test.exe
  > --a: x --> y;
  > --b: <!-- x;
  > --c: x || y;
  > EOF
  --a:x --> y;--b:<!-- x;--c:x || y

@supports selector() with a column combinator
  $ cat << "EOF" | ./Render_test.exe
  > @supports selector(col || td) { color: red }
  > EOF
  @supports selector(col || td){color:red}

Hash tokens keep a leading dash (mark/backtrack regression)
  $ cat << "EOF" | ./Render_test.exe
  > --x: #-5;
  > --y: #-2px;
  > EOF
  --x:#-5;--y:#-2px

Identifiers with code points outside the lexer ident set re-escape
  $ cat << "EOF" | ./Render_test.exe
  > .a\80 x { color: red }
  > .café { color: red }
  > EOF
  .a\80 x{color:red}.café{color:red}
