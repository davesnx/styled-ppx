/* ascent-override only accepts 'normal' or a percentage: a length must
   be rejected at compile time. */

module Broken = [%styled.global
  {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    ascent-override: 12px;
  }
|}
];
