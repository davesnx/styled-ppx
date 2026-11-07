open Types
open Support

module Property_caret =
  [%spec_module
  "'auto' | [ <color> || [ 'auto' | 'manual' ] || [ 'auto' | 'bar' | 'block' | \
   'underscore' ] ]",
  (module Css_types.Cascading)]

let property_caret = Property_caret.rule

module Property_caret_animation =
  [%spec_module
  "'auto' | 'manual'", (module Css_types.Cascading)]

let property_caret_animation = Property_caret_animation.rule

module Property_caret_color =
  [%spec_module
  "'auto' | <color>", (module Css_types.CaretColor)]

let property_caret_color : property_caret_color Rule.rule =
  Property_caret_color.rule

module Property_caret_shape =
  [%spec_module
  "'auto' | 'bar' | 'block' | 'underscore'", (module Css_types.Cascading)]

let property_caret_shape = Property_caret_shape.rule

let entries : (kind * packed_rule) list =
  [
    Property "caret", pack_module (module Property_caret);
    Property "caret-animation", pack_module (module Property_caret_animation);
    Property "caret-color", pack_module (module Property_caret_color);
    Property "caret-shape", pack_module (module Property_caret_shape);
  ]
