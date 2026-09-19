/* css-fonts-5 metric-override descriptors (issue #580): an out-of-grammar
   value must name the offending descriptor in the error. */

module Fonts = [%styled.global {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    ascent-override: 12px;
    descent-override: normal;
    line-gap-override: 10%;
    size-adjust: 100%;
  }
|}];
