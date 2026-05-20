/* Test box-shadow and text-shadow interpolation support in cx2 */

/* Single box shadow with full interpolation */
let singleShadow = CSS.BoxShadow.box(~x=`px(2), ~y=`px(4), ~blur=`px(8), CSS.hex("000"));
let _ = [%cx2 {|box-shadow: $(singleShadow)|}];

/* Array of box shadows with full interpolation */
let shadowArray = [|
  CSS.BoxShadow.box(~x=`px(0), ~y=`px(2), ~blur=`px(4), CSS.rgba(0, 0, 0, `num(0.1))),
  CSS.BoxShadow.box(~x=`px(0), ~y=`px(4), ~blur=`px(8), CSS.rgba(0, 0, 0, `num(0.2))),
|];
let _ = [%cx2 {|box-shadow: $(shadowArray)|}];

/* Box shadow none */
let _ = [%cx2 {|box-shadow: none|}];

/* Static box shadow */
let _ = [%cx2 {|box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1)|}];

/* Single text shadow with full interpolation */
let textShadowValue = CSS.TextShadow.text(~x=`px(1), ~y=`px(1), ~blur=`px(2), CSS.hex("333"));
let _ = [%cx2 {|text-shadow: $(textShadowValue)|}];

/* Array of text shadows with full interpolation */
let textShadowArray = [|
  CSS.TextShadow.text(~x=`px(1), ~y=`px(1), ~blur=`px(2), CSS.hex("000")),
  CSS.TextShadow.text(~x=`px(-1), ~y=`px(-1), ~blur=`px(2), CSS.hex("fff")),
|];
let _ = [%cx2 {|text-shadow: $(textShadowArray)|}];

/* Text shadow none */
let _ = [%cx2 {|text-shadow: none|}];

/* Test with inset shadow */
let insetShadow = CSS.BoxShadow.box(~inset=true, ~x=`px(0), ~y=`px(2), ~blur=`px(4), CSS.hex("000"));
let _ = [%cx2 {|box-shadow: $(insetShadow)|}];

