let r07_v1 = CSS.px(71);
let r07_a = [%css {|
  padding-top: $(r07_v1);
  &:hover { padding-top: $(r07_v1); }
  @media (max-width: 1200px) { padding-top: $(r07_v1); }
|}];
