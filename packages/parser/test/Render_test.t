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
  height:20px;width:20%;width:20.832%;color:red;content:"not emoji";color:lch(from rebeccapurple l c calc(h + 80));color:#f00;opacity:0.7;content:url("../../media/examples/fire.png");content:image-set("image1x.png" 1x, "image2x.png" 2x);content:url("../img/test.png") / "This is the alt text";content:url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico") " - alt text is not supported - ";content:url("https://mozorg.cdn.mozilla.net/media/img/favicon.ico") / " MOZILLA: ";font:x-small Arial, sans-serif;flex-grow:3;grid-template-columns:[line-name1] 100px [line-name2] repeat(auto-fit, [line-name3 line-name4] 300px) 100px;unicode-range:U+26;unicode-range:U+0-7F;unicode-range:U+0025-00FF;unicode-range:U+4??;unicode-range:U+0025-00FF, U+4??;

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
  li:nth-child(even){foo:bar;}li:nth-child(odd){foo:bar;}li:nth-child(5){foo:bar;}li:nth-child(n){foo:bar;}li:nth-child(-4n+10){foo:bar;}li:nth-child(3n-6){foo:bar;}li:nth-child(3n+-6){foo:bar;}li:nth-child(3n+1){foo:bar;}li:nth-child(-n+6){foo:bar;}

Remove empty rules
  $ cat <<"EOF" | run
  > .foo {}
  > .bar { color: red; }
  > /* .foo2 rule will be discarded */
  > .foo2 { .bar2 { color: red; } }
  > EOF
  .bar{color:red;}.foo2 .bar2{color:red;}

Split multiple selectors
  $ cat <<"EOF" | run
  > .foo, .bar { color: red; }
  > EOF
  .foo{color:red;}.bar{color:red;}

Split multiple selectors
  $ cat <<"EOF" | run
  > .foo, .bar { color: red; }
  > EOF
  .foo{color:red;}.bar{color:red;}

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
  .foo{font-size:1px;}.foo .lola{font-size:2px;}.foo .lola .foo{font-size:3px;}.lola .foo{font-size:4px;}.foo .lola{font-size:5px;}.lola .foo .foo .foo .foo .lola{font-size:6px;}

Resolve nested pseudo class and pseudo element
  $ cat <<"EOF" | run
  > h3.foo#baz[data-foo=bar] {
  >   :hover { color: red; }
  >   :nth-child(even) { color: red; }
  >   ::first-line { color: red; }
  > }
  > EOF
  h3.foo#baz[data-foo=bar]:hover{color:red;}h3.foo#baz[data-foo=bar]:nth-child(even){color:red;}h3.foo#baz[data-foo=bar]::first-line{color:red;}

Resolve nested other than pseudo class and pseudo element
  $ cat <<"EOF" | run
  > h3.foo#baz[data-foo=bar] {
  >   .color { color: red; }
  >   #what { color: red; }
  >   [data-foo=bar] { color: red; }
  > }
  > EOF
  h3.foo#baz[data-foo=bar] .color{color:red;}h3.foo#baz[data-foo=bar] #what{color:red;}h3.foo#baz[data-foo=bar] [data-foo=bar]{color:red;}

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
  .foo .bar[data-foo=bar]#baz:nth-child(even){color:red;}.foo .bar[data-foo=bar]#baz:hover{color:red;}.foo .bar[data-foo=bar]#baz.color{color:red;}.foo .bar[data-foo=bar]#baz[data-baz=bar]{color:red;}.foo .bar[data-foo=bar]#baz#myid{color:red;}

Nested with media query
  $ cat <<"EOF" | run
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
  li{list-style-type:none;}li::before{position:absolute;left:-20px;content:"check";}@media screen and (min-width: 600px) {li{position:relative;}}

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
  li{position:relative;}li:hover::after{top:50px;}

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
  li{position:relative;}li:hover ::after{top:50px;}

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
  .foo{display:block;}.foo div{display:flex;}@media (min-width: 768px) {.foo div{height:auto;}}

Selector nested
  $ cat <<"EOF" | run
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
  display:flex;a{display:block;}a div{display:none;}a div span{display:none;}a div span hr{display:none;}a div span hr code{display:none;}

Media query nested
  $ cat <<"EOF" | run
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
  max-width:800px;@media (min-width: 300px) {margin-left:10px;}@media (min-width: 300px) and (max-width: 768px) {position:fixed;}@media (max-width: 768px) and (min-width: 300px) and (max-width: 1200px) {border:1px solid transparent;}@media (max-width: 1200px) and (min-width: 300px) and (max-width: 768px) and (max-width: 1200px) {border:1px solid transparent;}@media (max-width: 1200px) and (max-width: 768px) and (min-width: 300px) and (max-width: 1200px) and (max-width: 1200px) {border:1px solid transparent;}@media (max-width: 1200px) and (max-width: 1200px) and (min-width: 300px) and (max-width: 768px) and (max-width: 1200px) and (max-width: 1200px) {border:1px solid transparent;}

Complex selector test
  $ cat <<"EOF" | run
  > div#main.container[data-role="content"]:not(:empty):nth-child(2n+1) > ul li:nth-of-type(odd):first-child a[target="_blank"]:hover,
  > section[lang|="en"] + article#special ~ aside:last-of-type *,
  > input[type="checkbox"]:checked:focus,
  > p::before {
  >   color: red;
  > }
  > EOF
  div#main.container[data-role="content"]:not(:empty):nth-child(2n+1) > ul li:nth-of-type(odd):first-child a[target="_blank"]:hover{color:red;}section[lang|="en"] + article#special ~ aside:last-of-type *{color:red;}input[type="checkbox"]:checked:focus{color:red;}p::before{color:red;}
