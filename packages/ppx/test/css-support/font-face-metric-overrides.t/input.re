module Fonts = [%styled.global {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    ascent-override: 90%;
    descent-override: normal;
    line-gap-override: 10%;
    size-adjust: 100%;
  }
|}];
