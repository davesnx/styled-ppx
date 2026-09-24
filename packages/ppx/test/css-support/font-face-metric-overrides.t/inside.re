/* css-fonts-5 metric-override descriptors (issue #580): an @font-face body
   takes descriptors only, so an ordinary property inside one is rejected. */

module Fonts = [%styled.global {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    color: red;
  }
|}];
