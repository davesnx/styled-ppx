let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);
let both = [%css
  {|
  color: $(color);
  padding: $(width);
  &:hover { color: $(color) }
  @media (max-width: 768px) { color: $(color) }
|}
];
let mixed = [%css "display: flex; color: $(color)"];
