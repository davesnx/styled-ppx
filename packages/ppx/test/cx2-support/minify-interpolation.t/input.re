let myColor = CSS.hex("ff0000");
let mySize = `px(20);

let styles1 = [%cx2 {|color: $(myColor)|}];

let styles2 = [%cx2 {|margin: $(mySize); padding: $(mySize)|}];

let bgColor = CSS.rgb(255, 255, 255);
let styles3 = [%cx2 {|background-color: $(bgColor); border: 1px solid $(myColor)|}];

