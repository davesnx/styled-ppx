/* css-fonts-5 metric-override descriptors (issue #580): they are @font-face
   descriptors, not properties, so a [%css] block must reject them. */

let title = [%css {|
  font-family: "Inter";
  size-adjust: 100%;
|}];
