open Types
open Support

module Property_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.Height)]

let property_height : property_height Rule.rule = Property_height.rule

let entries : (kind * packed_rule) list =
  [
    Property "height", pack_module (module Property_height);
  ]
