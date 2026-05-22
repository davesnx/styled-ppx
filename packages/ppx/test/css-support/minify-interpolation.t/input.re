let myColor = CSS.hex("ff0000");
let mySize = `px(20);

let styles1 = [%css {|color: $(myColor)|}];

let styles2 = [%css {|margin: $(mySize); padding: $(mySize)|}];

let bgColor = CSS.rgb(255, 255, 255);
let styles3 = [%css
  {|background-color: $(bgColor); border: 1px solid $(myColor)|}
];
