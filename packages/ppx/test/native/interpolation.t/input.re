module Size = {
  let big = `px(24);
  let small = `px(8);
  let px30 = `px(30);
};

module Color = {
  module Border = {
    let alpha = CSS.rgba(0, 0, 0, `num(0.4));
  };

  let red = "red";
};

module Theme = {
  let blue = CSS.hex("00f");
};

module BoxShadow = {
  let elevation = [|
    CSS.Shadow.box(
      ~x=`px(1),
      ~y=`px(2),
      ~blur=`px(3),
      CSS.hex("000"),
    ),
  |];
};

let mono100 = CSS.hex("fefefe");
let width = `px(100);
let max = `px(200);
let height = `px(80);
let border = `px(4);
let font = `px(16);
let mono: CSS.Types.FontFamily.t = `quoted("Mono");
let lh = `abs(1.5);
let zLevel = `num(10);
let left = `px(12);
let decorationColor = CSS.hex("ccc");
let wat = `url("background.png");
let externalImageUrl = `url("mask.svg");
let h = `px(1);
let v = `px(2);
let blur = `px(3);
let spread = `px(4);
let color = CSS.hex("000");
let clip = `clip;
let duration = `ms(200);
let state = `running;

let _ = [%css "color: $(mono100)"];
let _ = [%css "margin: $(Size.big) $(Size.small)"];
let _ = [%css "color: $(mono100)"];
let _ = [%css "padding: $(Size.small) 0px"];
let _ = [%css "border: 1px solid $(Color.Border.alpha)"];
let _ = [%css "outline: 1px solid $(Color.Border.alpha)"];
let _ = [%css "border-bottom: 0px solid $(Color.Border.alpha)"];
let _ = [%css "width: $(width)"];
let _ = [%css "max-width: $(max)"];
let _ = [%css "height: $(height)"];
let _ = [%css "border-radius: $(border)"];
let _ = [%css "font-size: $(font)"];
let _ = [%css "font-family: $(mono)"];
let _ = [%css "line-height: $(lh)"];
let _ = [%css "z-index: $(zLevel)"];
let _ = [%css "left: $(left)"];
let _ = [%css "text-decoration-color: $(decorationColor)"];
let _ = [%css "background-image: $(wat);"];
let _ = [%css "mask-image: $(externalImageUrl);"];
let _ = [%css "text-shadow: $(h) $(v) $(blur) $(color)"];
let _ = [%css "color: $(Theme.blue)"];
let _ = [%css "box-shadow: $(h) $(v) $(blur) $(spread) $(color)"];
let _ = [%css "box-shadow: 10px 10px 0px $(spread) $(color)"];
let _ = [%css "box-shadow: $(BoxShadow.elevation)"];
let _ = [%css "box-shadow: none"];
let _ = [%css "text-overflow: $(clip)"];
let _ = [%css "transition-duration: 500ms"];
let _ = [%css "transition-duration: $(duration)"];
let _ = [%css "animation-play-state: $(state)"];
let _ = [%css "animation-play-state: paused"];
let _ = [%css "column-gap: $(Size.px30)"];
let _ = [%css "-webkit-text-fill-color: $(Color.red)"];
