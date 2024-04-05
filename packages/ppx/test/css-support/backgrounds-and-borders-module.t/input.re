module Color = {
  module Background = {
    let boxDark = `hex("000000");
  };
  module Shadow = {
    let elevation1 = `rgba((0, 0, 0, `num(0.03)));
  };
};

/* CSS Backgrounds and Borders Module Level 3 */
[%css {|background-repeat: space|}];
[%css {|background-repeat: round|}];
[%css {|background-repeat: repeat repeat|}];
[%css {|background-repeat: space repeat|}];
[%css {|background-repeat: round repeat|}];
[%css {|background-repeat: no-repeat repeat|}];
[%css {|background-repeat: repeat space|}];
[%css {|background-repeat: space space|}];
[%css {|background-repeat: round space|}];
[%css {|background-repeat: no-repeat space|}];
[%css {|background-repeat: repeat round|}];
[%css {|background-repeat: space round|}];
[%css {|background-repeat: round round|}];
[%css {|background-repeat: no-repeat round|}];
[%css {|background-repeat: repeat no-repeat|}];
[%css {|background-repeat: space no-repeat|}];
[%css {|background-repeat: round no-repeat|}];
[%css {|background-repeat: no-repeat no-repeat|}];
[%css {|background-attachment: local|}];
/* [%css {|background-position: bottom 10px right 20px|}]; */
/* [%css {|background-position: bottom 10px right|}]; */
/* [%css {|background-position: top right 10px|}]; */
[%css {|background-clip: border-box|}];
[%css {|background-clip: padding-box|}];
[%css {|background-clip: content-box|}];
[%css {|background-origin: border-box|}];
[%css {|background-origin: padding-box|}];
[%css {|background-origin: content-box|}];
[%css {|background-size: auto|}];
[%css {|background-size: cover|}];
[%css {|background-size: contain|}];
[%css {|background-size: 10px|}];
[%css {|background-size: 50%|}];
[%css {|background-size: 10px auto|}];
[%css {|background-size: auto 10%|}];
[%css {|background-size: 50em 50%|}];
/* [%css {|background: url(foo.png), url(bar.svg)|}]; */
[%css {|background: top left / 50% 60%|}];
[%css {|background: border-box|}];
[%css {|background: blue|}];
[%css {|background: border-box red|}];
/* [%css {|background: fixed;|}]; */
[%css {|background: border-box padding-box|}];
[%css
  {|background: url(foo.png) bottom right / cover padding-box content-box|}
];
[%css {|border-top-left-radius: 0|}];
[%css {|border-top-left-radius: 50%|}];
[%css {|border-top-left-radius: 250px 100px|}];
[%css {|border-top-right-radius: 0|}];
[%css {|border-top-right-radius: 50%|}];
[%css {|border-top-right-radius: 250px 100px|}];
[%css {|border-bottom-right-radius: 0|}];
[%css {|border-bottom-right-radius: 50%|}];
[%css {|border-bottom-right-radius: 250px 100px|}];
[%css {|border-bottom-left-radius: 0|}];
[%css {|border-bottom-left-radius: 50%|}];
[%css {|border-bottom-left-radius: 250px 100px|}];
[%css {|border-radius: 10px|}];
[%css {|border-radius: 50%|}];
/* [%css {|border-radius: 10px / 20px|}]; */
/* [%css {|border-radius: 2px 4px 8px 16px|}]; */
/* [%css {|border-radius: 2px 4px 8px 16px / 2px 4px 8px 16px|}]; */
[%css {|border-image-source: none|}];
[%css {|border-image-source: url(foo.png)|}];
[%css {|border-image-slice: 10|}];
[%css {|border-image-slice: 30%|}];
[%css {|border-image-slice: 10 10|}];
[%css {|border-image-slice: 30% 10|}];
[%css {|border-image-slice: 10 30%|}];
[%css {|border-image-slice: 30% 30%|}];
[%css {|border-image-slice: 10 10 10|}];
[%css {|border-image-slice: 30% 10 10|}];
[%css {|border-image-slice: 10 30% 10|}];
[%css {|border-image-slice: 30% 30% 10|}];
[%css {|border-image-slice: 10 10 30%|}];
[%css {|border-image-slice: 30% 10 30%|}];
[%css {|border-image-slice: 10 30% 30%|}];
[%css {|border-image-slice: 30% 30% 30%|}];
[%css {|border-image-slice: 10 10 10 10|}];
[%css {|border-image-slice: 30% 10 10 10|}];
[%css {|border-image-slice: 10 30% 10 10|}];
[%css {|border-image-slice: 30% 30% 10 10|}];
[%css {|border-image-slice: 10 10 30% 10|}];
[%css {|border-image-slice: 30% 10 30% 10|}];
[%css {|border-image-slice: 10 30% 30% 10|}];
[%css {|border-image-slice: 30% 30% 30% 10|}];
[%css {|border-image-slice: 10 10 10 30%|}];
[%css {|border-image-slice: 30% 10 10 30%|}];
[%css {|border-image-slice: 10 30% 10 30%|}];
[%css {|border-image-slice: 30% 30% 10 30%|}];
[%css {|border-image-slice: 10 10 30% 30%|}];
[%css {|border-image-slice: 30% 10 30% 30%|}];
[%css {|border-image-slice: 10 30% 30% 30%|}];
[%css {|border-image-slice: 30% 30% 30% 30%|}];
[%css {|border-image-slice: fill 30%|}];
[%css {|border-image-slice: fill 10|}];
[%css {|border-image-slice: fill 2 4 8% 16%|}];
[%css {|border-image-slice: 30% fill|}];
[%css {|border-image-slice: 10 fill|}];
[%css {|border-image-slice: 2 4 8% 16% fill|}];
[%css {|border-image-width: 10px|}];
[%css {|border-image-width: 5%|}];
[%css {|border-image-width: 28|}];
[%css {|border-image-width: auto|}];
[%css {|border-image-width: 10px 10px|}];
[%css {|border-image-width: 5% 10px|}];
[%css {|border-image-width: 28 10px|}];
[%css {|border-image-width: auto 10px|}];
[%css {|border-image-width: 10px 5%|}];
[%css {|border-image-width: 5% 5%|}];
[%css {|border-image-width: 28 5%|}];
[%css {|border-image-width: auto 5%|}];
[%css {|border-image-width: 10px 28|}];
[%css {|border-image-width: 5% 28|}];
[%css {|border-image-width: 28 28|}];
[%css {|border-image-width: auto 28|}];
[%css {|border-image-width: 10px auto|}];
[%css {|border-image-width: 5% auto|}];
[%css {|border-image-width: 28 auto|}];
[%css {|border-image-width: auto auto|}];
[%css {|border-image-width: 10px 10% 10|}];
[%css {|border-image-width: 5% 10px 20 auto|}];
[%css {|border-image-outset: 10px|}];
[%css {|border-image-outset: 20|}];
[%css {|border-image-outset: 10px 20|}];
[%css {|border-image-outset: 10px 20px|}];
[%css {|border-image-outset: 20 30|}];
[%css {|border-image-outset: 2px 3px 4|}];
[%css {|border-image-outset: 1 2px 3px 4|}];
[%css {|border-image-repeat: stretch|}];
[%css {|border-image-repeat: repeat|}];
[%css {|border-image-repeat: round|}];
[%css {|border-image-repeat: space|}];
[%css {|border-image-repeat: stretch stretch|}];
[%css {|border-image-repeat: repeat stretch|}];
[%css {|border-image-repeat: round stretch|}];
[%css {|border-image-repeat: space stretch|}];
[%css {|border-image-repeat: stretch repeat|}];
[%css {|border-image-repeat: repeat repeat|}];
[%css {|border-image-repeat: round repeat|}];
[%css {|border-image-repeat: space repeat|}];
[%css {|border-image-repeat: stretch round|}];
[%css {|border-image-repeat: repeat round|}];
[%css {|border-image-repeat: round round|}];
[%css {|border-image-repeat: space round|}];
[%css {|border-image-repeat: stretch space|}];
[%css {|border-image-repeat: repeat space|}];
[%css {|border-image-repeat: round space|}];
[%css {|border-image-repeat: space space|}];
[%css {|border-image: url(foo.png) 10|}];
[%css {|border-image: url(foo.png) 10%|}];
[%css {|border-image: url(foo.png) 10% fill|}];
[%css {|border-image: url(foo.png) 10 round|}];
[%css {|border-image: url(foo.png) 10 stretch repeat|}];
[%css {|border-image: url(foo.png) 10 / 10px|}];
[%css {|border-image: url(foo.png) 10 / 10% / 10px|}];
[%css {|border-image: url(foo.png) fill 10 / 10% / 10px|}];
[%css {|border-image: url(foo.png) fill 10 / 10% / 10px space|}];
/* The following shadow declarations are not supported in the CSS Parser */
/* [%css {|box-shadow: 1px 1px|}]; */
/* [%css {|box-shadow: 0 0 black|}]; */
/* [%css {|box-shadow: 1px 2px 3px black|}]; */
[%css {|box-shadow: 1px 2px 3px 4px black|}];
[%css {|box-shadow: inset 1px 2px 3px 4px black|}];
[%css {|box-shadow: inset 1px 2px 3px 4px black, 1px 2px 3px 4px black|}];
[%css
  {|box-shadow: -1px 1px 0px 0px $(Color.Shadow.elevation1),
            1px 1px 0px 0px $(Color.Shadow.elevation1),
            0px -1px 0px 0px $(Color.Shadow.elevation1);|}
];

/* CSS Backgrounds and Borders Module Level 4 */
[%css {|background-position-x: right|}];
[%css {|background-position-x: center|}];
[%css {|background-position-x: 50%|}];
[%css {|background-position-x: left, left|}];
[%css {|background-position-x: left, right|}];
[%css {|background-position-x: right, left|}];
[%css {|background-position-x: left, 0%|}];
[%css {|background-position-x: 10%, 20%, 40%|}];
[%css {|background-position-x: 0px|}];
[%css {|background-position-x: 30px|}];
[%css {|background-position-x: 0%, 10%, 20%, 30%|}];
[%css {|background-position-x: left, left, left, left, left|}];
[%css {|background-position-x: calc(20px)|}];
[%css {|background-position-x: calc(20px + 1em)|}];
[%css {|background-position-x: calc(20px / 2)|}];
[%css {|background-position-x: calc(20px + 50%)|}];
[%css {|background-position-x: calc(50% - 10px)|}];
[%css {|background-position-x: calc(-20px)|}];
[%css {|background-position-x: calc(-50%)|}];
[%css {|background-position-x: calc(-20%)|}];
[%css {|background-position-x: right 20px|}];
[%css {|background-position-x: left 20px|}];
[%css {|background-position-x: right -50px|}];
[%css {|background-position-x: left -50px|}];
[%css {|background-position-x: right 20px|}];
[%css {|background-position-y: bottom|}];
[%css {|background-position-y: center|}];
[%css {|background-position-y: 50%|}];
[%css {|background-position-y: top, top|}];
[%css {|background-position-y: top, bottom|}];
[%css {|background-position-y: bottom, top|}];
[%css {|background-position-y: top, 0%|}];
[%css {|background-position-y: 10%, 20%, 40%|}];
[%css {|background-position-y: 0px|}];
[%css {|background-position-y: 30px|}];
[%css {|background-position-y: 0%, 10%, 20%, 30%|}];
[%css {|background-position-y: top, top, top, top, top|}];
[%css {|background-position-y: calc(20px)|}];
[%css {|background-position-y: calc(20px + 1em)|}];
[%css {|background-position-y: calc(20px / 2)|}];
[%css {|background-position-y: calc(20px + 50%)|}];
[%css {|background-position-y: calc(50% - 10px)|}];
[%css {|background-position-y: calc(-20px)|}];
[%css {|background-position-y: calc(-50%)|}];
[%css {|background-position-y: calc(-20%)|}];
[%css {|background-position-y: bottom 20px|}];
[%css {|background-position-y: top 20px|}];
[%css {|background-position-y: bottom -50px|}];
[%css {|background-position-y: top -50px|}];
[%css {|background-position-y: bottom 20px|}];

/* CSS Images Module Level 3 */
[%css {|background-image: linear-gradient(45deg, blue, red);|}];
[%css {|background-image: linear-gradient(90deg, blue 10%, red 20%);|}];
[%css {|background-image: linear-gradient(90deg, blue 10%, red);|}];
[%css {|background-image: linear-gradient(90deg, blue, 10%, red);|}];
[%css {|background-image: linear-gradient(white, black);|}];
[%css {|background-image: linear-gradient(to right, white, black);|}];
[%css {|background-image: linear-gradient(45deg, white, black);|}];
[%css {|background-image: linear-gradient(white 50%, black);|}];
[%css {|background-image: linear-gradient(white, #f06, black);|}];
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
[%css
  {|
       background-image:
         linear-gradient(45deg, $(Color.Background.boxDark) 25%, transparent 25%),
         linear-gradient(red -50px, white calc(-25px + 50%), blue 100%),
         linear-gradient(45deg, blue, red);
     |}
];
/* This is currently valid, but it's part of the issue with different spec for linear-gradients
   [%css {|background-image: linear-gradient(90deg, 10%, 10%, red);|}];
    */

[%css {|background-image: radial-gradient(white, black);|}];
[%css {|background-image: radial-gradient(circle, white, black);|}];
[%css {|background-image: radial-gradient(ellipse, white, black);|}];
[%css
  {|background-image: radial-gradient(circle closest-corner, white, black);|}
];
[%css {|background-image: radial-gradient(farthest-side, white, black);|}];
[%css
  {|background-image: radial-gradient(circle farthest-side, white, black);|}
];
[%css {|background-image: radial-gradient(50%, white, black);|}];
[%css {|background-image: radial-gradient(60% 60%, white, black);|}];
/* [%css {|background-image: repeating-linear-gradient(white, black);|}]; */
/* [%css {|background-image: repeating-radial-gradient(white, black);|}]; */
[%css {|list-style-image: linear-gradient(white, black);|}];
[%css {|list-style-image: linear-gradient(to right, white, black);|}];
[%css {|list-style-image: linear-gradient(45deg, white, black);|}];
[%css {|list-style-image: linear-gradient(white 50%, black);|}];
[%css {|list-style-image: linear-gradient(white 5px, black);|}];
[%css {|list-style-image: linear-gradient(white, #f06, black);|}];
[%css {|list-style-image: linear-gradient(currentColor, black);|}];
[%css
  {|list-style-image: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}
];
[%css {|list-style-image: radial-gradient(white, black);|}];
[%css {|list-style-image: radial-gradient(circle, white, black);|}];
[%css {|list-style-image: radial-gradient(ellipse, white, black);|}];
[%css {|list-style-image: radial-gradient(closest-corner, white, black);|}];
[%css
  {|list-style-image: radial-gradient(circle closest-corner, white, black);|}
];
[%css {|list-style-image: radial-gradient(farthest-side, white, black);|}];
[%css
  {|list-style-image: radial-gradient(circle farthest-side, white, black);|}
];
[%css {|list-style-image: radial-gradient(50%, white, black);|}];
[%css {|list-style-image: radial-gradient(60% 60%, white, black);|}];
/* [%css {|list-style-image: repeating-linear-gradient(white, black);|}]; */
/* [%css {|list-style-image: repeating-radial-gradient(white, black);|}]; */
/* [%css {|border-image: linear-gradient(white, black);|}]; */
/* [%css {|border-image: linear-gradient(to right, white, black);|}]; */
/* [%css {|border-image: linear-gradient(45deg, white, black);|}]; */
/* [%css {|border-image: linear-gradient(white 50%, black);|}]; */
/* [%css {|border-image: linear-gradient(white 5px, black);|}]; */
/* [%css {|border-image: linear-gradient(white, #f06, black);|}]; */
/* [%css {|border-image: linear-gradient(currentColor, black);|}]; */
/* [%css {|border-image: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%css {|border-image: radial-gradient(white, black);|}]; */
/* [%css {|border-image: radial-gradient(circle, white, black);|}]; */
/* [%css {|border-image: radial-gradient(ellipse, white, black);|}]; */
/* [%css {|border-image: radial-gradient(closest-corner, white, black);|}]; */
/* [%css {|border-image: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%css {|border-image: radial-gradient(farthest-side, white, black);|}]; */
/* [%css {|border-image: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%css {|border-image: radial-gradient(50%, white, black);|}]; */
/* [%css {|border-image: radial-gradient(60% 60%, white, black);|}]; */
/* [%css {|border-image: repeating-linear-gradient(white, black);|}]; */
/* [%css {|border-image: repeating-radial-gradient(white, black);|}]; */
[%css {|image-rendering: auto;|}];
[%css {|image-rendering: smooth;|}];
[%css {|image-rendering: high-quality;|}];
[%css {|image-rendering: pixelated;|}];
[%css {|image-rendering: crisp-edges;|}];
/* [%css {|cursor: linear-gradient(45deg, 25% black, 25% transparent);|}]; */
/* [%css {|cursor: linear-gradient(white, black);|}]; */
/* [%css {|cursor: linear-gradient(to right, white, black);|}]; */
/* [%css {|cursor: linear-gradient(45deg, white, black);|}]; */
/* [%css {|cursor: linear-gradient(white 50%, black);|}]; */
/* [%css {|cursor: linear-gradient(white 5px, black);|}]; */
/* [%css {|cursor: linear-gradient(white, #f06, black);|}]; */
/* [%css {|cursor: linear-gradient(currentColor, black);|}]; */
/* [%css {|cursor: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%css {|cursor: radial-gradient(white, black);|}]; */
/* [%css {|cursor: radial-gradient(circle, white, black);|}]; */
/* [%css {|cursor: radial-gradient(ellipse, white, black);|}]; */
/* [%css {|cursor: radial-gradient(closest-corner, white, black);|}]; */
/* [%css {|cursor: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%css {|cursor: radial-gradient(farthest-side, white, black);|}]; */
/* [%css {|cursor: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%css {|cursor: radial-gradient(50%, white, black);|}]; */
/* [%css {|cursor: radial-gradient(60% 60%, white, black);|}]; */
/* [%css {|cursor: repeating-linear-gradient(white, black);|}]; */
/* [%css {|cursor: repeating-radial-gradient(white, black);|}]; */
/* [%css {|content: linear-gradient(white, black);|}]; */
/* [%css {|content: linear-gradient(to right, white, black);|}]; */
/* [%css {|content: linear-gradient(45deg, white, black);|}]; */
/* [%css {|content: linear-gradient(white 50%, black);|}]; */
/* [%css {|content: linear-gradient(white 5px, black);|}]; */
/* [%css {|content: linear-gradient(white, #f06, black);|}]; */
/* [%css {|content: linear-gradient(currentColor, black);|}]; */
/* [%css {|content: linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);|}]; */
/* [%css {|content: radial-gradient(white, black);|}]; */
/* [%css {|content: radial-gradient(circle, white, black);|}]; */
/* [%css {|content: radial-gradient(ellipse, white, black);|}]; */
/* [%css {|content: radial-gradient(closest-corner, white, black);|}]; */
/* [%css {|content: radial-gradient(circle closest-corner, white, black);|}]; */
/* [%css {|content: radial-gradient(farthest-side, white, black);|}]; */
/* [%css {|content: radial-gradient(circle farthest-side, white, black);|}]; */
/* [%css {|content: radial-gradient(50%, white, black);|}]; */
/* [%css {|content: radial-gradient(60% 60%, white, black);|}]; */
/* [%css {|content: repeating-linear-gradient(white, black);|}]; */

[%css {|background-position: bottom;|}];
[%css {|background-position-x: 50%;|}];
[%css {|background-position-y: 0;|}];
[%css {|background-position: 0 0;|}];
[%css {|background-position: 1rem 0;|}];

/* Object Position */
[%css {| object-position: top |}];
[%css {| object-position: bottom |}];
[%css {| object-position: left |}];
[%css {| object-position: right |}];
[%css {| object-position: center |}];

[%css {| object-position: 25% 75% |}];
[%css {| object-position: 25% |}];

[%css {| object-position: 0 0 |}];
[%css {| object-position: 1cm 2cm |}];
[%css {| object-position: 10ch 8em |}];

[%css {| object-position: bottom 10px right 20px |}];
[%css {| object-position: right 3em bottom 10px |}];
[%css {| object-position: top 0 right 10px |}];

[%css {| object-position: inherit |}];
[%css {| object-position: initial |}];
[%css {| object-position: revert |}];
[%css {| object-position: revert-layer |}];
[%css {| object-position: unset |}];

let _loadingKeyframes = [%keyframe
  {|
  0% { background-position: 0 0; }
  100% { background-position: 1rem 0; }
|}
];
