open Types
open Support

module Property_offset =
  [%spec_module
  "[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || \
   <'offset-rotate'> ]? ]? ]? [ '/' <'offset-anchor'> ]?",
  (module Css_types.Offset)]

let property_offset : property_offset Rule.rule = Property_offset.rule

module Property_offset_anchor =
  [%spec_module
  "'auto' | <position>", (module Css_types.OffsetAnchor)]

let property_offset_anchor : property_offset_anchor Rule.rule =
  Property_offset_anchor.rule

module Property_offset_distance =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_offset_distance : property_offset_distance Rule.rule =
  Property_offset_distance.rule

module Property_offset_path =
  [%spec_module
  "'none' | ray( <extended-angle> && [ <ray-size> ]? && [ 'contain' ]? ) | \
   <path()> | <url> | <basic-shape> || <geometry-box>",
  (module Css_types.OffsetPath)]

let property_offset_path : property_offset_path Rule.rule =
  Property_offset_path.rule

module Property_offset_position =
  [%spec_module
  "'auto' | <position>", (module Css_types.OffsetPosition)]

let property_offset_position : property_offset_position Rule.rule =
  Property_offset_position.rule

module Property_offset_rotate =
  [%spec_module
  "[ 'auto' | 'reverse' ] || <extended-angle>", (module Css_types.OffsetRotate)]

let property_offset_rotate : property_offset_rotate Rule.rule =
  Property_offset_rotate.rule

let entries : (kind * packed_rule) list =
  [
    Property "offset", pack_module (module Property_offset);
    Property "offset-anchor", pack_module (module Property_offset_anchor);
    Property "offset-distance", pack_module (module Property_offset_distance);
    Property "offset-path", pack_module (module Property_offset_path);
    Property "offset-position", pack_module (module Property_offset_position);
    Property "offset-rotate", pack_module (module Property_offset_rotate);
  ]
