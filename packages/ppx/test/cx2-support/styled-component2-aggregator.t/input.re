let tone = CSS.red;

module Box = [%styled.div2 {|
color: red;
&:hover {
  color: $(tone);
}
|}];

module Button = [%styled.button2
  (~color: CSS.Types.Color.t) => {|
color: $(color);
padding: 8px;
|}
];

let card = [%cx2 {|
.$(Box) {
  margin: 0;
}
.$(Button) {
  display: block;
}
|}];
