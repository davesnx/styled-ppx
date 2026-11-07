open Types
open Support

module Property_math_depth =
  [%spec_module
  "'auto-add' | 'add(' <integer> ')' | <integer>", (module Css_types.MathDepth)]

let property_math_depth : property_math_depth Rule.rule =
  Property_math_depth.rule

module Property_math_shift =
  [%spec_module
  "'normal' | 'compact'", (module Css_types.MathShift)]

let property_math_shift : property_math_shift Rule.rule =
  Property_math_shift.rule

module Property_math_style =
  [%spec_module
  "'normal' | 'compact'", (module Css_types.MathStyle)]

let property_math_style : property_math_style Rule.rule =
  Property_math_style.rule

let entries : (kind * packed_rule) list =
  [
    Property "math-depth", pack_module (module Property_math_depth);
    Property "math-shift", pack_module (module Property_math_shift);
    Property "math-style", pack_module (module Property_math_style);
  ]
