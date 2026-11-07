open Types
open Support

module Property_user_select =
  [%spec_module
  "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>",
  (module Css_types.UserSelect)]

let property_user_select : property_user_select Rule.rule =
  Property_user_select.rule

module Property__ms_user_select =
  [%spec_module
  "'auto' | 'text' | 'none' | 'element' | <interpolation>",
  (module Css_types.UserSelect)]

let property__ms_user_select = Property__ms_user_select.rule

module Property__ms_touch_select =
  [%spec_module
  "'grippers' | 'none'", (module Css_types.Cascading)]

let property__ms_touch_select = Property__ms_touch_select.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-touch-select", pack_module (module Property__ms_touch_select);
    Property "-ms-user-select", pack_module (module Property__ms_user_select);
    Property "user-select", pack_module (module Property_user_select);
  ]
