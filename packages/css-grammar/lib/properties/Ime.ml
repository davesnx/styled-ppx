open Types
open Support

module Property_ime_mode =
  [%spec_module
  "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'",
  (module Css_types.ImeMode)]

let property_ime_mode : property_ime_mode Rule.rule = Property_ime_mode.rule

module Property__ms_ime_align =
  [%spec_module
  "'auto' | 'after'", (module Css_types.Cascading)]

let property__ms_ime_align = Property__ms_ime_align.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-ime-align", pack_module (module Property__ms_ime_align);
    Property "ime-mode", pack_module (module Property_ime_mode);
  ]
