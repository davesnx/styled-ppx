open Types
open Support

module Property_place_content =
  [%spec_module
  "<'align-content'> [ <'justify-content'> ]?", (module Css_types.PlaceContent)]

let property_place_content : property_place_content Rule.rule =
  Property_place_content.rule

module Property_place_items =
  [%spec_module
  "<'align-items'> [ <'justify-items'> ]?", (module Css_types.PlaceItems)]

let property_place_items : property_place_items Rule.rule =
  Property_place_items.rule

module Property_place_self =
  [%spec_module
  "<'align-self'> [ <'justify-self'> ]?", (module Css_types.PlaceSelf)]

let property_place_self : property_place_self Rule.rule =
  Property_place_self.rule

let entries : (kind * packed_rule) list =
  [
    Property "place-content", pack_module (module Property_place_content);
    Property "place-items", pack_module (module Property_place_items);
    Property "place-self", pack_module (module Property_place_self);
  ]
