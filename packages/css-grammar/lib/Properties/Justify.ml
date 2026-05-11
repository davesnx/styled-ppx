open Types
open Support

module Property_justify_content =
  [%spec_module
  "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
   <content-position> | 'left' | 'right' ]",
  (module Css_types.JustifyContent)]

let property_justify_content : property_justify_content Rule.rule =
  Property_justify_content.rule

module Property_justify_items =
  [%spec_module
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
   <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
   'right' | 'center' ]",
  (module Css_types.JustifyItems)]

let property_justify_items : property_justify_items Rule.rule =
  Property_justify_items.rule

module Property_justify_self =
  [%spec_module
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> \
   ]? [ <self-position> | 'left' | 'right' ]",
  (module Css_types.JustifySelf)]

let property_justify_self : property_justify_self Rule.rule =
  Property_justify_self.rule

module Property_justify_tracks =
  [%spec_module
  "[ 'normal' | <content-distribution> | [ <overflow-position> ]? [ \
   <content-position> | 'left' | 'right' ] ]#",
  (module Css_types.Cascading)]

let property_justify_tracks = Property_justify_tracks.rule

let entries : (kind * packed_rule) list =
  [
    Property "justify-content", pack_module (module Property_justify_content);
    Property "justify-items", pack_module (module Property_justify_items);
    Property "justify-tracks", pack_module (module Property_justify_tracks);
    Property "justify-self", pack_module (module Property_justify_self);
  ]
