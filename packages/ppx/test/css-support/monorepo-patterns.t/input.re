module Color = {
  module Border = {
    let line = `rgba((0, 0, 0, `num(0.1)));
    let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
    let accent = `rgba((0, 0, 255, `num(0.5)));
  };
  module Shadow = {
    let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    let elevation1Bottom = `rgba((0, 0, 0, `num(0.06)));
    let elevation2 = `rgba((0, 0, 0, `num(0.1)));
    let border = `rgba((0, 0, 0, `num(0.08)));
    let elevation3 = `rgba((0, 0, 0, `num(0.15)));
    let flag = `rgba((0, 0, 0, `num(0.2)));
  };
  module Background = {
    let selectedMuted = `hex("f5f5f5");
  };
};

/* ==========================================
   Transition shorthand patterns from monorepo
   ========================================== */

/* transition: all with 4 parts (property duration timing-function delay) */
[%css {|transition: all 200ms ease 0ms|}];
[%css {|transition: all 300ms ease-in-out 0ms|}];
[%css {|transition: opacity 300ms ease-in-out 0ms|}];

/* transition: with time units */
[%css {|transition: left 0.15s|}];
[%css {|transition: opacity 0.5s ease-in-out|}];
[%css {|transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out|}];
[%css {|transition: width 200ms ease, height 200ms ease, background-color 200ms ease|}];
[%css {|transition: transform 0.3s|}];

/* ==========================================
   Box-shadow patterns from monorepo
   ========================================== */

/* box-shadow: inset with 4 lengths + color */
[%css {|box-shadow: inset 0 -1px 0 0 $(Color.Border.lineAlpha)|}];
[%css {|box-shadow: inset 1px 0 0 0 $(Color.Border.line)|}];
[%css {|box-shadow: inset 0 0 0 1000px $(Color.Background.selectedMuted)|}];
[%css {|box-shadow: inset 0 0 0 0.5px $(Color.Shadow.flag)|}];

/* box-shadow: multiple comma-separated values */
[%css {|box-shadow: 0 0 0 1px $(Color.Shadow.elevation1), 0 1px 0 0 $(Color.Shadow.elevation1Bottom)|}];
[%css {|box-shadow: 0 0 0 1px $(Color.Shadow.border), 0 2px 4px 0 $(Color.Shadow.elevation2)|}];
[%css {|box-shadow: 0 0 0 1px $(Color.Shadow.border), 0 3px 18px 0 $(Color.Shadow.elevation3)|}];

/* box-shadow: mixed inset and non-inset */
[%css {|box-shadow: 1px 0 0 0 $(Color.Border.line), inset 1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line)|}];
[%css {|box-shadow: inset 0 1px 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line)|}];

/* box-shadow: with rgba values */
[%css {|box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1)|}];
[%css {|box-shadow: 0px 0px 1px 0 rgba(255, 255, 255, 0.5)|}];
[%css {|box-shadow: 0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02)|}];
[%css {|box-shadow: 0 0 0 1px $(Color.Shadow.elevation1), 0 3px 18px 0 $(Color.Shadow.elevation3)|}];

/* ==========================================
   Border shorthand patterns from monorepo
   ========================================== */

[%css {|border: 1px solid $(Color.Border.line)|}];
[%css {|border: 0px none transparent|}];
[%css {|border-top: 1px solid $(Color.Border.line)|}];
[%css {|border-bottom: 1px solid $(Color.Border.line)|}];
[%css {|border-left: 1px solid $(Color.Border.line)|}];
[%css {|border-right: 1px solid $(Color.Border.line)|}];
[%css {|border: 1px dashed $(Color.Border.line)|}];
[%css {|border: 1px none $(Color.Border.line)|}];

/* ==========================================
   Outline shorthand patterns from monorepo
   ========================================== */

[%css {|outline: 1px solid $(Color.Border.line)|}];
[%css {|outline: 2px solid $(Color.Border.accent)|}];

/* ==========================================
   Animation shorthand patterns from monorepo
   ========================================== */

[%css {|animation: helpMenuFadeIn 0.18s ease-in-out forwards|}];
[%css {|animation: helpMenuFadeOut 0.08s ease-out forwards|}];

/* ==========================================
   Transition shorthand with cubic-bezier
   ========================================== */

[%css {|transition: height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94)|}];
[%css {|transition: height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1)|}];

/* ==========================================
   !important patterns from monorepo
   ========================================== */

/* box-shadow with !important */
[%css {|box-shadow: inset 1px 0 0 0 transparent !important|}];
[%css {|box-shadow: 1px 0 0 0 black !important|}];
[%css {|box-shadow: 1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line) !important|}];

/* transition with !important */
[%css {|transition: transform 0.3s !important|}];

/* ==========================================
   CSS.Shadow.t type compatibility
   ========================================== */

/* Verify Shadow module types are accessible */
let _shadow1: CSS.Shadow.box = CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
let _shadow2: array(CSS.Shadow.box) = [|
  CSS.Shadow.box(~x=`zero, ~y=`zero, ~blur=`px(4), `rgba((0, 0, 0, `num(0.1)))),
  CSS.Shadow.box(~x=`zero, ~y=`px(6), ~blur=`px(15), `rgba((0, 0, 0, `num(0.2)))),
|];
