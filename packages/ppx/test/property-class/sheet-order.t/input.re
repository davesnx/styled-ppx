let color = CSS.Types.Color.toString(`hex("3A57FC"));
let box = [%css
  {|
  padding-top: 1px;
  padding: 2px;
  color: $(color);
  &:hover { color: red }
  @media (min-width: 1px) { margin: 0 }
  & > * { margin: 1px }
  & + & { margin-top: 3px }
|}
];
let flat = [%css "padding-left: 4px; margin-top: 5px"];
