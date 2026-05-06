/* @font-face with an interpolated src URL.

   The font URL comes from runtime config (e.g. an asset CDN base).
   The static side emits `src: url(var(--var-<hash>))` so the rule
   ships through [@@@css ...]; `to_string` emits the matching
   :root { --var-<hash>: <url>; } at runtime. */

let inter_url = "https://cdn.example.com/fonts/inter.woff2";

module Fonts = [%styled.global2 {|
  @font-face {
    font-family: "Inter";
    src: url($(inter_url)) format("woff2");
    font-display: swap;
  }
|}];
