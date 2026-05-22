let tone = CSS.red;

module Box = [%styled.div {|
color: red;
&:hover {
  color: $(tone);
}
|}];

module Button = [%styled.button
  (~color: CSS.Types.Color.t) => {|
color: $(color);
padding: 8px;
|}
];

let card = [%css
  {|
.$(Box) {
  margin: 0;
}
.$(Button) {
  display: block;
}
|}
];
