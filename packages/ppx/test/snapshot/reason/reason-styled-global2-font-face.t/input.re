/* @font-face inside [%styled.global].

   @font-face is a global at-rule and belongs in the global extraction
   channel. Each @font-face block ships through [@@@css ...] just like
   any other global rule. No runtime side-effects, no global stylesheet
   mutation - the font registers when the extracted .css loads. */

module Fonts = [%styled.global
  {|
  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter.woff2") format("woff2");
    font-display: swap;
    font-weight: 400;
    font-style: normal;
  }

  @font-face {
    font-family: "Inter";
    src: url("/fonts/inter-bold.woff2") format("woff2");
    font-display: swap;
    font-weight: 700;
    font-style: normal;
  }
|}
];
