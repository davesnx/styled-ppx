/* Static extraction must reject `$(name)` interpolation inside
   `url(...)`. CSS does not perform `var()` substitution inside the
   `url()` token: browsers consume the body as a literal string, so
   `url(var(--x))` would resolve to the string "var(--x)" and the
   resource would never load. The PPX raises a clear error and steers
   the user at literal-string alternatives (or moving the whole
   declaration value behind a single interpolation). */

let inter_url = "https://cdn.example.com/fonts/inter.woff2";

module Fonts = [%styled.global
  {|
  @font-face {
    font-family: "Inter";
    src: url($(inter_url)) format("woff2");
    font-display: swap;
  }
|}
];
