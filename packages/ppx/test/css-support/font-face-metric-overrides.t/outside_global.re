/* css-fonts-5 metric-override descriptors (issue #580): they are @font-face
   descriptors, not properties, so a regular style rule must reject them. */

module Styles = [%styled.global {|
  .title {
    font-family: "Inter";
    ascent-override: 90%;
  }
|}];
