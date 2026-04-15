module Alias = {
  module Shadow = {
    type t = CSS.Shadow.t;
  };
};

module Color = {
  module Border = {
    let line = `rgba((0, 0, 0, `num(0.1)));
    let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
  };
};

module BoxShadow = {
  let deprecated__elevation1: array(Alias.Shadow.t) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`px(1),
      `rgba((0, 0, 0, `num(0.03))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(1),
      ~blur=`zero,
      ~spread=`zero,
      `rgba((0, 0, 0, `num(0.06))),
    ),
  |];
};

let topMenuHeight = `px(56);

let _borderTop = [%cx2 {|border-top: 1px solid $(Color.Border.line)|}];
let _borderBottom = [%cx2 {|border-bottom: 1px solid $(Color.Border.lineAlpha)|}];
let _borderLeft = [%cx2 {|border-left: 1px solid $(Color.Border.lineAlpha)|}];

let _boxShadow1 = [%cx2 {|box-shadow: $(BoxShadow.deprecated__elevation1)|}];

let _heightPlus = [%cx2 {|height: calc(100vh + $(topMenuHeight))|}];
