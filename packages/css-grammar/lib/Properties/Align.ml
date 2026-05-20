open Types
open Support

module Property_align_content =
  [%spec_module
  "'normal' | <baseline-position> | <content-distribution> | [ \
   <overflow-position> ]? <content-position>",
  (module Css_types.AlignContent)]

let property_align_content : property_align_content Rule.rule =
  Property_align_content.rule

module Property_align_items =
  [%spec_module
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
   <self-position> | <interpolation>",
  (module Css_types.AlignItems)]

let property_align_items : property_align_items Rule.rule =
  Property_align_items.rule

module Property_align_self =
  [%spec_module
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? <self-position> | <interpolation>",
  (module Css_types.AlignSelf)]

let property_align_self : property_align_self Rule.rule =
  Property_align_self.rule

module Property_align_tracks =
  [%spec_module
  "[ 'normal' | <baseline-position> | <content-distribution> | [ \
   <overflow-position> ]? <content-position> ]#",
  (module Css_types.Cascading)]

let property_align_tracks = Property_align_tracks.rule

let entries : (kind * packed_rule) list =
  [
    Property "align-tracks", pack_module (module Property_align_tracks);
    Property "align-items", pack_module (module Property_align_items);
    Property "align-content", pack_module (module Property_align_content);
    Property "align-self", pack_module (module Property_align_self);
  ]
