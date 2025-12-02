module Color = {
  module Background = {
    let boxDark = `hex("000000");
  };
  module Shadow = {
    let elevation1 = `rgba((0, 0, 0, `num(0.03)));
  };
};

/* CSS Backgrounds and Borders Module Level 3 */
[%cx2 {|background-repeat: space|}];
[%cx2 {|background-repeat: round|}];
[%cx2 {|background-repeat: repeat repeat|}];
[%cx2 {|background-repeat: space repeat|}];
[%cx2 {|background-repeat: round repeat|}];
[%cx2 {|background-repeat: no-repeat repeat|}];
[%cx2 {|background-repeat: repeat space|}];
[%cx2 {|background-repeat: space space|}];
[%cx2 {|background-repeat: round space|}];
[%cx2 {|background-repeat: no-repeat space|}];
[%cx2 {|background-repeat: repeat round|}];
[%cx2 {|background-repeat: space round|}];
[%cx2 {|background-repeat: round round|}];
[%cx2 {|background-repeat: no-repeat round|}];
[%cx2 {|background-repeat: repeat no-repeat|}];
[%cx2 {|background-repeat: space no-repeat|}];
[%cx2 {|background-repeat: round no-repeat|}];
[%cx2 {|background-repeat: no-repeat no-repeat|}];
[%cx2 {|background-repeat: repeat-x, repeat-y|}];
[%cx2 {|background-attachment: local|}];
[%cx2 {|background-clip: border-box|}];
[%cx2 {|background-clip: padding-box|}];
[%cx2 {|background-clip: content-box|}];
[%cx2 {|background-clip: text|}];
[%cx2 {|background-clip: border-area|}];
[%cx2 {|background-clip: text, border-area|}];
[%cx2 {|background-origin: border-box|}];
[%cx2 {|background-origin: padding-box|}];
[%cx2 {|background-origin: content-box|}];
[%cx2 {|background-size: auto|}];
[%cx2 {|background-size: cover|}];
[%cx2 {|background-size: contain|}];
[%cx2 {|background-size: 10px|}];
[%cx2 {|background-size: 50%|}];
[%cx2 {|background-size: 10px auto|}];
[%cx2 {|background-size: auto 10%|}];
[%cx2 {|background-size: 50em 50%|}];
[%cx2 {|background-size: 20px 20px|}];
/* [%cx2 {|background: url(foo.png), url(bar.svg)|}]; */
[%cx2 {|background: top left / 50% 60%|}];
[%cx2 {|background: border-box|}];
[%cx2 {|background: blue|}];
[%cx2 {|background: border-box red|}];
/* [%cx2 {|background: fixed;|}]; */
[%cx2 {|background: border-box padding-box|}];
[%css
  {|background: url(foo.png) bottom right / cover padding-box content-box|}
];
[%cx2 {|border-top-left-radius: 0|}];
[%cx2 {|border-top-left-radius: 50%|}];
[%cx2 {|border-top-left-radius: 250px 100px|}];
[%cx2 {|border-top-right-radius: 0|}];
[%cx2 {|border-top-right-radius: 50%|}];
[%cx2 {|border-top-right-radius: 250px 100px|}];
[%cx2 {|border-bottom-right-radius: 0|}];
[%cx2 {|border-bottom-right-radius: 50%|}];
[%cx2 {|border-bottom-right-radius: 250px 100px|}];
[%cx2 {|border-bottom-left-radius: 0|}];
[%cx2 {|border-bottom-left-radius: 50%|}];
[%cx2 {|border-bottom-left-radius: 250px 100px|}];
[%cx2 {|border-radius: 10px|}];
[%cx2 {|border-radius: 50%|}];
/* [%cx2 {|border-radius: 10px / 20px|}]; */
/* [%cx2 {|border-radius: 2px 4px 8px 16px|}]; */
/* [%cx2 {|border-radius: 2px 4px 8px 16px / 2px 4px 8px 16px|}]; */
[%cx2 {|border-image-source: none|}];
[%cx2 {|border-image-source: url(foo.png)|}];
[%cx2 {|border-image-slice: 10|}];
[%cx2 {|border-image-slice: 30%|}];
[%cx2 {|border-image-slice: 10 10|}];
[%cx2 {|border-image-slice: 30% 10|}];
[%cx2 {|border-image-slice: 10 30%|}];
[%cx2 {|border-image-slice: 30% 30%|}];
[%cx2 {|border-image-slice: 10 10 10|}];
[%cx2 {|border-image-slice: 30% 10 10|}];
[%cx2 {|border-image-slice: 10 30% 10|}];
[%cx2 {|border-image-slice: 30% 30% 10|}];
[%cx2 {|border-image-slice: 10 10 30%|}];
[%cx2 {|border-image-slice: 30% 10 30%|}];
[%cx2 {|border-image-slice: 10 30% 30%|}];
[%cx2 {|border-image-slice: 30% 30% 30%|}];
[%cx2 {|border-image-slice: 10 10 10 10|}];
[%cx2 {|border-image-slice: 30% 10 10 10|}];
[%cx2 {|border-image-slice: 10 30% 10 10|}];
[%cx2 {|border-image-slice: 30% 30% 10 10|}];
[%cx2 {|border-image-slice: 10 10 30% 10|}];
[%cx2 {|border-image-slice: 30% 10 30% 10|}];
[%cx2 {|border-image-slice: 10 30% 30% 10|}];
[%cx2 {|border-image-slice: 30% 30% 30% 10|}];
[%cx2 {|border-image-slice: 10 10 10 30%|}];
[%cx2 {|border-image-slice: 30% 10 10 30%|}];
[%cx2 {|border-image-slice: 10 30% 10 30%|}];
[%cx2 {|border-image-slice: 30% 30% 10 30%|}];
[%cx2 {|border-image-slice: 10 10 30% 30%|}];
[%cx2 {|border-image-slice: 30% 10 30% 30%|}];
[%cx2 {|border-image-slice: 10 30% 30% 30%|}];
[%cx2 {|border-image-slice: 30% 30% 30% 30%|}];
[%cx2 {|border-image-slice: fill 30%|}];
[%cx2 {|border-image-slice: fill 10|}];
[%cx2 {|border-image-slice: fill 2 4 8% 16%|}];
[%cx2 {|border-image-slice: 30% fill|}];
[%cx2 {|border-image-slice: 10 fill|}];
[%cx2 {|border-image-slice: 2 4 8% 16% fill|}];
[%cx2 {|border-image-width: 10px|}];
[%cx2 {|border-image-width: 5%|}];
[%cx2 {|border-image-width: 28|}];
[%cx2 {|border-image-width: auto|}];
[%cx2 {|border-image-width: 10px 10px|}];
[%cx2 {|border-image-width: 5% 10px|}];
[%cx2 {|border-image-width: 28 10px|}];
[%cx2 {|border-image-width: auto 10px|}];
[%cx2 {|border-image-width: 10px 5%|}];
[%cx2 {|border-image-width: 5% 5%|}];
[%cx2 {|border-image-width: 28 5%|}];
[%cx2 {|border-image-width: auto 5%|}];
[%cx2 {|border-image-width: 10px 28|}];
[%cx2 {|border-image-width: 5% 28|}];
[%cx2 {|border-image-width: 28 28|}];
[%cx2 {|border-image-width: auto 28|}];
[%cx2 {|border-image-width: 10px auto|}];
[%cx2 {|border-image-width: 5% auto|}];
[%cx2 {|border-image-width: 28 auto|}];
[%cx2 {|border-image-width: auto auto|}];
[%cx2 {|border-image-width: 10px 10% 10|}];
[%cx2 {|border-image-width: 5% 10px 20 auto|}];
[%cx2 {|border-image-outset: 10px|}];
[%cx2 {|border-image-outset: 20|}];
[%cx2 {|border-image-outset: 10px 20|}];
[%cx2 {|border-image-outset: 10px 20px|}];
[%cx2 {|border-image-outset: 20 30|}];
[%cx2 {|border-image-outset: 2px 3px 4|}];
[%cx2 {|border-image-outset: 1 2px 3px 4|}];
[%cx2 {|border-image-repeat: stretch|}];
[%cx2 {|border-image-repeat: repeat|}];
[%cx2 {|border-image-repeat: round|}];
[%cx2 {|border-image-repeat: space|}];
[%cx2 {|border-image-repeat: stretch stretch|}];
[%cx2 {|border-image-repeat: repeat stretch|}];
[%cx2 {|border-image-repeat: round stretch|}];
[%cx2 {|border-image-repeat: space stretch|}];
[%cx2 {|border-image-repeat: stretch repeat|}];
[%cx2 {|border-image-repeat: repeat repeat|}];
[%cx2 {|border-image-repeat: round repeat|}];
[%cx2 {|border-image-repeat: space repeat|}];
[%cx2 {|border-image-repeat: stretch round|}];
[%cx2 {|border-image-repeat: repeat round|}];
[%cx2 {|border-image-repeat: round round|}];
[%cx2 {|border-image-repeat: space round|}];
[%cx2 {|border-image-repeat: stretch space|}];
[%cx2 {|border-image-repeat: repeat space|}];
[%cx2 {|border-image-repeat: round space|}];
[%cx2 {|border-image-repeat: space space|}];
[%cx2 {|border-image: url(foo.png) 10|}];
[%cx2 {|border-image: url(foo.png) 10%|}];
[%cx2 {|border-image: url(foo.png) 10% fill|}];
[%cx2 {|border-image: url(foo.png) 10 round|}];
[%cx2 {|border-image: url(foo.png) 10 stretch repeat|}];
[%cx2 {|border-image: url(foo.png) 10 / 10px|}];
[%cx2 {|border-image: url(foo.png) 10 / 10% / 10px|}];
[%cx2 {|border-image: url(foo.png) fill 10 / 10% / 10px|}];
[%cx2 {|border-image: url(foo.png) fill 10 / 10% / 10px space|}];
/* The following shadow declarations are not supported in the CSS Parser */
/* [%cx2 {|box-shadow: 1px 1px|}]; */
/* [%cx2 {|box-shadow: 0 0 black|}]; */
/* [%cx2 {|box-shadow: 1px 2px 3px black|}]; */
[%cx2 {|box-shadow: 1px 2px 3px 4px black|}];
[%cx2 {|box-shadow: inset 1px 2px 3px 4px black|}];
[%cx2 {|box-shadow: inset 1px 2px 3px 4px black, 1px 2px 3px 4px black|}];
[%css
  {|box-shadow: -1px 1px 0px 0px $(Color.Shadow.elevation1),
            1px 1px 0px 0px $(Color.Shadow.elevation1),
            0px -1px 0px 0px $(Color.Shadow.elevation1);|}
];

/* CSS Backgrounds and Borders Module Level 4 */
[%cx2 {|background-position-x: right|}];
[%cx2 {|background-position-x: center|}];
[%cx2 {|background-position-x: 50%|}];
[%cx2 {|background-position-x: left, left|}];
[%cx2 {|background-position-x: left, right|}];
[%cx2 {|background-position-x: right, left|}];
[%cx2 {|background-position-x: left, 0%|}];
[%cx2 {|background-position-x: 10%, 20%, 40%|}];
[%cx2 {|background-position-x: 0px|}];
[%cx2 {|background-position-x: 30px|}];
[%cx2 {|background-position-x: 0%, 10%, 20%, 30%|}];
[%cx2 {|background-position-x: left, left, left, left, left|}];
[%cx2 {|background-position-x: calc(20px)|}];
[%cx2 {|background-position-x: calc(20px + 1em)|}];
[%cx2 {|background-position-x: calc(20px / 2)|}];
[%cx2 {|background-position-x: calc(20px + 50%)|}];
[%cx2 {|background-position-x: calc(50% - 10px)|}];
[%cx2 {|background-position-x: calc(-20px)|}];
[%cx2 {|background-position-x: calc(-50%)|}];
[%cx2 {|background-position-x: calc(-20%)|}];
[%cx2 {|background-position-x: right 20px|}];
[%cx2 {|background-position-x: left 20px|}];
[%cx2 {|background-position-x: right -50px|}];
[%cx2 {|background-position-x: left -50px|}];
[%cx2 {|background-position-x: right 20px|}];
[%cx2 {|background-position-y: bottom|}];
[%cx2 {|background-position-y: center|}];
[%cx2 {|background-position-y: 50%|}];
[%cx2 {|background-position-y: top, top|}];
[%cx2 {|background-position-y: top, bottom|}];
[%cx2 {|background-position-y: bottom, top|}];
[%cx2 {|background-position-y: top, 0%|}];
[%cx2 {|background-position-y: 10%, 20%, 40%|}];
[%cx2 {|background-position-y: 0px|}];
[%cx2 {|background-position-y: 30px|}];
[%cx2 {|background-position-y: 0%, 10%, 20%, 30%|}];
[%cx2 {|background-position-y: top, top, top, top, top|}];
[%cx2 {|background-position-y: calc(20px)|}];
[%cx2 {|background-position-y: calc(20px + 1em)|}];
[%cx2 {|background-position-y: calc(20px / 2)|}];
[%cx2 {|background-position-y: calc(20px + 50%)|}];
[%cx2 {|background-position-y: calc(50% - 10px)|}];
[%cx2 {|background-position-y: calc(-20px)|}];
[%cx2 {|background-position-y: calc(-50%)|}];
[%cx2 {|background-position-y: calc(-20%)|}];
[%cx2 {|background-position-y: bottom 20px|}];
[%cx2 {|background-position-y: top 20px|}];
[%cx2 {|background-position-y: bottom -50px|}];
[%cx2 {|background-position-y: top -50px|}];
[%cx2 {|background-position-y: bottom 20px|}];

/* CSS Images Module Level 3 */
[%cx2 {|background-image: linear-gradient(45deg, blue, red);|}];
[%cx2 {|background-image: linear-gradient(90deg, blue 10%, red 20%);|}];
[%cx2 {|background-image: linear-gradient(90deg, blue 10%, red);|}];
[%cx2 {|background-image: linear-gradient(90deg, blue, 10%, red);|}];
[%cx2 {|background-image: linear-gradient(white, black);|}];
[%cx2 {|background-image: linear-gradient(to right, white, black);|}];
[%cx2 {|background-image: linear-gradient(45deg, white, black);|}];
[%cx2 {|background-image: linear-gradient(white 50%, black);|}];
[%cx2 {|background-image: linear-gradient(white, #f06, black);|}];
[%css
  {|background-image: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}
];
[%css
  {|
       background-image:
         linear-gradient(45deg, blue, red),
         linear-gradient(red -50px, white calc(-25px + 50%), blue 100%),
         linear-gradient(45deg, blue, red);
     |}
];
let color = `hex("333");
[%css
  {|
       background-image:
        linear-gradient(45deg,
          $(color) 25%,
          transparent 0%,
          transparent 50%,
          $(color) 0%,
          $(color) 75%,
          transparent 0%,
          transparent 100%
        )
     |}
];
[%css
  {|
    background-image:
      repeating-linear-gradient(
        45deg,
        $(color) 0px,
        $(color) 4px,
        $(color) 5px,
        $(color) 9px
      )
    |}
];

[%css
  {|
       background-image:
         linear-gradient(45deg, $(Color.Background.boxDark) 25%, transparent 25%),
         linear-gradient(red -50px, white calc(-25px + 50%), blue 100%),
         linear-gradient(45deg, blue, red);
     |}
];
/* This is currently valid, but it's part of the issue with different spec for linear-gradients
   [%cx2 {|background-image: linear-gradient(90deg, 10%, 10%, red);|}];
    */

[%cx2 {|background-image: radial-gradient(white, black);|}];
[%cx2 {|background-image: radial-gradient(circle, white, black);|}];
[%cx2 {|background-image: radial-gradient(ellipse, white, black);|}];
[%css
  {|background-image: radial-gradient(circle closest-corner, white, black);|}
];
[%cx2 {|background-image: radial-gradient(farthest-side, white, black);|}];
[%css
  {|background-image: radial-gradient(circle farthest-side, white, black);|}
];
[%cx2 {|background-image: radial-gradient(50%, white, black);|}];
[%cx2 {|background-image: radial-gradient(60% 60%, white, black);|}];
/* [%cx2 {|background-image: repeating-linear-gradient(white, black);|}]; */
/* [%cx2 {|background-image: repeating-radial-gradient(white, black);|}]; */
[%cx2 {|list-style-image: linear-gradient(white, black);|}];
[%cx2 {|list-style-image: linear-gradient(to right, white, black);|}];
[%cx2 {|list-style-image: linear-gradient(45deg, white, black);|}];
[%cx2 {|list-style-image: linear-gradient(white 50%, black);|}];
[%cx2 {|list-style-image: linear-gradient(white 5px, black);|}];
[%cx2 {|list-style-image: linear-gradient(white, #f06, black);|}];
[%cx2 {|list-style-image: linear-gradient(currentColor, black);|}];
[%css
  {|list-style-image: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}
];
[%cx2 {|list-style-image: radial-gradient(white, black);|}];
[%cx2 {|list-style-image: radial-gradient(circle, white, black);|}];
[%cx2 {|list-style-image: radial-gradient(ellipse, white, black);|}];
[%cx2 {|list-style-image: radial-gradient(closest-corner, white, black);|}];
[%css
  {|list-style-image: radial-gradient(circle closest-corner, white, black);|}
];
[%cx2 {|list-style-image: radial-gradient(farthest-side, white, black);|}];
[%css
  {|list-style-image: radial-gradient(circle farthest-side, white, black);|}
];
[%cx2 {|list-style-image: radial-gradient(50%, white, black);|}];
[%cx2 {|list-style-image: radial-gradient(60% 60%, white, black);|}];
/* [%cx2 {|list-style-image: repeating-linear-gradient(white, black);|}]; */
/* [%cx2 {|list-style-image: repeating-radial-gradient(white, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(white, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(to right, white, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(45deg, white, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(white 50%, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(white 5px, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(white, #f06, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(currentColor, black);|}]; */
/* [%cx2 {|border-image: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%cx2 {|border-image: radial-gradient(white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(circle, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(ellipse, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(closest-corner, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(farthest-side, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(50%, white, black);|}]; */
/* [%cx2 {|border-image: radial-gradient(60% 60%, white, black);|}]; */
/* [%cx2 {|border-image: repeating-linear-gradient(white, black);|}]; */
/* [%cx2 {|border-image: repeating-radial-gradient(white, black);|}]; */
[%cx2 {|image-rendering: auto;|}];
[%cx2 {|image-rendering: smooth;|}];
[%cx2 {|image-rendering: high-quality;|}];
[%cx2 {|image-rendering: pixelated;|}];
[%cx2 {|image-rendering: crisp-edges;|}];
/* [%cx2 {|cursor: linear-gradient(45deg, 25% black, 25% transparent);|}]; */
/* [%cx2 {|cursor: linear-gradient(white, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(to right, white, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(45deg, white, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(white 50%, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(white 5px, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(white, #f06, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(currentColor, black);|}]; */
/* [%cx2 {|cursor: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%cx2 {|cursor: radial-gradient(white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(circle, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(ellipse, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(closest-corner, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(farthest-side, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(50%, white, black);|}]; */
/* [%cx2 {|cursor: radial-gradient(60% 60%, white, black);|}]; */
/* [%cx2 {|cursor: repeating-linear-gradient(white, black);|}]; */
/* [%cx2 {|cursor: repeating-radial-gradient(white, black);|}]; */
/* [%cx2 {|content: linear-gradient(white, black);|}]; */
/* [%cx2 {|content: linear-gradient(to right, white, black);|}]; */
/* [%cx2 {|content: linear-gradient(45deg, white, black);|}]; */
/* [%cx2 {|content: linear-gradient(white 50%, black);|}]; */
/* [%cx2 {|content: linear-gradient(white 5px, black);|}]; */
/* [%cx2 {|content: linear-gradient(white, #f06, black);|}]; */
/* [%cx2 {|content: linear-gradient(currentColor, black);|}]; */
/* [%cx2 {|content: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%cx2 {|content: radial-gradient(white, black);|}]; */
/* [%cx2 {|content: radial-gradient(circle, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(ellipse, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(closest-corner, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(farthest-side, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(50%, white, black);|}]; */
/* [%cx2 {|content: radial-gradient(60% 60%, white, black);|}]; */
/* [%cx2 {|content: repeating-linear-gradient(white, black);|}]; */

[%cx2 {|background-position: bottom;|}];
[%cx2 {|background-position-x: 50%;|}];
[%cx2 {|background-position-y: 0;|}];
[%cx2 {|background-position: 0 0;|}];
[%cx2 {|background-position: 1rem 0;|}];
[%cx2 {|background-position: bottom 10px right|}];
[%cx2 {|background-position: bottom 10px right 20px|}];
[%cx2 {|background-position: 0 0, center|}];

/* Object Position */
[%cx2 {| object-position: top |}];
[%cx2 {| object-position: bottom |}];
[%cx2 {| object-position: left |}];
[%cx2 {| object-position: right |}];
[%cx2 {| object-position: center |}];

[%cx2 {| object-position: 25% 75% |}];
[%cx2 {| object-position: 25% |}];

[%cx2 {| object-position: 0 0 |}];
[%cx2 {| object-position: 1cm 2cm |}];
[%cx2 {| object-position: 10ch 8em |}];

[%cx2 {| object-position: bottom 10px right 20px |}];
[%cx2 {| object-position: right 3em bottom 10px |}];
[%cx2 {| object-position: top 0 right 10px |}];

[%cx2 {| object-position: inherit |}];
[%cx2 {| object-position: initial |}];
[%cx2 {| object-position: revert |}];
[%cx2 {| object-position: revert-layer |}];
[%cx2 {| object-position: unset |}];

let _loadingKeyframes = [%keyframe
  {|
  0% { background-position: 0 0; }
  100% { background-position: 1rem 0; }
|}
];
