let common = backgroundColor => [%css
  {|
  background-color: $(backgroundColor);
|}
];

let clickable = backgroundColor => [%css
  {|
  &:hover {
    background-color: $(backgroundColor);
  }
|}
];
