module Color = {
  module Border = {
    let line = `rgba((0, 0, 0, `num(0.1)));
  };
  module Text = {
    let tertiary = `hex("999999");
    let secondary = `hex("666666");
  };
  module Background = {
    let box_ = `hex("f0f0f0");
  };
};

/* Test 1: space before colon (BulkEditTab.re pattern) */
let _spaceBeforeColon = [%cx
  {|
  width: 30px;
  color : $(Color.Text.tertiary);
|}
];

/* Test 2: box-shadow with !important in [%cx] */
let _tabInnerFirst = [%cx {|
  box-shadow: inset 1px 0 0 0 transparent !important;
|}];

/* Test 3: multi-value box-shadow with !important inline */
let _multiShadowImportant = [%cx {|
  box-shadow: 1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line) !important;
|}];

/* Test 4: multi box-shadow with !important in nested selector - no trailing semicolon */
let _tabTextFirst = [%cx
  {|
  box-shadow: inset 0 0 0 0 transparent;

  :hover {
    box-shadow:
      1px 0 0 0 $(Color.Border.line),
      inset 0 -1px 0 0 $(Color.Border.line) !important
  }
|}
];

/* Test 5: multi box-shadow in nested selector WITHOUT !important */
let _tabText = [%cx
  {|
  color: $(Color.Text.secondary);

  :hover {
    background-color: $(Color.Background.box_);
    box-shadow:
      1px 0 0 0 $(Color.Border.line),
      inset 1px 0 0 0 $(Color.Border.line),
      inset 0 -1px 0 0 $(Color.Border.line)
  }
|}
];

/* Test 6: transition shorthand in [%cx] with nested selectors */
let sidebarClosed = [%cx ""];

let _sidebar = [%cx
  {|
  flex-grow: 1;
  z-index: 1;
  transition: all 200ms ease 0ms;

  &.$(sidebarClosed) {
    min-width: 0;
    max-width: 0;
    opacity: 0;
    overflow: hidden;
  }
|}
];

/* Test 7: transition with !important */
let _checkbox = [%cx {|transition: transform 0.3s !important;|}];

/* Test 8: multiple transitions in [%cx] */
let _transitions = [%cx
  {|
  transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;
|}
];

/* Test 9: CSS.Shadow.t type compatibility */
let _shadow1: CSS.Shadow.t = CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
let _shadow2: array(CSS.Shadow.t) = [|
  CSS.Shadow.box(~x=`zero, ~y=`zero, ~blur=`px(4), `rgba((0, 0, 0, `num(0.1)))),
  CSS.Shadow.box(~x=`zero, ~y=`px(6), ~blur=`px(15), `rgba((0, 0, 0, `num(0.2)))),
|];
