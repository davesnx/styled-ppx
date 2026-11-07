open Types
open Support

module Property_list_style =
  [%spec_module
  "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>",
  (module Css_types.ListStyle)]

let property_list_style : property_list_style Rule.rule =
  Property_list_style.rule

module Property_list_style_image =
  [%spec_module
  "'none' | <image>", (module Css_types.ListStyleImage)]

let property_list_style_image : property_list_style_image Rule.rule =
  Property_list_style_image.rule

module Property_list_style_position =
  [%spec_module
  "'inside' | 'outside'", (module Css_types.ListStylePosition)]

let property_list_style_position : property_list_style_position Rule.rule =
  Property_list_style_position.rule

module Property_list_style_type =
  [%spec_module
  "<counter-style> | <string> | 'none'", (module Css_types.ListStyleType)]

let property_list_style_type : property_list_style_type Rule.rule =
  Property_list_style_type.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "list-style-position",
      pack_module (module Property_list_style_position) );
    Property "list-style-type", pack_module (module Property_list_style_type);
    Property "list-style", pack_module (module Property_list_style);
    Property "list-style-image", pack_module (module Property_list_style_image);
  ]
