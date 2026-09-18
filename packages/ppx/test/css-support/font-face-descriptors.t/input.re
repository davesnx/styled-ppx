/* css-fonts-5 @font-face metric-override descriptors (issue #580):
   ascent-override, descent-override, line-gap-override and size-adjust
   validate at compile time inside [%styled.global]. */

module Fonts = [%styled.global
  {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    ascent-override: 90%;
    descent-override: normal;
    line-gap-override: 0%;
    size-adjust: 105.5%;
  }
|}
];

let _ = Fonts.make;
