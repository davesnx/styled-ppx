let color = "red";
let _item = [%css
  {|
  background-color: $(color);

  & + .sibling {
    border-color: $(color);
  }
|}
];
