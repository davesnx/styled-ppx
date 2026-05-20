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

  let deprecated__elevation3: array(Alias.Shadow.t) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`px(1),
      `rgba((0, 0, 0, `num(0.08))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(3),
      ~blur=`px(18),
      ~spread=`zero,
      `rgba((0, 0, 0, `num(0.15))),
    ),
  |];
};

let topMenuHeight = `px(56);

let _borderTop = [%css {|border-top: 1px solid $(Color.Border.line)|}];
let _borderBottom = [%css {|border-bottom: 1px solid $(Color.Border.lineAlpha)|}];
let _borderLeft = [%css {|border-left: 1px solid $(Color.Border.lineAlpha)|}];

let _boxShadow1 = [%css {|box-shadow: $(BoxShadow.deprecated__elevation1)|}];
let _boxShadow2 = [%css {|box-shadow: $(BoxShadow.deprecated__elevation3)|}];

let _heightPlus = [%css {|height: calc(100vh + $(topMenuHeight))|}];
let _heightMinus = [%css {|height: calc(100vh - $(topMenuHeight))|}];
